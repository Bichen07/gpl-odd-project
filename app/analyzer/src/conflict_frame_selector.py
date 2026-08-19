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
# Ego-frame longitudinal band treated as overlapping (≈ half vehicle length).
PASS_LONG_OVERLAP_M = 2.5
PASS_HYSTERESIS_S = 0.3
ROLLING_WINDOW_S = 1.0
# Adaptive BEV: half-extent = ego–partner distance + margin, clamped.
ADAPTIVE_BEV_MARGIN_M = 2.0
ADAPTIVE_BEV_MIN_HALF_M = 8.0
ADAPTIVE_BEV_MAX_HALF_M = 40.0
ADAPTIVE_BEV_FOOTPRINT_PAD_M = 2.6

# Discrete burst offsets around labelled COLLISION / NEAR_MISS peak (seconds).
_BURST_OFFSETS = (-2.0, -1.0, -0.5, -0.2, 0.0, 0.2, 0.5, 1.0)

# Geometry peaks that earn a ± burst ring. DANGEROUS_CUT_IN / CLOSEST_APPROACH
# may still appear as single stamps, but must not spawn a second burst fan.
_BURST_TYPES = frozenset({"COLLISION", "NEAR_MISS"})

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
    "partner azimuth relative to ego heading: bearing of the conflict partner, "
    "degrees in [-180, 180]; 0=ahead, +=left, −=right, ±180=behind. "
    "estimated time to collision: seconds until the center-to-center distance "
    "would reach zero if its current closing rate stayed constant. "
    "center-to-center distance: distance between the two vehicle centers (m). "
    "center-distance closing/opening rate: rate of change of that distance "
    "(m/s); closing means approaching. partner position in ego coordinates: "
    "longitudinal distance ahead/behind and lateral distance left/right. "
    "minimum distance between vehicle boundaries: shortest Euclidean distance "
    "between the two oriented vehicle rectangles (m). longitudinal relationship: "
    "partner ahead, vehicle lengths overlapping longitudinally, or partner behind. "
    "ego average speed during previous 1 second: prefer this over one sample."
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
    d: Optional[float] = None
    ttc: Optional[float] = None
    v_ego: Optional[float] = None
    v_partner: Optional[float] = None
    az: Optional[float] = None
    closing: Optional[float] = None
    ego_road: Optional[int] = None
    ego_lane: Optional[int] = None
    partner_road: Optional[int] = None
    partner_lane: Optional[int] = None
    rel_long_m: Optional[float] = None
    rel_lat_m: Optional[float] = None
    clearance_m: Optional[float] = None
    pass_state: Optional[str] = None
    rolling_disp_1s_m: Optional[float] = None
    rolling_speed_1s_mps: Optional[float] = None
    camera_half_m: Optional[float] = None
    view_yaw_deg: Optional[float] = None
    use_whole_scene: bool = False
    draw_agent_road_labels: bool = True
    burst_offset_s: Optional[float] = None

    def concise_slug(self) -> str:
        """Short filename / BEV-title event token (shared by medoid + Parameter-space pair).

        Includes burst timing when present, e.g. ``0p5s_before_APPROACH_Opposite``.
        Medoid and parameter-space synced titles both use this — do not
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

    def timeline_gloss(
        self,
        *,
        action_data: Optional[Dict[str, Any]] = None,
        clock_offset_s: float = 0.0,
    ) -> str:
        """Context.md event gloss, including burst offset when present."""
        gloss = _event_gloss(
            self.label,
            t=self.t,
            action_data=action_data,
            clock_offset_s=clock_offset_s,
        )
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
    pass_time: Optional[float] = None
    interaction_resolution: Optional[str] = None  # pass_first | yield | unresolved

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
                "d": fr.d,
                "ttc": fr.ttc,
                "v_ego": fr.v_ego,
                "v_partner": fr.v_partner,
                "az": fr.az,
                "closing": fr.closing,
                "ego_road_lane": _road_lane(fr.ego_road, fr.ego_lane),
                "partner_road_lane": _road_lane(fr.partner_road, fr.partner_lane),
                "rel_long_m": fr.rel_long_m,
                "rel_lat_m": fr.rel_lat_m,
                "clearance_m": fr.clearance_m,
                "pass_state": fr.pass_state,
                "rolling_disp_1s_m": fr.rolling_disp_1s_m,
                "rolling_speed_1s_mps": fr.rolling_speed_1s_mps,
                "camera_half_m": fr.camera_half_m,
                "view_yaw_deg": fr.view_yaw_deg,
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
            "pass_time": self.pass_time,
            "interaction_resolution": self.interaction_resolution,
            "azimuth_definition": AZIMUTH_GLOSSARY,
            "snapshots": rows,
        }


def _parse_road_lane_token(token: Any) -> Tuple[Optional[int], Optional[int]]:
    s = str(token or "").strip()
    if not s or s in ("—", "-", "n/a", "None"):
        return None, None
    if "/" not in s:
        return None, None

    def _maybe_int(part: str) -> Optional[int]:
        part = part.strip()
        if not part or part == "?":
            return None
        try:
            return int(part)
        except ValueError:
            return None

    a, b = s.split("/", 1)
    return _maybe_int(a), _maybe_int(b)


def selection_from_llm_snapshots(doc: Dict[str, Any]) -> SelectionResult:
    """Rebuild a ``SelectionResult`` from ``processed/snapshots/llm_snapshots.json``.

    Used to rewrite ``context_medoid.md`` without re-running BEV selection.
    """
    frames: List[SelectedFrame] = []
    default_partner = str(doc.get("partner_name") or "")
    default_tid = doc.get("partner_track_id")
    for snap in doc.get("snapshots") or []:
        ego_road, ego_lane = _parse_road_lane_token(snap.get("ego_road_lane"))
        p_road, p_lane = _parse_road_lane_token(snap.get("partner_road_lane"))
        frames.append(
            SelectedFrame(
                t=float(snap.get("t", 0.0)),
                label=str(snap.get("label") or ""),
                role=str(snap.get("role") or "action"),
                partner_name=str(snap.get("partner") or default_partner),
                partner_track_id=snap.get("partner_track_id", default_tid),
                context_partner_name=str(
                    snap.get("context_partner") or doc.get("context_partner_name") or ""
                ),
                context_partner_track_id=snap.get(
                    "context_partner_track_id", doc.get("context_partner_track_id")
                ),
                d=snap.get("d"),
                ttc=snap.get("ttc"),
                v_ego=snap.get("v_ego"),
                v_partner=snap.get("v_partner"),
                az=snap.get("az"),
                closing=snap.get("closing"),
                ego_road=ego_road,
                ego_lane=ego_lane,
                partner_road=p_road,
                partner_lane=p_lane,
                rel_long_m=snap.get("rel_long_m"),
                rel_lat_m=snap.get("rel_lat_m"),
                clearance_m=snap.get("clearance_m"),
                pass_state=snap.get("pass_state"),
                rolling_disp_1s_m=snap.get("rolling_disp_1s_m"),
                rolling_speed_1s_mps=snap.get("rolling_speed_1s_mps"),
                camera_half_m=snap.get("camera_half_m"),
                view_yaw_deg=snap.get("view_yaw_deg"),
                use_whole_scene=bool(snap.get("use_whole_scene") or False),
                burst_offset_s=snap.get("burst_offset_s"),
            )
        )
    return SelectionResult(
        frames=frames,
        partner_track_id=default_tid,
        partner_name=default_partner,
        context_partner_track_id=doc.get("context_partner_track_id"),
        context_partner_name=str(doc.get("context_partner_name") or ""),
        relevance_t=doc.get("relevance_t"),
        peak_t=doc.get("peak_t"),
        pass_time=doc.get("pass_time"),
        interaction_resolution=doc.get("interaction_resolution"),
    )


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


def ego_frame_xy(
    ego_x: float,
    ego_y: float,
    ego_h_rad: float,
    px: float,
    py: float,
) -> Tuple[float, float]:
    """Partner position in ego frame: (forward, left) metres.

    Inputs are vehicle **centers** from the trajectory CSV (``x``, ``y``) plus
    Ego **heading** ``h`` (yaw). This is a center-to-center projection, not
    bumper / nose tip geometry and not oriented-rectangle contact.

    World offset from Ego center to partner center:
        dx, dy = px - ego_x, py - ego_y
    Rotate into Ego body axes (heading ``ego_h_rad``):
        fwd  =  dx·cos(h) + dy·sin(h)   # +ahead / −behind along Ego nose
        left = −dx·sin(h) + dy·cos(h)   # +left  / −right of Ego
    """
    dx, dy = float(px) - float(ego_x), float(py) - float(ego_y)
    c, s = math.cos(float(ego_h_rad)), math.sin(float(ego_h_rad))
    fwd = dx * c + dy * s
    left = -dx * s + dy * c
    return fwd, left


def pass_state_from_rel_long(
    rel_long_m: Optional[float],
    *,
    overlap_m: float = PASS_LONG_OVERLAP_M,
) -> Optional[str]:
    """Bin longitudinal center offset into pass order.

    ``rel_long_m`` is ``fwd`` from :func:`ego_frame_xy` (partner center relative
    to Ego center along Ego heading). ``overlap_m`` defaults to
    ``PASS_LONG_OVERLAP_M`` (2.5 m ≈ half vehicle length):

    - ``partner_ahead``  if fwd > +overlap_m
    - ``side_overlap``   if |fwd| ≤ overlap_m  (centers roughly abreast)
    - ``partner_behind`` if fwd < −overlap_m

    Lateral offset is ignored here; use boundary distance for geometric gap.
    """
    if rel_long_m is None:
        return None
    x = float(rel_long_m)
    band = float(overlap_m)
    if x > band:
        return "partner_ahead"
    if x < -band:
        return "partner_behind"
    return "side_overlap"


def rolling_ego_motion(
    series: Optional[pd.DataFrame],
    t: float,
    *,
    window_s: float = ROLLING_WINDOW_S,
) -> Tuple[Optional[float], Optional[float]]:
    """1 s ego displacement (m) and average speed (m/s) ending at ``t``."""
    if series is None or series.empty or "ex" not in series.columns:
        return None, None
    tt = series["time"].to_numpy(dtype=float)
    i = int(np.argmin(np.abs(tt - float(t))))
    t_end = float(tt[i])
    t_start = t_end - float(window_s)
    j = int(np.argmin(np.abs(tt - t_start)))
    if tt[j] > t_start + 1e-6:
        earlier = np.where(tt <= t_start + 1e-6)[0]
        if len(earlier):
            j = int(earlier[-1])
    dt = float(tt[i] - tt[j])
    if dt < 0.2:
        return None, None
    dx = float(series["ex"].iloc[i]) - float(series["ex"].iloc[j])
    dy = float(series["ey"].iloc[i]) - float(series["ey"].iloc[j])
    disp = float(math.hypot(dx, dy))
    return round(disp, 3), round(disp / dt, 3)


def minimum_vehicle_boundary_distance_m(
    source_df: Optional[pd.DataFrame],
    partner_name: str,
    ego_x: float,
    ego_y: float,
    ego_h: float,
    npc_x: float,
    npc_y: float,
    npc_h: float,
) -> Optional[float]:
    """Shortest distance between oriented vehicle-rectangle boundaries."""
    if source_df is None or source_df.empty or not partner_name:
        return None
    try:
        from collision_partner import _dims_for_name, _ego_name, polygon_clearance
    except Exception:
        return None
    try:
        ego_name = _ego_name(source_df)
        ew, eln = _dims_for_name(source_df, ego_name)
        nw, nln = _dims_for_name(source_df, partner_name)
        gap = polygon_clearance(
            float(ego_x), float(ego_y), float(ego_h), float(ew), float(eln),
            float(npc_x), float(npc_y), float(npc_h), float(nw), float(nln),
        )
        return float(gap)
    except Exception:
        return None


def first_pass_time(
    series: Optional[pd.DataFrame],
    *,
    hold_s: float = PASS_HYSTERESIS_S,
    overlap_m: float = PASS_LONG_OVERLAP_M,
) -> Optional[float]:
    """First time the partner stays behind for ``hold_s`` seconds."""
    if series is None or series.empty:
        return None
    behind_start: Optional[float] = None
    for _, row in series.iterrows():
        eh = _heading_to_rad(float(row["eh"]))
        fwd, _ = ego_frame_xy(
            float(row["ex"]), float(row["ey"]), eh,
            float(row["nx"]), float(row["ny"]),
        )
        t = float(row["time"])
        if fwd < -float(overlap_m):
            if behind_start is None:
                behind_start = t
            elif (t - behind_start) >= float(hold_s):
                return round(behind_start, 3)
        else:
            behind_start = None
    return None


def interaction_resolution_from_series(
    series: Optional[pd.DataFrame],
    *,
    peak_t: Optional[float] = None,
) -> str:
    """``pass_first`` | ``yield`` | ``unresolved`` from signed geometry."""
    if series is None or series.empty:
        return "unresolved"
    pass_t = first_pass_time(series)
    t_ref = float(peak_t) if peak_t is not None else float(series["time"].iloc[-1])
    i = int(np.argmin(np.abs(series["time"].to_numpy(dtype=float) - t_ref)))
    row = series.iloc[i]
    eh = _heading_to_rad(float(row["eh"]))
    fwd, _ = ego_frame_xy(
        float(row["ex"]), float(row["ey"]), eh,
        float(row["nx"]), float(row["ny"]),
    )
    state = pass_state_from_rel_long(fwd)
    if pass_t is not None or state == "partner_behind":
        return "pass_first"
    if state == "partner_ahead":
        return "yield"
    # At peak still overlapping: look at the last sample.
    last = series.iloc[-1]
    eh_l = _heading_to_rad(float(last["eh"]))
    fwd_l, _ = ego_frame_xy(
        float(last["ex"]), float(last["ey"]), eh_l,
        float(last["nx"]), float(last["ny"]),
    )
    last_state = pass_state_from_rel_long(fwd_l)
    if last_state == "partner_behind":
        return "pass_first"
    if last_state == "partner_ahead":
        return "yield"
    return "unresolved"


def adaptive_half_extent(
    d_m: Optional[float],
    *,
    margin_m: float = ADAPTIVE_BEV_MARGIN_M,
    min_half: float = ADAPTIVE_BEV_MIN_HALF_M,
    max_half: float = ADAPTIVE_BEV_MAX_HALF_M,
    footprint_pad_m: float = ADAPTIVE_BEV_FOOTPRINT_PAD_M,
) -> float:
    """Ego-centered half-extent: ``d + 2 m``, clamped and footprint-padded."""
    if d_m is None or not math.isfinite(float(d_m)):
        return float(min_half)
    d = abs(float(d_m))
    half = max(d + float(margin_m), d + float(footprint_pad_m), float(min_half))
    return float(min(float(max_half), half))


def shared_pair_half_extent(
    d_left: Optional[float],
    d_right: Optional[float],
    **kwargs: Any,
) -> float:
    """Shared pair-panel half-extent: ``max(d_L, d_R) + 2 m``."""
    candidates = [d for d in (d_left, d_right) if d is not None and math.isfinite(float(d))]
    d_max = max(candidates) if candidates else None
    return adaptive_half_extent(d_max, **kwargs)


def ego_centered_square_bounds(
    ego_xy: Tuple[float, float],
    half_m: float,
) -> Tuple[float, float, float, float]:
    """Axis-aligned world square centred on ego."""
    ex, ey = float(ego_xy[0]), float(ego_xy[1])
    h = float(half_m)
    return (ex - h, ex + h, ey - h, ey + h)


def heading_up_rotation_deg(heading_deg: float) -> float:
    """Rotation that maps world heading ``heading_deg`` (0=+X) to screen-up."""
    return 90.0 - float(heading_deg)


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
        # Lane-entry stamp is useful only when it precedes (or equals) the
        # min-distance peak. Post-peak cut_in_time is usually a lane-ID flicker
        # after the partner has already passed — do not promote it to a peak.
        if (
            ct is not None
            and typ == "DANGEROUS_CUT_IN"
            and float(ct) <= float(kt) + 1e-6
        ):
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
    *,
    source_df: Optional[pd.DataFrame] = None,
) -> Dict[str, Any]:
    out: Dict[str, Any] = {
        "partner_name": partner_name,
        "partner_track_id": partner_tid,
        "d": None,
        "ttc": None,
        "v_ego": None,
        "v_partner": None,
        "az": None,
        "closing": None,
        "ego_road": None,
        "ego_lane": None,
        "partner_road": None,
        "partner_lane": None,
        "rel_long_m": None,
        "rel_lat_m": None,
        "clearance_m": None,
        "pass_state": None,
        "rolling_disp_1s_m": None,
        "rolling_speed_1s_mps": None,
    }
    if series is None or series.empty:
        return out
    i = int(np.argmin(np.abs(series["time"].to_numpy(dtype=float) - t)))
    row = series.iloc[i]
    out["d"] = round(float(row["dist"]), 2)
    ttc = float(row["ttc"])
    out["ttc"] = None if not np.isfinite(ttc) or ttc > 60 else round(ttc, 2)
    out["v_ego"] = round(float(row["ev"]), 2)
    out["v_partner"] = round(float(row["nv"]), 2)
    out["closing"] = round(float(row["closing"]), 2)
    out["ego_road"] = int(row["er"]) if not pd.isna(row["er"]) else None
    out["ego_lane"] = int(row["el"]) if not pd.isna(row["el"]) else None
    out["partner_road"] = int(row["nr"]) if not pd.isna(row["nr"]) else None
    out["partner_lane"] = int(row["nl"]) if not pd.isna(row["nl"]) else None
    eh = _heading_to_rad(float(row["eh"]))
    out["az"] = round(
        _azimuth_deg(float(row["ex"]), float(row["ey"]), eh, float(row["nx"]), float(row["ny"])),
        1,
    )
    fwd, left = ego_frame_xy(
        float(row["ex"]), float(row["ey"]), eh, float(row["nx"]), float(row["ny"]),
    )
    out["rel_long_m"] = round(fwd, 3)
    out["rel_lat_m"] = round(left, 3)
    out["pass_state"] = pass_state_from_rel_long(fwd)
    disp, spd = rolling_ego_motion(series, float(row["time"]))
    out["rolling_disp_1s_m"] = disp
    out["rolling_speed_1s_mps"] = spd
    npc_h = float(row["nh"]) if "nh" in series.columns and not pd.isna(row["nh"]) else 0.0
    gap = minimum_vehicle_boundary_distance_m(
        source_df,
        partner_name,
        float(row["ex"]),
        float(row["ey"]),
        float(row["eh"]),
        float(row["nx"]),
        float(row["ny"]),
        npc_h,
    )
    if gap is not None:
        out["clearance_m"] = round(gap, 3)
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
        # Same gate as _conflict_anchors: only pre-/at-peak lane entry.
        if ct is not None and (
            kt is None or float(ct) <= float(kt) + 1e-6
        ):
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
    ``key_time`` only. DANGEROUS_CUT_IN / CLOSEST_APPROACH keep at most a
    single non-burst stamp; post-peak ``cut_in_time`` is dropped upstream.

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

    has_geom_peak = any(typ in _BURST_TYPES for _, typ, _, _ in anchors)
    for tc, typ, _tid, pname in anchors:
        label = f"{typ}_{pname}" if pname else typ
        # ± burst only for COLLISION / NEAR_MISS. If neither exists, burst around
        # the primary fallback once (CLOSEST_APPROACH / DANGEROUS_CUT_IN key_time).
        # *_start stamps are never peaks and never get a burst ring.
        is_start = typ.endswith("_start")
        gets_burst = (typ in _BURST_TYPES) or (
            not has_geom_peak and not is_start and tc == anchors[0][0]
        )
        if gets_burst:
            add(tc, label, "peak")
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
        else:
            add(tc, label, "interaction")

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
        m = _metrics_at(
            series, t, partner_name, partner_tid, source_df=df,
        )
        frames.append(SelectedFrame(
            t=round(t, 3),
            label=lab,
            role=role,
            partner_name=partner_name,
            partner_track_id=partner_tid,
            context_partner_name=ctx_name,
            context_partner_track_id=ctx_tid,
            d=m["d"],
            ttc=m["ttc"],
            v_ego=m["v_ego"],
            v_partner=m["v_partner"],
            az=m["az"],
            closing=m["closing"],
            ego_road=m["ego_road"],
            ego_lane=m["ego_lane"],
            partner_road=m["partner_road"],
            partner_lane=m["partner_lane"],
            rel_long_m=m["rel_long_m"],
            rel_lat_m=m["rel_lat_m"],
            clearance_m=m["clearance_m"],
            pass_state=m["pass_state"],
            rolling_disp_1s_m=m["rolling_disp_1s_m"],
            rolling_speed_1s_mps=m["rolling_speed_1s_mps"],
            use_whole_scene=False,
            draw_agent_road_labels=True,
            burst_offset_s=bo,
        ))

    pass_t = first_pass_time(series) if series is not None else None
    resolution = interaction_resolution_from_series(series, peak_t=peak_t)

    return SelectionResult(
        frames=frames,
        conflict_times=conflict_times,
        partner_track_id=partner_tid,
        partner_name=partner_name,
        context_partner_track_id=ctx_tid,
        context_partner_name=ctx_name,
        relevance_t=None,
        peak_t=peak_t,
        pass_time=pass_t,
        interaction_resolution=resolution,
    )


# Back-compat alias used by older call sites / docs.
def select_conflict_frames(*args, **kwargs) -> SelectionResult:
    """Deprecated alias for :func:`select_action_frames`."""
    # Drop inventing-only kwargs silently.
    kwargs.pop("conflict_distance_m", None)
    kwargs.pop("conflict_burst_step_s", None)
    kwargs.pop("hard_brake_accel", None)
    return select_action_frames(*args, **kwargs)


def _bearing_sector(az: float) -> str:
    """FRONT/LEFT/... bins matching LLM-ODD context_builder thresholds."""
    deg = float(az)
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


def _distance_band(d: float) -> str:
    if d >= 40.0:
        return "far"
    if d >= 15.0:
        return "moderate"
    if d >= 5.0:
        return "near"
    return "very close"


def format_az_token(az: Optional[float]) -> Optional[str]:
    """Partner bearing relative to ego's heading."""
    if az is None:
        return None
    sector = _bearing_sector(float(az))
    return (
        "partner azimuth relative to ego heading="
        f"{sector} ({float(az):.0f}°)"
    )


