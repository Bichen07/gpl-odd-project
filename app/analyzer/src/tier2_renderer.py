"""
bev_tier2_renderer.py — Phase 3b: xosc_gen-style BEV using esmini odrplot map + MapPlotter.

Map:   ``hct_6_tracks.csv`` from ``scripts/generate_map_tracks.py`` (esmini odrplot).
Agents: local ``esmini_<batch>_<trial>.csv`` (authoritative sim ground truth).
"""
from __future__ import annotations

import csv
import json
import math
import os
import tempfile
from pathlib import Path
from typing import Dict, List, Optional, Tuple

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
from taxonomy import Thresholds

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
_UNCAPPED_MAX_FRAMES = 99999

# Semantic maneuver events (skip MAINTAIN_SPEED / DECELERATE when semantic_only=True).
SEMANTIC_ACTION_TYPES = frozenset({
    "LANE_CHANGE_LEFT",
    "LANE_CHANGE_RIGHT",
    "ENTER_JUNCTION",
    "EXIT_JUNCTION",
    "EMERGENCY_BRAKE",
    "STOPPED",
})


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


def _combine_labels(prev: str, new: str, max_parts: int = 3) -> str:
    """Join co-occurring frame labels with ``+`` but cap the count so a frame
    where many agents act at once (e.g. every parked car ``start STOPPED`` at
    t=0) does not produce an unbounded title / filename."""
    for key in ("COLLISION", "NEAR_MISS", "DANGEROUS_CUT_IN", "CLOSEST_APPROACH"):
        if key in new:
            extras = [p for p in prev.split("+") if p and key not in p][: max(0, max_parts - 1)]
            return "+".join([new] + extras) if extras else new
        if key in prev:
            extras = [p for p in new.split("+") if p and key not in p][: max(0, max_parts - 1)]
            return "+".join([prev] + extras) if extras else prev

    parts = prev.split("+")
    if new in parts:
        return prev
    if len(parts) >= max_parts:
        return prev if prev.endswith("\u2026") else prev + "\u2026"
    return prev + "+" + new


def _agent_token(agent: dict) -> str:
    """Short BEV-title token for an agent: 'ego' or its NPC name."""
    role = str(agent.get("role", "")).lower()
    tid = agent.get("track_id")
    if role == "ego" or tid == 0:
        return "ego"
    return str(agent.get("name") or f"agent{tid}")


def extract_action_timestamps_gpl(
    action_yaml_path: str | Path,
    min_gap: float = DEFAULT_ACTION_MIN_GAP_S,
    semantic_only: bool = False,
) -> List[Tuple[float, str]]:
    """
    Extract key times from ``action.yaml`` (gpl-odd top-level schema). Returns
    ``(timestamp, label)`` pairs where the label names the **agent** and the
    **phase** of the maneuver, e.g. ``"ego start DECELERATE"`` /
    ``"Opposite end STOPPED"`` — so the BEV title states who is doing what and
    whether the frame is the start or end of the action (interval actions get
    both boundaries; instantaneous ones get a single label).
    """
    path = Path(action_yaml_path)
    if not path.is_file():
        return []

    try:
        with path.open() as fh:
            data = yaml.safe_load(fh) or {}
    except Exception as exc:
        print(f"[tier2] Warning: failed to read action YAML {path}: {exc}")
        return []

    agents = data.get("agents") or []
    id_to_token = {a.get("track_id"): _agent_token(a) for a in agents}

    raw: List[Tuple[float, str]] = []
    for agent in agents:
        token = _agent_token(agent)
        for action in agent.get("actions") or []:
            name = str(action.get("action", "action"))
            if semantic_only and name not in SEMANTIC_ACTION_TYPES:
                continue
            attrs = action.get("attributes") or {}
            st = action.get("start_time", attrs.get("start_time"))
            et = action.get("end_time", attrs.get("end_time"))
            if st is None:
                st = et
            if et is None:
                et = st
            if st is None:
                continue
            st, et = float(st), float(et)
            if et - st > 1e-6:  # interval action → label both boundaries
                raw.append((st, f"{token} start {name}"))
                raw.append((et, f"{token} end {name}"))
            else:               # instantaneous (junction enter/exit, etc.)
                raw.append((st, f"{token} {name}"))

    # Multi-agent interactions (NEAR_MISS / DANGEROUS_CUT_IN) are always
    # significant — feed their peak-conflict timestamp into frame selection so
    # the closest-approach moment is never skipped (independent of semantic_only).
    for inter in data.get("interactions") or []:
        name = str(inter.get("type", "interaction"))
        partner = inter.get("with_name") or id_to_token.get(inter.get("with_track_id"))
        suffix = f" with {partner}" if partner else ""
        kt = inter.get("key_time")
        if kt is not None:
            raw.append((float(kt), f"{name}{suffix}"))
        ct = inter.get("cut_in_time")
        if ct is not None:
            raw.append((float(ct), f"{name} start{suffix}"))

    if not raw:
        return []

    raw.sort(key=lambda x: x[0])
    merged: List[Tuple[float, str]] = []
    for t, label in raw:
        if merged and (t - merged[-1][0]) < min_gap:
            prev_t, prev_label = merged[-1]
            if prev_label != label:
                merged[-1] = (prev_t, _combine_labels(prev_label, label))
            continue
        merged.append((t, label))
    return merged


