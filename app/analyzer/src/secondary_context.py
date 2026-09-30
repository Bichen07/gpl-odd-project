"""Deterministic secondary-vehicle and full-trial continuation context (A1/A2).

Builds compact evidence blocks for medoid and parameter-space pair LLM context:
secondary obstacles, post-conflict continuation, trajectory-shape summaries, and
candidate control-reason hints.
"""
from __future__ import annotations

import math
import re
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any, Dict, List, Optional, Sequence, Tuple

import numpy as np
import pandas as pd
import yaml

from agent_labels import display_agent_name, normalize_vehicle_schema

# --- A1 inclusion gates (named constants, not LLM decisions) ---
SECONDARY_DISTANCE_GATE_M = 40.0
PATH_CORRIDOR_ALONG_ROUTE_M = 60.0
PATH_CORRIDOR_LATERAL_M = 4.0
MAX_SECONDARY_OBJECTS = 2
MAX_STAMPS_PER_SECONDARY = 5
DECEL_DV_THRESHOLD_MPS = 0.5
DECEL_WINDOW_S = 0.5
STATIONARY_SPEED_EPS = 0.3
POST_PASS_DECEL_THRESHOLD_MPS2 = 1.0


@dataclass
class SecondaryAgent:
    track_id: int
    name: str
    inclusion_rules: List[str] = field(default_factory=list)
    stationary: bool = False


def _normalize_traj_df(df: pd.DataFrame) -> pd.DataFrame:
    from conflict_frame_selector import _normalize_traj_df as _norm

    return _norm(df)


def _agent_name_map(action_data: Optional[Dict[str, Any]]) -> Dict[int, str]:
    from conflict_frame_selector import _agent_name_map as _map

    return _map(action_data)


def _pair_series(df: pd.DataFrame, vehicle_tid: int) -> Optional[pd.DataFrame]:
    from conflict_frame_selector import _pair_series as _ps

    return _ps(df, vehicle_tid)


def _metrics_at(
    series: Optional[pd.DataFrame],
    t: float,
    vehicle_name: str,
    vehicle_tid: Optional[int],
    *,
    source_df: Optional[pd.DataFrame] = None,
) -> Dict[str, Any]:
    from conflict_frame_selector import _metrics_at as _ma

    return _ma(series, t, vehicle_name, vehicle_tid, source_df=source_df)


def _heading_to_rad(h: float) -> float:
    from conflict_frame_selector import _heading_to_rad as _h

    return _h(h)


def ego_frame_xy(ego_x, ego_y, ego_h_rad, px, py):
    from conflict_frame_selector import ego_frame_xy as _ef

    return _ef(ego_x, ego_y, ego_h_rad, px, py)


def format_side_metric_bits(**kwargs) -> List[str]:
    from conflict_frame_selector import format_side_metric_bits as _fmt

    return _fmt(**kwargs)


def _load_action(path: Optional[Path]) -> Optional[Dict[str, Any]]:
    if path is None or not Path(path).is_file():
        return None
    try:
        with Path(path).open(encoding="utf-8") as fh:
            return normalize_vehicle_schema(yaml.safe_load(fh) or {})
    except Exception:
        return None


def _ego_row_at(df: pd.DataFrame, t: float) -> Optional[pd.Series]:
    ego = df[df["trackId"] == 0]
    if ego.empty:
        return None
    tt = ego["time"].to_numpy(dtype=float)
    i = int(np.argmin(np.abs(tt - float(t))))
    return ego.iloc[i]


def _agent_row_at(df: pd.DataFrame, tid: int, t: float) -> Optional[pd.Series]:
    sub = df[df["trackId"] == int(tid)]
    if sub.empty:
        return None
    tt = sub["time"].to_numpy(dtype=float)
    i = int(np.argmin(np.abs(tt - float(t))))
    return sub.iloc[i]


def _center_distance(df: pd.DataFrame, tid: int, t: float) -> Optional[float]:
    er = _ego_row_at(df, t)
    ar = _agent_row_at(df, tid, t)
    if er is None or ar is None:
        return None
    return float(
        math.hypot(float(ar["x"]) - float(er["x"]), float(ar["y"]) - float(er["y"]))
    )


def _is_stationary(df: pd.DataFrame, tid: int) -> bool:
    sub = df[df["trackId"] == int(tid)]
    if sub.empty or "velocity" not in sub.columns:
        return False
    return float(sub["velocity"].abs().max()) < STATIONARY_SPEED_EPS


