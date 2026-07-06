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
    "COLLISION": "collides",
}

_INTENT_PHRASES = {
    "TURN_LEFT": "turn left",
    "TURN_RIGHT": "turn right",
    "GO_STRAIGHT": "go straight",
}

_INTERACTION_PHRASES = {
    "COLLISION": "collision",
    "NEAR_MISS": "near miss",
    "DANGEROUS_CUT_IN": "dangerous cut-in",
    "CLOSEST_APPROACH": "closest approach",
}

_CRITICAL_TIER_A = frozenset({"COLLISION", "NEAR_MISS", "DANGEROUS_CUT_IN"})
_CRITICAL_TIER_B = frozenset({"CLOSEST_APPROACH"})

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
        attrs = act.get("attributes", {})
        if act["action"] == "COLLISION" and attrs.get("role") == "partner":
            phrase = "is struck by"
        else:
            phrase = _EGO_PHRASES.get(act["action"], act["action"].lower().replace("_", " "))
        t0, t1 = act["start_time"], act["end_time"]
        when = f"t={t0:.1f}s" if t0 == t1 else f"t={t0:.1f}-{t1:.1f}s"
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
        elif act["action"] == "COLLISION":
            lines.append(_format_collision_action_line(when, phrase, act, role))
            continue
        lines.append(
            f"  {when}: {phrase} on road {act['road_id']}, lane {act['lane_id']}{extra}"
        )
    return lines


def _format_collision_action_line(when: str, phrase: str, act: dict, role: str) -> str:
    attrs = act.get("attributes", {})
    partner = attrs.get("with_name", "unknown agent")
    ptid = attrs.get("with_track_id")
    who = f"{partner} (track {ptid})" if ptid is not None else str(partner)
    if attrs.get("role") == "partner" or role != "ego":
        target = f" {who}"
    else:
        target = f" with {who}"

    loc = f"on road {act['road_id']}, lane {act['lane_id']}"
    ex, ey = attrs.get("ego_x"), attrs.get("ego_y")
    px, py = attrs.get("partner_x"), attrs.get("partner_y")
    if role == "ego" and ex is not None and ey is not None:
        loc += f" at (x={ex}, y={ey})"
    elif px is not None and py is not None:
        loc += f" at (x={px}, y={py})"

    speeds = []
    if attrs.get("ego_speed_mps") is not None:
        speeds.append(f"ego {attrs['ego_speed_mps']} m/s")
    if attrs.get("partner_speed_mps") is not None:
        speeds.append(f"partner {attrs['partner_speed_mps']} m/s")
    speed_txt = f" — {', '.join(speeds)}" if speeds else ""
    clearance = ""
    if attrs.get("min_clearance_m") is not None:
        clearance = f" (clearance {attrs['min_clearance_m']} m)"
    return f"  {when}: {phrase}{target} {loc}{speed_txt}{clearance}"


def _partner_label(iv: Dict) -> str:
    if iv.get("with_name"):
        return str(iv["with_name"])
    tid = iv.get("with_track_id")
    return f"track {tid}" if tid is not None else "unknown agent"


def _format_interaction_detail(iv: Dict) -> str:
    det = []
    if iv.get("min_clearance_m") is not None:
        det.append(f"min clearance {iv['min_clearance_m']} m")
    if iv.get("min_distance_m") is not None:
        det.append(f"min distance {iv['min_distance_m']} m")
    if iv.get("min_ttc_s") is not None:
        det.append(f"min TTC {iv['min_ttc_s']} s")
    if iv.get("ego_reaction_accel") is not None:
        det.append(f"ego braking {iv['ego_reaction_accel']} m/s²")
    if iv.get("source"):
        det.append(f"source {iv['source']}")
    return f" ({', '.join(det)})" if det else ""


def _format_collision_structured(iv: Dict) -> List[str]:
    """Structured collision block for description.txt / LLM prompts."""
    lines = ["Collision event:"]
    lines.append(f"  when: t={float(iv.get('key_time', 0)):.1f}s")
    ego = iv.get("ego_at_collision") or {}
    partner = iv.get("partner_at_collision") or {}
    pname = _partner_label(iv)
    if ego:
        lines.append(
            f"  where (ego): road {ego.get('road_id')}, lane {ego.get('lane_id')} "
            f"(x={ego.get('x')}, y={ego.get('y')})"
        )
        lines.append(
            f"  ego: {ego.get('name', 'Ego')} — speed {ego.get('speed_mps')} m/s"
        )
    if partner:
        lines.append(
            f"  partner: {pname} (track {iv.get('with_track_id')}) — "
            f"speed {partner.get('speed_mps')} m/s, "
            f"road {partner.get('road_id')}, lane {partner.get('lane_id')} "
            f"(x={partner.get('x')}, y={partner.get('y')})"
        )
    if iv.get("min_clearance_m") is not None:
        lines.append(f"  contact: min clearance {iv['min_clearance_m']} m")
    if iv.get("source"):
        lines.append(f"  partner source: {iv['source']}")
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
        collisions = [
            iv for iv in interactions if iv.get("type") == "COLLISION"
        ]
        if collisions:
            parts.append("Collision:")
            for iv in collisions:
                parts.extend(_format_collision_structured(iv))
            parts.append("")

        critical = [iv for iv in interactions if iv.get("type") in _CRITICAL_TIER_A | _CRITICAL_TIER_B]
        if critical:
            parts.append("Critical moments:")
            for iv in critical:
                phrase = _INTERACTION_PHRASES.get(iv.get("type"), str(iv.get("type")).lower())
                kt = iv.get("key_time")
                partner = _partner_label(iv)
                parts.append(
                    f"  t={kt:.1f}s: {phrase} with {partner}{_format_interaction_detail(iv)}"
                )
            parts.append("")

        parts.append("Interactions:")
        for iv in interactions:
            phrase = _INTERACTION_PHRASES.get(iv.get("type"), str(iv.get("type")).lower())
            kt = iv.get("key_time")
            partner = _partner_label(iv)
            parts.append(
                f"  t={kt:.1f}s: {phrase} with {partner}{_format_interaction_detail(iv)}"
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
