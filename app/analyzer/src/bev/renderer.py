"""
bev/renderer.py  —  XODR map parser utilities + BevSnapshot dataclass.

Provides:
  - XodrParser: parses hct_6.xodr → reference lines + lane boundaries (used by
    Tier2BevRenderer for road-ID assignment in sim_labeller).
  - BevSnapshot: dataclass for a rendered snapshot (path, label, timestep).
  - LaneLine: sampled polyline for one road or lane boundary.

BEV image generation is done exclusively by Tier2BevRenderer (bev/tier2_renderer.py).

CLI usage (standalone BEV generation):
    python3 -m bev.renderer --cluster <clustering.json> --dataset dataset1

    # Or via the convenience script:
    bash scripts/run_bev_tier2.sh dataset1 3
"""

from __future__ import annotations

import argparse
import json
import math
import os
from dataclasses import dataclass, field
from pathlib import Path
from typing import Dict, List, Optional, Tuple

import matplotlib.patches as mpatches
import matplotlib.pyplot as plt
import matplotlib.transforms as transforms
import numpy as np
from lxml import etree
from scipy.integrate import quad


# ---------------------------------------------------------------------------
# OpenDRIVE Geometry helpers
# ---------------------------------------------------------------------------

def _sample_line(x0, y0, hdg, length, step):
    """Sample a straight geometry segment."""
    n = max(2, int(length / step) + 1)
    pts = [(x0 + t * math.cos(hdg), y0 + t * math.sin(hdg))
           for t in np.linspace(0, length, n)]
    return pts


def _sample_arc(x0, y0, hdg, length, curvature, step):
    """Sample a constant-curvature arc."""
    if abs(curvature) < 1e-9:
        return _sample_line(x0, y0, hdg, length, step)
    radius = 1.0 / curvature
    n = max(2, int(length / step) + 1)
    pts = []
    for s in np.linspace(0, length, n):
        angle = hdg + s * curvature
        cx = x0 + radius * math.sin(hdg) * (-1) + radius * math.sin(angle) * (1) if curvature > 0 else \
             x0 - radius * math.sin(hdg) * (-1) + radius * math.sin(angle) * (-1)
        # Simpler direct formula:
        dTheta = s * curvature
        cx = x0 + (math.sin(hdg + dTheta) - math.sin(hdg)) / curvature
        cy = y0 + (-math.cos(hdg + dTheta) + math.cos(hdg)) / curvature
        pts.append((cx, cy))
    return pts


def _sample_spiral(x0, y0, hdg, length, k0, k1, step):
    """
    Sample a Euler spiral (clothoid) where curvature varies linearly
    from k0 at s=0 to k1 at s=length.
    Uses numerical integration of dx/ds = cos(θ), dy/ds = sin(θ)
    where θ(s) = hdg + k0*s + (k1-k0)/(2*length)*s²
    """
    n = max(2, int(length / step) + 1)
    s_vals = np.linspace(0, length, n)
    dk = (k1 - k0) / length if length > 0 else 0.0

    def theta(s):
        return hdg + k0 * s + 0.5 * dk * s ** 2

    # Cumulative integration
    pts = [(x0, y0)]
    for i in range(1, len(s_vals)):
        ds = s_vals[i] - s_vals[i - 1]
        t_mid = theta((s_vals[i - 1] + s_vals[i]) / 2.0)
        px = pts[-1][0] + ds * math.cos(t_mid)
        py = pts[-1][1] + ds * math.sin(t_mid)
        pts.append((px, py))
    return pts


def _sample_param_poly3(x0, y0, hdg, length, au, bu, cu, du, av, bv, cv, dv,
                        p_range, step):
    """
    Sample a parametric cubic polynomial geometry.
    u(p) = au + bu*p + cu*p² + du*p³
    v(p) = av + bv*p + cv*p² + dv*p³
    Coordinates are in local frame, then rotated by hdg and translated.
    p_range: "normalized" (p in [0,1]) or "arcLength" (p in [0,length])
    """
    n = max(2, int(length / step) + 1)
    p_max = 1.0 if p_range == "normalized" else length
    ps = np.linspace(0, p_max, n)
    cos_h, sin_h = math.cos(hdg), math.sin(hdg)
    pts = []
    for p in ps:
        u = au + bu * p + cu * p ** 2 + du * p ** 3
        v = av + bv * p + cv * p ** 2 + dv * p ** 3
        wx = x0 + u * cos_h - v * sin_h
        wy = y0 + u * sin_h + v * cos_h
        pts.append((wx, wy))
    return pts