def _decel_event_times(df: pd.DataFrame) -> List[float]:
    ego = df[df["trackId"] == 0].sort_values("time")
    if ego.empty or "velocity" not in ego.columns:
        return []
    times: List[float] = []
    tt = ego["time"].to_numpy(dtype=float)
    vv = ego["velocity"].to_numpy(dtype=float)
    for i in range(1, len(tt)):
        dt = float(tt[i] - tt[i - 1])
        if dt < 0.05 or dt > 2.0:
            continue
        dv = float(vv[i] - vv[i - 1])
        if dv <= -DECEL_DV_THRESHOLD_MPS and dt <= DECEL_WINDOW_S + 0.05:
            times.append(float(tt[i]))
    return sorted(set(round(t, 2) for t in times))


def _in_forward_corridor(
    df: pd.DataFrame, tid: int, t: float, *, along_m: float, lateral_m: float
) -> bool:
    er = _ego_row_at(df, t)
    ar = _agent_row_at(df, tid, t)
    if er is None or ar is None:
        return False
    eh = _heading_to_rad(float(er["heading"]))
    fwd, left = ego_frame_xy(
        float(er["x"]), float(er["y"]), eh, float(ar["x"]), float(ar["y"])
    )
    return 0.0 < fwd <= along_m and abs(left) <= lateral_m


def _agents_within_gate(df: pd.DataFrame, t: float, gate_m: float) -> List[int]:
    out: List[int] = []
    for tid in sorted(int(x) for x in df["trackId"].unique() if int(x) != 0):
        d = _center_distance(df, tid, t)
        if d is not None and d <= gate_m:
            out.append(tid)
    return out


def _collision_partners(action_data: Optional[Dict[str, Any]]) -> List[Tuple[str, float, Optional[int]]]:
    if not action_data:
        return []
    id_to_name = _agent_name_map(action_data)
    out: List[Tuple[str, float, Optional[int]]] = []
    for agent in action_data.get("agents") or []:
        tid = agent.get("track_id")
        for act in agent.get("actions") or []:
            if str(act.get("action")) != "COLLISION":
                continue
            attrs = act.get("attributes") or {}
            partner = attrs.get("with_name") or id_to_name.get(tid)
            st = act.get("start_time", act.get("end_time"))
            if st is None:
                continue
            out.append((str(partner), float(st), tid if isinstance(tid, int) else None))
    return out


def _tid_for_name(df: pd.DataFrame, action_data: Optional[Dict[str, Any]], name: str) -> Optional[int]:
    id_to_name = _agent_name_map(action_data)
    rev = {v: k for k, v in id_to_name.items()}
    if name in rev:
        return int(rev[name])
    for tid in df["trackId"].unique():
        if int(tid) == 0:
            continue
        sub = df[df["trackId"] == int(tid)]
        if not sub.empty and "name" in sub.columns:
            if str(sub["name"].iloc[0]) == name:
                return int(tid)
    return None


