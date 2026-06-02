"""Tests for Phase 6 cluster interpretation helpers (no OpenAI calls)."""

from __future__ import annotations

import json
import sys
from pathlib import Path

import numpy as np

REPO = Path(__file__).resolve().parents[1]
ANALYZER_SRC = REPO / "app" / "analyzer" / "src"
if str(ANALYZER_SRC) not in sys.path:
    sys.path.insert(0, str(ANALYZER_SRC))

from llm.cluster_interpretation_pipeline import (  # noqa: E402
    action_log_from_observations,
    build_cluster_stats,
    compute_cluster_medoids,
    interpret_cluster_dir,
    write_stub_interpretation,
)


def test_compute_cluster_medoids():
    X = np.array([[0, 0], [1, 1], [10, 10], [11, 11]], dtype=float)
    ids = ["a", "b", "c", "d"]
    labels = np.array([0, 0, 1, 1])
    medoids = compute_cluster_medoids(X, ids, labels)
    assert medoids[0] in ("a", "b")
    assert medoids[1] in ("c", "d")


def test_action_log_from_observations():
    obs = [
        {"time": 0.0, "egoSpeed": 5.0, "egoRoadId": 1, "egoLaneId": -1, "agents": []},
        {"time": 1.0, "egoSpeed": 2.0, "egoRoadId": 1, "egoLaneId": -1, "agents": []},
    ]
    log = action_log_from_observations(obs)
    assert "Time=0.0s" in log
    assert "decelerating" in log.lower() or "speed=2.0" in log


def test_build_cluster_stats():
    trials = {
        "t1": {
            "testObjectives": {
                "criticalityMetrics": [
                    {"keyPerformanceIndicator": {"name": "collision"}, "value": 1},
                    {"keyPerformanceIndicator": {"name": "ttc_min"}, "value": 1.5},
                ]
            },
            "parameters": [{"parameterId": "p1", "value": 50}],
        },
        "t2": {
            "testObjectives": {
                "criticalityMetrics": [
                    {"keyPerformanceIndicator": {"name": "collision"}, "value": 0},
                    {"keyPerformanceIndicator": {"name": "ttc_min"}, "value": 2.5},
                ]
            },
            "parameters": [{"parameterId": "p1", "value": 60}],
        },
    }
    stats = build_cluster_stats(0, ["t1", "t2"], trials, [{"id": "p1", "name": "speed"}])
    assert stats["n_trials"] == 2
    assert stats["collision_rate"] == 50.0
    assert "speed" in stats["parameter_ranges"]


def test_interpret_cluster_dir_dry_run(tmp_path):
    cluster_dir = tmp_path / "clusters" / "cluster_0"
    cluster_dir.mkdir(parents=True)
    (cluster_dir / "stats.json").write_text(
        json.dumps({"cluster_label": 0, "medoid_trial_id": "2601", "cluster_size": 10}),
        encoding="utf-8",
    )
    (cluster_dir / "observations.json").write_text(
        json.dumps([{"time": 0, "egoSpeed": 3, "egoRoadId": 1, "egoLaneId": -1}]),
        encoding="utf-8",
    )
    out = interpret_cluster_dir(
        cluster_dir, 0, "dataset1", dry_run=True
    )
    assert out is not None
    assert out.name == "cluster_interpretation.yaml"
    text = out.read_text(encoding="utf-8")
    assert "offline stub" in text.lower() or "skipped" in text.lower()
