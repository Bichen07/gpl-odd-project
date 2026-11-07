from pathlib import Path

from visibility_analysis import build_visibility_evidence, evaluate_profile_response_window, save_visibility_evidence


def _profile():
    source = "fixture-profile"
    rationale = "Synthetic sensitivity fixture, not a historical measurement."
    def number(value, unit):
        return {"value": value, "unit": unit, "status": "assumed", "source": source, "rationale": rationale}
    return {
        "schema_version": "perception-profile/v1",
        "profile_id": "fixture-v1",
        "status": "assumed",
        "source": source,
        "rationale": rationale,
        "applicability": "Unit-test geometry only.",
        "visibility": {
            "horizontal_fov_deg": number(120, "deg"),
            "near_range_m": number(0, "m"),
            "far_range_m": number(50, "m"),
        },
        "latency": {
            "detection_delay_s": number(0.2, "s"),
            "planning_delay_s": number(0.3, "s"),
            "control_delay_s": number(0.1, "s"),
        },
    }


def _trajectory(path: Path) -> None:
    path.write_text(
        "trackId,time,x,y,heading,velocity\n"
        "0,0.0,0,0,0,5\n"
        "1,0.0,10,0,0,0\n"
        "0,1.0,5,0,0,5\n"
        "1,1.0,12,0,0,2\n",
        encoding="utf-8",
    )


def test_complete_geometry_yields_derived_visibility_but_not_detection(tmp_path: Path):
    trajectory = tmp_path / "trajectory.csv"
    _trajectory(trajectory)
    evidence = build_visibility_evidence(
        trial_id="fixture",
        trajectory_path=trajectory,
        ego_actor="0",
        target_actor="1",
        profile=_profile(),
        geometry={"coverage": "complete", "source": "fixture-map", "rationale": "Complete synthetic map and occluder fixture.", "static_occluders": []},
    )
    assert evidence["fov_range_opportunity"]["status"] == "derived"
    assert evidence["visibility_opportunity"]["status"] == "derived"
    assert evidence["visibility_opportunity"]["value"] == 0.0
    assert evidence["perception"]["first_detected"]["status"] == "unavailable"
    output = tmp_path / "visibility.yaml"
    save_visibility_evidence(evidence, output)
    assert output.is_file()


def test_partial_geometry_never_promotes_fov_candidate_to_visibility(tmp_path: Path):
    trajectory = tmp_path / "trajectory.csv"
    _trajectory(trajectory)
    evidence = build_visibility_evidence(
        trial_id="fixture",
        trajectory_path=trajectory,
        ego_actor="0",
        target_actor="1",
        profile=_profile(),
        geometry={"coverage": "partial", "source": "fixture-map", "rationale": "Static occluders are not fully archived."},
    )
    assert evidence["fov_range_opportunity"]["status"] == "derived"
    assert evidence["visibility_opportunity"]["status"] == "unavailable"
    assert evidence["perception"]["first_detected"]["status"] == "unavailable"


def test_profile_window_is_conditional_and_does_not_change_primary_verdict(tmp_path: Path):
    trajectory = tmp_path / "trajectory.csv"
    _trajectory(trajectory)
    evidence = build_visibility_evidence(
        trial_id="fixture",
        trajectory_path=trajectory,
        ego_actor="0",
        target_actor="1",
        profile=_profile(),
        geometry={"coverage": "complete", "source": "fixture-map", "rationale": "Complete synthetic map and occluder fixture."},
    )
    result = evaluate_profile_response_window(
        visibility=evidence,
        collision_time={"value": 5.0, "unit": "s", "status": "derived"},
        profile=_profile(),
    )
    assert result["status"] == "assumed"
    assert result["first_detection_assumed_s"] == 0.2
    assert result["response_start_assumed_s"] == 0.6
    assert result["response_window_before_collision_s"] == 4.4
    assert result["primary_verdict_unchanged"] is True
