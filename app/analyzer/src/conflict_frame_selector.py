"""Conflict-centered BEV frame selection for LLM packs.

Selects a small set of times around COLLISION / NEAR_MISS / CLOSEST_APPROACH
using window + distance gates, junction demotion, burst sampling, and
rule-based criticality extrema. Metrics rows feed description.txt; concise
labels feed BEV filenames.
"""
from __future__ import annotations

import math
from dataclasses import asdict, dataclass, field
from pathlib import Path
from typing import Any, Dict, List, Optional, Sequence, Tuple

import numpy as np
import pandas as pd
import yaml

# Defaults (also exposed as dataset_builder CLI flags).
DEFAULT_CONFLICT_WINDOW_S = 6.0
DEFAULT_CONFLICT_DISTANCE_M = 40.0
# 0 = discrete burst only (plan offsets). >0 densifies with that step.
DEFAULT_CONFLICT_BURST_STEP_S = 0.0
DEFAULT_HARD_BRAKE_ACCEL = -2.5
DEFAULT_PARTNER_SPEED_EPS = 0.3
DEFAULT_HEADING_TURN_DEG = 25.0
DEFAULT_MIN_GAP_S = 0.15
DEFAULT_PAIR_MARGIN_M = 12.0

# Discrete burst offsets around conflict peak (seconds).
_BURST_OFFSETS = (-2.0, -1.0, -0.5, -0.2, 0.0, 0.2, 0.5, 1.0)

_CONFLICT_TYPES = frozenset({"COLLISION", "NEAR_MISS", "CLOSEST_APPROACH", "DANGEROUS_CUT_IN"})
_JUNCTION_ACTIONS = frozenset({"ENTER_JUNCTION", "EXIT_JUNCTION"})

AZIMUTH_GLOSSARY = (
    "Azimuth (az): bearing of the conflict partner relative to ego heading, "
    "degrees in [-180, 180]; 0=ahead, +left, -right, ±180=behind. "
    "TTC=time-to-collision (s). d=center distance (m)."
)


def _burst_offset_slug(offset_s: float) -> str:
    """Filename token for burst offset, e.g. ``0p2s_before`` / ``1s_after``."""
    mag = abs(float(offset_s))
    if abs(mag - round(mag)) < 1e-6:
        tok = f"{int(round(mag))}s"
    else:
        tok = f"{mag:.1f}s".replace(".", "p")
    return f"{tok}_before" if offset_s < 0 else f"{tok}_after"


@dataclass
class SelectedFrame:
    t: float
    label: str
    role: str  # peak | burst | relevance | brake | dist_min | ttc_min | closing | pet | action | whole
    partner_name: str = ""
    partner_track_id: Optional[int] = None
    context_partner_name: str = ""
    context_partner_track_id: Optional[int] = None
    d_m: Optional[float] = None
    ttc_s: Optional[float] = None
    v_ego: Optional[float] = None
    v_partner: Optional[float] = None
    az_deg: Optional[float] = None
    closing_mps: Optional[float] = None
    ego_road: Optional[int] = None
    ego_lane: Optional[int] = None
    partner_road: Optional[int] = None
    partner_lane: Optional[int] = None
    use_whole_scene: bool = False  # left panel = whole scene (else pair zoom)
    draw_agent_road_labels: bool = False
    burst_offset_s: Optional[float] = None

    def concise_slug(self) -> str:
        """Short filename slug: [offset_]EVENT_Partner."""
        parts: List[str] = []
        if self.burst_offset_s is not None and abs(self.burst_offset_s) > 1e-9:
            parts.append(_burst_offset_slug(self.burst_offset_s))
        event = self.label.split("+")[0].strip() if self.label else self.role
        event = event.replace(" ", "_")
        if len(event) > 40:
            event = event.split("_")[-1] if "_" in event else event[:40]
        parts.append(event or self.role)
        if self.partner_name and self.partner_name.lower() not in event.lower():
            parts.append(self.partner_name)
        slug = "_".join(parts)
        return "".join(c if c.isalnum() or c in "-_" else "_" for c in slug).strip("_")[:72]


