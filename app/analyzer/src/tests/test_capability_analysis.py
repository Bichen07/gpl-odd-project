from pathlib import Path

from capability_analysis import build_capability_card, evaluate_avoidability, save_capability_card


def _fact(value, unit="unit"):
    return {"value": value, "unit": unit, "status": "configured", "source": "synthetic-fixture"}


def _inputs(speed, gap, delay, limits, observed=0.0, lane=True):
    return {
        "perception_time_s": _fact(1.0, "s"),
        "response_delay_s": _fact(delay, "s"),
        "ego_speed_mps": _fact(speed, "m/s"),
        "available_gap_m": _fact(gap, "m"),
        "brake_limits_mps2": _fact(limits, "m/s^2"),
        "observed_brake_mps2": _fact(observed, "m/s^2"),
        "lane_geometry": _fact(lane, "boolean"),
    }


def test_late_cut_in_is_unavoidable_under_stated_inputs():
    result = evaluate_avoidability(_inputs(speed=20, gap=10, delay=1, limits=[8.2, 10]))
    assert result["label"] == "unavoidable_under_stated_assumptions"


def test_early_visible_no_brake_is_engineering_review_not_legal_fault():
    result = evaluate_avoidability(_inputs(speed=10, gap=100, delay=0.1, limits=[8.2, 10], observed=0))
    assert result["label"] == "may_be_system_issue"


def test_brake_sensitivity_disagreement_is_explicit():
    result = evaluate_avoidability(_inputs(speed=15, gap=16, delay=0.2, limits=[8.2, 10]))
    assert result["label"] == "depends_on_capability_limit"


def test_missing_lane_geometry_is_insufficient_data():
    inputs = _inputs(speed=10, gap=100, delay=0.1, limits=[8.2, 10])
    inputs["lane_geometry"] = {"status": "unavailable"}
    assert evaluate_avoidability(inputs)["label"] == "insufficient_data"


def test_real_card_keeps_unlogged_perception_and_capability_unavailable(tmp_path: Path):
    trajectory = tmp_path / "trajectory.csv"
    trajectory.write_text("name,time,speed\nEgo,2.0,10.0\n", encoding="utf-8")
    card = build_capability_card(
        trial_id="42",
        trajectory_path=trajectory,
        trial_events=[{
            "name": "collisionWithOpposite", "esminiSeconds": 2.0,
            "observation": 99, "timeStatus": "recorded",
        }],
    )
    assert card["verdict"]["label"] == "insufficient_data"
    assert card["perception"]["first_detected"]["status"] == "unavailable"
    assert card["analysis_context"]["batch_id"]["status"] == "unavailable"
    assert card["analysis_context"]["scenario_archetype"]["status"] == "unavailable"
    output = tmp_path / "capability.yaml"
    save_capability_card(card, output)
    assert output.is_file()


def test_archived_trackid_velocity_csv_gets_a_derived_speed_and_illustrative_profile(tmp_path: Path):
    trajectory = tmp_path / "trajectory.csv"
    trajectory.write_text(
        "trackId,time,velocity\n0,14.6,2.456\n1,14.6,3.418\n0,14.64,2.419\n",
        encoding="utf-8",
    )
    action = {
        "agents": [{"track_id": 0, "role": "ego"}],
        "interactions": [{"type": "COLLISION", "key_time": 14.64, "with_name": "CuttingIn"}],
    }
    card = build_capability_card(
        trial_id="12152",
        trajectory_path=trajectory,
        action_data=action,
        include_illustrative_assumptions=True,
    )
    speed = next(item for item in card["inputs"] if item["key"] == "ego_speed_at_collision")
    assert speed["status"] == "derived"
    assert speed["value"] == 2.419
    assert card["collision"]["time"]["status"] == "derived"
    assert card["verdict"]["label"] == "insufficient_data"
    assert card["illustrative_assumptions"]["primary_verdict_unchanged"] is True
    assert len(card["illustrative_assumptions"]["sensitivity"]["rows"]) == 4


def test_card_keeps_visibility_and_profile_sensitivity_distinct_from_detection(tmp_path: Path):
    trajectory = tmp_path / "trajectory.csv"
    trajectory.write_text("trackId,time,velocity\n0,1.0,3.0\n", encoding="utf-8")
    visibility = {
        "visibility_opportunity": {
            "key": "visibility_opportunity", "value": 0.4, "unit": "s",
            "status": "derived", "source": "fixture", "method": "ray-cast",
        }
    }
    sensitivity = [{
        "profile_id": "fixture-profile", "status": "assumed", "rationale": "fixture sensitivity",
        "primary_verdict_unchanged": True,
    }]
    card = build_capability_card(
        trial_id="visibility-fixture", trajectory_path=trajectory,
        visibility_evidence=visibility, profile_sensitivity=sensitivity,
    )
    assert card["visibility"]["opportunity"]["status"] == "derived"
    assert card["perception"]["first_detected"]["status"] == "unavailable"
    assert card["profile_sensitivity"][0]["status"] == "assumed"
    assert card["verdict"]["label"] == "insufficient_data"