def _times_to_indices(
    frames: List[Tuple[float, str]],
    time_steps: List[float],
    min_gap: float,
) -> List[Tuple[int, str]]:
    """Map ``(time, label)`` to nearest simulation indices with min-gap dedupe."""
    if not time_steps or not frames:
        return []
    t_arr = np.asarray(time_steps, dtype=float)
    out: List[Tuple[int, str]] = []
    last_t = -1e9
    for t, label in sorted(frames, key=lambda x: x[0]):
        idx = int(np.argmin(np.abs(t_arr - t)))
        t_snap = float(time_steps[idx])
        if out and (t_snap - last_t) < min_gap:
            prev_idx, prev_label = out[-1]
            if prev_label != label:
                out[-1] = (prev_idx, _combine_labels(prev_label, label))
            continue
        out.append((idx, label))
        last_t = t_snap
    return out


def merge_key_frame_times(
    df: pd.DataFrame,
    time_steps: List[float],
    action_frames: List[Tuple[float, str]],
    *,
    min_gap: float = DEFAULT_ACTION_MIN_GAP_S,
    collision_timestep: Optional[float] = None,
    heuristic_max_frames: Optional[int] = None,
    include_proximity_heuristics: bool = False,
) -> List[Tuple[int, str]]:
    """
    Combine action.yaml event times with kinematic heuristics (hybrid mode).
    Action events are kept; heuristics fill gaps (closest approach, collision, etc.).
    """
    action_picks = _times_to_indices(action_frames, time_steps, min_gap)
    action_indices = {idx for idx, _ in action_picks}

    heur_cap = heuristic_max_frames if heuristic_max_frames is not None else _UNCAPPED_MAX_FRAMES
    heur_picks = pick_critical_timestamps(
        df,
        time_steps,
        max_frames=heur_cap,
        min_gap=min_gap,
        collision_timestep=collision_timestep,
        fill_uniform=False,
        include_proximity_heuristics=include_proximity_heuristics,
    )

    merged: List[Tuple[int, str]] = list(action_picks)
    picked_times = [float(time_steps[i]) for i, _ in merged]
    # Closest-approach frames (label "closest_*") are always kept — a crossing or
    # oncoming pass is critical even without a collision. Only the broad
    # "within_20m" marker stays behind the proximity gate.
    gated_labels = {"within_20m"}

    for idx, label in heur_picks:
        if not include_proximity_heuristics and label in gated_labels:
            continue
        if idx in action_indices:
            continue
        t = float(time_steps[idx])
        if picked_times and min(abs(t - pt) for pt in picked_times) < min_gap:
            continue
        merged.append((idx, label))
        picked_times.append(t)

    # The collision frame is authoritative: never let it be dropped or hidden
    # behind a nearby action label (the ego is usually braking/stopping at impact,
    # so its index coincides with an action boundary). Mark the nearest frame as
    # "collision" — or add a dedicated frame if none is close.
    if collision_timestep is not None and time_steps:
        tc = float(collision_timestep)
        coll_idx = min(range(len(time_steps)), key=lambda i: abs(time_steps[i] - tc))
        hit = None
        for n_i, (idx, _label) in enumerate(merged):
            if idx == coll_idx or abs(time_steps[idx] - time_steps[coll_idx]) < min_gap:
                hit = n_i
                break
        if hit is not None:
            idx, label = merged[hit]
            parts = [p for p in label.split("+") if p and p != "collision"]
            merged[hit] = (idx, "+".join(["collision"] + parts[:2]))
        else:
            merged.append((coll_idx, "collision"))

    merged.sort(key=lambda x: time_steps[x[0]])
    return merged


