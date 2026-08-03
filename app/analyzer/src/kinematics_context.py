"""Trajectory-backed kinematics for description tables + heading-sweep text.

Used to enrich human ``description.txt`` action rows (v, a, heading, partner
distance/azimuth) and to emit same-lane heading/curve events into
``context.md`` when OpenDRIVE ``lane_id`` does not change.
"""
from __future__ import annotations

import math
import csv
from dataclasses import dataclass
from typing import Any, Dict, List, Optional, Sequence, Tuple

import numpy as np
import pandas as pd

# Heading sweep (same-lane steer / path curve) thresholds.
# Keep in sync with taxonomy.Thresholds.SAME_LANE_TURN_* (labeller source of truth).
HEADING_SWEEP_MIN_DEG = 15.0  # net |Δheading| to keep
HEADING_SWEEP_MIN_S = 1.5  # sustained window
HEADING_SMOOTH_WIN = 7  # samples (~0.7 s at 0.1 s)
HEADING_YAW_RATE_MIN = 2.0  # deg/s — ignore quieter yaw (noise / cruise)
HEADING_STOPPED_SPEED = 0.3  # m/s — no turn while parked / waiting
HEADING_GAP_S = 0.4  # s — allow brief |yaw|≈0 holes inside one arc

_MAP_LANE_CACHE: Dict[str, Dict[Tuple[int, int], List[Tuple[float, float, float]]]] = {}



def _wrap_deg(d: float) -> float:
    return (d + 180.0) % 360.0 - 180.0


def _heading_to_rad(h: float) -> float:
    if abs(h) > 2 * math.pi + 0.5:
        return math.radians(h)
    return float(h)


def _heading_to_deg(h: float) -> float:
    return math.degrees(_heading_to_rad(h))


def _normalize_traj(df: pd.DataFrame) -> pd.DataFrame:
    out = df.copy()
    rename = {}
    if "trackId" in out.columns and "track_id" not in out.columns:
        rename["trackId"] = "track_id"
    if "h" in out.columns and "heading" not in out.columns:
        rename["h"] = "heading"
    if rename:
        out = out.rename(columns=rename)
    return out


def primary_partner_track_id(action_data: Optional[Dict[str, Any]]) -> Optional[int]:
    """Prefer conflict partner, else ONCOMING NPC, else first non-ego agent."""
    if not action_data:
        return None
    for iv in action_data.get("interactions") or []:
        if iv.get("with_track_id") is not None and str(iv.get("type", "")) in (
            "NEAR_MISS",
            "COLLISION",
            "DANGEROUS_CUT_IN",
            "CLOSEST_APPROACH",
        ):
            return int(iv["with_track_id"])
    for ag in action_data.get("agents") or []:
        if int(ag.get("track_id", -1)) == 0:
            continue
        if str(ag.get("relation_to_ego", "")).upper() == "ONCOMING":
            return int(ag["track_id"])
    for ag in action_data.get("agents") or []:
        if int(ag.get("track_id", -1)) != 0:
            return int(ag["track_id"])
    return None


def partner_name(action_data: Optional[Dict[str, Any]], tid: Optional[int]) -> str:
    if tid is None or not action_data:
        return "partner"
    for ag in action_data.get("agents") or []:
        if int(ag.get("track_id", -1)) == int(tid):
            return str(ag.get("name") or f"agent{tid}")
    return f"agent{tid}"


def _agent_at(df: pd.DataFrame, track_id: int, t: float) -> Optional[pd.Series]:
    sub = df[df["track_id"].astype(int) == int(track_id)]
    if sub.empty:
        return None
    times = sub["time"].to_numpy(dtype=float)
    i = int(np.argmin(np.abs(times - float(t))))
    return sub.iloc[i]


def _accel_at(df: pd.DataFrame, track_id: int, t: float) -> Optional[float]:
    sub = df[df["track_id"].astype(int) == int(track_id)].sort_values("time")
    if len(sub) < 3:
        return None
    times = sub["time"].to_numpy(dtype=float)
    v = sub["velocity"].to_numpy(dtype=float)
    i = int(np.argmin(np.abs(times - float(t))))
    i0 = max(0, i - 2)
    i1 = min(len(times) - 1, i + 2)
    dt = times[i1] - times[i0]
    if dt <= 1e-6:
        return None
    return float((v[i1] - v[i0]) / dt)


