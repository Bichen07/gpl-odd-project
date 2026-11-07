"""Versioned, explicitly illustrative assumptions for Phase A demonstrations.

These values are never measurements from an archived trial.  They exist only to
show how the capability-card UI can present a replaceable sensitivity envelope
until run-bound vehicle and perception data are available.
"""
from __future__ import annotations

from pathlib import Path
from typing import Any, Dict, List, Optional

import yaml

from capability_sources import sha256_file


REPO_ROOT = Path(__file__).resolve().parents[3]
RSS_PARAMETERS = REPO_ROOT / "simulation/ros/src/rss/data/parameters.yaml"
PACIFICA_PARAMETERS = REPO_ROOT / "sdc/vehicle-configuration/pacifica-1/parameters.yaml"

# Primary sources: these explain the engineering concepts and test benchmark.
MOBILEYE_RSS_URL = "https://www.mobileye.com/technology/responsibility-sensitive-safety/"
UNECE_R152_URL = "https://unece.org/sites/default/files/2024-04/R152r2E.pdf"


def _yaml_mapping(path: Path) -> Dict[str, Any]:
    try:
        value = yaml.safe_load(path.read_text(encoding="utf-8")) or {}
    except (OSError, yaml.YAMLError):
        return {}
    return value if isinstance(value, dict) else {}


def _source(path: Path) -> Dict[str, str]:
    return {"source": str(path.relative_to(REPO_ROOT)), "source_sha256": sha256_file(path)}


def _assumption(
    key: str, value: float, unit: str, source: str, rationale: str, *, source_sha256: Optional[str] = None
) -> Dict[str, Any]:
    item: Dict[str, Any] = {
        "key": key,
        "value": value,
        "unit": unit,
        "status": "assumed",
        "source": source,
        "rationale": rationale,
    }
    if source_sha256:
        item["source_sha256"] = source_sha256
    return item


def _stop_distance(speed_mps: float, response_s: float, brake_mps2: float) -> float:
    """Straight-line response plus braking distance; not an avoidability verdict."""
    return speed_mps * response_s + (speed_mps * speed_mps) / (2.0 * brake_mps2)


def build_illustrative_assumption_profile(ego_speed_mps: Optional[float]) -> Dict[str, Any]:
    """Create a source-labelled sensitivity envelope without changing the verdict.

    The 5.0 m/s² reference is a UN R152 test braking-demand requirement, not a
    statement that the trial vehicle is type-approved.  RSS and Pacifica values
    are project configuration values, not proof that they governed this run.
    """
    rss = _yaml_mapping(RSS_PARAMETERS)
    ego_dynamics = ((rss.get("rss") or {}).get("ego_vehicle_dynamics") or {})
    other_dynamics = ((rss.get("rss") or {}).get("other_vehicle_dynamics") or {})
    rss_hash = sha256_file(RSS_PARAMETERS) if RSS_PARAMETERS.is_file() else None
    pacifica = _yaml_mapping(PACIFICA_PARAMETERS)
    pacifica_hash = sha256_file(PACIFICA_PARAMETERS) if PACIFICA_PARAMETERS.is_file() else None

    brake_max = abs(float(((ego_dynamics.get("alphaLon") or {}).get("brakeMax", -8.2))))
    response_fast = float(ego_dynamics.get("responseTime", 0.05))
    response_conservative = float(other_dynamics.get("responseTime", 0.5))
    lateral_limit = float(pacifica.get("max_lateral_acceleration", 2.5))

    assumptions = [
        _assumption(
            "illustrative_un_r152_brake_demand_mps2",
            5.0,
            "m/s^2",
            UNECE_R152_URL,
            "UN R152 AEBS test braking-demand benchmark. It is not evidence that this vehicle, scenario, or run is compliant.",
        ),
        _assumption(
            "illustrative_project_rss_brake_max_mps2",
            brake_max,
            "m/s^2",
            str(RSS_PARAMETERS.relative_to(REPO_ROOT)),
            "Value in the current project RSS configuration; not recorded as the configuration used by this archived trial.",
            source_sha256=rss_hash,
        ),
        _assumption(
            "illustrative_project_rss_response_time_s",
            response_fast,
            "s",
            str(RSS_PARAMETERS.relative_to(REPO_ROOT)),
            "Ego RSS configuration value used only as a sensitivity input; it is not measured end-to-end sensing, planning, and actuation latency.",
            source_sha256=rss_hash,
        ),
        _assumption(
            "illustrative_conservative_response_time_s",
            response_conservative,
            "s",
            str(RSS_PARAMETERS.relative_to(REPO_ROOT)),
            "Alternate project RSS response value used to expose sensitivity; it is not a measured delay for Ego.",
            source_sha256=rss_hash,
        ),
        _assumption(
            "illustrative_project_pacifica_lateral_limit_mps2",
            lateral_limit,
            "m/s^2",
            str(PACIFICA_PARAMETERS.relative_to(REPO_ROOT)),
            "Vehicle configuration value used only to show an available future input. Lane geometry and controller calibration are absent, so lateral feasibility is not evaluated.",
            source_sha256=pacifica_hash,
        ),
    ]

    sensitivity: Dict[str, Any] = {
        "status": "illustrative_only",
        "method": "straight_line_stop_distance_at_collision_speed",
        "source": MOBILEYE_RSS_URL,
        "rationale": "RSS motivates explicit response-time and braking assumptions. This envelope is not a reconstruction of the pre-collision decision state.",
        "limitations": [
            "No first-detection timestamp or opening longitudinal gap is recorded.",
            "No lane geometry, friction, grade, or controller calibration is recorded.",
            "Rows therefore do not establish collision avoidability, system fault, legal responsibility, or certification compliance.",
        ],
        "rows": [],
    }
    if ego_speed_mps is None:
        sensitivity["speed_at_collision"] = {
            "status": "unavailable",
            "rationale": "The archived trajectory did not provide an Ego speed at the resolved collision time.",
            "unit": "m/s",
        }
    else:
        sensitivity["speed_at_collision"] = {
            "value": round(float(ego_speed_mps), 4),
            "unit": "m/s",
            "status": "derived",
            "source": "archived trajectory nearest Ego sample",
            "rationale": "Used only as the initial speed for the illustrative stopping-distance envelope.",
        }
        for response in (response_fast, response_conservative):
            for brake in (5.0, brake_max):
                sensitivity["rows"].append(
                    {
                        "response_time_s": response,
                        "brake_deceleration_mps2": brake,
                        "straight_line_stop_distance_m": round(_stop_distance(float(ego_speed_mps), response, brake), 4),
                    }
                )

    return {
        "profile_version": "phase-a-illustrative-assumptions/v1",
        "purpose": "Replaceable sensitivity demonstration; never a measurement or primary verdict input.",
        "primary_verdict_unchanged": True,
        "assumptions": assumptions,
        "sensitivity": sensitivity,
    }