def resolve_key_frames(
    df: pd.DataFrame,
    time_steps: List[float],
    *,
    action_yaml_path: Optional[str] = None,
    key_frame_mode: str = "hybrid",
    min_gap: float = DEFAULT_ACTION_MIN_GAP_S,
    n_snapshots: Optional[int] = None,
    collision_timestep: Optional[float] = None,
    semantic_only: bool = False,
    collision_trial: bool = False,
) -> List[Tuple[int, str]]:
    """
    Select BEV key-frame indices.

    Modes: ``action`` (YAML only), ``hybrid`` (YAML + heuristics), ``heuristic``.
    ``n_snapshots=None`` renders all selected frames; set a cap for quick dev only.
    """
    mode = (key_frame_mode or "hybrid").lower()
    yaml_path = Path(action_yaml_path) if action_yaml_path else None
    has_yaml = yaml_path is not None and yaml_path.is_file()

    if mode == "action":
        if not has_yaml:
            print("[tier2] action mode: no action.yaml — falling back to heuristic")
            mode = "heuristic"
        else:
            frames = extract_action_timestamps_gpl(
                yaml_path, min_gap=min_gap, semantic_only=semantic_only
            )
            picks = _times_to_indices(frames, time_steps, min_gap)
    elif mode == "hybrid":
        action_frames = (
            extract_action_timestamps_gpl(
                yaml_path, min_gap=min_gap, semantic_only=semantic_only
            )
            if has_yaml
            else []
        )
        if action_frames:
            picks = merge_key_frame_times(
                df,
                time_steps,
                action_frames,
                min_gap=min_gap,
                collision_timestep=collision_timestep,
                include_proximity_heuristics=False,
            )
        else:
            print("[tier2] hybrid mode: no action frames — using heuristics only")
            picks = pick_critical_timestamps(
                df,
                time_steps,
                max_frames=n_snapshots or _UNCAPPED_MAX_FRAMES,
                min_gap=min_gap,
                collision_timestep=collision_timestep,
                fill_uniform=n_snapshots is not None,
                include_proximity_heuristics=collision_trial,
            )
    else:
        picks = pick_critical_timestamps(
            df,
            time_steps,
            max_frames=n_snapshots or _UNCAPPED_MAX_FRAMES,
            min_gap=min_gap,
            collision_timestep=collision_timestep,
            fill_uniform=n_snapshots is not None,
            include_proximity_heuristics=collision_trial,
        )

    if not picks:
        return picks

    if n_snapshots is not None and len(picks) > n_snapshots:
        start = picks[0]
        end = picks[-1]
        mid = [p for p in picks[1:-1]]
        if n_snapshots <= 1:
            return [start]
        if n_snapshots == 2:
            return [start, end]
        keep_mid = n_snapshots - 2
        picks = [start] + mid[:keep_mid] + [end]

    return picks


