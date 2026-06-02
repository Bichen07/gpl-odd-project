#!/usr/bin/env python3
"""
Unit tests for Phase 3 — BEV Renderer.

Tests XodrParser geometry sampling and BevRenderer key-timestep selection
without needing a display or writing real files (matplotlib is mocked).

How to run:
    conda activate analyzer
    python3 tests/test_bev_renderer.py
"""

import math
import os
import sys
import unittest
from unittest.mock import MagicMock, patch

# Allow importing from app/analyzer/src
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "app", "analyzer", "src"))

from bev.renderer import (
    BevRenderer,
    BevSnapshot,
    _sample_arc,
    _sample_line,
    _sample_param_poly3,
    _sample_spiral,
    _load_medoids_from_clustering,
)


# ---------------------------------------------------------------------------
# Geometry helpers
# ---------------------------------------------------------------------------

class TestSampleLine(unittest.TestCase):
    def test_straight_horizontal(self):
        pts = _sample_line(0, 0, 0, 10, 2)
        self.assertGreaterEqual(len(pts), 2)
        # All y should be 0
        self.assertTrue(all(abs(p[1]) < 1e-9 for p in pts))
        # x should be non-decreasing
        xs = [p[0] for p in pts]
        self.assertEqual(xs, sorted(xs))

    def test_start_end_points(self):
        pts = _sample_line(5, 3, 0, 10, 1)
        self.assertAlmostEqual(pts[0][0], 5, places=6)
        self.assertAlmostEqual(pts[0][1], 3, places=6)
        self.assertAlmostEqual(pts[-1][0], 15, places=5)

    def test_diagonal(self):
        angle = math.pi / 4  # 45 degrees
        pts = _sample_line(0, 0, angle, math.sqrt(2), 0.5)
        # Last point should be near (1, 1)
        self.assertAlmostEqual(pts[-1][0], 1.0, places=4)
        self.assertAlmostEqual(pts[-1][1], 1.0, places=4)


class TestSampleArc(unittest.TestCase):
    def test_quarter_circle(self):
        # radius = 10, curvature = 0.1, arc length = pi/2 * 10 ≈ 15.7
        pts = _sample_arc(10, 0, math.pi / 2, math.pi / 2 * 10, 0.1, 1.0)
        self.assertGreaterEqual(len(pts), 2)
        # Start should be near (10, 0)
        self.assertAlmostEqual(pts[0][0], 10, places=3)
        self.assertAlmostEqual(pts[0][1], 0, places=3)

    def test_zero_curvature_falls_back_to_line(self):
        pts_arc = _sample_arc(0, 0, 0, 10, 0.0, 1.0)
        pts_line = _sample_line(0, 0, 0, 10, 1.0)
        # Should produce same number of points as a line
        self.assertEqual(len(pts_arc), len(pts_line))


class TestSampleSpiral(unittest.TestCase):
    def test_zero_curvature_is_straight(self):
        """Spiral with k0=k1=0 should give a straight line."""
        pts = _sample_spiral(0, 0, 0, 10, 0, 0, 1.0)
        self.assertGreaterEqual(len(pts), 2)
        # All y close to 0
        self.assertTrue(all(abs(p[1]) < 0.01 for p in pts),
                        f"Expected straight line, got: {pts[:3]}")

    def test_starts_at_origin(self):
        pts = _sample_spiral(5, 3, 0, 20, 0, 0.1, 2.0)
        self.assertAlmostEqual(pts[0][0], 5, places=9)
        self.assertAlmostEqual(pts[0][1], 3, places=9)


class TestSampleParamPoly3(unittest.TestCase):
    def test_straight_line_params(self):
        """bU=1, all others 0 → should give a line along u-axis at heading 0."""
        pts = _sample_param_poly3(0, 0, 0, 10,
                                   au=0, bu=1, cu=0, du=0,
                                   av=0, bv=0, cv=0, dv=0,
                                   p_range="normalized", step=0.2)
        self.assertGreaterEqual(len(pts), 2)
        # All y close to 0
        self.assertTrue(all(abs(p[1]) < 1e-9 for p in pts))


# ---------------------------------------------------------------------------
# BevRenderer key-timestep selection (no real rendering needed)
# ---------------------------------------------------------------------------

def _make_straight_traj(n=100, speed=10.0):
    """Simple straight trajectory along x-axis."""
    frames = [{"x": float(i), "y": 0.0, "yaw": 0.0,
               "width": 2.0, "length": 4.5, "speed": speed}
              for i in range(n)]
    time_steps = [i * 0.1 for i in range(n)]
    return frames, time_steps