def format_closing_token(closing: Optional[float]) -> Optional[str]:
    """Rate at which vehicle center-to-center distance changes."""
    if closing is None:
        return None
    c = float(closing)
    if c > 0.05:
        trend = "closing"
    elif c < -0.05:
        trend = "opening"
    else:
        trend = "steady"
    return f"center-to-center distance {trend} at {abs(c):.1f} m/s"


def format_rel_position_token(
    rel_long_m: Optional[float],
    rel_lat_m: Optional[float],
) -> Optional[str]:
    """Directional partner position in ego-aligned coordinates."""
    if rel_long_m is None or rel_lat_m is None:
        return None
    longitudinal = float(rel_long_m)
    lateral = float(rel_lat_m)
    long_direction = "ahead of ego" if longitudinal >= 0.0 else "behind ego"
    lat_direction = "left of ego" if lateral >= 0.0 else "right of ego"
    return (
        "partner position in ego coordinates=("
        f"{abs(longitudinal):.1f} m {long_direction}, "
        f"{abs(lateral):.1f} m {lat_direction})"
    )


def format_longitudinal_relationship_token(
    pass_state: Optional[str],
) -> Optional[str]:
    """Pretty-print ``pass_state`` for context.md (no geometry math here).

    Machine codes come from :func:`pass_state_from_rel_long`, which bins the
    Ego-frame longitudinal center offset ``fwd`` from :func:`ego_frame_xy`.
    This helper only maps those codes to readable phrases.
    """
    if not pass_state:
        return None
    human = {
        "partner_ahead": "partner ahead of ego",
        "side_overlap": "vehicle lengths overlap longitudinally",
        "partner_behind": "partner behind ego (ego has passed)",
    }.get(str(pass_state), str(pass_state))
    return f"longitudinal relationship={human}"


