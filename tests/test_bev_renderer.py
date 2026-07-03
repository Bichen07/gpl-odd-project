#!/usr/bin/env python3
"""
Unit tests for renderer.py — XODR geometry sampling helpers.

Note (June 2026 refactor): the old ``BevRenderer`` class and
``_load_medoids_from_clustering`` were removed; BEV rendering + medoid loading
now live in ``tier2_renderer.py`` (covered by test_bev_tier2.py). This file
keeps only the surviving geometry-sampling unit tests.

How to run:
    conda activate analyzer
    python3 tests/test_bev_renderer.py
"""

import math
import os
import sys
import unittest

# Allow importing from app/analyzer/src
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "app", "analyzer", "src"))

from renderer import (
    _sample_arc,
    _sample_line,
    _sample_param_poly3,
    _sample_spiral,
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


if __name__ == "__main__":
    unittest.main(verbosity=2)
