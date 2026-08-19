"""
bev_tier2_renderer.py — Phase 3b: xosc_gen-style BEV using esmini odrplot map + MapPlotter.

Map:   ``hct_6_tracks.csv`` from ``map_assets / dataset_builder --map-only`` (esmini odrplot).
Agents: local ``esmini_<batch>_<trial>.csv`` (authoritative sim ground truth).
"""
from __future__ import annotations

import csv
import json
import math
import os
import tempfile
from pathlib import Path
from typing import Any, Dict, List, Optional, Tuple

import numpy as np
import pandas as pd
import yaml

from renderer import BevSnapshot
from map_plotter import BevTypography, DEFAULT_BEV_TYPOGRAPHY, MapPlotter
from csv_roadid_loader import csv_exists, get_csv_road_data
from dataset_config import (
    csv_indices_to_trial_id,
    get_dataset_config,
    map_tracks_path_for_dataset,
    trial_id_to_csv_indices,
    xodr_path_for_dataset,
)

# Default vehicle dimensions when esmini CSV has no width/length
_AGENT_DEFAULTS = {
    "Ego": ("car", 2.2, 5.17),
    "Oncoming": ("car", 2.0, 4.5),
}

_MIN_VALID_WIDTH = 1.0
_MIN_VALID_LENGTH = 2.0


def infer_agent_role(name: str) -> str:
    """Human-readable role for legend (ID → role)."""
    n = name.strip().lower()
    if n == "ego":
        return "Ego"
    if "park" in n:
        return "Parking"
    if "oncom" in n:
        return "Oncoming car"
    if "static" in n or "obstacle" in n:
        return "Static obstacle"
    if "bicycle" in n or "bike" in n:
        return "Bicycle"
    if "pedestrian" in n or "person" in n:
        return "Pedestrian"
    return name.strip()


def _normalized_name_series(df: pd.DataFrame) -> pd.Series:
    """Strip agent names once; reuse across hot paths on large esmini CSVs."""
    if "_name_norm" in df.columns:
        return df["_name_norm"]
    return df["name"].astype(str).str.strip()


def _dims_for_agent(df: pd.DataFrame, name: str) -> Tuple[str, float, float]:
    """Return (class, width, length) from CSV dimensions or defaults."""
    cls, w_def, ln_def = _AGENT_DEFAULTS.get(name, ("car", 2.0, 4.5))
    sub = df[_normalized_name_series(df) == name]
    if sub.empty:
        return cls, w_def, ln_def
    w = ln = None
    if "width" in sub.columns:
        w = sub["width"].dropna().median()
    if "length" in sub.columns:
        ln = sub["length"].dropna().median()
    try:
        w = float(w) if w is not None and not pd.isna(w) else w_def
    except (TypeError, ValueError):
        w = w_def
    try:
        ln = float(ln) if ln is not None and not pd.isna(ln) else ln_def
    except (TypeError, ValueError):
        ln = ln_def
    if w < _MIN_VALID_WIDTH:
        w = w_def
    if ln < _MIN_VALID_LENGTH:
        ln = ln_def
    return cls, w, ln


def build_agent_registry(df: pd.DataFrame) -> List[dict]:
    """Build agent list with track_id, display_id (1-based), role, width, length."""
    names = sorted({str(n).strip() for n in df["name"].unique() if str(n).strip()})
    if "Ego" in names:
        names = ["Ego"] + sorted(n for n in names if n != "Ego")
    registry = []
    display_id = 1
    for track_id, name in enumerate(names):
        cls, w, ln = _dims_for_agent(df, name)
        registry.append(
            {
                "track_id": track_id,
                "display_id": display_id,
                "name": name,
                "role": infer_agent_role(name),
                "class": cls,
                "width": w,
                "length": ln,
            }
        )
        display_id += 1
    return registry

DEFAULT_N_SNAPSHOTS = 12
DEFAULT_MIN_FRAME_GAP_S = 0.35
DEFAULT_ACTION_MIN_GAP_S = 0.1


def tier2_output_dir(
    base: str | Path,
    dataset: str,
    n_clusters: Optional[int] = None,
    cluster_label: Optional[int] = None,
) -> Path:
    """
    ``bev_output_tier2/{dataset}/cluster_num{N}/cluster_{label}/`` layout.
    """
    root = Path(base) / dataset
    if n_clusters is not None:
        root = root / f"cluster_num{n_clusters}"
    if cluster_label is not None:
        root = root / f"cluster_{cluster_label}"
    return root


def _slug_label(label: str) -> str:
    return "".join(c if c.isalnum() or c in "-_" else "_" for c in label).strip("_")


def extract_action_timestamps_gpl(
    action_yaml_path: str | Path,
    min_gap: float = DEFAULT_ACTION_MIN_GAP_S,
    semantic_only: bool = False,
) -> List[Tuple[float, str]]:
    """Thin wrapper — timestamps live in ``conflict_frame_selector`` (action.yaml only)."""
    from conflict_frame_selector import extract_action_timestamps

    return extract_action_timestamps(
        action_yaml_path=action_yaml_path,
        min_gap=min_gap,
        semantic_only=semantic_only,
    )