def select_secondary_agents(
    traj_df: Optional[pd.DataFrame],
    action_data: Optional[Dict[str, Any]],
    *,
    primary_tid: Optional[int],
    primary_name: str,
    peak_t: Optional[float],
    t_min: Optional[float] = None,
    t_max: Optional[float] = None,
) -> List[SecondaryAgent]:
    if traj_df is None or traj_df.empty or primary_tid is None:
        return []
    df = _normalize_traj_df(traj_df)
    t0 = float(t_min) if t_min is not None else float(df["time"].min())
    t1 = float(t_max) if t_max is not None else float(df["time"].max())
    eval_times: List[float] = [t0]
    if peak_t is not None:
        eval_times.append(float(peak_t))
    eval_times.extend(t for t in _decel_event_times(df) if t0 <= t <= t1)
    eval_times = sorted(set(round(t, 2) for t in eval_times))

    picked: Dict[int, SecondaryAgent] = {}
    primary_name_disp = display_agent_name(primary_name)

    def _add(tid: int, rule: str) -> None:
        if tid == 0 or tid == int(primary_tid):
            return
        id_to_name = _agent_name_map(action_data)
        name = display_agent_name(id_to_name.get(tid, f"agent{tid}"))
        if tid not in picked:
            picked[tid] = SecondaryAgent(
                track_id=tid,
                name=name,
                inclusion_rules=[rule],
                stationary=_is_stationary(df, tid),
            )
        elif rule not in picked[tid].inclusion_rules:
            picked[tid].inclusion_rules.append(rule)

    for t in eval_times:
        for tid in _agents_within_gate(df, t, SECONDARY_DISTANCE_GATE_M):
            _add(tid, f"within_{int(SECONDARY_DISTANCE_GATE_M)}m_at_t={t:.2f}s")

    for partner, ct, _ in _collision_partners(action_data):
        tid = _tid_for_name(df, action_data, partner)
        if tid is not None:
            _add(tid, f"collision_partner_at_t={ct:.2f}s")

    for t in eval_times:
        for tid in sorted(int(x) for x in df["trackId"].unique() if int(x) != 0):
            if _in_forward_corridor(
                df, tid, t, along_m=PATH_CORRIDOR_ALONG_ROUTE_M, lateral_m=PATH_CORRIDOR_LATERAL_M
            ):
                _add(tid, f"forward_corridor_at_t={t:.2f}s")

    if not picked:
        return []

    def _rank_key(agent: SecondaryAgent) -> Tuple[float, float, float]:
        col_tid = [
            t
            for partner, t, _ in _collision_partners(action_data)
            if display_agent_name(partner) == agent.name
        ]
        is_collision = 0.0 if col_tid else 1.0
        min_clear = 999.0
        min_post = 999.0
        series = _pair_series(df, agent.track_id)
        if series is not None:
            peak = float(peak_t) if peak_t is not None else t0
            post = series[series["time"] >= peak - 0.01]
            if not post.empty and "dist" in post.columns:
                min_post = float(post["dist"].min())
            for t in _decel_event_times(df):
                m = _metrics_at(series, t, agent.name, agent.track_id, source_df=df)
                c = m.get("clearance_m")
                if c is not None:
                    min_clear = min(min_clear, float(c))
        return (is_collision, min_clear, min_post)

    ranked = sorted(picked.values(), key=_rank_key)[:MAX_SECONDARY_OBJECTS]
    return ranked


def _secondary_stamp_times(
    df: pd.DataFrame,
    agent: SecondaryAgent,
    *,
    peak_t: Optional[float],
    action_data: Optional[Dict[str, Any]],
) -> List[float]:
    stamps: List[float] = []
    series = _pair_series(df, agent.track_id)
    if series is None:
        return stamps
    tt = series["time"].to_numpy(dtype=float)
  # enter 40m range
    for i, t in enumerate(tt):
        if float(series["dist"].iloc[i]) <= SECONDARY_DISTANCE_GATE_M:
            stamps.append(float(t))
            break
    peak = float(peak_t) if peak_t is not None else float(tt[0])
    post = series[series["time"] >= peak - 0.01]
    if not post.empty:
        j = int(post["dist"].to_numpy().argmin())
        stamps.append(float(post["time"].iloc[j]))
    for t in _decel_event_times(df):
        if t >= peak - 0.5:
            stamps.append(t)
    for partner, ct, _ in _collision_partners(action_data):
        if display_agent_name(partner) == agent.name:
            stamps.append(float(ct))
    stamps.append(float(tt[-1]))
    stamps = sorted(set(round(t, 2) for t in stamps))
    if len(stamps) > MAX_STAMPS_PER_SECONDARY:
        # keep first, min-dist, last, and fill from decel/collision
        keep = [stamps[0]]
        if peak_t is not None:
            post_stamps = [s for s in stamps if s >= peak - 0.01]
            if post_stamps:
                keep.append(post_stamps[0])
        for partner, ct, _ in _collision_partners(action_data):
            if display_agent_name(partner) == agent.name:
                keep.append(round(ct, 2))
        keep.append(stamps[-1])
        stamps = sorted(set(keep))[:MAX_STAMPS_PER_SECONDARY]
    return stamps


def _secondary_metric_bits(m: Dict[str, Any], agent_name: str) -> List[str]:
    """Metric tokens for secondary agents — position in ego coords, no pass-state bin.

    Longitudinal relationship (ahead/overlap/behind) is kept for the primary
    conflict vehicle only; secondary position already states ahead/behind + distance.
    """
    return format_side_metric_bits(
        d=m.get("d"),
        ttc=m.get("ttc"),
        v_ego=m.get("v_ego"),
        v_vehicle=m.get("v_vehicle"),
        az=m.get("az"),
        closing=m.get("closing"),
        rel_long_m=m.get("rel_long_m"),
        rel_lat_m=m.get("rel_lat_m"),
        clearance_m=m.get("clearance_m"),
        rolling_speed_1s_mps=m.get("rolling_speed_1s_mps"),
        conflict_name=agent_name,
    )