def _rel_partner(
    ego: pd.Series, partner: Optional[pd.Series]
) -> Tuple[Optional[float], Optional[float]]:
    if partner is None:
        return None, None
    dx = float(partner["x"]) - float(ego["x"])
    dy = float(partner["y"]) - float(ego["y"])
    d = math.hypot(dx, dy)
    bearing = math.atan2(dy, dx)
    eh = _heading_to_rad(float(ego.get("heading", 0.0)))
    az = _wrap_deg(math.degrees(bearing - eh))
    return d, az


def _load_map_lane_heads(map_tracks_csv: str) -> Dict[Tuple[int, int], List[Tuple[float, float, float]]]:
    """Parse odrplot tracks CSV into {(road_id,lane_id): [(x,y,h_rad), ...]}."""
    if map_tracks_csv in _MAP_LANE_CACHE:
        return _MAP_LANE_CACHE[map_tracks_csv]
    out: Dict[Tuple[int, int], List[Tuple[float, float, float]]] = {}
    current: Optional[Tuple[int, int, str]] = None
    with open(map_tracks_csv, encoding="utf-8") as f:
        reader = csv.reader(f, skipinitialspace=True)
        for row in reader:
            if not row:
                continue
            if row[0] == "lane":
                try:
                    road_id = int(row[1])
                    lane_id = int(row[3])
                except Exception:
                    current = None
                    continue
                ltype = "driving"
                if lane_id == 0:
                    ltype = "ref"
                elif len(row) > 4 and row[4] == "no-driving":
                    ltype = "border"
                current = (road_id, lane_id, ltype)
                out.setdefault((road_id, lane_id), [])
                continue
            if current is None or current[2] != "driving":
                continue
            try:
                x, y, h = float(row[0]), float(row[1]), float(row[3])
            except Exception:
                continue
            out[(current[0], current[1])].append((x, y, h))
    _MAP_LANE_CACHE[map_tracks_csv] = out
    return out


def _road_tangent_from_map(
    x: float,
    y: float,
    road_id: int,
    lane_id: int,
    map_tracks_csv: Optional[str],
) -> Optional[float]:
    """Return nearest driving-lane heading (deg) from map tracks."""
    if not map_tracks_csv:
        return None
    try:
        lanes = _load_map_lane_heads(map_tracks_csv)
    except Exception:
        return None
    # Prefer exact (road,lane), then any driving lane on same road.
    keys = [(int(road_id), int(lane_id))]
    keys += [k for k in lanes.keys() if k[0] == int(road_id) and k != keys[0]]
    best: Optional[Tuple[float, float]] = None  # (d2, h_deg)
    for k in keys:
        for px, py, h in lanes.get(k, []):
            d2 = (px - x) ** 2 + (py - y) ** 2
            if best is None or d2 < best[0]:
                best = (d2, math.degrees(float(h)))
    if best is None:
        return None
    return float(best[1])


def _vs_road_at(
    df: pd.DataFrame,
    track_id: int,
    t: float,
    map_tracks_csv: Optional[str] = None,
) -> Optional[float]:
    """Nose heading minus local road tangent; 0° ~= parallel to road."""
    sub = df[df["track_id"].astype(int) == int(track_id)].sort_values("time")
    if len(sub) < 2:
        return None
    times = sub["time"].to_numpy(dtype=float)
    i = int(np.argmin(np.abs(times - float(t))))
    row_i = sub.iloc[i]
    road_i = int(row_i.get("road_id", 0))
    lane_i = int(row_i.get("lane_id", 0))
    x_i = float(row_i.get("x", 0.0))
    y_i = float(row_i.get("y", 0.0))
    tangent = _road_tangent_from_map(x_i, y_i, road_i, lane_i, map_tracks_csv)
    if tangent is None:
        # Fallback: local motion tangent from trajectory if map data unavailable.
        for span in (1, 2, 3, 5):
            i0 = max(0, i - span)
            i1 = min(len(sub) - 1, i + span)
            if i1 <= i0:
                continue
            r0, r1 = sub.iloc[i0], sub.iloc[i1]
            dx = float(r1["x"]) - float(r0["x"])
            dy = float(r1["y"]) - float(r0["y"])
            if math.hypot(dx, dy) < 0.05:
                continue
            tangent = math.degrees(math.atan2(dy, dx))
            break
    if tangent is None:
        return None
    hdg = _heading_to_deg(float(row_i.get("heading", 0.0)))
    return round(_wrap_deg(hdg - tangent), 1)
    return None