@dataclass
class SelectionResult:
    frames: List[SelectedFrame] = field(default_factory=list)
    conflict_times: List[float] = field(default_factory=list)
    partner_track_id: Optional[int] = None
    partner_name: str = ""
    context_partner_track_id: Optional[int] = None
    context_partner_name: str = ""
    relevance_t: Optional[float] = None
    peak_t: Optional[float] = None

    def to_llm_json(self, file_prefix: str, filenames: Sequence[str]) -> Dict[str, Any]:
        rows = []
        for fr, fname in zip(self.frames, filenames):
            rows.append({
                "file": fname,
                "t": round(fr.t, 3),
                "label": fr.label,
                "role": fr.role,
                "partner": fr.partner_name,
                "context_partner": fr.context_partner_name or None,
                "d_m": fr.d_m,
                "ttc_s": fr.ttc_s,
                "v_ego": fr.v_ego,
                "v_partner": fr.v_partner,
                "az_deg": fr.az_deg,
                "closing_mps": fr.closing_mps,
                "ego_road_lane": _road_lane(fr.ego_road, fr.ego_lane),
                "partner_road_lane": _road_lane(fr.partner_road, fr.partner_lane),
                "use_whole_scene": fr.use_whole_scene,
                "burst_offset_s": fr.burst_offset_s,
            })
        return {
            "prefix": file_prefix,
            "partner_name": self.partner_name,
            "partner_track_id": self.partner_track_id,
            "context_partner_name": self.context_partner_name,
            "context_partner_track_id": self.context_partner_track_id,
            "peak_t": self.peak_t,
            "relevance_t": self.relevance_t,
            "azimuth_definition": AZIMUTH_GLOSSARY,
            "snapshots": rows,
        }


def _road_lane(road: Optional[int], lane: Optional[int]) -> str:
    if road is None and lane is None:
        return "—"
    return f"{road if road is not None else '?'}/{lane if lane is not None else '?'}"


def _normalize_traj_df(df: pd.DataFrame) -> pd.DataFrame:
    """Unify esmini / trajectory.csv column names."""
    out = df.copy()
    rename = {}
    if "roadId" in out.columns and "road_id" not in out.columns:
        rename["roadId"] = "road_id"
    if "laneId" in out.columns and "lane_id" not in out.columns:
        rename["laneId"] = "lane_id"
    if "speed" in out.columns and "velocity" not in out.columns:
        rename["speed"] = "velocity"
    if "h" in out.columns and "heading" not in out.columns:
        rename["h"] = "heading"
    if rename:
        out = out.rename(columns=rename)
    if "trackId" not in out.columns and "name" in out.columns:
        # Map Ego -> 0, others by appearance order.
        names = list(dict.fromkeys(out["name"].astype(str)))
        name_to_id = {n: (0 if n == "Ego" else i) for i, n in enumerate(names)}
        if "Ego" in name_to_id:
            # Re-number non-ego starting at 1
            nid = 1
            for n in names:
                if n == "Ego":
                    name_to_id[n] = 0
                else:
                    name_to_id[n] = nid
                    nid += 1
        out["trackId"] = out["name"].astype(str).map(name_to_id)
    return out


def _wrap_deg(deg: float) -> float:
    while deg > 180.0:
        deg -= 360.0
    while deg < -180.0:
        deg += 360.0
    return deg


def _azimuth_deg(ego_x: float, ego_y: float, ego_h_rad: float,
                 px: float, py: float) -> float:
    """Partner bearing relative to ego heading (deg, [-180,180])."""
    dx, dy = px - ego_x, py - ego_y
    bearing = math.atan2(dy, dx)
    return _wrap_deg(math.degrees(bearing - ego_h_rad))


def _heading_to_rad(h: float) -> float:
    # esmini / trajectory: heading usually radians; if |h| > 2π treat as degrees.
    if abs(h) > 2 * math.pi + 0.5:
        return math.radians(h)
    return float(h)


def _agent_name_map(action_data: Optional[Dict[str, Any]]) -> Dict[int, str]:
    out: Dict[int, str] = {0: "Ego"}
    if not action_data:
        return out
    for a in action_data.get("agents") or []:
        tid = a.get("track_id")
        if tid is None:
            continue
        out[int(tid)] = str(a.get("name") or f"agent{tid}")
    return out


def _load_action(action_yaml_path: Optional[str | Path]) -> Optional[Dict[str, Any]]:
    if not action_yaml_path:
        return None
    p = Path(action_yaml_path)
    if not p.is_file():
        return None
    try:
        with p.open() as fh:
            return yaml.safe_load(fh) or {}
    except Exception:
        return None


