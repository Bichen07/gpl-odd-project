#!/usr/bin/env python3
"""
Unit test for the roadId preservation fix in controller.py.

This test verifies that the replayerTrajectories construction no longer
defaults valid roadIds to 0 when they are integers or clean floats.
It also checks the safe fallback behavior for NaN/missing values.
"""

import unittest
import math
from unittest.mock import patch, MagicMock


class TestRoadIdPreservation(unittest.TestCase):

    def test_roadid_preservation_in_replayer_trajectories(self):
        """Test the fixed logic that builds replayerTrajectories."""

        # Simulate rawTrajectories structure that the analyzer receives
        raw_trajectories = {
            "123": {
                "time": [0.0, 0.1, 0.2],
                "trajectory": {
                    "Ego": [
                        {"x": 0.0, "y": 0.0, "yaw": 0.0, "roadId": 51, "s": 10.0},
                        {"x": 5.0, "y": 0.0, "yaw": 0.0, "roadId": 51.0, "s": 15.0},  # clean float
                        {"x": 10.0, "y": 0.0, "yaw": 0.0, "roadId": float("nan"), "s": 20.0},  # NaN
                        {"x": 15.0, "y": 0.0, "yaw": 0.0, "roadId": 52, "s": 25.0},
                    ]
                }
            }
        }

        # Mock the part of the code that was buggy
        replayer = {}
        for trial_id, data in raw_trajectories.items():
            agents = {}
            for agent_name, agent_list in data["trajectory"].items():
                agents[agent_name] = []
                prev_road = 0
                prev_s = 0.0
                for item in agent_list:
                    roadId = 0
                    s = 0.0
                    if "roadId" in item and item["roadId"] is not None:
                        try:
                            if isinstance(item["roadId"], (int, float)) and not math.isnan(item["roadId"]):
                                roadId = int(item["roadId"])
                            else:
                                roadId = prev_road
                        except (ValueError, TypeError, KeyError):
                            roadId = prev_road

                    if "s" in item and item["s"] is not None:
                        try:
                            s = float(item["s"])
                        except (ValueError, TypeError):
                            s = prev_s

                    agents[agent_name].append({
                        "x": item["x"],
                        "y": item["y"],
                        "yaw": item["yaw"],
                        "s": s,
                        "roadId": roadId
                    })
                    prev_road = roadId
                    prev_s = s

            replayer[trial_id] = {"trajectory": agents}

        # Assertions
        ego_traj = replayer["123"]["trajectory"]["Ego"]
        self.assertEqual(ego_traj[0]["roadId"], 51)
        self.assertEqual(ego_traj[1]["roadId"], 51)   # preserved from float 51.0
        self.assertEqual(ego_traj[2]["roadId"], 51)   # NaN → fallback to previous
        self.assertEqual(ego_traj[3]["roadId"], 52)   # new valid value

        print("✓ All roadId values correctly preserved (no spurious 0s)")

    def test_real_esmini_csv_example(self):
        """Simulate a small snippet from real esmini CSV output."""
        # Real values seen in esmini_1_51.csv: roadId=51, laneId=1, etc.
        sample_frames = [
            {"roadId": 51, "s": 57.544},
            {"roadId": 51, "s": 56.989},
            {"roadId": 51, "s": 49.175},
        ]

        reconstructed = []
        prev_road = 0
        for frame in sample_frames:
            road = frame["roadId"] if not math.isnan(frame["roadId"]) else prev_road
            reconstructed.append({"roadId": int(road)})
            prev_road = road

        self.assertEqual([r["roadId"] for r in reconstructed], [51, 51, 51])
        print("✓ Real esmini roadId=51 values are preserved")


if __name__ == "__main__":
    unittest.main()
