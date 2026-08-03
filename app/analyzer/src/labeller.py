#!/usr/bin/env python3
"""labeller.py — V1-4 / Step T-2: rule-based action classifier.

Reads a medoid `trajectory.csv` + `meta.yaml` (+ optional map YAML) and writes
`action.yaml`: per-agent sequences of ActionEvents from the gpl-odd taxonomy.

Map-agnostic: junction membership comes from the map YAML's `JunctionRoads`
list (produced by map_assets / app/analyzer/src/dataset_builder.py --map-only), so it works on the full hct_6
network rather than a single 4-way intersection.

Column compatibility: accepts both gpl-odd (`x`,`y`) and xosc_gen
(`world_x`,`world_y`) trajectory column names.

CLI:
  python3 app/analyzer/src/labeller.py \
      --traj results/dataset1/4/cluster0/trajectory.csv \
      --meta results/dataset1/4/cluster0/meta.yaml \
      --map  alldatasets/map/hct_6.yaml \
      --out  results/dataset1/4/cluster0/action.yaml
"""
from __future__ import annotations

import argparse
from pathlib import Path
from typing import Dict, List, Optional, Set

import numpy as np
import pandas as pd
import yaml

try:
    from taxonomy import (ActionEvent, EgoAction, InteractionAction, NpcAction,
                          Thresholds)
except ImportError:  # allow running as a module from repo root
    import sys

    sys.path.insert(0, str(Path(__file__).resolve().parent))
    from taxonomy import (ActionEvent, EgoAction, InteractionAction, NpcAction,
                          Thresholds)


def _normalize_columns(df: pd.DataFrame) -> pd.DataFrame:
    """Accept xosc_gen world_x/world_y aliases for x/y."""
    if "x" not in df.columns and "world_x" in df.columns:
        df = df.rename(columns={"world_x": "x", "world_y": "y"})
    return df


def _v_at(t: np.ndarray, v: np.ndarray, tt: float) -> float:
    """Velocity at the frame nearest to time ``tt``."""
    return float(v[int(np.argmin(np.abs(t - tt)))])


