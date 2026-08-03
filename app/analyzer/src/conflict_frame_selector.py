"""Action-derived BEV frame pack for Path A (xosc_gen Steps 1→2→2.5).

BEV timestamps come from ``action.yaml`` (agent action boundaries + interaction
key times) plus optional **burst samples** around labelled COLLISION / NEAR_MISS
peaks (offsets like −2…+1 s). Metrics (d/ttc/az) annotate those times for
``description.txt`` evidence — they must never invent new event labels such as
``HARD_BRAKE`` / ``MAX_CLOSING`` from raw kinematics.
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

# Defaults (also exposed as dataset_builder CLI flags for near-conflict filter).
DEFAULT_CONFLICT_WINDOW_S = 8.0  # legacy ±W / after-window default
DEFAULT_CONFLICT_WINDOW_BEFORE_S = 15.0  # include pre-conflict setup maneuvers
DEFAULT_CONFLICT_WINDOW_AFTER_S = 8.0
DEFAULT_CONFLICT_DISTANCE_M = 50.0
DEFAULT_PARTNER_SPEED_EPS = 0.3
DEFAULT_HEADING_TURN_DEG = 25.0
DEFAULT_MIN_GAP_S = 0.1
DEFAULT_PAIR_MARGIN_M = 12.0
DEFAULT_ACTION_MIN_GAP_S = 0.1

# Discrete burst offsets around labelled COLLISION / NEAR_MISS peak (seconds).
_BURST_OFFSETS = (-2.0, -1.0, -0.5, -0.2, 0.0, 0.2, 0.5, 1.0)

_CONFLICT_TYPES = frozenset(
    {"COLLISION", "NEAR_MISS", "CLOSEST_APPROACH", "DANGEROUS_CUT_IN"}
)
_JUNCTION_ACTIONS = frozenset({"ENTER_JUNCTION", "EXIT_JUNCTION"})

# Semantic maneuver events (skip MAINTAIN_SPEED / DECELERATE when semantic_only).
SEMANTIC_ACTION_TYPES = frozenset({
    "LANE_CHANGE_LEFT",
    "LANE_CHANGE_RIGHT",
    "TURN_LEFT",
    "TURN_RIGHT",
    "ENTER_JUNCTION",
    "EXIT_JUNCTION",
    "EMERGENCY_BRAKE",
    "STOPPED",
})

# Ego actions kept even outside the conflict window (route-level turns matter
# after the near-miss as much as during it).
_ALWAYS_KEEP_EGO_ACTIONS = frozenset({
    "COLLISION",
    "TURN_LEFT",
    "TURN_RIGHT",
})

AZIMUTH_GLOSSARY = (
    "Azimuth (az): bearing of the conflict partner relative to ego heading, "
    "degrees in [-180, 180]; 0=ahead, +left, -right, ±180=behind. "
    "TTC=time-to-collision (s). d=center distance (m)."
)


def _burst_offset_phrase(offset_s: float) -> str:
    """Human phrase for conflict-burst timing, e.g. ``0.2s before`` / ``1s after``."""
    mag = abs(float(offset_s))
    if abs(mag - round(mag)) < 1e-6:
        tok = f"{int(round(mag))}s"
    else:
        tok = f"{mag:.1f}s"
    return f"{tok} before" if float(offset_s) < 0 else f"{tok} after"


def _burst_offset_slug(offset_s: float) -> str:
    """Filename token for burst offset, e.g. ``0p2s_before`` / ``1s_after``."""
    return (
        _burst_offset_phrase(offset_s)
        .replace(" ", "_")
        .replace(".", "p")
    )


def _combine_labels(prev: str, new: str, max_parts: int = 3) -> str:
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
    role = str(agent.get("role", "")).lower()
    tid = agent.get("track_id")
    if role == "ego" or tid == 0:
        return "ego"
    return str(agent.get("name") or f"agent{tid}")


@dataclass
class SelectedFrame:
    t: float
    label: str
    role: str  # peak | burst | action | interaction
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
    use_whole_scene: bool = False
    draw_agent_road_labels: bool = True
    burst_offset_s: Optional[float] = None

    def concise_slug(self) -> str:
        """Short filename / BEV-title event token (shared by medoid + IC pair).

        Includes burst timing when present, e.g. ``0p5s_before_APPROACH_Opposite``.
        Medoid dual-panel titles and IC synced titles both use this — do not
        invent a second formatter.
        """
        parts: List[str] = []
        if self.burst_offset_s is not None and abs(self.burst_offset_s) > 1e-9:
            parts.append(_burst_offset_slug(self.burst_offset_s))
        event = self.label.split("+")[0].strip() if self.label else self.role
        event = event.replace(" ", "_")
        if len(event) > 40:
            event = event[:40]
        parts.append(event or self.role)
        if self.partner_name and self.partner_name.lower() not in event.lower():
            if self.role in ("peak", "burst") or "COLLISION" in event.upper() or "NEAR_MISS" in event.upper():
                if self.partner_name not in "_".join(parts):
                    parts.append(self.partner_name)
        slug = "_".join(parts)
        return "".join(c if c.isalnum() or c in "-_" else "_" for c in slug).strip("_")[:72]

    def title_event(self) -> str:
        """BEV composite title event — alias of ``concise_slug`` (one rule)."""
        return self.concise_slug()

    def timeline_gloss(self) -> str:
        """Context.md event gloss, including burst offset when present."""
        gloss = _event_gloss(self.label)
        if self.burst_offset_s is not None and abs(float(self.burst_offset_s)) > 1e-9:
            return f"{_burst_offset_phrase(self.burst_offset_s)} {gloss}"
        return gloss


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
        names = list(dict.fromkeys(out["name"].astype(str)))
        name_to_id: Dict[str, int] = {}
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
    dx, dy = px - ego_x, py - ego_y
    bearing = math.atan2(dy, dx)
    return _wrap_deg(math.degrees(bearing - ego_h_rad))


def _heading_to_rad(h: float) -> float:
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
    """Return (t*, type, partner_tid, partner_name) from action.yaml only."""
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
    merged: List[Tuple[float, str, Optional[int], str]] = []
    for a in anchors:
        if merged and abs(a[0] - merged[-1][0]) < 0.05:
            if a[1] in ("COLLISION", "NEAR_MISS") and merged[-1][1] not in ("COLLISION", "NEAR_MISS"):
                merged[-1] = a
            continue
        merged.append(a)
    return merged


def _pair_series(df: pd.DataFrame, partner_tid: int) -> Optional[pd.DataFrame]:
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
    id_to_name = _agent_name_map(action_data)
    best: Optional[Tuple[float, int, float]] = None
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
    if primary_tid is None or peak_t is None:
        return None, ""
    id_to_name = _agent_name_map(action_data)
    primary = _pair_series(df, primary_tid)
    if primary is None or primary.empty:
        return None, ""
    i = int(np.argmin(np.abs(primary["time"].to_numpy(float) - peak_t)))
    if abs(float(primary["nv"].iloc[i])) > DEFAULT_PARTNER_SPEED_EPS:
        return None, ""

    best: Optional[Tuple[float, int]] = None
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


def _is_straight_junction_action(act: Dict[str, Any]) -> bool:
    name = str(act.get("action", ""))
    if name not in _JUNCTION_ACTIONS:
        return False
    attrs = act.get("attributes") or {}
    intent = str(attrs.get("intent", "GO_STRAIGHT"))
    heading = abs(float(attrs.get("heading_change_deg", 0) or 0))
    return intent == "GO_STRAIGHT" and heading < DEFAULT_HEADING_TURN_DEG


def extract_action_timestamps(
    action_yaml_path: Optional[str | Path] = None,
    action_data: Optional[Dict[str, Any]] = None,
    *,
    min_gap: float = DEFAULT_ACTION_MIN_GAP_S,
    semantic_only: bool = False,
) -> List[Tuple[float, str]]:
    """Extract ``(t, label)`` from action.yaml — sole BEV timestamp source.

    Mirrors xosc_gen ``extract_action_timestamps`` for the gpl-odd schema
    (top-level start/end + interactions key_time / cut_in_time).
    """
    if action_data is None:
        action_data = _load_action(action_yaml_path)
    if not action_data:
        return []

    agents = action_data.get("agents") or []
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
            if name == "COLLISION":
                partner = attrs.get("with_name")
                suffix = f" with {partner}" if partner else ""
                raw.append((st, f"{token} {name}{suffix}"))
                continue
            if et - st > 1e-6:
                raw.append((st, f"{token} start {name}"))
                raw.append((et, f"{token} end {name}"))
            else:
                raw.append((st, f"{token} {name}"))

    for inter in action_data.get("interactions") or []:
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


def _resolve_conflict_windows(
    *,
    conflict_window_s: Optional[float] = None,
    conflict_window_before_s: float = DEFAULT_CONFLICT_WINDOW_BEFORE_S,
    conflict_window_after_s: float = DEFAULT_CONFLICT_WINDOW_AFTER_S,
) -> Tuple[float, float]:
    """Return (before, after) seconds around conflict peak.

    If ``conflict_window_s`` is set (legacy ±W API), both sides use that value.
    Otherwise use the asymmetric before/after defaults (15 s pre / 8 s post).
    """
    if conflict_window_s is not None:
        w = float(conflict_window_s)
        return w, w
    return float(conflict_window_before_s), float(conflict_window_after_s)


def _noise_filtered_action_times(
    action_data: Optional[Dict[str, Any]],
    conflict_times: Sequence[float],
    window_before_s: float,
    window_after_s: float,
) -> List[Tuple[float, str]]:
    """Subset of action boundaries: demote junction noise / far NPC STOPPED.

    Never invents times — only removes stamps that are not useful for the LLM pack.
    Conflict interaction / COLLISION times are always kept via
    ``extract_action_timestamps`` merge with anchors in ``select_action_frames``.
    """
    if not action_data:
        return []
    out: List[Tuple[float, str]] = []
    id_to_name = _agent_name_map(action_data)
    before = float(window_before_s)
    after = float(window_after_s)

    def in_window(t: float) -> bool:
        if not conflict_times:
            return True
        return any(
            (float(tc) - before) <= t <= (float(tc) + after) for tc in conflict_times
        )

    for agent in action_data.get("agents") or []:
        tid = int(agent.get("track_id", -1))
        token = "ego" if tid == 0 else str(agent.get("name") or id_to_name.get(tid, f"a{tid}"))
        for act in agent.get("actions") or []:
            name = str(act.get("action", "action"))
            if _is_straight_junction_action(act):
                continue
            if name == "MAINTAIN_SPEED" and tid != 0:
                continue
            if name == "STOPPED" and tid != 0:
                continue
            st = act.get("start_time")
            et = act.get("end_time", st)
            if st is None:
                continue
            st_f, et_f = float(st), float(et if et is not None else st)
            if conflict_times and not (in_window(st_f) or in_window(et_f)):
                # Always keep ego COLLISION / same-lane TURN_* even slightly outside W.
                if not (tid == 0 and name in _ALWAYS_KEEP_EGO_ACTIONS):
                    continue
            if name == "COLLISION":
                # Ego (and interactions) already emit the conflict peak — skip the
                # mirrored NPC-side COLLISION (partner=Ego) which garbles the slug.
                if tid != 0:
                    continue
                partner = (act.get("attributes") or {}).get("with_name", "")
                out.append((st_f, f"COLLISION_{partner}" if partner else "COLLISION"))
                continue
            if abs(et_f - st_f) > 1e-6:
                out.append((st_f, f"{token}_start_{name}"))
                out.append((et_f, f"{token}_end_{name}"))
            else:
                out.append((st_f, f"{token}_{name}"))
    return out


def select_action_frames(
    traj_df: pd.DataFrame,
    action_yaml_path: Optional[str | Path] = None,
    action_data: Optional[Dict[str, Any]] = None,
    *,
    time_steps: Optional[Sequence[float]] = None,
    conflict_window_s: Optional[float] = None,
    conflict_window_before_s: float = DEFAULT_CONFLICT_WINDOW_BEFORE_S,
    conflict_window_after_s: float = DEFAULT_CONFLICT_WINDOW_AFTER_S,
    min_gap_s: float = DEFAULT_MIN_GAP_S,
) -> SelectionResult:
    """Build BEV pack from action.yaml + burst around labelled conflict peaks.

    Burst offsets (−2…+1 s) sample geometry around COLLISION / NEAR_MISS
    ``key_time`` from action.yaml — they do **not** invent new event types.

    Action stamps are kept in ``[peak − before, peak + after]`` (defaults 15 s /
    8 s). Pass ``conflict_window_s`` for legacy symmetric ±W.
    """
    df = _normalize_traj_df(traj_df)
    if action_data is None:
        action_data = _load_action(action_yaml_path)

    if time_steps is None:
        time_steps = sorted(float(t) for t in df["time"].unique())
    t_arr = list(time_steps)
    t_min = t_arr[0] if t_arr else 0.0
    t_max = t_arr[-1] if t_arr else 0.0

    win_before, win_after = _resolve_conflict_windows(
        conflict_window_s=conflict_window_s,
        conflict_window_before_s=conflict_window_before_s,
        conflict_window_after_s=conflict_window_after_s,
    )

    anchors = _conflict_anchors(action_data)
    partner_tid: Optional[int] = None
    partner_name = ""
    conflict_times: List[float] = []

    if anchors:
        primary = next((a for a in anchors if a[1] in ("COLLISION", "NEAR_MISS")), anchors[0])
        partner_tid = primary[2]
        partner_name = primary[3]
        conflict_times = [a[0] for a in anchors]
    else:
        partner_tid, partner_name, _t_fb = _fallback_partner(df, action_data)

    series = _pair_series(df, partner_tid) if partner_tid is not None else None
    peak_t = conflict_times[0] if conflict_times else None

    # (t, label, role, burst_offset)
    raw: List[Tuple[float, str, str, Optional[float]]] = []

    def add(t: float, label: str, role: str, burst_offset: Optional[float] = None) -> None:
        tn = _nearest_time(t_arr, t)
        if tn < t_min - 1e-6 or tn > t_max + 1e-6:
            return
        raw.append((tn, label, role, burst_offset))

    for tc, typ, _tid, pname in anchors:
        add(tc, f"{typ}_{pname}" if pname else typ, "peak")
        for o in _BURST_OFFSETS:
            if abs(o) < 1e-9:
                continue
            side = "APPROACH" if o < 0 else "POST"
            add(
                tc + o,
                f"{side}_{pname}" if pname else side,
                "burst",
                burst_offset=float(o),
            )

    for t, lab in _noise_filtered_action_times(
        action_data, conflict_times, win_before, win_after
    ):
        role = "peak" if "COLLISION" in lab.upper() else "action"
        add(t, lab, role)

    for t, lab in extract_action_timestamps(action_data=action_data, min_gap=min_gap_s):
        upper = lab.upper()
        if any(k in upper for k in ("NEAR_MISS", "DANGEROUS_CUT_IN", "CLOSEST_APPROACH")):
            add(t, lab.replace(" ", "_"), "interaction")

    role_priority = {"peak": 0, "burst": 1, "interaction": 2, "action": 3}
    raw.sort(key=lambda x: (x[0], role_priority.get(x[2], 9)))
    merged: List[Tuple[float, str, str, Optional[float]]] = []
    for t, lab, role, bo in raw:
        if merged and abs(t - merged[-1][0]) < min_gap_s:
            prev_t, prev_lab, prev_role, prev_bo = merged[-1]
            # Always keep both labels when times collide — e.g. POST burst must
            # not erase ego_start_TURN_LEFT at the same stamp.
            if role_priority.get(role, 9) < role_priority.get(prev_role, 9):
                combined = (
                    lab if prev_lab in lab else _combine_labels(lab, prev_lab)
                )
                merged[-1] = (t, combined, role, bo)
            else:
                if lab != prev_lab and lab not in prev_lab:
                    merged[-1] = (
                        prev_t,
                        _combine_labels(prev_lab, lab),
                        prev_role,
                        prev_bo,
                    )
            continue
        merged.append((t, lab, role, bo))

    ctx_tid, ctx_name = _context_partner_for_stationary(
        df, action_data, partner_tid, peak_t
    )

    frames: List[SelectedFrame] = []
    for t, lab, role, bo in merged:
        m = _metrics_at(series, t, partner_name, partner_tid)
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
            use_whole_scene=False,
            draw_agent_road_labels=True,
            burst_offset_s=bo,
        ))

    return SelectionResult(
        frames=frames,
        conflict_times=conflict_times,
        partner_track_id=partner_tid,
        partner_name=partner_name,
        context_partner_track_id=ctx_tid,
        context_partner_name=ctx_name,
        relevance_t=None,
        peak_t=peak_t,
    )


# Back-compat alias used by older call sites / docs.
def select_conflict_frames(*args, **kwargs) -> SelectionResult:
    """Deprecated alias for :func:`select_action_frames`."""
    # Drop inventing-only kwargs silently.
    kwargs.pop("conflict_distance_m", None)
    kwargs.pop("conflict_burst_step_s", None)
    kwargs.pop("hard_brake_accel", None)
    return select_action_frames(*args, **kwargs)


def _bearing_sector(az_deg: float) -> str:
    """FRONT/LEFT/... bins matching LLM-ODD context_builder thresholds."""
    deg = float(az_deg)
    if -30 <= deg <= 30:
        return "FRONT"
    if 30 < deg <= 60:
        return "FRONT LEFT"
    if 60 < deg <= 120:
        return "LEFT"
    if 120 < deg <= 150:
        return "BEHIND LEFT"
    if -60 < deg < -30:
        return "FRONT RIGHT"
    if -120 <= deg < -60:
        return "RIGHT"
    if -150 < deg < -120:
        return "BEHIND RIGHT"
    return "BEHIND"


def _distance_band(d_m: float) -> str:
    if d_m >= 40.0:
        return "far"
    if d_m >= 15.0:
        return "moderate"
    if d_m >= 5.0:
        return "near"
    return "very close"


def _event_gloss_one(label: str) -> str:
    lab = str(label or "")
    _start = {
        "DECELERATE": "decelerating",
        "ACCELERATE": "accelerating",
        "EMERGENCY_BRAKE": "emergency braking",
        "MAINTAIN_SPEED": "maintaining speed",
        "STOPPED": "stopping",
        "LANE_CHANGE_LEFT": "a left lane change",
        "LANE_CHANGE_RIGHT": "a right lane change",
        "TURN_LEFT": "turning left on the same lane (heading change)",
        "TURN_RIGHT": "turning right on the same lane (heading change)",
        "ENTER_JUNCTION": "entering a junction",
        "EXIT_JUNCTION": "exiting a junction",
    }
    _end = {
        "DECELERATE": "deceleration",
        "ACCELERATE": "acceleration",
        "EMERGENCY_BRAKE": "emergency braking",
        "LANE_CHANGE_LEFT": "a left lane change",
        "LANE_CHANGE_RIGHT": "a right lane change",
        "TURN_LEFT": "a left turn on the same lane (heading change)",
        "TURN_RIGHT": "a right turn on the same lane (heading change)",
    }
    if lab.startswith("ego_start_"):
        act = lab[len("ego_start_") :]
        return f"Ego begins {_start.get(act, act.lower().replace('_', ' '))}"
    if lab.startswith("ego_end_"):
        act = lab[len("ego_end_") :]
        return f"Ego ends {_end.get(act, act.lower().replace('_', ' '))}"
    if lab.startswith("APPROACH_"):
        return f"approach phase with {lab[len('APPROACH_'):]}"
    if lab.startswith("POST_"):
        return f"post-conflict phase with {lab[len('POST_'):]}"
    if lab.startswith("NEAR_MISS_"):
        return f"near-miss with {lab[len('NEAR_MISS_'):]}"
    if lab.startswith("COLLISION_"):
        return f"collision with {lab[len('COLLISION_'):]}"
    if lab.startswith("CLOSEST_APPROACH_"):
        return f"closest approach with {lab[len('CLOSEST_APPROACH_'):]}"
    m = re.match(r"^(.+?)_(start|end)_(.+)$", lab)
    if m:
        who, kind, act = m.group(1), m.group(2), m.group(3)
        gloss = _start.get(act, act.lower().replace("_", " ")) if kind == "start" else _end.get(
            act, act.lower().replace("_", " ")
        )
        return f"{who} {'begins' if kind == 'start' else 'ends'} {gloss}"
    return lab.replace("_", " ")


def _event_gloss(label: str) -> str:
    """Human gloss; supports ``A+B`` combined stamps from merge."""
    lab = str(label or "")
    if "+" not in lab:
        return _event_gloss_one(lab)
    parts = [p.strip() for p in lab.split("+") if p.strip()]
    glosses: List[str] = []
    for p in parts:
        g = _event_gloss_one(p)
        if g and g not in glosses:
            glosses.append(g)
    return "; ".join(glosses) if glosses else lab.replace("_", " ")


def _partner_relation_phrase(
    partner: str, sector: str, band: str, d_m: float, az_deg: float
) -> str:
    name = partner or "the conflict partner"
    sector_phrase = {
        "FRONT": f"{name} is {band} ahead of Ego",
        "FRONT LEFT": f"{name} is {band} front-left of Ego",
        "LEFT": f"{name} is {band} on Ego's left",
        "BEHIND LEFT": f"{name} is {band} behind-left of Ego",
        "FRONT RIGHT": f"{name} is {band} front-right of Ego",
        "RIGHT": f"{name} is {band} on Ego's right",
        "BEHIND RIGHT": f"{name} is {band} behind-right of Ego",
        "BEHIND": f"{name} is {band} behind Ego",
    }.get(sector, f"{name} is {band} relative to Ego ({sector})")
    return (
        f"{sector_phrase} (d={d_m:.1f} m), "
        f"azimuth {sector} (azimuth = {az_deg:.1f} degree)"
    )


def format_conflict_timeline_sentences(
    selection: SelectionResult,
    filenames: Optional[Sequence[str]] = None,
    action_data: Optional[Dict[str, Any]] = None,
    traj_df: Optional[pd.DataFrame] = None,
    map_tracks_csv: Optional[str] = None,
    *,
    clock_offset_s: float = 0.0,
    clock_name: str = "",
) -> str:
    """Complete-sentence conflict timeline for LLM ``context.md`` (no raw table).

    Includes longitudinal / lateral / route-level (same-lane TURN_*) action
    stamps in one chronological list — heading arcs are not a separate section.

    ``clock_offset_s`` subtracts from each stamp (e.g. StartValidCondition clip so
    times match Explore Replayer / synced IC BEVs). ``clock_name`` is noted in
    the section intro when non-empty.
    """
    clock_note = (
        f" Times use the {clock_name} clock (esmini − {float(clock_offset_s):.2f} s)."
        if clock_name
        else ""
    )
    lines = [
        "## Conflict timeline (rule-based)",
        "",
        "Chronological BEV/action stamps (speed, lane change, same-lane turn, "
        "conflict bursts). Metric definitions live in the LLM domain glossary "
        f"(common_sense), not here. Use description table `v_lat (m/s)` for "
        f"speed-aware lateral effect checks.{clock_note}",
        "",
    ]
    partner_fallback = selection.partner_name or "Opposite"
    off = float(clock_offset_s or 0.0)
    for i, fr in enumerate(selection.frames):
        gloss = (
            fr.timeline_gloss()
            if hasattr(fr, "timeline_gloss")
            else _event_gloss(fr.label)
        )
        t_disp = float(fr.t) - off
        parts = [f"At t={t_disp:.2f} s, {gloss}"]
        turn_extra = _turn_detail_phrase(fr.label, fr.t, action_data)
        if turn_extra:
            parts.append(turn_extra)
        if fr.d_m is not None and fr.az_deg is not None:
            sector = _bearing_sector(fr.az_deg)
            band = _distance_band(float(fr.d_m))
            pname = fr.partner_name or partner_fallback
            parts.append(
                _partner_relation_phrase(
                    pname, sector, band, float(fr.d_m), float(fr.az_deg)
                )
            )
        if traj_df is not None:
            try:
                from kinematics_context import sample_kinematics_at_time

                k = sample_kinematics_at_time(
                    traj_df,
                    track_id=0,
                    t=float(fr.t),
                    partner_tid=fr.partner_track_id,
                    map_tracks_csv=map_tracks_csv,
                )
                if k and k.get("v_lat") is not None and k.get("vs_road") is not None:
                    vlat = float(k["v_lat"])
                    side = "left" if vlat > 1e-6 else ("right" if vlat < -1e-6 else "neutral")
                    mag = abs(vlat)
                    if mag < 0.3:
                        eff = "low"
                    elif mag <= 0.8:
                        eff = "moderate"
                    else:
                        eff = "strong"
                    parts.append(
                        f"lateral: v_lat={vlat:+.2f} m/s ({eff} lateral {side}, "
                        f"vs_road={float(k['vs_road']):+.1f}°)"
                    )
            except Exception:
                pass
        if fr.ttc_s is not None and float(fr.ttc_s) < 5.0:
            parts.append(f"TTC ≈ {float(fr.ttc_s):.2f} s")
        if fr.v_ego is not None:
            parts.append(f"v_ego={float(fr.v_ego):.2f} m/s")
        sentence = "; ".join(parts) + "."
        lines.append(f"- {sentence}")
        if filenames is not None and i < len(filenames):
            lines.append(f"  - frame: `{filenames[i]}`")
    lines.append("")
    return "\n".join(lines)


def _turn_detail_phrase(
    label: str, t: float, action_data: Optional[Dict[str, Any]]
) -> Optional[str]:
    """Pull Δheading / path-tangent attrs for TURN_* stamps from action.yaml."""
    if action_data is None:
        return None
    upper = label.upper()
    wants = [w for w in ("TURN_LEFT", "TURN_RIGHT") if w in upper]
    if not wants:
        return None

    def _bits_for(want: str) -> Optional[str]:
        for agent in action_data.get("agents") or []:
            if int(agent.get("track_id", -1)) != 0:
                continue
            for act in agent.get("actions") or []:
                if str(act.get("action")) != want:
                    continue
                st = float(act.get("start_time", -1))
                et = float(act.get("end_time", st))
                if abs(t - st) > 0.15 and abs(t - et) > 0.15:
                    continue
                attrs = act.get("attributes") or {}
                dhdg = attrs.get("heading_change_deg")
                h0 = attrs.get("heading_start_deg")
                h1 = attrs.get("heading_end_deg")
                side = "left" if want == "TURN_LEFT" else "right"
                parts = []
                if dhdg is not None and h0 is not None and h1 is not None:
                    parts.append(
                        f"{side} Δheading = {dhdg}° (nose {h0}° → {h1}°)"
                    )
                elif dhdg is not None:
                    parts.append(f"{side} Δheading = {dhdg}°")
                vp0, vp1 = attrs.get("vs_path_start_deg"), attrs.get("vs_path_end_deg")
                if vp0 is not None and vp1 is not None:
                    parts.append(
                        f"heading vs road direction {vp0:+.1f}° → {vp1:+.1f}° "
                        f"(0° = nose parallel to road)"
                    )
                return "; ".join(parts) if parts else None
        return None

    chunks = [b for w in wants if (b := _bits_for(w))]
    return "; ".join(chunks) if chunks else None


def format_bev_frame_index(
    selection: SelectionResult,
    filenames: Sequence[str],
) -> str:
    """Short human-facing BEV filename list (no metrics table)."""
    lines = ["## BEV frames", ""]
    for fr, fname in zip(selection.frames, filenames):
        if fr.role == "peak":
            note = "peak conflict"
        elif fr.role == "burst":
            note = "conflict burst"
        elif fr.role == "interaction":
            note = "interaction key_time"
        else:
            note = "action boundary"
        lines.append(f"- `{fname}` — {note} (t={fr.t:.2f}s)")
    lines.append("")
    return "\n".join(lines)


def format_conflict_checkpoint_index(
    selection: SelectionResult,
    filenames: Sequence[str],
) -> str:
    """Human-facing burst/peak checkpoints for BEV↔description cross-check."""
    lines = ["## Conflict checkpoints", ""]
    added = 0
    for fr, fname in zip(selection.frames, filenames):
        if fr.role not in {"peak", "burst", "interaction"}:
            continue
        gloss = (
            fr.timeline_gloss()
            if hasattr(fr, "timeline_gloss")
            else _event_gloss(fr.label)
        )
        lines.append(f"- t={fr.t:.2f}s: {gloss}")
        lines.append(f"  - frame: `{fname}`")
        added += 1
    if added == 0:
        lines.append("- (no conflict burst checkpoints in this pack)")
    lines.append("")
    return "\n".join(lines)


def format_snapshot_evidence_block(
    selection: SelectionResult,
    filenames: Sequence[str],
) -> str:
    """Deprecated raw table — prefer :func:`format_conflict_timeline_sentences`.

    Kept for debug / tests; not attached to human ``description.txt``.
    """
    lines = [
        "## Snapshot evidence (debug table)",
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
        if fr.role == "peak":
            note = "peak conflict (from action.yaml)"
        elif fr.role == "burst":
            if fr.burst_offset_s is not None:
                note = f"conflict burst ({_burst_offset_slug(fr.burst_offset_s).replace('_', ' ')})"
            else:
                note = "conflict burst sample"
        elif fr.role == "interaction":
            note = "interaction key_time (from action.yaml)"
        else:
            note = "action boundary (from action.yaml)"
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
