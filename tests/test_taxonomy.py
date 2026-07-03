"""Unit tests for the V1 rule-based taxonomy pipeline:
taxonomy.py + labeller.py + description.py.

All tests are self-contained (synthetic trajectories written to a tmp dir);
they do not require Payload, the real .xodr, or cached esmini CSVs.
"""
from __future__ import annotations

import csv
import sys
from pathlib import Path

import yaml

SRC = Path(__file__).resolve().parents[1] / "app" / "analyzer" / "src"
sys.path.insert(0, str(SRC))

import taxonomy  # noqa: E402
import labeller  # noqa: E402
import description  # noqa: E402


# ---------------------------------------------------------------------------
# Synthetic trajectory helpers
# ---------------------------------------------------------------------------

FIELDS = ["trackId", "time", "x", "y", "velocity", "heading",
          "road_id", "lane_id", "lane_offset", "s"]


def _write_traj(path: Path, rows):
    with path.open("w", newline="") as fh:
        w = csv.DictWriter(fh, fieldnames=FIELDS)
        w.writeheader()
        for r in rows:
            w.writerow(r)


def _row(tid, t, x, y, v, h=0.0, road=51, lane=1):
    return {"trackId": tid, "time": t, "x": x, "y": y, "velocity": v,
            "heading": h, "road_id": road, "lane_id": lane,
            "lane_offset": 0.0, "s": 0.0}


def _meta(path: Path, agents):
    data = {"dataset": "t", "location": "hct_6", "duration": 5.0,
            "agents": agents}
    path.write_text(yaml.safe_dump(data))


# ---------------------------------------------------------------------------
# taxonomy.merge_consecutive
# ---------------------------------------------------------------------------

def test_merge_consecutive_collapses_same_action():
    ev = taxonomy.ActionEvent
    events = [
        ev(0, "ego", "MAINTAIN_SPEED", 0.0, 1.0, 51, 1),
        ev(0, "ego", "MAINTAIN_SPEED", 1.0, 2.0, 51, 1),
        ev(0, "ego", "ACCELERATE", 2.0, 4.0, 51, 1),
    ]
    merged = taxonomy.merge_consecutive(events, min_duration=0.5)
    assert len(merged) == 2
    assert merged[0].end_time == 2.0
    assert merged[1].action == "ACCELERATE"


# ---------------------------------------------------------------------------
# labeller: longitudinal detection
# ---------------------------------------------------------------------------

def test_emergency_brake_detected(tmp_path):
    # speed drops 10 -> 0 over 1s => accel = -10 m/s² (< -4)
    rows = [_row(0, i * 0.1, 0, -i, max(0.0, 10 - i)) for i in range(11)]
    traj = tmp_path / "trajectory.csv"
    meta = tmp_path / "meta.yaml"
    _write_traj(traj, rows)
    _meta(meta, [{"track_id": 0, "name": "Ego", "class": "car"}])

    data = labeller.label_trajectory(traj, meta, None)
    actions = {a["action"] for a in data["agents"][0]["actions"]}
    assert "EMERGENCY_BRAKE" in actions


def test_accelerate_and_decelerate(tmp_path):
    # gentle +2 m/s² then -2 m/s² (kept above DECEL but below EMERGENCY_DECEL)
    rows = ([_row(0, i * 0.1, 0, i, 0.2 * i) for i in range(11)]            # speed up
            + [_row(0, 1.1 + i * 0.1, 0, 10 + i, 2.0 - 0.2 * i) for i in range(11)])  # slow
    traj = tmp_path / "trajectory.csv"
    meta = tmp_path / "meta.yaml"
    _write_traj(traj, rows)
    _meta(meta, [{"track_id": 0, "name": "Ego", "class": "car"}])

    data = labeller.label_trajectory(traj, meta, None)
    actions = {a["action"] for a in data["agents"][0]["actions"]}
    assert "ACCELERATE" in actions
    assert "DECELERATE" in actions


