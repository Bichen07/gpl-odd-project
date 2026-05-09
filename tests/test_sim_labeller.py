"""Unit tests for app/analyzer/src/sim_labeller.py.

These tests intentionally do NOT touch Payload or the real .xodr file; they
construct a minimal in-memory parser stub so the field mapping logic can be
verified in isolation.
"""

from __future__ import annotations

import csv
import sys
from dataclasses import dataclass
from pathlib import Path
from typing import List, Tuple

import yaml

# Allow `import sim_labeller` regardless of how pytest is launched.
SRC = Path(__file__).resolve().parents[1] / "app" / "analyzer" / "src"
sys.path.insert(0, str(SRC))

import sim_labeller  # noqa: E402


# ---------------------------------------------------------------------------
# In-memory parser stub matching XodrParser.lines / .get_bounds() shape
# ---------------------------------------------------------------------------

@dataclass
class _StubLine:
    road_id: str
    lane_id: int
    lane_type: str
    points: List[Tuple[float, float]]


class _StubParser:
    def __init__(self, lines):
        self.lines = lines


def _stub_parser_two_lanes():
    return _StubParser([
        _StubLine("ref-only", 0, "ref", [(0.0, 0.0), (50.0, 0.0)]),
        _StubLine("100", -1, "driving", [(0.0, -3.5), (50.0, -3.5)]),
        _StubLine("100",  1, "driving", [(0.0,  3.5), (50.0,  3.5)]),
        _StubLine("200", -1, "driving", [(100.0, -3.5), (150.0, -3.5)]),
    ])


# ---------------------------------------------------------------------------
# assign_agent_road_id
# ---------------------------------------------------------------------------

def test_assign_returns_nearest_lane_skipping_ref():
    parser = _stub_parser_two_lanes()
    rid, lid = sim_labeller.assign_agent_road_id(10.0, -3.4, parser)
    assert rid == 100
    assert lid == -1


def test_assign_picks_left_lane():
    parser = _stub_parser_two_lanes()
    rid, lid = sim_labeller.assign_agent_road_id(10.0, 3.6, parser)
    assert rid == 100
    assert lid == 1


def test_assign_picks_far_road():
    parser = _stub_parser_two_lanes()
    rid, lid = sim_labeller.assign_agent_road_id(120.0, -3.5, parser)
    assert rid == 200
    assert lid == -1


def test_assign_returns_zero_when_no_lanes():
    parser = _StubParser([_StubLine("ref-only", 0, "ref",
                                    [(0.0, 0.0), (10.0, 0.0)])])
    rid, lid = sim_labeller.assign_agent_road_id(5.0, 0.0, parser)
    assert rid == 0
    assert lid == 0


def test_assign_skips_ref_lines_only():
    """Even if (x,y) is exactly on a ref line, it must pick a real lane."""
    parser = _stub_parser_two_lanes()
    rid, lid = sim_labeller.assign_agent_road_id(25.0, 0.0, parser)
    assert rid == 100
    assert lid in (-1, 1)


# ---------------------------------------------------------------------------
# build_trajectory_csv
# ---------------------------------------------------------------------------

def _sample_observations():
    return [
        {
            "time": 0.0,
            "egoX": 0.0, "egoY": 0.0, "egoYaw": 0.0, "egoSpeed": 5.0,
            "egoRoadId": 100, "egoLaneId": -1, "egoLaneOffset": 0.1, "egoS": 0.0,
            "agents": [
                {"name": "Oncoming", "x": 50.0, "y": 3.5, "yaw": 3.14,
                 "speed": 8.0, "roadId": 0, "laneId": 0,
                 "s": 0, "laneOffset": 0},
                {"name": "Parking", "x": 10.0, "y": -3.4, "yaw": 0.0,
                 "speed": 0.0, "roadId": 0, "laneId": 0,
                 "s": 0, "laneOffset": 0},
            ],
        },
        {
            "time": 0.1,
            "egoX": 0.5, "egoY": 0.0, "egoYaw": 0.0, "egoSpeed": 5.0,
            "egoRoadId": 100, "egoLaneId": -1, "egoLaneOffset": 0.1, "egoS": 0.5,
            "agents": [
                {"name": "Oncoming", "x": 49.2, "y": 3.5, "yaw": 3.14,
                 "speed": 8.0, "roadId": 0, "laneId": 0,
                 "s": 0, "laneOffset": 0},
                {"name": "Parking", "x": 10.0, "y": -3.4, "yaw": 0.0,
                 "speed": 0.0, "roadId": 0, "laneId": 0,
                 "s": 0, "laneOffset": 0},
            ],
        },
    ]


