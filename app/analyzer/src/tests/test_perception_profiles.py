import pytest

from perception_profiles import PerceptionProfileError, profile_sha256, validate_profile


def _profile():
    source = "fixture"
    rationale = "Explicit synthetic sensitivity profile."
    def field(value, unit):
        return {"value": value, "unit": unit, "status": "assumed", "source": source, "rationale": rationale}
    return {
        "schema_version": "perception-profile/v1",
        "profile_id": "fixture-v1",
        "status": "assumed",
        "source": source,
        "rationale": rationale,
        "applicability": "Test only.",
        "visibility": {
            "horizontal_fov_deg": field(120, "deg"),
            "near_range_m": field(0, "m"),
            "far_range_m": field(60, "m"),
        },
        "latency": {
            "detection_delay_s": field(0.2, "s"),
            "planning_delay_s": field(0.3, "s"),
            "control_delay_s": field(0.1, "s"),
        },
    }


def test_profile_is_valid_and_hash_stable():
    profile = _profile()
    assert validate_profile(profile) is profile
    assert profile_sha256(profile) == profile_sha256(profile)


def test_profile_rejects_unsourced_or_wrong_unit_latency():
    profile = _profile()
    profile["latency"]["control_delay_s"].pop("source")
    with pytest.raises(PerceptionProfileError, match="source and rationale"):
        validate_profile(profile)
    profile = _profile()
    profile["visibility"]["far_range_m"]["unit"] = "s"
    with pytest.raises(PerceptionProfileError, match="unit m"):
        validate_profile(profile)
