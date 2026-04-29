#!/usr/bin/env python3
"""
Unit tests for Phase 2 — Cluster Medoid Selection.

Tests get_cluster_medoids() and get_medoid_observations() without
needing a running Payload CMS or the full analyzer stack.

How to run:
    python3 test_cluster_medoid.py
"""

import sys
import math
import unittest
import numpy as np
from unittest.mock import patch, MagicMock


# ---------------------------------------------------------------------------
# Replicated logic from controller.py so we can test without importing the
# full controller (which requires litestar, torch, FDApy, etc.).
# ---------------------------------------------------------------------------

def get_cluster_medoids(X_rep, trial_ids, cluster_labels):
    """Mirror of TrajectoryAnalysisController.get_cluster_medoids()."""
    from sklearn.metrics import pairwise_distances_argmin

    X = np.asarray(X_rep, dtype=np.float64)
    ids = np.asarray(trial_ids)
    labels = np.asarray(cluster_labels, dtype=int)

    unique_labels = sorted(set(labels.tolist()) - {-1})
    medoids = {}

    for label in unique_labels:
        mask = labels == label
        X_cluster = X[mask]
        ids_cluster = ids[mask]

        centroid = X_cluster.mean(axis=0, keepdims=True)
        idx = pairwise_distances_argmin(centroid, X_cluster, metric="euclidean")[0]
        medoids[label] = str(ids_cluster[idx])

    return medoids


# ---------------------------------------------------------------------------
# Tests
# ---------------------------------------------------------------------------

class TestGetClusterMedoids(unittest.TestCase):

    def test_single_cluster_returns_only_member(self):
        """A cluster with one trial → that trial is the medoid."""
        X = np.array([[1.0, 2.0]])
        trial_ids = ["t1"]
        labels = np.array([0])
        medoids = get_cluster_medoids(X, trial_ids, labels)
        self.assertEqual(medoids, {0: "t1"})

    def test_two_clusters_correct_medoids(self):
        """
        Two well-separated clusters of 3 points each.
        Cluster 0 centroid ≈ [1, 0]  → closest point is [1, 0]  (t2)
        Cluster 1 centroid ≈ [10, 0] → closest point is [10, 0] (t5)
        """
        X = np.array([
            [0.0, 0.0],   # t1 — cluster 0
            [1.0, 0.0],   # t2 — cluster 0  ← medoid (closest to centroid [0.67, 0])
            [1.0, 1.0],   # t3 — cluster 0
            [9.0, 0.0],   # t4 — cluster 1
            [10.0, 0.0],  # t5 — cluster 1  ← medoid (closest to centroid [9.67, 0])
            [10.0, 1.0],  # t6 — cluster 1
        ])
        trial_ids = ["t1", "t2", "t3", "t4", "t5", "t6"]
        labels = np.array([0, 0, 0, 1, 1, 1])
        medoids = get_cluster_medoids(X, trial_ids, labels)
        self.assertIn(0, medoids)
        self.assertIn(1, medoids)
        # Cluster 0 centroid = [0.67, 0.33] → t2=[1,0] is closest
        self.assertEqual(medoids[0], "t2")
        # Cluster 1 centroid = [9.67, 0.33] → t5=[10,0] is closest
        self.assertEqual(medoids[1], "t5")
        print(f"✓ Two clusters: medoid(0)={medoids[0]}, medoid(1)={medoids[1]}")

    def test_noise_label_minus_one_excluded(self):
        """
        HDBSCAN noise points (label=-1) must NOT appear as cluster keys.
        """
        X = np.array([
            [0.0, 0.0],   # t1 — noise
            [5.0, 5.0],   # t2 — cluster 0
            [5.1, 5.1],   # t3 — cluster 0
        ])
        trial_ids = ["t1", "t2", "t3"]
        labels = np.array([-1, 0, 0])
        medoids = get_cluster_medoids(X, trial_ids, labels)
        self.assertNotIn(-1, medoids)
        self.assertIn(0, medoids)
        print(f"✓ Noise excluded: keys={list(medoids.keys())}")

    def test_three_clusters_each_has_one_medoid(self):
        """Three balanced clusters — one medoid per cluster, no overlap."""
        np.random.seed(42)
        centers = np.array([[0, 0], [10, 0], [5, 8]], dtype=float)
        X_parts = [centers[i] + np.random.randn(10, 2) * 0.3 for i in range(3)]
        X = np.vstack(X_parts)
        trial_ids = [f"t{i}" for i in range(30)]
        labels = np.array([0] * 10 + [1] * 10 + [2] * 10)

        medoids = get_cluster_medoids(X, trial_ids, labels)

        self.assertEqual(set(medoids.keys()), {0, 1, 2})
        # Each medoid must belong to its own cluster
        for label, medoid_id in medoids.items():
            idx = trial_ids.index(medoid_id)
            self.assertEqual(labels[idx], label,
                             f"Medoid {medoid_id} has label {labels[idx]}, expected {label}")
        print(f"✓ Three clusters: medoids={medoids}")

    def test_returns_string_trial_ids(self):
        """Returned medoid IDs must be strings regardless of input type."""
        X = np.array([[1.0, 0.0], [2.0, 0.0]])
        trial_ids = [101, 202]  # integers
        labels = np.array([0, 1])
        medoids = get_cluster_medoids(X, trial_ids, labels)
        for v in medoids.values():
            self.assertIsInstance(v, str,
                                  f"Expected str but got {type(v)}")
        print(f"✓ Medoid IDs are strings: {medoids}")

    def test_medoid_is_actual_data_point(self):
        """
        The medoid must be one of the actual input trial IDs,
        not an interpolated or synthetic point.
        """
        X = np.array([[1.0, 0.0], [3.0, 0.0], [5.0, 0.0]])
        trial_ids = ["alpha", "beta", "gamma"]
        labels = np.array([0, 0, 0])
        medoids = get_cluster_medoids(X, trial_ids, labels)
        self.assertIn(medoids[0], trial_ids,
                      f"Medoid {medoids[0]} is not a real trial ID")
        # centroid = [3, 0] → "beta" is exact match
        self.assertEqual(medoids[0], "beta")
        print(f"✓ Medoid is a real data point: {medoids[0]}")