def format_minimum_vehicle_boundary_distance_token(
    clearance_m: Optional[float],
) -> Optional[str]:
    """Shortest Euclidean distance between vehicle boundaries."""
    if clearance_m is None:
        return None
    return (
        "minimum distance between vehicle boundaries="
        f"{float(clearance_m):.1f} m"
    )


def format_rolling_speed_token(rolling_speed_1s_mps: Optional[float]) -> Optional[str]:
    """Ego mean speed over the previous 1 s — not a cryptic ``roll1s=`` token."""
    if rolling_speed_1s_mps is None:
        return None
    return (
        "ego average speed during previous 1 second="
        f"{float(rolling_speed_1s_mps):.1f} m/s"
    )


def format_side_metric_bits(
    *,
    d: Optional[float] = None,
    ttc: Optional[float] = None,
    v_ego: Optional[float] = None,
    v_partner: Optional[float] = None,
    az: Optional[float] = None,
    closing: Optional[float] = None,
    rel_long_m: Optional[float] = None,
    rel_lat_m: Optional[float] = None,
    clearance_m: Optional[float] = None,
    pass_state: Optional[str] = None,
    rolling_speed_1s_mps: Optional[float] = None,
) -> List[str]:
    """Full-noun metric tokens for pair/medoid context lines."""
    bits: List[str] = []
    if v_ego is not None:
        bits.append(f"ego speed={float(v_ego):.1f} m/s")
    if v_partner is not None:
        bits.append(f"partner speed={float(v_partner):.1f} m/s")
    if d is not None:
        bits.append(f"center-to-center distance={float(d):.1f} m")
    if ttc is not None:
        bits.append(f"estimated time to collision={float(ttc):.1f} s")
    az_tok = format_az_token(az)
    if az_tok:
        bits.append(az_tok)
    closing_tok = format_closing_token(closing)
    if closing_tok:
        bits.append(closing_tok)
    rel_tok = format_rel_position_token(rel_long_m, rel_lat_m)
    if rel_tok:
        bits.append(rel_tok)
    pass_tok = format_longitudinal_relationship_token(pass_state)
    if pass_tok:
        bits.append(pass_tok)
    clear_tok = format_minimum_vehicle_boundary_distance_token(clearance_m)
    if clear_tok:
        bits.append(clear_tok)
    roll_tok = format_rolling_speed_token(rolling_speed_1s_mps)
    if roll_tok:
        bits.append(roll_tok)
    return bits


