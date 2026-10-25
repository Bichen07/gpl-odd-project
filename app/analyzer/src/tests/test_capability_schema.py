import pytest

from capability_schema import CapabilityCardError, validate_card


def _card():
    return {
        "schema_version": "capability-card/v1",
        "trial_id": "7",
        "collision": {"time": {"value": 2, "unit": "s", "status": "recorded", "source": "fixture"}},
        "perception": {"first_detected": {"status": "unavailable", "rationale": "not logged"}},
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
