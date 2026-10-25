"""Deterministic, non-legal collision capability artifacts for Phase A."""
from __future__ import annotations

from datetime import datetime, timezone
from pathlib import Path
from typing import Any, Dict, Iterable, List, Optional

import pandas as pd
import yaml

from capability_schema import PROHIBITED_CLAIMS, unavailable, validate_card
from capability_sources import sha256_file, valid_persisted_collision


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


def _ego_speed_at_time(trajectory_path: Path, collision_time: Optional[float]) -> Optional[float]:
    if collision_time is None or not trajectory_path.is_file():
        return None
    try:
        df = pd.read_csv(trajectory_path)
        if not {"name", "time", "speed"}.issubset(df.columns):
            return None
        ego = df[df["name"].astype(str).str.strip() == "Ego"]
        if ego.empty:
            return None
        row = ego.iloc[(ego["time"].astype(float) - collision_time).abs().argsort().iloc[0]]
        return round(float(row["speed"]), 4)
    except Exception:
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
    speed = _ego_speed_at_time(trajectory, time_value)
    if speed is not None:
        inputs.append(_status_value("ego_speed_at_collision", speed, "m/s", "derived", str(trajectory), "Nearest recorded Ego trajectory sample at collision time."))
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
    card = {
        "schema_version": "capability-card/v1",
        "trial_id": str(trial_id),
        "generated_at": datetime.now(timezone.utc).isoformat(),
        "collision": {"actor": actor, "time": collision_time},
        "perception": {"first_detected": unavailable("first_detected", "No sensor event is recorded; first-in-range is intentionally not used as a proxy.", unit="s"), "method": "unavailable"},
        "inputs": inputs,
        "verdict": verdict,
    }
    return validate_card(card)


def save_capability_card(card: Dict[str, Any], path: str | Path) -> None:
    validate_card(card)
    target = Path(path)
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(yaml.safe_dump(card, sort_keys=False), encoding="utf-8")


def capability_summary(card: Dict[str, Any]) -> str:
    verdict = (card.get("verdict") or {}).get("label", "insufficient_data")
    if verdict == "insufficient_data":
        return "Capability/avoidability: insufficient data; perception and vehicle-capability values are unavailable for this trial."
    return "Capability/avoidability engineering result: {}. This is not a legal-fault or certification conclusion.".format(verdict)
