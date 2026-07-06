"""Resolve ego collision partner and conflict key times.

Priority:
  1. Payload trial ``events`` with ``collisionWith{AgentName}`` (simulation GT).
  2. Polygon clearance scan on esmini CSV (contact / conflict relevance).
"""
from __future__ import annotations

import math
from dataclasses import dataclass
from typing import Dict, List, Optional, Sequence, Tuple

import pandas as pd
from shapely.geometry import Polygon
from shapely.ops import nearest_points

from map_plotter import _rotated_box_vertices
from taxonomy import InteractionAction, Thresholds

_COLLISION_EVENT_PREFIX = "collisionWith"
_EGO_DEFAULT = ("Ego", 2.2, 5.17)
_AGENT_DEFAULTS: Dict[str, Tuple[float, float]] = {
    "Ego": (2.2, 5.17),
    "Parking": (2.0, 4.5),
    "Opposite": (2.0, 4.5),
}


@dataclass(frozen=True)
class CollisionPartner:
    partner_name: str
    partner_track_id: Optional[int]
    key_time: float
    min_clearance_m: float
    source: str  # "gt_events" | "polygon"


def _heading_deg(h_val: float) -> float:
    if abs(h_val) > 2 * math.pi + 0.5:
        return float(h_val)
    return math.degrees(float(h_val))


def _dims_for_name(df: pd.DataFrame, name: str) -> Tuple[float, float]:
    w_def, ln_def = _AGENT_DEFAULTS.get(name, (2.0, 4.5))
    sub = df[df["name"].astype(str).str.strip() == name]
    if sub.empty:
        return w_def, ln_def
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
    if w < 0.5:
        w = w_def
    if ln < 1.5:
        ln = ln_def
    return w, ln


def polygon_clearance(
    x_a: float,
    y_a: float,
    h_a: float,
    w_a: float,
    ln_a: float,
    x_b: float,
    y_b: float,
    h_b: float,
    w_b: float,
    ln_b: float,
) -> float:
    """Shortest gap between oriented vehicle rectangles (metres)."""
    pa = Polygon(
        _rotated_box_vertices(x_a, y_a, _heading_deg(h_a), ln_a, w_a)
    )
    pb = Polygon(
        _rotated_box_vertices(x_b, y_b, _heading_deg(h_b), ln_b, w_b)
    )
    p1, p2 = nearest_points(pa, pb)
    return float(p1.distance(p2))


def _name_to_track(meta_agents: Sequence[dict]) -> Dict[str, int]:
    out: Dict[str, int] = {}
    for ag in meta_agents or []:
        name = str(ag.get("name", "")).strip()
        if name:
            out[name] = int(ag["track_id"])
    return out


def _track_to_name(meta_agents: Sequence[dict]) -> Dict[int, str]:
    return {int(ag["track_id"]): str(ag.get("name", f"agent_{ag['track_id']}")) for ag in (meta_agents or [])}


def _ego_name(df: pd.DataFrame) -> str:
    names = {str(x).strip() for x in df["name"].unique() if str(x).strip()}
    return "Ego" if "Ego" in names else (sorted(names)[0] if names else "Ego")


def _npc_names(df: pd.DataFrame, ego_name: str) -> List[str]:
    return sorted(nm for nm in {str(x).strip() for x in df["name"].unique() if str(x).strip()} if nm != ego_name)


def parse_collision_from_events(
    events: Optional[Sequence[dict]],
    meta_agents: Sequence[dict],
    df: pd.DataFrame,
    *,
    contact_clearance_m: float = Thresholds.CONTACT_CLEARANCE_M,
) -> Optional[CollisionPartner]:
    """Read simulation GT from ``Trial.events`` (``collisionWith{Name}``)."""
    if not events:
        return None
    name_to_track = _name_to_track(meta_agents)
    ego_name = _ego_name(df)

    for ev in events:
        ev_name = str(ev.get("name") or "")
        if not ev_name.startswith(_COLLISION_EVENT_PREFIX):
            continue
        partner_name = ev_name[len(_COLLISION_EVENT_PREFIX) :]
        if not partner_name:
            continue
        track_id = name_to_track.get(partner_name)

        key_time: Optional[float] = None
        for key in ("esminiSeconds", "time"):
            val = ev.get(key)
            if val is not None:
                try:
                    t = float(val)
                except (TypeError, ValueError):
                    continue
                if t > 0:
                    key_time = t
                    break

        clearance, t_clear = _min_clearance_with_partner(
            df, ego_name, partner_name, key_time_hint=key_time
        )
        if key_time is None:
            key_time = t_clear

        if key_time is None:
            continue

        return CollisionPartner(
            partner_name=partner_name,
            partner_track_id=track_id,
            key_time=round(float(key_time), 2),
            min_clearance_m=round(float(clearance), 3),
            source="gt_events",
        )
    return None