def test_trajectory_csv_has_one_row_per_track_per_frame(tmp_path):
    obs = _sample_observations()
    parser = _stub_parser_two_lanes()
    out = tmp_path / "trajectory.csv"
    registry = sim_labeller.build_trajectory_csv(obs, parser, out)

    with out.open() as fh:
        rows = list(csv.DictReader(fh))

    assert len(rows) == 6
    assert {r["trackId"] for r in rows} == {"0", "1", "2"}
    assert {a.name for a in registry} == {"Ego", "Oncoming", "Parking"}


def test_trajectory_csv_ego_uses_payload_road_id(tmp_path):
    obs = _sample_observations()
    parser = _stub_parser_two_lanes()
    out = tmp_path / "trajectory.csv"
    sim_labeller.build_trajectory_csv(obs, parser, out)

    with out.open() as fh:
        rows = list(csv.DictReader(fh))

    egos = [r for r in rows if r["trackId"] == "0"]
    assert all(r["road_id"] == "100" for r in egos)
    assert all(r["lane_id"] == "-1" for r in egos)


def test_trajectory_csv_agents_use_spatial_fallback(tmp_path):
    obs = _sample_observations()
    parser = _stub_parser_two_lanes()
    out = tmp_path / "trajectory.csv"
    sim_labeller.build_trajectory_csv(obs, parser, out)

    with out.open() as fh:
        rows = list(csv.DictReader(fh))

    oncoming = next(r for r in rows if r["trackId"] == "1")
    parking = next(r for r in rows if r["trackId"] == "2")
    assert oncoming["road_id"] == "100"
    assert oncoming["lane_id"] == "1"
    assert parking["road_id"] == "100"
    assert parking["lane_id"] == "-1"


def test_trajectory_csv_keeps_payload_value_when_nonzero(tmp_path):
    """If the simulator was patched in the future, payload values must win."""
    obs = _sample_observations()
    obs[0]["agents"][0]["roadId"] = 99
    obs[0]["agents"][0]["laneId"] = -2
    parser = _stub_parser_two_lanes()
    out = tmp_path / "trajectory.csv"
    sim_labeller.build_trajectory_csv(obs, parser, out)

    with out.open() as fh:
        rows = list(csv.DictReader(fh))

    first_oncoming = next(r for r in rows
                          if r["trackId"] == "1" and r["time"] == "0.0")
    assert first_oncoming["road_id"] == "99"
    assert first_oncoming["lane_id"] == "-2"


# ---------------------------------------------------------------------------
# build_meta_yaml
# ---------------------------------------------------------------------------

def test_meta_yaml_records_duration_and_agents(tmp_path):
    obs = _sample_observations()
    parser = _stub_parser_two_lanes()
    csv_out = tmp_path / "trajectory.csv"
    yaml_out = tmp_path / "meta.yaml"

    registry = sim_labeller.build_trajectory_csv(obs, parser, csv_out)
    sim_labeller.build_meta_yaml(registry, obs, yaml_out,
                                 dataset="dataset1", location="hct_6")

    with yaml_out.open() as fh:
        data = yaml.safe_load(fh)

    assert data["dataset"] == "dataset1"
    assert data["location"] == "hct_6"
    assert data["duration"] == 0.1
    names = {a["name"] for a in data["agents"]}
    assert names == {"Ego", "Oncoming", "Parking"}


def test_meta_yaml_handles_empty_observations(tmp_path):
    parser = _stub_parser_two_lanes()
    csv_out = tmp_path / "trajectory.csv"
    yaml_out = tmp_path / "meta.yaml"

    registry = sim_labeller.build_trajectory_csv([], parser, csv_out)
    sim_labeller.build_meta_yaml(registry, [], yaml_out,
                                 dataset="dataset1", location="hct_6")

    with yaml_out.open() as fh:
        data = yaml.safe_load(fh)
    assert data["duration"] == 0.0
    assert [a["name"] for a in data["agents"]] == ["Ego"]