def _longitudinal_actions(t: np.ndarray, v: np.ndarray, road: np.ndarray,
                          lane: np.ndarray, agent_id: int, role: str) -> List[ActionEvent]:
    """Faithful port of xosc_gen ``label_longitudinal_actions`` (thesis §4.2).

    Three stages, step-for-step with xosc_gen:
      1. **Coarse pass** — per-frame acceleration ``a = Δv/Δt``; a sign band of
         ±``CRUISE_BAND`` (0.05 m/s²) labels each frame speed_up / slow_down /
         cruise. Maximal same-label runs are the coarse segments (cruise emits
         nothing — it is the implicit baseline).
      2. **Intensity sub-split** — inside each speed_up/slow_down run, a sliding
         look-back of ``MIN_CHANGE_DURATION`` splits the run when the mean accel of
         the established segment and the recent window differ by more than
         ``ACCEL_DEV_THRESHOLD`` (gentle decel → hard brake becomes two segments).
         The earlier segment ("A") is emitted as-is; only the **final** segment of
         each run is filtered by ``dur > MIN_EVENT_DURATION`` **and**
         ``|Δv| > MIN_DELTA_V`` (xosc_gen keeps A unconditionally).
      3. **Short-merge** — ``_merge_short_same_type`` (port of
         ``merge_short_actions``) re-merges same-type neighbours shorter than
         ``MERGE_SHORT_S`` with a duration-weighted mean acceleration.
    """
    n = len(t)
    if n < 2:
        return []
    # Light velocity smooth before frame accel labels. Raw esmini speed is noisy
    # enough that a real post-conflict recovery (Δv ≈ +8 m/s over ~15 s) shatters
    # into 1–3 frame ACC/DEC flickers and fails MIN_EVENT_DURATION. Window ≈0.7 s
    # at 0.1 s sampling; details still report speeds from the smoothed series so
    # start/target match the labelled interval.
    win = 7
    if n >= 3:
        pad = win // 2
        v_pad = np.pad(v.astype(float), (pad, pad), mode="edge")
        kernel = np.ones(win, dtype=float) / float(win)
        v_s = np.convolve(v_pad, kernel, mode="valid")
    else:
        v_s = v.astype(float)
    dt = np.diff(t)
    dv = np.diff(v_s)
    acc = np.divide(dv, dt, out=np.zeros_like(dv), where=dt != 0)
    labels = np.where(acc > Thresholds.CRUISE_BAND, EgoAction.ACCELERATE.value,
                      np.where(acc < -Thresholds.CRUISE_BAND,
                               EgoAction.DECELERATE.value, "cruise"))

    out: List[ActionEvent] = []

    def emit(a: int, b: int, action: str) -> None:
        dur = float(t[b] - t[a])
        v0, v1 = float(v_s[a]), float(v_s[b])
        out.append(ActionEvent(
            agent_id=agent_id, agent_role=role, action=str(action),
            start_time=float(t[a]), end_time=float(t[b]),
            road_id=int(road[a]), lane_id=int(lane[a]),
            detail={
                "start_speed": round(v0, 2),
                "target_speed": round(v1, 2),
                "delta_v": round(v1 - v0, 2),
                "acceleration": round((v1 - v0) / dur, 3) if dur > 0 else 0.0,
            },
        ))

    m = len(labels)  # = n - 1
    start = 0
    while start < m:
        cur = labels[start]
        end = start
        while end + 1 < m and labels[end + 1] == cur:
            end += 1
        if cur != "cruise":
            scan = start
            for k in range(start + 1, end + 1):
                new_start = t[k] - Thresholds.MIN_CHANGE_DURATION
                if new_start <= t[scan]:
                    continue
                split = int(np.searchsorted(t, new_start, side="left"))
                if split <= scan:
                    continue
                dur_a = t[split] - t[scan]
                dur_b = t[k] - t[split]
                if dur_a > Thresholds.MIN_EVENT_DURATION and dur_b > 0:
                    acc_a = (v_s[split] - v_s[scan]) / dur_a
                    acc_b = (v_s[k] - v_s[split]) / dur_b
                    if abs(acc_a - acc_b) > Thresholds.ACCEL_DEV_THRESHOLD:
                        emit(scan, split, cur)  # segment A — xosc keeps it as-is
                        scan = split
            final_end = end + 1  # one past the last frame of the run
            f_dur = t[final_end] - t[scan]
            f_dv = v_s[final_end] - v_s[scan]
            if f_dur > Thresholds.MIN_EVENT_DURATION and abs(f_dv) > Thresholds.MIN_DELTA_V:
                emit(scan, final_end, cur)
        start = end + 1

    out = _merge_short_same_type(out, t, v_s, Thresholds.MERGE_SHORT_S)

    # Ours (additive): a slow_down whose mean accel ≤ EMERGENCY_DECEL is an
    # emergency brake — relabel without changing xosc's segmentation.
    for ev in out:
        if (ev.action == EgoAction.DECELERATE.value
                and ev.detail.get("acceleration", 0.0) <= Thresholds.EMERGENCY_DECEL):
            ev.action = EgoAction.EMERGENCY_BRAKE.value
    return out


def _stopped_actions(t: np.ndarray, v: np.ndarray, road: np.ndarray,
                     lane: np.ndarray, agent_id: int, role: str) -> List[ActionEvent]:
    """Ours (additive, no xosc equivalent): emit a STOPPED event for every
    sustained near-zero-speed interval (``speed < STOPPED_SPEED`` for
    ``≥ STOPPED_MIN_DURATION``). Stops are invisible to the longitudinal sign
    pass (their acceleration is ~0 ⇒ cruise), so they are detected separately."""
    n = len(t)
    out: List[ActionEvent] = []
    stopped = v < Thresholds.STOPPED_SPEED
    i = 0
    while i < n:
        if not stopped[i]:
            i += 1
            continue
        j = i
        while j + 1 < n and stopped[j + 1]:
            j += 1
        if float(t[j] - t[i]) >= Thresholds.STOPPED_MIN_DURATION:
            out.append(ActionEvent(
                agent_id=agent_id, agent_role=role, action=EgoAction.STOPPED.value,
                start_time=float(t[i]), end_time=float(t[j]),
                road_id=int(road[i]), lane_id=int(lane[i]),
                detail={"speed": round(float(v[i]), 2)},
            ))
        i = j + 1
    return out


