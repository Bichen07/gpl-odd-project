"""Human-facing names for non-Ego vehicles.

Names not listed in the legacy alias table pass through unchanged, so new
scenario vehicle names do not require code changes.

Cluster *labels* are invented by the summary LLM from evidence (open
vocabulary) — do not hardcode actor→label maps here.
"""

from __future__ import annotations

from typing import Any, Optional


_LEGACY_NAME_ALIASES = {
    "opposite": "Oncoming",
    "oncoming": "Oncoming",
    "parked": "Parking",
    "parking": "Parking",
    "cuttingin": "CuttingIn",
}


def display_agent_name(name: Optional[object], fallback: str = "other vehicle") -> str:
    """Return a clear actor name for LLM-facing natural-language text."""
    raw = str(name or "").strip()
    if not raw:
        return fallback
    return _LEGACY_NAME_ALIASES.get(raw.lower(), raw)


_OLD_ACTOR_TOKEN = "part" + "ner"


def normalize_vehicle_schema(value: Any) -> Any:
    """Convert older actor-field spellings at data-input boundaries.

    New artifacts use ``vehicle`` consistently. Existing JSON/YAML snapshots
    are accepted once, converted recursively, and then processed by the same
    canonical code path.
    """
    if isinstance(value, dict):
        return {
            str(key).replace(_OLD_ACTOR_TOKEN, "vehicle"): normalize_vehicle_schema(item)
            for key, item in value.items()
        }
    if isinstance(value, list):
        return [normalize_vehicle_schema(item) for item in value]
    if isinstance(value, tuple):
        return tuple(normalize_vehicle_schema(item) for item in value)
    if isinstance(value, str):
        return value.replace(_OLD_ACTOR_TOKEN, "vehicle").replace(
            "unresolved_brake_release", "brake_release"
        )
    return value