def pick_critical_timestamps(
    df: pd.DataFrame,
    time_steps: List[float],
    max_frames: Optional[int] = DEFAULT_N_SNAPSHOTS,
    min_gap: float = DEFAULT_MIN_FRAME_GAP_S,
    collision_timestep: Optional[float] = None,
    fill_uniform: Optional[bool] = None,
    include_proximity_heuristics: bool = True,
) -> List[Tuple[int, str]]:
    """
    Select action-like key times from esmini CSV (xosc_gen-style density).

    Events: start/end, closest approach, proximity, braking, road changes,
    optional collision, plus uniform mid-scenario fill.
    """
    n = len(time_steps)
    if n == 0:
        return []
    t_arr = np.asarray(time_steps, dtype=float)

    def idx_near(t: float) -> int:
        return int(np.argmin(np.abs(t_arr - t)))

    # (priority, index, label) — lower priority number = more important
    raw: List[Tuple[int, int, str]] = []

    def add(priority: int, idx: int, label: str) -> None:
        idx = max(0, min(n - 1, int(idx)))
        raw.append((priority, idx, label))

    add(0, 0, "start")
    add(100, n - 1, "end")

    names = {str(x).strip() for x in df["name"].unique() if str(x).strip()}
    ego_name = "Ego" if "Ego" in names else (sorted(names)[0] if names else None)
    others = sorted(nm for nm in names if nm != ego_name)
    # display_id is the number drawn on each car in the BEV image; label closest-
    # approach frames as "ID:<disp> <name>" so the title matches the on-image legend
    # ("ID:10 → Parking"). The "ID:" prefix makes clear that the number is the
    # display id, not the name's own numeric suffix (e.g. "BackgroundParking6").
    name_to_display = {a["name"]: a["display_id"] for a in build_agent_registry(df)}

    def _other_tag(nm: str) -> str:
        disp = name_to_display.get(nm)
        return f"ID:{disp} {nm}" if disp is not None else nm

    if ego_name:
        ego = df[df["name"].astype(str).str.strip() == ego_name].sort_values("time")
        ego_t = ego["time"].to_numpy(dtype=float)
        speed_col = "speed" if "speed" in ego.columns else None
        ego_speed = (
            ego[speed_col].astype(float).to_numpy()
            if speed_col
            else np.zeros(len(ego))
        )

        if len(ego_speed) > 1:
            imin = int(np.argmin(ego_speed))
            add(22, idx_near(float(ego_t[imin])), "ego_min_speed")

        if len(ego_t) > 2:
            dt = np.diff(ego_t)
            ds = np.diff(ego_speed)
            valid = dt > 1e-6
            if np.any(valid):
                decel = ds[valid] / dt[valid]
                worst = int(np.argmin(decel))
                t_evt = float(ego_t[np.where(valid)[0][worst] + 1])
                add(24, idx_near(t_evt), "ego_max_deceleration")

        # Turn apex = moment of maximum heading-rate (|dθ/dt|).
        if "h" in ego.columns and len(ego_t) > 2:
            h = np.unwrap(ego["h"].astype(float).to_numpy())
            dt_h = np.diff(ego_t)
            dh = np.diff(h)
            valid_h = dt_h > 1e-6
            if np.any(valid_h):
                rate = np.abs(dh[valid_h] / dt_h[valid_h])
                if rate.size and float(rate.max()) > 0.15:  # ~8.6°/s ⇒ real turn
                    apex = int(np.argmax(rate))
                    t_apex = float(ego_t[np.where(valid_h)[0][apex] + 1])
                    add(26, idx_near(t_apex), "ego_turn_apex")

        if "roadId" in ego.columns and len(ego) > 1:
            rid = ego["roadId"].fillna(0).astype(int).to_numpy()
            changes = np.where(np.diff(rid) != 0)[0]
            for j, ci in enumerate(changes[:3]):
                add(28 + j, idx_near(float(ego_t[ci + 1])), f"ego_road_change_{j + 1}")

        # Closest-approach heuristics (legacy fallback when action.yaml lacks interactions).
        if include_proximity_heuristics:
            approach: List[Tuple[float, float, str, bool]] = []
            for other_name in others:
                oth = (
                    df[df["name"].astype(str).str.strip() == other_name]
                    .sort_values("time")
                    .rename(columns={"x": "x_o", "y": "y_o", "speed": "speed_o"})
                )
                merged = pd.merge_asof(
                    ego.sort_values("time"),
                    oth.sort_values("time"),
                    on="time",
                    direction="nearest",
                    tolerance=0.06,
                )
                if merged.empty or "x" not in merged.columns or "x_o" not in merged.columns:
                    continue
                dist = np.hypot(
                    merged["x"].astype(float) - merged["x_o"].astype(float),
                    merged["y"].astype(float) - merged["y_o"].astype(float),
                ).to_numpy()
                if not dist.size:
                    continue
                imin_d = int(np.argmin(dist))
                t_ca = float(merged["time"].iloc[imin_d])
                moving = False
                if "speed_o" in merged.columns:
                    sp = pd.to_numeric(merged["speed_o"], errors="coerce").abs()
                    moving = float(sp.max() or 0.0) > 0.3
                approach.append((float(dist[imin_d]), t_ca, other_name, moving))

            approach.sort(key=lambda c: (not c[3], c[0]))
            n_added = 0
            for min_dist, t_ca, other_name, moving in approach:
                if min_dist > 30.0:
                    break
                if n_added >= 3:
                    break
                add(8 + n_added, idx_near(t_ca), f"ego closest to {_other_tag(other_name)}")
                n_added += 1
                if moving:
                    oth2 = (
                        df[df["name"].astype(str).str.strip() == other_name]
                        .sort_values("time")
                        .rename(columns={"x": "x_o", "y": "y_o"})
                    )
                    m2 = pd.merge_asof(
                        ego.sort_values("time"),
                        oth2.sort_values("time"),
                        on="time",
                        direction="nearest",
                        tolerance=0.06,
                    )
                    if not m2.empty and "x_o" in m2.columns:
                        d2 = np.hypot(
                            m2["x"].astype(float) - m2["x_o"].astype(float),
                            m2["y"].astype(float) - m2["y_o"].astype(float),
                        ).to_numpy()
                        close = np.where(d2 < 20.0)[0]
                        if len(close):
                            add(
                                16,
                                idx_near(float(m2["time"].iloc[int(close[0])])),
                                f"ego within 20m of {_other_tag(other_name)}",
                            )

    if collision_timestep is not None:
        add(5, idx_near(float(collision_timestep)), "collision")

    # Best label per index (lowest priority wins)
    by_idx: Dict[int, Tuple[int, str]] = {}
    for prio, idx, label in raw:
        if idx not in by_idx or prio < by_idx[idx][0]:
            by_idx[idx] = (prio, label)

    cap = max_frames if max_frames is not None else _UNCAPPED_MAX_FRAMES
    do_fill = fill_uniform if fill_uniform is not None else (
        max_frames is not None and max_frames < _UNCAPPED_MAX_FRAMES
    )

    ordered = sorted(by_idx.items(), key=lambda kv: time_steps[kv[0]])
    picked: List[Tuple[int, str]] = []
    last_t = -1e9
    for idx, (_prio, label) in ordered:
        t = time_steps[idx]
        if picked and (t - last_t) < min_gap:
            continue
        if len(picked) >= cap:
            break
        picked.append((idx, label))
        last_t = t

    # Uniform fill if still under budget (capped mode only)
    used = {idx for idx, _ in picked}
    if do_fill and len(picked) < cap and n > 2:
        need = cap - len(picked)
        for k in range(1, need + 1):
            t = t_arr[0] + (t_arr[-1] - t_arr[0]) * k / (need + 1)
            idx = idx_near(float(t))
            if idx in used:
                continue
            if picked and abs(t - time_steps[picked[-1][0]]) < min_gap:
                continue
            picked.append((idx, f"mid_{k}"))
            used.add(idx)
            if len(picked) >= cap:
                break

    picked.sort(key=lambda x: time_steps[x[0]])

    picked = [(i, lb) for i, lb in picked if i not in (0, n - 1)]
    picked.insert(0, (0, "start"))
    if n > 1:
        picked.append((n - 1, "end"))
    picked.sort(key=lambda x: time_steps[x[0]])
    # Trim to cap while keeping endpoints (capped mode only)
    if do_fill and len(picked) > cap:
        start = picked[0]
        end = picked[-1]
        mid = [p for p in picked[1:-1]]
        if cap <= 1:
            picked = [start]
        elif cap == 2:
            picked = [start, end]
        else:
            keep_mid = cap - 2
            picked = [start] + mid[:keep_mid] + [end]

    return picked


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
    """Road IDs used during the trial (for gray lane fill in MapPlotter)."""
    ids = set()
    if "roadId" in df.columns:
        for v in df["roadId"].dropna().unique():
            try:
                iv = int(v)
                if iv > 0:
                    ids.add(str(iv))
            except (TypeError, ValueError):
                pass
    return sorted(ids, key=int)