def _conflict_anchors(
    action_data: Optional[Dict[str, Any]],
) -> List[Tuple[float, str, Optional[int], str]]:
    """Return (t*, type, partner_tid, partner_name) sorted by time."""
    if not action_data:
        return []
    id_to_name = _agent_name_map(action_data)
    anchors: List[Tuple[float, str, Optional[int], str]] = []
    for iv in action_data.get("interactions") or []:
        typ = str(iv.get("type", ""))
        if typ not in _CONFLICT_TYPES:
            continue
        kt = iv.get("key_time")
        if kt is None:
            continue
        tid = iv.get("with_track_id")
        tid_i = int(tid) if tid is not None else None
        pname = str(iv.get("with_name") or (id_to_name.get(tid_i, "") if tid_i is not None else ""))
        anchors.append((float(kt), typ, tid_i, pname))
        ct = iv.get("cut_in_time")
        if ct is not None and typ == "DANGEROUS_CUT_IN":
            anchors.append((float(ct), f"{typ}_start", tid_i, pname))
    # Also COLLISION actions on ego
    for agent in action_data.get("agents") or []:
        if int(agent.get("track_id", -1)) != 0:
            continue
        for act in agent.get("actions") or []:
            if act.get("action") != "COLLISION":
                continue
            st = act.get("start_time")
            if st is None:
                continue
            attrs = act.get("attributes") or {}
            tid = attrs.get("with_track_id")
            tid_i = int(tid) if tid is not None else None
            pname = str(attrs.get("with_name") or (id_to_name.get(tid_i, "") if tid_i else ""))
            anchors.append((float(st), "COLLISION", tid_i, pname))
    anchors.sort(key=lambda x: x[0])
    # Dedupe near-identical times
    merged: List[Tuple[float, str, Optional[int], str]] = []
    for a in anchors:
        if merged and abs(a[0] - merged[-1][0]) < 0.05:
            # Prefer COLLISION / NEAR_MISS label
            if a[1] in ("COLLISION", "NEAR_MISS") and merged[-1][1] not in ("COLLISION", "NEAR_MISS"):
                merged[-1] = a
            continue
        merged.append(a)
    return merged


def _pair_series(
    df: pd.DataFrame,
    partner_tid: int,
) -> Optional[pd.DataFrame]:
    ego = df[df["trackId"] == 0].sort_values("time")
    npc = df[df["trackId"] == partner_tid].sort_values("time")
    if ego.empty or npc.empty:
        return None
    ego_cols = ["time", "x", "y", "velocity", "heading", "road_id", "lane_id"]
    npc_cols = ["time", "x", "y", "velocity", "heading", "road_id", "lane_id"]
    for c in ego_cols:
        if c not in ego.columns:
            ego = ego.copy()
            ego[c] = 0.0 if c != "time" else ego.get("time", 0)
    for c in npc_cols:
        if c not in npc.columns:
            npc = npc.copy()
            npc[c] = 0.0 if c != "time" else npc.get("time", 0)
    merged = pd.merge_asof(
        ego[ego_cols].rename(columns={
            "x": "ex", "y": "ey", "velocity": "ev", "heading": "eh",
            "road_id": "er", "lane_id": "el",
        }),
        npc[npc_cols].rename(columns={
            "x": "nx", "y": "ny", "velocity": "nv", "heading": "nh",
            "road_id": "nr", "lane_id": "nl",
        }),
        on="time",
        direction="nearest",
        tolerance=0.08,
    ).dropna(subset=["nx"])
    if merged.empty:
        return None
    merged = merged.copy()
    merged["dist"] = np.hypot(merged["ex"] - merged["nx"], merged["ey"] - merged["ny"])
    tt = merged["time"].to_numpy(dtype=float)
    dist = merged["dist"].to_numpy(dtype=float)
    if len(tt) > 1:
        ddt = np.gradient(dist, tt)
    else:
        ddt = np.zeros_like(dist)
    merged["closing"] = -ddt
    closing = merged["closing"].to_numpy(dtype=float)
    merged["ttc"] = np.where(closing > 1e-3, dist / np.maximum(closing, 1e-3), np.inf)
    return merged


