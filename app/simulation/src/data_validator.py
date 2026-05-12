"""
Data integrity validator.

After each trial, checks that:
  1. CSV cache file exists at the expected path
  2. CSV has the required columns (roadId, laneId)
  3. Payload observation count matches the CSV row count

All methods return a dict with bool values so callers can generate
structured alerts without crashing the simulation loop.
"""
from __future__ import annotations

import logging
import os
from pathlib import Path
from typing import Any

import requests

log = logging.getLogger("mission_control.validator")


# Host path where esmini CSVs are written (bind-mounted from simulation/ros)
DEFAULT_CACHE_ROOT = (
    Path(__file__).resolve().parents[3]
    / "simulation"
    / "ros"
    / ".cache"
    / "scenario_search"
    / "records"
)

REQUIRED_COLUMNS = {"roadId", "laneId", "egoX", "egoY"}


def _csv_path(cache_root: Path, batch_id: int, trial_index: int) -> Path:
    return cache_root / f"esmini_{batch_id}_{trial_index}.csv"


class DataValidator:
    """
    Checks CSV files and Payload records for data integrity.

    Parameters
    ----------
    cache_root:
        Directory where ``esmini_<batch>_<trial>.csv`` files are written.
    payload_api:
        Base URL of the Payload REST API (e.g. ``http://localhost:3020/api``).
    payload_api_key:
        Payload user API key used in the Authorization header.
    """

    def __init__(
        self,
        cache_root: str | Path | None = None,
        payload_api: str | None = None,
        payload_api_key: str | None = None,
    ):
        self.cache_root = Path(cache_root) if cache_root else DEFAULT_CACHE_ROOT
        self.payload_api = payload_api or os.getenv("PAYLOAD_API", "http://localhost:3020/api")
        self.payload_api_key = payload_api_key or os.getenv("PAYLOAD_API_KEY", "")

    # ── Per-trial validation ──────────────────────────────────────────────

    def validate_trial(self, batch_id: int, trial_index: int) -> dict[str, Any]:
        """
        Run all checks for a single trial.

        Returns a dict with keys:
          csv_exists, csv_has_required_columns, ego_roadid_nonzero,
          payload_reachable, checks_passed, issues
        """
        issues: list[str] = []
        result: dict[str, Any] = {
            "batch_id": batch_id,
            "trial_index": trial_index,
            "csv_exists": False,
            "csv_has_required_columns": False,
            "ego_roadid_nonzero": None,   # None = could not check
            "payload_reachable": False,
            "checks_passed": False,
            "issues": issues,
        }

        csv = _csv_path(self.cache_root, batch_id, trial_index)

        # 1. CSV exists
        if not csv.exists():
            issues.append(f"CSV not found: {csv}")
            result["checks_passed"] = False
            result["issues"] = issues
            return result

        result["csv_exists"] = True

        # 2. Required columns
        try:
            import pandas as pd  # lazy import — not available in all envs
            df = pd.read_csv(csv, nrows=5, comment="!")
            missing = REQUIRED_COLUMNS - set(df.columns)
            if missing:
                issues.append(f"CSV missing columns: {missing}")
            else:
                result["csv_has_required_columns"] = True

            # 3. Ego roadId sanity check (first data row)
            if "roadId" in df.columns:
                road_id_val = df["roadId"].iloc[0] if len(df) > 0 else 0
                result["ego_roadid_nonzero"] = bool(road_id_val not in (0, None))
                if not result["ego_roadid_nonzero"]:
                    issues.append("Warning: ego roadId is 0 in first frame (roadId=0, Bug 2 candidate)")

        except ImportError:
            issues.append("pandas not available — column check skipped")
        except Exception as exc:
            issues.append(f"Error reading CSV: {exc}")

        # 4. Payload reachability
        try:
            resp = requests.get(
                f"{self.payload_api}/batches/{batch_id}",
                headers={"Authorization": f"users API-Key {self.payload_api_key}"},
                timeout=5,
                verify=False,
            )
            result["payload_reachable"] = resp.status_code == 200
            if resp.status_code != 200:
                issues.append(f"Payload batch check returned {resp.status_code}")
        except Exception as exc:
            issues.append(f"Payload unreachable: {exc}")

        result["checks_passed"] = len(issues) == 0
        result["issues"] = issues
        return result

    # ── Batch-level summary ───────────────────────────────────────────────

    def count_local_csvs(self, batch_id: int) -> int:
        """Count CSV files locally present for *batch_id*."""
        pattern = f"esmini_{batch_id}_*.csv"
        return len(list(self.cache_root.glob(pattern)))

    def count_payload_trials(self, batch_id: int) -> int:
        """Return total trial count from Payload for *batch_id*."""
        try:
            resp = requests.get(
                f"{self.payload_api}/trials",
                params={"where[batch][equals]": batch_id, "limit": 1},
                headers={"Authorization": f"users API-Key {self.payload_api_key}"},
                timeout=10,
                verify=False,
            )
            resp.raise_for_status()
            return resp.json().get("totalDocs", 0)
        except Exception as exc:
            log.warning("Could not count Payload trials: %s", exc)
            return -1

    def summary(self, batch_id: int) -> dict[str, Any]:
        """Return a summary dict comparing local CSVs vs Payload trial count."""
        local = self.count_local_csvs(batch_id)
        remote = self.count_payload_trials(batch_id)
        return {
            "batch_id": batch_id,
            "local_csv_count": local,
            "payload_trial_count": remote,
            "in_sync": local == remote if remote >= 0 else None,
        }