def _merge_two_long(a: ActionEvent, b: ActionEvent, t: np.ndarray, v: np.ndarray) -> ActionEvent:
    """Merge same-type longitudinal events ``a`` (earlier) and ``b`` (later),
    re-deriving start/target speed and a duration-weighted mean acceleration."""
    a.end_time = b.end_time
    v0, v1 = _v_at(t, v, a.start_time), _v_at(t, v, a.end_time)
    dur = a.end_time - a.start_time
    a.detail = {
        "start_speed": round(v0, 2),
        "target_speed": round(v1, 2),
        "delta_v": round(v1 - v0, 2),
        "acceleration": round((v1 - v0) / dur, 3) if dur > 0 else 0.0,
    }
    return a


def _merge_short_same_type(events: List[ActionEvent], t: np.ndarray, v: np.ndarray,
                           threshold: float) -> List[ActionEvent]:
    """Re-merge same-type neighbours shorter than ``threshold`` — port of
    xosc_gen ``merge_short_actions``. When both neighbours match, merge into the
    one with the closer mean acceleration."""
    actions = list(events)
    while True:
        merged_any = False
        i = 0
        while i < len(actions):
            ev = actions[i]
            if ev.action == EgoAction.STOPPED.value or ev.duration >= threshold:
                i += 1
                continue
            prev = actions[i - 1] if i > 0 else None
            nxt = actions[i + 1] if i < len(actions) - 1 else None
            prev_same = prev is not None and prev.action == ev.action
            next_same = nxt is not None and nxt.action == ev.action
            target = None
            if prev_same and next_same:
                ac = ev.detail.get("acceleration", 0.0)
                if abs(ac - prev.detail.get("acceleration", 0.0)) <= abs(ac - nxt.detail.get("acceleration", 0.0)):
                    target = "prev"
                else:
                    target = "next"
            elif prev_same:
                target = "prev"
            elif next_same:
                target = "next"

            if target == "prev":
                actions[i - 1] = _merge_two_long(prev, ev, t, v)
                actions.pop(i)
                merged_any = True
                break
            if target == "next":
                actions[i] = _merge_two_long(ev, nxt, t, v)
                actions.pop(i + 1)
                merged_any = True
                break
            i += 1
        if not merged_any:
            break
    return actions


def _overlaps_lane_change(
    t0: float, t1: float, lane_changes: List[ActionEvent], *, frac: float = 0.5
) -> bool:
    """True if [t0,t1] substantially overlaps a LANE_CHANGE interval."""
    dur = max(1e-6, t1 - t0)
    for lc in lane_changes:
        ov = min(t1, lc.end_time) - max(t0, lc.start_time)
        if ov >= frac * dur:
            return True
    return False


def _same_lane_turn_actions(
    df: pd.DataFrame,
    agent_id: int,
    role: str,
    lane_changes: List[ActionEvent],
) -> List[ActionEvent]:
    """Route-level same-lane TURN_LEFT / TURN_RIGHT from heading arcs.

    Complements junction ``ENTER_JUNCTION.intent`` (40° threshold): here a
    sustained |Δheading| ≥ ``SAME_LANE_TURN_DEG`` on a fixed road/lane is enough
    (swerve around parked traffic, follow road curvature). Overlaps with
    ``LANE_CHANGE_*`` are skipped — those already encode lateral intent.
    """
    try:
        from kinematics_context import detect_heading_sweeps
    except ImportError:  # pragma: no cover
        return []

    sweeps = detect_heading_sweeps(
        df,
        track_id=agent_id,
        min_deg=Thresholds.SAME_LANE_TURN_DEG,
        min_s=Thresholds.SAME_LANE_TURN_MIN_S,
    )
    out: List[ActionEvent] = []
    for sw in sweeps:
        if _overlaps_lane_change(sw.t0, sw.t1, lane_changes):
            continue
        action = (
            EgoAction.TURN_LEFT.value
            if sw.direction == "LEFT"
            else EgoAction.TURN_RIGHT.value
        )
        out.append(
            ActionEvent(
                agent_id=agent_id,
                agent_role=role,
                action=action,
                start_time=float(sw.t0),
                end_time=float(sw.t1),
                road_id=int(sw.road_id if sw.road_id is not None else 0),
                lane_id=int(sw.lane_id if sw.lane_id is not None else 0),
                detail={
                    "scope": "same_lane",
                    "heading_change_deg": float(sw.delta_deg),
                    "heading_start_deg": float(sw.hdg0_deg),
                    "heading_end_deg": float(sw.hdg1_deg),
                    "vs_path_start_deg": sw.vs_path0_deg,
                    "vs_path_end_deg": sw.vs_path1_deg,
                    "path_tangent_start_deg": sw.path_tangent0_deg,
                    "path_tangent_end_deg": sw.path_tangent1_deg,
                },
            )
        )
    return out