def _fallback_partner(
    df: pd.DataFrame,
    action_data: Optional[Dict[str, Any]],
) -> Tuple[Optional[int], str, Optional[float]]:
    """Pick moving partner with global min distance; return tid, name, t_at_min."""
    id_to_name = _agent_name_map(action_data)
    best: Optional[Tuple[float, int, float]] = None  # dist, tid, t
    for tid in sorted(int(x) for x in df["trackId"].unique() if int(x) != 0):
        series = _pair_series(df, tid)
        if series is None or series.empty:
            continue
        if float(series["nv"].abs().max()) < DEFAULT_PARTNER_SPEED_EPS:
            continue
        i = int(series["dist"].to_numpy().argmin())
        d = float(series["dist"].iloc[i])
        t = float(series["time"].iloc[i])
        if best is None or d < best[0]:
            best = (d, tid, t)
    if best is None:
        return None, "", None
    return best[1], id_to_name.get(best[1], f"agent{best[1]}"), best[2]


def _context_partner_for_stationary(
    df: pd.DataFrame,
    action_data: Optional[Dict[str, Any]],
    primary_tid: Optional[int],
    peak_t: Optional[float],
) -> Tuple[Optional[int], str]:
    """If primary conflict partner is parked/slow, pick a moving threat (e.g. Opposite).

    Used so pair-zoom still shows the oncoming vehicle that caused the dodge into
    a parked car.
    """
    if primary_tid is None or peak_t is None:
        return None, ""
    id_to_name = _agent_name_map(action_data)
    primary = _pair_series(df, primary_tid)
    if primary is None or primary.empty:
        return None, ""
    i = int(np.argmin(np.abs(primary["time"].to_numpy(float) - peak_t)))
    if abs(float(primary["nv"].iloc[i])) > DEFAULT_PARTNER_SPEED_EPS:
        return None, ""  # primary already moving — no extra context needed

    best: Optional[Tuple[float, int]] = None  # dist, tid
    for tid in sorted(int(x) for x in df["trackId"].unique() if int(x) not in (0, int(primary_tid))):
        series = _pair_series(df, tid)
        if series is None or series.empty:
            continue
        j = int(np.argmin(np.abs(series["time"].to_numpy(float) - peak_t)))
        if abs(float(series["nv"].iloc[j])) < DEFAULT_PARTNER_SPEED_EPS:
            continue
        d = float(series["dist"].iloc[j])
        if best is None or d < best[0]:
            best = (d, tid)
    if best is None:
        return None, ""
    return best[1], id_to_name.get(best[1], f"agent{best[1]}")


def _metrics_at(
    series: Optional[pd.DataFrame],
    t: float,
    partner_name: str,
    partner_tid: Optional[int],
) -> Dict[str, Any]:
    out: Dict[str, Any] = {
        "partner_name": partner_name,
        "partner_track_id": partner_tid,
        "d_m": None,
        "ttc_s": None,
        "v_ego": None,
        "v_partner": None,
        "az_deg": None,
        "closing_mps": None,
        "ego_road": None,
        "ego_lane": None,
        "partner_road": None,
        "partner_lane": None,
    }
    if series is None or series.empty:
        return out
    i = int(np.argmin(np.abs(series["time"].to_numpy(dtype=float) - t)))
    row = series.iloc[i]
    out["d_m"] = round(float(row["dist"]), 2)
    ttc = float(row["ttc"])
    out["ttc_s"] = None if not np.isfinite(ttc) or ttc > 60 else round(ttc, 2)
    out["v_ego"] = round(float(row["ev"]), 2)
    out["v_partner"] = round(float(row["nv"]), 2)
    out["closing_mps"] = round(float(row["closing"]), 2)
    out["ego_road"] = int(row["er"]) if not pd.isna(row["er"]) else None
    out["ego_lane"] = int(row["el"]) if not pd.isna(row["el"]) else None
    out["partner_road"] = int(row["nr"]) if not pd.isna(row["nr"]) else None
    out["partner_lane"] = int(row["nl"]) if not pd.isna(row["nl"]) else None
    eh = _heading_to_rad(float(row["eh"]))
    out["az_deg"] = round(
        _azimuth_deg(float(row["ex"]), float(row["ey"]), eh, float(row["nx"]), float(row["ny"])),
        1,
    )
    return out


def _nearest_time(time_steps: Sequence[float], t: float) -> float:
    if not time_steps:
        return t
    arr = np.asarray(time_steps, dtype=float)
    return float(arr[int(np.argmin(np.abs(arr - t)))])


