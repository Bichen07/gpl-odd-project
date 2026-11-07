"""Deterministic, non-legal collision capability artifacts for Phase A."""
from __future__ import annotations

import csv
from datetime import datetime, timezone
from pathlib import Path
from typing import Any, Dict, Iterable, List, Optional

import yaml

from capability_schema import PROHIBITED_CLAIMS, unavailable, validate_card
from capability_sources import sha256_file, valid_persisted_collision
from capability_assumptions import build_illustrative_assumption_profile


REPO_ROOT = Path(__file__).resolve().parents[3]


def _status_value(key: str, value: Any, unit: str, status: str, source: str, rationale: str = "") -> Dict[str, Any]:
    item: Dict[str, Any] = {"key": key, "value": value, "unit": unit, "status": status, "source": source}
    if rationale:
        item["rationale"] = rationale
    return item


def _collision_from_action(action_data: Optional[Dict[str, Any]]) -> Optional[Dict[str, Any]]:
    for interaction in (action_data or {}).get("interactions", []):
        if interaction.get("type") != "COLLISION":
            continue
        try:
            key_time = float(interaction.get("key_time"))
        except (TypeError, ValueError):
            continue
        if key_time > 0:
            return {"actor": interaction.get("with_name"), "time": key_time, "source": "analyzer_polygon_resolver"}
    return None


def _ego_track_id(action_data: Optional[Dict[str, Any]]) -> Optional[str]:
    for actor in (action_data or {}).get("agents", []):
        if str(actor.get("role", "")).lower() == "ego" and actor.get("track_id") is not None:
            return str(actor["track_id"])
    return None


def _source_path(path: Path) -> str:
    """Use a checkout-portable provenance path whenever the source is in this repo."""
    try:
        return str(path.resolve().relative_to(REPO_ROOT))
    except ValueError:
        return str(path)


def _ego_speed_at_time(
    trajectory_path: Path, collision_time: Optional[float], ego_track_id: Optional[str] = None
) -> Optional[float]:
    if collision_time is None or not trajectory_path.is_file():
        return None
    try:
        nearest = None
        with trajectory_path.open(newline="", encoding="utf-8") as source:
            for row in csv.DictReader(source):
                has_actor_name = bool(str(row.get("name") or "").strip())
                row_track_id = str(row.get("trackId") or row.get("track_id") or "").strip()
                is_ego = str(row.get("name") or "").strip() == "Ego" if has_actor_name else row_track_id == str(ego_track_id)
                if not is_ego:
                    continue
                sample_time = float(row["time"])
                speed = float(row.get("speed") or row.get("velocity"))
                candidate = (abs(sample_time - collision_time), speed)
                if nearest is None or candidate[0] < nearest[0]:
                    nearest = candidate
        return round(nearest[1], 4) if nearest is not None else None
    except (OSError, KeyError, TypeError, ValueError):
        return None


def evaluate_avoidability(inputs: Dict[str, Any]) -> Dict[str, Any]:
    """Evaluate supplied, provenance-checked synthetic or recorded inputs.

    This routine does not infer any missing inputs.  It is intentionally small:
    a delayed straight-line braking check, not a legal or certified model.
    """
    required = ("perception_time_s", "response_delay_s", "ego_speed_mps", "available_gap_m", "brake_limits_mps2", "lane_geometry")
    for key in required:
        item = inputs.get(key)
        if not item or item.get("status") == "unavailable":
            return {"label": "insufficient_data", "reason_codes": ["missing_" + key]}
    if inputs["lane_geometry"].get("value") is not True:
        return {"label": "insufficient_data", "reason_codes": ["lane_geometry_unavailable"]}
    try:
        speed = float(inputs["ego_speed_mps"]["value"])
        gap = float(inputs["available_gap_m"]["value"])
        delay = float(inputs["response_delay_s"]["value"])
        limits = sorted(float(limit) for limit in inputs["brake_limits_mps2"]["value"])
    except (KeyError, TypeError, ValueError):
        return {"label": "insufficient_data", "reason_codes": ["invalid_braking_inputs"]}
    remaining_gap = gap - speed * delay
    if remaining_gap <= 0 or not limits:
        return {"label": "unavoidable_under_stated_assumptions", "reason_codes": ["no_braking_distance_after_delay"]}
    required_brake = speed * speed / (2.0 * remaining_gap)
    observed_brake = inputs.get("observed_brake_mps2") or {}
    if required_brake <= limits[0]:
        if observed_brake.get("status") != "unavailable" and float(observed_brake.get("value", 0.0)) < required_brake:
            return {"label": "may_be_system_issue", "reason_codes": ["braking_capacity_exceeded_observed_brake"], "required_brake_mps2": required_brake}
        return {"label": "may_be_system_issue", "reason_codes": ["avoidability_requires_engineering_review"], "required_brake_mps2": required_brake}
    if required_brake <= limits[-1]:
        return {"label": "depends_on_capability_limit", "reason_codes": ["brake_sensitivity_disagreement"], "required_brake_mps2": required_brake}
    return {"label": "unavoidable_under_stated_assumptions", "reason_codes": ["required_brake_exceeds_tested_limits"], "required_brake_mps2": required_brake}