def _heading_to_degrees(h: float) -> float:
    """esmini ``h`` is radians; MapPlotter expects degrees."""
    if abs(h) > 2 * math.pi + 0.5:
        return h
    return math.degrees(h)


def esmini_df_to_trajectory_csv(df: pd.DataFrame, out_path: Path) -> List[dict]:
    """Write xosc_gen-format trajectory CSV; return agent registry for meta.yaml."""
    registry = build_agent_registry(df)
    name_to_id = {a["name"]: a["track_id"] for a in registry}

    fieldnames = [
        "trackId",
        "time",
        "x",
        "y",
        "velocity",
        "heading",
        "road_id",
        "lane_id",
        "lane_offset",
        "s",
    ]
    out_path.parent.mkdir(parents=True, exist_ok=True)
    with out_path.open("w", newline="") as fh:
        writer = csv.DictWriter(fh, fieldnames=fieldnames)
        writer.writeheader()
        for _, row in df.iterrows():
            name = str(row["name"]).strip()
            if name not in name_to_id:
                continue
            writer.writerow(
                {
                    "trackId": name_to_id[name],
                    "time": round(float(row["time"]), 3),
                    "x": float(row["x"]),
                    "y": float(row["y"]),
                    "velocity": float(row.get("speed", 0) or 0),
                    "heading": round(_heading_to_degrees(float(row["h"])), 3),
                    "road_id": int(row.get("roadId", 0) or 0),
                    "lane_id": int(row.get("laneId", 0) or 0),
                    "lane_offset": float(row.get("offset", 0) or 0),
                    "s": float(row.get("s", 0) or 0),
                }
            )
    return registry


def write_meta_yaml(
    registry: List[dict],
    df: pd.DataFrame,
    out_path: Path,
    dataset: str = "gplodd",
    location: str = "hct_6",
) -> None:
    t0 = float(df["time"].min())
    t1 = float(df["time"].max())
    payload = {
        "dataset": dataset,
        "location": location,
        "x_offset": 0.0,
        "y_offset": 0.0,
        "duration": round(t1 - t0, 3),
        "agents": [
            {
                "track_id": a["track_id"],
                "display_id": a["display_id"],
                "role": a["role"],
                "class": a["class"],
                "name": a["name"],
                "width": a["width"],
                "length": a["length"],
            }
            for a in registry
        ],
    }
    out_path.parent.mkdir(parents=True, exist_ok=True)
    with out_path.open("w") as fh:
        yaml.safe_dump(payload, fh, sort_keys=False)


def view_bounds_from_df(
    df: pd.DataFrame,
    pad_frac: float = 0.20,
) -> Tuple[float, float, float, float]:
    """Crop window around all agents (metres).

    Padding is proportional to agent span per axis (default 10% each side).
    Example: x span 100 m, y span 80 m → padded window 120 m × 96 m.
    """
    xs = df["x"].astype(float)
    ys = df["y"].astype(float)
    x_min, x_max = float(xs.min()), float(xs.max())
    y_min, y_max = float(ys.min()), float(ys.max())
    pad = max(x_max - x_min, y_max - y_min) * pad_frac
    return (
        x_min - pad,
        x_max + pad,
        y_min - pad,
        y_max + pad,
    )


def highlight_road_ids_from_df(df: pd.DataFrame) -> List[str]:
    """Road IDs used during the trial (for gray lane fill in MapPlotter).

    Accepts either esmini ``roadId`` or trajectory ``road_id`` columns.
    Rows with id ≤ 0 are ignored (common for Path-A materialised CSVs).
    """
    ids = set()
    for col in ("roadId", "road_id"):
        if col not in df.columns:
            continue
        for v in df[col].dropna().unique():
            try:
                iv = int(v)
                if iv > 0:
                    ids.add(str(iv))
            except (TypeError, ValueError):
                pass
    return sorted(ids, key=int)