def _segments_cross(a1, a2, b1, b2) -> bool:
    """2D segment intersection (proper or endpoint touch)."""
    def orient(p, q, r):
        return (q[1] - p[1]) * (r[0] - q[0]) - (q[0] - p[0]) * (r[1] - q[1])

    def on_seg(p, q, r):
        return (min(p[0], r[0]) <= q[0] <= max(p[0], r[0])
                and min(p[1], r[1]) <= q[1] <= max(p[1], r[1]))

    o1 = orient(a1, a2, b1)
    o2 = orient(a1, a2, b2)
    o3 = orient(b1, b2, a1)
    o4 = orient(b1, b2, a2)
    if o1 * o2 < 0 and o3 * o4 < 0:
        return True
    if abs(o1) < 1e-9 and on_seg(a1, b1, a2):
        return True
    if abs(o2) < 1e-9 and on_seg(a1, b2, a2):
        return True
    if abs(o3) < 1e-9 and on_seg(b1, a1, b2):
        return True
    if abs(o4) < 1e-9 and on_seg(b1, a2, b2):
        return True
    return False


def _pet_time(series: pd.DataFrame, t_star: float, window: float) -> Optional[float]:
    """Approximate PET: when ego/partner path segments cross near t*."""
    lo, hi = t_star - window, t_star + window
    sub = series[(series["time"] >= lo) & (series["time"] <= hi)]
    if len(sub) < 4:
        return None
    ego_xy = list(zip(sub["ex"].to_numpy(float), sub["ey"].to_numpy(float)))
    npc_xy = list(zip(sub["nx"].to_numpy(float), sub["ny"].to_numpy(float)))
    times = sub["time"].to_numpy(float)
    for i in range(len(sub) - 1):
        for j in range(len(sub) - 1):
            if abs(times[i] - times[j]) > window:
                continue
            if _segments_cross(ego_xy[i], ego_xy[i + 1], npc_xy[j], npc_xy[j + 1]):
                # Mid time of the later segment end ≈ encroachment
                return float(max(times[i + 1], times[j + 1]))
    return None


def _local_minima_indices(values: np.ndarray, min_prominence: float = 0.5) -> List[int]:
    if len(values) < 3:
        return []
    out = []
    for i in range(1, len(values) - 1):
        if values[i] <= values[i - 1] and values[i] <= values[i + 1]:
            left = values[max(0, i - 5):i]
            right = values[i + 1:i + 6]
            prom = min(
                (float(left.max()) - float(values[i])) if len(left) else 0.0,
                (float(right.max()) - float(values[i])) if len(right) else 0.0,
            )
            if prom >= min_prominence or values[i] == values.min():
                out.append(i)
    return out


def _is_straight_junction_action(act: Dict[str, Any]) -> bool:
    name = str(act.get("action", ""))
    if name not in _JUNCTION_ACTIONS:
        return False
    attrs = act.get("attributes") or {}
    intent = str(attrs.get("intent", "GO_STRAIGHT"))
    heading = abs(float(attrs.get("heading_change_deg", 0) or 0))
    if intent == "GO_STRAIGHT" and heading < DEFAULT_HEADING_TURN_DEG:
        return True
    return False


def _candidate_action_times(
    action_data: Optional[Dict[str, Any]],
    conflict_times: Sequence[float],
    window_s: float,
) -> List[Tuple[float, str]]:
    """Action boundaries that survive junction demotion / window gate."""
    if not action_data:
        return []
    out: List[Tuple[float, str]] = []
    id_to_name = _agent_name_map(action_data)
    burst_lo = min(conflict_times) - 2.0 if conflict_times else None
    burst_hi = max(conflict_times) + 1.0 if conflict_times else None

    def in_window(t: float) -> bool:
        if not conflict_times:
            return True
        return any(abs(t - tc) <= window_s for tc in conflict_times)

    def in_burst(t: float) -> bool:
        if burst_lo is None:
            return True
        return burst_lo <= t <= burst_hi

    for agent in action_data.get("agents") or []:
        tid = int(agent.get("track_id", -1))
        token = "ego" if tid == 0 else str(agent.get("name") or id_to_name.get(tid, f"a{tid}"))
        for act in agent.get("actions") or []:
            name = str(act.get("action", "action"))
            # Always demote GO_STRAIGHT junction enter/exit (even inside W) —
            # these flood the LLM pack without adding conflict signal.
            if _is_straight_junction_action(act):
                continue
            if name in ("MAINTAIN_SPEED",) and tid != 0:
                continue
            if name == "STOPPED" and tid != 0:
                continue
            st = act.get("start_time")
            et = act.get("end_time", st)
            if st is None:
                continue
            st_f, et_f = float(st), float(et if et is not None else st)
            if not in_window(st_f) and not in_window(et_f):
                continue
            # Non-ego actions: only keep if inside the conflict burst band.
            if tid != 0 and not (in_burst(st_f) or in_burst(et_f)):
                continue
            if name == "COLLISION":
                partner = (act.get("attributes") or {}).get("with_name", "")
                out.append((st_f, f"COLLISION_{partner}" if partner else "COLLISION"))
                continue
            if abs(et_f - st_f) > 1e-6:
                out.append((st_f, f"{token}_start_{name}"))
                out.append((et_f, f"{token}_end_{name}"))
            else:
                out.append((st_f, f"{token}_{name}"))
    return out


