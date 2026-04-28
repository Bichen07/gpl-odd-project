#!/usr/bin/env python3
"""
Unit test for the roadId preservation fix in controller.py.

This test verifies that the replayerTrajectories construction no longer
defaults valid roadIds to 0 when they are integers or clean floats.
It also checks the safe fallback behavior for NaN/missing values.

How to run:
    python3 test_roadid_preservation.py
"""

import csv
import math
import os
import unittest


# ---------------------------------------------------------------------------
# Replicated fix logic (mirrors the fix in controller.py:1583-1611)
# so we can test it here without importing the full controller (which has
# many server-side dependencies like litestar, torch, etc.)
# ---------------------------------------------------------------------------

def _build_replayer_trajectories(raw_trajectories):
    """
    Mirrors the fixed version of the replayerTrajectories construction block
    from app/analyzer/src/controller.py.
    """
    replayer = {}
    for trial_id, trajectory in raw_trajectories.items():
        agents = {}
        for agent_name, agent_list in trajectory["trajectory"].items():
            agents[agent_name] = []
            for item in agent_list:
                roadId = 0
                s = 0.0
                if "roadId" in item:
                    if item["roadId"] is None:
                        roadId = agents[agent_name][-1]["roadId"] if agents[agent_name] else 0
                    else:
                        try:
                            if isinstance(item["roadId"], (int, float)) and not math.isnan(item["roadId"]):
                                roadId = int(item["roadId"])
                            else:
                                roadId = agents[agent_name][-1]["roadId"] if agents[agent_name] else 0
                        except (ValueError, TypeError, IndexError, KeyError):
                            roadId = agents[agent_name][-1]["roadId"] if agents[agent_name] else 0

                if "s" in item:
                    if item["s"] is None:
                        s = agents[agent_name][-1]["s"] if agents[agent_name] else 0.0
                    else:
                        try:
                            s = float(item["s"])
                        except (ValueError, TypeError):
                            s = agents[agent_name][-1]["s"] if agents[agent_name] else 0.0

                agents[agent_name].append({
                    "x": item["x"],
                    "y": item["y"],
                    "yaw": item["yaw"],
                    "width": item.get("width", 0),
                    "length": item.get("length", 0),
                    "s": s,
                    "roadId": roadId,
                })
        replayer[trial_id] = {"time": trajectory["time"], "trajectory": agents}
    return replayer


# ---------------------------------------------------------------------------
# Tests
# ---------------------------------------------------------------------------