def enrich_action_row(
    act: Dict[str, Any],
    traj_df: pd.DataFrame,
    track_id: int,
    partner_tid: Optional[int],
    map_tracks_csv: Optional[str] = None,
) -> Dict[str, Any]:
    """Sample kinematics at action start (and end for intervals)."""
    df = _normalize_traj(traj_df)
    st = float(act.get("start_time", 0.0))
    et = float(act.get("end_time", st))
    ego0 = _agent_at(df, track_id, st)
    ego1 = _agent_at(df, track_id, et) if abs(et - st) > 1e-3 else ego0
    out: Dict[str, Any] = {}
    if ego0 is None:
        return out
    v0 = float(ego0["velocity"])
    v1 = float(ego1["velocity"]) if ego1 is not None else v0
    a0 = _accel_at(df, track_id, st)
    h0 = _heading_to_deg(float(ego0.get("heading", 0.0)))
    h1 = _heading_to_deg(float(ego1.get("heading", 0.0))) if ego1 is not None else h0
    out["v0"] = round(v0, 2)
    out["v1"] = round(v1, 2)
    if a0 is not None:
        out["a"] = round(a0, 2)
    out["hdg0"] = round(h0, 1)
    out["hdg1"] = round(h1, 1)
    out["d_hdg"] = round(_wrap_deg(h1 - h0), 1)

    vs0 = _vs_road_at(df, track_id, st, map_tracks_csv=map_tracks_csv)
    if vs0 is not None:
        out["vs0"] = vs0
    if abs(et - st) > 1e-3:
        vs1 = _vs_road_at(df, track_id, et, map_tracks_csv=map_tracks_csv)
        if vs1 is not None:
            out["vs1"] = vs1
    elif vs0 is not None:
        out["vs1"] = vs0
    if out.get("vs0") is not None:
        out["vlat0"] = round(float(v0) * math.sin(math.radians(float(out["vs0"]))), 2)
    if out.get("vs1") is not None:
        out["vlat1"] = round(float(v1) * math.sin(math.radians(float(out["vs1"]))), 2)

    if partner_tid is not None:
        p0 = _agent_at(df, partner_tid, st)
        d0, az0 = _rel_partner(ego0, p0)
        if d0 is not None:
            out["d0"] = round(d0, 1)
            out["az0"] = round(float(az0), 1)
        if ego1 is not None and abs(et - st) > 1e-3:
            p1 = _agent_at(df, partner_tid, et)
            d1, az1 = _rel_partner(ego1, p1)
            if d1 is not None:
                out["d1"] = round(d1, 1)
                out["az1"] = round(float(az1), 1)
    return out


def sample_kinematics_at_time(
    traj_df: pd.DataFrame,
    track_id: int,
    t: float,
    partner_tid: Optional[int] = None,
    map_tracks_csv: Optional[str] = None,
) -> Dict[str, Any]:
    """Instantaneous kinematics snapshot at time *t* for one agent."""
    df = _normalize_traj(traj_df)
    row = _agent_at(df, track_id, t)
    if row is None:
        return {}
    out: Dict[str, Any] = {
        "t": float(t),
        "road_id": int(row.get("road_id", 0)),
        "lane_id": int(row.get("lane_id", 0)),
        "v": round(float(row.get("velocity", 0.0)), 2),
        "hdg": round(_heading_to_deg(float(row.get("heading", 0.0))), 1),
    }
    a = _accel_at(df, track_id, t)
    if a is not None:
        out["a"] = round(float(a), 2)
    vs = _vs_road_at(df, track_id, t, map_tracks_csv=map_tracks_csv)
    if vs is not None:
        out["vs_road"] = float(vs)
        out["v_lat"] = round(
            float(out["v"]) * math.sin(math.radians(float(out["vs_road"]))), 2
        )
    if partner_tid is not None:
        p = _agent_at(df, partner_tid, t)
        d, az = _rel_partner(row, p)
        if d is not None:
            out["d"] = round(float(d), 1)
            out["az"] = round(float(az), 1)
    return out


