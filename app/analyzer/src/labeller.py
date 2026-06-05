#!/usr/bin/env python3
"""labeller.py — V1-4 / Step T-2: rule-based action classifier.

Reads a medoid `trajectory.csv` + `meta.yaml` (+ optional map YAML) and writes
`action.yaml`: per-agent sequences of ActionEvents from the gpl-odd taxonomy.

Map-agnostic: junction membership comes from the map YAML's `JunctionRoads`
list (produced by scripts/map_preprocess.py), so it works on the full hct_6
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
    from taxonomy import ActionEvent, EgoAction, NpcAction, Thresholds, merge_consecutive
except ImportError:  # allow running as a module from repo root
    import sys

    sys.path.insert(0, str(Path(__file__).resolve().parent))
    from taxonomy import ActionEvent, EgoAction, NpcAction, Thresholds, merge_consecutive


def _normalize_columns(df: pd.DataFrame) -> pd.DataFrame:
    """Accept xosc_gen world_x/world_y aliases for x/y."""
    if "x" not in df.columns and "world_x" in df.columns:
        df = df.rename(columns={"world_x": "x", "world_y": "y"})
    return df


def _agent_speed_actions(df: pd.DataFrame, junction_roads: Set[int]) -> List[ActionEvent]:
    """Classify longitudinal + junction transitions frame-by-frame for one agent."""
    df = df.sort_values("time").reset_index(drop=True)
    if len(df) < 2:
        return []

    t = df["time"].to_numpy(dtype=float)
    v = df["velocity"].to_numpy(dtype=float)
    road = df["road_id"].to_numpy(dtype=int)
    lane = df["lane_id"].to_numpy(dtype=int)
    agent_id = int(df["trackId"].iloc[0])
    role = "ego" if agent_id == 0 else "npc"

    dt = np.diff(t)
    dv = np.diff(v)
    acc = np.divide(dv, dt, out=np.zeros_like(dv), where=dt != 0)

    events: List[ActionEvent] = []
    for i in range(len(acc)):
        a = acc[i]
        speed = v[i]
        if speed < Thresholds.STOPPED_SPEED and abs(a) < abs(Thresholds.DECEL):
            action = EgoAction.STOPPED.value
        elif a <= Thresholds.EMERGENCY_DECEL:
            action = EgoAction.EMERGENCY_BRAKE.value
        elif a <= Thresholds.DECEL:
            action = EgoAction.DECELERATE.value
        elif a >= Thresholds.ACCEL:
            action = EgoAction.ACCELERATE.value
        else:
            action = EgoAction.MAINTAIN_SPEED.value
        events.append(ActionEvent(
            agent_id=agent_id, agent_role=role, action=action,
            start_time=float(t[i]), end_time=float(t[i + 1]),
            road_id=int(road[i]), lane_id=int(lane[i]),
            detail={"speed": round(float(speed), 2), "accel": round(float(a), 2)},
        ))

    long_events = merge_consecutive(events, Thresholds.MIN_EVENT_DURATION)

    # Lane-change + junction transitions as discrete annotated events.
    discrete: List[ActionEvent] = []
    for i in range(1, len(df)):
        prev_road, cur_road = int(road[i - 1]), int(road[i])
        prev_lane, cur_lane = int(lane[i - 1]), int(lane[i])
        ti = float(t[i])

        if cur_lane != prev_lane and cur_road == prev_road:
            direction = (EgoAction.LANE_CHANGE_LEFT if cur_lane > prev_lane
                         else EgoAction.LANE_CHANGE_RIGHT)
            discrete.append(ActionEvent(
                agent_id=agent_id, agent_role=role, action=direction.value,
                start_time=ti, end_time=ti, road_id=cur_road, lane_id=cur_lane,
                detail={"from_lane": prev_lane, "to_lane": cur_lane},
            ))

        in_prev = prev_road in junction_roads
        in_cur = cur_road in junction_roads
        if junction_roads and in_cur and not in_prev:
            discrete.append(ActionEvent(
                agent_id=agent_id, agent_role=role, action=EgoAction.ENTER_JUNCTION.value,
                start_time=ti, end_time=ti, road_id=cur_road, lane_id=cur_lane,
                detail={"entry_road": cur_road},
            ))
        elif junction_roads and in_prev and not in_cur:
            discrete.append(ActionEvent(
                agent_id=agent_id, agent_role=role, action=EgoAction.EXIT_JUNCTION.value,
                start_time=ti, end_time=ti, road_id=cur_road, lane_id=cur_lane,
                detail={"exit_road": cur_road},
            ))

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


def label_trajectory(
    traj_path: Path, meta_path: Path, map_path: Optional[Path] = None
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

    return {
        "dataset": meta.get("dataset"),
        "location": meta.get("location"),
        "duration": meta.get("duration"),
        "junction_aware": bool(junction_roads),
        "agents": agents_out,
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