def secondary_inline_clauses(
    traj_df: Optional[pd.DataFrame],
    action_data: Optional[Dict[str, Any]],
    t: float,
    *,
    primary_tid: Optional[int],
    primary_name: str,
    secondary_agents: Sequence[SecondaryAgent],
) -> List[str]:
    """Metric clauses for secondary agents at ``t``, only when within the 40 m gate.

    Same metric vocabulary as the primary vehicle except longitudinal relationship
    (pass-state bin) — position in ego coordinates is sufficient for secondaries.

    Do not attach a pre-assigned brake cause. The LLM sees speed, clearance, and
    position; it decides whether a secondary agent matters. The medoid BEV crop
    is keyed to the primary vehicle, so a nearby secondary can be off-frame —
    the text metrics are how it still appears in context.
    """
    if traj_df is None or traj_df.empty or not secondary_agents:
        return []
    df = _normalize_traj_df(traj_df)
    clauses: List[str] = []
    for agent in secondary_agents:
        d = _center_distance(df, agent.track_id, float(t))
        if d is None or float(d) > SECONDARY_DISTANCE_GATE_M:
            continue
        series = _pair_series(df, agent.track_id)
        m = _metrics_at(series, float(t), agent.name, agent.track_id, source_df=df)
        bits = _secondary_metric_bits(m, agent.name)
        if not bits:
            continue
        state = "stationary" if agent.stationary else "moving"
        clause = f"{agent.name} (secondary, {state}): " + "; ".join(bits)
        clauses.append(clause)
    return clauses


def format_secondary_obstacles_section(
    traj_df: Optional[pd.DataFrame],
    action_data: Optional[Dict[str, Any]],
    *,
    primary_tid: Optional[int],
    primary_name: str,
    peak_t: Optional[float],
    t_min: Optional[float] = None,
    t_max: Optional[float] = None,
    primary_label: str = "primary interaction",
) -> str:
    agents = select_secondary_agents(
        traj_df,
        action_data,
        primary_tid=primary_tid,
        primary_name=primary_name,
        peak_t=peak_t,
        t_min=t_min,
        t_max=t_max,
    )
    lines = [
        "## Secondary obstacles",
        "",
        f"The named conflict vehicle ({display_agent_name(primary_name)}) is the "
        f"**{primary_label}**. Other agents below are **secondary** — their "
        "distance, speed, and clearance are facts on the timeline; do not treat "
        "them as a pre-assigned brake cause.",
        "",
    ]
    if not agents:
        lines.append("(no secondary agents selected by inclusion rules)")
        lines.append("")
        return "\n".join(lines)

    if traj_df is None or traj_df.empty:
        lines.append("(trajectory unavailable)")
        lines.append("")
        return "\n".join(lines)

    df = _normalize_traj_df(traj_df)
    shown_names = {ag.name for ag in agents}
    # List agents that matched rules but were below the display cap
    if primary_tid is not None:
        import secondary_context as _sc_mod

        saved_cap = _sc_mod.MAX_SECONDARY_OBJECTS
        _sc_mod.MAX_SECONDARY_OBJECTS = 99
        all_ranked = select_secondary_agents(
            traj_df,
            action_data,
            primary_tid=primary_tid,
            primary_name=primary_name,
            peak_t=peak_t,
            t_min=t_min,
            t_max=t_max,
        )
        _sc_mod.MAX_SECONDARY_OBJECTS = saved_cap
        omitted = [a.name for a in all_ranked if a.name not in shown_names]
    else:
        omitted = []
    if omitted:
        lines.append(f"- also present (not shown): {', '.join(sorted(set(omitted)))}")
        lines.append("")

    for agent in agents:
        rules = "; ".join(r for r in agent.inclusion_rules if not r.startswith("also_present"))
        state = "stationary" if agent.stationary else "moving"
        lines.append(
            f"### {agent.name} (secondary, {state}) — selected by: {rules}"
        )
        series = _pair_series(df, agent.track_id)
        for t in _secondary_stamp_times(df, agent, peak_t=peak_t, action_data=action_data):
            m = _metrics_at(series, t, agent.name, agent.track_id, source_df=df)
            bits = _secondary_metric_bits(m, agent.name)
            er = _ego_row_at(df, t)
            ar = _agent_row_at(df, agent.track_id, t)
            lane_bits = []
            if er is not None:
                lane_bits.append(
                    f"Ego road/lane={er.get('road_id', '?')}/{er.get('lane_id', '?')}"
                )
            if ar is not None:
                lane_bits.append(
                    f"{agent.name} road/lane={ar.get('road_id', '?')}/{ar.get('lane_id', '?')}"
                )
            lines.append(
                f"- t={t:.2f}s: {'; '.join(bits)}; {'; '.join(lane_bits)}"
            )
        lines.append("")
    return "\n".join(lines)


