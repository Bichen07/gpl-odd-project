"""Cluster-level stats from ``collision.json`` + ``selectedClusteringResult_*.json``."""
from __future__ import annotations

from typing import Any, Dict, List, Union


def cluster_label_value(item: Union[str, int, Dict[str, Any]]) -> int:
    """Normalize cluster assignment from dashboard object or plain string label."""
    if isinstance(item, dict):
        return int(item.get("label", -1))
    return int(item)


def trials_in_cluster_data(
    assignments: Dict[str, Any],
    cluster_label: int,
) -> List[str]:
    """Return Payload trial IDs belonging to *cluster_label*."""
    out: List[str] = []
    for tid, item in assignments.items():
        if cluster_label_value(item) == int(cluster_label):
            out.append(str(tid))
    return out


def trial_collision_flag(collision_flags: Dict[str, Any], trial_id: str) -> bool:
    """Read boolean collision KPI for a trial from ``collision.json``."""
    if not collision_flags:
        return False
    val = collision_flags.get(str(trial_id), collision_flags.get(int(trial_id)))  # type: ignore[arg-type]
    return bool(val)


def build_collision_cluster_stats(
    cluster_label: int,
    clustering_result: Dict[str, Any],
    collision_flags: Dict[str, Any],
) -> Dict[str, Any]:
    """
    Aggregate collision rate for one cluster using senior's export files.

    ``clustering_result`` is the full ``selectedClusteringResult_*Clusters.json``
    object or its ``data`` mapping.
    """
    if "data" in clustering_result:
        assignments = clustering_result["data"]
    else:
        assignments = clustering_result

    trial_ids = trials_in_cluster_data(assignments, cluster_label)
    collisions = sum(
        1 for tid in trial_ids if trial_collision_flag(collision_flags, tid)
    )
    n = max(len(trial_ids), 1)
    return {
        "cluster_label": int(cluster_label),
        "n_trials": len(trial_ids),
        "collision_count": collisions,
        "collision_rate": round(100.0 * collisions / n, 2),
    }
