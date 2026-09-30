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


_DECIDED_RESOLUTIONS = {"pass_first", "yield"}


def collapse_agent_interactions(rows: Any, partner: Optional[object] = None) -> list:
    """One row per display name. ``Opposite`` and ``Oncoming`` are one vehicle.

    A decided resolution (``pass_first`` or ``yield``) replaces ``unresolved``
    for that name. The named conflict vehicle, under its display name, is first.
    """
    grouped: dict = {}
    order: list = []
    raw_is_display: dict = {}
    for row in rows or []:
        if not isinstance(row, dict):
            continue
        raw = str(row.get("agent") or "").strip()
        if not raw:
            continue
        shown = display_agent_name(raw)
        res = str(
            row.get("resolution") or row.get("interaction_resolution") or "unresolved"
        ).strip() or "unresolved"
        if shown not in grouped:
            grouped[shown] = res
            order.append(shown)
            raw_is_display[shown] = raw == shown
            continue
        prev = grouped[shown]
        prev_decided = prev in _DECIDED_RESOLUTIONS
        new_decided = res in _DECIDED_RESOLUTIONS
        take_new = (new_decided and not prev_decided) or (
            new_decided == prev_decided and raw == shown and not raw_is_display.get(shown)
        )
        if take_new:
            grouped[shown] = res
            raw_is_display[shown] = raw == shown
    shown_partner = display_agent_name(partner) if str(partner or "").strip() else ""
    names = list(order)
    if shown_partner and shown_partner in grouped:
        names = [shown_partner] + [name for name in names if name != shown_partner]
    return [{"agent": name, "resolution": grouped[name]} for name in names]


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