def _agent_speed_actions(df: pd.DataFrame, junction_roads: Set[int]) -> List[ActionEvent]:
    """Classify longitudinal + junction transitions frame-by-frame for one agent."""
    df = df.sort_values("time").reset_index(drop=True)
    if len(df) < 2:
        return []

    t = df["time"].to_numpy(dtype=float)
    v = df["velocity"].to_numpy(dtype=float)
    x = df["x"].to_numpy(dtype=float)
    y = df["y"].to_numpy(dtype=float)
    road = df["road_id"].to_numpy(dtype=int)
    lane = df["lane_id"].to_numpy(dtype=int)
    head = (df["heading"].to_numpy(dtype=float)
            if "heading" in df.columns else np.zeros(len(df)))
    # Also accept track_id-only frames (after rename) for agent id lookup.
    agent_id = int(
        df["trackId"].iloc[0]
        if "trackId" in df.columns
        else df["track_id"].iloc[0]
    )
    role = "ego" if agent_id == 0 else "npc"

    # --- Longitudinal (xosc port) + sustained STOPPED (ours) --------------
    long_events = _longitudinal_actions(t, v, road, lane, agent_id, role)
    long_events += _stopped_actions(t, v, road, lane, agent_id, role)

    # --- Lateral: lane changes with a maneuver duration window (xosc_gen) -
    # A lane change is a *sustained* lane_id change on the same road; the maneuver
    # is grown to the surrounding stable lanes and filtered/capped to
    # [LANE_CHANGE_MIN_S, LANE_CHANGE_MAX_S]. esmini/OpenDRIVE convention:
    # increasing lane_id ⇒ moving left. NOTE: xosc_gen requires |Δlane| == 1, but
    # OpenDRIVE reserves lane 0 for the reference line, so a cross-centerline
    # change here is Δ == 2 — we therefore trigger on any change, not just ±1.
    discrete: List[ActionEvent] = []
    n = len(df)
    for i in range(n - 2):
        if int(lane[i + 1]) == int(lane[i]):
            continue
        if int(road[i]) != int(road[i + 1]):
            continue
        sustained = (lane[i + 2] == lane[i + 1]) and (i == 0 or lane[i - 1] == lane[i])
        if not sustained:
            continue
        start_index = i
        while (start_index > 0 and lane[start_index] == lane[start_index - 1]
               and road[start_index - 1] == road[i]):
            start_index -= 1
        end_index = i + 1
        while (end_index + 1 < n and lane[end_index] == lane[end_index + 1]
               and road[end_index + 1] == road[i]):
            end_index += 1
        duration = float(t[end_index] - t[start_index])
        direction = (EgoAction.LANE_CHANGE_LEFT if lane[end_index] > lane[start_index]
                     else EgoAction.LANE_CHANGE_RIGHT)
        if Thresholds.LANE_CHANGE_MIN_S <= duration <= Thresholds.LANE_CHANGE_MAX_S:
            st, en = max(0.0, float(t[start_index])), float(t[end_index])
        elif duration > Thresholds.LANE_CHANGE_MAX_S:
            st = max(0.0, float(t[i]) - Thresholds.LANE_CHANGE_MAX_S / 2.0)
            en = st + Thresholds.LANE_CHANGE_MAX_S
        else:
            continue  # too short ⇒ spurious flicker, discard
        dir_word = "left" if direction == EgoAction.LANE_CHANGE_LEFT else "right"
        discrete.append(ActionEvent(
            agent_id=agent_id, agent_role=role, action=direction.value,
            start_time=st, end_time=en, road_id=int(road[i]), lane_id=int(lane[end_index]),
            detail={
                "from_lane": int(lane[start_index]),
                "to_lane": int(lane[end_index]),
                "target_lane": int(lane[end_index]),  # xosc parity
                "direction": dir_word,                # xosc parity
            },
        ))

    # --- Route: same-lane TURN_LEFT / TURN_RIGHT (heading arcs, ≥15°) ------
    lane_changes = [
        e for e in discrete
        if e.action in (EgoAction.LANE_CHANGE_LEFT.value, EgoAction.LANE_CHANGE_RIGHT.value)
    ]
    discrete += _same_lane_turn_actions(df, agent_id, role, lane_changes)

    # --- Route: one ENTER (with turn intent) + one EXIT per junction pass -
    # heading is in degrees (esmini CCW); +Δ ⇒ left, −Δ ⇒ right.
    if junction_roads:
        in_junc = np.array([int(r) in junction_roads for r in road])
        n = len(road)
        i = 0
        while i < n:
            if in_junc[i]:
                j = i
                while j + 1 < n and in_junc[j + 1]:
                    j += 1
                t_enter, t_exit = float(t[i]), float(t[j])
                approach_idx = max(0, i - 1)
                exit_idx = min(n - 1, j + 1)
                # xosc no-move skip: ignore a "passage" with negligible displacement
                # (e.g. an agent parked on a connecting road for the whole window).
                if float(np.hypot(x[exit_idx] - x[approach_idx],
                                  y[exit_idx] - y[approach_idx])) < Thresholds.ROUTE_MIN_DISP:
                    i = j + 1
                    continue
                dtheta = ((head[exit_idx] - head[approach_idx] + 180.0) % 360.0) - 180.0
                if dtheta > Thresholds.TURN_HEADING_DEG:
                    intent = EgoAction.TURN_LEFT.value
                elif dtheta < -Thresholds.TURN_HEADING_DEG:
                    intent = EgoAction.TURN_RIGHT.value
                else:
                    intent = EgoAction.GO_STRAIGHT.value
                discrete.append(ActionEvent(
                    agent_id=agent_id, agent_role=role, action=EgoAction.ENTER_JUNCTION.value,
                    start_time=t_enter, end_time=t_enter,
                    road_id=int(road[i]), lane_id=int(lane[i]),
                    detail={
                        "intent": intent,
                        "entry_road": int(road[approach_idx]),
                        "exit_road": int(road[exit_idx]),
                        "heading_change_deg": round(float(dtheta), 1),
                    },
                ))
                if t_exit > t_enter:
                    discrete.append(ActionEvent(
                        agent_id=agent_id, agent_role=role, action=EgoAction.EXIT_JUNCTION.value,
                        start_time=t_exit, end_time=t_exit,
                        road_id=int(road[exit_idx]), lane_id=int(lane[exit_idx]),
                        detail={"exit_road": int(road[exit_idx]), "exit_lane": int(lane[exit_idx])},
                    ))
                i = j + 1
            else:
                i += 1

    return long_events + discrete