@dataclass
class HeadingSweep:
    t0: float
    t1: float
    direction: str  # LEFT | RIGHT
    delta_deg: float
    hdg0_deg: float
    hdg1_deg: float
    road_id: Optional[int]
    lane_id: Optional[int]
    path_tangent0_deg: Optional[float] = None
    path_tangent1_deg: Optional[float] = None
    vs_path0_deg: Optional[float] = None  # heading − path tangent
    vs_path1_deg: Optional[float] = None


def detect_heading_sweeps(
    traj_df: pd.DataFrame,
    track_id: int = 0,
    *,
    min_deg: float = HEADING_SWEEP_MIN_DEG,
    min_s: float = HEADING_SWEEP_MIN_S,
) -> List[HeadingSweep]:
    """Same-lane heading arcs: net yaw change without requiring lane_id change.

    Uses smoothed heading and path tangent from (x,y).

    Detection is **active yaw-rate runs**, not trajectory endpoints:
      * ignore frames with speed < ``HEADING_STOPPED_SPEED`` (no turn while stopped)
      * ignore |yaw_rate| < ``HEADING_YAW_RATE_MIN``
      * keep same-sign contiguous runs (brief zero gaps ≤ ``HEADING_GAP_S`` allowed)
      * require |Δheading| ≥ min_deg and duration ≥ min_s

    Endpoint-extrema used earlier falsely labelled long plateaus (e.g. parked
    then a 90° junction curve) as one TURN from t=0 to well after the curve.
    """
    df = _normalize_traj(traj_df)
    sub = df[df["track_id"].astype(int) == int(track_id)].sort_values("time")
    if len(sub) < HEADING_SMOOTH_WIN + 2:
        return []

    t = sub["time"].to_numpy(dtype=float)
    x = sub["x"].to_numpy(dtype=float)
    y = sub["y"].to_numpy(dtype=float)
    v = (
        sub["velocity"].to_numpy(dtype=float)
        if "velocity" in sub.columns
        else np.ones(len(sub), dtype=float)
    )
    h_raw = np.array([_heading_to_deg(float(val)) for val in sub["heading"].to_numpy()])
    h_un = np.rad2deg(np.unwrap(np.deg2rad(h_raw)))
    win = HEADING_SMOOTH_WIN
    pad = win // 2
    h_pad = np.pad(h_un, (pad, pad), mode="edge")
    kernel = np.ones(win) / float(win)
    h_s = np.convolve(h_pad, kernel, mode="valid")

    dx = np.diff(x, prepend=x[0])
    dy = np.diff(y, prepend=y[0])
    path = np.degrees(np.arctan2(dy, dx))
    # Stationary frames: path tangent is undefined — hold previous.
    moving = np.hypot(dx, dy) > 1e-3
    for i in range(1, len(path)):
        if not moving[i]:
            path[i] = path[i - 1]
    if not moving[0] and len(path) > 1:
        path[0] = path[1]
    path_un = np.rad2deg(np.unwrap(np.deg2rad(path)))

    road = (
        sub["road_id"].to_numpy(dtype=int)
        if "road_id" in sub.columns
        else np.zeros(len(sub), dtype=int)
    )
    lane = (
        sub["lane_id"].to_numpy(dtype=int)
        if "lane_id" in sub.columns
        else np.zeros(len(sub), dtype=int)
    )

    dt = np.diff(t, prepend=t[0])
    dt[dt <= 1e-9] = 1e-9
    yaw_rate = np.diff(h_s, prepend=h_s[0]) / dt
    sign = np.sign(yaw_rate)
    sign[np.abs(yaw_rate) < HEADING_YAW_RATE_MIN] = 0
    sign[v < HEADING_STOPPED_SPEED] = 0

    events: List[HeadingSweep] = []
    i = 0
    n = len(t)
    while i < n:
        if sign[i] == 0:
            i += 1
            continue
        s0 = sign[i]
        j = i
        while j + 1 < n:
            nxt = sign[j + 1]
            if nxt == s0:
                j += 1
                continue
            if nxt == 0:
                # Allow a short quiet gap if the same sign resumes.
                k = j + 1
                while k < n and sign[k] == 0 and (t[k] - t[j]) < HEADING_GAP_S:
                    k += 1
                if k < n and sign[k] == s0:
                    j = k
                    continue
            break
        # Trim quiet edges inside [i, j]
        while i <= j and sign[i] == 0:
            i += 1
        while j >= i and sign[j] == 0:
            j -= 1
        if j <= i:
            i = max(i, j) + 1
            continue

        dur = float(t[j] - t[i])
        dhdg = float(h_s[j] - h_s[i])
        if dur >= min_s and abs(dhdg) >= min_deg:
            direction = "LEFT" if dhdg > 0 else "RIGHT"
            events.append(
                HeadingSweep(
                    t0=float(t[i]),
                    t1=float(t[j]),
                    direction=direction,
                    delta_deg=round(abs(dhdg), 1),
                    hdg0_deg=round(float(h_s[i] % 360.0), 1),
                    hdg1_deg=round(float(h_s[j] % 360.0), 1),
                    road_id=int(road[i]),
                    lane_id=int(lane[i]),
                    path_tangent0_deg=round(float(path_un[i] % 360.0), 1),
                    path_tangent1_deg=round(float(path_un[j] % 360.0), 1),
                    vs_path0_deg=round(_wrap_deg(float(h_s[i] - path_un[i])), 1),
                    vs_path1_deg=round(_wrap_deg(float(h_s[j] - path_un[j])), 1),
                )
            )
        i = j + 1

    # Merge adjacent same-direction sweeps separated by <0.5 s
    merged: List[HeadingSweep] = []
    for ev in events:
        if (
            merged
            and ev.direction == merged[-1].direction
            and ev.t0 - merged[-1].t1 < 0.5
        ):
            prev = merged[-1]
            merged[-1] = HeadingSweep(
                t0=prev.t0,
                t1=ev.t1,
                direction=prev.direction,
                delta_deg=round(abs(_wrap_deg(ev.hdg1_deg - prev.hdg0_deg)), 1),
                hdg0_deg=prev.hdg0_deg,
                hdg1_deg=ev.hdg1_deg,
                road_id=prev.road_id,
                lane_id=prev.lane_id,
                path_tangent0_deg=prev.path_tangent0_deg,
                path_tangent1_deg=ev.path_tangent1_deg,
                vs_path0_deg=prev.vs_path0_deg,
                vs_path1_deg=ev.vs_path1_deg,
            )
        else:
            merged.append(ev)
    return merged