# Same noun for start and end of an action (not "accelerating" vs "acceleration").
_ACTION_NOUN = {
    "DECELERATE": "deceleration",
    "ACCELERATE": "acceleration",
    "EMERGENCY_BRAKE": "emergency braking",
    "MAINTAIN_SPEED": "speed maintenance",
    "STOPPED": "a stop",
    "LANE_CHANGE_LEFT": "a left lane change",
    "LANE_CHANGE_RIGHT": "a right lane change",
    "TURN_LEFT": "a left turn on the same lane (heading change)",
    "TURN_RIGHT": "a right turn on the same lane (heading change)",
    "ENTER_JUNCTION": "junction entry",
    "EXIT_JUNCTION": "junction exit",
}


def _parse_start_end_token(label: str) -> Optional[Tuple[str, str, str]]:
    """Return ``(agent_name, 'start'|'end', ACTION)`` or None."""
    lab = str(label or "")
    if lab.startswith("ego_start_"):
        return "Ego", "start", lab[len("ego_start_") :]
    if lab.startswith("ego_end_"):
        return "Ego", "end", lab[len("ego_end_") :]
    m = re.match(r"^(.+?)_(start|end)_(.+)$", lab)
    if m:
        return m.group(1), m.group(2), m.group(3)
    return None


def _matching_action_span(
    who: str,
    act: str,
    t: float,
    action_data: Optional[Dict[str, Any]],
) -> Optional[Tuple[float, float]]:
    """Nearest action.yaml span for this agent/action whose start or end is at ``t``."""
    if action_data is None:
        return None
    best: Optional[Tuple[float, float]] = None
    best_dt = 1e9
    who_l = str(who).lower()
    for agent in action_data.get("agents") or []:
        name_ok = str(agent.get("name") or "").lower() == who_l
        ego_ok = who_l == "ego" and int(agent.get("track_id", -1)) == 0
        if not (name_ok or ego_ok):
            continue
        for a in agent.get("actions") or []:
            if str(a.get("action")) != act:
                continue
            st = float(a.get("start_time", -1))
            et = float(a.get("end_time", st))
            dt = min(abs(float(t) - st), abs(float(t) - et))
            if dt <= 0.2 and dt < best_dt:
                best = (st, et)
                best_dt = dt
    return best


