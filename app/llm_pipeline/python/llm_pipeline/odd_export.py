"""S2 (Python twin) — ODD boundary export without the Dashboard browser.

Mirrors ``app/dashboard/.../explore/lib/boundaryExport.ts`` +
``Filtering/index.tsx`` "Export ODD boundary" button, so a batch/cluster
folder can be (re)exported from a terminal / CI job, not just by clicking a
button in Explore. Writes the exact same three files the UI writes:

  odd_boundary_export.json
  odd_all_trials.json
  odd_boundary_export.kNN<k>.json   (sidecar snapshot)

Data source note (see implementation_plan.md §2.2 A4): trial-level scenario
parameters + KPI pass/fail are **not** queryable from Payload's live Trial
collection for this dataset (REST ``/api/trials?where[batch][equals]=<id>``
returns zero docs — the paper-casestudy trials were only ever materialized
into a saved Dashboard analysis zip, never re-inserted as live Trial
documents). The only reliable on-disk/network source is the same saved
analysis zip Explore already reads via the Saves panel, fetched here with
``dataset_builder._fetch_payload_analysis`` (same helper the LLM pipeline
already uses for medoid/pair building) — not a new Payload access path.

Each trial's *own* embedded ``trial.batch.scenario.parameters`` (baked into
the zip at simulation time) is used to resolve ``parameterId -> name``,
instead of a live ``GET /api/batches/<id>`` call: the "current" batch document
in Payload can be a *different* ObjectId epoch than the one trials were
originally simulated under (confirmed for batch 8: current batch's
criticalityMetric ids are ``6a5f0d82...``, but every trial's embedded
``batch.scenario`` carries ``68b78058...`` ids) — this is the same mismatch
that broke ``calculateDistance`` / ``paramNameById`` in the TS path, worked
around there with positional matching. Here we avoid the mismatch entirely by
reading the id->name map from data that is self-consistent by construction.
"""

from __future__ import annotations

import json
import re
import sys
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any, Dict, List, Optional, Tuple

import numpy as np
from scipy.spatial import cKDTree

from .paths import find_repo_root

ALL_TRIALS_FILENAME = "odd_all_trials.json"
EXPORT_FILENAME = "odd_boundary_export.json"


def _analyzer_src(start: Path) -> Path:
    return find_repo_root(start) / "app" / "analyzer" / "src"


def _dataset_builder_module():
    src = _analyzer_src(Path(__file__).resolve())
    if str(src) not in sys.path:
        sys.path.insert(0, str(src))
    import dataset_builder  # type: ignore

    return dataset_builder


def parse_run_dir(run_dir: Path) -> Tuple[int, int, str]:
    """``results/batch<id>/<k>_cluster_s=<sil>/`` -> (batch_id, k, folder_name)."""
    run_dir = run_dir.resolve()
    folder = run_dir.name
    batch_dir = run_dir.parent.name
    m = re.match(r"batch(\d+)$", batch_dir)
    if not m:
        raise ValueError(f"Cannot parse batch id from parent dir name: {batch_dir!r}")
    mk = re.match(r"(\d+)_cluster", folder)
    k = int(mk.group(1)) if mk else -1
    return int(m.group(1)), k, folder


def load_selected_clustering_result(run_dir: Path) -> Dict[str, Any]:
    p = run_dir / "clustering" / "selectedClusteringResult.json"
    if not p.is_file():
        raise FileNotFoundError(
            f"Missing {p} — this folder was not produced by dataset_builder "
            "(no clustering/selectedClusteringResult.json to read cluster labels from)."
        )
    return json.loads(p.read_text(encoding="utf-8"))


def fetch_ego_data(
    batch_id: int,
    *,
    ego_name: str = "ITRI",
    duration_mode: str = "full",
    save_doc_id: Optional[int] = None,
    analysis_zip: Optional[str] = None,
) -> Dict[str, Any]:
    db = _dataset_builder_module()
    result = db._fetch_payload_analysis(
        batch_id,
        save_doc_id=save_doc_id,
        duration_mode=duration_mode,
        ego_name=ego_name,
        analysis_zip=analysis_zip,
    )
    if result is None:
        raise RuntimeError(
            f"Could not fetch/parse a saved analysis for batch {batch_id} "
            f"(ego={ego_name}, duration_mode={duration_mode}). Run the Dashboard "
            "Explore -> Saves -> Analysis 'save' step first, or pass --analysis-zip."
        )
    _scores, _clustering_list, ego_data, _selected_meta = result
    return ego_data


