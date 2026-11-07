import pytest

from capability_schema import CapabilityCardError, validate_card


def _card():
    return {
        "schema_version": "capability-card/v1",
        "trial_id": "7",
        "collision": {"time": {"value": 2, "unit": "s", "status": "recorded", "source": "fixture"}},
        "perception": {"first_detected": {"status": "unavailable", "rationale": "not logged"}},
        "analysis_context": {
            "batch_id": {"status": "unavailable", "rationale": "not provided"},
            "scenario_archetype": {"status": "unavailable", "rationale": "not provided"},
        },
        "inputs": [],
        "verdict": {
            "label": "insufficient_data",
            "prohibited_claims": ["no_legal_fault_determination", "no_certification_claim"],
        },
    }


def test_schema_rejects_numeric_value_without_unit():
    card = _card()
    card["inputs"] = [{"key": "brake", "value": 8.2, "status": "configured", "source": "fixture"}]
    with pytest.raises(CapabilityCardError, match="without a unit"):
        validate_card(card)


def test_schema_rejects_unsupported_status_and_missing_prohibition():
    card = _card()
    card["perception"]["first_detected"] = {"status": "estimated", "rationale": "bad"}
    with pytest.raises(CapabilityCardError, match="unsupported status"):
        validate_card(card)

    card = _card()
    card["verdict"]["prohibited_claims"] = ["no_legal_fault_determination"]
    with pytest.raises(CapabilityCardError, match="must prohibit"):
        validate_card(card)


def test_schema_requires_status_for_analysis_context():
    card = _card()
    card["analysis_context"]["batch_id"] = {"value": 3, "source": "fixture"}
    with pytest.raises(CapabilityCardError, match="unsupported status"):
        validate_card(card)


def test_schema_rejects_legal_or_certification_verdict_language():
    card = _card()
    card["verdict"]["reason_codes"] = ["legal_liability_confirmed"]
    with pytest.raises(CapabilityCardError, match="legal or certification"):
        validate_card(card)


def test_schema_rejects_illustrative_profile_that_changes_primary_verdict():
    card = _card()
    card["illustrative_assumptions"] = {
        "profile_version": "phase-a-illustrative-assumptions/v1",
        "purpose": "bad fixture",
        "primary_verdict_unchanged": False,
        "assumptions": [],
        "sensitivity": {"status": "illustrative_only", "method": "x", "rationale": "x"},
    }
    with pytest.raises(CapabilityCardError, match="must not change"):
        validate_card(card)