def _span_pair_note(
    kind: str,
    st: float,
    et: float,
    clock_offset_s: float = 0.0,
) -> str:
    """Mark the other end of a start/end pair when the action has duration."""
    if abs(et - st) < 0.05:
        return ""
    off = float(clock_offset_s or 0.0)
    if kind == "start":
        return f" (ends at t={et - off:.2f} s)"
    return f" (started at t={st - off:.2f} s)"


def _event_gloss_one(
    label: str,
    *,
    t: Optional[float] = None,
    action_data: Optional[Dict[str, Any]] = None,
    clock_offset_s: float = 0.0,
) -> str:
    lab = str(label or "")
    parsed = _parse_start_end_token(lab)
    if parsed is not None:
        who, kind, act = parsed
        noun = _ACTION_NOUN.get(act, act.lower().replace("_", " "))
        verb = "begins" if kind == "start" else "ends"
        note = ""
        if t is not None:
            span = _matching_action_span(who, act, float(t), action_data)
            if span is not None:
                note = _span_pair_note(kind, span[0], span[1], clock_offset_s)
        return f"{who} {verb} {noun}{note}"
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
    return lab.replace("_", " ")


def _event_gloss(
    label: str,
    *,
    t: Optional[float] = None,
    action_data: Optional[Dict[str, Any]] = None,
    clock_offset_s: float = 0.0,
) -> str:
    """Human gloss; supports ``A+B`` combined stamps from merge."""
    lab = str(label or "")
    if "+" not in lab:
        return _event_gloss_one(
            lab, t=t, action_data=action_data, clock_offset_s=clock_offset_s
        )
    parts = [p.strip() for p in lab.split("+") if p.strip()]
    glosses: List[str] = []
    for p in parts:
        g = _event_gloss_one(
            p, t=t, action_data=action_data, clock_offset_s=clock_offset_s
        )
        if g and g not in glosses:
            glosses.append(g)
    return "; ".join(glosses) if glosses else lab.replace("_", " ")