def scenario_param_order(trials_meta: Dict[str, Any]) -> List[Dict[str, Any]]:
    """Authoritative id/name/min/max list, read from a trial's own embedded scenario."""
    for t in trials_meta.values():
        if not isinstance(t, dict):
            continue
        params = (((t.get("batch") or {}).get("scenario") or {}).get("parameters")) or []
        if params:
            return params
    raise RuntimeError("No trial in this saved analysis carries an embedded batch.scenario.parameters list.")


def collision_kpi_meta(trials_meta: Dict[str, Any]) -> Dict[str, Any]:
    for t in trials_meta.values():
        if not isinstance(t, dict):
            continue
        for m in (t.get("testObjectives") or {}).get("criticalityMetrics") or []:
            kpi = (m or {}).get("keyPerformanceIndicator") or {}
            if isinstance(kpi, dict) and kpi.get("name") == "collision":
                return {"id": kpi.get("id"), "name": "collision", "rule": kpi.get("rule"), "unit": kpi.get("unit")}
    return {"id": None, "name": "collision", "rule": None, "unit": None}


@dataclass
class TrialTable:
    trial_ids: List[str]
    X_raw: np.ndarray  # (n, d) raw scenario-parameter values
    passed: List[Optional[bool]]
    param_names: List[str]
    param_min: np.ndarray  # (d,)
    param_max: np.ndarray  # (d,)


def build_trial_table(
    trials_meta: Dict[str, Any],
    scenario_params: List[Dict[str, Any]],
    kpi_id: Any,
) -> TrialTable:
    param_id_to_name: Dict[str, str] = {
        str(p.get("id")): p.get("name") for p in scenario_params if p.get("id") is not None
    }
    param_names = [p.get("name") for p in scenario_params]
    param_min = np.array([float(p.get("min")) for p in scenario_params], dtype=np.float64)
    param_max = np.array([float(p.get("max")) for p in scenario_params], dtype=np.float64)

    trial_ids: List[str] = []
    rows: List[List[float]] = []
    passed_list: List[Optional[bool]] = []

    for tid, t in trials_meta.items():
        if not isinstance(t, dict):
            continue
        vals: Dict[str, float] = {}
        for tp in t.get("parameters") or []:
            if not isinstance(tp, dict):
                continue
            pid = str(tp.get("parameterId") or tp.get("id") or "")
            name = param_id_to_name.get(pid)
            if name is None:
                continue
            try:
                vals[name] = float(tp.get("value"))
            except (TypeError, ValueError):
                continue
        if any(n not in vals for n in param_names):
            continue

        passed: Optional[bool] = None
        for m in (t.get("testObjectives") or {}).get("criticalityMetrics") or []:
            kpi = (m or {}).get("keyPerformanceIndicator") or {}
            if isinstance(kpi, dict) and kpi.get("id") == kpi_id:
                passed = m.get("passed")
                break

        trial_ids.append(str(tid))
        rows.append([vals[n] for n in param_names])
        passed_list.append(passed)

    X = np.asarray(rows, dtype=np.float64) if rows else np.zeros((0, len(param_names)))
    return TrialTable(trial_ids, X, passed_list, param_names, param_min, param_max)


def label_lookup(result_data: Dict[str, Any]) -> Dict[str, str]:
    """trial_id -> cluster label string (only for trials the clustering fit actually covers).

    "-1" (HDBSCAN noise) is a *real* label here, matching the Dashboard's
    ``clusteringResult.data[id].label`` lookup — a trial only maps to ``None``
    (no label at all) when it is entirely absent from ``data`` below, i.e. it
    was never part of the clustering fit (e.g. below MFPCA's minimum
    trajectory-duration cutoff), not because its label happens to be noise.
    """
    data = (result_data or {}).get("data") or {}
    out: Dict[str, str] = {}
    for tid, item in data.items():
        label = item.get("label") if isinstance(item, dict) else item
        if label is not None:
            out[str(tid)] = str(label)
    return out


