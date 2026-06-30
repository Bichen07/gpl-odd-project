#!/usr/bin/env python3
"""description.py — V1-5 / Step T-3: natural-language scenario narration.

Reads `action.yaml` (from labeller.py) and renders a plain-English
`description.txt` that feeds directly into the LLM prompt (Step 5).

Map-agnostic: narration is driven by the taxonomy action labels, so it works on
the full hct_6 network (not only intersection maneuvers).

CLI:
  python3 app/analyzer/src/description.py \
      --action results/dataset1/4/cluster0/action.yaml \
      --out    results/dataset1/4/cluster0/description.txt
"""
from __future__ import annotations

import argparse
from pathlib import Path
from typing import Dict, List

import yaml

# Human-readable phrasing for each action label.
_EGO_PHRASES = {
    "MAINTAIN_SPEED": "maintains speed",
    "DECELERATE": "decelerates",
    "ACCELERATE": "accelerates",
    "EMERGENCY_BRAKE": "brakes hard (emergency braking)",
    "STOPPED": "is stopped",
    "LANE_CHANGE_LEFT": "changes lane to the left",
    "LANE_CHANGE_RIGHT": "changes lane to the right",
    "ENTER_JUNCTION": "enters a junction",
    "EXIT_JUNCTION": "exits the junction",
}

_INTENT_PHRASES = {
    "TURN_LEFT": "turn left",
    "TURN_RIGHT": "turn right",
    "GO_STRAIGHT": "go straight",
}

_INTERACTION_PHRASES = {
    "NEAR_MISS": "near miss",
    "DANGEROUS_CUT_IN": "dangerous cut-in",
}

_RELATION_PHRASES = {
    "FOLLOWING_EGO": "follows the ego vehicle",
    "ONCOMING": "approaches from the opposite direction (oncoming)",
    "YIELD_TO_EGO": "yields to the ego vehicle",
    "CROSSING": "crosses the ego vehicle's path",
    "PARKED": "remains parked / stationary",
    "IRRELEVANT": "stays far from the ego vehicle",
}


def _narrate_agent(agent: Dict) -> List[str]:
    name = agent.get("name", f"agent {agent['track_id']}")
    role = agent.get("role", "npc")
    header = f"{name} (track {agent['track_id']}, {agent.get('type', 'car')})"
    if role == "npc" and "relation_to_ego" in agent:
        header += f" — {_RELATION_PHRASES.get(agent['relation_to_ego'], agent['relation_to_ego'])}"
    lines = [header + ":"]

    if not agent.get("actions"):
        lines.append("  (no significant actions detected)")
        return lines

    for act in agent["actions"]:
        phrase = _EGO_PHRASES.get(act["action"], act["action"].lower().replace("_", " "))
        t0, t1 = act["start_time"], act["end_time"]
        when = f"t={t0:.1f}s" if t0 == t1 else f"t={t0:.1f}-{t1:.1f}s"
        attrs = act.get("attributes", {})
        extra = ""
        if "target_speed" in attrs:                       # longitudinal maneuver
            extra = f" from {attrs.get('start_speed')} to {attrs['target_speed']} m/s"
        elif "speed" in attrs:                            # sustained stop
            extra = f" (~{attrs['speed']} m/s)"
        elif "to_lane" in attrs:                          # lane change
            extra = f" (lane {attrs['from_lane']}→{attrs['to_lane']})"
        elif "intent" in attrs:                           # junction entry
            intent_word = _INTENT_PHRASES.get(attrs["intent"], attrs["intent"].lower())
            extra = (f", intending to {intent_word} "
                     f"(road {attrs.get('entry_road')}→{attrs.get('exit_road')})")
        elif "exit_road" in attrs:                        # junction exit
            extra = f" (road {attrs['exit_road']})"
        lines.append(
            f"  {when}: {phrase} on road {act['road_id']}, lane {act['lane_id']}{extra}"
        )
    return lines


def build_description(action_data: Dict) -> str:
    parts: List[str] = []
    loc = action_data.get("location", "unknown")
    dur = action_data.get("duration", "?")
    parts.append(f"Scenario on map '{loc}', duration {dur}s.")
    if not action_data.get("junction_aware", False):
        parts.append(
            "(Map junction info unavailable — junction transitions omitted; "
            "run scripts/map_preprocess.py to enable.)"
        )
    parts.append("")

    # Ego first, then NPCs.
    agents = sorted(action_data.get("agents", []), key=lambda a: a["track_id"])
    for agent in agents:
        parts.extend(_narrate_agent(agent))
        parts.append("")

    # Multi-agent interactions (ego-relative conflicts).
    interactions = action_data.get("interactions") or []
    if interactions:
        parts.append("Interactions:")
        for iv in interactions:
            phrase = _INTERACTION_PHRASES.get(iv.get("type"), str(iv.get("type")).lower())
            kt = iv.get("key_time")
            det = []
            if iv.get("min_distance_m") is not None:
                det.append(f"min distance {iv['min_distance_m']} m")
            if iv.get("min_ttc_s") is not None:
                det.append(f"min TTC {iv['min_ttc_s']} s")
            if iv.get("ego_reaction_accel") is not None:
                det.append(f"ego braking {iv['ego_reaction_accel']} m/s²")
            tail = f" ({', '.join(det)})" if det else ""
            parts.append(
                f"  t={kt:.1f}s: {phrase} with track {iv.get('with_track_id')}{tail}"
            )
        parts.append("")

    return "\n".join(parts).rstrip() + "\n"


def save_description_txt(text: str, out_path: Path) -> None:
    out_path.parent.mkdir(parents=True, exist_ok=True)
    out_path.write_text(text)


def describe_action_file(action_path: Path) -> str:
    with open(action_path) as f:
        action_data = yaml.safe_load(f)
    return build_description(action_data)


def main() -> int:
    ap = argparse.ArgumentParser(description="Scenario description generator (V1-5)")
    ap.add_argument("--action", required=True)
    ap.add_argument("--out", required=True)
    args = ap.parse_args()

    text = describe_action_file(Path(args.action))
    save_description_txt(text, Path(args.out))
    print(f"✓ wrote {args.out}")
    print("-" * 50)
    print(text)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