def _min_clearance_with_partner(
    df: pd.DataFrame,
    ego_name: str,
    partner_name: str,
    *,
    key_time_hint: Optional[float] = None,
) -> Tuple[float, Optional[float]]:
    """Return (min_clearance, time_at_min) between ego and one NPC."""
    ego = df[df["name"].astype(str).str.strip() == ego_name].sort_values("time")
    npc = df[df["name"].astype(str).str.strip() == partner_name].sort_values("time")
    if ego.empty or npc.empty:
        return float("inf"), key_time_hint

    ew, eln = _dims_for_name(df, ego_name)
    nw, nln = _dims_for_name(df, partner_name)

    merged = pd.merge_asof(
        ego.sort_values("time"),
        npc.sort_values("time").rename(
            columns={
                "x": "x_n",
                "y": "y_n",
                "h": "h_n",
                "speed": "speed_n",
            }
        ),
        on="time",
        direction="nearest",
        tolerance=0.06,
    )
    if merged.empty:
        return float("inf"), key_time_hint

    best_d = float("inf")
    best_t: Optional[float] = key_time_hint
    for _, row in merged.iterrows():
        d = polygon_clearance(
            float(row["x"]),
            float(row["y"]),
            float(row["h"]),
            ew,
            eln,
            float(row["x_n"]),
            float(row["y_n"]),
            float(row["h_n"]),
            nw,
            nln,
        )
        t = float(row["time"])
        if d < best_d:
            best_d = d
            best_t = t

    return best_d, best_t


def infer_collision_partner_polygon(
    df: pd.DataFrame,
    meta_agents: Sequence[dict],
    *,
    collided: bool = False,
    contact_clearance_m: float = Thresholds.CONTACT_CLEARANCE_M,
) -> Optional[CollisionPartner]:
    """Infer collision partner from polygon clearance across all NPCs."""
    if not collided:
        return None

    ego_name = _ego_name(df)
    name_to_track = _name_to_track(meta_agents)
    ew, eln = _dims_for_name(df, ego_name)

    best: Optional[Tuple[float, float, str]] = None  # clearance, time, name

    for npc_name in _npc_names(df, ego_name):
        npc = df[df["name"].astype(str).str.strip() == npc_name].sort_values("time")
        if npc.empty:
            continue
        nw, nln = _dims_for_name(df, npc_name)
        merged = pd.merge_asof(
            df[df["name"].astype(str).str.strip() == ego_name].sort_values("time"),
            npc.rename(columns={"x": "x_n", "y": "y_n", "h": "h_n"}),
            on="time",
            direction="nearest",
            tolerance=0.06,
        )
        for _, row in merged.iterrows():
            d = polygon_clearance(
                float(row["x"]),
                float(row["y"]),
                float(row["h"]),
                ew,
                eln,
                float(row["x_n"]),
                float(row["y_n"]),
                float(row["h_n"]),
                nw,
                nln,
            )
            t = float(row["time"])
            if best is None or d < best[0]:
                best = (d, t, npc_name)

    if best is None:
        return None

    clearance, t_hit, partner_name = best
    if clearance > contact_clearance_m * 3.0:
        return None

    return CollisionPartner(
        partner_name=partner_name,
        partner_track_id=name_to_track.get(partner_name),
        key_time=round(t_hit, 2),
        min_clearance_m=round(clearance, 3),
        source="polygon",
    )


def resolve_collision_partner(
    df: pd.DataFrame,
    meta_agents: Sequence[dict],
    *,
    trial_events: Optional[Sequence[dict]] = None,
    collided: bool = False,
    contact_clearance_m: float = Thresholds.CONTACT_CLEARANCE_M,
) -> Optional[CollisionPartner]:
    gt = parse_collision_from_events(
        trial_events, meta_agents, df, contact_clearance_m=contact_clearance_m
    )
    if gt is not None:
        return gt
    return infer_collision_partner_polygon(
        df,
        meta_agents,
        collided=collided,
        contact_clearance_m=contact_clearance_m,
    )


def _agent_row_at_time(
    df: pd.DataFrame, name: str, t: float
) -> Optional[Dict[str, object]]:
    """Nearest esmini row for ``name`` at simulation time ``t``."""
    sub = df[df["name"].astype(str).str.strip() == name].sort_values("time")
    if sub.empty:
        return None
    idx = int((sub["time"] - t).abs().idxmin())
    row = sub.loc[idx]
    return {
        "name": name,
        "speed_mps": round(float(row.get("speed", 0) or 0), 2),
        "road_id": int(row.get("roadId", 0) or 0),
        "lane_id": int(row.get("laneId", 0) or 0),
        "x": round(float(row["x"]), 2),
        "y": round(float(row["y"]), 2),
    }