@dataclass
class BoundarySide:
    boundary_trials: List[Dict[str, Any]] = field(default_factory=list)
    edges: List[Dict[str, Any]] = field(default_factory=list)


def compute_boundaries(
    table: TrialTable,
    labels: Dict[str, str],
    kNN: int,
) -> Dict[str, Any]:
    """Pure port of ``boundaryExport.ts::computeBoundaries`` (min-max L2 kd-tree kNN)."""
    n = len(table.trial_ids)
    if n == 0:
        raise RuntimeError("No trials with complete scenario parameters to build a tree from.")

    rng = np.where((table.param_max - table.param_min) < 1e-12, 1.0, table.param_max - table.param_min)
    X_norm = (table.X_raw - table.param_min) / rng  # min shift cancels in L2 diffs vs TS's raw/rng; kept for clarity

    tree = cKDTree(X_norm)
    k = min(kNN + 1, n)
    dists, idxs = tree.query(X_norm, k=k)
    if k == 1:
        dists = dists[:, None]
        idxs = idxs[:, None]

    def params_dict(i: int) -> Dict[str, float]:
        return {name: float(table.X_raw[i, j]) for j, name in enumerate(table.param_names)}

    collision_trials: Dict[str, Dict[str, Any]] = {}
    cluster_trials: Dict[str, Dict[str, Any]] = {}
    collision_edge_keys: set = set()
    cluster_edge_keys: set = set()
    collision_edges: List[Dict[str, Any]] = []
    cluster_edges: List[Dict[str, Any]] = []
    all_trials: List[Dict[str, Any]] = []
    n_without_label = 0

    def edge_key(a: str, b: str) -> str:
        return f"{a}|{b}" if a < b else f"{b}|{a}"

    for i, trial_id in enumerate(table.trial_ids):
        current_label = labels.get(trial_id)
        current_passed = table.passed[i]
        if current_label is None:
            n_without_label += 1

        all_trials.append(
            {
                "trial_id": trial_id,
                "parameters": params_dict(i),
                "passed": current_passed,
                "cluster_label": current_label,
            }
        )

        collision_neighbors: List[str] = []
        cluster_neighbors: List[str] = []

        row_idxs = idxs[i] if n > 1 else np.array([i])
        row_dists = dists[i] if n > 1 else np.array([0.0])
        for j, dist in zip(np.atleast_1d(row_idxs), np.atleast_1d(row_dists)):
            j = int(j)
            if j == i:
                continue
            neighbor_id = table.trial_ids[j]
            neighbor_label = labels.get(neighbor_id)
            neighbor_passed = table.passed[j]

            if (
                current_label is not None
                and neighbor_label is not None
                and current_passed is not None
                and neighbor_passed is not None
                and current_passed != neighbor_passed
            ):
                collision_neighbors.append(neighbor_id)
                key = edge_key(trial_id, neighbor_id)
                if key not in collision_edge_keys:
                    collision_edge_keys.add(key)
                    collision_edges.append({"trial_a": trial_id, "trial_b": neighbor_id, "param_dist": float(dist)})

            if current_label is not None and neighbor_label is not None and current_label != neighbor_label:
                cluster_neighbors.append(neighbor_id)
                key = edge_key(trial_id, neighbor_id)
                if key not in cluster_edge_keys:
                    cluster_edge_keys.add(key)
                    cluster_edges.append({"trial_a": trial_id, "trial_b": neighbor_id, "param_dist": float(dist)})

        if collision_neighbors:
            collision_trials[trial_id] = {
                "trial_id": trial_id,
                "parameters": params_dict(i),
                "passed": current_passed,
                "cluster_label": current_label,
                "neighbor_ids": list(dict.fromkeys(collision_neighbors)),
            }
        if cluster_neighbors:
            cluster_trials[trial_id] = {
                "trial_id": trial_id,
                "parameters": params_dict(i),
                "passed": current_passed,
                "cluster_label": current_label,
                "neighbor_ids": list(dict.fromkeys(cluster_neighbors)),
            }

    return {
        "kNN": kNN,
        "n_trials_considered": n,
        "n_trials_without_cluster_label": n_without_label,
        "collision_boundary": {"boundary_trials": list(collision_trials.values()), "edges": collision_edges},
        "cluster_boundary": {"boundary_trials": list(cluster_trials.values()), "edges": cluster_edges},
        "all_trials": all_trials,
    }


