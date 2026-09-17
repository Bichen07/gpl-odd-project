"""Parity / smoke tests for clustering_uniqueness (PerEgoSelection-v1)."""

from __future__ import annotations

import sys
from pathlib import Path

SRC = Path(__file__).resolve().parents[1]
if str(SRC) not in sys.path:
    sys.path.insert(0, str(SRC))

from clustering_uniqueness import (  # noqa: E402
    DEFAULT_DUPLICATED_FILTER_RATIO,
    UNIQUENESS_ALGORITHM,
    compute_clustering_uniqueness,
)


def _result(labels_by_trial: dict) -> dict:
    return {
        "data": {
            tid: {"label": lab} for tid, lab in labels_by_trial.items()
        }
    }


def test_identical_partitions_collapse_to_one():
    # Two identical 3-trial partitions → one unique.
    a = _result({"1": "0", "2": "0", "3": "1"})
    b = _result({"1": "0", "2": "0", "3": "1"})
    indices, noise, meta = compute_clustering_uniqueness(
        [a, b], trial_order_len=3, duplicated_filter_ratio=0.005
    )
    assert indices == [0]
    assert meta["algorithm"] == UNIQUENESS_ALGORITHM
    assert meta["duplicatedFilterRatio"] == DEFAULT_DUPLICATED_FILTER_RATIO
    assert noise["0"] == 0.0


def test_distinct_partitions_both_kept():
    a = _result({"1": "0", "2": "0", "3": "1"})
    b = _result({"1": "0", "2": "1", "3": "1"})  # trial 2 moved
    indices, _noise, _meta = compute_clustering_uniqueness(
        [a, b], trial_order_len=3, duplicated_filter_ratio=0.005
    )
    # differentRatio for one trial of 3 is ~0.33 >> 0.005 → both unique
    assert indices == [0, 1]


def test_higher_rank_replaces_duplicate():
    a = _result({"1": "0", "2": "0", "3": "1"})
    b = _result({"1": "0", "2": "0", "3": "1"})

    def rank(_result, index):
        return 2 if index == 1 else 0

    indices, _noise, _meta = compute_clustering_uniqueness(
        [a, b],
        trial_order_len=3,
        duplicated_filter_ratio=0.005,
        rank_for_index=rank,
    )
    assert indices == [1]


def test_null_slots_skipped():
    a = _result({"1": "0", "2": "1"})
    indices, noise, _meta = compute_clustering_uniqueness(
        [None, a, None], trial_order_len=2
    )
    assert indices == [1]
    assert "1" in noise


def test_noise_ratio():
    a = _result({"1": "-1", "2": "0", "3": "0", "4": "1"})
    _indices, noise, _meta = compute_clustering_uniqueness(
        [a], trial_order_len=4
    )
    assert abs(noise["0"] - 0.25) < 1e-9
