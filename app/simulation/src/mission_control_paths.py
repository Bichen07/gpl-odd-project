"""
Paths for Mission Control artifacts (logs, launch scripts, manifests).

On-disk layout is documented in ``app/simulation/docs/mission_control_artifacts.md``.

All paths are under the repo's ``simulation/ros/.cache/mission_control/``, which is
bind-mounted into the container as ``/project/mmsl_simulation/.cache/mission_control/``.
"""
from __future__ import annotations

import json
from pathlib import Path
from typing import Any

# app/simulation/src → repo root (parents[3] = gpl-odd-project)
_REPO_ROOT = Path(__file__).resolve().parents[3]

# Host-side cache (same tree visible in container under /project/mmsl_simulation)
MISSION_CONTROL_CACHE = _REPO_ROOT / "simulation" / "ros" / ".cache" / "mission_control"

# Inside sdc-bionic when ``simulation/ros`` is mounted at ``/project/mmsl_simulation``
CONTAINER_MISSION_CONTROL = "/project/mmsl_simulation/.cache/mission_control"


def runs_dir() -> Path:
    return MISSION_CONTROL_CACHE / "runs"


def run_dir_host(run_id: str) -> Path:
    return runs_dir() / run_id


def write_run_manifest(
    run_id: str,
    *,
    batch_id: int,
    scenario_id: int,
    n_trials: int,
    sampling_api_host: str,
    sampling_api_container: str,
    extra: dict[str, Any] | None = None,
) -> Path:
    """Create run folder and ``manifest.json``. Returns path to manifest."""
    d = run_dir_host(run_id)
    d.mkdir(parents=True, exist_ok=True)
    payload: dict[str, Any] = {
        "run_id": run_id,
        "batch_id": batch_id,
        "scenario_id": scenario_id,
        "n_trials": n_trials,
        "sampling_api_host": sampling_api_host,
        "sampling_api_container": sampling_api_container,
        "paths": {
            "host_cache_root": str(MISSION_CONTROL_CACHE),
            "container_cache_root": CONTAINER_MISSION_CONTROL,
            "records_csv_glob": str(
                _REPO_ROOT / "simulation" / "ros" / ".cache" / "scenario_search" / "records"
            ),
        },
    }
    if extra:
        payload["extra"] = extra
    manifest = d / "manifest.json"
    manifest.write_text(json.dumps(payload, indent=2), encoding="utf-8")
    return manifest
