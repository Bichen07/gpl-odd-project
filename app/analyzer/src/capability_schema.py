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
PROHIBITED_VERDICT_TERMS = frozenset({"legal", "liable", "liability", "certif"})


class CapabilityCardError(ValueError):
    """Raised when a capability card has ambiguous provenance or semantics."""


def _require_status(value: Dict[str, Any], label: str, *, unit_for_numeric: bool = True) -> None:
    status = value.get("status")
    if status not in STATUSES:
        raise CapabilityCardError("{} has unsupported status {!r}".format(label, status))
    if status == "unavailable":
        if not value.get("rationale"):
            raise CapabilityCardError("{} is unavailable without a rationale".format(label))
        return
    if not value.get("source"):
        raise CapabilityCardError("{} has no source".format(label))
    if unit_for_numeric and value.get("value") is not None and not value.get("unit"):
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
    visibility = card.get("visibility")
    if visibility is not None:
        _require_status(
            (visibility or {}).get("opportunity") or {},
            "visibility.opportunity",
        )
    for item in card.get("profile_sensitivity") or []:
        if item.get("status") not in {"assumed", "unavailable"}:
            raise CapabilityCardError("profile sensitivity has unsupported status")
        if not item.get("profile_id") or item.get("primary_verdict_unchanged") is not True:
            raise CapabilityCardError("profile sensitivity must preserve the primary verdict")
        if not item.get("rationale"):
            raise CapabilityCardError("profile sensitivity needs a rationale")
    context = card.get("analysis_context") or {}
    for key in ("batch_id", "scenario_archetype"):
        _require_status(
            context.get(key) or {}, "analysis_context.{}".format(key), unit_for_numeric=False
        )
    for item in card.get("inputs") or []:
        if not item.get("key"):
            raise CapabilityCardError("capability input has no key")
        _require_status(item, "inputs.{}".format(item["key"]))
    verdict = (card.get("verdict") or {}).get("label")
    if verdict not in VERDICTS:
        raise CapabilityCardError("unsupported verdict {!r}".format(verdict))
    verdict_terms = [str(verdict)] + [
        str(reason) for reason in ((card.get("verdict") or {}).get("reason_codes") or [])
    ]
    if any(term in item.lower() for item in verdict_terms for term in PROHIBITED_VERDICT_TERMS):
        raise CapabilityCardError("capability verdict must not contain legal or certification claims")
    prohibited = set((card.get("verdict") or {}).get("prohibited_claims") or [])
    if not PROHIBITED_CLAIMS.issubset(prohibited):
        raise CapabilityCardError("capability card must prohibit legal and certification claims")
    illustrative = card.get("illustrative_assumptions")
    if illustrative is not None:
        _validate_illustrative_assumptions(illustrative)
    return card


def _validate_illustrative_assumptions(profile: Dict[str, Any]) -> None:
    if not isinstance(profile, dict) or profile.get("profile_version") != "phase-a-illustrative-assumptions/v1":
        raise CapabilityCardError("unsupported illustrative-assumption profile")
    if profile.get("primary_verdict_unchanged") is not True:
        raise CapabilityCardError("illustrative assumptions must not change the primary verdict")
    if not profile.get("purpose"):
        raise CapabilityCardError("illustrative assumptions need a purpose")
    assumptions = profile.get("assumptions") or []
    if not assumptions:
        raise CapabilityCardError("illustrative assumptions must list their inputs")
    for item in assumptions:
        if item.get("status") != "assumed":
            raise CapabilityCardError("illustrative assumptions must use assumed status")
        if not item.get("key"):
            raise CapabilityCardError("illustrative assumption has no key")
        _require_status(item, "illustrative_assumptions.{}".format(item["key"]))
    sensitivity = profile.get("sensitivity") or {}
    if sensitivity.get("status") != "illustrative_only":
        raise CapabilityCardError("illustrative sensitivity must be marked illustrative_only")
    if not sensitivity.get("method") or not sensitivity.get("rationale"):
        raise CapabilityCardError("illustrative sensitivity needs method and rationale")


def unavailable(key: str, rationale: str, *, unit: str | None = None) -> Dict[str, Any]:
    """Construct one explicit unavailable input."""
    out: Dict[str, Any] = {"key": key, "status": "unavailable", "rationale": rationale}
    if unit:
        out["unit"] = unit
    return out