def unique_time_steps(df: pd.DataFrame) -> List[float]:
    """Sorted simulation timestamps from an esmini CSV."""
    return sorted(df["time"].unique().tolist())


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
        # Right panel of each snapshot zooms to ±radius metres around the ego.
        # 0/None disables the composite (whole-scene only).
        self.ego_zoom_radius = ego_zoom_radius
        if not Path(map_tracks_csv).is_file():
            raise FileNotFoundError(
                f"Map tracks CSV not found: {map_tracks_csv}\n"
                "Run: python3 scripts/generate_map_tracks.py"
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
        )
        print(f"[Tier2BevRenderer] Saved map overview {output_path}")
        return output_path

    def render_trial_from_esmini_csv(
        self,
        batch_id: int,
        trial_index: int,
        output_dir: str,
        n_snapshots: Optional[int] = None,
        collision_timestep: Optional[float] = None,
        file_prefix: Optional[str] = None,
        min_frame_gap_s: float = DEFAULT_ACTION_MIN_GAP_S,
        overview_dir: Optional[str] = None,
        action_yaml_path: Optional[str] = None,
        key_frame_mode: str = "hybrid",
        semantic_only: bool = False,
        collision_trial: bool = False,
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
            key_indices = resolve_key_frames(
                df,
                time_steps,
                action_yaml_path=action_yaml_path,
                key_frame_mode=key_frame_mode,
                min_gap=min_frame_gap_s,
                n_snapshots=n_snapshots,
                collision_timestep=collision_timestep,
                semantic_only=semantic_only,
                collision_trial=collision_trial,
            )
            highlight = highlight_road_ids_from_df(df)
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

            for rank, (idx, label) in enumerate(key_indices):
                t = time_steps[idx]
                slug = _slug_label(label)[:80]  # filesystem name-length safety
                out_path = os.path.join(
                    output_dir,
                    f"{prefix}_t_{t:05.2f}_{slug}.jpg",
                )
                self._render_snapshot(
                    out_path=out_path,
                    traj_csv=traj_csv,
                    meta_yaml=meta_yaml,
                    highlight=highlight,
                    vbounds=vbounds,
                    t=float(t),
                    label=label,
                    ego_xy=ego_xy_at(float(t)),
                    work=work,
                )
                snapshots.append(BevSnapshot(timestep=t, label=label, path=out_path))
                print(f"[Tier2BevRenderer] Saved {out_path}")
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
    ) -> None:
        self._plotter.render_scene(
            self.map_tracks_csv,
            out_path,
            highlight_road_ids_list=highlight,
            view_bounds=view_bounds,
            draw_labels=False,
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
    ) -> None:
        """Render a snapshot — dual-panel (whole + ego zoom) when enabled."""
        radius = self.ego_zoom_radius or 0.0
        if radius <= 0 or ego_xy is None:
            self._render_one_panel(
                out_path, traj_csv=traj_csv, meta_yaml=meta_yaml,
                highlight=highlight, view_bounds=vbounds, t=t,
                time_label=f"t = {t:.2f}s — {label}",
            )
            return

        ex, ey = ego_xy
        zoom_bounds = (ex - radius, ex + radius, ey - radius, ey + radius)
        full_tmp = str(work / "panel_full.jpg")
        zoom_tmp = str(work / "panel_zoom.jpg")
        self._render_one_panel(
            full_tmp, traj_csv=traj_csv, meta_yaml=meta_yaml,
            highlight=highlight, view_bounds=vbounds, t=t,
            time_label="whole scene",
        )
        self._render_one_panel(
            zoom_tmp, traj_csv=traj_csv, meta_yaml=meta_yaml,
            highlight=highlight, view_bounds=zoom_bounds, t=t,
            time_label=f"ego \u00b1{radius:.0f}m",
        )
        title = f"t = {t:.2f}s  \u2014  {label}"
        if not compose_dual_bev(full_tmp, zoom_tmp, out_path, title=title):
            # Pillow missing / panel failed → fall back to whole-scene only.
            self._render_one_panel(
                out_path, traj_csv=traj_csv, meta_yaml=meta_yaml,
                highlight=highlight, view_bounds=vbounds, t=t,
                time_label=f"t = {t:.2f}s — {label}",
            )

    def render_cluster_medoids(
        self,
        medoids: Dict[int, Tuple[int, int]],
        output_dir: str,
        n_snapshots: Optional[int] = None,
        dataset: Optional[str] = None,
        n_clusters: Optional[int] = None,
        key_frame_mode: str = "hybrid",
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
                    key_frame_mode=key_frame_mode,
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