def _classify_npc_relation(
    ego: pd.DataFrame, npc: pd.DataFrame
) -> str:
    """Coarse relationship label for an NPC relative to the ego over the trial."""
    if (npc["velocity"] < Thresholds.STOPPED_SPEED).all():
        return NpcAction.PARKED.value

    # Align on shared timestamps.
    merged = pd.merge(
        ego[["time", "x", "y", "heading"]],
        npc[["time", "x", "y", "heading", "velocity"]],
        on="time", suffixes=("_e", "_n"),
    )
    if merged.empty:
        return NpcAction.IRRELEVANT.value

    gap = np.hypot(merged["x_e"] - merged["x_n"], merged["y_e"] - merged["y_n"])
    min_gap = float(gap.min())
    dh = np.abs(((merged["heading_e"] - merged["heading_n"] + np.pi) % (2 * np.pi)) - np.pi)
    oncoming_frac = float((dh > Thresholds.ONCOMING_HEADING).mean())

    if min_gap > Thresholds.NEAR_GAP:
        return NpcAction.IRRELEVANT.value
    if oncoming_frac > 0.5:
        return NpcAction.ONCOMING.value
    # Same direction & close ⇒ following; if it slows hard near ego ⇒ yielding.
    if min_gap < Thresholds.FOLLOW_GAP:
        if (merged["velocity"].min() < Thresholds.STOPPED_SPEED):
            return NpcAction.YIELD_TO_EGO.value
        return NpcAction.FOLLOWING_EGO.value
    return NpcAction.CROSSING.value