def select_conflict_frames(
    traj_df: pd.DataFrame,
    action_yaml_path: Optional[str | Path] = None,
    action_data: Optional[Dict[str, Any]] = None,
    *,
    time_steps: Optional[Sequence[float]] = None,
    conflict_window_s: float = DEFAULT_CONFLICT_WINDOW_S,
    conflict_distance_m: float = DEFAULT_CONFLICT_DISTANCE_M,
    conflict_burst_step_s: float = DEFAULT_CONFLICT_BURST_STEP_S,
    hard_brake_accel: float = DEFAULT_HARD_BRAKE_ACCEL,
    min_gap_s: float = DEFAULT_MIN_GAP_S,
) -> SelectionResult:
    """Build the LLM BEV pack selection."""
    df = _normalize_traj_df(traj_df)
    if action_data is None:
        action_data = _load_action(action_yaml_path)

    if time_steps is None:
        time_steps = sorted(float(t) for t in df["time"].unique())
    t_arr = list(time_steps)
    t_min = t_arr[0] if t_arr else 0.0
    t_max = t_arr[-1] if t_arr else 0.0

    anchors = _conflict_anchors(action_data)
    partner_tid: Optional[int] = None
    partner_name = ""
    conflict_times: List[float] = []

    if anchors:
        # Primary partner = first NEAR_MISS/COLLISION partner, else first anchor
        primary = next((a for a in anchors if a[1] in ("COLLISION", "NEAR_MISS")), anchors[0])
        partner_tid = primary[2]
        partner_name = primary[3]
        conflict_times = [a[0] for a in anchors]
    else:
        partner_tid, partner_name, t_fb = _fallback_partner(df, action_data)
        if t_fb is not None:
            conflict_times = [t_fb]
            anchors = [(t_fb, "CLOSEST_APPROACH", partner_tid, partner_name)]

    series = _pair_series(df, partner_tid) if partner_tid is not None else None

    # Relevance: first time partner within D and moving
    relevance_t: Optional[float] = None
    if series is not None:
        moving = series["nv"].abs() > DEFAULT_PARTNER_SPEED_EPS
        near = series["dist"] < conflict_distance_m
        mask = moving & near
        if mask.any():
            relevance_t = float(series.loc[mask, "time"].iloc[0])

    peak_t = conflict_times[0] if conflict_times else None
    if peak_t is None and series is not None and not series.empty:
        i = int(series["dist"].to_numpy().argmin())
        peak_t = float(series["time"].iloc[i])
        conflict_times = [peak_t]

    # --- collect raw (t, label, role, burst_offset) ---
    raw: List[Tuple[float, str, str, Optional[float]]] = []

    def add(t: float, label: str, role: str, burst_offset: Optional[float] = None) -> None:
        # Snap to nearest sample first so peak times slightly past CSV end
        # (e.g. collision at 31.69 with last frame 31.688) are kept.
        tn = _nearest_time(t_arr, t)
        if tn < t_min - 1e-6 or tn > t_max + 1e-6:
            return
        raw.append((tn, label, role, burst_offset))

    # Peak + discrete burst (optional densify via conflict_burst_step_s > 0)
    for tc, typ, _tid, pname in anchors:
        add(tc, f"{typ}_{pname}" if pname else typ, "peak")
        offsets = list(_BURST_OFFSETS)
        if conflict_burst_step_s and conflict_burst_step_s > 1e-9:
            denser = np.arange(-2.0, 1.0 + 1e-9, conflict_burst_step_s)
            for o in denser:
                if not any(abs(o - x) < 1e-6 for x in offsets):
                    offsets.append(float(o))
        for o in offsets:
            if abs(o) < 1e-9:
                continue
            side = "APPROACH" if o < 0 else "POST"
            add(
                tc + o,
                f"{side}_{pname}" if pname else side,
                "burst",
                burst_offset=float(o),
            )

    if relevance_t is not None:
        add(relevance_t, f"RELEVANCE_{partner_name}", "relevance")

    # Criticality extrema in window around peak (global extrema only).
    if series is not None and peak_t is not None:
        lo, hi = peak_t - conflict_window_s, peak_t + conflict_window_s
        win = series[(series["time"] >= lo) & (series["time"] <= hi)]
        if len(win) >= 3:
            dist = win["dist"].to_numpy(float)
            ttc = win["ttc"].to_numpy(float)
            closing = win["closing"].to_numpy(float)
            times = win["time"].to_numpy(float)

            i_dist = int(np.argmin(dist))
            # Skip if coincides with peak (peak label already COLLISION/NEAR_MISS).
            if abs(float(times[i_dist]) - peak_t) > DEFAULT_MIN_GAP_S:
                add(float(times[i_dist]), f"DIST_MIN_{partner_name}", "dist_min")

            finite_ttc = np.where(np.isfinite(ttc) & (ttc < 30), ttc, np.nan)
            if np.isfinite(finite_ttc).any():
                i_ttc = int(np.nanargmin(finite_ttc))
                if abs(float(times[i_ttc]) - peak_t) > DEFAULT_MIN_GAP_S:
                    add(float(times[i_ttc]), f"TTC_MIN_{partner_name}", "ttc_min")

            if closing.max() > 0.5:
                i = int(np.argmax(closing))
                add(float(times[i]), f"MAX_CLOSING_{partner_name}", "closing")

            ego = df[df["trackId"] == 0].sort_values("time")
            if len(ego) > 2 and "velocity" in ego.columns:
                et = ego["time"].to_numpy(float)
                ev = ego["velocity"].to_numpy(float)
                ea = np.gradient(ev, et)
                for i in range(1, len(et)):
                    if et[i] < lo or et[i] > hi:
                        continue
                    if ea[i] <= hard_brake_accel and ea[i - 1] > hard_brake_accel:
                        add(float(et[i]), "ego_HARD_BRAKE", "brake")
                        break

            pet = _pet_time(series, peak_t, min(conflict_window_s, 4.0))
            if pet is not None:
                add(pet, f"PET_{partner_name}", "pet")

    # Action-boundary frames inside W or within D of a moving partner.
    # (Not the full dense action pack — junction-only noise is filtered elsewhere.)
    for t, lab in _candidate_action_times(
        action_data, conflict_times or ([peak_t] if peak_t is not None else []), conflict_window_s
    ):
        keep = False
        if conflict_times and any(abs(t - tc) <= conflict_window_s for tc in conflict_times):
            keep = True
        elif series is not None:
            m = _metrics_at(series, t, partner_name, partner_tid)
            if m["d_m"] is not None and m["d_m"] < conflict_distance_m:
                if m["v_partner"] is not None and abs(m["v_partner"]) > DEFAULT_PARTNER_SPEED_EPS:
                    keep = True
        if keep:
            add(t, lab, "action")

    # Merge by min_gap; prefer peak/burst/relevance roles
    role_priority = {
        "peak": 0, "relevance": 1, "brake": 2, "dist_min": 3, "ttc_min": 3,
        "closing": 4, "pet": 4, "burst": 5, "action": 6, "whole": 7,
    }
    raw.sort(key=lambda x: (x[0], role_priority.get(x[2], 9)))
    merged: List[Tuple[float, str, str, Optional[float]]] = []
    for t, lab, role, bo in raw:
        if merged and abs(t - merged[-1][0]) < min_gap_s:
            prev_t, prev_lab, prev_role, prev_bo = merged[-1]
            if role_priority.get(role, 9) < role_priority.get(prev_role, 9):
                merged[-1] = (t, lab, role, bo)
            elif role_priority.get(role, 9) == role_priority.get(prev_role, 9) and lab != prev_lab:
                if lab not in prev_lab:
                    merged[-1] = (prev_t, f"{prev_lab}+{lab}"[:80], prev_role, prev_bo)
            continue
        merged.append((t, lab, role, bo))

    ctx_tid, ctx_name = _context_partner_for_stationary(
        df, action_data, partner_tid, peak_t
    )

    frames: List[SelectedFrame] = []
    for t, lab, role, bo in merged:
        m = _metrics_at(series, t, partner_name, partner_tid)
        # Whole-scene left panel only at relevance start (peak stays pair|ego).
        use_whole = role == "relevance" or (
            relevance_t is not None and abs(t - relevance_t) < 1e-3
        )
        frames.append(SelectedFrame(
            t=round(t, 3),
            label=lab,
            role=role,
            partner_name=partner_name,
            partner_track_id=partner_tid,
            context_partner_name=ctx_name,
            context_partner_track_id=ctx_tid,
            d_m=m["d_m"],
            ttc_s=m["ttc_s"],
            v_ego=m["v_ego"],
            v_partner=m["v_partner"],
            az_deg=m["az_deg"],
            closing_mps=m["closing_mps"],
            ego_road=m["ego_road"],
            ego_lane=m["ego_lane"],
            partner_road=m["partner_road"],
            partner_lane=m["partner_lane"],
            use_whole_scene=use_whole,
            draw_agent_road_labels=role in (
                "peak", "burst", "brake", "dist_min", "ttc_min", "closing", "pet",
                "relevance", "action",
            ),
            burst_offset_s=bo,
        ))

    return SelectionResult(
        frames=frames,
        conflict_times=conflict_times,
        partner_track_id=partner_tid,
        partner_name=partner_name,
        context_partner_track_id=ctx_tid,
        context_partner_name=ctx_name,
        relevance_t=relevance_t,
        peak_t=peak_t,
    )