# ---------------------------------------------------------------------------
# XodrParser: parses OpenDRIVE XML and returns road centre-line + lane boundaries
# ---------------------------------------------------------------------------

@dataclass
class LaneLine:
    """One sampled polyline: either a road ref-line or an actual lane boundary."""
    road_id: str
    lane_id: int          # 0 = reference line, ±N = driving/shoulder lanes
    lane_type: str        # "ref", "driving", "shoulder", "border", etc.
    points: List[Tuple[float, float]]


class XodrParser:
    """
    Parses an OpenDRIVE .xodr file and produces:
      - reference lines (centerline of each road)
      - lane boundaries (computed by perpendicular offset from the ref-line)

    This gives a richer map matching what odrplot/MapPlotter produce.
    """

    SAMPLE_STEP = 2.0   # metres between sample points

    def __init__(self, xodr_path: str):
        self.xodr_path = xodr_path
        self._lines: List[LaneLine] = []   # all lines (ref + lane boundaries)
        self._parse()

    def _parse(self):
        tree = etree.parse(self.xodr_path)
        root = tree.getroot()
        for road_elem in root.findall(".//road"):
            road_id = road_elem.get("id", "?")
            ref_pts = self._sample_ref_line(road_elem)
            if len(ref_pts) < 2:
                continue
            # Reference line (drawn as red/centerline)
            self._lines.append(LaneLine(road_id=road_id, lane_id=0,
                                        lane_type="ref", points=ref_pts))
            # Lane boundaries
            self._lines.extend(self._compute_lane_boundaries(road_elem, ref_pts))

    # ------------------------------------------------------------------
    # Reference line sampling (same as before)
    # ------------------------------------------------------------------

    def _sample_ref_line(self, road_elem) -> List[Tuple[float, float]]:
        all_pts: List[Tuple[float, float]] = []
        plan_view = road_elem.find("planView")
        if plan_view is None:
            return all_pts
        for geom in plan_view.findall("geometry"):
            x0 = float(geom.get("x", 0))
            y0 = float(geom.get("y", 0))
            hdg = float(geom.get("hdg", 0))
            length = float(geom.get("length", 0))
            if length < 0.01:
                continue
            child = list(geom)
            tag = child[0].tag if child else "line"
            if tag == "line":
                pts = _sample_line(x0, y0, hdg, length, self.SAMPLE_STEP)
            elif tag == "arc":
                k = float(child[0].get("curvature", 0))
                pts = _sample_arc(x0, y0, hdg, length, k, self.SAMPLE_STEP)
            elif tag == "spiral":
                k0 = float(child[0].get("curvStart", 0))
                k1 = float(child[0].get("curvEnd", 0))
                pts = _sample_spiral(x0, y0, hdg, length, k0, k1, self.SAMPLE_STEP)
            elif tag == "paramPoly3":
                au = float(child[0].get("aU", 0))
                bu = float(child[0].get("bU", 0))
                cu = float(child[0].get("cU", 0))
                du = float(child[0].get("dU", 0))
                av = float(child[0].get("aV", 0))
                bv = float(child[0].get("bV", 0))
                cv = float(child[0].get("cV", 0))
                dv = float(child[0].get("dV", 0))
                p_range = child[0].get("pRange", "normalized")
                pts = _sample_param_poly3(x0, y0, hdg, length,
                                          au, bu, cu, du, av, bv, cv, dv,
                                          p_range, self.SAMPLE_STEP)
            else:
                pts = _sample_line(x0, y0, hdg, length, self.SAMPLE_STEP)
            if all_pts:
                pts = pts[1:]
            all_pts.extend(pts)
        return all_pts

    # ------------------------------------------------------------------
    # Lane boundary computation by perpendicular offset from ref line
    # ------------------------------------------------------------------

    def _compute_lane_boundaries(
        self, road_elem, ref_pts: List[Tuple[float, float]]
    ) -> List[LaneLine]:
        """
        For each laneSection, offset from the reference line outward (left = positive,
        right = negative side) by cumulative lane widths to get lane boundaries.

        Uses a simple "width(s) = a + b*s + c*s² + d*s³" polynomial for each lane.
        The offset vector at each sampled point is perpendicular to the local heading.
        """
        lines: List[LaneLine] = []
        road_id = road_elem.get("id", "?")

        # Build a cumulative arc-length array for ref_pts
        n = len(ref_pts)
        s_arr = np.zeros(n)
        for i in range(1, n):
            dx = ref_pts[i][0] - ref_pts[i - 1][0]
            dy = ref_pts[i][1] - ref_pts[i - 1][1]
            s_arr[i] = s_arr[i - 1] + math.hypot(dx, dy)
        total_s = s_arr[-1]
        if total_s < 0.01:
            return lines

        # Compute heading at each sampled point (finite differences)
        headings = np.zeros(n)
        for i in range(n):
            if i == 0:
                dx = ref_pts[1][0] - ref_pts[0][0]
                dy = ref_pts[1][1] - ref_pts[0][1]
            elif i == n - 1:
                dx = ref_pts[-1][0] - ref_pts[-2][0]
                dy = ref_pts[-1][1] - ref_pts[-2][1]
            else:
                dx = ref_pts[i + 1][0] - ref_pts[i - 1][0]
                dy = ref_pts[i + 1][1] - ref_pts[i - 1][1]
            headings[i] = math.atan2(dy, dx)

        ref_x = np.array([p[0] for p in ref_pts])
        ref_y = np.array([p[1] for p in ref_pts])

        def eval_width_poly(w_elem, s: np.ndarray) -> np.ndarray:
            """Evaluate the cubic width polynomial at arc-length positions s."""
            if w_elem is None:
                return np.zeros_like(s)
            s0 = float(w_elem.get("sOffset", 0))
            a = float(w_elem.get("a", 0))
            b = float(w_elem.get("b", 0))
            c = float(w_elem.get("c", 0))
            d = float(w_elem.get("d", 0))
            ds = s - s0
            ds = np.clip(ds, 0, None)
            return a + b * ds + c * ds ** 2 + d * ds ** 3

        def offset_pts(offset_arr: np.ndarray) -> List[Tuple[float, float]]:
            """Shift ref_pts perpendicularly by offset_arr (left=+, right=-)."""
            # Left is perpendicular in the direction heading + π/2
            ox = ref_x - offset_arr * np.sin(headings)
            oy = ref_y + offset_arr * np.cos(headings)
            return list(zip(ox.tolist(), oy.tolist()))

        for ls_elem in road_elem.findall(".//lanes/laneSection"):
            ls_s = float(ls_elem.get("s", 0))
            # Mask points that belong to this lane section
            # (simple: use all points for single-section roads, or filter by s)
            mask = s_arr >= ls_s
            if not np.any(mask):
                continue
            s_local = s_arr[mask]

            for side_tag, sign in [("left", 1.0), ("right", -1.0)]:
                side_elem = ls_elem.find(side_tag)
                if side_elem is None:
                    continue
                cumulative = np.zeros(len(s_local))
                for lane_elem in sorted(
                    side_elem.findall("lane"),
                    key=lambda e: abs(int(e.get("id", 0)))
                ):
                    lane_id = int(lane_elem.get("id", 0))
                    lane_type = lane_elem.get("type", "none")
                    w_elem = lane_elem.find("width")
                    width = eval_width_poly(w_elem, s_local)
                    cumulative = cumulative + width

                    if lane_type in ("driving", "shoulder", "border", "parking"):
                        # Draw the outer boundary of this lane
                        boundary_offset = sign * cumulative
                        # Map local mask indices back to full ref arrays
                        full_offset = np.zeros(n)
                        full_offset[mask] = boundary_offset
                        pts = offset_pts(full_offset)
                        if len(pts) >= 2:
                            lines.append(LaneLine(
                                road_id=road_id,
                                lane_id=lane_id,
                                lane_type=lane_type,
                                points=pts,
                            ))
        return lines

    # ------------------------------------------------------------------
    # Public interface
    # ------------------------------------------------------------------

    @property
    def lines(self) -> List[LaneLine]:
        """All sampled lines (ref + lane boundaries)."""
        return self._lines

    # Keep backward-compatible .roads property: return ref lines only
    @property
    def roads(self):
        return [l for l in self._lines if l.lane_type == "ref"]

    def get_bounds(self) -> Tuple[float, float, float, float]:
        xs = [p[0] for l in self._lines for p in l.points]
        ys = [p[1] for l in self._lines for p in l.points]
        return min(xs), max(xs), min(ys), max(ys)