def format_heading_sweep_sentences(sweeps: Sequence[HeadingSweep]) -> str:
    """LLM/context text for heading arcs (no lane_id change required)."""
    if not sweeps:
        return ""
    lines = [
        "## Same-lane turns (rule-based)",
        "",
        "Detected from smoothed vehicle heading while moving. These are "
        "same-lane heading changes — not OpenDRIVE LANE_CHANGE events. Kept "
        f"when |Δheading| ≥ {HEADING_SWEEP_MIN_DEG:.0f}° over ≥ {HEADING_SWEEP_MIN_S:.1f} s "
        f"(ignore stopped frames and |yaw rate| < {HEADING_YAW_RATE_MIN:.0f}°/s).",
        "",
        "Δheading = change in nose direction (compass yaw). "
        "heading vs road direction = nose angle minus local lane tangent at that "
        "position; 0° means the nose points along the road.",
        "",
    ]
    for ev in sweeps:
        side = "left" if ev.direction == "LEFT" else "right"
        road = f"road {ev.road_id}, lane {ev.lane_id}" if ev.road_id is not None else "unknown road"
        lines.append(
            f"- At t={ev.t0:.2f}–{ev.t1:.2f} s, Ego turns {side} on the same lane "
            f"(Δheading = {ev.delta_deg:.1f}°, nose {ev.hdg0_deg:.1f}° → {ev.hdg1_deg:.1f}°) "
            f"on {road}."
        )
        if ev.vs_path0_deg is not None and ev.vs_path1_deg is not None:
            lines.append(
                f"  - heading vs road direction: {ev.vs_path0_deg:+.1f}° → {ev.vs_path1_deg:+.1f}° "
                f"(0° = nose aligned with road; local road direction ≈ "
                f"{ev.path_tangent0_deg:.1f}° → {ev.path_tangent1_deg:.1f}°)."
            )
    lines.append("")
    return "\n".join(lines)