def candidate_control_reason(
    *,
    traj_df: pd.DataFrame,
    action_data: Optional[Dict[str, Any]],
    t: float,
    primary_name: str,
    secondary_agents: Sequence[SecondaryAgent],
) -> Optional[str]:
    """Internal geometry helper. **Not** written into LLM context.

    Context lines only carry secondary-agent metrics (distance, clearance, speed).
    The LLM concludes cause; this function must not be appended as a pre-assigned
    brake reason.
    """
    er = _ego_row_at(traj_df, t)
    if er is None:
        return None
    decel_times = _decel_event_times(traj_df)
    near_onset = any(abs(dt - t) < 0.15 for dt in decel_times)
    # A stationary obstacle can be the reason Ego STAYS slow well after the
    # last discrete decel-onset sample (e.g. easing toward a parked car at
    # near-constant low speed) — a fixed ±0.15s onset window alone misses
    # this. Extend the gate to "recently braked and still slow", not just
    # "braking exactly now".
    ego_v = None
    if "velocity" in er.index:
        try:
            ego_v = float(er["velocity"])
        except (TypeError, ValueError):
            ego_v = None
    recently_decelerated = any(0.0 <= (t - dt) <= 5.0 for dt in decel_times)
    is_slow = ego_v is not None and ego_v <= 3.0
    if not (near_onset or (recently_decelerated and is_slow)):
        return None
    best_sec: Optional[SecondaryAgent] = None
    best_clear = 999.0
    for ag in secondary_agents:
        if not ag.stationary:
            continue
        series = _pair_series(traj_df, ag.track_id)
        m = _metrics_at(series, t, ag.name, ag.track_id, source_df=traj_df)
        c = m.get("clearance_m")
        if c is not None and float(c) < best_clear:
            best_clear = float(c)
            best_sec = ag
    if best_sec is not None and best_clear < 8.0:
        return f"braking_near_stationary_obstacle ({best_sec.name}, clearance={best_clear:.1f}m)"
    for partner, ct, _ in _collision_partners(action_data):
        if abs(float(ct) - t) < 0.2:
            return f"post_collision_recovery ({display_agent_name(partner)})"
    return "braking_for_primary_conflict"


def _trial_end_t(action_data: Optional[Dict[str, Any]], traj_df: Optional[pd.DataFrame]) -> Optional[float]:
    if traj_df is not None and not traj_df.empty:
        return float(traj_df["time"].max())
    if action_data:
        mx = 0.0
        for agent in action_data.get("agents") or []:
            for act in agent.get("actions") or []:
                for key in ("end_time", "start_time"):
                    v = act.get(key)
                    if v is not None:
                        mx = max(mx, float(v))
        return mx if mx > 0 else None
    return None


def _collision_facts(action_data: Optional[Dict[str, Any]]) -> List[Dict[str, Any]]:
    facts = []
    for partner, ct, _ in _collision_partners(action_data):
        facts.append({"partner": display_agent_name(partner), "t": round(ct, 3)})
    return facts


def _post_primary_max_decel(traj_df: Optional[pd.DataFrame], peak_t: Optional[float]) -> Optional[float]:
    if traj_df is None or peak_t is None:
        return None
    ego = traj_df[traj_df["trackId"] == 0].sort_values("time")
    post = ego[ego["time"] >= float(peak_t)]
    if len(post) < 2:
        return None
    tt = post["time"].to_numpy(dtype=float)
    vv = post["velocity"].to_numpy(dtype=float)
    max_decel = 0.0
    for i in range(1, len(tt)):
        dt = float(tt[i] - tt[i - 1])
        if dt < 0.05:
            continue
        dv = float(vv[i] - vv[i - 1])
        if dv < 0:
            max_decel = max(max_decel, abs(dv) / dt)
    return round(max_decel, 3) if max_decel > 0 else None


