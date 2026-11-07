"""Versioned, replaceable perception/response profiles for Phase A.

These profiles are deliberately *not* a shortcut for historical evidence.  They
describe a sensitivity experiment and are consumed only after their source,
applicability, and all numerical units have been declared.
"""
from __future__ import annotations

import hashlib
import json
from typing import Any, Dict


PROFILE_SCHEMA_VERSION = "perception-profile/v1"
PROFILE_STATUSES = frozenset({"assumed", "configured"})


class PerceptionProfileError(ValueError):
    """Raised when a sensitivity profile is ambiguous or lacks provenance."""


def _numeric_field(section: Dict[str, Any], key: str, unit: str) -> None:
    value = section.get(key)
    if not isinstance(value, dict):
        raise PerceptionProfileError("{} must be an evidence object".format(key))
    if value.get("status") not in PROFILE_STATUSES:
        raise PerceptionProfileError("{} must be assumed or configured".format(key))
    if not value.get("source") or not value.get("rationale"):
        raise PerceptionProfileError("{} needs source and rationale".format(key))
    if value.get("unit") != unit:
        raise PerceptionProfileError("{} must use unit {}".format(key, unit))
    try:
        float(value.get("value"))
    except (TypeError, ValueError):
        raise PerceptionProfileError("{} needs a numeric value".format(key))


def validate_profile(profile: Dict[str, Any]) -> Dict[str, Any]:
    """Validate a profile without filling values or weakening its status."""
    if not isinstance(profile, dict) or profile.get("schema_version") != PROFILE_SCHEMA_VERSION:
        raise PerceptionProfileError("unsupported perception-profile schema")
    if not profile.get("profile_id") or profile.get("status") not in PROFILE_STATUSES:
        raise PerceptionProfileError("profile needs id and assumed/configured status")
    for key in ("source", "rationale", "applicability"):
        if not profile.get(key):
            raise PerceptionProfileError("profile needs {}".format(key))

    visibility = profile.get("visibility") or {}
    _numeric_field(visibility, "horizontal_fov_deg", "deg")
    _numeric_field(visibility, "near_range_m", "m")
    _numeric_field(visibility, "far_range_m", "m")
    if float(visibility["horizontal_fov_deg"]["value"]) <= 0 or float(visibility["horizontal_fov_deg"]["value"]) > 360:
        raise PerceptionProfileError("horizontal_fov_deg must be in (0, 360]")
    if float(visibility["near_range_m"]["value"]) < 0 or float(visibility["far_range_m"]["value"]) <= float(visibility["near_range_m"]["value"]):
        raise PerceptionProfileError("visibility ranges must be non-negative and ordered")

    latency = profile.get("latency") or {}
    for key in ("detection_delay_s", "planning_delay_s", "control_delay_s"):
        _numeric_field(latency, key, "s")
        if float(latency[key]["value"]) < 0:
            raise PerceptionProfileError("{} must be non-negative".format(key))
    return profile


def profile_sha256(profile: Dict[str, Any]) -> str:
    """Canonical profile hash; used to make recalculation inputs explicit."""
    validate_profile(profile)
    payload = json.dumps(profile, sort_keys=True, separators=(",", ":")).encode("utf-8")
    return hashlib.sha256(payload).hexdigest()


def profile_number(profile: Dict[str, Any], section: str, key: str) -> float:
    """Read one already-validated profile value."""
    validate_profile(profile)
    return float(profile[section][key]["value"])