def _partner_relation_phrase(
    partner: str, sector: str, band: str, d: float, az: float
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
        f"{sector_phrase} (center-to-center distance={d:.1f} m), "
        "partner azimuth relative to ego heading="
        f"{sector} ({az:.1f}°)"
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
    """Complete-sentence conflict timeline for LLM ``context_medoid.md``.

    Includes longitudinal / lateral / route-level (same-lane TURN_*) action
    stamps in one chronological list — heading arcs are not a separate section.

    ``clock_offset_s`` subtracts from each stamp (e.g. StartValidCondition clip so
    times match Explore Replayer / synced IC BEVs). ``clock_name`` is noted in
    the section intro when non-empty.

    Does **not** pre-label pass/yield; the LLM infers that from the timeline.
    """
    clock_note = (
        f" Times use the {clock_name} clock (esmini − {float(clock_offset_s):.2f} s)."
        if clock_name
        else ""
    )
    lines = [
        "## Conflict timeline",
        "",
        "Chronological action and BEV stamps for this trial. Metric names are "
        "defined in the domain glossary. Infer pass/yield from how the "
        "longitudinal relationship changes over time — this header is not a "
        f"verdict.{clock_note}",
        "",
    ]
    partner_fallback = selection.partner_name or "Opposite"
    off = float(clock_offset_s or 0.0)
    for i, fr in enumerate(selection.frames):
        gloss = (
            fr.timeline_gloss(
                action_data=action_data, clock_offset_s=off
            )
            if hasattr(fr, "timeline_gloss")
            else _event_gloss(
                fr.label,
                t=float(fr.t),
                action_data=action_data,
                clock_offset_s=off,
            )
        )
        t_disp = float(fr.t) - off
        parts = [f"At t={t_disp:.2f} s, {gloss}"]
        turn_extra = _turn_detail_phrase(fr.label, fr.t, action_data)
        if turn_extra:
            parts.append(turn_extra)
        if fr.d is not None and fr.az is not None:
            sector = _bearing_sector(fr.az)
            band = _distance_band(float(fr.d))
            pname = fr.partner_name or partner_fallback
            parts.append(
                _partner_relation_phrase(
                    pname, sector, band, float(fr.d), float(fr.az)
                )
            )
        rel_tok = format_rel_position_token(fr.rel_long_m, fr.rel_lat_m)
        if rel_tok:
            parts.append(rel_tok)
        pass_tok = format_longitudinal_relationship_token(fr.pass_state)
        if pass_tok:
            parts.append(pass_tok)
        clear_tok = format_minimum_vehicle_boundary_distance_token(fr.clearance_m)
        if clear_tok:
            parts.append(clear_tok)
        if fr.rolling_speed_1s_mps is not None and fr.rolling_disp_1s_m is not None:
            parts.append(
                f"ego distance traveled during previous 1 second="
                f"{float(fr.rolling_disp_1s_m):.2f} m; "
                f"{format_rolling_speed_token(fr.rolling_speed_1s_mps)}"
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
                        f"lateral_speed={vlat:+.2f} m/s ({eff} lateral {side}, "
                        f"heading_vs_road={float(k['vs_road']):+.1f}°)"
                    )
            except Exception:
                pass
        if fr.ttc is not None and float(fr.ttc) < 5.0:
            parts.append(f"estimated time to collision≈{float(fr.ttc):.2f} s")
        if fr.v_ego is not None:
            parts.append(f"ego speed={float(fr.v_ego):.2f} m/s")
        # Partner speed / closing rate only matter once the gap is tight —
        # this is exactly the evidence needed to tell "who is catching up to
        # whom" at approach/collision, so surface it for near + very-close
        # bands (and always at COLLISION) instead of dropping it everywhere.
        is_close = fr.d is not None and float(fr.d) < 15.0
        is_collision = "COLLISION" in str(fr.label or "").upper()
        if (is_close or is_collision) and fr.v_partner is not None:
            pname = fr.partner_name or partner_fallback
            parts.append(
                f"partner speed ({pname})={float(fr.v_partner):.2f} m/s"
            )
            if fr.closing is not None:
                closing_tok = format_closing_token(float(fr.closing))
                if closing_tok:
                    parts.append(closing_tok)
        sentence = "; ".join(parts) + "."
        lines.append(f"- {sentence}")
        if filenames is not None and i < len(filenames):
            lines.append(f"  - frame: `{filenames[i]}`")
    lines.append("")
    return "\n".join(lines)


def _turn_detail_phrase(
    label: str, t: float, action_data: Optional[Dict[str, Any]]
) -> Optional[str]:
    """Pull Δheading / path-tangent attrs for TURN_* stamps from action.yaml.

    ``heading_start_deg`` / ``heading_end_deg`` are the *arc endpoints* of the
    whole TURN action, not the nose at every stamp. Bind them to the action's
    ``start_time`` / ``end_time`` so a start stamp does not look like the turn
    already finished (and vice versa).
    """
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
                near_start = abs(t - st) <= 0.15
                near_end = abs(t - et) <= 0.15
                if not near_start and not near_end:
                    continue
                attrs = act.get("attributes") or {}
                dhdg = attrs.get("heading_change_deg")
                h0 = attrs.get("heading_start_deg")
                h1 = attrs.get("heading_end_deg")
                side = "left" if want == "TURN_LEFT" else "right"
                parts = []
                if dhdg is not None and h0 is not None and h1 is not None:
                    if near_start and not near_end:
                        # Start stamp: nose *now* is h0; h1 is the future end.
                        parts.append(
                            f"{side} turn starting; nose={h0}° now; "
                            f"arc Δheading={dhdg}° → {h1}° by t={et:.2f}s"
                        )
                    elif near_end and not near_start:
                        # End stamp: nose *now* is h1; h0 was at start.
                        parts.append(
                            f"{side} turn ending; nose={h1}° now; "
                            f"completed Δheading={dhdg}° from {h0}° at t={st:.2f}s"
                        )
                    else:
                        # Degenerate: start≈end (or stamp hits both).
                        parts.append(
                            f"{side} Δheading={dhdg}° "
                            f"(nose {h0}° @ t={st:.2f}s → {h1}° @ t={et:.2f}s)"
                        )
                elif dhdg is not None:
                    parts.append(f"{side} Δheading={dhdg}°")
                vp0, vp1 = attrs.get("vs_path_start_deg"), attrs.get("vs_path_end_deg")
                if vp0 is not None and vp1 is not None:
                    if near_start and not near_end:
                        parts.append(
                            f"heading vs road {vp0:+.1f}° now "
                            f"(→ {vp1:+.1f}° by t={et:.2f}s; 0°=parallel)"
                        )
                    elif near_end and not near_start:
                        parts.append(
                            f"heading vs road {vp1:+.1f}° now "
                            f"(from {vp0:+.1f}° at t={st:.2f}s; 0°=parallel)"
                        )
                    else:
                        parts.append(
                            f"heading vs road {vp0:+.1f}° @ t={st:.2f}s → "
                            f"{vp1:+.1f}° @ t={et:.2f}s (0°=parallel)"
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
    peak_t = selection.peak_t
    lines = ["## BEV frames", ""]
    for fr, fname in zip(selection.frames, filenames):
        if fr.role == "peak" and (
            peak_t is None or abs(float(fr.t) - float(peak_t)) < 0.05
        ):
            note = "peak conflict"
        elif fr.role == "peak":
            note = "conflict key_time"
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
                d="—" if fr.d is None else f"{fr.d:.2f}",
                ttc="—" if fr.ttc is None else f"{fr.ttc:.2f}",
                ve="—" if fr.v_ego is None else f"{fr.v_ego:.2f}",
                vp="—" if fr.v_partner is None else f"{fr.v_partner:.2f}",
                az="—" if fr.az is None else f"{fr.az:.1f}",
                er=_road_lane(fr.ego_road, fr.ego_lane),
                pr=_road_lane(fr.partner_road, fr.partner_lane),
            )
        )
    lines.append("")
    lines.append("Frames:")
    peak_t = selection.peak_t
    for fr, fname in zip(selection.frames, filenames):
        if fr.role == "peak" and (
            peak_t is None or abs(float(fr.t) - float(peak_t)) < 0.05
        ):
            note = "peak conflict (from action.yaml)"
        elif fr.role == "peak":
            note = "conflict key_time (from action.yaml)"
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


