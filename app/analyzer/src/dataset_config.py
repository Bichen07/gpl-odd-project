"""Per-dataset map, batch, and Payload trial ID conventions (see readMD/DATA_INVENTORY_AND_ANALYSIS.md)."""
from __future__ import annotations

from pathlib import Path
from typing import Dict, Optional, Tuple

from repo_paths import REPO_ROOT, MAP_DIR
# Shared map assets (xodr + odrplot tracks) now live under results/map.
XODR_DIR = MAP_DIR

# Payload trial_id = trial_id_base + esmini CSV trial_index
DATASETS: Dict[str, Dict] = {
    "dataset1": {
        "batch_id": 1,
        "trial_id_base": 2600,
        "xodr": "hct_6.xodr",
        "tracks": "hct_6_tracks.csv",
        "location": "hct_6",
        "description": "Case 1 — junction / oncoming (full HCT map)",
    },
    "dataset2": {
        "batch_id": 2,
        "trial_id_base": 8135,
        "xodr": "hct_6_no_930.xodr",
        "tracks": "hct_6_no_930_tracks.csv",
        "location": "hct_6_no_930",
        "description": "Case 2 — straight road + parked vehicle",
    },
    "dataset3": {
        "batch_id": 3,
        "trial_id_base": 6122,
        "xodr": "hct_6.xodr",
        "tracks": "hct_6_tracks.csv",
        "location": "hct_6",
        "description": "Case 3 — full HCT map",
    },
}


def get_dataset_config(dataset: str) -> Dict:
    if dataset not in DATASETS:
        raise KeyError(
            f"Unknown dataset {dataset!r}. Expected one of: {list(DATASETS)}"
        )
    return DATASETS[dataset]


def dataset_for_batch_id(batch_id: int) -> Optional[str]:
    """Reverse-lookup the canonical dataset name for a Payload batch id.

    Used by payload-save mode so `--dataset` can be omitted: the batch id from
    the saved analysis determines which map/track assets to use.
    Returns None if no dataset maps to this batch id.
    """
    for name, cfg in DATASETS.items():
        if int(cfg.get("batch_id", -1)) == int(batch_id):
            return name
    return None


def xodr_path_for_dataset(dataset: str) -> Path:
    cfg = get_dataset_config(dataset)
    p = XODR_DIR / cfg["xodr"]
    if not p.is_file():
        alt = REPO_ROOT / "simulation/ros/.cache/scenario_search" / cfg["xodr"]
        if alt.is_file():
            return alt
    return p


def map_tracks_path_for_dataset(dataset: str) -> Path:
    cfg = get_dataset_config(dataset)
    return XODR_DIR / cfg["tracks"]


def trial_id_to_csv_indices(dataset: str, trial_id: str) -> Tuple[int, int]:
    """Map Payload/clustering trial ID to (batch_id, esmini CSV trial_index)."""
    cfg = get_dataset_config(dataset)
    tid = int(trial_id)
    trial_index = tid - int(cfg["trial_id_base"])
    return int(cfg["batch_id"]), trial_index


def csv_indices_to_trial_id(dataset: str, batch_id: int, trial_index: int) -> str:
    cfg = get_dataset_config(dataset)
    if int(cfg["batch_id"]) != batch_id:
        raise ValueError(
            f"batch_id {batch_id} does not match {dataset} (expected {cfg['batch_id']})"
        )
    return str(int(cfg["trial_id_base"]) + int(trial_index))