def build_trajectory_shape_summary(
    *,
    left_label: str,
    right_label: str,
    layer1_end_t: Optional[float],
    left_action_path: Optional[Path],
    right_action_path: Optional[Path],
    left_traj_path: Optional[Path],
    right_traj_path: Optional[Path],
    left_peak_t: Optional[float],
    right_peak_t: Optional[float],
    left_conflict_vehicle: str = "CuttingIn",
    right_conflict_vehicle: str = "CuttingIn",
) -> Dict[str, Any]:
    left_action = _load_action(left_action_path)
    right_action = _load_action(right_action_path)
    left_traj = pd.read_csv(left_traj_path) if left_traj_path and left_traj_path.is_file() else None
    right_traj = pd.read_csv(right_traj_path) if right_traj_path and right_traj_path.is_file() else None

    def _side(
        label: str,
        action,
        traj,
        peak,
        conflict_vehicle: str,
    ) -> Dict[str, Any]:
        end_t = _trial_end_t(action, traj)
        tail = None
        if end_t is not None and layer1_end_t is not None:
            tail = round(max(0.0, end_t - float(layer1_end_t)), 3)
        cols = _collision_facts(action)
        whole = "collision" if cols else "safe"
        sec = False
        if traj is not None and peak is not None:
            ptid = _tid_for_name(traj, action, conflict_vehicle)
            agents = select_secondary_agents(
                traj,
                action,
                primary_tid=ptid,
                primary_name=conflict_vehicle,
                peak_t=peak,
            )
            sec = len(agents) > 0
        return {
            "trial_end_t": end_t,
            "collisions": cols,
            "whole_trial_outcome": whole,
            "tail_length_s": tail,
            "post_primary_decel_max_mps2": _post_primary_max_decel(traj, peak),
            "secondary_obstacle_encountered": sec,
        }

    left = _side(
        left_label, left_action, left_traj, left_peak_t, left_conflict_vehicle
    )
    right = _side(
        right_label, right_action, right_traj, right_peak_t, right_conflict_vehicle
    )
    material = (
        left.get("whole_trial_outcome") != right.get("whole_trial_outcome")
        or left.get("collisions") != right.get("collisions")
        or (left.get("tail_length_s") or 0) > 1.0
        or (right.get("tail_length_s") or 0) > 1.0
    )
    return {
        "layer1_end_t": layer1_end_t,
        "left": left,
        "right": right,
        "downstream_behavior_difference": "material" if material else "immaterial",
    }


def format_trajectory_shape_section(summary: Dict[str, Any], left_lab: str, right_lab: str) -> str:
    lines = [
        "## Trajectory shape difference (deterministic)",
        "",
        "MFPCA+HDBSCAN clustered on whole-trajectory shape. This block summarizes",
        "full-trial facts — independent of synchronized `behavior_similarity`.",
        "",
        f"- **layer1_end_t**: {summary.get('layer1_end_t')} s",
        f"- **downstream_behavior_difference**: {summary.get('downstream_behavior_difference')}",
        "",
    ]
    for side_key, lab in (("left", left_lab), ("right", right_lab)):
        s = summary.get(side_key) or {}
        lines.append(f"### [{lab}]")
        lines.append(f"- trial_end_t: {s.get('trial_end_t')}")
        lines.append(f"- whole_trial_outcome: {s.get('whole_trial_outcome')}")
        lines.append(f"- tail_length_s (after Layer 1): {s.get('tail_length_s')}")
        lines.append(f"- post_primary_decel_max: {s.get('post_primary_decel_max_mps2')} m/s²")
        lines.append(f"- secondary_obstacle_encountered: {s.get('secondary_obstacle_encountered')}")
        cols = s.get("collisions") or []
        if cols:
            for c in cols:
                lines.append(f"- collision: {c.get('partner')} at t={c.get('t')} s")
        else:
            lines.append("- collision: none recorded")
        lines.append("")
    return "\n".join(lines)


