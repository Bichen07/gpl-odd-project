"""sim_labeller.py — Phase 4: adapt xosc_gen.Labeller for gpl-odd Observations.

Inputs  (per medoid trial):
  * raw Payload Observations JSON (list of frames, each with ego* and agents[])
  * the scenario's .xodr file (for spatial fallback of agent road_id/lane_id)

Outputs (written into llm_artifacts/<run_id>/clusters/cluster_<n>/):
  * trajectory.csv : columns trackId,time,x,y,velocity,heading,road_id,
                     lane_id,lane_offset,s
  * meta.yaml      : dataset, location, duration, agents:[{track_id,class,
                     width,length}]

The action classifier (xosc_gen-style ROUTE/MAINTAIN/ACCELERATE/etc.) is
intentionally split into a follow-up iteration so this scaffold can land
and be reviewed independently.

Design notes
------------
1.  We treat Ego (always present) as track_id 0 and assign integer ids 1..N
    to the named agents in the order they appear in the first frame.
2.  When Payload/CSV ``roadId`` is missing or 0, road/lane are inferred by
    nearest sampled OpenDRIVE lane polyline (Ego and NPCs alike). This is
    not metrology GT — junctions can mis-assign — but enables Labeller
    lane-change / junction text when esmini IDs are stuck at 0.
3.  No floating-point fields are coerced to ints except road_id / lane_id.
"""

from __future__ import annotations

import csv
import math
from dataclasses import dataclass
from pathlib import Path
from typing import Dict, List, Optional, Tuple

import yaml


# ---------------------------------------------------------------------------
# Spatial fallback
# ---------------------------------------------------------------------------

def assign_agent_road_id(
    x: float,
    y: float,
    parser,  # bev_renderer.XodrParser — typed loosely to avoid circular import
) -> Tuple[int, int]:
    """Project (x, y) onto the nearest sampled lane and return (road_id, lane_id).

    Uses every LaneLine that is not a road reference (`lane_type != "ref"`),
    which includes drivable lanes, shoulders and borders. Returns (0, 0) only
    when the parser has no lane samples.

    Limitation: dense nearest-point (not true centerline projection); parallel
    roads / junctions can flip IDs frame-to-frame.
    """
    best_d2 = math.inf
    best = (0, 0)
    for line in parser.lines:
        if line.lane_type == "ref":
            continue
        for px, py in line.points:
            d2 = (px - x) ** 2 + (py - y) ** 2
            if d2 < best_d2:
                best_d2 = d2
                try:
                    rid = int(line.road_id)
                except (TypeError, ValueError):
                    rid = 0
                best = (rid, int(line.lane_id))
    return best


def resolve_road_lane(
    x: float,
    y: float,
    rid: int,
    lid: int,
    parser,
) -> Tuple[int, int]:
    """Prefer payload/CSV IDs; if ``rid == 0`` (missing GT), infer from map."""
    if int(rid) != 0:
        return int(rid), int(lid)
    if parser is None:
        return 0, int(lid)
    return assign_agent_road_id(float(x), float(y), parser)


# ---------------------------------------------------------------------------
# Trajectory + metadata builder
# ---------------------------------------------------------------------------

@dataclass
class AgentRow:
    track_id: int
    name: str
    obj_class: str   # "car" / "person" / "motorbike"
    width: float
    length: float


def _ordered_agent_names(observations: List[Dict]) -> List[str]:
    """Return agent names in the order they first appear in the trial."""
    seen: List[str] = []
    for ob in observations:
        for ag in ob.get("agents", []):
            n = ag.get("name")
            if n and n not in seen:
                seen.append(n)
    return seen