def pair_geometry_summary(
    frames: Sequence[Dict[str, Any]],
    *,
    left_key: str = "left",
    right_key: str = "right",
    persist_n: int = 2,
    clearance_delta_m: float = 0.15,
    rel_lat_delta_m: float = 0.25,
) -> Dict[str, Any]:
    """Deterministic pair summary from synced-frame metric dicts.

    Each frame should carry ``{left,right}_pass_state``, ``_clearance_m``,
    ``_rel_long_m``, ``_rel_lat_m``, ``_v_ego``, ``_alive``, and ``t_s``.
    """
    def _get(fr: Dict[str, Any], side: str, field: str) -> Any:
        return fr.get(f"{side}_{field}")

    def _terminal_resolution(side: str) -> str:
        states = [
            _get(fr, side, "pass_state")
            for fr in frames
            if fr.get(f"{side}_alive", True) and _get(fr, side, "pass_state")
        ]
        if any(s == "partner_behind" for s in states):
            return "pass_first"
        if states and states[-1] == "partner_ahead":
            return "yield"
        return "unresolved"

    def _min_clearance(side: str) -> Optional[float]:
        vals = [
            float(_get(fr, side, "clearance_m"))
            for fr in frames
            if _get(fr, side, "clearance_m") is not None
        ]
        return round(min(vals), 3) if vals else None

    left_res = _terminal_resolution("left")
    right_res = _terminal_resolution("right")
    left_c = _min_clearance("left")
    right_c = _min_clearance("right")

    persist_hits = 0
    first_div: Optional[Dict[str, Any]] = None
    overlapping = [
        fr for fr in frames
        if fr.get("left_alive", True) and fr.get("right_alive", True)
    ]
    for i, fr in enumerate(overlapping):
        cl = _get(fr, "left", "clearance_m")
        cr = _get(fr, "right", "clearance_m")
        ll = _get(fr, "left", "rel_lat_m")
        lr = _get(fr, "right", "rel_lat_m")
        ps_l = _get(fr, "left", "pass_state")
        ps_r = _get(fr, "right", "pass_state")
        d_clear = (
            abs(float(cl) - float(cr))
            if cl is not None and cr is not None
            else 0.0
        )
        d_lat = (
            abs(float(ll) - float(lr))
            if ll is not None and lr is not None
            else 0.0
        )
        state_mismatch = bool(ps_l and ps_r and ps_l != ps_r)
        hit = d_clear >= clearance_delta_m or d_lat >= rel_lat_delta_m or state_mismatch
        if hit:
            persist_hits += 1
            is_last_overlap = i == len(overlapping) - 1
            # Collision/clip often truncates the overlapping window to one late frame.
            enough = persist_hits >= persist_n or (
                is_last_overlap and d_clear >= clearance_delta_m
            )
            if enough and first_div is None:
                reasons = []
                if d_clear >= clearance_delta_m:
                    reasons.append(
                        f"clearance {float(cl):.1f} vs {float(cr):.2f} m"
                    )
                if d_lat >= rel_lat_delta_m:
                    reasons.append(
                        f"rel_lat {float(ll):+.2f} vs {float(lr):+.2f} m"
                    )
                if state_mismatch:
                    reasons.append(f"pass_state {ps_l} vs {ps_r}")
                first_div = {
                    "t_s": fr.get("t_s"),
                    "reason": "; ".join(reasons) or "geometry",
                    "left_clearance_m": cl,
                    "right_clearance_m": cr,
                    "left_pass_state": ps_l,
                    "right_pass_state": ps_r,
                }
        else:
            persist_hits = 0

    if first_div is None:
        near_identical = True
    elif left_res == right_res:
        # Late-only clearance split (often the last overlapping stamp, when
        # one side then collides/ends) still counts as near-identical motion.
        t_last_overlap = None
        if overlapping:
            t_last_overlap = overlapping[-1].get("t_s")
        t_div = first_div.get("t_s")
        state_mismatch = (
            first_div.get("left_pass_state")
            and first_div.get("right_pass_state")
            and first_div["left_pass_state"] != first_div["right_pass_state"]
        )
        near_identical = (
            t_last_overlap is not None
            and t_div is not None
            and (float(t_last_overlap) - float(t_div)) <= 1.5
            and not state_mismatch
        )
    else:
        near_identical = False

    return {
        "left_resolution": left_res,
        "right_resolution": right_res,
        "left_min_clearance_m": left_c,
        "right_min_clearance_m": right_c,
        "near_identical_motion": bool(near_identical),
        "first_persistent_divergence": first_div,
    }
