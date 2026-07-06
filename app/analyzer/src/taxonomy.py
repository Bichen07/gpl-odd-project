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
    DECELERATE = "DECELERATE"          # xosc_gen "slow_down"
    ACCELERATE = "ACCELERATE"          # xosc_gen "speed_up"
    LANE_CHANGE_LEFT = "LANE_CHANGE_LEFT"
    LANE_CHANGE_RIGHT = "LANE_CHANGE_RIGHT"
    ENTER_JUNCTION = "ENTER_JUNCTION"
    EXIT_JUNCTION = "EXIT_JUNCTION"
    TURN_LEFT = "TURN_LEFT"            # xosc_gen "turn_left"
    TURN_RIGHT = "TURN_RIGHT"          # xosc_gen "turn_right"
    GO_STRAIGHT = "GO_STRAIGHT"        # xosc_gen "go_straight" (through a junction)
    EMERGENCY_BRAKE = "EMERGENCY_BRAKE"
    STOPPED = "STOPPED"


class NpcAction(str, Enum):
    FOLLOWING_EGO = "FOLLOWING_EGO"
    ONCOMING = "ONCOMING"
    YIELD_TO_EGO = "YIELD_TO_EGO"
    CROSSING = "CROSSING"
    PARKED = "PARKED"
    IRRELEVANT = "IRRELEVANT"


class InteractionAction(str, Enum):
    """Composite, multi-agent labels produced by the Interactive Action Detector."""
    COLLISION = "COLLISION"
    NEAR_MISS = "NEAR_MISS"
    DANGEROUS_CUT_IN = "DANGEROUS_CUT_IN"
    CLOSEST_APPROACH = "CLOSEST_APPROACH"


# Detection thresholds (tuned for esmini @ ~0.1s sampling, m/s, m/s²).
class Thresholds:
    # Longitudinal coarse pass (xosc_gen label_longitudinal_actions, thesis §4.2):
    # a per-frame acceleration with |a| > CRUISE_BAND is speed_up/slow_down, else
    # cruise (the implicit baseline). This is the xosc-faithful segmentation.
    CRUISE_BAND = 0.05     # m/s² → |a| below this is "cruise" (not a maneuver)
    EMERGENCY_DECEL = -4.0  # m/s² → a slow_down with mean accel ≤ this ⇒ EMERGENCY_BRAKE
    STOPPED_SPEED = 0.3    # m/s  → STOPPED / PARKED
    MIN_EVENT_DURATION = 0.5  # s   → a kept speed segment must last ≥ this (thesis §4.2)
    # Conciseness filters (thesis §4.2 "eliminate spurious or insignificant events").
    # A speed-change segment is kept only if it lasts ≥ MIN_EVENT_DURATION AND the
    # velocity actually changes by ≥ MIN_DELTA_V; MAINTAIN_SPEED is never emitted
    # (it is the implicit baseline between real maneuvers).
    MIN_DELTA_V = 0.2      # m/s  → discard speed changes smaller than this
    STOPPED_MIN_DURATION = 1.0  # s → only report a sustained stop (≥ this long)
    # Intensity sub-split (xosc_gen label_longitudinal_actions, thesis §4.2 stage 2).
    # Within one same-category run, split when the mean acceleration of the recent
    # MIN_CHANGE_DURATION window deviates from the established segment by more than
    # ACCEL_DEV_THRESHOLD (captures e.g. gentle-decel → hard-brake compound moves).
    ACCEL_DEV_THRESHOLD = 1.5  # m/s² → deviation that triggers an intensity split
    MIN_CHANGE_DURATION = 1.0  # s   → the new intensity must be sustained this long
    MERGE_SHORT_S = 1.5    # s    → re-merge same-type segments shorter than this
    # Lateral lane-change maneuver duration window (xosc_gen label_lateral_actions).
    LANE_CHANGE_MIN_S = 1.0  # s  → discard lane changes faster than this
    LANE_CHANGE_MAX_S = 3.0  # s  → cap (centre on jump) lane changes slower than this
    FOLLOW_GAP = 18.0      # m    → NPC FOLLOWING_EGO if gap below this
    NEAR_GAP = 30.0        # m    → NPC considered "relevant" to ego
    ONCOMING_HEADING = 2.2  # rad  → |Δheading| above this ⇒ opposing direction
    TURN_HEADING_DEG = 40.0  # deg → net |Δheading| through a junction ⇒ a turn
    #   (xosc_gen label_route_decisions uses 40°: |Δθ|≤40 ⇒ straight, else turn)
    ROUTE_MIN_DISP = 0.1   # m    → skip a junction passage with displacement below this
    # Interactive Action Detector (composite, multi-agent).
    TTC_NEAR_MISS = 2.5    # s    → TTC below this while closing ⇒ near_miss
    CUT_IN_REACTION_S = 2.0  # s   → ego must react within this after NPC cut-in
    CUT_IN_DECEL = -1.5    # m/s² → ego decel sharper than this ⇒ dangerous cut-in
    # Polygon clearance thresholds (collision partner + conflict focus).
    CONTACT_CLEARANCE_M = 0.5   # m → polygon gap ≤ this ⇒ contact / collision
    CONFLICT_RELEVANCE_M = 5.0  # m → moving-agent focus window for CLOSEST_APPROACH


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