def build_trajectory_csv(
    observations: List[Dict],
    parser,
    out_path: Path,
    agent_metadata: Optional[Dict[str, Dict]] = None,
) -> List[AgentRow]:
    """Write xosc_gen-format trajectory.csv and return the agent registry.

    `observations` must be sorted by `time` ascending. The function does NOT
    sort in place to keep behaviour predictable for callers that already
    handle ordering.

    `agent_metadata` is optional; when provided it should be a mapping
    `{agent_name: {"class": "car", "width": 2.0, "length": 4.5}}`.
    Missing entries fall back to `("car", 2.0, 4.5)`.
    """
    out_path.parent.mkdir(parents=True, exist_ok=True)
    agent_names = _ordered_agent_names(observations)
    name_to_id: Dict[str, int] = {"Ego": 0}
    for i, name in enumerate(agent_names, start=1):
        name_to_id[name] = i

    registry: List[AgentRow] = [
        AgentRow(track_id=0, name="Ego", obj_class="car", width=2.2, length=5.17),
    ]
    for name in agent_names:
        meta = (agent_metadata or {}).get(name, {})
        registry.append(AgentRow(
            track_id=name_to_id[name],
            name=name,
            obj_class=meta.get("class", "car"),
            width=float(meta.get("width", 2.0)),
            length=float(meta.get("length", 4.5)),
        ))

    fieldnames = [
        "trackId", "time", "x", "y", "velocity", "heading",
        "road_id", "lane_id", "lane_offset", "s",
    ]
    with out_path.open("w", newline="") as fh:
        writer = csv.DictWriter(fh, fieldnames=fieldnames)
        writer.writeheader()

        for ob in observations:
            t = float(ob["time"])
            ex, ey = float(ob["egoX"]), float(ob["egoY"])
            ego_rid = int(ob.get("egoRoadId", 0) or 0)
            ego_lid = int(ob.get("egoLaneId", 0) or 0)
            ego_rid, ego_lid = resolve_road_lane(ex, ey, ego_rid, ego_lid, parser)

            writer.writerow({
                "trackId": 0,
                "time": t,
                "x": ex,
                "y": ey,
                "velocity": float(ob.get("egoSpeed", 0.0)),
                "heading": float(ob.get("egoYaw", 0.0)),
                "road_id": ego_rid,
                "lane_id": ego_lid,
                "lane_offset": float(ob.get("egoLaneOffset", 0.0) or 0.0),
                "s": float(ob.get("egoS", 0.0) or 0.0),
            })

            for ag in ob.get("agents", []):
                name = ag.get("name")
                if name not in name_to_id:
                    continue
                ax, ay = float(ag["x"]), float(ag["y"])
                rid_payload = int(ag.get("roadId", 0) or 0)
                lid_payload = int(ag.get("laneId", 0) or 0)
                rid, lid = resolve_road_lane(ax, ay, rid_payload, lid_payload, parser)
                writer.writerow({
                    "trackId": name_to_id[name],
                    "time": t,
                    "x": ax,
                    "y": ay,
                    "velocity": float(ag.get("speed", 0.0)),
                    "heading": float(ag.get("yaw", 0.0)),
                    "road_id": rid,
                    "lane_id": lid,
                    "lane_offset": float(ag.get("laneOffset", 0.0) or 0.0),
                    "s": float(ag.get("s", 0.0) or 0.0),
                })
    return registry


def build_meta_yaml(
    registry: List[AgentRow],
    observations: List[Dict],
    out_path: Path,
    dataset: str,
    location: str,
) -> None:
    """Write the xosc_gen-format meta.yaml describing the trial."""
    if not observations:
        duration = 0.0
    else:
        duration = float(observations[-1]["time"]) - float(observations[0]["time"])

    payload = {
        "dataset": dataset,
        "location": location,
        "duration": round(duration, 3),
        "agents": [
            {
                "track_id": a.track_id,
                "class": a.obj_class,
                "name": a.name,
                "width": a.width,
                "length": a.length,
            }
            for a in registry
        ],
    }
    out_path.parent.mkdir(parents=True, exist_ok=True)
    with out_path.open("w") as fh:
        yaml.safe_dump(payload, fh, sort_keys=False)