class TestRoadIdPreservation(unittest.TestCase):

    def test_integer_roadid_preserved(self):
        """Valid integer roadId must be stored as-is."""
        raw = {"t1": {"time": [0.0], "trajectory": {
            "Ego": [{"x": 0, "y": 0, "yaw": 0, "roadId": 51, "s": 10.0}]
        }}}
        result = _build_replayer_trajectories(raw)
        self.assertEqual(result["t1"]["trajectory"]["Ego"][0]["roadId"], 51)

    def test_float_roadid_preserved(self):
        """A clean float like 51.0 must be converted to int 51, not defaulted to 0."""
        raw = {"t1": {"time": [0.0], "trajectory": {
            "Ego": [{"x": 0, "y": 0, "yaw": 0, "roadId": 51.0, "s": 10.0}]
        }}}
        result = _build_replayer_trajectories(raw)
        self.assertEqual(result["t1"]["trajectory"]["Ego"][0]["roadId"], 51)

    def test_nan_roadid_falls_back_to_previous_frame(self):
        """NaN roadId must fall back to the previous valid frame's roadId, NOT 0."""
        raw = {"t1": {"time": [0.0, 0.1, 0.2], "trajectory": {
            "Ego": [
                {"x": 0, "y": 0, "yaw": 0, "roadId": 51, "s": 10.0},
                {"x": 1, "y": 0, "yaw": 0, "roadId": float("nan"), "s": 11.0},  # NaN
                {"x": 2, "y": 0, "yaw": 0, "roadId": 52, "s": 12.0},
            ]
        }}}
        result = _build_replayer_trajectories(raw)
        frames = result["t1"]["trajectory"]["Ego"]
        self.assertEqual(frames[0]["roadId"], 51)
        self.assertEqual(frames[1]["roadId"], 51,  # fallback to previous, NOT 0
                         "NaN roadId should fall back to previous frame (51), not 0")
        self.assertEqual(frames[2]["roadId"], 52)
        print("✓ NaN falls back to previous valid roadId (not 0)")

    def test_none_roadid_falls_back_to_previous_frame(self):
        """None roadId must also fall back safely."""
        raw = {"t1": {"time": [0.0, 0.1], "trajectory": {
            "Ego": [
                {"x": 0, "y": 0, "yaw": 0, "roadId": 51, "s": 10.0},
                {"x": 1, "y": 0, "yaw": 0, "roadId": None, "s": 11.0},
            ]
        }}}
        result = _build_replayer_trajectories(raw)
        frames = result["t1"]["trajectory"]["Ego"]
        self.assertEqual(frames[1]["roadId"], 51,
                         "None roadId should fall back to previous frame (51), not 0")

    def test_missing_roadid_key_defaults_to_zero(self):
        """If roadId key doesn't exist at all, safe default of 0 is acceptable."""
        raw = {"t1": {"time": [0.0], "trajectory": {
            "Ego": [{"x": 0, "y": 0, "yaw": 0, "s": 10.0}]  # no roadId key
        }}}
        result = _build_replayer_trajectories(raw)
        self.assertEqual(result["t1"]["trajectory"]["Ego"][0]["roadId"], 0)

    def test_multi_agent_roadids_independent(self):
        """Ego and Oncoming have different roadIds — they must not interfere."""
        raw = {"t1": {"time": [0.0], "trajectory": {
            "Ego":      [{"x": 0, "y": 0, "yaw": 0, "roadId": 51, "s": 10.0}],
            "Oncoming": [{"x": 0, "y": 0, "yaw": 0, "roadId": 152, "s": 20.0}],
        }}}
        result = _build_replayer_trajectories(raw)
        self.assertEqual(result["t1"]["trajectory"]["Ego"][0]["roadId"], 51)
        self.assertEqual(result["t1"]["trajectory"]["Oncoming"][0]["roadId"], 152)
        print("✓ Multi-agent: Ego=51, Oncoming=152 — no cross-contamination")

    def test_real_esmini_csv(self):
        """
        Read the actual cached esmini CSV and verify that the first frame
        roadId values (51 for Ego, 152 for Oncoming) survive the fix logic.

        CSV location: simulation/ros/.cache/scenario_search/records/esmini_1_51.csv
        This file is produced by dat2csv.py from an actual esmini .dat recording.
        """
        csv_path = os.path.join(
            os.path.dirname(__file__),
            "simulation", "ros", ".cache", "scenario_search", "records", "esmini_1_51.csv"
        )
        if not os.path.exists(csv_path):
            self.skipTest(f"Real esmini CSV not found at {csv_path}")

        # Parse the CSV (skip the version line, use the header line)
        frames = {"Ego": [], "Oncoming": []}
        with open(csv_path, newline="") as f:
            reader = csv.reader(f)
            next(reader)             # version line
            header = [h.strip() for h in next(reader)]
            for row in reader:
                if len(row) < len(header):
                    continue
                entry = dict(zip(header, row))
                name = entry["name"].strip()
                if name in frames:
                    frames[name].append({
                        "x": float(entry["x"]),
                        "y": float(entry["y"]),
                        "yaw": float(entry["h"]),
                        "roadId": float(entry["roadId"]),
                        "s": float(entry["s"]),
                    })

        # Build replayer from what was parsed (like the analyzer would)
        raw = {"real_trial": {"time": [], "trajectory": {
            name: frames[name] for name in frames if frames[name]
        }}}
        result = _build_replayer_trajectories(raw)

        ego_frames = result["real_trial"]["trajectory"]["Ego"]
        oncoming_frames = result["real_trial"]["trajectory"]["Oncoming"]

        # Verify all Ego frames have roadId 51 (no 0s slipping in)
        ego_road_ids = set(f["roadId"] for f in ego_frames)
        self.assertIn(51, ego_road_ids,
                      f"Expected roadId=51 for Ego but got: {ego_road_ids}")
        self.assertNotIn(0, ego_road_ids,
                         f"Ego roadId should never be 0, but found 0 in {ego_road_ids}")

        # Verify all Oncoming frames have roadId 152
        onc_road_ids = set(f["roadId"] for f in oncoming_frames)
        self.assertIn(152, onc_road_ids,
                      f"Expected roadId=152 for Oncoming but got: {onc_road_ids}")
        self.assertNotIn(0, onc_road_ids,
                         f"Oncoming roadId should never be 0, but found 0 in {onc_road_ids}")

        print(f"✓ Real esmini CSV: Ego roadIds={ego_road_ids}, "
              f"Oncoming roadIds={onc_road_ids} — all preserved correctly")


if __name__ == "__main__":
    unittest.main(verbosity=2)
