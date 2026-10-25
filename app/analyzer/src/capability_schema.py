"""Validation contract for Phase A capability cards.

This schema deliberately permits unavailable data, but rejects a card that
silently promotes an unsupported engineering value into a trial fact.
"""
from __future__ import annotations

from typing import Any, Dict, Iterable


STATUSES = frozenset({"recorded", "derived", "configured", "assumed", "unavailable"})
VERDICTS = frozenset({
    "unavoidable_under_stated_assumptions",
    "may_be_system_issue",
    "depends_on_capability_limit",
    "insufficient_data",
})
PROHIBITED_CLAIMS = frozenset({"no_legal_fault_determination", "no_certification_claim"})


class CapabilityCardError(ValueError):
    """Raised when a capability card has ambiguous provenance or semantics."""


def _require_status(value: Dict[str, Any], label: str) -> None:
    status = value.get("status")
    if status not in STATUSES:
        raise CapabilityCardError("{} has unsupported status {!r}".format(label, status))
    if status == "unavailable":
        if not value.get("rationale"):
            raise CapabilityCardError("{} is unavailable without a rationale".format(label))
        return
    if not value.get("source"):
        raise CapabilityCardError("{} has no source".format(label))
    if value.get("value") is not None and not value.get("unit"):
        raise CapabilityCardError("{} has a numeric value without a unit".format(label))


def validate_card(card: Dict[str, Any]) -> Dict[str, Any]:
    """Validate and return *card*; never coerce missing provenance."""
    if not isinstance(card, dict) or card.get("schema_version") != "capability-card/v1":
        raise CapabilityCardError("unsupported capability-card schema")
    if not str(card.get("trial_id") or ""):
        raise CapabilityCardError("capability card needs a trial_id")
    collision = card.get("collision") or {}
    _require_status(collision.get("time") or {}, "collision.time")
    perception = card.get("perception") or {}
    _require_status(perception.get("first_detected") or {}, "perception.first_detected")
    for item in card.get("inputs") or []:
        if not item.get("key"):
            raise CapabilityCardError("capability input has no key")
        _require_status(item, "inputs.{}".format(item["key"]))
    verdict = (card.get("verdict") or {}).get("label")
    if verdict not in VERDICTS:
        raise CapabilityCardError("unsupported verdict {!r}".format(verdict))
    prohibited = set((card.get("verdict") or {}).get("prohibited_claims") or [])
    if not PROHIBITED_CLAIMS.issubset(prohibited):
        raise CapabilityCardError("capability card must prohibit legal and certification claims")
    return card


def unavailable(key: str, rationale: str, *, unit: str | None = None) -> Dict[str, Any]:
    """Construct one explicit unavailable input."""
    out: Dict[str, Any] = {"key": key, "status": "unavailable", "rationale": rationale}
    if unit:
        out["unit"] = unit
    return out