def test_lane_change_left_and_right(tmp_path):
    # The xosc-faithful lateral rule only keeps a maneuver whose grown duration is
    # within [LANE_CHANGE_MIN_S, LANE_CHANGE_MAX_S] = [1.0, 3.0] s, so the synthetic
    # change must span ≥ 1.0 s of stable-before / stable-after lanes.
    rows = (
        [_row(0, i * 0.1, 0, i, 5, road=51, lane=1) for i in range(8)]
        + [_row(0, 0.8 + i * 0.1, 0, 8 + i, 5, road=51, lane=2) for i in range(8)]
    )
    traj = tmp_path / "trajectory.csv"
    meta = tmp_path / "meta.yaml"
    _write_traj(traj, rows)
    _meta(meta, [{"track_id": 0, "name": "Ego", "class": "car"}])

    data = labeller.label_trajectory(traj, meta, None)
    actions = {a["action"] for a in data["agents"][0]["actions"]}
    assert "LANE_CHANGE_LEFT" in actions  # lane 1 -> 2 increases ⇒ left (OpenDRIVE)


def test_enter_exit_junction(tmp_path):
    # road 51 (arterial) -> 206 (junction) -> 89 (arterial)
    rows = (
        [_row(0, i * 0.1, 0, i, 5, road=51, lane=1) for i in range(5)]
        + [_row(0, 0.5 + i * 0.1, 0, 5 + i, 5, road=206, lane=1) for i in range(5)]
        + [_row(0, 1.0 + i * 0.1, 0, 10 + i, 5, road=89, lane=1) for i in range(5)]
    )
    traj = tmp_path / "trajectory.csv"
    meta = tmp_path / "meta.yaml"
    map_yaml = tmp_path / "map.yaml"
    _write_traj(traj, rows)
    _meta(meta, [{"track_id": 0, "name": "Ego", "class": "car"}])
    map_yaml.write_text(yaml.safe_dump({"Roads": [51, 89], "JunctionRoads": [206]}))

    data = labeller.label_trajectory(traj, meta, map_yaml)
    actions = [a["action"] for a in data["agents"][0]["actions"]]
    assert "ENTER_JUNCTION" in actions
    assert "EXIT_JUNCTION" in actions
    assert data["junction_aware"] is True


def test_world_xy_aliases_accepted(tmp_path):
    # xosc_gen-style column names world_x/world_y must be accepted. Use an
    # accelerating profile so a maneuver survives the §4.2 conciseness filter
    # (a constant-velocity track correctly yields no action under the new rules).
    traj = tmp_path / "trajectory.csv"
    meta = tmp_path / "meta.yaml"
    with traj.open("w", newline="") as fh:
        fields = ["trackId", "time", "world_x", "world_y", "velocity",
                  "heading", "road_id", "lane_id", "lane_offset", "s"]
        w = csv.DictWriter(fh, fieldnames=fields)
        w.writeheader()
        for i in range(8):
            w.writerow({"trackId": 0, "time": i * 0.1, "world_x": i,
                        "world_y": 0, "velocity": 1.0 + i, "heading": 0,
                        "road_id": 51, "lane_id": 1, "lane_offset": 0, "s": 0})
    _meta(meta, [{"track_id": 0, "name": "Ego", "class": "car"}])

    data = labeller.label_trajectory(traj, meta, None)  # should not raise
    assert data["agents"][0]["actions"]


def test_npc_parked_relation(tmp_path):
    rows = (
        [_row(0, i * 0.1, 0, i, 5) for i in range(10)]              # ego moving
        + [_row(1, i * 0.1, 100, 100, 0.0, road=300, lane=-1) for i in range(10)]  # far + stopped
    )
    traj = tmp_path / "trajectory.csv"
    meta = tmp_path / "meta.yaml"
    _write_traj(traj, rows)
    _meta(meta, [
        {"track_id": 0, "name": "Ego", "class": "car"},
        {"track_id": 1, "name": "Oncoming", "class": "car"},
    ])

    data = labeller.label_trajectory(traj, meta, None)
    npc = [a for a in data["agents"] if a["track_id"] == 1][0]
    assert npc["relation_to_ego"] == "PARKED"


# ---------------------------------------------------------------------------
# description
# ---------------------------------------------------------------------------

def test_description_output_format(tmp_path):
    rows = [_row(0, i * 0.1, 0, i, 5) for i in range(10)]
    traj = tmp_path / "trajectory.csv"
    meta = tmp_path / "meta.yaml"
    _write_traj(traj, rows)
    _meta(meta, [{"track_id": 0, "name": "Ego", "class": "car"}])

    data = labeller.label_trajectory(traj, meta, None)
    text = description.build_description(data)
    assert "Ego (track 0" in text
    assert "Scenario on map 'hct_6'" in text
    assert text.endswith("\n")