def export_run_dir(
    run_dir: Path,
    *,
    kNN: int = 10,
    ego_name: str = "ITRI",
    duration_mode: str = "full",
    save_doc_id: Optional[int] = None,
    analysis_zip: Optional[str] = None,
) -> Dict[str, Any]:
    """End-to-end S2 export for one ``results/batch<id>/<k>_cluster_s=.../`` folder.

    Writes the same three files as the Dashboard "Export ODD boundary" button
    and returns a short summary dict.
    """
    run_dir = Path(run_dir)
    batch_id, k_from_folder, folder = parse_run_dir(run_dir)

    result_data = load_selected_clustering_result(run_dir)
    silhouette = ((result_data.get("scores") or {}).get("silhouetteScore"))

    ego_data = fetch_ego_data(
        batch_id,
        ego_name=ego_name,
        duration_mode=duration_mode,
        save_doc_id=save_doc_id,
        analysis_zip=analysis_zip,
    )
    trials_meta = ego_data.get("trials") or {}
    scenario_params = scenario_param_order(trials_meta)
    kpi_meta = collision_kpi_meta(trials_meta)

    table = build_trial_table(trials_meta, scenario_params, kpi_meta.get("id"))
    labels = label_lookup(result_data)
    result = compute_boundaries(table, labels, kNN)

    clusters_included = sorted(
        {v for v in labels.values() if v != "-1"},
        key=lambda x: (len(x), x),
    )

    export_doc = {
        "generated_at": _now_iso(),
        "batch_id": batch_id,
        "folder": folder,
        "kNN": kNN,
        "kpi": kpi_meta,
        "clusters_included": clusters_included,
        "n_trials_considered": result["n_trials_considered"],
        "n_trials_without_cluster_label": result["n_trials_without_cluster_label"],
        "distance_note": (
            "min-max normalized L2 over scenario parameters (same metric as Filtering UI); "
            "not comparable to parameter-space pair z-score distance"
        ),
        "collision_boundary": result["collision_boundary"],
        "cluster_boundary": result["cluster_boundary"],
        "source": "python-cli (odd_export.py) — dataset_builder saved-analysis zip, not Payload REST/GraphQL",
    }
    all_trials_doc = {
        "generated_at": export_doc["generated_at"],
        "batch_id": batch_id,
        "folder": folder,
        "n_trials": len(result["all_trials"]),
        "trials": result["all_trials"],
    }

    export_path = run_dir / EXPORT_FILENAME
    export_path.write_text(json.dumps(export_doc, indent=2), encoding="utf-8")
    all_trials_path = run_dir / ALL_TRIALS_FILENAME
    all_trials_path.write_text(json.dumps(all_trials_doc, indent=2), encoding="utf-8")
    snapshot_path = run_dir / f"odd_boundary_export.kNN{kNN}.json"
    snapshot_path.write_text(json.dumps(export_doc, indent=2), encoding="utf-8")

    return {
        "run_dir": str(run_dir),
        "batch_id": batch_id,
        "folder": folder,
        "k_from_folder": k_from_folder,
        "silhouette_from_selected_result": silhouette,
        "kNN": kNN,
        "n_trials_considered": result["n_trials_considered"],
        "n_trials_without_cluster_label": result["n_trials_without_cluster_label"],
        "n_collision_boundary": len(result["collision_boundary"]["boundary_trials"]),
        "n_cluster_boundary": len(result["cluster_boundary"]["boundary_trials"]),
        "export_path": str(export_path),
        "all_trials_path": str(all_trials_path),
        "snapshot_path": str(snapshot_path),
    }


def _now_iso() -> str:
    from datetime import datetime, timezone

    return datetime.now(timezone.utc).isoformat().replace("+00:00", "Z")