def enrich_collision_interaction(
    interaction: dict,
    df: pd.DataFrame,
    meta_agents: Sequence[dict],
) -> dict:
    """Attach ego/partner kinematics and map location at collision time."""
    if interaction.get("type") != InteractionAction.COLLISION.value:
        return interaction
    t = float(interaction.get("key_time") or 0)
    ego_name = _ego_name(df)
    partner_name = str(interaction.get("with_name") or "unknown")
    out = dict(interaction)
    ego = _agent_row_at_time(df, ego_name, t)
    partner = _agent_row_at_time(df, partner_name, t)
    if ego:
        out["ego_at_collision"] = ego
    if partner:
        out["partner_at_collision"] = partner
    return out


def collision_interaction_to_medoid_doc(interaction: Optional[dict]) -> Optional[dict]:
    """Compact collision block for ``cluster.json`` medoid section."""
    if not interaction or interaction.get("type") != InteractionAction.COLLISION.value:
        return None
    ego = interaction.get("ego_at_collision") or {}
    partner = interaction.get("partner_at_collision") or {}
    return {
        "time_s": interaction.get("key_time"),
        "partner_name": interaction.get("with_name"),
        "partner_track_id": interaction.get("with_track_id"),
        "min_clearance_m": interaction.get("min_clearance_m"),
        "source": interaction.get("source"),
        "ego_speed_mps": ego.get("speed_mps"),
        "partner_speed_mps": partner.get("speed_mps"),
        "ego_road_id": ego.get("road_id"),
        "ego_lane_id": ego.get("lane_id"),
        "partner_road_id": partner.get("road_id"),
        "partner_lane_id": partner.get("lane_id"),
        "ego_xy": [ego.get("x"), ego.get("y")] if ego else None,
        "partner_xy": [partner.get("x"), partner.get("y")] if partner else None,
    }


def _collision_action_attributes(iv: dict, *, as_partner: bool) -> dict:
    """Build action.yaml attributes for a per-agent COLLISION event."""
    ego = iv.get("ego_at_collision") or {}
    partner = iv.get("partner_at_collision") or {}
    base = {
        "min_clearance_m": iv.get("min_clearance_m"),
        "source": iv.get("source"),
        "ego_speed_mps": ego.get("speed_mps"),
        "partner_speed_mps": partner.get("speed_mps"),
        "ego_road_id": ego.get("road_id"),
        "ego_lane_id": ego.get("lane_id"),
        "ego_x": ego.get("x"),
        "ego_y": ego.get("y"),
        "partner_road_id": partner.get("road_id"),
        "partner_lane_id": partner.get("lane_id"),
        "partner_x": partner.get("x"),
        "partner_y": partner.get("y"),
    }
    if as_partner:
        base["with_name"] = ego.get("name", "Ego")
        base["with_track_id"] = 0
        base["role"] = "partner"
    else:
        base["with_name"] = iv.get("with_name")
        base["with_track_id"] = iv.get("with_track_id")
        base["role"] = "ego"
    return {k: v for k, v in base.items() if v is not None}


def inject_collision_agent_actions(
    agents: List[dict],
    interactions: List[dict],
) -> None:
    """Append sorted per-agent COLLISION actions from enriched interactions."""
    collisions = [
        iv for iv in interactions if iv.get("type") == InteractionAction.COLLISION.value
    ]
    if not collisions:
        return

    by_track = {int(a["track_id"]): a for a in agents}

    for iv in collisions:
        t = round(float(iv.get("key_time") or 0), 2)
        ego = iv.get("ego_at_collision") or {}
        partner = iv.get("partner_at_collision") or {}
        partner_tid = iv.get("with_track_id")

        ego_agent = by_track.get(0)
        if ego_agent is not None:
            ego_agent.setdefault("actions", []).append(
                {
                    "action": InteractionAction.COLLISION.value,
                    "start_time": t,
                    "end_time": t,
                    "duration": 0.0,
                    "road_id": int(ego.get("road_id", 0) or 0),
                    "lane_id": int(ego.get("lane_id", 0) or 0),
                    "attributes": _collision_action_attributes(iv, as_partner=False),
                }
            )

        if partner_tid is not None:
            pa = by_track.get(int(partner_tid))
            if pa is not None:
                pa.setdefault("actions", []).append(
                    {
                        "action": InteractionAction.COLLISION.value,
                        "start_time": t,
                        "end_time": t,
                        "duration": 0.0,
                        "road_id": int(partner.get("road_id", 0) or 0),
                        "lane_id": int(partner.get("lane_id", 0) or 0),
                        "attributes": _collision_action_attributes(iv, as_partner=True),
                    }
                )

    for agent in agents:
        agent["actions"] = sorted(
            agent.get("actions", []),
            key=lambda a: (float(a.get("start_time", 0)), float(a.get("end_time", 0))),
        )