def detect_interactions(df: pd.DataFrame) -> List[Dict]:
    """Interactive Action Detector — composite, multi-agent labels (V1-5).

    Reads the full multi-agent trajectory (all trackIds) and emits ego-relative
    interaction events that single-agent kinematics cannot express:

      * NEAR_MISS         — TTC < 2.5 s while ego–NPC distance is decreasing.
                            Key timestamp = moment of absolute minimum distance.
      * DANGEROUS_CUT_IN  — an NPC changes into the ego's lane and the ego is
                            forced into a sharp deceleration within 2 s.

    Each event records the peak-intensity timestamp so the BEV/keyframe layer can
    snapshot the exact conflict moment.
    """
    events: List[Dict] = []
    ego = df[df["trackId"] == 0].sort_values("time").reset_index(drop=True)
    if ego.empty:
        return events
    ego_t = ego["time"].to_numpy(dtype=float)

    # Ego longitudinal acceleration (for cut-in reaction test).
    ego_v = ego["velocity"].to_numpy(dtype=float)
    if len(ego_t) > 1:
        ego_acc = np.gradient(ego_v, ego_t)
    else:
        ego_acc = np.zeros(len(ego_t))

    def ego_min_accel(t0: float, t1: float) -> Optional[float]:
        mask = (ego_t >= t0) & (ego_t <= t1)
        return float(ego_acc[mask].min()) if mask.any() else None

    for tid in sorted(int(x) for x in df["trackId"].unique() if int(x) != 0):
        npc = df[df["trackId"] == tid].sort_values("time").reset_index(drop=True)
        if len(npc) < 2:
            continue
        # A near miss requires a *moving* partner. Parked / background cars the
        # ego merely drives past are not conflicts (they otherwise spam one
        # NEAR_MISS each, which also pollutes BEV keyframe selection).
        npc_moving = float(npc["velocity"].abs().max()) > Thresholds.STOPPED_SPEED
        merged = pd.merge_asof(
            ego[["time", "x", "y", "road_id", "lane_id"]].sort_values("time"),
            npc[["time", "x", "y", "road_id", "lane_id"]].sort_values("time")
            .rename(columns={"x": "x_n", "y": "y_n",
                             "road_id": "road_n", "lane_id": "lane_n"}),
            on="time", direction="nearest", tolerance=0.06,
        ).dropna(subset=["x_n"])
        if len(merged) < 2:
            continue

        tt = merged["time"].to_numpy(dtype=float)
        dist = np.hypot(merged["x"].to_numpy(float) - merged["x_n"].to_numpy(float),
                        merged["y"].to_numpy(float) - merged["y_n"].to_numpy(float))
        ddt = np.gradient(dist, tt)
        closing = -ddt  # >0 ⇒ approaching
        ttc = np.where(closing > 1e-3, dist / np.maximum(closing, 1e-3), np.inf)

        # --- NEAR_MISS ---------------------------------------------------
        nm_mask = (ttc < Thresholds.TTC_NEAR_MISS) & (closing > 0)
        if npc_moving and nm_mask.any():
            i_md = int(np.argmin(dist))  # absolute minimum distance = key frame
            events.append({
                "type": InteractionAction.NEAR_MISS.value,
                "with_track_id": tid,
                "key_time": round(float(tt[i_md]), 2),
                "min_distance_m": round(float(dist[i_md]), 2),
                "min_ttc_s": round(float(np.min(ttc[nm_mask])), 2),
            })

        # --- DANGEROUS_CUT_IN --------------------------------------------
        road_n = merged["road_n"].to_numpy(float)
        lane_n = merged["lane_n"].to_numpy(float)
        road_e = merged["road_id"].to_numpy(float)
        lane_e = merged["lane_id"].to_numpy(float)
        for k in range(1, len(merged)):
            npc_changed_lane = (lane_n[k] != lane_n[k - 1])
            into_ego_lane = (road_n[k] == road_e[k] and lane_n[k] == lane_e[k])
            if npc_changed_lane and into_ego_lane and dist[k] < Thresholds.NEAR_GAP:
                t_cut = float(tt[k])
                amin = ego_min_accel(t_cut, t_cut + Thresholds.CUT_IN_REACTION_S)
                if amin is not None and amin <= Thresholds.CUT_IN_DECEL:
                    i_md = int(np.argmin(dist))
                    events.append({
                        "type": InteractionAction.DANGEROUS_CUT_IN.value,
                        "with_track_id": tid,
                        "key_time": round(float(tt[i_md]), 2),
                        "cut_in_time": round(t_cut, 2),
                        "ego_reaction_accel": round(float(amin), 2),
                        "min_distance_m": round(float(dist.min()), 2),
                    })
                    break  # one cut-in per NPC is enough

    return events


