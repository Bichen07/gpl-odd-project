#!/usr/bin/env python3
"""description.py — natural-language scenario narration from ``action.yaml``.

Reads Labeller output and renders human ``description.txt`` (scenario prose,
per-agent actions, Critical/Interactions). Optional *snapshot_evidence* may add
a short BEV filename index — never the raw az/d/ttc metrics table (LLM context
uses ``processed/context.md`` sentence timelines instead).

Map-agnostic: narration is driven by the taxonomy action labels, so it works on
the full hct_6 network (not only intersection maneuvers).

CLI:
  python3 app/analyzer/src/description.py \
      --action results/dataset1/4/cluster0/processed/action.yaml \
      --out    results/dataset1/4/cluster0/processed/description.txt
"""
from __future__ import annotations

import argparse
from pathlib import Path
from typing import Any, Dict, List, Optional, Tuple

import yaml

try:
    import pandas as pd
except ImportError:  # pragma: no cover
    pd = None  # type: ignore

# Human-readable phrasing for each action label.
_EGO_PHRASES = {
    "MAINTAIN_SPEED": "maintains speed",
    "DECELERATE": "decelerates",
    "ACCELERATE": "accelerates",
    "EMERGENCY_BRAKE": "brakes hard (emergency braking)",
    "STOPPED": "is stopped",
    "LANE_CHANGE_LEFT": "changes lane to the left",
    "LANE_CHANGE_RIGHT": "changes lane to the right",
    "TURN_LEFT": "turns left",
    "TURN_RIGHT": "turns right",
    "GO_STRAIGHT": "goes straight",
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
        elif attrs.get("scope") == "same_lane" and "heading_change_deg" in attrs:
            extra = (
                f" (same-lane, Δheading={attrs['heading_change_deg']}°, "
                f"{attrs.get('heading_start_deg')}°→{attrs.get('heading_end_deg')}°)"
            )
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
        clearance = (
            " (minimum distance between vehicle boundaries "
            f"{attrs['min_clearance_m']} m)"
        )
    return f"  {when}: {phrase}{target} {loc}{speed_txt}{clearance}"


def _partner_label(iv: Dict) -> str:
    if iv.get("with_name"):
        return str(iv["with_name"])
    tid = iv.get("with_track_id")
    return f"track {tid}" if tid is not None else "unknown agent"


def _format_interaction_detail(iv: Dict) -> str:
    det = []
    if iv.get("min_clearance_m") is not None:
        det.append(
            "minimum distance between vehicle boundaries "
            f"{iv['min_clearance_m']} m"
        )
    if iv.get("min_distance_m") is not None:
        det.append(f"minimum center-to-center distance {iv['min_distance_m']} m")
    if iv.get("min_ttc_s") is not None:
        det.append(f"minimum estimated time to collision {iv['min_ttc_s']} s")
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
        lines.append(
            "  contact geometry: minimum distance between vehicle boundaries "
            f"{iv['min_clearance_m']} m"
        )
    if iv.get("source"):
        lines.append(f"  partner source: {iv['source']}")
    return lines


def _agent_action_table(
    agent: Dict,
    traj_df: Any = None,
    partner_tid: Optional[int] = None,
    partner_label: str = "Opposite",
    map_tracks_csv: Optional[str] = None,
) -> List[str]:
    """Detailed kinematics table for human ``description.txt``."""
    from kinematics_context import format_enriched_action_table

    return format_enriched_action_table(
        agent,
        traj_df,
        partner_tid if agent.get("role") == "ego" else None,
        partner_label,
        map_tracks_csv=map_tracks_csv,
    )


def _ego_actions_with_checkpoints_table(
    action_data: Dict,
    ego_agent: Dict,
    traj_df: Any,
    partner_tid: Optional[int],
    partner_label: str,
    map_tracks_csv: Optional[str] = None,
) -> List[str]:
    """Single Ego table: action rows + before/after near-miss rows, time-sorted."""
    if traj_df is None:
        return _agent_action_table(
            ego_agent,
            traj_df=traj_df,
            partner_tid=partner_tid,
            partner_label=partner_label,
            map_tracks_csv=map_tracks_csv,
        )

    from kinematics_context import enrich_action_row, sample_kinematics_at_time

    def _fmt_num(v, fmt):
        return "—" if v is None else fmt.format(v)

    rows: List[Tuple[float, str]] = []

    # Action rows.
    for act in ego_agent.get("actions") or []:
        st = float(act.get("start_time", 0.0))
        et = float(act.get("end_time", st))
        kin = enrich_action_row(
            act,
            traj_df,
            int(ego_agent.get("track_id", 0)),
            partner_tid,
            map_tracks_csv=map_tracks_csv,
        )
        tspan = f"{st:.1f}s" if abs(st - et) < 1e-6 else f"{st:.1f}–{et:.1f}s"
        v_cell = _fmt_num(kin.get("v0"), "{:.2f}") if abs(st - et) < 1e-6 else (
            f"{_fmt_num(kin.get('v0'), '{:.2f}')}→{_fmt_num(kin.get('v1'), '{:.2f}')}"
        )
        a_cell = _fmt_num(kin.get("a"), "{:.2f}")
        if abs(st - et) < 1e-6:
            h_cell = _fmt_num(kin.get("hdg0"), "{:.1f}")
            vs_cell = _fmt_num(kin.get("vs0"), "{:+.1f}")
            vlat_cell = _fmt_num(kin.get("vlat0"), "{:+.2f}")
        else:
            h0 = _fmt_num(kin.get("hdg0"), "{:.1f}")
            h1 = _fmt_num(kin.get("hdg1"), "{:.1f}")
            dh = _fmt_num(kin.get("d_hdg"), "{:+.1f}")
            h_cell = f"{h0}→{h1} (Δ{dh})" if h0 != "—" else "—"
            vs0 = _fmt_num(kin.get("vs0"), "{:+.1f}")
            vs1 = _fmt_num(kin.get("vs1"), "{:+.1f}")
            vs_cell = f"{vs0}→{vs1}" if vs0 != "—" or vs1 != "—" else "—"
            vl0 = _fmt_num(kin.get("vlat0"), "{:+.2f}")
            vl1 = _fmt_num(kin.get("vlat1"), "{:+.2f}")
            vlat_cell = f"{vl0}→{vl1}" if vl0 != "—" or vl1 != "—" else "—"
        d_cell = (
            f"{_fmt_num(kin.get('d0'), '{:.1f}')}→{_fmt_num(kin.get('d1'), '{:.1f}')}"
            if kin.get("d1") is not None and abs(st - et) > 1e-6
            else _fmt_num(kin.get("d0"), "{:.1f}")
        )
        az_cell = (
            f"{_fmt_num(kin.get('az0'), '{:.1f}')}→{_fmt_num(kin.get('az1'), '{:.1f}')}"
            if kin.get("az1") is not None and abs(st - et) > 1e-6
            else _fmt_num(kin.get("az0"), "{:.1f}")
        )
        row = (
            f"| {tspan} | {act.get('action')} | {act.get('road_id')} | {act.get('lane_id')} | "
            f"{v_cell} | {a_cell} | {h_cell} | {vs_cell} | {vlat_cell} | {d_cell} | {az_cell} |"
        )
        rows.append((st, row))

    # Checkpoint rows.
    peak_t = None
    for iv in action_data.get("interactions") or []:
        if str(iv.get("type")) in {"NEAR_MISS", "COLLISION"} and iv.get("key_time") is not None:
            peak_t = float(iv["key_time"])
            break
    if peak_t is not None:
        checkpoints: List[Tuple[str, float]] = [
            ("2s before", peak_t - 2.0),
            ("1s before", peak_t - 1.0),
            ("0.5s before", peak_t - 0.5),
            ("0.2s before", peak_t - 0.2),
            ("near-miss", peak_t),
            ("0.2s after", peak_t + 0.2),
            ("0.5s after", peak_t + 0.5),
            ("1s after", peak_t + 1.0),
        ]
        for label, t in checkpoints:
            k = sample_kinematics_at_time(
                traj_df,
                track_id=int(ego_agent.get("track_id", 0)),
                t=t,
                partner_tid=partner_tid,
                map_tracks_csv=map_tracks_csv,
            )
            if not k:
                continue
            row = (
                f"| {k['t']:.2f}s | {label} | {k.get('road_id','—')} | {k.get('lane_id','—')} | "
                f"{k.get('v', 0.0):.2f} | {_fmt_num(k.get('a'), '{:.2f}')} | "
                f"{k.get('hdg', 0.0):.1f} | {_fmt_num(k.get('vs_road'), '{:+.1f}')} | "
                f"{_fmt_num(k.get('v_lat'), '{:+.2f}')} | "
                f"{_fmt_num(k.get('d'), '{:.1f}')} | {_fmt_num(k.get('az'), '{:.1f}')} |"
            )
            rows.append((float(k["t"]), row))

    rows.sort(key=lambda it: it[0])
    lines = [
        "### Ego (car, ego)",
        "",
        "_vs road_ = nose heading − local road direction at current position.",
        "_v_lat_ ≈ v * sin(vs_road): signed lateral speed (+ leftward, − rightward).",
        "",
        "| time | action | road | lane | v (m/s) | a (m/s²) | heading (°) | vs road (°) | "
        f"v_lat (m/s) | d→{partner_label} (m) | az→{partner_label} (°) |",
        "|------|--------|------|------|---------|----------|-------------|---------------|"
        "-------------|-------------------|--------------------|",
    ]
    lines.extend(r for _, r in rows)
    lines.append("")
    return lines


def build_description(
    action_data: Dict,
    snapshot_evidence: Optional[str] = None,
    traj_df: Any = None,
    map_tracks_csv: Optional[str] = None,
) -> str:
    from kinematics_context import partner_name, primary_partner_track_id

    parts: List[str] = []
    loc = action_data.get("location", "unknown")
    dur = action_data.get("duration", "?")
    parts.append(f"Scenario on map '{loc}', duration {dur}s.")
    if not action_data.get("junction_aware", False):
        parts.append(
            "(Map junction info unavailable — junction transitions omitted; "
            "run app/analyzer/src/dataset_builder.py --map-only to enable.)"
        )
    parts.append("")

    partner_tid = primary_partner_track_id(action_data) if traj_df is not None else None
    pname = partner_name(action_data, partner_tid)

    # Detailed structured tables with kinematics when trajectory is available.
    parts.append("## Agent actions")
    parts.append("")
    if traj_df is not None and partner_tid is not None:
        parts.append(
            f"Ego rows include velocity, accel, heading, and geometry vs "
            f"**{pname}** (track {partner_tid}) at action start→end."
        )
        parts.append("")
    agents = sorted(action_data.get("agents", []), key=lambda a: a["track_id"])
    for agent in agents:
        if str(agent.get("role", "")).lower() == "ego":
            parts.extend(
                _ego_actions_with_checkpoints_table(
                    action_data=action_data,
                    ego_agent=agent,
                    traj_df=traj_df,
                    partner_tid=partner_tid,
                    partner_label=pname,
                    map_tracks_csv=map_tracks_csv,
                )
            )
        else:
            parts.extend(
                _agent_action_table(
                    agent,
                    traj_df=traj_df,
                    partner_tid=partner_tid,
                    partner_label=pname,
                    map_tracks_csv=map_tracks_csv,
                )
            )

    # Prose narration (human-readable complement to the tables).
    parts.append("## Narration")
    parts.append("")
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

    if snapshot_evidence:
        parts.append(snapshot_evidence.rstrip())
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