def highlight_road_ids_near_agents(
    df: pd.DataFrame,
    map_tracks_csv: str,
    *,
    radius_m: float = 45.0,
    max_samples: int = 40,
) -> List[str]:
    """Fallback when CSV road IDs are missing/zero: nearest odrplot roads to agents."""
    from map_plotter import MapPlotter, _roads_near_anchors

    if df is None or df.empty or not map_tracks_csv:
        return []
    # Subsample agent positions along the trial.
    pts: List[Tuple[float, float]] = []
    step = max(1, len(df) // max_samples)
    for _, row in df.iloc[::step].iterrows():
        try:
            pts.append((float(row["x"]), float(row["y"])))
        except (KeyError, TypeError, ValueError):
            continue
    if not pts:
        return []
    plotter = MapPlotter()
    try:
        (
            _all_lanes,
            _proc,
            road_id_text_plot_info,
            *_rest,
        ) = plotter._parse_and_process_map_data(map_tracks_csv)
    except Exception:
        return []

    found = _roads_near_anchors(road_id_text_plot_info, pts, radius_m)
    return sorted(found, key=lambda s: int(s) if str(s).isdigit() else 0)


def highlight_conflict_corridor_roads(
    df: pd.DataFrame,
    map_tracks_csv: str,
    *,
    partner_name: Optional[str] = None,
    context_name: Optional[str] = None,
    max_roads: int = 5,
    at_time: Optional[float] = None,
) -> List[str]:
    """Road IDs for conflict BEV labels: ego + partner (+ context), ≤ ``max_roads``.

    Prefer real ``roadId`` / ``road_id`` from those agents when present (>0).
    Otherwise pick the single nearest odrplot road label per agent position.

    ``at_time`` (e.g. peak / relevance) is used for the spatial fallback — **not**
    the last frame of the trial (end-of-trial poses sit on far junction roads and
    starve corridor labels on earlier snapshots).
    """
    from map_plotter import MapPlotter, _nearest_roads_per_anchor

    if df is None or df.empty or max_roads <= 0:
        return []

    names = {str(x).strip() for x in df["name"].unique() if str(x).strip()}
    ego_name = "Ego" if "Ego" in names else (sorted(names)[0] if names else None)
    focus = [n for n in (ego_name, partner_name, context_name) if n]

    def _ids_for_name(name: str) -> List[str]:
        sub = df[df["name"].astype(str).str.strip() == str(name).strip()]
        out: List[str] = []
        for col in ("roadId", "road_id"):
            if col not in sub.columns:
                continue
            for v in sub[col].dropna().unique():
                try:
                    iv = int(v)
                    if iv > 0:
                        out.append(str(iv))
                except (TypeError, ValueError):
                    pass
        seen = set()
        ordered: List[str] = []
        for rid in out:
            if rid not in seen:
                seen.add(rid)
                ordered.append(rid)
        return ordered

    chosen: List[str] = []
    seen: set = set()
    for name in focus:
        for rid in _ids_for_name(name):
            if rid not in seen:
                seen.add(rid)
                chosen.append(rid)
            if len(chosen) >= max_roads:
                return chosen[:max_roads]

    if chosen:
        return chosen[:max_roads]

    # Spatial fallback: nearest road label per focus agent at ``at_time``
    # (default: mid-trial), never the last pose alone.
    t_ref = float(at_time) if at_time is not None else float(df["time"].median())
    anchors: List[Tuple[float, float]] = []
    for name in focus:
        sub = df[df["name"].astype(str).str.strip() == str(name).strip()]
        if sub.empty:
            continue
        sub = sub.sort_values("time")
        i = int((sub["time"] - t_ref).abs().to_numpy().argmin())
        row = sub.iloc[i]
        try:
            anchors.append((float(row["x"]), float(row["y"])))
        except (KeyError, TypeError, ValueError):
            continue
    if not anchors or not map_tracks_csv:
        return []
    try:
        (
            _all_lanes,
            _proc,
            road_id_text_plot_info,
            *_rest,
        ) = MapPlotter()._parse_and_process_map_data(map_tracks_csv)
    except Exception:
        return []
    found = _nearest_roads_per_anchor(
        road_id_text_plot_info, anchors, max_roads=max_roads
    )
    return sorted(found, key=lambda s: int(s) if str(s).isdigit() else 0)


def unique_time_steps(df: pd.DataFrame) -> List[float]:
    """Sorted simulation timestamps from an esmini CSV."""
    return sorted(df["time"].unique().tolist())


def _ego_initial_yaw_deg(df: pd.DataFrame) -> Optional[float]:
    """First-frame ego heading in degrees (Replayer fixed orientation)."""
    names = {str(x).strip() for x in df["name"].unique() if str(x).strip()}
    ego_name = "Ego" if "Ego" in names else (sorted(names)[0] if names else None)
    if ego_name is None:
        return None
    ego = (
        df[df["name"].astype(str).str.strip() == ego_name]
        .sort_values("time")
        .reset_index(drop=True)
    )
    if ego.empty or "h" not in ego.columns:
        return None
    return float(_heading_to_degrees(float(ego.iloc[0]["h"])))


def _ego_position_lookup(df: pd.DataFrame):
    """Return f(t) → (ego_x, ego_y) using the nearest esmini frame, or None."""
    names = {str(x).strip() for x in df["name"].unique() if str(x).strip()}
    ego_name = "Ego" if "Ego" in names else (sorted(names)[0] if names else None)
    if ego_name is None:
        return lambda _t: None
    ego = (
        df[df["name"].astype(str).str.strip() == ego_name]
        .sort_values("time")
        .reset_index(drop=True)
    )
    if ego.empty:
        return lambda _t: None
    et = ego["time"].to_numpy(dtype=float)
    ex = ego["x"].to_numpy(dtype=float)
    ey = ego["y"].to_numpy(dtype=float)

    def _at(t: float):
        i = int(np.argmin(np.abs(et - t)))
        return float(ex[i]), float(ey[i])

    return _at


def _agent_position_lookup(df: pd.DataFrame, name: Optional[str] = None, track_id: Optional[int] = None):
    """Return f(t) → (x, y) for a named agent or trackId, or None."""
    sub = df
    if name:
        sub = df[df["name"].astype(str).str.strip() == str(name).strip()]
    elif track_id is not None and "trackId" in df.columns:
        sub = df[df["trackId"] == int(track_id)]
    elif track_id is not None and "name" in df.columns:
        # esmini CSV: map track via name order is unreliable — try name match later
        return lambda _t: None
    sub = sub.sort_values("time").reset_index(drop=True)
    if sub.empty:
        return lambda _t: None
    et = sub["time"].to_numpy(dtype=float)
    ex = sub["x"].to_numpy(dtype=float)
    ey = sub["y"].to_numpy(dtype=float)

    def _at(t: float):
        i = int(np.argmin(np.abs(et - t)))
        return float(ex[i]), float(ey[i])

    return _at


def _metric_chip_text(d, ttc) -> Optional[str]:
    parts = []
    if d is not None:
        parts.append(f"d={d:.1f}m")
    if ttc is not None:
        parts.append(f"ttc={ttc:.1f}s")
    return "  ".join(parts) if parts else None


def _selection_to_key_indices(selection, time_steps: List[float]):
    """Map SelectedFrame list → (index, label, frame) for rendering."""
    if not time_steps:
        return []
    t_arr = np.asarray(time_steps, dtype=float)
    picks = []
    seen = set()
    for fr in selection.frames:
        idx = int(np.argmin(np.abs(t_arr - fr.t)))
        if idx in seen:
            continue
        seen.add(idx)
        picks.append((idx, fr.label, fr))
    return picks


def _autocrop_white(im, pad: int = 8):
    """Trim surrounding pure-white margin, leaving a small uniform padding."""
    from PIL import Image, ImageChops

    bg = Image.new(im.mode, im.size, (255, 255, 255))
    bbox = ImageChops.difference(im, bg).getbbox()
    if not bbox:
        return im
    l, t, r, b = bbox
    l = max(0, l - pad)
    t = max(0, t - pad)
    r = min(im.width, r + pad)
    b = min(im.height, b + pad)
    return im.crop((l, t, r, b))


def _load_title_font(size: int):
    from PIL import ImageFont

    for name in ("DejaVuSans-Bold.ttf", "DejaVuSans.ttf", "Arial.ttf"):
        try:
            return ImageFont.truetype(name, size)
        except Exception:
            continue
    return ImageFont.load_default()


def compose_dual_bev(
    full_path: str,
    zoom_path: str,
    out_path: str,
    title: Optional[str] = None,
    border_px: int = 3,
    gap_px: int = 14,
) -> bool:
    """Combine two BEV panels into one labelled image.

    Layout: a white title bar on top, then the two panels side by side —
    left = whole-scene view, right = ego-centric zoom. Each panel keeps its own
    aspect ratio (no forced 4:3) after redundant white margins are trimmed, and
    is framed by a black border so the two views are clearly distinguishable.
    Returns False if Pillow is unavailable or a panel is missing (caller keeps
    the single whole-scene image).
    """
    try:
        from PIL import Image, ImageDraw, ImageOps
    except Exception:
        return False
    if not (os.path.isfile(full_path) and os.path.isfile(zoom_path)):
        return False

    left = _autocrop_white(Image.open(full_path).convert("RGB"))
    right = _autocrop_white(Image.open(zoom_path).convert("RGB"))

    # Match panels to a common content height (preserve each panel's own width).
    panel_h = max(left.height, right.height)

    def _to_height(im, h):
        if im.height == h:
            return im
        w = max(1, int(round(im.width * h / im.height)))
        return im.resize((w, h), Image.LANCZOS)

    left = _to_height(left, panel_h)
    right = _to_height(right, panel_h)

    # Black frame on each panel boundary (distinguishes the two views).
    left = ImageOps.expand(left, border=border_px, fill=(0, 0, 0))
    right = ImageOps.expand(right, border=border_px, fill=(0, 0, 0))

    row_w = left.width + gap_px + right.width
    row_h = left.height  # == right.height after expand

    title_h = max(40, int(panel_h * 0.07)) if title else 0
    canvas = Image.new("RGB", (row_w, title_h + row_h), (255, 255, 255))

    if title_h:
        draw = ImageDraw.Draw(canvas)
        max_w = row_w - 24  # side margin

        def _text_wh(s, font):
            try:
                tb = draw.textbbox((0, 0), s, font=font)
                return tb[2] - tb[0], tb[3] - tb[1]
            except Exception:
                return (font.getsize(s) if hasattr(font, "getsize") else (0, 0))

        # Shrink font to fit the width; if still too wide at the floor size,
        # truncate the title with an ellipsis (long multi-agent action slugs).
        text = title
        size = max(18, int(title_h * 0.55))
        font = _load_title_font(size)
        tw, th = _text_wh(text, font)
        while tw > max_w and size > 12:
            size -= 2
            font = _load_title_font(size)
            tw, th = _text_wh(text, font)
        while tw > max_w and len(text) > 8:
            text = text[:-2]
            tw, th = _text_wh(text + "\u2026", font)
        if text != title:
            text += "\u2026"
            tw, th = _text_wh(text, font)
        draw.text(((row_w - tw) // 2, max(0, (title_h - th) // 2 - 2)),
                  text, fill=(0, 0, 0), font=font)
        # Thin separator under the title bar.
        draw.line([(0, title_h - 1), (row_w, title_h - 1)], fill=(0, 0, 0), width=1)

    canvas.paste(left, (0, title_h))
    canvas.paste(right, (left.width + gap_px, title_h))
    canvas.save(out_path, quality=90)
    return True


def infer_collision_timestep(
    df: pd.DataFrame,
    threshold_m: float = 2.5,
    *,
    meta_agents: Optional[List[dict]] = None,
    trial_events: Optional[List[dict]] = None,
    collided: bool = True,
) -> Optional[float]:
    """Return collision key time from GT events or polygon clearance."""
    from collision_partner import resolve_collision_partner

    agents = meta_agents or []
    if not agents:
        registry = build_agent_registry(df)
        agents = [
            {"track_id": a["track_id"], "name": a["name"]}
            for a in registry
        ]
    partner = resolve_collision_partner(
        df,
        agents,
        trial_events=trial_events,
        collided=collided,
    )
    return partner.key_time if partner else None


def df_to_trajectory_dict(df: pd.DataFrame) -> Tuple[Dict[str, List[dict]], List[float]]:
    """Build BevRenderer-style trajectory dict for key-frame selection."""
    names = sorted({str(n).strip() for n in df["name"].unique() if str(n).strip()})
    if "Ego" in names:
        names = ["Ego"] + sorted(n for n in names if n != "Ego")
    agent_dims = {name: _dims_for_agent(df, name)[1:] for name in names}

    name_col = _normalized_name_series(df)
    sub = df.assign(_name_norm=name_col)
    traj: Dict[str, List[dict]] = {}
    for name in names:
        w, ln = agent_dims[name]
        rows = sub.loc[sub["_name_norm"] == name].sort_values("time")
        if rows.empty:
            continue
        traj[name] = [
            {
                "x": float(r["x"]),
                "y": float(r["y"]),
                "yaw": float(r["h"]),
                "width": w,
                "length": ln,
                "speed": float(r.get("speed", 0) or 0),
            }
            for _, r in rows.iterrows()
        ]
    return traj, unique_time_steps(df)


MAP_OVERVIEW_FILENAME = "map_overview.jpg"


def clear_snapshot_dir(output_dir: str | Path) -> None:
    """Remove all files in a snapshot output folder before a fresh BEV run."""
    d = Path(output_dir)
    d.mkdir(parents=True, exist_ok=True)
    for stale in d.iterdir():
        if stale.is_file():
            stale.unlink(missing_ok=True)


class Tier2BevRenderer:
    """Render BEV snapshots via xosc_gen MapPlotter + odrplot tracks CSV."""

    def __init__(
        self,
        map_tracks_csv: str,
        xodr_path: str,
        location: str = "hct_6",
        dataset_name: str = "gplodd",
        snapshot_output_px: int = 1024,
        snapshot_border_frac: float = 0.10,
        typography: BevTypography = DEFAULT_BEV_TYPOGRAPHY,
        ego_zoom_radius: float = 30.0,
    ):
        self.map_tracks_csv = map_tracks_csv
        self.xodr_path = xodr_path
        self.location = location
        self.dataset_name = dataset_name
        self.snapshot_output_px = snapshot_output_px
        self.snapshot_border_frac = snapshot_border_frac
        self.typography = typography
        # Legacy radius kept for callers; medoid snapshots now use adaptive
        # ego–partner + 2 m framing instead of a fixed dual-panel zoom.
        self.ego_zoom_radius = ego_zoom_radius
        self.fixed_view_yaw_deg: Optional[float] = None
        if not Path(map_tracks_csv).is_file():
            raise FileNotFoundError(
                f"Map tracks CSV not found: {map_tracks_csv}\n"
                "Run: python3 app/analyzer/src/dataset_builder.py --batch-id <n> --map-only"
            )
        self._plotter = MapPlotter()

    def render_map_overview(
        self,
        highlight_road_ids: List[str],
        view_bounds: Tuple[float, float, float, float],
        output_path: str,
        title: Optional[str] = None,
    ) -> str:
        """Local map without agents — red road IDs, black lane IDs (xosc_gen style)."""
        os.makedirs(os.path.dirname(output_path) or ".", exist_ok=True)
        self._plotter.render_scene(
            self.map_tracks_csv,
            output_path,
            highlight_road_ids_list=highlight_road_ids,
            view_bounds=view_bounds,
            draw_labels=True,
            typography=self.typography,
            figure_title=title or "Map overview (cluster roads)",
            scope_bounds=view_bounds,
            output_px=self.snapshot_output_px,
            white_border_frac=self.snapshot_border_frac,
            fill_lane_polygons=False,
            draw_ref_lines=True,
            draw_ref_arrows=False,
            max_road_labels=5,
        )
        print(f"[Tier2BevRenderer] Saved map overview {output_path}")
        return output_path

    def render_trial_from_esmini_csv(
        self,
        batch_id: int,
        trial_index: int,
        output_dir: str,
        n_snapshots: Optional[int] = None,
        file_prefix: Optional[str] = None,
        overview_dir: Optional[str] = None,
        action_yaml_path: Optional[str] = None,
        *,
        conflict_window_s: Optional[float] = None,
        conflict_window_before_s: float = 15.0,
        conflict_window_after_s: float = 8.0,
        selection_out: Optional[list] = None,
    ) -> List[BevSnapshot]:
        if not csv_exists(batch_id, trial_index):
            raise FileNotFoundError(
                f"No esmini CSV for batch {batch_id} trial {trial_index}"
            )
        df = get_csv_road_data(batch_id, trial_index)
        if df is None or df.empty:
            raise RuntimeError(f"Empty esmini CSV for batch {batch_id} trial {trial_index}")

        prefix = file_prefix or f"trial_{trial_index}"
        clear_snapshot_dir(output_dir)
        work = Path(tempfile.mkdtemp(prefix="bev_tier2_"))
        try:
            traj_csv = work / "trajectory.csv"
            meta_yaml = work / "meta.yaml"
            registry = esmini_df_to_trajectory_csv(df, traj_csv)
            write_meta_yaml(
                registry,
                df,
                meta_yaml,
                dataset=self.dataset_name,
                location=self.location,
            )

            time_steps = unique_time_steps(df)
            from conflict_frame_selector import select_action_frames

            if not action_yaml_path or not Path(action_yaml_path).is_file():
                raise FileNotFoundError(
                    "action.yaml is required for BEV (action-first Path A). "
                    "Label the trial before rendering snapshots."
                )

            selection = select_action_frames(
                df,
                action_yaml_path=action_yaml_path,
                time_steps=time_steps,
                conflict_window_s=conflict_window_s,
                conflict_window_before_s=float(conflict_window_before_s),
                conflict_window_after_s=float(conflict_window_after_s),
            )
            key_with_frames = _selection_to_key_indices(selection, time_steps)
            key_indices = [(i, lab) for i, lab, _ in key_with_frames]
            print(
                f"[Tier2BevRenderer] action-derived selection: {len(key_indices)} frames "
                f"(partner={selection.partner_name or '?'}, peak_t={selection.peak_t})"
            )

            if n_snapshots is not None and len(key_with_frames) > n_snapshots:
                key_with_frames = key_with_frames[:n_snapshots]
                key_indices = [(i, lab) for i, lab, _ in key_with_frames]

            highlight = highlight_conflict_corridor_roads(
                df,
                self.map_tracks_csv,
                partner_name=selection.partner_name if selection else None,
                context_name=selection.context_partner_name if selection else None,
                max_roads=5,
                at_time=selection.peak_t if selection else None,
            )
            if highlight:
                print(
                    f"[Tier2BevRenderer] conflict corridor roads (≤5): {highlight}"
                )
            else:
                # Last resort: trial-wide IDs, still capped later by MapPlotter.
                highlight = highlight_road_ids_from_df(df)[:5]
            vbounds = view_bounds_from_df(df)
            snapshots: List[BevSnapshot] = []

            overview_root = overview_dir if overview_dir is not None else output_dir
            overview_path = os.path.join(overview_root, MAP_OVERVIEW_FILENAME)
            self.render_map_overview(
                highlight,
                vbounds,
                overview_path,
                title="Map overview — cluster medoid roads",
            )

            ego_xy_at = _ego_position_lookup(df)
            if self.fixed_view_yaw_deg is None:
                self.fixed_view_yaw_deg = _ego_initial_yaw_deg(df)
            partner_name = selection.partner_name if selection else None
            partner_xy_at = (
                _agent_position_lookup(df, name=partner_name)
                if partner_name
                else (lambda _t: None)
            )
            ctx_name = selection.context_partner_name if selection else None
            ctx_xy_at = (
                _agent_position_lookup(df, name=ctx_name)
                if ctx_name
                else (lambda _t: None)
            )

            filenames: List[str] = []
            selected_frames_ordered = []

            for rank, (idx, label, fr) in enumerate(key_with_frames):
                t = float(time_steps[idx])
                # Snap SelectedFrame.t to the rendered timestep.
                if fr is not None:
                    fr.t = round(t, 3)
                    # Filename + dual-panel title share SelectedFrame.title_event()
                    # (= concise_slug); same rule as IC synced BEVs.
                    slug = fr.title_event()
                    use_whole = bool(fr.use_whole_scene)
                    draw_road = bool(fr.draw_agent_road_labels)
                    chip = _metric_chip_text(fr.d, fr.ttc)
                    label_for_title = slug
                else:
                    slug = _slug_label(label)[:60]
                    use_whole = True
                    draw_road = False
                    chip = None
                    label_for_title = slug

                out_name = f"{prefix}_t_{t:05.2f}_{slug}.jpg"
                out_path = os.path.join(output_dir, out_name)
                partner_xy = partner_xy_at(t) if partner_name else None
                ctx_xy = ctx_xy_at(t) if ctx_name else None
                extra = [ctx_xy] if ctx_xy is not None else None
                self._render_snapshot(
                    out_path=out_path,
                    traj_csv=traj_csv,
                    meta_yaml=meta_yaml,
                    highlight=highlight,
                    vbounds=vbounds,
                    t=t,
                    label=label_for_title,
                    ego_xy=ego_xy_at(t),
                    partner_xy=partner_xy,
                    work=work,
                    use_whole_scene=use_whole,
                    draw_agent_road_labels=draw_road,
                    metric_chip=chip,
                    extra_pair_xy=extra,
                    frame=fr,
                )
                snapshots.append(BevSnapshot(timestep=t, label=label_for_title, path=out_path))
                filenames.append(out_name)
                if fr is not None:
                    selected_frames_ordered.append(fr)
                print(f"[Tier2BevRenderer] Saved {out_path}")

            if selection is not None:
                if selected_frames_ordered:
                    selection.frames = selected_frames_ordered
                llm_doc = selection.to_llm_json(prefix, filenames[: len(selection.frames)])
                llm_path = Path(output_dir) / "llm_snapshots.json"
                llm_path.write_text(json.dumps(llm_doc, indent=2), encoding="utf-8")
                print(f"[Tier2BevRenderer] Wrote {llm_path}")
                if selection_out is not None:
                    selection_out.clear()
                    selection_out.append(selection)
                    selection_out.append(filenames[: len(selection.frames)])

            return snapshots
        finally:
            import shutil

            shutil.rmtree(work, ignore_errors=True)

    def _render_one_panel(
        self,
        out_path: str,
        *,
        traj_csv: Path,
        meta_yaml: Path,
        highlight: List[str],
        view_bounds: Tuple[float, float, float, float],
        t: float,
        time_label: str,
        draw_labels: bool = False,
        label_anchors: Optional[List[Tuple[float, float]]] = None,
        metric_chip: Optional[str] = None,
        label_avoid_xy: Optional[List[Tuple[float, float]]] = None,
        view_yaw_deg: Optional[float] = None,
        view_center: Optional[Tuple[float, float]] = None,
    ) -> None:
        yaw = view_yaw_deg if view_yaw_deg is not None else self.fixed_view_yaw_deg
        center = view_center
        if center is None and view_bounds is not None:
            xmin, xmax, ymin, ymax = view_bounds
            center = ((xmin + xmax) / 2.0, (ymin + ymax) / 2.0)
        self._plotter.render_scene(
            self.map_tracks_csv,
            out_path,
            highlight_road_ids_list=highlight,
            view_bounds=view_bounds,
            draw_labels=draw_labels,
            typography=self.typography,
            tracks_csv_path=str(traj_csv),
            metadata_yaml_path=str(meta_yaml),
            timestamp=float(t),
            ego_id=0,
            heading_in_degrees=True,
            draw_trajectory_trails=True,
            time_label=time_label,
            scope_bounds=view_bounds,
            output_px=self.snapshot_output_px,
            white_border_frac=self.snapshot_border_frac,
            label_anchors=label_anchors,
            metric_chip=metric_chip,
            label_avoid_xy=label_avoid_xy,
            fill_lane_polygons=False,
            draw_ref_lines=True,
            draw_ref_arrows=False,
            max_road_labels=5,
            view_rotation_deg=yaw,
            view_rotation_center=center if yaw is not None else None,
        )

    def _render_snapshot(
        self,
        *,
        out_path: str,
        traj_csv: Path,
        meta_yaml: Path,
        highlight: List[str],
        vbounds: Tuple[float, float, float, float],
        t: float,
        label: str,
        ego_xy: Optional[Tuple[float, float]],
        work: Path,
        partner_xy: Optional[Tuple[float, float]] = None,
        use_whole_scene: bool = True,
        draw_agent_road_labels: bool = False,
        metric_chip: Optional[str] = None,
        extra_pair_xy: Optional[List[Tuple[float, float]]] = None,
        frame: Optional[Any] = None,
    ) -> None:
        """Render a single ego-centered adaptive BEV (ego–partner + 2 m)."""
        from conflict_frame_selector import (
            adaptive_half_extent,
            ego_centered_square_bounds,
        )

        anchors: Optional[List[Tuple[float, float]]] = None
        avoid: Optional[List[Tuple[float, float]]] = None
        if ego_xy is not None:
            avoid = [ego_xy]
            if partner_xy is not None:
                avoid.append(partner_xy)
            if extra_pair_xy:
                avoid.extend(extra_pair_xy)
        if draw_agent_road_labels and ego_xy is not None:
            anchors = list(avoid) if avoid else [ego_xy]

        short = label.split("+")[0] if label else ""
        if len(short) > 56:
            short = short[:53] + "…"

        if ego_xy is None:
            self._render_one_panel(
                out_path, traj_csv=traj_csv, meta_yaml=meta_yaml,
                highlight=highlight, view_bounds=vbounds, t=t,
                time_label=f"t = {t:.2f}s — {short or label}",
                draw_labels=draw_agent_road_labels,
                label_anchors=anchors,
                metric_chip=metric_chip,
                label_avoid_xy=avoid,
            )
            return

        d_m = None
        if partner_xy is not None:
            d_m = math.hypot(
                float(partner_xy[0]) - float(ego_xy[0]),
                float(partner_xy[1]) - float(ego_xy[1]),
            )
        elif frame is not None and getattr(frame, "d", None) is not None:
            d_m = float(frame.d)
        half = adaptive_half_extent(d_m)
        bounds = ego_centered_square_bounds(ego_xy, half)
        yaw = self.fixed_view_yaw_deg
        caption = f"t = {t:.2f}s  {short}  ±{half:.0f}m".strip()
        self._render_one_panel(
            out_path, traj_csv=traj_csv, meta_yaml=meta_yaml,
            highlight=highlight, view_bounds=bounds, t=t,
            time_label=caption,
            draw_labels=draw_agent_road_labels,
            label_anchors=anchors,
            metric_chip=metric_chip,
            label_avoid_xy=avoid,
            view_yaw_deg=yaw,
            view_center=ego_xy,
        )
        if frame is not None:
            frame.camera_half_m = round(float(half), 2)
            frame.view_yaw_deg = round(float(yaw), 2) if yaw is not None else None

    def render_cluster_medoids(
        self,
        medoids: Dict[int, Tuple[int, int]],
        output_dir: str,
        n_snapshots: Optional[int] = None,
        dataset: Optional[str] = None,
        n_clusters: Optional[int] = None,
        action_yaml_dir: Optional[str] = None,
    ) -> Dict[int, List[BevSnapshot]]:
        results: Dict[int, List[BevSnapshot]] = {}
        for label, (batch_id, trial_index) in medoids.items():
            if dataset and n_clusters is not None:
                # output_dir = bev_output_tier2 root
                cluster_out = str(
                    tier2_output_dir(output_dir, dataset, n_clusters, label)
                )
            else:
                cluster_out = os.path.join(output_dir, f"cluster_{label}")
            try:
                if dataset:
                    trial_label = csv_indices_to_trial_id(dataset, batch_id, trial_index)
                else:
                    trial_label = str(trial_index)
                action_yaml = None
                if action_yaml_dir:
                    candidate = Path(action_yaml_dir) / f"cluster{label}" / "action.yaml"
                    if candidate.is_file():
                        action_yaml = str(candidate)
                snaps = self.render_trial_from_esmini_csv(
                    batch_id,
                    trial_index,
                    cluster_out,
                    n_snapshots=n_snapshots,
                    file_prefix=f"trial_{trial_label}",
                    action_yaml_path=action_yaml,
                )
                results[label] = snaps
            except FileNotFoundError as e:
                print(f"[Tier2BevRenderer] SKIP cluster {label}: {e}")
        return results


def _pick_cluster_representative_trial_id(
    trial_ids: List[str],
    trajectories: Optional[dict],
) -> Optional[str]:
    """Geometric medoid on Ego mean (x,y), matching Phase 3a bev_renderer."""
    if trajectories:
        trial_means = []
        for tid in trial_ids:
            if tid not in trajectories:
                continue
            frames = trajectories[tid].get("trajectory", {}).get("Ego", [])
            if not frames:
                continue
            mx = sum(f["x"] for f in frames) / len(frames)
            my = sum(f["y"] for f in frames) / len(frames)
            trial_means.append((tid, mx, my))
        if trial_means:
            ctr_x = sum(m[1] for m in trial_means) / len(trial_means)
            ctr_y = sum(m[2] for m in trial_means) / len(trial_means)
            return min(
                trial_means,
                key=lambda m: (m[1] - ctr_x) ** 2 + (m[2] - ctr_y) ** 2,
            )[0]
    return trial_ids[0] if trial_ids else None


def load_medoids_from_clustering(
    clustering_path: str,
    dataset: str,
    trajectories_path: Optional[str] = None,
) -> Dict[int, Tuple[int, int]]:
    """
    Map cluster label -> (batch_id, trial_index) for the given dataset.

    Clustering keys are Payload trial IDs (e.g. 8135 for dataset2).
    CSV files use ``esmini_{batch}_{trial_index}.csv`` with
    ``trial_index = trial_id - trial_id_base`` (see readMD/DATA_INVENTORY_AND_ANALYSIS.md).
    """
    cfg = get_dataset_config(dataset)
    batch_id = int(cfg["batch_id"])

    trajectories: Optional[dict] = None
    if trajectories_path and Path(trajectories_path).is_file():
        with open(trajectories_path) as f:
            trajectories = json.load(f)

    with open(clustering_path) as f:
        clustering = json.load(f)

    medoids: Dict[int, Tuple[int, int]] = {}
    label_to_trials: Dict[str, List[str]] = {}
    for trial_id, label in clustering["data"].items():
        label_to_trials.setdefault(label, []).append(trial_id)

    for label_str, trial_ids in label_to_trials.items():
        label = int(label_str)
        if label == -1:
            continue

        rep_id = _pick_cluster_representative_trial_id(trial_ids, trajectories)
        if rep_id is None:
            continue

        # Prefer geometric medoid if its CSV exists; else first cluster member with CSV.
        candidates = [rep_id] + [
            tid for tid in sorted(trial_ids, key=int) if tid != rep_id
        ]
        chosen: Optional[Tuple[int, int]] = None
        for tid in candidates:
            try:
                b, tidx = trial_id_to_csv_indices(dataset, tid)
            except (ValueError, KeyError):
                continue
            if b != batch_id:
                continue
            if csv_exists(b, tidx):
                chosen = (b, tidx)
                break

        if chosen:
            medoids[label] = chosen
        else:
            print(
                f"[Tier2BevRenderer] SKIP cluster {label}: no local CSV for "
                f"dataset {dataset} (batch {batch_id}, tried {len(trial_ids)} trials)"
            )

    return medoids


def resolve_tier2_paths(dataset: str) -> Tuple[Path, Path, str]:
    """Return (xodr_path, map_tracks_csv, location) for a dataset."""
    cfg = get_dataset_config(dataset)
    xodr = xodr_path_for_dataset(dataset)
    tracks = map_tracks_path_for_dataset(dataset)
    return xodr, tracks, str(cfg["location"])