def build_capability_card(
    *,
    trial_id: str,
    trajectory_path: str | Path,
    trial_events: Optional[Iterable[Dict[str, Any]]] = None,
    action_data: Optional[Dict[str, Any]] = None,
    capability_snapshot: Optional[Dict[str, Any]] = None,
    analysis_context: Optional[Dict[str, Dict[str, Any]]] = None,
    visibility_evidence: Optional[Dict[str, Any]] = None,
    profile_sensitivity: Optional[Iterable[Dict[str, Any]]] = None,
    include_illustrative_assumptions: bool = False,
) -> Dict[str, Any]:
    """Build an honest card; unresolved perception/capability stays unavailable."""
    trajectory = Path(trajectory_path)
    event = valid_persisted_collision(trial_events)
    derived = None if event else _collision_from_action(action_data)
    if event:
        collision_time = {
            "value": float(event["esminiSeconds"]), "unit": "s", "status": "recorded",
            "source": "Payload Trial.events/{}".format(event.get("observation")),
            "source_sha256": sha256_file(trajectory),
        }
        actor = str(event["name"])[len("collisionWith"):]
    elif derived:
        collision_time = {
            "value": derived["time"], "unit": "s", "status": "derived",
            "source": derived["source"], "source_sha256": sha256_file(trajectory),
        }
        actor = derived.get("actor")
    else:
        collision_time = unavailable("collision_time", "No valid persisted event or deterministic collision resolution is available.", unit="s")
        actor = None

    time_value = collision_time.get("value")
    inputs: List[Dict[str, Any]] = [
        unavailable("perception_time_s", "No sensor-detection event is recorded for this trial.", unit="s"),
        unavailable("response_delay_s", "No measured sensing, decision, and actuation timestamps are recorded for this trial.", unit="s"),
        unavailable("emergency_brake_mps2", "No selected, run-linked emergency braking capability is recorded.", unit="m/s^2"),
        unavailable("lateral_limit_mps2", "No selected vehicle configuration and validated lane-geometry model are recorded.", unit="m/s^2"),
        unavailable("road_grade_percent", "No per-trial grade source is recorded.", unit="%"),
        unavailable("friction_coefficient", "No per-trial friction source is recorded."),
        unavailable("right_of_way", "No per-trial right-of-way source is recorded."),
        unavailable("lane_geometry", "No validated lane-geometry artifact is attached to this capability card."),
    ]
    speed = _ego_speed_at_time(trajectory, time_value, _ego_track_id(action_data))
    if speed is not None:
        inputs.append(_status_value("ego_speed_at_collision", speed, "m/s", "derived", _source_path(trajectory), "Nearest recorded Ego trajectory sample at collision time."))
    else:
        inputs.append(unavailable("ego_speed_at_collision", "Trajectory cannot provide an Ego speed at a resolved collision time.", unit="m/s"))
    for item in (capability_snapshot or {}).get("inputs", []):
        normalized = dict(item)
        if normalized.get("sourcePath") and not normalized.get("source"):
            normalized["source"] = normalized["sourcePath"]
        if normalized.get("sourceSha256") and not normalized.get("source_sha256"):
            normalized["source_sha256"] = normalized["sourceSha256"]
        inputs.append(normalized)

    verdict = {"label": "insufficient_data", "reason_codes": ["perception_and_capability_provenance_missing"], "prohibited_claims": sorted(PROHIBITED_CLAIMS)}
    context = dict(analysis_context or {})
    context.setdefault(
        "batch_id",
        unavailable("batch_id", "Analyzer did not receive a source-backed batch identity."),
    )
    context.setdefault(
        "scenario_archetype",
        unavailable(
            "scenario_archetype",
            "Phase A does not infer a scenario archetype from a filename or trajectory.",
        ),
    )
    opportunity = (visibility_evidence or {}).get("visibility_opportunity")
    if not isinstance(opportunity, dict):
        opportunity = unavailable(
            "visibility_opportunity",
            "No geometric visibility-evidence artifact is attached to this capability card.",
            unit="s",
        )
    card = {
        "schema_version": "capability-card/v1",
        "trial_id": str(trial_id),
        "generated_at": datetime.now(timezone.utc).isoformat(),
        "collision": {"actor": actor, "time": collision_time},
        "perception": {"first_detected": unavailable("first_detected", "No sensor event is recorded; first-in-range is intentionally not used as a proxy.", unit="s"), "method": "unavailable"},
        "visibility": {"opportunity": opportunity},
        "profile_sensitivity": list(profile_sensitivity or []),
        "analysis_context": context,
        "inputs": inputs,
        "verdict": verdict,
    }
    if include_illustrative_assumptions:
        card["illustrative_assumptions"] = build_illustrative_assumption_profile(speed)
    return validate_card(card)


def save_capability_card(card: Dict[str, Any], path: str | Path) -> None:
    validate_card(card)
    target = Path(path)
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(yaml.safe_dump(card, sort_keys=False), encoding="utf-8")


def capability_summary(card: Dict[str, Any]) -> str:
    verdict = (card.get("verdict") or {}).get("label", "insufficient_data")
    if verdict == "insufficient_data":
        suffix = ""
        if card.get("illustrative_assumptions"):
            suffix = " An illustrative sensitivity profile is attached but does not change this verdict."
        return "Capability/avoidability: insufficient data; perception and vehicle-capability values are unavailable for this trial." + suffix
    return "Capability/avoidability engineering result: {}. This is not a legal-fault or certification conclusion.".format(verdict)