def label_trajectory(
    traj_path: Path,
    meta_path: Path,
    map_path: Optional[Path] = None,
    *,
    esmini_df: Optional[pd.DataFrame] = None,
    trial_events: Optional[List[dict]] = None,
    collided: bool = False,
    contact_clearance_m: float = Thresholds.CONTACT_CLEARANCE_M,
    conflict_relevance_m: float = Thresholds.CONFLICT_RELEVANCE_M,
) -> Dict:
    """Return the action.yaml dict for a medoid trajectory."""
    df = _normalize_columns(pd.read_csv(traj_path))
    with open(meta_path) as f:
        meta = yaml.safe_load(f)

    junction_roads: Set[int] = set()
    if map_path and Path(map_path).is_file():
        with open(map_path) as f:
            map_data = yaml.safe_load(f) or {}
        junction_roads = {int(r) for r in map_data.get("JunctionRoads", [])}

    ego_df = df[df["trackId"] == 0].sort_values("time").reset_index(drop=True)

    agents_out = []
    for agent in meta.get("agents", []):
        tid = int(agent["track_id"])
        adf = df[df["trackId"] == tid].sort_values("time").reset_index(drop=True)
        if adf.empty:
            continue
        events = _agent_speed_actions(adf, junction_roads)
        entry = {
            "track_id": tid,
            "name": agent.get("name", f"agent_{tid}"),
            "type": agent.get("class", "car"),
            "role": "ego" if tid == 0 else "npc",
            "enter_time": round(float(adf["time"].iloc[0]), 2),
            "exit_time": round(float(adf["time"].iloc[-1]), 2),
            "initial_speed": round(float(adf["velocity"].iloc[0]), 2),
            "actions": [e.to_dict() for e in sorted(events, key=lambda e: e.start_time)],
        }
        if tid != 0 and not ego_df.empty:
            entry["relation_to_ego"] = _classify_npc_relation(ego_df, adf)
        agents_out.append(entry)

    interactions = detect_interactions(df)

    if esmini_df is not None and not esmini_df.empty:
        from collision_partner import augment_interactions

        interactions = augment_interactions(
            interactions,
            esmini_df,
            meta.get("agents", []),
            trial_events=trial_events,
            collided=collided,
            contact_clearance_m=contact_clearance_m,
            conflict_relevance_m=conflict_relevance_m,
        )
        from collision_partner import inject_collision_agent_actions

        inject_collision_agent_actions(agents_out, interactions)
    else:
        track_to_name = {
            int(ag["track_id"]): str(ag.get("name", f"agent_{ag['track_id']}"))
            for ag in meta.get("agents", [])
        }
        interactions = [
            {**iv, "with_name": track_to_name.get(int(iv["with_track_id"]), f"track {iv['with_track_id']}")}
            if iv.get("with_track_id") is not None
            else iv
            for iv in interactions
        ]

    return {
        "dataset": meta.get("dataset"),
        "location": meta.get("location"),
        "duration": meta.get("duration"),
        "junction_aware": bool(junction_roads),
        "agents": agents_out,
        "interactions": interactions,
    }


def save_action_yaml(action_data: Dict, out_path: Path) -> None:
    out_path.parent.mkdir(parents=True, exist_ok=True)
    with out_path.open("w") as f:
        yaml.safe_dump(action_data, f, sort_keys=False)


def main() -> int:
    ap = argparse.ArgumentParser(description="Rule-based action labeller (V1-4)")
    ap.add_argument("--traj", required=True)
    ap.add_argument("--meta", required=True)
    ap.add_argument("--map", default=None)
    ap.add_argument("--out", required=True)
    args = ap.parse_args()

    data = label_trajectory(Path(args.traj), Path(args.meta),
                            Path(args.map) if args.map else None)
    save_action_yaml(data, Path(args.out))
    n = sum(len(a["actions"]) for a in data["agents"])
    print(f"✓ wrote {args.out}  ({len(data['agents'])} agents, {n} action events)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