@dataclass
class BevSnapshot:
    """Represents a single rendered BEV frame (used by Tier2BevRenderer)."""
    timestep: float
    label: str          # e.g. "t=0.0s (start)", "t=3.2s (close approach)"
    path: str           # saved .jpg path



# ---------------------------------------------------------------------------
# CLI entry point — wraps Tier2BevRenderer for standalone BEV generation.
# Use via:  python3 -m bev.renderer --cluster <file> --dataset dataset1
# Or:       bash scripts/run_bev_tier2.sh dataset1 3
# ---------------------------------------------------------------------------

def main():
    parser = argparse.ArgumentParser(
        description="BEV generator — Tier2 (xosc_gen MapPlotter + esmini CSV)"
    )
    parser.add_argument("--xodr", default=None, help="Override XODR path")
    parser.add_argument("--map-tracks", default=None, help="Override odrplot *_tracks.csv")
    parser.add_argument("--cluster", default=None,
                        help="Path to selectedClusteringResult_NCluster.json")
    parser.add_argument("--traj", default=None, help="Path to trajectories.json (for medoid lookup)")
    parser.add_argument("--trial", default=None, help="Optional single Payload trial id")
    parser.add_argument("--batch", type=int, default=None, help="Override esmini batch id")
    parser.add_argument("--n-snapshots", type=int, default=12,
                        help="Number of critical frames per trial (default 12)")
    parser.add_argument("--dataset", default="dataset1",
                        help="Dataset name (determines default xodr + tracks + output path)")
    parser.add_argument("--n-clusters", type=int, default=None,
                        help="Cluster count (inferred from --cluster filename if omitted)")
    parser.add_argument("--out", default=None,
                        help="Override output root (default: llm_artifacts/bev_<dataset>_<N>cl)")
    args = parser.parse_args()

    from data.dataset_config import get_dataset_config, trial_id_to_csv_indices
    from bev.tier2_renderer import (
        Tier2BevRenderer,
        load_medoids_from_clustering,
        resolve_tier2_paths,
        tier2_output_dir,
    )
    from repo_paths import REPO_ROOT

    xodr_p, tracks_p, location = resolve_tier2_paths(args.dataset)
    if args.xodr:
        xodr_p = Path(args.xodr)
    if args.map_tracks:
        tracks_p = Path(args.map_tracks)
    if not tracks_p.is_file():
        print(
            f"ERROR: map tracks missing: {tracks_p}\n"
            f"Run: python3 scripts/generate_map_tracks.py --dataset {args.dataset}"
        )
        return

    n_cl = args.n_clusters
    if n_cl is None and args.cluster:
        m = __import__("re").search(r"(\d+)\s*Clusters?", args.cluster, __import__("re").I)
        n_cl = int(m.group(1)) if m else 3

    if args.out:
        bev_root = Path(args.out)
    else:
        bev_root = REPO_ROOT / "llm_artifacts" / f"bev_{args.dataset}_{n_cl}cl"

    ds_cfg = get_dataset_config(args.dataset)
    batch_id = int(ds_cfg["batch_id"]) if args.batch is None else args.batch

    renderer = Tier2BevRenderer(
        map_tracks_csv=str(tracks_p),
        xodr_path=str(xodr_p),
        location=location,
        dataset_name=args.dataset,
    )

    if args.trial:
        batch_id, tidx = trial_id_to_csv_indices(args.dataset, args.trial)
        trial_out = bev_root / f"trial_{args.trial}"
        trial_out.mkdir(parents=True, exist_ok=True)
        snaps = renderer.render_trial_from_esmini_csv(
            batch_id, tidx, str(trial_out),
            n_snapshots=args.n_snapshots,
            file_prefix=f"trial_{args.trial}",
        )
    elif args.cluster:
        medoids = load_medoids_from_clustering(
            args.cluster, args.dataset,
            trajectories_path=args.traj or str(
                REPO_ROOT / f"alldatasets/{args.dataset}/trajectories.json"
            ),
        )
        print(f"[CLI] Medoids: {medoids}")
        results = renderer.render_cluster_medoids(
            medoids,
            str(bev_root),
            n_snapshots=args.n_snapshots,
            dataset=args.dataset,
            n_clusters=n_cl,
        )
        snaps = [s for lst in results.values() for s in lst]
    else:
        print("ERROR: provide --cluster <file> (or --trial <id>)")
        return

    print(f"\n✓ Rendered {len(snaps)} BEV snapshots under {bev_root}")
    for s in snaps:
        print(f"  {s.label:50s}  →  {s.path}")


if __name__ == "__main__":
    main()
