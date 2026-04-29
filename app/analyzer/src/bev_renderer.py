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
# XodrParser: parses OpenDRIVE XML and returns road centre-line samples
# ---------------------------------------------------------------------------

@dataclass
class RoadGeometry:
    road_id: str
    points: List[Tuple[float, float]]  # sampled (x, y) along reference line
    lane_width: float = 3.5            # rough average for outline drawing


class XodrParser:
    """
    Parses an OpenDRIVE .xodr file and samples road reference lines.
    Only geometry needed for visualisation is extracted.
    """

    SAMPLE_STEP = 2.0   # metres between sample points

    def __init__(self, xodr_path: str):
        self.xodr_path = xodr_path
        self._roads: List[RoadGeometry] = []
        self._parse()

    def _parse(self):
        tree = etree.parse(self.xodr_path)
        root = tree.getroot()
        for road_elem in root.findall(".//road"):
            road_id = road_elem.get("id", "?")
            pts = self._sample_road(road_elem)
            if len(pts) >= 2:
                # Get a representative lane width
                lw = self._get_lane_width(road_elem)
                self._roads.append(RoadGeometry(road_id=road_id, points=pts,
                                                lane_width=lw))

    def _sample_road(self, road_elem) -> List[Tuple[float, float]]:
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
            if not child:
                pts = _sample_line(x0, y0, hdg, length, self.SAMPLE_STEP)
            else:
                tag = child[0].tag
                if tag == "line":
                    pts = _sample_line(x0, y0, hdg, length, self.SAMPLE_STEP)
                elif tag == "arc":
                    k = float(child[0].get("curvature", 0))
                    pts = _sample_arc(x0, y0, hdg, length, k, self.SAMPLE_STEP)
                elif tag == "spiral":
                    k0 = float(child[0].get("curvStart", 0))
                    k1 = float(child[0].get("curvEnd", 0))
                    pts = _sample_spiral(x0, y0, hdg, length, k0, k1,
                                         self.SAMPLE_STEP)
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
                                              au, bu, cu, du,
                                              av, bv, cv, dv,
                                              p_range, self.SAMPLE_STEP)
                else:
                    pts = _sample_line(x0, y0, hdg, length, self.SAMPLE_STEP)
            # Skip first point of each segment except the first (avoids duplicate)
            if all_pts:
                pts = pts[1:]
            all_pts.extend(pts)
        return all_pts

    def _get_lane_width(self, road_elem) -> float:
        for w_elem in road_elem.findall(".//lane/width"):
            try:
                return float(w_elem.get("a", 3.5))
            except ValueError:
                pass
        return 3.5

    @property
    def roads(self) -> List[RoadGeometry]:
        return self._roads

    def get_bounds(self) -> Tuple[float, float, float, float]:
        """Returns (xmin, xmax, ymin, ymax) of the full road network."""
        xs = [p[0] for r in self._roads for p in r.points]
        ys = [p[1] for r in self._roads for p in r.points]
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
        Selects up to n frame indices that cover important events:
        start, close approach, max deceleration, collision, end.
        Always includes start (0) and end (-1).
        """
        n_frames = len(time_steps)
        candidates: List[Tuple[int, str]] = [
            (0, f"t={time_steps[0]:.1f}s (start)"),
        ]

        # Find closest-approach frame (min Euclidean distance between Ego and first other agent)
        agents = list(trajectory.keys())
        if len(agents) >= 2:
            ego_frames = trajectory[agents[0]]
            other_frames = trajectory[agents[1]]
            min_len = min(len(ego_frames), len(other_frames))
            dists = [
                math.hypot(ego_frames[i]["x"] - other_frames[i]["x"],
                           ego_frames[i]["y"] - other_frames[i]["y"])
                for i in range(min_len)
            ]
            if dists:
                close_idx = int(np.argmin(dists))
                candidates.append(
                    (close_idx, f"t={time_steps[close_idx]:.1f}s (closest approach, d={dists[close_idx]:.1f}m)")
                )

        # Find max deceleration frame for Ego
        ego_frames = trajectory[agents[0]]
        if len(ego_frames) >= 3:
            speeds = [f.get("speed", 0.0) for f in ego_frames]
            dt = (time_steps[-1] - time_steps[0]) / max(len(time_steps) - 1, 1)
            accels = [(speeds[i + 1] - speeds[i - 1]) / (2 * dt)
                      for i in range(1, len(speeds) - 1)]
            if accels:
                min_a_idx = int(np.argmin(accels)) + 1
                if accels[min_a_idx - 1] < DECEL_THRESHOLD_MS2:
                    candidates.append(
                        (min_a_idx,
                         f"t={time_steps[min_a_idx]:.1f}s (max decel {accels[min_a_idx-1]:.1f} m/s²)")
                    )

        # Collision frame
        if collision_t is not None:
            col_idx = min(range(len(time_steps)),
                          key=lambda i: abs(time_steps[i] - collision_t))
            candidates.append((col_idx, f"t={time_steps[col_idx]:.1f}s (collision)"))

        candidates.append((n_frames - 1, f"t={time_steps[-1]:.1f}s (end)"))

        # Deduplicate and sort
        seen: set = set()
        unique: List[Tuple[int, str]] = []
        for idx, lbl in sorted(candidates, key=lambda x: x[0]):
            if idx not in seen:
                seen.add(idx)
                unique.append((idx, lbl))

        # If we still need more, add evenly spaced
        if len(unique) < n:
            step = n_frames // (n - len(unique) + 1)
            for i in range(step, n_frames - step, step):
                if i not in seen:
                    seen.add(i)
                    unique.append((i, f"t={time_steps[i]:.1f}s"))

        unique.sort(key=lambda x: x[0])
        return unique[:n]

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

        # 2. Draw road network (only roads whose points fall in the view)
        for road in self._parser.roads:
            xs = [p[0] for p in road.points]
            ys = [p[1] for p in road.points]
            # Quick visibility check
            if max(xs) < xmin or min(xs) > xmax or max(ys) < ymin or min(ys) > ymax:
                continue
            ax.plot(xs, ys, color="#AAAAAA", linewidth=1.0, zorder=1)

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
