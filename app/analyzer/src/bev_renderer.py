"""
bev_renderer.py  —  Phase 3: Bird's Eye View Renderer for Simulated Trajectories

Parses hct_6.xodr (OpenDRIVE) to draw a top-down road map, then overlays
agent bounding boxes and velocity arrows from gpl-odd trajectory data.

Geometry supported: line, arc, spiral (Euler/Clothoid), paramPoly3.

Usage (standalone):
    python3 bev_renderer.py \
        --xodr  alldatasets/resources/xodr/hct_6.xodr \
        --traj  alldatasets/dataset1/trajectories.json \
        --cluster alldatasets/dataset1/selectedClusteringResult_3Clusters.json \
        --out   /tmp/bev_output

Usage (from controller.py):
    from bev_renderer import BevRenderer
    renderer = BevRenderer("alldatasets/resources/xodr/hct_6.xodr")
    snapshots = renderer.render_trial(
        trial_id="5951",
        trajectory=traj_dict,          # {agent: [{x,y,yaw,width,length,...},...]}
        time_steps=time_list,
        output_dir="/tmp/bev/trial_5951",
    )
    # snapshots is a list of {"timestep": t, "path": "/tmp/bev/trial_5951/frame_002.jpg"}
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


# ---------------------------------------------------------------------------
# BevRenderer: draws road map + agent overlay
# ---------------------------------------------------------------------------

# Key timestep detection
DECEL_THRESHOLD_MS2 = -0.5   # m/s²  — Ego decelerating
MIN_DIST_WINDOW = 5           # frames either side for local min search


@dataclass
class BevSnapshot:
    timestep: float
    label: str          # e.g. "t=0.0s (start)", "t=3.2s (close approach)"
    path: str           # saved .jpg path


class BevRenderer:
    """
    Renders Bird's Eye View snapshots of a single trial on the HCT map.

    Args:
        xodr_path: Path to hct_6.xodr
        map_bounds: Optional (xmin, xmax, ymin, ymax) to restrict the view.
                    If None, the view is auto-fitted around the trajectory.
        dpi: Image DPI (default 120)
    """

    # Vehicle size defaults when width/length==0 in the trajectory data
    DEFAULT_LENGTH = 4.5   # metres
    DEFAULT_WIDTH  = 2.0

    EGO_COLOR    = "darkorange"
    AGENT_COLOR  = "royalblue"
    EGO_ARROW    = "darkgreen"
    AGENT_ARROW  = "cyan"

    def __init__(self, xodr_path: str, map_bounds=None, dpi: int = 120):
        self.dpi = dpi
        self._map_bounds = map_bounds
        print(f"[BevRenderer] Parsing {xodr_path} ...")
        self._parser = XodrParser(xodr_path)
        print(f"[BevRenderer] Loaded {len(self._parser.roads)} road segments.")

    # ------------------------------------------------------------------
    # Public API
    # ------------------------------------------------------------------

    def render_trial(
        self,
        trial_id: str,
        trajectory: Dict[str, List[dict]],
        time_steps: List[float],
        output_dir: str,
        n_snapshots: int = 5,
        collision_timestep: Optional[float] = None,
    ) -> List[BevSnapshot]:
        """
        Render key-timestep BEV snapshots for one trial.

        Args:
            trial_id:   String trial ID (for output file naming).
            trajectory: {agent_name: [frame_dict, ...]} where each frame has
                        keys x, y, yaw, width, length, speed (optional).
            time_steps: List of timestamps matching trajectory frames.
            output_dir: Directory to save .jpg files.
            n_snapshots: Number of snapshots to capture (default 5).
            collision_timestep: If known, always include this timestep.

        Returns:
            List of BevSnapshot (timestep, label, path).
        """
        os.makedirs(output_dir, exist_ok=True)
        key_indices = self._pick_key_indices(trajectory, time_steps,
                                              n_snapshots, collision_timestep)
        snapshots: List[BevSnapshot] = []
        for rank, (idx, label) in enumerate(key_indices):
            t = time_steps[idx]
            frame_data = {agent: frames[idx] if idx < len(frames) else frames[-1]
                          for agent, frames in trajectory.items()}
            path = os.path.join(output_dir, f"trial_{trial_id}_frame_{rank:03d}.jpg")
            self._render_frame(frame_data, t, label, path, trajectory)
            snapshots.append(BevSnapshot(timestep=t, label=label, path=path))
            print(f"[BevRenderer] Saved {path}")
        return snapshots

    def render_cluster_medoids(
        self,
        medoids: Dict[int, str],
        trajectories_json_path: str,
        output_dir: str,
        collision_trial_ids: Optional[set] = None,
    ) -> Dict[int, List[BevSnapshot]]:
        """
        Render BEV snapshots for all cluster medoid trials.

        Args:
            medoids: {cluster_label: trial_id} from get_cluster_medoids()
            trajectories_json_path: Path to trajectories.json
            output_dir: Root output directory; sub-dirs per cluster are created.
            collision_trial_ids: Set of trial_ids that ended in collision.

        Returns:
            {cluster_label: [BevSnapshot, ...]}
        """
        with open(trajectories_json_path) as f:
            all_traj = json.load(f)

        results: Dict[int, List[BevSnapshot]] = {}
        for cluster_label, trial_id in medoids.items():
            if trial_id not in all_traj:
                print(f"[BevRenderer] WARNING: trial {trial_id} not in trajectories.json")
                continue
            entry = all_traj[trial_id]
            collision_t = None
            if collision_trial_ids and trial_id in collision_trial_ids:
                collision_t = entry["time"][-1]
            cluster_out = os.path.join(output_dir, f"cluster_{cluster_label}")
            snaps = self.render_trial(
                trial_id=trial_id,
                trajectory=entry["trajectory"],
                time_steps=entry["time"],
                output_dir=cluster_out,
                collision_timestep=collision_t,
            )
            results[cluster_label] = snaps
        return results

    # ------------------------------------------------------------------
    # Private helpers
    # ------------------------------------------------------------------

    def _pick_key_indices(
        self,
        trajectory: Dict[str, List[dict]],
        time_steps: List[float],
        n: int,
        collision_t: Optional[float],
    ) -> List[Tuple[int, str]]:
        """
        Selects up to n frame indices using a curvature-based approach
        (adapted from xosc_gen/scripts/trajectory_feature.py) combined with
        interaction-aware events.

        Priority order:
          1. Start (always)
          2. Curvature peaks of Ego trajectory (decision moments: turns, braking arcs)
          3. Closest approach between Ego and other agents
          4. Collision frame (if known)
          5. End (always)
          6. Evenly spaced fill-ins if still under n
        """
        n_frames = len(time_steps)
        agents = list(trajectory.keys())
        ego_frames = trajectory[agents[0]]

        candidates: List[Tuple[int, str]] = [
            (0, f"t={time_steps[0]:.1f}s (start)"),
        ]

        # ---- 1. Curvature-based key frames (xosc_gen approach) --------
        ego_x = np.array([f["x"] for f in ego_frames], dtype=float)
        ego_y = np.array([f["y"] for f in ego_frames], dtype=float)
        t_arr = np.array(time_steps[:len(ego_x)], dtype=float)

        if len(ego_x) >= 5:
            # Numerical derivatives (central differences)
            dx  = np.gradient(ego_x, t_arr)
            dy  = np.gradient(ego_y, t_arr)
            ddx = np.gradient(dx, t_arr)
            ddy = np.gradient(dy, t_arr)
            denom = (dx**2 + dy**2)**1.5 + 1e-8
            curvature = np.abs(dx * ddy - dy * ddx) / denom

            max_k = curvature.max()
            if max_k > 1e-4:
                # Find all local maxima of curvature above 20% of max
                from scipy.signal import argrelextrema
                local_max_idx = argrelextrema(curvature, np.greater, order=3)[0]
                thresh = max_k * 0.20
                for idx in local_max_idx:
                    if curvature[idx] >= thresh:
                        candidates.append((
                            int(idx),
                            f"t={time_steps[idx]:.1f}s (κ-peak, curvature={curvature[idx]:.3f})"
                        ))

        # ---- 2. Closest approach ----------------------------------------
        if len(agents) >= 2:
            other_frames = trajectory[agents[1]]
            min_len = min(len(ego_frames), len(other_frames))
            dists = [
                math.hypot(ego_frames[i]["x"] - other_frames[i]["x"],
                           ego_frames[i]["y"] - other_frames[i]["y"])
                for i in range(min_len)
            ]
            close_idx = int(np.argmin(dists))
            candidates.append((
                close_idx,
                f"t={time_steps[close_idx]:.1f}s (closest, d={dists[close_idx]:.1f}m)"
            ))

        # ---- 3. Collision -----------------------------------------------
        if collision_t is not None:
            col_idx = min(range(len(time_steps)),
                          key=lambda i: abs(time_steps[i] - collision_t))
            candidates.append((col_idx, f"t={time_steps[col_idx]:.1f}s (collision)"))

        # ---- 4. End -------------------------------------------------------
        end_entry = (n_frames - 1, f"t={time_steps[-1]:.1f}s (end)")

        # ---- Deduplicate middle candidates, sort, limit to n-2 ----------
        # Always reserve slots 0 and -1 for start and end so they can't be
        # pushed out by evenly-spaced fill-ins.
        start_entry = candidates[0]
        middle_candidates = candidates[1:]  # everything that's not "start"

        seen: set = {0, n_frames - 1}
        middle: List[Tuple[int, str]] = []
        for idx, lbl in sorted(middle_candidates, key=lambda x: x[0]):
            if idx not in seen:
                seen.add(idx)
                middle.append((idx, lbl))

        # Fill up with evenly-spaced frames if still under n-2
        slots_left = n - 2 - len(middle)
        if slots_left > 0:
            step = max(1, n_frames // (n + 1))
            for i in range(step, n_frames - step, step):
                if i not in seen:
                    seen.add(i)
                    middle.append((i, f"t={time_steps[i]:.1f}s"))
                    slots_left -= 1
                    if slots_left <= 0:
                        break

        middle.sort(key=lambda x: x[0])
        result = [start_entry] + middle[: n - 2] + [end_entry]
        result.sort(key=lambda x: x[0])
        # Deduplicate again in case start == end (trivially short trial)
        final: List[Tuple[int, str]] = []
        seen2: set = set()
        for entry in result:
            if entry[0] not in seen2:
                seen2.add(entry[0])
                final.append(entry)
        return final[:n]

    def _render_frame(
        self,
        frame_data: Dict[str, dict],   # {agent: single frame dict}
        t: float,
        label: str,
        output_path: str,
        full_trajectory: Dict[str, List[dict]],
    ):
        """Draw road map + trajectory paths + bounding boxes for one timestep."""
        fig, ax = plt.subplots(figsize=(10, 10), dpi=self.dpi)

        # 1. Determine view bounds (trajectory bounding box + 20m padding)
        all_x = [f["x"] for frames in full_trajectory.values() for f in frames]
        all_y = [f["y"] for frames in full_trajectory.values() for f in frames]
        pad = 20.0
        xmin, xmax = min(all_x) - pad, max(all_x) + pad
        ymin, ymax = min(all_y) - pad, max(all_y) + pad

        # If explicit map bounds provided, use those
        if self._map_bounds:
            xmin, xmax, ymin, ymax = self._map_bounds

        # 2. Draw road network (ref lines + lane boundaries)
        for lane_line in self._parser.lines:
            xs = [p[0] for p in lane_line.points]
            ys = [p[1] for p in lane_line.points]
            if max(xs) < xmin or min(xs) > xmax or max(ys) < ymin or min(ys) > ymax:
                continue
            if lane_line.lane_type == "ref":
                ax.plot(xs, ys, color="#CC6666", linewidth=0.8, alpha=0.5, zorder=1)
            elif lane_line.lane_type == "driving":
                ax.plot(xs, ys, color="#888888", linewidth=1.2, zorder=1)
            elif lane_line.lane_type in ("shoulder", "border"):
                ax.plot(xs, ys, color="#BBBBBB", linewidth=0.7, zorder=1)
            else:
                ax.plot(xs, ys, color="#DDDDDD", linewidth=0.5, zorder=1)

        # 3. Draw trajectory paths (faded lines)
        agent_names = list(full_trajectory.keys())
        colors = [self.EGO_COLOR, self.AGENT_COLOR, "#AA55AA", "#55AAAA"]
        for i, (agent, frames) in enumerate(full_trajectory.items()):
            col = colors[i % len(colors)]
            traj_x = [f["x"] for f in frames]
            traj_y = [f["y"] for f in frames]
            ax.plot(traj_x, traj_y, color=col, linewidth=1.0, alpha=0.3,
                    linestyle="--", zorder=2)

        # 4. Draw bounding boxes + velocity arrows at current timestep
        for i, (agent, frame) in enumerate(frame_data.items()):
            is_ego = (i == 0)
            col = self.EGO_COLOR if is_ego else self.AGENT_COLOR
            arr_col = self.EGO_ARROW if is_ego else self.AGENT_ARROW

            cx, cy, yaw = frame["x"], frame["y"], frame["yaw"]
            length = frame.get("length", 0) or self.DEFAULT_LENGTH
            width  = frame.get("width",  0) or self.DEFAULT_WIDTH
            speed  = frame.get("speed",  0) or 0.0
            if length < 0.1:
                length = self.DEFAULT_LENGTH
            if width < 0.1:
                width = self.DEFAULT_WIDTH

            # esmini yaw is in radians (heading angle)
            rect = mpatches.Rectangle(
                (-length / 2, -width / 2), length, width,
                linewidth=1.5, edgecolor=col, facecolor=col, alpha=0.7, zorder=10
            )
            tf = (transforms.Affine2D().rotate(yaw)
                  + transforms.Affine2D().translate(cx, cy)
                  + ax.transData)
            rect.set_transform(tf)
            ax.add_patch(rect)

            # Velocity arrow
            if speed > 0.5:
                arrow_len = speed * 0.5
                ax.annotate(
                    "",
                    xy=(cx + arrow_len * math.cos(yaw), cy + arrow_len * math.sin(yaw)),
                    xytext=(cx, cy),
                    arrowprops=dict(arrowstyle="->", color=arr_col, lw=2),
                    zorder=11,
                )

            # Agent label
            ax.text(cx, cy + width * 0.7, agent, fontsize=7, color="white",
                    ha="center", va="bottom",
                    bbox=dict(boxstyle="round,pad=0.2", fc="black", alpha=0.6),
                    zorder=12)

        # 5. Title, formatting
        ax.set_xlim(xmin, xmax)
        ax.set_ylim(ymin, ymax)
        ax.set_aspect("equal")
        ax.axis("off")
        ax.set_title(label, fontsize=9, pad=4)

        # Legend
        legend_elements = [
            mpatches.Patch(facecolor=self.EGO_COLOR, label="Ego"),
            mpatches.Patch(facecolor=self.AGENT_COLOR, label="Other agents"),
        ]
        ax.legend(handles=legend_elements, loc="upper right", fontsize=8)

        plt.tight_layout()
        plt.savefig(output_path, dpi=self.dpi, bbox_inches="tight")
        plt.close(fig)


# ---------------------------------------------------------------------------
# CLI entry point for standalone testing
# ---------------------------------------------------------------------------

def _load_medoids_from_clustering(clustering_path: str,
                                   trajectories: dict) -> Dict[int, str]:
    """
    Given a selectedClusteringResult_NCluster.json, pick the trial
    closest to each cluster centroid using only x,y trajectory data
    as a simple proxy (no MFPCA scores needed offline).
    """
    with open(clustering_path) as f:
        clustering = json.load(f)

    label_to_trials: Dict[str, List[str]] = {}
    for trial_id, label in clustering["data"].items():
        label_to_trials.setdefault(label, []).append(trial_id)

    medoids: Dict[int, str] = {}
    for label_str, trial_ids in label_to_trials.items():
        label = int(label_str)
        if label == -1:
            continue
        # Compute centroid of each trial's mean (x,y)
        trial_means = []
        for tid in trial_ids:
            if tid not in trajectories:
                continue
            frames = trajectories[tid]["trajectory"].get("Ego", [])
            if not frames:
                continue
            mx = sum(f["x"] for f in frames) / len(frames)
            my = sum(f["y"] for f in frames) / len(frames)
            trial_means.append((tid, mx, my))

        if not trial_means:
            continue

        ctr_x = sum(m[1] for m in trial_means) / len(trial_means)
        ctr_y = sum(m[2] for m in trial_means) / len(trial_means)
        medoid = min(trial_means,
                     key=lambda m: (m[1] - ctr_x) ** 2 + (m[2] - ctr_y) ** 2)
        medoids[label] = medoid[0]

    return medoids


def main():
    parser = argparse.ArgumentParser(description="BEV Renderer — Phase 3")
    parser.add_argument("--xodr", required=True, help="Path to hct_6.xodr")
    parser.add_argument("--traj", required=True, help="Path to trajectories.json")
    parser.add_argument("--cluster", required=True,
                        help="Path to selectedClusteringResult_NCluster.json")
    parser.add_argument("--out", default="/tmp/bev_output",
                        help="Output directory for BEV images")
    parser.add_argument("--trial", default=None,
                        help="Single trial_id to render (overrides medoid selection)")
    args = parser.parse_args()

    with open(args.traj) as f:
        trajectories = json.load(f)

    renderer = BevRenderer(xodr_path=args.xodr)

    if args.trial:
        # Render one specific trial
        trial_id = args.trial
        if trial_id not in trajectories:
            print(f"ERROR: trial {trial_id} not found in {args.traj}")
            return
        entry = trajectories[trial_id]
        snaps = renderer.render_trial(
            trial_id=trial_id,
            trajectory=entry["trajectory"],
            time_steps=entry["time"],
            output_dir=args.out,
        )
    else:
        # Render medoid of each cluster
        medoids = _load_medoids_from_clustering(args.cluster, trajectories)
        print(f"[CLI] Medoids: {medoids}")
        results = renderer.render_cluster_medoids(
            medoids=medoids,
            trajectories_json_path=args.traj,
            output_dir=args.out,
        )
        snaps = [s for snaps in results.values() for s in snaps]

    print(f"\n✓ Rendered {len(snaps)} BEV snapshots to {args.out}")
    for s in snaps:
        print(f"  {s.label:50s}  →  {s.path}")


if __name__ == "__main__":
    main()