def format_snapshot_evidence_block(
    selection: SelectionResult,
    filenames: Sequence[str],
) -> str:
    """Markdown-ish text block for description.txt."""
    lines = [
        "## Snapshot evidence (LLM pack)",
        AZIMUTH_GLOSSARY,
        "",
        "| t(s) | event | d(m) | ttc(s) | v_ego | v_opp | az(deg) | ego_road/lane | opp_road/lane |",
        "|------|-------|------|--------|-------|-------|---------|---------------|---------------|",
    ]
    for fr, fname in zip(selection.frames, filenames):
        event = fr.label.replace("|", "/")
        lines.append(
            "| {t:.2f} | {ev} | {d} | {ttc} | {ve} | {vp} | {az} | {er} | {pr} |".format(
                t=fr.t,
                ev=event[:40],
                d="—" if fr.d_m is None else f"{fr.d_m:.2f}",
                ttc="—" if fr.ttc_s is None else f"{fr.ttc_s:.2f}",
                ve="—" if fr.v_ego is None else f"{fr.v_ego:.2f}",
                vp="—" if fr.v_partner is None else f"{fr.v_partner:.2f}",
                az="—" if fr.az_deg is None else f"{fr.az_deg:.1f}",
                er=_road_lane(fr.ego_road, fr.ego_lane),
                pr=_road_lane(fr.partner_road, fr.partner_lane),
            )
        )
    lines.append("")
    lines.append("Frames:")
    for fr, fname in zip(selection.frames, filenames):
        note = fr.role
        if fr.role == "peak":
            note = "peak conflict"
        elif fr.role == "relevance":
            note = "partner enters relevance distance"
        elif fr.role == "burst":
            if fr.burst_offset_s is not None:
                note = f"conflict burst ({_burst_offset_slug(fr.burst_offset_s).replace('_', ' ')})"
            else:
                note = "conflict burst sample"
        lines.append(f"  - {fname}  — {note}")
    lines.append("")
    return "\n".join(lines)


def pair_zoom_bounds(
    ego_xy: Tuple[float, float],
    partner_xy: Optional[Tuple[float, float]],
    margin_m: float = DEFAULT_PAIR_MARGIN_M,
    min_half: float = 15.0,
    extra_xy: Optional[Sequence[Tuple[float, float]]] = None,
) -> Tuple[float, float, float, float]:
    """Axis-aligned bounds covering ego + partner (+ optional context agents)."""
    pts: List[Tuple[float, float]] = [ego_xy]
    if partner_xy is not None:
        pts.append(partner_xy)
    if extra_xy:
        pts.extend(list(extra_xy))
    xs = [p[0] for p in pts]
    ys = [p[1] for p in pts]
    cx, cy = (min(xs) + max(xs)) / 2.0, (min(ys) + max(ys)) / 2.0
    half = max(
        min_half,
        (max(xs) - min(xs)) / 2.0 + margin_m,
        (max(ys) - min(ys)) / 2.0 + margin_m,
    )
    return (cx - half, cx + half, cy - half, cy + half)
