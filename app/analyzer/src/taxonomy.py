"""taxonomy.py — V1 rule-based behavior taxonomy (Step T-1).

A map-agnostic action vocabulary for gpl-odd scenarios. Unlike xosc_gen's
intersection-only taxonomy (go_straight / turn_left / turn_right / yield), this
covers lane-keeping, lane changes, junctions/merges and emergencies so it works
on the full hct_6 road network (not a single 4-way intersection).

Used by:
  * labeller.py     — classifies trajectory.csv rows into ActionEvent sequences
  * description.py  — renders ActionEvent sequences into plain-English text
"""
from __future__ import annotations

from dataclasses import dataclass, field
from enum import Enum
from typing import List, Optional


class EgoAction(str, Enum):
    MAINTAIN_SPEED = "MAINTAIN_SPEED"
    DECELERATE = "DECELERATE"
    ACCELERATE = "ACCELERATE"
    LANE_CHANGE_LEFT = "LANE_CHANGE_LEFT"
    LANE_CHANGE_RIGHT = "LANE_CHANGE_RIGHT"
    ENTER_JUNCTION = "ENTER_JUNCTION"
    EXIT_JUNCTION = "EXIT_JUNCTION"
    EMERGENCY_BRAKE = "EMERGENCY_BRAKE"
    STOPPED = "STOPPED"


class NpcAction(str, Enum):
    FOLLOWING_EGO = "FOLLOWING_EGO"
    CUTTING_IN = "CUTTING_IN"
    ONCOMING = "ONCOMING"
    YIELD_TO_EGO = "YIELD_TO_EGO"
    CROSSING = "CROSSING"
    PARKED = "PARKED"
    IRRELEVANT = "IRRELEVANT"


# Detection thresholds (tuned for esmini @ ~0.1s sampling, m/s, m/s²).
class Thresholds:
    ACCEL = 1.0            # m/s² → ACCELERATE
    DECEL = -1.0           # m/s² → DECELERATE
    EMERGENCY_DECEL = -4.0  # m/s² → EMERGENCY_BRAKE
    STOPPED_SPEED = 0.3    # m/s  → STOPPED / PARKED
    MIN_EVENT_DURATION = 0.8  # s   → merge shorter same-type events
    FOLLOW_GAP = 18.0      # m    → NPC FOLLOWING_EGO if gap below this
    NEAR_GAP = 30.0        # m    → NPC considered "relevant" to ego
    ONCOMING_HEADING = 2.2  # rad  → |Δheading| above this ⇒ opposing direction


@dataclass
class ActionEvent:
    """One classified behavior interval for a single agent."""
    agent_id: int          # trackId (0 = Ego)
    agent_role: str        # "ego" or "npc"
    action: str            # EgoAction / NpcAction value
    start_time: float
    end_time: float
    road_id: int
    lane_id: int
    detail: dict = field(default_factory=dict)  # e.g. speeds, gap, exit_road

    @property
    def duration(self) -> float:
        return round(self.end_time - self.start_time, 3)

    def to_dict(self) -> dict:
        out = {
            "action": self.action,
            "start_time": round(self.start_time, 2),
            "end_time": round(self.end_time, 2),
            "duration": self.duration,
            "road_id": int(self.road_id),
            "lane_id": int(self.lane_id),
        }
        if self.detail:
            out["attributes"] = self.detail
        return out


def merge_consecutive(events: List[ActionEvent], min_duration: float) -> List[ActionEvent]:
    """Collapse adjacent same-action events, then absorb sub-threshold runs.

    Two passes so that a long run made of many short same-action frames is
    grouped FIRST (otherwise each tiny frame would be absorbed into the
    previous, different-action run before the run can form):
      1. merge consecutive same-action events for the same agent into runs
      2. absorb any run still shorter than ``min_duration`` into its previous run
    """
    if not events:
        return []

    # Pass 1: group consecutive same-action runs.
    runs: List[ActionEvent] = [events[0]]
    for ev in events[1:]:
        last = runs[-1]
        if ev.agent_id == last.agent_id and ev.action == last.action:
            last.end_time = ev.end_time
        else:
            runs.append(ev)

    # Pass 2: absorb too-short runs into the previous run (same agent).
    merged: List[ActionEvent] = []
    for ev in runs:
        if (merged and ev.duration < min_duration
                and ev.agent_id == merged[-1].agent_id):
            merged[-1].end_time = ev.end_time
            continue
        merged.append(ev)

    # Pass 3: re-collapse in case absorption created new adjacencies.
    final: List[ActionEvent] = [merged[0]]
    for ev in merged[1:]:
        last = final[-1]
        if ev.agent_id == last.agent_id and ev.action == last.action:
            last.end_time = ev.end_time
        else:
            final.append(ev)
    return final