def format_enriched_action_table(
    agent: Dict[str, Any],
    traj_df: Optional[pd.DataFrame],
    partner_tid: Optional[int],
    partner_label: str = "Opposite",
    map_tracks_csv: Optional[str] = None,
) -> List[str]:
    """Markdown table with v/a/heading, heading-vs-road, and partner geometry."""
    name = agent.get("name", f"agent {agent['track_id']}")
    role = agent.get("role", "npc")
    tid = int(agent.get("track_id", -1))
    header = f"### {name} ({agent.get('type', 'car')}, {role})"
    if role == "npc" and agent.get("relation_to_ego"):
        header += f" — {agent['relation_to_ego']}"

    use_partner = traj_df is not None and partner_tid is not None and role == "ego"
    # vs road: nose − local road tangent; v_lat: signed lateral component (m/s).
    if use_partner:
        cols = (
            "| time | action | road | lane | v (m/s) | a (m/s²) | heading (°) | "
            "vs road (°) | v_lat (m/s) | "
            f"d→{partner_label} (m) | az→{partner_label} (°) |"
        )
        sep = (
            "|------|--------|------|------|---------|----------|-------------|"
            "---------------|-------------|-------------------|--------------------|"
        )
    else:
        cols = (
            "| time | action | road | lane | v (m/s) | a (m/s²) | heading (°) | "
            "vs road (°) | v_lat (m/s) |"
        )
        sep = (
            "|------|--------|------|------|---------|----------|-------------|"
            "---------------|-------------|"
        )

    lines = [
        header,
        "",
        "_vs road_ = nose heading − local road direction at current position.",
        "Signed _v_lat_ ≈ v * sin(vs_road): + leftward, − rightward lateral component.",
        "",
        cols,
        sep,
    ]
    actions = agent.get("actions") or []
    if not actions:
        empty = "| — | (no significant actions) | — | — | — | — | — | — | — |"
        if use_partner:
            empty += " — | — |"
        lines.append(empty)
        lines.append("")
        return lines

    for act in actions:
        st, et = act.get("start_time"), act.get("end_time")
        tspan = f"{st:.1f}s" if st == et else f"{st:.1f}–{et:.1f}s"
        kin: Dict[str, Any] = {}
        if traj_df is not None:
            kin = enrich_action_row(
                act,
                traj_df,
                tid,
                partner_tid if use_partner else None,
                map_tracks_csv=map_tracks_csv,
            )

        def _f(key: str, fmt: str = "{:.2f}") -> str:
            if key not in kin or kin[key] is None:
                return "—"
            return fmt.format(kin[key])

        v_cell = _f("v0") if abs(float(st) - float(et)) < 1e-6 else f"{_f('v0')}→{_f('v1')}"
        a_cell = _f("a")
        if abs(float(st) - float(et)) < 1e-6:
            h_cell = _f("hdg0", "{:.1f}")
            vs_cell = _f("vs0", "{:+.1f}")
            vlat_cell = _f("vlat0", "{:+.2f}")
        else:
            h0, h1 = _f("hdg0", "{:.1f}"), _f("hdg1", "{:.1f}")
            dh = _f("d_hdg", "{:+.1f}")
            h_cell = f"{h0}→{h1} (Δ{dh})" if h0 != "—" else "—"
            vs0, vs1 = _f("vs0", "{:+.1f}"), _f("vs1", "{:+.1f}")
            vs_cell = f"{vs0}→{vs1}" if vs0 != "—" or vs1 != "—" else "—"
            vl0, vl1 = _f("vlat0", "{:+.2f}"), _f("vlat1", "{:+.2f}")
            vlat_cell = f"{vl0}→{vl1}" if vl0 != "—" or vl1 != "—" else "—"

        row = (
            f"| {tspan} | {act.get('action')} | {act.get('road_id')} | {act.get('lane_id')} "
            f"| {v_cell} | {a_cell} | {h_cell} | {vs_cell} | {vlat_cell} |"
        )
        if use_partner:
            if "d1" in kin and abs(float(st) - float(et)) > 1e-6:
                d_cell = f"{_f('d0', '{:.1f}')}→{_f('d1', '{:.1f}')}"
                az_cell = f"{_f('az0', '{:.1f}')}→{_f('az1', '{:.1f}')}"
            else:
                d_cell = _f("d0", "{:.1f}")
                az_cell = _f("az0", "{:.1f}")
            row = f"{row} {d_cell} | {az_cell} |"
        lines.append(row)
    lines.append("")
    return lines