class TestBevRendererKeyTimesteps(unittest.TestCase):
    """Tests the _pick_key_indices logic without rendering."""

    def setUp(self):
        # Patch XodrParser so no real file is needed
        with patch("bev_renderer.XodrParser") as mock_parser_cls:
            mock_parser = MagicMock()
            mock_parser.roads = []
            mock_parser_cls.return_value = mock_parser
            self.renderer = BevRenderer.__new__(BevRenderer)
            self.renderer.dpi = 120
            self.renderer._map_bounds = None
            self.renderer._parser = mock_parser

    def test_always_includes_start_and_end(self):
        ego, ts = _make_straight_traj(50)
        oncoming = [{"x": float(50 - i), "y": 0.0, "yaw": math.pi,
                     "width": 2.0, "length": 4.5, "speed": 10.0}
                    for i in range(50)]
        traj = {"Ego": ego, "Oncoming": oncoming}
        indices = self.renderer._pick_key_indices(traj, ts, n=5, collision_t=None)
        idx_list = [i for i, _ in indices]
        self.assertIn(0, idx_list, "Start frame (0) must be in key indices")
        self.assertIn(49, idx_list, "End frame must be in key indices")
        print(f"✓ Key indices always include start/end: {idx_list}")

    def test_detects_closest_approach(self):
        """Ego and Oncoming converge at frame 25 then diverge."""
        ego = [{"x": float(i), "y": 0.0, "yaw": 0.0,
                "width": 2.0, "length": 4.5, "speed": 10.0}
               for i in range(50)]
        oncoming = [{"x": float(50 - i), "y": 0.0, "yaw": math.pi,
                     "width": 2.0, "length": 4.5, "speed": 10.0}
                    for i in range(50)]
        traj = {"Ego": ego, "Oncoming": oncoming}
        ts = [i * 0.1 for i in range(50)]
        indices = self.renderer._pick_key_indices(traj, ts, n=5, collision_t=None)
        idx_list = [i for i, _ in indices]
        # Frame 25 is where they meet (x=25 both) → distance = 0
        self.assertIn(25, idx_list,
                      f"Closest approach (frame 25) must be detected, got {idx_list}")
        print(f"✓ Closest approach at frame 25 detected: {idx_list}")

    def test_no_duplicate_frames(self):
        ego, ts = _make_straight_traj(30)
        oncoming = [{"x": float(30 - i), "y": 0.0, "yaw": math.pi,
                     "width": 2.0, "length": 4.5, "speed": 5.0}
                    for i in range(30)]
        traj = {"Ego": ego, "Oncoming": oncoming}
        indices = self.renderer._pick_key_indices(traj, ts, n=5, collision_t=None)
        idx_list = [i for i, _ in indices]
        self.assertEqual(len(idx_list), len(set(idx_list)),
                         f"Duplicate frame indices found: {idx_list}")

    def test_n_snapshots_not_exceeded(self):
        ego, ts = _make_straight_traj(100)
        oncoming = [{"x": float(100 - i), "y": 0.0, "yaw": math.pi,
                     "width": 2.0, "length": 4.5, "speed": 10.0}
                    for i in range(100)]
        traj = {"Ego": ego, "Oncoming": oncoming}
        for n in [3, 5, 7]:
            indices = self.renderer._pick_key_indices(traj, ts, n=n, collision_t=None)
            self.assertLessEqual(len(indices), n,
                                 f"Expected ≤{n} snapshots but got {len(indices)}")
        print("✓ n_snapshots limit respected")


# ---------------------------------------------------------------------------
# Medoid loading from clustering JSON
# ---------------------------------------------------------------------------

class TestLoadMedoids(unittest.TestCase):
    def test_three_clusters(self):
        """
        Simulate a trajectories dict and a clustering dict with 3 clusters.
        Verify that _load_medoids_from_clustering returns one medoid per cluster.
        """
        # Build simple trajectories: 3 groups spatially separated
        traj = {}
        for i in range(30):
            cluster = i // 10
            base_x = cluster * 100.0
            frames = [{"x": base_x + j * 0.1, "y": 0.0, "yaw": 0.0,
                       "width": 2.0, "length": 4.5, "speed": 5.0}
                      for j in range(20)]
            traj[str(i)] = {"time": [j * 0.1 for j in range(20)],
                            "trajectory": {"Ego": frames}}

        clustering = {"data": {str(i): str(i // 10) for i in range(30)},
                      "task": {}, "scores": {}}

        import tempfile, json as json_mod
        with tempfile.NamedTemporaryFile("w", suffix=".json", delete=False) as f:
            json_mod.dump(clustering, f)
            tmp_path = f.name

        medoids = _load_medoids_from_clustering(tmp_path, traj)
        os.unlink(tmp_path)

        self.assertEqual(set(medoids.keys()), {0, 1, 2},
                         f"Expected clusters 0,1,2 but got {set(medoids.keys())}")
        for label, trial_id in medoids.items():
            self.assertIn(trial_id, traj,
                          f"Medoid {trial_id} not in trajectory dict")
        print(f"✓ Three cluster medoids: {medoids}")

    def test_noise_cluster_excluded(self):
        """Cluster label -1 (HDBSCAN noise) must not appear in result."""
        traj = {str(i): {"time": [0.0], "trajectory": {"Ego": [
            {"x": float(i), "y": 0.0, "yaw": 0.0, "width": 2.0, "length": 4.5}
        ]}} for i in range(5)}
        clustering = {"data": {"0": "-1", "1": "0", "2": "0", "3": "1", "4": "1"},
                      "task": {}, "scores": {}}

        import tempfile, json as json_mod
        with tempfile.NamedTemporaryFile("w", suffix=".json", delete=False) as f:
            json_mod.dump(clustering, f)
            tmp_path = f.name

        medoids = _load_medoids_from_clustering(tmp_path, traj)
        os.unlink(tmp_path)

        self.assertNotIn(-1, medoids, "Noise cluster -1 must be excluded")
        print(f"✓ Noise excluded. Medoids: {medoids}")


if __name__ == "__main__":
    unittest.main(verbosity=2)