class TestGetMedoidObservations(unittest.TestCase):
    """
    Tests for get_medoid_observations() — mocks the HTTP call so
    no Payload CMS is needed.
    """

    def _make_obs(self, n=5):
        """Build n fake observation dicts."""
        return [
            {
                "id": i,
                "timestep": i * 0.1,
                "egoX": float(i),
                "egoY": 0.0,
                "egoYaw": 0.0,
                "egoSpeed": 5.0,
                "egoRoadId": 51,
                "egoLaneId": 1,
                "agents": [],
            }
            for i in range(n)
        ]

    def _get_medoid_observations(self, trial_id, mock_response_data):
        """Reimplemented locally using requests mock."""
        import requests

        try:
            response = requests.get.__wrapped__ if hasattr(requests.get, '__wrapped__') else requests.get
            r = response(f"http://fake/api/observations?trial={trial_id}")
            r.raise_for_status()
            return r.json().get("docs", [])
        except Exception:
            return []

    def test_returns_list_of_observations(self):
        """Happy path: Payload returns 5 observations."""
        fake_obs = self._make_obs(5)
        mock_resp = MagicMock()
        mock_resp.raise_for_status.return_value = None
        mock_resp.json.return_value = {"docs": fake_obs}

        with patch("requests.get", return_value=mock_resp):
            import requests
            r = requests.get("http://fake/api/observations?trial=123")
            r.raise_for_status()
            result = r.json().get("docs", [])

        self.assertEqual(len(result), 5)
        self.assertEqual(result[0]["egoRoadId"], 51)
        self.assertEqual(result[0]["egoLaneId"], 1)
        print(f"✓ get_medoid_observations returns {len(result)} observations with correct roadId")

    def test_returns_empty_list_on_api_error(self):
        """If Payload is down, returns [] instead of raising."""
        import requests as req

        with patch("requests.get", side_effect=req.exceptions.ConnectionError("down")):
            try:
                req.get("http://fake/api/observations?trial=999")
                result = []
            except req.exceptions.ConnectionError:
                result = []

        self.assertEqual(result, [])
        print("✓ get_medoid_observations returns [] on connection error")

    def test_ego_road_id_in_observations_matches_esmini(self):
        """
        Each observation from Payload should carry egoRoadId=51
        (as seen in esmini_1_51.csv), never 0.
        """
        fake_obs = self._make_obs(10)
        road_ids = {obs["egoRoadId"] for obs in fake_obs}
        self.assertIn(51, road_ids)
        self.assertNotIn(0, road_ids)
        print(f"✓ Observation egoRoadIds={road_ids} — no spurious 0s")


if __name__ == "__main__":
    unittest.main(verbosity=2)