def _continuation_events(
    action_data: Optional[Dict[str, Any]],
    traj_df: Optional[pd.DataFrame],
    *,
    after_t: float,
    primary_name: str,
    peak_t: Optional[float],
) -> List[str]:
    from conflict_frame_selector import extract_action_timestamps, _event_gloss

    lines: List[str] = []
    if action_data is None:
        return lines
    primary_tid = _tid_for_name(traj_df, action_data, primary_name) if traj_df is not None else None
    for t, lab in extract_action_timestamps(action_data=action_data):
        if float(t) < float(after_t) - 0.05:
            continue
        gloss = _event_gloss(lab, t=float(t), action_data=action_data)
        extra = ""
        if traj_df is not None and not traj_df.empty:
            agents = select_secondary_agents(
                traj_df,
                action_data,
                primary_tid=primary_tid,
                primary_name=primary_name,
                peak_t=peak_t,
            )
            sec_bits = []
            df = _normalize_traj_df(traj_df)
            for ag in agents:
                series = _pair_series(df, ag.track_id)
                m = _metrics_at(series, t, ag.name, ag.track_id, source_df=df)
                if m.get("clearance_m") is not None and float(m["clearance_m"]) < 15.0:
                    sec_bits.append(
                        f"{ag.name} boundary clearance={float(m['clearance_m']):.1f}m"
                    )
            if sec_bits:
                extra = "; " + "; ".join(sec_bits)
        lines.append(f"- t={float(t):.2f}s: {gloss}{extra}")
    return lines


def format_pair_continuation_sections(
    pack_dir: Path,
    *,
    left_lab: str,
    right_lab: str,
    layer1_end_t: float,
    left_conflict_vehicle: str,
    right_conflict_vehicle: str,
    left_peak_t: Optional[float],
    right_peak_t: Optional[float],
) -> str:
    """Layer 2 — independent full-trial tails after synchronized comparison ends."""
    lines = [
        "## Layer 2 — Full-trial continuation",
        "",
        "Evidence after Layer 1 ends. Each side is read independently — do not treat",
        "as synchronized geometry comparison.",
        "",
    ]

    def _side_dirs(lab: str) -> Tuple[Optional[Path], Optional[Path], Optional[Path]]:
        m = re.match(r"c(\d+)", lab)
        if not m:
            return None, None, None
        cid = m.group(1)
        for d in Path(pack_dir).glob(f"c{cid}_trial_*"):
            action = d / "processed" / "action.yaml"
            if not action.is_file():
                action = d / "action.yaml"
            traj = d / "raw" / "trajectory.csv"
            if not traj.is_file():
                traj = d / "trajectory.csv"
            return d, action if action.is_file() else None, traj if traj.is_file() else None
        return None, None, None

    for lab, veh, peak in (
        (left_lab, left_conflict_vehicle, left_peak_t),
        (right_lab, right_conflict_vehicle, right_peak_t),
    ):
        _, action_p, traj_p = _side_dirs(lab)
        action = _load_action(action_p)
        traj = pd.read_csv(traj_p) if traj_p and traj_p.is_file() else None
        end_t = _trial_end_t(action, traj)
        lines.append(f"### [{lab}] continuation (after t={layer1_end_t:.2f}s)")
        if end_t is not None and end_t <= layer1_end_t + 0.05:
            lines.append(f"- trial ended at t={end_t:.2f}s (no continuation tail)")
            lines.append("")
            continue
        ev = _continuation_events(
            action, traj, after_t=layer1_end_t, primary_name=veh, peak_t=peak
        )
        if ev:
            lines.extend(ev)
        else:
            lines.append("(no action stamps after Layer 1 end)")
        lines.append("")
    return "\n".join(lines)


def _layer1_end_t_from_frames(frames: Sequence[Dict[str, Any]]) -> Optional[float]:
    for fr in frames:
        if not fr.get("left_alive", True) or not fr.get("right_alive", True):
            t_s = fr.get("t_s")
            if t_s is not None:
                return float(t_s)
    return None


def discover_pair_side_paths(pack_dir: Path) -> Dict[str, Dict[str, Optional[Path]]]:
    out: Dict[str, Dict[str, Optional[Path]]] = {}
    for d in Path(pack_dir).glob("c*_trial_*"):
        m = re.match(r"(c\d+)_trial_", d.name)
        if not m:
            continue
        lab = m.group(1)
        action = d / "processed" / "action.yaml"
        if not action.is_file():
            action = d / "action.yaml"
        traj = d / "raw" / "trajectory.csv"
        if not traj.is_file():
            traj = d / "trajectory.csv"
        out[lab] = {
            "action": action if action.is_file() else None,
            "trajectory": traj if traj.is_file() else None,
        }
    return out