def infer_closest_approaches(
    df: pd.DataFrame,
    meta_agents: Sequence[dict],
    *,
    conflict_relevance_m: float = Thresholds.CONFLICT_RELEVANCE_M,
    max_moving: int = 2,
    exclude_track_ids: Optional[set] = None,
) -> List[dict]:
    """CLOSEST_APPROACH for moving NPCs within ``conflict_relevance_m`` (polygon gap)."""
    exclude_track_ids = exclude_track_ids or set()
    ego_name = _ego_name(df)
    name_to_track = _name_to_track(meta_agents)
    track_to_name = _track_to_name(meta_agents)
    candidates: List[Tuple[float, dict]] = []

    for npc_name in _npc_names(df, ego_name):
        track_id = name_to_track.get(npc_name)
        if track_id is not None and track_id in exclude_track_ids:
            continue
        npc = df[df["name"].astype(str).str.strip() == npc_name]
        if npc.empty:
            continue
        if float(npc["speed"].abs().max()) <= Thresholds.STOPPED_SPEED:
            continue

        clearance, t_hit = _min_clearance_with_partner(df, ego_name, npc_name)
        if clearance >= conflict_relevance_m or t_hit is None:
            continue

        candidates.append(
            (
                clearance,
                {
                    "type": InteractionAction.CLOSEST_APPROACH.value,
                    "with_track_id": track_id,
                    "with_name": track_to_name.get(track_id, npc_name) if track_id else npc_name,
                    "key_time": round(float(t_hit), 2),
                    "min_clearance_m": round(float(clearance), 3),
                },
            )
        )

    candidates.sort(key=lambda c: c[0])
    return [item for _, item in candidates[:max_moving]]


def augment_interactions(
    base_interactions: List[dict],
    df: pd.DataFrame,
    meta_agents: Sequence[dict],
    *,
    trial_events: Optional[Sequence[dict]] = None,
    collided: bool = False,
    contact_clearance_m: float = Thresholds.CONTACT_CLEARANCE_M,
    conflict_relevance_m: float = Thresholds.CONFLICT_RELEVANCE_M,
) -> List[dict]:
    """Merge detector output with COLLISION GT / polygon and CLOSEST_APPROACH."""
    track_to_name = _track_to_name(meta_agents)
    out: List[dict] = []

    for iv in base_interactions:
        if (
            iv.get("type") == InteractionAction.NEAR_MISS.value
            and iv.get("min_distance_m") is not None
            and float(iv["min_distance_m"]) > conflict_relevance_m
        ):
            continue
        enriched = dict(iv)
        tid = enriched.get("with_track_id")
        if tid is not None and "with_name" not in enriched:
            enriched["with_name"] = track_to_name.get(int(tid), f"track {tid}")
        out.append(enriched)

    tier_a_tracks = {
        int(iv["with_track_id"])
        for iv in out
        if iv.get("with_track_id") is not None
        and iv.get("type") in {
            InteractionAction.NEAR_MISS.value,
            InteractionAction.DANGEROUS_CUT_IN.value,
            InteractionAction.COLLISION.value,
        }
    }

    partner = resolve_collision_partner(
        df,
        meta_agents,
        trial_events=trial_events,
        collided=collided,
        contact_clearance_m=contact_clearance_m,
    )
    if partner is not None:
        collision_iv = enrich_collision_interaction(
            {
                "type": InteractionAction.COLLISION.value,
                "with_track_id": partner.partner_track_id,
                "with_name": partner.partner_name,
                "key_time": partner.key_time,
                "min_clearance_m": partner.min_clearance_m,
                "source": partner.source,
            },
            df,
            meta_agents,
        )
        out.insert(0, collision_iv)
        if partner.partner_track_id is not None:
            tier_a_tracks.add(int(partner.partner_track_id))

    closest = infer_closest_approaches(
        df,
        meta_agents,
        conflict_relevance_m=conflict_relevance_m,
        exclude_track_ids=tier_a_tracks,
    )
    out.extend(closest)

    out.sort(key=lambda iv: float(iv.get("key_time") or 0))
    return out
