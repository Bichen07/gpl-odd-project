#!/usr/bin/env python3
"""Build structured LLM dataset from medoid trials (single CLI entry point).

Auto-ensures shared map assets under ``results/map/`` (via ``map_assets``), then
for each cluster medoid generates nested pack layout::

  clusterN/raw/{trajectory.csv,cluster.json}
  clusterN/processed/{action.yaml,description.txt,context.md,snapshots/,map_overview.jpg}
  clusterN/output/   # LLM YAMLs (medoid_trial / cluster_summary / shim)

Examples::

  export PYTHONPATH="app/llm_pipeline/python:app/analyzer/src"
  python3 app/analyzer/src/dataset_builder.py --batch-id 2 --k 4
  python3 app/analyzer/src/dataset_builder.py --batch-id 2 --map-only
  python3 app/analyzer/src/dataset_builder.py --batch-id 2 --from-run results/batch2/4_cluster

Output: results/batch<id>/<k>_cluster_s=<silhouette>/cluster<label>/
"""

import argparse
import io
import json
import math
import os
import re
import shutil
import sys
import zipfile
from datetime import datetime
from pathlib import Path
from typing import Any, Dict, List, Optional, Set, Tuple
import numpy as np
import pandas as pd

import yaml
import requests

# Add analyzer src to path for flat-module imports
from repo_paths import ANALYZER_SRC, REPO_ROOT, RESULTS_DIR
from cluster_paths import (
    ensure_layout,
    highlight_subdir,
    migrate_flat_to_nested,
    migrate_highlight_trials,
    processed_dir,
    resolve_path,
    snapshots_dir as nested_snapshots_dir,
    write_path,
)

if str(ANALYZER_SRC) not in sys.path:
    sys.path.insert(0, str(ANALYZER_SRC))

from renderer import XodrParser
from csv_roadid_loader import csv_exists, get_csv_road_data
from sim_labeller import assign_agent_road_id, build_meta_yaml, build_trajectory_csv

# Project root
PROJECT_ROOT = REPO_ROOT

# Payload API endpoint (Note: docker-compose maps container port 3000 to host port 3020)
PAYLOAD_API = os.getenv("PAYLOAD_API_URL", "http://localhost:3020")


def _build_csv_trial_mapping() -> Dict[str, Tuple[int, int]]:
    """Build a mapping from trial IDs to (batch_id, trial_index) by scanning CSVs.
    
    Since the clustering result contains Payload trial IDs that may not exist in
    the local database, we infer the mapping from available CSV files.
    
    Returns:
        Dict mapping trial_id (str) -> (batch_id, trial_index)
    """
    import re
    from pathlib import Path
    
    cache_dir = PROJECT_ROOT / "simulation/ros/.cache/scenario_search/records"
    pattern = re.compile(r"esmini_(\d+)_(\d+)\.csv")
    
    # First, get all available CSVs
    csv_map = {}
    if not cache_dir.exists():
        return csv_map
    
    for fname in cache_dir.iterdir():
        m = pattern.match(fname.name)
        if m:
            batch_id = int(m.group(1))
            trial_index = int(m.group(2))
            csv_map[(batch_id, trial_index)] = True
    
    print(f"  Found {len(csv_map)} CSV files across batches")
    
    # The trial IDs in clustering.json are Payload IDs
    # But we need to map them to CSV indices
    # Strategy: since we don't have the authoritative mapping, we'll use a heuristic:
    # Load the trial IDs from clustering.json in order and assign them sequentially
    # to available CSV files (sorted by batch then index)
    
    # This is a fallback - ideally we'd have the actual mapping from Payload
    # For now, return empty dict and let caller handle it
    return {}


def _get_trial_metadata(trial_id: str, csv_mapping: Dict[str, Tuple[int, int]]) -> Tuple[Optional[int], Optional[int]]:
    """Get batch_id and trial_index for a trial.
    
    Tries Payload API first, falls back to CSV-based mapping.
    
    Returns:
        Tuple of (batch_id, trial_index) or (None, None) on error
    """
    # Try Payload first
    try:
        response = requests.get(
            f"{PAYLOAD_API}/api/trials/{trial_id}",
            timeout=2,
        )
        if response.status_code == 200:
            trial_data = response.json()
            batch_id = trial_data.get("batch")
            if isinstance(batch_id, dict):
                batch_id = batch_id.get("id")
            trial_index = trial_data.get("trialIndex")
            return (int(batch_id) if batch_id else None, 
                    int(trial_index) if trial_index else None)
    except:
        pass
    
    # Fall back to CSV mapping
    if trial_id in csv_mapping:
        return csv_mapping[trial_id]
    
    return None, None


def load_clustering_data(dataset: str, n_clusters: int) -> Optional[Tuple[Dict, Dict]]:
    """Load clustering embeddings and selected result.
    
    Returns:
        Tuple of (embeddings_dict, clustering_result_dict) or None on error
    """
    dataset_dir = PROJECT_ROOT / "alldatasets" / dataset
    
    # Load main clustering.json (contains embeddings)
    embeddings_path = dataset_dir / "clustering.json"
    if not embeddings_path.exists():
        print(f"❌ ERROR: Embeddings file not found: {embeddings_path}")
        return None
    
    with embeddings_path.open() as f:
        embeddings_data = json.load(f)
    
    # Load selectedClusteringResult_*Clusters.json (contains assignments)
    result_path = dataset_dir / f"selectedClusteringResult_{n_clusters}Clusters.json"
    if not result_path.exists():
        print(f"❌ ERROR: Clustering result not found: {result_path}")
        print(f"   Available files in {dataset_dir}:")
        for p in sorted(dataset_dir.glob("selectedClusteringResult_*.json")):
            print(f"   - {p.name}")
        return None
    
    with result_path.open() as f:
        result_data = json.load(f)
    
    return embeddings_data, result_data


def _real_cluster_count(result: Dict) -> int:
    """Number of real clusters in a ClusteringResult (excludes noise label -1)."""
    return len({v["label"] for v in result.get("data", {}).values()} - {"-1"})


def _parse_analysis_zip_bytes(
    content: bytes,
    *,
    source_label: str,
    duration_mode: str,
    ego_name: str,
) -> Optional[Tuple[Dict, List, Dict, Optional[Dict]]]:
    """Unzip + navigate a saved-analysis zip to (scores, clustering_list, ego_data, selected)."""
    try:
        with zipfile.ZipFile(io.BytesIO(content)) as zf:
            zf_namelist = zf.namelist()
            json_name = next(
                (n for n in zf_namelist if n.endswith(".json") and "selected" not in n),
                None,
            )
            if json_name is None:
                json_name = next((n for n in zf_namelist if n.endswith(".json")), None)
            if json_name is None:
                print(f"❌ ERROR: No JSON file found in {source_label}")
                return None
            with zf.open(json_name) as jf:
                analysis = json.load(jf)
            selected_meta_raw: Optional[Dict] = None
            if "selected.json" in zf_namelist:
                try:
                    with zf.open("selected.json") as sf:
                        selected_meta_raw = json.load(sf)
                except Exception as exc:
                    print(f"⚠️  Could not read selected.json: {exc}")
    except Exception as exc:
        print(f"❌ ERROR: Failed to parse zip from {source_label}: {exc}")
        return None

    ego_data = analysis.get(ego_name)
    if ego_data is None:
        print(
            f"❌ ERROR: ego '{ego_name}' not in saved analysis. "
            f"Available: {list(analysis.keys())}"
        )
        return None

    mfpca_all = ego_data.get("mfpca", {})
    if duration_mode not in mfpca_all:
        print(
            f"❌ ERROR: duration_mode '{duration_mode}' not in mfpca. "
            f"Available: {list(mfpca_all.keys())}"
        )
        return None

    mfpca = mfpca_all[duration_mode]
    scores = mfpca.get("scores", {})
    clustering_list = [c for c in mfpca.get("clustering", []) if c is not None]

    if not scores:
        print("❌ ERROR: mfpca.scores is empty — no embeddings found.")
        return None
    if not clustering_list:
        print("❌ ERROR: mfpca.clustering is empty — no clustering results found.")
        return None

    return scores, clustering_list, ego_data, selected_meta_raw


def _fetch_payload_analysis(
    batch_id: int,
    save_doc_id: Optional[int] = None,
    duration_mode: str = "full",
    ego_name: str = "ITRI",
    analysis_zip: Optional[str] = None,
) -> Optional[Tuple[Dict, List, Dict, Optional[Dict]]]:
    """Fetch + parse a saved Dashboard analysis zip from Payload or a local path.

    Returns (scores, clustering_list, ego_data, selected_meta_raw) or None on error.
    Shared by load_clustering_from_payload_save() and list_clusterings_from_payload_save().

    When *analysis_zip* is set, skip Payload download and read that file directly
    (paper casestudy mirror / offline Path A).
    """
    if analysis_zip:
        zip_path = Path(analysis_zip)
        if not zip_path.is_file():
            print(f"❌ ERROR: --analysis-zip not found: {zip_path}")
            return None
        print(f"  Using local analysis zip: {zip_path}")
        try:
            content = zip_path.read_bytes()
        except OSError as exc:
            print(f"❌ ERROR: Could not read {zip_path}: {exc}")
            return None
        return _parse_analysis_zip_bytes(
            content,
            source_label=str(zip_path),
            duration_mode=duration_mode,
            ego_name=ego_name,
        )

    # 1. Fetch batch to get saved analysis document list
    try:
        resp = requests.get(
            f"{PAYLOAD_API}/api/batches/{batch_id}",
            params={"depth": 1},
            timeout=10,
        )
        resp.raise_for_status()
        batch_doc = resp.json()
    except Exception as exc:
        print(f"❌ ERROR: Could not fetch batch {batch_id} from Payload: {exc}")
        return None

    saves = batch_doc.get("savedTrajectoryAnalysis") or []
    if not saves:
        print(f"❌ ERROR: Batch {batch_id} has no savedTrajectoryAnalysis documents.")
        print("   Run Dashboard → Explore → Saves → Analysis, then press 'save'.")
        return None

    # 2. Select document (explicit id or latest by id)
    if save_doc_id is not None:
        doc = next((s for s in saves if isinstance(s, dict) and s.get("id") == save_doc_id), None)
        if doc is None:
            print(f"❌ ERROR: Document id {save_doc_id} not found in batch {batch_id} saves.")
            print(f"   Available: {[s.get('id') if isinstance(s, dict) else s for s in saves]}")
            return None
    else:
        doc = max(
            (s for s in saves if isinstance(s, dict)),
            key=lambda s: s.get("id", 0),
            default=None,
        )
        if doc is None:
            print("❌ ERROR: savedTrajectoryAnalysis entries are not document objects (depth issue).")
            return None

    doc_url = doc.get("url")
    doc_filename = doc.get("filename", "?")
    print(f"  Using saved analysis: doc id={doc.get('id')} filename={doc_filename}")
    if not doc_url:
        print(f"❌ ERROR: Document has no url field: {doc}")
        return None

    # 3. Download zip
    try:
        dl = requests.get(doc_url, timeout=60)
        dl.raise_for_status()
    except Exception as exc:
        print(f"❌ ERROR: Could not download {doc_url}: {exc}")
        return None

    return _parse_analysis_zip_bytes(
        dl.content,
        source_label=doc_filename,
        duration_mode=duration_mode,
        ego_name=ego_name,
    )


def _collision_flags_from_ego(ego_data: Dict) -> Dict[str, bool]:
    """Build a ``{payload_trial_id: collided_bool}`` map from the saved analysis.

    The Dashboard stores collision as a per-trial criticality KPI at
    ``trials[tid].testObjectives.criticalityMetrics[name=="collision"].value``
    (0 = no collision, ≥1 = collision). This mirrors the legacy
    ``alldatasets/<dataset>/collision.json`` file so the payload-save path can feed
    the same ``build_collision_cluster_stats`` / ``trial_collision_flag`` helpers.
    """
    flags: Dict[str, bool] = {}
    trials = ego_data.get("trials") or {}
    for tid, t_info in trials.items():
        if not isinstance(t_info, dict):
            continue
        cms = ((t_info.get("testObjectives") or {}).get("criticalityMetrics")) or []
        for m in cms:
            if not isinstance(m, dict):
                continue
            kpi = m.get("keyPerformanceIndicator") or {}
            if kpi.get("name") == "collision":
                val = m.get("value")
                try:
                    flags[str(tid)] = float(val) > 0.0
                except (TypeError, ValueError):
                    flags[str(tid)] = bool(val)
                break
    return flags


def _cluster_metric_stats_from_ego(
    ego_data: Dict, result_data: Dict
) -> Dict[str, Dict[str, Any]]:
    """Per-cluster aggregate of TTC / SPrET / parameter ranges from the saved analysis.

    Returns ``{label_str: {mean_ttc, min_ttc, mean_spret, parameter_ranges}}``.
    Collision is handled separately by ``build_collision_cluster_stats``; this fills
    the metrics that were previously left ``n/a`` in the ``results/`` builder layout.
    Missing pieces degrade gracefully (e.g. no ``parameters`` → empty ranges).
    """
    from collections import defaultdict

    trials = ego_data.get("trials") or {}
    assignments = (result_data or {}).get("data", {}) or {}

    param_id_to_name: Dict[str, str] = {}
    sp = (
        (ego_data.get("scenario") or {}).get("parameters")
        or ego_data.get("parameters")
        or []
    )
    for p in sp:
        if not isinstance(p, dict):
            continue
        pid = p.get("id") or p.get("parameterId")
        if pid is not None:
            param_id_to_name[str(pid)] = p.get("name") or str(pid)

    ttc: Dict[str, List[float]] = defaultdict(list)
    spret: Dict[str, List[float]] = defaultdict(list)
    params: Dict[str, Dict[str, List[float]]] = defaultdict(lambda: defaultdict(list))

    for tid, item in assignments.items():
        label = item.get("label") if isinstance(item, dict) else item
        if label is None or str(label) == "-1":
            continue
        lb = str(label)
        t = trials.get(str(tid)) or trials.get(tid)
        if not isinstance(t, dict):
            continue
        for m in ((t.get("testObjectives") or {}).get("criticalityMetrics") or []):
            if not isinstance(m, dict):
                continue
            kpi = (m.get("keyPerformanceIndicator") or {}).get("name", "")
            val = m.get("value")
            if val is None:
                continue
            try:
                fval = float(val)
            except (TypeError, ValueError):
                continue
            if kpi == "ttc_min":
                ttc[lb].append(fval)
            elif kpi == "spret_min":
                spret[lb].append(min(fval, 9.0))
        for tp in (t.get("parameters") or []):
            if not isinstance(tp, dict):
                continue
            pid = str(tp.get("parameterId", ""))
            name = param_id_to_name.get(pid, pid or "param")
            try:
                params[lb][name].append(float(tp.get("value", 0)))
            except (TypeError, ValueError):
                continue

    out: Dict[str, Dict[str, Any]] = {}
    for lb in set(ttc) | set(spret) | set(params):
        pr = {
            k: [float(min(v)), float(max(v))]
            for k, v in params[lb].items()
            if v
        }
        out[lb] = {
            "mean_ttc": round(float(np.mean(ttc[lb])), 3) if ttc[lb] else None,
            "min_ttc": round(float(np.min(ttc[lb])), 3) if ttc[lb] else None,
            "mean_spret": round(float(np.mean(spret[lb])), 3) if spret[lb] else None,
            "parameter_ranges": pr,
        }
    return out


def _parse_silhouette_from_dirname(dirname: str) -> Optional[float]:
    m = re.search(r"_s=([\d.]+)", dirname)
    if not m:
        return None
    try:
        return float(m.group(1))
    except ValueError:
        return None


def _parse_k_from_run_dirname(dirname: str) -> Optional[int]:
    m = re.match(r"^(\d+)_cluster", dirname)
    if not m:
        return None
    try:
        return int(m.group(1))
    except ValueError:
        return None


def _run_has_from_run_artifacts(run_dir: Path) -> bool:
    return (
        (run_dir / "clustering" / "selectedClusteringResult.json").is_file()
        and (run_dir / "manifest.json").is_file()
    )


def _list_complete_runs(parent: Path, k: Optional[int] = None) -> List[Path]:
    """Complete ``--from-run`` candidates under *parent* (optionally filtered by k)."""
    if not parent.is_dir():
        return []
    scored: List[Tuple[float, Path]] = []
    for p in parent.iterdir():
        if not p.is_dir():
            continue
        pk = _parse_k_from_run_dirname(p.name)
        if pk is None:
            continue
        if k is not None and pk != k:
            continue
        if not _run_has_from_run_artifacts(p):
            continue
        s = _parse_silhouette_from_dirname(p.name)
        scored.append((s if s is not None else -1.0, p))
    scored.sort(key=lambda x: (-x[0], x[1].name))
    return [p for _, p in scored]


def _print_available_runs(parent: Path, k: Optional[int] = None) -> None:
    avail = _list_complete_runs(parent, k=k)
    if not avail and k is not None:
        avail = _list_complete_runs(parent, k=None)
    if avail:
        print(f"   Available complete runs under {parent}:")
        for p in avail:
            print(f"     - {p}")
    else:
        print(
            f"   No complete runs (manifest.json + clustering/"
            f"selectedClusteringResult.json) under {parent}"
        )


def _batch_id_from_path(path: Path) -> Optional[int]:
    for part in path.parts:
        m = re.match(r"^batch(\d+)$", part)
        if m:
            return int(m.group(1))
    return None


def _print_fresh_build_hint(path: Path, k: Optional[int] = None) -> None:
    """Tell the user how to CREATE a run (not rebuild) when --from-run can't find one."""
    batch = _batch_id_from_path(path)
    k_arg = k if k is not None else _parse_k_from_run_dirname(path.name)
    print("   --from-run only REBUILDS an existing folder.")
    print("   To CREATE a complete LLM dataset from Payload (recommended):")
    if batch is not None and k_arg is not None:
        print(
            f"     python3 app/analyzer/src/dataset_builder.py "
            f"--batch-id {batch} --k {k_arg}"
        )
    elif batch is not None:
        print(
            f"     python3 app/analyzer/src/dataset_builder.py "
            f"--batch-id {batch} --k <k>"
        )
        print(
            f"     python3 app/analyzer/src/dataset_builder.py "
            f"--batch-id {batch} --list-clusterings"
        )
    else:
        print(
            "     python3 app/analyzer/src/dataset_builder.py "
            "--batch-id <id> --k <k>"
        )


def locate_from_run_spec(spec: str) -> Path:
    """Map a user ``--from-run`` string to an absolute path (may not exist yet)."""
    raw = Path(spec)
    if raw.is_absolute():
        return raw
    # ``results/batch2/...`` is relative to repo root, not to RESULTS_DIR itself.
    candidates = [PROJECT_ROOT / raw, Path.cwd() / raw]
    if raw.parts and raw.parts[0] != "results":
        candidates.insert(0, RESULTS_DIR / raw)
    for c in candidates:
        if c.is_dir():
            return c
    for c in candidates:
        if c.parent.is_dir():
            return c
    return candidates[0]


def resolve_from_run_path(
    spec: str,
    k: Optional[int] = None,
) -> Optional[Path]:
    """Resolve ``--from-run`` to a complete results folder.

    Accepts:
    - Exact path with ``manifest.json`` + ``clustering/selectedClusteringResult.json``
    - Prefix without silhouette, e.g. ``results/batch2/4_cluster`` → best
      ``4_cluster_s=*`` sibling (highest ``_s=``)
    - Batch folder + ``--k``, e.g. ``results/batch2`` with ``k=4`` → best k=4 run
    - Missing / incomplete ``…/N_cluster_s=…`` → best complete ``N_cluster*`` sibling

    If nothing matches, prints available runs and the fresh-build command
    (``python3 app/analyzer/src/dataset_builder.py --batch-id … --k …``).
    """
    path = locate_from_run_spec(str(spec))

    if path.is_dir() and _run_has_from_run_artifacts(path):
        return path

    # Batch root: results/batch2  → need --k (or infer from path name)
    batch_m = re.match(r"^batch(\d+)$", path.name)
    dirname_k = _parse_k_from_run_dirname(path.name)
    effective_k = k if k is not None else dirname_k

    if path.is_dir() and batch_m and effective_k is not None:
        complete = _list_complete_runs(path, k=effective_k)
        if complete:
            best = complete[0]
            print(
                f"  Resolved --from-run {path.name} --k {effective_k} → {best.name} "
                f"(highest silhouette among complete k={effective_k} runs)"
            )
            return best
        print(f"❌ ERROR: no complete k={effective_k} run under {path}")
        _print_available_runs(path, k=None)
        _print_fresh_build_hint(path, k=effective_k)
        return None

    if path.is_dir() and batch_m and effective_k is None:
        print(
            f"❌ ERROR: --from-run {path} is a batch folder; pass --k <n> "
            f"to pick the best complete run, or a full …/N_cluster_s=… path"
        )
        _print_available_runs(path, k=None)
        _print_fresh_build_hint(path, k=None)
        return None

    parent = path.parent
    if parent.is_dir() and effective_k is not None:
        complete = _list_complete_runs(parent, k=effective_k)
        if complete:
            best = complete[0]
            if path.is_dir() and not _run_has_from_run_artifacts(path):
                print(
                    f"  ⚠️  {path.name} is missing rebuild artifacts; "
                    f"using best complete k={effective_k} run: {best.name}"
                )
            elif not path.exists():
                print(
                    f"  ⚠️  {path} not found; "
                    f"using best complete k={effective_k} run: {best.name}"
                )
            elif path.resolve() != best.resolve():
                print(
                    f"  Resolved --from-run {path.name} → {best.name} "
                    f"(highest silhouette among complete k={effective_k} runs)"
                )
            return best
        print(f"❌ ERROR: no complete k={effective_k} run under {parent}")
        _print_available_runs(parent, k=None)
        _print_fresh_build_hint(path, k=effective_k)
        return None

    if path.is_dir():
        print(
            f"❌ ERROR: --from-run needs clustering/selectedClusteringResult.json "
            f"and manifest.json under {path}"
        )
        _print_available_runs(path.parent)
        _print_fresh_build_hint(path, k=effective_k)
        return None

    print(f"❌ ERROR: --from-run path not found: {path}")
    if parent.is_dir():
        _print_available_runs(parent, k=effective_k)
    _print_fresh_build_hint(path, k=effective_k)
    return None


def load_from_reference_run(
    run_dir: Path,
) -> Optional[Tuple[Dict[str, Any], List[Dict[str, Any]], Optional[float]]]:
    """Load clustering assignments + medoid list from a prior ``results/`` run."""
    run_dir = Path(run_dir)
    clustering_path = run_dir / "clustering" / "selectedClusteringResult.json"
    manifest_path = run_dir / "manifest.json"
    if not clustering_path.is_file() or not manifest_path.is_file():
        print(f"❌ ERROR: --from-run needs clustering/selectedClusteringResult.json "
              f"and manifest.json under {run_dir}")
        return None
    with clustering_path.open() as f:
        result_data = json.load(f)
    with manifest_path.open() as f:
        manifest = json.load(f)
    medoids: List[Dict[str, Any]] = []
    for c in manifest.get("clusters") or []:
        medoids.append({
            "cluster_label": str(c["label"]),
            "trial_id": str(c["trial_id"]),
            "batch_id": int(c["batch_id"]),
            "trial_index": int(c["trial_index"]),
            "size": int(c.get("size", 1)),
        })
    silhouette = _parse_silhouette_from_dirname(run_dir.name)
    if silhouette is None:
        sv = (result_data.get("scores") or {}).get("silhouetteScore")
        if isinstance(sv, (int, float)):
            silhouette = float(sv)
    print(f"  Loaded reference run: {len(medoids)} medoids, "
          f"k={manifest.get('n_clusters')}, silhouette={silhouette}")
    return result_data, medoids, silhouette


def backfill_cluster_stats_in_dir(
    results_dir: str,
    batch_id: int,
    save_doc_id: Optional[int] = None,
    k: Optional[int] = None,
    clustering_index: Optional[int] = None,
    silhouette: Optional[float] = None,
    duration_mode: str = "full",
    ego_name: str = "ITRI",
    analysis_zip: Optional[str] = None,
) -> bool:
    """Patch collision + TTC/SPrET/parameter stats into existing cluster.json files.

    Re-fetches the saved Payload analysis (same selection knobs as a build) and
    rewrites only the ``cluster`` block of each ``cluster<N>/cluster.json`` under
    *results_dir* — no BEV/labelling regeneration. Pass the same ``--k`` /
    ``--silhouette`` / ``--clustering-index`` that produced the folder.
    """
    rd = Path(results_dir)
    if not rd.is_dir():
        print(f"❌ Results dir not found: {rd}")
        return False

    clustering_data = load_clustering_from_payload_save(
        batch_id=batch_id,
        save_doc_id=save_doc_id,
        k=k,
        clustering_index=clustering_index,
        duration_mode=duration_mode,
        ego_name=ego_name,
        silhouette=silhouette,
        analysis_zip=analysis_zip,
    )
    if not clustering_data:
        return False
    _emb, result_data, trial_index_map, collision_flags, metric_stats, _trials = clustering_data

    from pipeline_imports import ensure_llm_pipeline

    ensure_llm_pipeline()
    from llm_pipeline.cluster_stats import build_collision_cluster_stats

    patched = 0
    for cdir in sorted(rd.glob("cluster*")):
        if not (cdir.is_dir() and cdir.name[len("cluster"):].isdigit()):
            continue
        cid = int(cdir.name[len("cluster"):])
        cj = resolve_path(cdir, "cluster.json", must_exist=True)
        if cj is None:
            continue
        try:
            doc = json.loads(cj.read_text(encoding="utf-8"))
        except Exception as e:
            print(f"  ⚠️  Skipping {cdir.name}: {e}")
            continue
        c = doc.get("cluster", {}) or {}
        if collision_flags and result_data:
            cs = build_collision_cluster_stats(cid, result_data, collision_flags)
            c["n_trials"] = cs.get("n_trials", c.get("n_trials"))
            c["collision_count"] = cs.get("collision_count")
            c["collision_rate"] = cs.get("collision_rate")
        ms = metric_stats.get(str(cid)) or metric_stats.get(cid) or {}
        c["mean_ttc"] = ms.get("mean_ttc")
        c["min_ttc"] = ms.get("min_ttc")
        c["mean_spret"] = ms.get("mean_spret")
        c["parameter_ranges"] = ms.get("parameter_ranges") or {}
        doc["cluster"] = c
        cj.write_text(json.dumps(doc, indent=2), encoding="utf-8")
        patched += 1
        print(
            f"  ✓ patched {cdir.name}/cluster.json "
            f"(min_ttc={c.get('min_ttc')}, params={len(c['parameter_ranges'])})"
        )

    print(f"✅ Backfilled {patched} cluster.json file(s) in {rd}")
    return patched > 0


def list_clusterings_from_payload_save(
    batch_id: int,
    save_doc_id: Optional[int] = None,
    k: Optional[int] = None,
    duration_mode: str = "full",
    ego_name: str = "ITRI",
    analysis_zip: Optional[str] = None,
) -> bool:
    """Print every clustering candidate (index, k, silhouette, task params).

    If k is given, only candidates with that real cluster count are shown.
    Returns True on success. Used by `--list-clusterings`.
    """
    fetched = _fetch_payload_analysis(
        batch_id, save_doc_id, duration_mode, ego_name, analysis_zip=analysis_zip
    )
    if fetched is None:
        return False
    scores, clustering_list, _ego_data, _sel = fetched
    print(f"  Loaded {len(scores)} trial embeddings, {len(clustering_list)} clustering candidates.\n")

    rows = []
    for idx, result in enumerate(clustering_list):
        rk = _real_cluster_count(result)
        if k is not None and rk != k:
            continue
        sc = result.get("scores", {}) or {}
        task = result.get("task", {}) or {}
        rows.append({
            "idx": idx,
            "k": rk,
            "silhouette": sc.get("silhouetteScore"),
            "minClusterSize": task.get("minClusterSize"),
            "minSamples": task.get("minSamples"),
            "epsilon": task.get("clusterSelectionEpsilon"),
            "method": task.get("clusterSelectionMethod"),
        })

    if not rows:
        print(f"  No clustering candidates{f' with k={k}' if k is not None else ''}.")
        return True

    # Sort by k, then silhouette desc — so the default --k pick is the top row per k
    rows.sort(key=lambda r: (r["k"], -(r["silhouette"] if r["silhouette"] is not None else -1.0)))

    hdr = f"{'index':>6}  {'k':>3}  {'silhouette':>11}  {'minClSize':>9}  {'minSamp':>7}  {'epsilon':>7}  method"
    print(hdr)
    print("  " + "-" * (len(hdr) + 2))
    for r in rows:
        sil = f"{r['silhouette']:.4f}" if isinstance(r["silhouette"], (int, float)) else "?"
        print(f"{r['idx']:>6}  {r['k']:>3}  {sil:>11}  "
              f"{str(r['minClusterSize']):>9}  {str(r['minSamples']):>7}  "
              f"{str(r['epsilon']):>7}  {r['method']}")
    print(f"\n  → Pick one with: --clustering-index <index>   "
          f"(or --k <k> to auto-pick the highest-silhouette row for that k)")
    return True


def load_clustering_from_payload_save(
    batch_id: int,
    save_doc_id: Optional[int] = None,
    k: Optional[int] = None,
    clustering_index: Optional[int] = None,
    duration_mode: str = "full",
    ego_name: str = "ITRI",
    silhouette: Optional[float] = None,
    analysis_zip: Optional[str] = None,
) -> Optional[Tuple[Dict, Dict, Dict, Dict]]:
    """Fetch a saved Dashboard analysis zip from Payload and extract clustering data.

    Returns (embeddings_data, result_data, trial_index_map, collision_flags) or
    None on error.

    embeddings_data: { "embeddings": { trialId: [float, ...] } }
    result_data:     { "data": { trialId: { "trialId": ..., "label": ... } } }
    trial_index_map: { trialId_str: (batch_id_int, trial_index_int) }
    collision_flags: { trialId_str: collided_bool }  (from the collision KPI)

    Either k or clustering_index must be provided (not both), unless the zip
    carries a selected.json with the user's choice.

    Pass *analysis_zip* to read a local mirror file instead of downloading from Payload.
    """
    if k is not None and clustering_index is not None:
        print("❌ ERROR: --k and --clustering-index are mutually exclusive")
        return None

    fetched = _fetch_payload_analysis(
        batch_id, save_doc_id, duration_mode, ego_name, analysis_zip=analysis_zip
    )
    if fetched is None:
        return None
    scores, clustering_list, ego_data, selected_meta_raw = fetched
    print(f"  Loaded {len(scores)} trial embeddings, {len(clustering_list)} clustering candidates.")

    # Apply selected.json if available and no CLI override
    if selected_meta_raw is not None:
        ego_sel = selected_meta_raw.get(ego_name)
        if ego_sel:
            print(f"  Found selected.json: ego={ego_name}, "
                  f"index={ego_sel.get('clusteringIndex')}, task={ego_sel.get('task')}")
            if k is None and clustering_index is None:
                ci = ego_sel.get("clusteringIndex")
                if ci is not None:
                    clustering_index = int(ci)
                    print(f"  Using clusteringIndex={clustering_index} from selected.json")

    # 6. Select one ClusteringResult
    if k is None and clustering_index is None:
        print("❌ ERROR: payload-save mode requires --k, --clustering-index, "
              "or a saved selected.json in the zip (save from Dashboard after choosing a result).")
        return None

    selected: Optional[Dict] = None
    if clustering_index is not None:
        if clustering_index < 0 or clustering_index >= len(clustering_list):
            print(f"❌ ERROR: --clustering-index {clustering_index} out of range [0, {len(clustering_list)-1}]")
            return None
        selected = clustering_list[clustering_index]
        real_k = len(set(v["label"] for v in selected["data"].values()) - {"-1"})
        print(f"  Selected clustering index={clustering_index}, k={real_k}, "
              f"silhouette={selected['scores'].get('silhouetteScore', '?'):.4f}")
    else:
        # Pick by k: find all results with exactly k real clusters (label != '-1'), then best silhouette
        candidates = []
        for idx, result in enumerate(clustering_list):
            real_labels = {v["label"] for v in result.get("data", {}).values()} - {"-1"}
            if len(real_labels) == k:
                sil = result.get("scores", {}).get("silhouetteScore", -1.0)
                candidates.append((sil, idx, result))
        if not candidates:
            available_ks = sorted(
                set(
                    len({v["label"] for v in r.get("data", {}).values()} - {"-1"})
                    for r in clustering_list
                )
            )
            print(f"❌ ERROR: No clustering result found with k={k}.")
            print(f"   Available cluster counts: {available_ks}")
            return None
        if silhouette is not None:
            # Select the k-result whose silhouette is closest to the requested value.
            best_sil, best_idx, selected = min(
                candidates,
                key=lambda c: abs((c[0] if c[0] is not None else -1.0) - silhouette),
            )
            print(f"  Selected k={k} result nearest silhouette={silhouette:.4f}: "
                  f"index={best_idx}, silhouette={best_sil:.4f}, task={selected.get('task')}")
            distinct_sils = sorted({round(c[0], 4) for c in candidates if c[0] is not None}, reverse=True)
            print(f"  (k={k} silhouettes available: {distinct_sils})")
        else:
            candidates.sort(reverse=True)
            best_sil, best_idx, selected = candidates[0]
            print(f"  Selected best k={k} result: index={best_idx}, "
                  f"silhouette={best_sil:.4f}, task={selected.get('task')}")
            if len(candidates) > 1:
                print(f"  ({len(candidates)} candidates with k={k} evaluated)")

    # 7. Build trial_index_map from esminiDat.filename
    _DAT_PAT = re.compile(r"esmini_(\d+)_(\d+)\.dat")
    trial_index_map: Dict[str, Tuple[int, int]] = {}
    trials_meta = ego_data.get("trials", {})
    for tid, t_info in trials_meta.items():
        if not isinstance(t_info, dict):
            continue
        edat = t_info.get("esminiDat")
        if not isinstance(edat, dict):
            continue
        fname = edat.get("filename", "")
        m = _DAT_PAT.match(fname)
        if m:
            trial_index_map[str(tid)] = (int(m.group(1)), int(m.group(2)))

    print(f"  Built trial→CSV map for {len(trial_index_map)} trials from esminiDat filenames.")

    # 8. Shape return values to match load_clustering_data() contract
    embeddings_data = {"embeddings": scores}
    result_data = selected
    collision_flags = _collision_flags_from_ego(ego_data)
    n_coll = sum(1 for v in collision_flags.values() if v)
    print(f"  Loaded collision KPI for {len(collision_flags)} trials "
          f"({n_coll} collided).")

    metric_stats = _cluster_metric_stats_from_ego(ego_data, result_data)
    n_with_ttc = sum(1 for s in metric_stats.values() if s.get("mean_ttc") is not None)
    print(f"  Computed per-cluster metric stats for {len(metric_stats)} clusters "
          f"({n_with_ttc} with TTC).")

    return embeddings_data, result_data, trial_index_map, collision_flags, metric_stats, ego_data.get("trials", {})


def compute_medoids(
    embeddings_data: Dict[str, Any],
    result_data: Dict[str, Any],
    dataset: Optional[str] = None,
    trial_index_map: Optional[Dict[str, Tuple[int, int]]] = None,
) -> List[Dict[str, Any]]:
    """Compute medoid trials for each cluster.
    
    Uses the same logic as controller.py get_cluster_medoids():
    For each cluster, find the trial whose embedding is closest to the centroid.
    
    Args:
        trial_index_map: Optional pre-built {trialId: (batch_id, trial_index)} from
            load_clustering_from_payload_save(). When provided, skips dataset_config
            and Payload API lookups entirely.

    Returns list of dicts with keys: cluster_label, trial_id, batch_id, trial_index, size
    """
    import numpy as np
    from sklearn.metrics import pairwise_distances_argmin
    
    embeddings_dict = embeddings_data.get("embeddings", {})
    cluster_assignments = result_data.get("data", {})
    
    if not embeddings_dict or not cluster_assignments:
        print("❌ ERROR: Missing embeddings or cluster assignments")
        return []
    
    trial_ids = []
    embeddings = []
    labels = []
    
    for trial_id, item in cluster_assignments.items():
        if trial_id not in embeddings_dict:
            continue
        trial_ids.append(trial_id)
        embeddings.append(embeddings_dict[trial_id])
        # item is either a plain label string (old alldatasets format) or a dict
        raw_label = item if isinstance(item, str) else item.get("label", str(item))
        labels.append(int(raw_label))
    
    X = np.array(embeddings, dtype=np.float64)
    labels_arr = np.array(labels, dtype=int)
    
    unique_labels = sorted(set(labels) - {-1})
    medoids = []

    csv_fallback_mapping = _build_csv_trial_mapping()
    
    def _resolve_indices(tid: str):
        # 1. Pre-built map from payload-save (fastest, no API)
        if trial_index_map and tid in trial_index_map:
            return trial_index_map[tid]
        # 2. dataset_config formula (alldatasets mode)
        if dataset:
            try:
                from dataset_config import trial_id_to_csv_indices
                return trial_id_to_csv_indices(dataset, tid)
            except Exception:
                pass
        # 3. Payload API fallback
        return _get_trial_metadata(tid, csv_fallback_mapping)

    for label in unique_labels:
        mask = labels_arr == label
        X_cluster = X[mask]
        ids_cluster = np.array(trial_ids)[mask]
        cluster_size = int(mask.sum())

        # Rank cluster trials by distance to the centroid. The true medoid is
        # the closest, but its esmini CSV may not be cached locally, so we fall
        # back to the nearest trial that DOES have a CSV (keeps dataset1 fully
        # analysable with local data).
        centroid = X_cluster.mean(axis=0)
        dists = np.linalg.norm(X_cluster - centroid, axis=1)
        order = np.argsort(dists)

        chosen = None
        for rank, idx in enumerate(order):
            cand_id = str(ids_cluster[idx])
            b, ti = _resolve_indices(cand_id)
            if b is None or ti is None:
                continue
            if not csv_exists(b, ti):
                continue
            chosen = {
                "cluster_label": str(label),
                "trial_id": cand_id,
                "batch_id": b,
                "trial_index": ti,
                "size": cluster_size,
                "medoid_rank": int(rank),  # 0 = exact medoid
                "is_exact_medoid": rank == 0,
            }
            break

        if chosen is None:
            print(f"⚠️  WARNING: cluster {label}: no trial with a local CSV "
                  f"(checked {len(order)} candidates) — skipped")
            continue
        if chosen["medoid_rank"] > 0:
            print(f"  ↪ cluster {label}: exact medoid CSV missing, using "
                  f"nearest available (rank {chosen['medoid_rank']}, "
                  f"trial {chosen['trial_id']})")
        medoids.append(chosen)

    return medoids


def compute_intra_variance_and_boundaries(
    embeddings_data: Dict[str, Any],
    result_data: Dict[str, Any],
    trial_index_map: Optional[Dict[str, Tuple[int, int]]] = None,
    collision_flags: Optional[Dict[str, bool]] = None,
    n_outliers: int = 3,
) -> Tuple[Dict[str, Dict[str, Any]], List[Dict[str, Any]]]:
    """Compute per-cluster intra variance metrics and cross-cluster boundary pairs.

    Returns:
        intra_by_cluster: label_str → {mean_dist_to_medoid, std_dist_to_medoid,
                                        max_dist_to_medoid, outlier_trial_ids,
                                        outlier_collision, boundary_neighbors, n_members}
        boundary_pairs:   sorted list of {cluster_a, trial_a, …, cluster_b, trial_b,
                                           …, embedding_dist} dicts (closest first)
    """
    embeddings_dict = embeddings_data.get("embeddings", {})
    assignments = result_data.get("data", {})

    if not embeddings_dict or not assignments:
        return {}, []

    trial_ids_list: List[str] = []
    embeds: List[List[float]] = []
    label_list: List[int] = []

    for tid, item in assignments.items():
        if tid not in embeddings_dict:
            continue
        trial_ids_list.append(tid)
        embeds.append(embeddings_dict[tid])
        raw = item if isinstance(item, str) else item.get("label", str(item))
        try:
            label_list.append(int(raw))
        except (ValueError, TypeError):
            label_list.append(-1)

    if not trial_ids_list:
        return {}, []

    trial_ids_arr = np.array(trial_ids_list)
    X = np.array(embeds, dtype=np.float64)
    labels_arr = np.array(label_list, dtype=int)
    unique_labels = sorted(set(label_list) - {-1})

    cluster_centroids: Dict[int, np.ndarray] = {}
    intra_by_cluster: Dict[str, Dict[str, Any]] = {}

    for label in unique_labels:
        mask = labels_arr == label
        X_cl = X[mask]
        ids_cl = trial_ids_arr[mask]
        centroid = X_cl.mean(axis=0)
        dists = np.linalg.norm(X_cl - centroid, axis=1)
        cluster_centroids[label] = centroid

        # outliers = furthest from centroid (most "atypical")
        order_desc = np.argsort(dists)[::-1]
        top_n = min(n_outliers, len(order_desc))
        outlier_ids = [str(ids_cl[i]) for i in order_desc[:top_n]]
        outlier_coll = [
            bool((collision_flags or {}).get(str(ids_cl[i]), False))
            for i in order_desc[:top_n]
        ]

        intra_by_cluster[str(label)] = {
            "mean_dist_to_medoid": round(float(np.mean(dists)), 4),
            "std_dist_to_medoid": round(float(np.std(dists)), 4),
            "max_dist_to_medoid": round(float(np.max(dists)), 4),
            "outlier_trial_ids": outlier_ids,
            "outlier_collision": outlier_coll,
            "boundary_neighbors": {},
            "n_members": int(mask.sum()),
        }

    # Cross-cluster boundary pairs: for each (A, B) find the nearest trial pair
    # across the cluster boundary (smallest L2 distance in embedding space).
    boundary_pairs: List[Dict[str, Any]] = []
    processed: set = set()

    for a in unique_labels:
        X_a = X[labels_arr == a]
        ids_a = trial_ids_arr[labels_arr == a]
        for b in unique_labels:
            if b <= a or (a, b) in processed:
                continue
            processed.add((a, b))
            X_b = X[labels_arr == b]
            ids_b = trial_ids_arr[labels_arr == b]

            # (na, nb) pairwise distance matrix
            diff = X_a[:, np.newaxis, :] - X_b[np.newaxis, :, :]
            pdists = np.linalg.norm(diff, axis=2)
            ia, ib = np.unravel_index(int(np.argmin(pdists)), pdists.shape)
            min_dist = float(pdists[ia, ib])

            ta, tb = str(ids_a[ia]), str(ids_b[ib])
            coll_a = bool((collision_flags or {}).get(ta, False))
            coll_b = bool((collision_flags or {}).get(tb, False))
            dist_a = round(float(np.linalg.norm(X_a[ia] - cluster_centroids[a])), 4)
            dist_b = round(float(np.linalg.norm(X_b[ib] - cluster_centroids[b])), 4)

            boundary_pairs.append({
                "cluster_a": a,
                "trial_a": ta,
                "dist_a_to_centroid": dist_a,
                "collided_a": coll_a,
                "cluster_b": b,
                "trial_b": tb,
                "dist_b_to_centroid": dist_b,
                "collided_b": coll_b,
                "embedding_dist": round(min_dist, 4),
            })
            intra_by_cluster[str(a)]["boundary_neighbors"][str(b)] = ta
            intra_by_cluster[str(b)]["boundary_neighbors"][str(a)] = tb

    boundary_pairs.sort(key=lambda p: p["embedding_dist"])

    n_bp = len(boundary_pairs)
    print(f"  📐 Intra-variance computed for {len(unique_labels)} clusters, "
          f"{n_bp} boundary pair(s)")
    return intra_by_cluster, boundary_pairs


def _build_trial_parameter_matrix(
    trials_meta: Dict[str, Any],
    result_data: Dict[str, Any],
    ego_scenario_params: Optional[List[Dict[str, Any]]] = None,
) -> Tuple[List[str], np.ndarray, np.ndarray, List[str]]:
    """Build per-trial initial-condition vectors from Payload trial parameters.

    Returns ``(trial_ids, X, labels, param_names)`` where ``X`` is z-scored
    (columns with zero variance stay zero). Trials missing any parameter are skipped.
    """
    assignments = (result_data or {}).get("data", {}) or {}
    param_id_to_name: Dict[str, str] = {}
    for p in ego_scenario_params or []:
        if not isinstance(p, dict):
            continue
        pid = p.get("id") or p.get("parameterId")
        if pid is not None:
            param_id_to_name[str(pid)] = p.get("name") or str(pid)

    # First pass: collect raw {tid: {name: value}} and discover names.
    raw: Dict[str, Dict[str, float]] = {}
    labels_map: Dict[str, int] = {}
    name_set: set = set()

    for tid, item in assignments.items():
        raw_label = item if isinstance(item, str) else item.get("label", str(item))
        try:
            label_i = int(raw_label)
        except (ValueError, TypeError):
            label_i = -1
        if label_i < 0:
            continue
        t = trials_meta.get(str(tid)) or trials_meta.get(tid)
        if not isinstance(t, dict):
            continue
        vals: Dict[str, float] = {}
        for tp in (t.get("parameters") or []):
            if not isinstance(tp, dict):
                continue
            pid = str(tp.get("parameterId", tp.get("id", "")))
            name = param_id_to_name.get(pid) or tp.get("name") or (pid or "param")
            try:
                vals[str(name)] = float(tp.get("value", 0))
            except (TypeError, ValueError):
                continue
        if not vals:
            continue
        raw[str(tid)] = vals
        labels_map[str(tid)] = label_i
        name_set.update(vals.keys())

    param_names = sorted(name_set)
    if not param_names or not raw:
        return [], np.zeros((0, 0)), np.zeros((0,), dtype=int), []

    trial_ids: List[str] = []
    rows: List[List[float]] = []
    labels: List[int] = []
    for tid, vals in raw.items():
        if any(n not in vals for n in param_names):
            continue
        trial_ids.append(tid)
        rows.append([vals[n] for n in param_names])
        labels.append(labels_map[tid])

    if not trial_ids:
        return [], np.zeros((0, 0)), np.zeros((0,), dtype=int), param_names

    X = np.asarray(rows, dtype=np.float64)
    # Z-score each parameter so delay (s) and speed (m/s) are comparable.
    std = X.std(axis=0)
    mean = X.mean(axis=0)
    std_safe = np.where(std < 1e-12, 1.0, std)
    X = (X - mean) / std_safe
    return trial_ids, X, np.asarray(labels, dtype=int), param_names


def compute_parameter_space_boundaries(
    trials_meta: Dict[str, Any],
    result_data: Dict[str, Any],
    collision_flags: Optional[Dict[str, bool]] = None,
    ego_scenario_params: Optional[List[Dict[str, Any]]] = None,
) -> List[Dict[str, Any]]:
    """Closest cross-cluster trial pairs in Parameter Space (initial conditions).

    Distance is L2 on z-scored scenario parameters (e.g. OncomingStartDelay,
    OncomingSpeed). Separate from MFPCA embedding ``boundary_pairs``.
    """
    trial_ids, X, labels_arr, param_names = _build_trial_parameter_matrix(
        trials_meta, result_data, ego_scenario_params=ego_scenario_params,
    )
    if len(trial_ids) == 0 or X.size == 0:
        print("  ⚠️  Parameter-space boundaries skipped (no trial parameters)")
        return []

    unique_labels = sorted(set(int(x) for x in labels_arr.tolist()) - {-1})
    trial_ids_arr = np.asarray(trial_ids)
    cluster_centroids: Dict[int, np.ndarray] = {}
    for label in unique_labels:
        mask = labels_arr == label
        cluster_centroids[label] = X[mask].mean(axis=0)

    pairs: List[Dict[str, Any]] = []
    processed: set = set()
    for a in unique_labels:
        X_a = X[labels_arr == a]
        ids_a = trial_ids_arr[labels_arr == a]
        for b in unique_labels:
            if b <= a or (a, b) in processed:
                continue
            processed.add((a, b))
            X_b = X[labels_arr == b]
            ids_b = trial_ids_arr[labels_arr == b]
            diff = X_a[:, np.newaxis, :] - X_b[np.newaxis, :, :]
            pdists = np.linalg.norm(diff, axis=2)
            ia, ib = np.unravel_index(int(np.argmin(pdists)), pdists.shape)
            min_dist = float(pdists[ia, ib])
            ta, tb = str(ids_a[ia]), str(ids_b[ib])
            pairs.append({
                "cluster_a": a,
                "trial_a": ta,
                "dist_a_to_centroid": round(
                    float(np.linalg.norm(X_a[ia] - cluster_centroids[a])), 4
                ),
                "collided_a": bool((collision_flags or {}).get(ta, False)),
                "cluster_b": b,
                "trial_b": tb,
                "dist_b_to_centroid": round(
                    float(np.linalg.norm(X_b[ib] - cluster_centroids[b])), 4
                ),
                "collided_b": bool((collision_flags or {}).get(tb, False)),
                "param_dist": round(min_dist, 4),
                "param_names": param_names,
            })

    pairs.sort(key=lambda p: p["param_dist"])
    print(
        f"  📐 Parameter-space boundaries: {len(pairs)} pair(s) "
        f"over {param_names}"
    )
    return pairs


def attach_param_boundary_neighbors(
    intra_by_cluster: Dict[str, Dict[str, Any]],
    param_boundary_pairs: List[Dict[str, Any]],
) -> None:
    """Write ``param_boundary_neighbors`` for IC-matched pairs only."""
    for iv in intra_by_cluster.values():
        iv.setdefault("param_boundary_neighbors", {})
    for bp in param_boundary_pairs:
        if bp.get("ic_match") is False:
            continue
        a, b = str(bp["cluster_a"]), str(bp["cluster_b"])
        if a in intra_by_cluster:
            intra_by_cluster[a].setdefault("param_boundary_neighbors", {})[b] = str(
                bp["trial_a"]
            )
        if b in intra_by_cluster:
            intra_by_cluster[b].setdefault("param_boundary_neighbors", {})[a] = str(
                bp["trial_b"]
            )


def patch_cluster_json_param_neighbors(
    run_dir: Path,
    param_boundary_pairs: List[Dict[str, Any]],
) -> int:
    """Update existing cluster.json files with param_boundary_neighbors (aux-only rebuilds).

    Returns the number of cluster.json files patched.
    """
    neighbors: Dict[str, Dict[str, str]] = {}
    for bp in param_boundary_pairs:
        if bp.get("ic_match") is False:
            continue
        a, b = str(bp["cluster_a"]), str(bp["cluster_b"])
        neighbors.setdefault(a, {})[b] = str(bp["trial_a"])
        neighbors.setdefault(b, {})[a] = str(bp["trial_b"])
    patched = 0
    for label, neigh in neighbors.items():
        cj_path = resolve_path(run_dir / f"cluster{label}", "cluster.json", must_exist=True)
        if cj_path is None:
            continue
        try:
            doc = json.loads(cj_path.read_text(encoding="utf-8"))
            cluster = doc.setdefault("cluster", {})
            intra = cluster.setdefault("intra_variance", {})
            intra["param_boundary_neighbors"] = neigh
            cj_path.write_text(json.dumps(doc, indent=2), encoding="utf-8")
            patched += 1
        except Exception as exc:
            print(f"  ⚠️  Could not patch cluster{label}/cluster.json: {exc}")
    return patched


def build_run_manifest(
    dataset: str,
    n_clusters: int,
    medoids: List[Dict[str, Any]],
    run_id: str,
    batch_id: Optional[int] = None,
    boundary_pairs: Optional[List[Dict[str, Any]]] = None,
    param_boundary_pairs: Optional[List[Dict[str, Any]]] = None,
) -> Dict[str, Any]:
    """Create the top-level manifest.json for this run."""
    manifest: Dict[str, Any] = {
        "run_id": run_id,
        "timestamp": datetime.utcnow().isoformat() + "Z",
        "dataset": dataset,
        "batch_id": batch_id,
        "n_clusters": n_clusters,
        "medoid_count": len(medoids),
        "clusters": [
            {
                "label": m["cluster_label"],
                "trial_id": m["trial_id"],
                "batch_id": m["batch_id"],
                "trial_index": m["trial_index"],
                "size": m["size"],
            }
            for m in medoids
        ],
    }
    if boundary_pairs is not None:
        manifest["boundary_pairs"] = boundary_pairs
    if param_boundary_pairs is not None:
        manifest["param_boundary_pairs"] = param_boundary_pairs
    return manifest


def _df_to_observations(df: "pd.DataFrame") -> List[Dict[str, Any]]:
    """Convert esmini CSV DataFrame to Payload-style observations.
    
    Each observation is a dict with ego fields + agents list.
    """
    observations = []
    
    # Get unique timestamps
    times = sorted(df["time"].unique())
    
    for t in times:
        frame = df[df["time"] == t]
        
        # Find ego row
        ego_row = frame[frame["name"] == "Ego"]
        if ego_row.empty:
            continue  # Skip frames without ego
        
        ego = ego_row.iloc[0]
        
        # Build observation dict
        obs = {
            "time": float(t),
            "egoX": float(ego["x"]),
            "egoY": float(ego["y"]),
            "egoYaw": float(ego["h"]),
            "egoSpeed": float(ego["speed"]),
            "egoRoadId": int(ego["roadId"]),
            "egoLaneId": int(ego["laneId"]),
            "egoS": float(ego["s"]),
            "egoLaneOffset": float(ego["offset"]),
            "agents": [],
        }
        
        # Add agent rows
        agent_rows = frame[frame["name"] != "Ego"]
        for _, ag in agent_rows.iterrows():
            obs["agents"].append({
                "name": str(ag["name"]),
                "x": float(ag["x"]),
                "y": float(ag["y"]),
                "yaw": float(ag["h"]),
                "speed": float(ag["speed"]),
                "roadId": int(ag["roadId"]),
                "laneId": int(ag["laneId"]),
                "s": float(ag["s"]),
                "laneOffset": float(ag["offset"]),
            })
        
        observations.append(obs)
    
    return observations


def build_bev_typography(args: argparse.Namespace):
    """Build ``BevTypography`` from dataset_builder CLI args."""
    from map_plotter import BevTypography

    return BevTypography(
        road_label_size=args.road_label_size,
        lane_label_size=args.lane_label_size,
        road_label_plain_size=args.road_label_plain_size,
        agent_id_fontsize=args.agent_id_size,
        info_fontsize=args.info_font_size,
        title_fontsize=args.title_font_size,
        scale_bar_fontsize=args.scale_bar_font_size,
        scale_bar_y=args.scale_bar_y,
        scale_bar_max_width_frac=args.scale_bar_max_width_frac,
        scale_bar_min_width_frac=args.scale_bar_min_width_frac,
        metric_chip_fontsize=args.metric_chip_font_size,
        panel_label_fontsize=args.panel_label_font_size,
        road_label_avoid_m=args.road_label_avoid_m,
    )


def parse_cluster_scope(spec: str) -> Optional[Set[str]]:
    """Parse ``all`` / ``none`` / ``0,2`` cluster scope.

    Returns:
      None  → all clusters
      set() → none
      {.. } → only those cluster label strings
    """
    s = (spec or "all").strip().lower()
    if s in ("all", "*", "yes"):
        return None
    if s in ("none", "off", "no", "-"):
        return set()
    out = {p.strip() for p in s.replace(" ", "").split(",") if p.strip() != ""}
    return out


def cluster_in_scope(label: Any, scope: Optional[Set[str]]) -> bool:
    if scope is None:
        return True
    return str(label) in scope


def write_context_md(
    cluster_dir: Path,
    cluster_doc: Optional[Dict[str, Any]],
    action_data: Optional[Dict[str, Any]],
    selection: Any = None,
    snap_filenames: Optional[List[str]] = None,
    traj_df: Any = None,
    map_tracks_csv: Optional[str] = None,
) -> None:
    """Write LLM ``processed/context.md``: header + unified conflict timeline.

    Same-lane TURN_LEFT/RIGHT live in ``action.yaml`` and appear in the
    timeline (not a separate heading section). Agent-action tables stay in
    human ``description.txt``. ``traj_df`` is accepted for API compatibility.
    """
    from conflict_frame_selector import format_conflict_timeline_sentences

    cd = cluster_doc or {}
    c = cd.get("cluster", {})
    m = cd.get("medoid", {})
    s = cd.get("scene", {})

    lines: List[str] = []
    label = c.get("label", cluster_dir.name.replace("cluster", ""))
    sil = c.get("silhouette")
    sil_str = f"{sil:.4f}" if isinstance(sil, (int, float)) else "n/a"
    lines.append(f"# Cluster {label}")
    lines.append("")
    lines.append(
        f"- **Representativeness**: medoid of {c.get('size', '?')} similar trials "
        f"(k={c.get('n_clusters', '?')}, silhouette={sil_str})"
    )
    lines.append(
        f"- **Medoid trial**: id={m.get('trial_id', '?')}, batch={m.get('batch_id', '?')}, "
        f"esmini index={m.get('trial_index', '?')}"
        + ("" if m.get("is_exact_medoid", True) else f" (nearest available, rank {m.get('medoid_rank')})")
    )
    if c.get("collision_rate") is not None:
        lines.append(
            f"- **Collisions**: {c.get('collision_count')}/{c.get('n_trials')} trials "
            f"({c.get('collision_rate')}%)"
        )
    lines.append(
        f"- **Map**: {s.get('location', '?')}, duration {s.get('duration_seconds', '?')}s, "
        f"{s.get('frame_count', '?')} frames"
    )
    agents = s.get("agents", [])
    if agents:
        ag_str = ", ".join(
            f"{a.get('name')} ({a.get('class')})" for a in agents
        )
        lines.append(f"- **Agents**: {ag_str}")
    lines.append("")

    if selection is not None and getattr(selection, "frames", None):
        lines.append(
            format_conflict_timeline_sentences(
                selection,
                filenames=snap_filenames,
                action_data=action_data,
                traj_df=traj_df,
                map_tracks_csv=map_tracks_csv,
            ).rstrip()
        )
        lines.append("")

    write_path(cluster_dir, "context.md").write_text(
        "\n".join(lines), encoding="utf-8"
    )


def process_medoid(
    medoid: Dict[str, Any],
    run_dir: Path,
    xodr_path: Path,
    parser: XodrParser,
    dataset_name: str = "dataset1",
    snapshot_output_px: int = 1024,
    snapshot_border_frac: float = 0.10,
    typography=None,
    max_snapshots: Optional[int] = None,
    collision_flags: Optional[Dict[str, bool]] = None,
    cluster_collision_stats: Optional[Dict[str, Any]] = None,
    n_clusters: Optional[int] = None,
    silhouette: Optional[float] = None,
    ego_zoom_radius: float = 30.0,
    trials_meta: Optional[Dict[str, Any]] = None,
    contact_clearance_m: float = 0.5,
    conflict_relevance_m: float = 5.0,
    intra_variance: Optional[Dict[str, Any]] = None,
    conflict_window_s: Optional[float] = None,
    conflict_window_before_s: float = 15.0,
    conflict_window_after_s: float = 8.0,
) -> bool:
    """Process a single medoid trial: generate all required files.
    
    Returns True on success, False on failure.
    """
    from map_plotter import DEFAULT_BEV_TYPOGRAPHY

    if typography is None:
        typography = DEFAULT_BEV_TYPOGRAPHY

    label = medoid["cluster_label"]
    batch_id = medoid["batch_id"]
    trial_index = medoid["trial_index"]
    
    print(f"\n🔹 Processing cluster {label} (batch {batch_id}, trial {trial_index})")
    
    cluster_dir = run_dir / f"cluster{label}"
    cluster_dir.mkdir(parents=True, exist_ok=True)
    # Preserve any flat LLM YAMLs into output/ before rewriting raw/processed.
    moved = migrate_flat_to_nested(cluster_dir)
    if moved:
        print(f"  ✓ Migrated flat artifacts: {', '.join(moved)}")
    ht_moved = migrate_highlight_trials(cluster_dir)
    if ht_moved:
        print(f"  ✓ Migrated highlight trials: {', '.join(ht_moved)}")
    ensure_layout(cluster_dir)

    # 1. Check if CSV exists
    if not csv_exists(batch_id, trial_index):
        print(f"  ❌ CSV not found for batch {batch_id} trial {trial_index}")
        return False
    
    # 2. Load ground truth from CSV
    df = get_csv_road_data(batch_id, trial_index)
    if df is None or df.empty:
        print(f"  ❌ Failed to load CSV data")
        return False
    
    print(f"  ✓ Loaded {len(df)} frames from CSV")
    
    # 3. Convert DataFrame to Payload-style observations
    try:
        observations = _df_to_observations(df)
        print(f"  ✓ Converted {len(observations)} timesteps to observation format")
    except Exception as e:
        print(f"  ❌ Failed to convert DataFrame: {e}")
        del df
        return False
    
    # 4. Build trajectory.csv in xosc_gen format
    trajectory_path = write_path(cluster_dir, "trajectory.csv")
    try:
        registry = build_trajectory_csv(observations, parser, trajectory_path)
        print(f"  ✓ Generated trajectory.csv")
    except Exception as e:
        print(f"  ❌ Failed to build trajectory.csv: {e}")
        del df
        return False
    
    # 5. Build meta.yaml (intermediate input for the labeller; removed from output later)
    location_for_meta = Path(xodr_path).stem
    meta_path = write_path(cluster_dir, "meta.yaml")
    try:
        build_meta_yaml(
            registry,
            observations,
            meta_path,
            dataset="gpl-odd-simulated",
            location=location_for_meta,
        )
        print(f"  ✓ Generated meta.yaml (intermediate)")
    except Exception as e:
        print(f"  ❌ Failed to build meta.yaml: {e}")
        del df
        return False
    
    # 6. Action labelling (xosc_gen Step 1) then description prose (Step 2).
    #    BEV (Step 2.5) must follow — timestamps come only from action.yaml.
    from pipeline_imports import ensure_llm_pipeline

    ensure_llm_pipeline()
    from llm_pipeline.cluster_stats import trial_collision_flag

    action_data_for_ctx: Optional[Dict[str, Any]] = None
    traj_for_desc = None
    trial_id = str(medoid.get("trial_id") or "")
    medoid_collided = trial_collision_flag(collision_flags or {}, trial_id) or bool(
        medoid.get("collided")
    )
    trial_info = (trials_meta or {}).get(trial_id) if trials_meta else None
    trial_events = trial_info.get("events") if isinstance(trial_info, dict) else None
    action_yaml_path = write_path(cluster_dir, "action.yaml")
    desc_path = write_path(cluster_dir, "description.txt")
    try:
        from labeller import label_trajectory, save_action_yaml
        from description import build_description, save_description_txt
        from dataset_config import map_tracks_path_for_dataset

        map_yaml = RESULTS_DIR / "map" / f"{Path(xodr_path).stem}.yaml"
        action_data = label_trajectory(
            trajectory_path,
            meta_path,
            map_yaml if map_yaml.is_file() else None,
            esmini_df=df,
            trial_events=trial_events,
            collided=medoid_collided,
            contact_clearance_m=contact_clearance_m,
            conflict_relevance_m=conflict_relevance_m,
        )
        action_data_for_ctx = action_data
        save_action_yaml(action_data, action_yaml_path)
        # Enrich tables from labelled trajectory.csv (not raw esmini columns).
        traj_for_desc = pd.read_csv(trajectory_path)
        map_tracks_csv = map_tracks_path_for_dataset(dataset_name)
        save_description_txt(
            build_description(
                action_data,
                traj_df=traj_for_desc,
                map_tracks_csv=str(map_tracks_csv) if map_tracks_csv.is_file() else None,
            ),
            desc_path,
        )
        if not map_yaml.is_file():
            print("  ⚠️  action/description built WITHOUT junction info — run "
                  "map assets first (--map-only)")
        print(f"  ✓ Generated action.yaml + description.txt (prose)")
    except Exception as e:
        print(f"  ⚠️  Action/description generation failed: {e}")
        traj_for_desc = None

    # 7. BEV snapshots from action.yaml timestamps only (xosc_gen Step 2.5)
    snaps_out = nested_snapshots_dir(cluster_dir)
    proc_dir = processed_dir(cluster_dir)
    selection_bundle: list = []
    map_tracks = None
    map_tracks_for_ctx: Optional[str] = None
    try:
        from tier2_renderer import (
            Tier2BevRenderer,
            resolve_tier2_paths,
        )

        _xodr, map_tracks, location = resolve_tier2_paths(dataset_name)
        if map_tracks.is_file():
            map_tracks_for_ctx = str(map_tracks)
        if map_tracks.is_file():
            if not action_yaml_path.is_file():
                raise FileNotFoundError("action.yaml missing — cannot render BEV")
            tier2 = Tier2BevRenderer(
                str(map_tracks),
                str(xodr_path if xodr_path.is_file() else _xodr),
                location=location,
                dataset_name=dataset_name,
                snapshot_output_px=snapshot_output_px,
                snapshot_border_frac=snapshot_border_frac,
                typography=typography,
                ego_zoom_radius=ego_zoom_radius,
            )
            snaps_out.mkdir(parents=True, exist_ok=True)
            snaps = tier2.render_trial_from_esmini_csv(
                batch_id,
                trial_index,
                str(snaps_out),
                n_snapshots=max_snapshots,
                file_prefix=f"trial_{trial_index}",
                overview_dir=str(proc_dir),
                action_yaml_path=str(action_yaml_path),
                conflict_window_s=conflict_window_s,
                conflict_window_before_s=conflict_window_before_s,
                conflict_window_after_s=conflict_window_after_s,
                selection_out=selection_bundle,
            )
            print(f"  ✓ Generated {len(snaps)} action-derived BEV snapshots")
            print(f"  ✓ map_overview.jpg")
        else:
            print("  ⚠️  BEV skipped — run dataset_builder.py --batch-id <n> --map-only")
    except Exception as e:
        print(f"  ⚠️  BEV generation failed: {e}")

    # 7b. Human description: optional short BEV filename list (no metrics table).
    if action_data_for_ctx is not None:
        try:
            from description import build_description, save_description_txt
            from conflict_frame_selector import format_bev_frame_index

            evidence = None
            if len(selection_bundle) >= 2:
                evidence = format_bev_frame_index(
                    selection_bundle[0], selection_bundle[1]
                )
            save_description_txt(
                build_description(
                    action_data_for_ctx,
                    snapshot_evidence=evidence,
                    traj_df=traj_for_desc,
                    map_tracks_csv=(
                        str(map_tracks)
                        if (map_tracks is not None and map_tracks.is_file())
                        else None
                    ),
                ),
                desc_path,
            )
            print(
                f"  ✓ Updated description.txt"
                + (" (with BEV frame index)" if evidence else "")
            )
        except Exception as e:
            print(f"  ⚠️  description.txt failed: {e}")
    
    # 8. Consolidated cluster.json (merges old meta.yaml + medoid.json + stats.json).
    #    observations.json is no longer written — trajectory.csv is the single raw timeline.
    try:
        from collision_partner import collision_interaction_to_medoid_doc

        duration = (observations[-1]["time"] - observations[0]["time"]) if observations else 0
        agent_names = [ag.name for ag in registry if ag.name != "Ego"]
        cc = cluster_collision_stats or {}
        collision_iv = None
        if action_data_for_ctx:
            for iv in action_data_for_ctx.get("interactions") or []:
                if iv.get("type") == "COLLISION":
                    collision_iv = iv
                    break
        collision_doc = collision_interaction_to_medoid_doc(collision_iv)
        medoid_block = {
            "trial_id": medoid.get("trial_id"),
            "batch_id": batch_id,
            "trial_index": trial_index,
            "medoid_rank": medoid.get("medoid_rank", 0),
            "is_exact_medoid": medoid.get("is_exact_medoid", True),
            "collided": medoid_collided,
        }
        if collision_doc:
            medoid_block["collision"] = collision_doc
        cluster_blk: Dict[str, Any] = {
            "label": label,
            "size": medoid["size"],
            "n_trials": cc.get("n_trials", medoid["size"]),
            "n_clusters": n_clusters,
            "silhouette": round(float(silhouette), 4) if silhouette is not None else None,
            "collision_count": cc.get("collision_count"),
            "collision_rate": cc.get("collision_rate"),
            "mean_ttc": cc.get("mean_ttc"),
            "min_ttc": cc.get("min_ttc"),
            "mean_spret": cc.get("mean_spret"),
            "parameter_ranges": cc.get("parameter_ranges") or {},
        }
        if intra_variance is not None:
            cluster_blk["intra_variance"] = intra_variance
        cluster_doc = {
            "cluster": cluster_blk,
            "medoid": medoid_block,
            "scene": {
                "dataset": "gpl-odd-simulated",
                "location": location_for_meta,
                "duration_seconds": round(float(duration), 3),
                "frame_count": len(observations),
                "agents": [
                    {
                        "track_id": a.track_id,
                        "name": a.name,
                        "class": a.obj_class,
                        "width": a.width,
                        "length": a.length,
                    }
                    for a in registry
                ],
            },
        }
        with write_path(cluster_dir, "cluster.json").open("w") as f:
            json.dump(cluster_doc, f, indent=2)
        print(f"  ✓ Saved cluster.json")
    except Exception as e:
        cluster_doc = None
        print(f"  ⚠️  Failed to write cluster.json: {e}")

    # 9. LLM context card: sentence timeline + agent digest (no raw az table).
    try:
        sel = selection_bundle[0] if selection_bundle else None
        fnames = selection_bundle[1] if len(selection_bundle) >= 2 else None
        write_context_md(
            cluster_dir,
            cluster_doc,
            action_data_for_ctx,
            selection=sel,
            snap_filenames=fnames,
            traj_df=traj_for_desc,
            map_tracks_csv=map_tracks_for_ctx,
        )
        print(f"  ✓ Saved context.md")
    except Exception as e:
        print(f"  ⚠️  Failed to write context.md: {e}")

    # meta.yaml is an intermediate input to the labeller only — drop it from output.
    try:
        meta_path.unlink(missing_ok=True)
    except Exception:
        pass

    # Clean up dataframe
    del df
    
    print(f"  ✅ Cluster {label} processing complete")
    return True


def process_trial_to_dir(
    batch_id: int,
    trial_index: int,
    trial_id: str,
    out_dir: Path,
    xodr_path: Path,
    parser_xodr: XodrParser,
    dataset_name: str = "dataset1",
    snapshot_output_px: int = 1024,
    snapshot_border_frac: float = 0.10,
    typography=None,
    max_snapshots: Optional[int] = None,
    collided: bool = False,
    trial_events: Optional[Any] = None,
    ego_zoom_radius: float = 30.0,
    contact_clearance_m: float = 0.5,
    conflict_relevance_m: float = 5.0,
    conflict_window_s: Optional[float] = None,
    conflict_window_before_s: float = 15.0,
    conflict_window_after_s: float = 8.0,
) -> bool:
    """Generate nested pack artifacts for one aux trial under *out_dir*.

    Mirrors the core of ``process_medoid`` but writes only per-trial artifacts
    (no cluster.json / context.md). Used for outlier and boundary trials.
    """
    from map_plotter import DEFAULT_BEV_TYPOGRAPHY

    if typography is None:
        typography = DEFAULT_BEV_TYPOGRAPHY

    out_dir.mkdir(parents=True, exist_ok=True)
    migrate_flat_to_nested(out_dir)
    ensure_layout(out_dir)

    if not csv_exists(batch_id, trial_index):
        print(f"    ❌ CSV missing for batch {batch_id} trial {trial_index} — skipped")
        return False

    df = get_csv_road_data(batch_id, trial_index)
    if df is None or df.empty:
        print(f"    ❌ Failed to load CSV for batch {batch_id} trial {trial_index}")
        return False

    try:
        observations = _df_to_observations(df)
    except Exception as e:
        print(f"    ❌ DataFrame conversion failed: {e}")
        return False

    trajectory_path = write_path(out_dir, "trajectory.csv")
    meta_path = write_path(out_dir, "meta.yaml")
    location_for_meta = Path(xodr_path).stem

    try:
        registry = build_trajectory_csv(observations, parser_xodr, trajectory_path)
        build_meta_yaml(
            registry, observations, meta_path,
            dataset="gpl-odd-simulated", location=location_for_meta,
        )
    except Exception as e:
        print(f"    ❌ trajectory/meta build failed: {e}")
        return False

    from pipeline_imports import ensure_llm_pipeline
    ensure_llm_pipeline()
    from llm_pipeline.cluster_stats import trial_collision_flag

    action_data = None
    traj_for_desc = None
    action_yaml_path = write_path(out_dir, "action.yaml")
    desc_path = write_path(out_dir, "description.txt")
    try:
        from labeller import label_trajectory, save_action_yaml
        from description import build_description, save_description_txt
        from dataset_config import map_tracks_path_for_dataset

        map_yaml = (
            Path(xodr_path).parent.parent / "map" / f"{location_for_meta}.yaml"
        )
        action_data = label_trajectory(
            trajectory_path, meta_path,
            map_yaml if map_yaml.is_file() else None,
            esmini_df=df,
            trial_events=trial_events,
            collided=collided,
            contact_clearance_m=contact_clearance_m,
            conflict_relevance_m=conflict_relevance_m,
        )
        save_action_yaml(action_data, action_yaml_path)
        traj_for_desc = pd.read_csv(trajectory_path)
        map_tracks_csv = map_tracks_path_for_dataset(dataset_name)
        save_description_txt(
            build_description(
                action_data,
                traj_df=traj_for_desc,
                map_tracks_csv=str(map_tracks_csv) if map_tracks_csv.is_file() else None,
            ),
            desc_path,
        )
    except Exception as e:
        print(f"    ⚠️  Action/description failed: {e}")

    snaps_out = nested_snapshots_dir(out_dir)
    selection_bundle: list = []
    map_tracks = None
    try:
        from tier2_renderer import (
            Tier2BevRenderer,
            resolve_tier2_paths,
        )

        _xodr, map_tracks, location = resolve_tier2_paths(dataset_name)
        if map_tracks.is_file():
            tier2 = Tier2BevRenderer(
                str(map_tracks),
                str(xodr_path if xodr_path.is_file() else _xodr),
                location=location,
                dataset_name=dataset_name,
                snapshot_output_px=snapshot_output_px,
                snapshot_border_frac=snapshot_border_frac,
                typography=typography,
                ego_zoom_radius=ego_zoom_radius,
            )
            if not action_yaml_path.is_file():
                raise FileNotFoundError("action.yaml missing — cannot render BEV")
            snaps = tier2.render_trial_from_esmini_csv(
                batch_id, trial_index,
                str(snaps_out),
                n_snapshots=max_snapshots,
                file_prefix=f"trial_{trial_index}",
                overview_dir=None,
                action_yaml_path=str(action_yaml_path),
                conflict_window_s=conflict_window_s,
                conflict_window_before_s=conflict_window_before_s,
                conflict_window_after_s=conflict_window_after_s,
                selection_out=selection_bundle,
            )
            print(f"    ✓ {len(snaps)} BEV snapshots")
    except Exception as e:
        print(f"    ⚠️  BEV generation failed: {e}")

    if action_data is not None:
        try:
            from description import build_description, save_description_txt
            from conflict_frame_selector import format_bev_frame_index

            evidence = None
            if len(selection_bundle) >= 2:
                evidence = format_bev_frame_index(
                    selection_bundle[0], selection_bundle[1]
                )
            save_description_txt(
                build_description(
                    action_data,
                    snapshot_evidence=evidence,
                    traj_df=traj_for_desc,
                    map_tracks_csv=(
                        str(map_tracks)
                        if (map_tracks is not None and map_tracks.is_file())
                        else None
                    ),
                ),
                desc_path,
            )
        except Exception as e:
            print(f"    ⚠️  description.txt failed: {e}")

    try:
        meta_path.unlink(missing_ok=True)
    except Exception:
        pass

    del df
    return True


def process_auxiliary_trials(
    run_dir: Path,
    intra_by_cluster: Dict[str, Dict[str, Any]],
    boundary_pairs: List[Dict[str, Any]],
    trial_index_map: Dict[str, Tuple[int, int]],
    collision_flags: Optional[Dict[str, bool]],
    trials_meta: Optional[Dict[str, Any]],
    xodr_path: Path,
    parser_xodr: XodrParser,
    dataset_name: str = "dataset1",
    snapshot_output_px: int = 1024,
    snapshot_border_frac: float = 0.10,
    typography=None,
    max_snapshots: Optional[int] = None,
    ego_zoom_radius: float = 30.0,
    contact_clearance_m: float = 0.5,
    conflict_relevance_m: float = 5.0,
    conflict_window_s: Optional[float] = None,
    conflict_window_before_s: float = 15.0,
    conflict_window_after_s: float = 8.0,
    outlier_scope: Optional[Set[str]] = None,
    boundary_scope: Optional[Set[str]] = None,
    param_boundary_pairs: Optional[List[Dict[str, Any]]] = None,
    param_boundary_scope: Optional[Set[str]] = None,
) -> None:
    """Build full trial artifacts for outlier and boundary trials.

    Outlier → ``cluster<N>/highlight_trials/outlier_trials/trial_<id>/``
    Embedding boundary → ``cluster<N>/highlight_trials/boundary_c<M>/trial_<id>/``
    Param (IC) boundary → ``<run>/ic_pairs/cA-cB/`` (gated by param_dist ≤ τ)

    ``outlier_scope`` / ``boundary_scope`` / ``param_boundary_scope``:
    None=all, empty=skip, else cluster labels.
    """
    def _resolve(tid: str) -> Tuple[Optional[int], Optional[int]]:
        bi = trial_index_map.get(str(tid))
        return (bi[0], bi[1]) if bi else (None, None)

    def _trial_events(tid: str):
        info = (trials_meta or {}).get(str(tid))
        return info.get("events") if isinstance(info, dict) else None

    def _build_boundary_dirs(
        pairs: List[Dict[str, Any]],
        scope: Optional[Set[str]],
        folder_prefix: str,
        dist_key: str,
        label: str,
    ) -> None:
        if scope is not None and len(scope) == 0:
            print(f"  ⏭  {label} skipped")
            return
        processed: set = set()
        for bp in pairs:
            ca, ta = bp["cluster_a"], bp["trial_a"]
            cb, tb = bp["cluster_b"], bp["trial_b"]
            dist = bp.get(dist_key)
            dist_s = f"{float(dist):.3f}" if isinstance(dist, (int, float)) else "?"
            for (src_label, tgt_label, tid) in [(ca, cb, ta), (cb, ca, tb)]:
                if not cluster_in_scope(src_label, scope):
                    continue
                key = (src_label, tgt_label, str(tid))
                if key in processed:
                    continue
                processed.add(key)
                b, ti = _resolve(str(tid))
                if b is None:
                    print(f"  ⚠️  {label} trial {tid} not in index map — skipped")
                    continue
                collided = bool((collision_flags or {}).get(str(tid), False))
                out_dir = (
                    highlight_subdir(
                        run_dir / f"cluster{src_label}",
                        folder_prefix,
                        target_cluster=tgt_label,
                    )
                    / f"trial_{ti}"
                )
                print(
                    f"  🔹 {label} c{src_label}↔c{tgt_label}: trial {tid} "
                    f"(batch {b}, idx {ti}, {dist_key}={dist_s})"
                    f"{' COLLISION' if collided else ''}"
                )
                process_trial_to_dir(
                    b, ti, str(tid), out_dir, xodr_path, parser_xodr,
                    dataset_name=dataset_name,
                    snapshot_output_px=snapshot_output_px,
                    snapshot_border_frac=snapshot_border_frac,
                    typography=typography,
                    max_snapshots=max_snapshots,
                    collided=collided,
                    trial_events=_trial_events(str(tid)),
                    ego_zoom_radius=ego_zoom_radius,
                    contact_clearance_m=contact_clearance_m,
                    conflict_relevance_m=conflict_relevance_m,
                    conflict_window_s=conflict_window_s,
                    conflict_window_before_s=conflict_window_before_s,
                    conflict_window_after_s=conflict_window_after_s,
                )

    # --- outlier trials ---
    if outlier_scope is not None and len(outlier_scope) == 0:
        print("  ⏭  Outliers skipped (--outliers none)")
    else:
        for label_str, iv in intra_by_cluster.items():
            if not cluster_in_scope(label_str, outlier_scope):
                continue
            outlier_ids = iv.get("outlier_trial_ids", [])
            if not outlier_ids:
                continue
            top_tid = str(outlier_ids[0])
            b, ti = _resolve(top_tid)
            if b is None:
                print(f"  ⚠️  Outlier trial {top_tid} not in index map — skipped")
                continue
            collided = bool((collision_flags or {}).get(top_tid, False))
            out_dir = (
                highlight_subdir(run_dir / f"cluster{label_str}", "outlier_trials")
                / f"trial_{ti}"
            )
            print(f"  🔸 Outlier cluster {label_str}: trial {top_tid} (batch {b}, idx {ti})"
                  f"{' COLLISION' if collided else ''}")
            process_trial_to_dir(
                b, ti, top_tid, out_dir, xodr_path, parser_xodr,
                dataset_name=dataset_name,
                snapshot_output_px=snapshot_output_px,
                snapshot_border_frac=snapshot_border_frac,
                typography=typography,
                max_snapshots=max_snapshots,
                collided=collided,
                trial_events=_trial_events(top_tid),
                ego_zoom_radius=ego_zoom_radius,
                contact_clearance_m=contact_clearance_m,
                conflict_relevance_m=conflict_relevance_m,
                conflict_window_s=conflict_window_s,
                conflict_window_before_s=conflict_window_before_s,
                conflict_window_after_s=conflict_window_after_s,
            )

    # --- embedding-space closest pairs ---
    _build_boundary_dirs(
        boundary_pairs,
        boundary_scope,
        folder_prefix="boundary_c",
        dist_key="embedding_dist",
        label="Emb-boundary",
    )

    # --- parameter-space (initial condition) closest pairs → ic_pairs/cA-cB/ ---
    if param_boundary_scope is not None and len(param_boundary_scope) == 0:
        print("  ⏭  IC-pair packs skipped (--param-boundaries none)")
    elif param_boundary_pairs:
        from ic_pair_packs import process_ic_pair_packs

        process_ic_pair_packs(
            run_dir=run_dir,
            param_boundary_pairs=param_boundary_pairs,
            trial_index_map=trial_index_map,
            collision_flags=collision_flags,
            trials_meta=trials_meta,
            xodr_path=xodr_path,
            parser_xodr=parser_xodr,
            dataset_name=dataset_name,
            snapshot_output_px=snapshot_output_px,
            snapshot_border_frac=snapshot_border_frac,
            typography=typography,
            ego_zoom_radius=ego_zoom_radius if ego_zoom_radius else 25.0,
            contact_clearance_m=contact_clearance_m,
            conflict_relevance_m=conflict_relevance_m,
            conflict_window_s=conflict_window_s,
            conflict_window_before_s=conflict_window_before_s,
            conflict_window_after_s=conflict_window_after_s,
            scope=param_boundary_scope,
        )


def main():
    parser = argparse.ArgumentParser(
        description="Build LLM dataset from medoid trials"
    )

    # --- Source mode ---
    parser.add_argument(
        "--source",
        choices=("alldatasets", "payload-save"),
        default="payload-save",
        help="Where clustering comes from (default: payload-save). "
             "payload-save = create/rebuild from Payload saved analysis; "
             "alldatasets = legacy local export.",
    )

    # --- alldatasets mode (legacy) ---
    parser.add_argument(
        "--dataset",
        default=None,
        help=(
            "Dataset name (e.g., dataset1). Required for --source alldatasets. "
            "Optional for --source payload-save (used for output folder; defaults to batch<id>)"
        ),
    )
    parser.add_argument(
        "--n-clusters",
        type=int,
        default=None,
        help="Number of clusters (required for --source alldatasets; ignored when --k is set)",
    )

    # --- payload-save mode ---
    parser.add_argument(
        "--batch-id",
        type=int,
        default=None,
        help="Payload batch ID to load saved analysis from (required for --source payload-save)",
    )
    parser.add_argument(
        "--save-doc-id",
        type=int,
        default=None,
        help="Specific Payload document ID for the saved analysis zip (default: latest)",
    )
    parser.add_argument(
        "--analysis-zip",
        default=None,
        help=(
            "Local path to a saved-analysis zip (e.g. data/paper_casestudies/case2/"
            "casestudy2.zip). Skips Payload download; still use --batch-id / --k / "
            "--ego-name for selection and output layout."
        ),
    )
    parser.add_argument(
        "-k", "--k_clusters",
        type=int,
        default=None,
        dest="k_clusters",
        help="Target cluster count: pick best-silhouette result with this k "
             "(or the one matching --silhouette) from the saved analysis",
    )
    parser.add_argument(
        "--silhouette",
        type=float,
        default=None,
        help="With --k, select the result whose silhouette is closest to this value "
             "(e.g. --k 4 --silhouette 0.7037 to pick the lower-silhouette k=4 result). "
             "Without it, --k picks the highest silhouette.",
    )
    parser.add_argument(
        "--clustering-index",
        type=int,
        default=None,
        help="Directly select by 0-based index into clustering[] array (mutually exclusive with --k)",
    )
    parser.add_argument(
        "--list-clusterings",
        action="store_true",
        help="payload-save only: print all clustering candidates (index, k, silhouette, "
             "task params) and exit without building. Filter with --k.",
    )
    parser.add_argument(
        "--backfill-stats",
        metavar="RESULTS_DIR",
        help="payload-save only: re-fetch the analysis and patch collision + TTC/SPrET/"
             "parameter-range stats into each cluster<N>/cluster.json under RESULTS_DIR "
             "(e.g. results/batch2/4_cluster_s=0.6945), without rebuilding BEV. Needs --batch-id.",
    )
    parser.add_argument(
        "--duration-mode",
        default="full",
        help="MFPCA duration key in the saved analysis (default: full)",
    )
    parser.add_argument(
        "--ego-name",
        default="ITRI",
        help="Ego key in the saved analysis JSON (default: ITRI)",
    )

    # --- shared / rendering ---
    parser.add_argument(
        "--run-id",
        help="Optional run ID (default: auto-generated timestamp)",
    )
    parser.add_argument(
        "--xodr",
        default="simulation/ros/.cache/scenario_search/hct_6.xodr",
        help="Path to OpenDRIVE map (relative to project root)",
    )
    parser.add_argument(
        "--trials",
        help="Manual trial list: batch:index,batch:index,... (e.g., '1:100,1:200,1:300')",
    )
    parser.add_argument(
        "--snapshot-size",
        type=int,
        default=512,
        help="Square BEV snapshot output size in pixels (default: 1024)",
    )
    parser.add_argument(
        "--snapshot-border-frac",
        type=float,
        default=0.10,
        help="White border as fraction of map content per side (default: 0.10 → 100 m → 120 m frame)",
    )
    parser.add_argument(
        "--ego-zoom-radius",
        type=float,
        default=25.0,
        help="Right BEV panel zooms to ±this many metres around the ego "
             "(default: 30). Set 0 to disable the dual-panel composite.",
    )
    parser.add_argument(
        "--road-label-size",
        type=float,
        default=10,
        help="Font size (pt) for red road ID boxes on map_overview AND conflict "
             "snapshot overlays (default: 5). Raise e.g. 8–10 if too small.",
    )
    parser.add_argument(
        "--lane-label-size",
        type=float,
        default=10,
        help="Font size (pt) for black lane ID boxes on map_overview AND conflict "
             "snapshot overlays (default: 6). Raise e.g. 8–10 if too small.",
    )
    parser.add_argument(
        "--road-label-plain-size",
        type=float,
        default=5,
        help="Font size (pt) for unhighlighted road IDs on full-network hct_6.jpg (default: 4.8)",
    )
    parser.add_argument(
        "--agent-id-size",
        type=float,
        default=11,
        help="Font size (pt) for on-car agent ID circles in snapshots (default: 4.0)",
    )
    parser.add_argument(
        "--info-font-size",
        type=float,
        default=8.0,
        help="Font size (pt) for top-left agent legend list (default: 8.0)",
    )
    parser.add_argument(
        "--panel-label-font-size",
        type=float,
        default=12.0,
        help="Font size (pt) for dual-panel captions 'pair zoom' / 'ego ±Nm' / "
             "'whole scene' (default: 9)",
    )
    parser.add_argument(
        "--scale-bar-font-size",
        type=float,
        default=12.0,
        help="Font size (pt) for scale-bar tick numbers 0/50/100… (default: 12)",
    )
    parser.add_argument(
        "--scale-bar-y",
        type=float,
        default=0.06,
        help="Vertical position of the scale bar in figure coords "
             "(0=bottom edge, 1=top). Raise if the bar sits too low "
             "(default: 0.06; try 0.07–0.09).",
    )
    parser.add_argument(
        "--scale-bar-max-width-frac",
        type=float,
        default=0.4,
        help="Max scale-bar width as fraction of image width (default: 0.40). "
             "Lower if the bar overlays the d=/TTC= chip (try 0.28–0.35).",
    )
    parser.add_argument(
        "--scale-bar-min-width-frac",
        type=float,
        default=0.22,
        help="Min scale-bar width as fraction of image width (default: 0.22).",
    )
    parser.add_argument(
        "--metric-chip-font-size",
        type=float,
        default=12.0,
        help="Font size (pt) for bottom-right d=/TTC= chip on conflict BEVs "
             "(default: 12).",
    )
    parser.add_argument(
        "--road-label-avoid-m",
        type=float,
        default=4.0,
        help="Nudge road/lane ID labels at least this many metres away from "
             "ego/partner centers so agents do not cover them (default: 4). "
             "Set 0 to disable.",
    )
    parser.add_argument(
        "--title-font-size",
        type=float,
        default=8.0,
        help="Font size (pt) for map_overview title (default: 7.0)",
    )
    parser.add_argument(
        "--from-run",
        type=str,
        default=None,
        metavar="PATH",
        help="Rebuild BEV/labels into an EXISTING results folder "
             "(needs manifest.json + clustering/selectedClusteringResult.json). "
             "Do NOT use this to create a new k — for that omit --from-run and use "
             "--batch-id + --k. Accepts exact …/4_cluster_s=0.6945, prefix …/4_cluster, "
             "or …/batch2 with --k 4 (auto-picks highest silhouette).",
    )
    parser.add_argument(
        "--force-map",
        action="store_true",
        help="Regenerate results/map/ assets (xodr copy, tracks, yaml, jpg) "
             "even if they already exist.",
    )
    parser.add_argument(
        "--skip-map",
        action="store_true",
        help="Do not auto-ensure results/map/ assets (assume already present).",
    )
    parser.add_argument(
        "--map-only",
        action="store_true",
        help="Only ensure/regenerate results/map/ assets, then exit "
             "(needs --batch-id, --dataset, or --all-maps).",
    )
    parser.add_argument(
        "--all-maps",
        action="store_true",
        help="With --map-only: generate assets for every map variant.",
    )
    parser.add_argument(
        "--medoids",
        type=str,
        default="all",
        metavar="SCOPE",
        help="Which cluster medoids to build: 'all' (default), 'none', or "
             "comma list of labels e.g. '1' or '0,2'.",
    )
    parser.add_argument(
        "--emb-boundaries",
        "--boundaries",  # backward-compatible alias
        type=str,
        default="none",
        dest="emb_boundaries",
        metavar="SCOPE",
        help="Embedding-space closest pairs → clusterN/highlight_trials/boundary_cM/: "
             "'all' (default), 'none', or labels e.g. '1'.",
    )
    parser.add_argument(
        "--param-boundaries",
        type=str,
        default="none",
        metavar="SCOPE",
        help="IC closest pairs → results/.../ic_pairs/cA-cB/ (param_dist≤0.1 only): "
             "'all', 'none' (default), or labels e.g. '1'. Distance is z-scored "
             "OncomingSpeed / OncomingStartDelay L2.",
    )
    parser.add_argument(
        "--outliers",
        type=str,
        default="none",
        metavar="SCOPE",
        help="Which clusters get highlight_trials/outlier_trials: 'all' (default), 'none', "
             "or labels e.g. '1'.",
    )
    parser.add_argument(
        "--contact-clearance-m",
        type=float,
        default=0.5,
        help="Polygon gap (m) treated as vehicle contact for collision partner",
    )
    parser.add_argument(
        "--conflict-relevance-m",
        type=float,
        default=5.0,
        help="Max polygon gap (m) for moving-agent CLOSEST_APPROACH",
    )
    parser.add_argument(
        "--max-snapshots",
        type=int,
        default=None,
        metavar="N",
        help="Optional cap on BEV frames rendered (default: uncapped, all key times)",
    )
    parser.add_argument(
        "--conflict-window-before-s",
        type=float,
        default=15.0,
        help="Keep action-derived BEV/context frames from peak−BEFORE to peak "
             "(default: 15). Captures pre-conflict setup maneuvers.",
    )
    parser.add_argument(
        "--conflict-window-after-s",
        type=float,
        default=8.0,
        help="Keep action-derived BEV/context frames from peak to peak+AFTER "
             "(default: 8).",
    )
    parser.add_argument(
        "--conflict-window-s",
        type=float,
        default=None,
        help="Legacy symmetric ±W override for the conflict peak window. "
             "If set, ignores --conflict-window-before-s / --conflict-window-after-s.",
    )

    args = parser.parse_args()

    # --- Map-only mode: ensure results/map/ then exit ---
    if args.map_only:
        from map_assets import ensure_map_assets, resolve_datasets

        try:
            datasets = resolve_datasets(
                batch_id=args.batch_id,
                dataset=args.dataset,
                all_datasets=bool(args.all_maps),
            )
        except ValueError as exc:
            parser.error(f"--map-only: {exc}")
        for ds in datasets:
            ensure_map_assets(
                dataset=ds,
                force=bool(args.force_map),
            )
        sys.exit(0)

    # --- Validate arg combinations ---
    is_payload_save = args.source == "payload-save"

    # --- List-only mode: print clustering candidates and exit (no build) ---
    if args.list_clusterings:
        if not is_payload_save:
            parser.error("--list-clusterings requires --source payload-save")
        if args.batch_id is None:
            parser.error("--list-clusterings requires --batch-id")
        print(f"📋 Clustering candidates for batch {args.batch_id}"
              f"{f' (k={args.k_clusters})' if args.k_clusters is not None else ''}:")
        ok = list_clusterings_from_payload_save(
            batch_id=args.batch_id,
            save_doc_id=args.save_doc_id,
            k=args.k_clusters,
            duration_mode=args.duration_mode,
            ego_name=args.ego_name,
            analysis_zip=args.analysis_zip,
        )
        sys.exit(0 if ok else 1)

    # --- Backfill-stats mode: patch existing cluster.json files and exit ---
    if args.backfill_stats:
        if not is_payload_save:
            parser.error("--backfill-stats requires --source payload-save")
        if args.batch_id is None:
            parser.error("--backfill-stats requires --batch-id")
        print(f"🩹 Backfilling stats into {args.backfill_stats} (batch {args.batch_id})")
        ok = backfill_cluster_stats_in_dir(
            args.backfill_stats,
            batch_id=args.batch_id,
            save_doc_id=args.save_doc_id,
            k=args.k_clusters,
            clustering_index=args.clustering_index,
            silhouette=args.silhouette,
            duration_mode=args.duration_mode,
            ego_name=args.ego_name,
            analysis_zip=args.analysis_zip,
        )
        sys.exit(0 if ok else 1)

    if not args.trials:
        if is_payload_save:
            if args.batch_id is None:
                parser.error("--source payload-save requires --batch-id")
            # k / clustering-index are optional when the zip contains selected.json;
            # the Python loader will raise an error at runtime if none of them apply.
        else:
            if args.dataset is None:
                parser.error("--source alldatasets requires --dataset")
            if args.n_clusters is None:
                parser.error("--source alldatasets requires --n-clusters")

    # Derive effective n_clusters and dataset name.
    # In payload-save mode --dataset is optional: resolve the canonical dataset
    # (dataset1/2/3) from the batch id so map/track assets and BEV keep working.
    n_clusters: int = args.n_clusters or args.k_clusters or 0
    dataset_name: str = args.dataset or ""
    if not dataset_name:
        resolved = None
        if args.batch_id is not None:
            try:
                from dataset_config import dataset_for_batch_id
                resolved = dataset_for_batch_id(args.batch_id)
            except Exception:
                resolved = None
        if resolved:
            dataset_name = resolved
            print(f"   Resolved dataset '{dataset_name}' from batch id {args.batch_id}")
        elif args.batch_id is not None:
            # Custom batch folders (e.g. batch9) still share hct_6 map assets.
            dataset_name = "dataset1"
            print(
                f"   ⚠️  No dataset config maps to batch {args.batch_id}; "
                f"using '{dataset_name}' for map/BEV assets"
            )
        else:
            dataset_name = "unknown"

    bev_typography = build_bev_typography(args)
    run_id = args.run_id or datetime.utcnow().strftime("%Y%m%d_%H%M%S")

    print(f"🚀 Building LLM dataset for {dataset_name} (k={n_clusters})")
    print(f"   Source: {args.source}")
    print(f"   Run ID: {run_id}")
    print("   BEV: conflict-centered (action.yaml + W/D gates)")

    result_data: Optional[Dict[str, Any]] = None
    embeddings_data: Optional[Dict[str, Any]] = None
    trial_index_map: Optional[Dict[str, Tuple[int, int]]] = None
    payload_collision_flags: Optional[Dict[str, bool]] = None
    payload_metric_stats: Dict[str, Dict[str, Any]] = {}
    trials_meta: Dict[str, Any] = {}
    ego_scenario_params: List[Dict[str, Any]] = []

    # --- Step 1: Load clustering data ---
    ref_silhouette: Optional[float] = None
    if args.from_run:
        ref_path = resolve_from_run_path(
            args.from_run,
            k=args.k_clusters,
        )
        if not ref_path:
            sys.exit(1)
        print(f"\n📂 Rebuilding from reference run: {ref_path}")
        loaded = load_from_reference_run(ref_path)
        if not loaded:
            sys.exit(1)
        result_data, medoids, ref_silhouette = loaded
        real_labels = {v["label"] for v in result_data.get("data", {}).values()} - {"-1"}
        n_clusters = len(real_labels)
        if args.batch_id is None and medoids:
            args.batch_id = medoids[0].get("batch_id")
            print(f"  Inferred --batch-id {args.batch_id} from manifest")
        if args.batch_id is not None:
            fetched = _fetch_payload_analysis(
                batch_id=args.batch_id,
                save_doc_id=args.save_doc_id,
                duration_mode=args.duration_mode,
                ego_name=args.ego_name,
                analysis_zip=args.analysis_zip,
            )
            if fetched:
                scores, _clist, ego_data, _sel = fetched
                payload_collision_flags = _collision_flags_from_ego(ego_data)
                trials_meta = ego_data.get("trials") or {}
                ego_scenario_params = list(
                    (ego_data.get("scenario") or {}).get("parameters")
                    or ego_data.get("parameters")
                    or []
                )
                payload_metric_stats = _cluster_metric_stats_from_ego(ego_data, result_data)
                n_coll = sum(1 for v in payload_collision_flags.values() if v)
                print(f"  Loaded collision KPI for {len(payload_collision_flags)} trials "
                      f"({n_coll} collided)")
                # Enable outlier / boundary aux trials (same as fresh payload-save).
                embeddings_data = {"embeddings": scores}
                _DAT_PAT = re.compile(r"esmini_(\d+)_(\d+)\.dat")
                trial_index_map = {}
                for tid, t_info in trials_meta.items():
                    if not isinstance(t_info, dict):
                        continue
                    edat = t_info.get("esminiDat")
                    if not isinstance(edat, dict):
                        continue
                    fname = edat.get("filename", "")
                    m = _DAT_PAT.match(fname)
                    if m:
                        trial_index_map[str(tid)] = (int(m.group(1)), int(m.group(2)))
                print(f"  Built trial→CSV map for {len(trial_index_map)} trials "
                      f"(enables outlier_trials / boundary_c* / param_boundary_c*)")
            else:
                print("  ⚠️  Could not fetch Payload analysis — cluster collision stats may be incomplete")
                print("  ⚠️  Without embeddings, outlier/boundary aux trials will be skipped")

    elif args.trials:
        print(f"\n📝 Using manually specified trials: {args.trials}")
        medoids = []
        for i, trial_spec in enumerate(args.trials.split(",")):
            parts = trial_spec.strip().split(":")
            batch_id_t, trial_index_t = int(parts[0]), int(parts[1])
            collided_flag = len(parts) > 2 and parts[2].lower() in ("1", "true", "collision", "collided")
            if not csv_exists(batch_id_t, trial_index_t):
                print(f"  ⚠️  WARNING: CSV not found for batch {batch_id_t} trial {trial_index_t}")
                continue
            medoids.append({
                "cluster_label": str(i),
                "trial_id": f"{batch_id_t}_{trial_index_t}",
                "batch_id": batch_id_t,
                "trial_index": trial_index_t,
                "size": 1,
                "collided": collided_flag,
            })
        if not medoids:
            print("❌ ERROR: None of the specified trials have available CSVs")
            sys.exit(1)

    elif is_payload_save:
        print(f"\n📦 Loading clustering from Payload save (batch={args.batch_id})")
        clustering_data = load_clustering_from_payload_save(
            batch_id=args.batch_id,
            save_doc_id=args.save_doc_id,
            k=args.k_clusters,
            clustering_index=args.clustering_index,
            duration_mode=args.duration_mode,
            ego_name=args.ego_name,
            silhouette=args.silhouette,
            analysis_zip=args.analysis_zip,
        )
        if not clustering_data:
            sys.exit(1)

        embeddings_data, result_data, trial_index_map, payload_collision_flags, payload_metric_stats, trials_meta = clustering_data
        # Update n_clusters from the actual selection (real label count)
        real_labels = {v["label"] for v in result_data.get("data", {}).values()} - {"-1"}
        n_clusters = len(real_labels)
        print(f"  Resolved k={n_clusters} real clusters")

        print("\n📊 Computing cluster medoids...")
        medoids = compute_medoids(
            embeddings_data, result_data,
            dataset=None,
            trial_index_map=trial_index_map,
        )
        if not medoids:
            print("❌ ERROR: No medoids with local CSVs found")
            print("\n💡 TIP: Verify that esmini CSV files are present for batch", args.batch_id)
            sys.exit(1)

    else:
        print(f"\n📂 Loading clustering from alldatasets/{dataset_name}")
        clustering_data = load_clustering_data(dataset_name, n_clusters)
        if not clustering_data:
            sys.exit(1)
        embeddings_data, result_data = clustering_data

        print("\n📊 Computing cluster medoids...")
        medoids = compute_medoids(embeddings_data, result_data, dataset=dataset_name)
        if not medoids:
            print("❌ ERROR: No medoids computed")
            print("\n💡 TIP: The clustering result contains Payload trial IDs that don't")
            print("   exist in your local database. You can specify trials manually:")
            print(f"   python3 app/analyzer/src/dataset_builder.py {dataset_name} {n_clusters} --trials '1:100,1:200,1:300'")
            sys.exit(1)

    print(f"\n📊 Found {len(medoids)} medoid clusters")

    # --- Resolve batch id for the output path (results/batch<id>/<k>_cluster/) ---
    batch_id_out: Optional[int] = args.batch_id
    if batch_id_out is None:
        try:
            from dataset_config import get_dataset_config
            batch_id_out = int(get_dataset_config(dataset_name)["batch_id"])
        except Exception:
            batch_id_out = None
    if batch_id_out is None and medoids:
        batch_id_out = medoids[0].get("batch_id")
    # If dataset is still unknown but we now know the batch, recover the dataset
    # name so map/track assets resolve correctly.
    if dataset_name in ("", "unknown") and batch_id_out is not None:
        try:
            from dataset_config import dataset_for_batch_id
            recovered = dataset_for_batch_id(batch_id_out)
            if recovered:
                dataset_name = recovered
        except Exception:
            pass

    batch_label = f"batch{batch_id_out}" if batch_id_out is not None else dataset_name

    # --- Step 3: Output directory (batch-based layout) ---
    #   results/batch<id>/<k>_cluster_s=<silhouette>/cluster<N>/...
    # The silhouette suffix keeps multiple results with the same k (but different
    # clustering params) in separate folders.
    # Folder name must use the SELECTED result's real silhouette, not the
    # --silhouette search hint. Otherwise a nearest-match pick (e.g. request
    # 0.6988 → select 0.7036) would write under the wrong folder name.
    silhouette: Optional[float] = None
    if result_data is not None:
        sv = (result_data.get("scores", {}) or {}).get("silhouetteScore")
        if isinstance(sv, (int, float)):
            silhouette = float(sv)
    if silhouette is None:
        silhouette = args.silhouette or ref_silhouette
    cluster_dirname = f"{n_clusters}_cluster"
    if silhouette is not None:
        cluster_dirname += f"_s={silhouette:.4f}"
    run_dir = RESULTS_DIR / batch_label / cluster_dirname
    run_dir.mkdir(parents=True, exist_ok=True)
    print(f"📁 Output dir: {run_dir.relative_to(RESULTS_DIR.parent)}")

    # --- Shared map assets (results/map/) — auto-generate if missing ---
    shared_map_dir = RESULTS_DIR / "map"
    if not args.skip_map:
        try:
            from map_assets import ensure_map_assets

            ensure_map_assets(
                batch_id=batch_id_out if isinstance(batch_id_out, int) else args.batch_id,
                dataset=dataset_name if dataset_name not in ("", "unknown") else None,
                force=bool(args.force_map),
            )
        except Exception as exc:
            print(f"  ⚠️  Map asset ensure failed: {exc}")

    try:
        from dataset_config import xodr_path_for_dataset
        xodr_src = xodr_path_for_dataset(dataset_name)
    except Exception:
        xodr_src = shared_map_dir / "hct_6.xodr"

    if not xodr_src.is_file() and args.xodr:
        alt = PROJECT_ROOT / args.xodr
        if alt.is_file():
            xodr_src = alt
    if not xodr_src.is_file():
        cache_xodr = PROJECT_ROOT / "simulation/ros/.cache/scenario_search/hct_6.xodr"
        if cache_xodr.is_file():
            xodr_src = cache_xodr
    if not xodr_src.is_file():
        print(f"❌ ERROR: Map xodr not found in {shared_map_dir}.")
        print("   Fix: python3 app/analyzer/src/dataset_builder.py --batch-id "
              f"{args.batch_id or '<id>'} --map-only")
        sys.exit(1)

    # --- Step 4: Initialize map parser (reads shared map xodr directly) ---
    xodr_path = xodr_src
    try:
        parser_xodr = XodrParser(str(xodr_path))
        print(f"✓ Initialized XODR map parser from {xodr_path}")
    except Exception as e:
        print(f"❌ ERROR: Failed to initialize map parser: {e}")
        sys.exit(1)

    # --- Step 5: Save clustering result snapshot ---
    clustering_dir = run_dir / "clustering"
    clustering_dir.mkdir(exist_ok=True)

    if is_payload_save or args.from_run:
        # Write the selected result directly (no alldatasets file to copy)
        if result_data is not None:
            with (clustering_dir / "selectedClusteringResult.json").open("w") as f:
                json.dump(result_data, f, indent=2)
            print("✓ Saved clustering result snapshot")
    else:
        result_src = (
            PROJECT_ROOT
            / "alldatasets"
            / dataset_name
            / f"selectedClusteringResult_{n_clusters}Clusters.json"
        )
        if result_src.is_file():
            shutil.copy(result_src, clustering_dir / "selectedClusteringResult.json")
            print("✓ Copied clustering data")
        else:
            print(f"⚠️  Clustering result file not found: {result_src} (skipped)")

    # --- Collision flags ---
    # payload-save: collision KPI parsed from the saved analysis (per Payload trial).
    # alldatasets:  legacy alldatasets/<dataset>/collision.json file.
    collision_flags: Optional[Dict[str, bool]] = None
    if payload_collision_flags:
        collision_flags = payload_collision_flags
        n_coll = sum(1 for v in collision_flags.values() if v)
        print(f"✓ Using collision KPI from Payload analysis "
              f"({n_coll}/{len(collision_flags)} trials collided)")
    else:
        collision_path = PROJECT_ROOT / "alldatasets" / dataset_name / "collision.json"
        if collision_path.is_file():
            try:
                collision_flags = json.loads(collision_path.read_text(encoding="utf-8"))
                print(f"✓ Loaded collision flags from {collision_path.name}")
            except Exception as e:
                print(f"⚠️  Could not load collision.json: {e}")

    from pipeline_imports import ensure_llm_pipeline

    ensure_llm_pipeline()
    from llm_pipeline.cluster_stats import build_collision_cluster_stats

    # Ensure result_data is populated for collision stats
    if result_data is None and not is_payload_save:
        clustering_data2 = load_clustering_data(dataset_name, n_clusters)
        if clustering_data2:
            _, result_data = clustering_data2

    per_cluster_collision: Dict[str, Dict[str, Any]] = {}
    if collision_flags and result_data:
        for medoid in medoids:
            lb = medoid["cluster_label"]
            per_cluster_collision[lb] = build_collision_cluster_stats(
                int(lb), result_data, collision_flags
            )
            # Merge TTC / SPrET / parameter ranges (payload-save only) so the LLM
            # gets the full stats picture instead of n/a.
            metrics = payload_metric_stats.get(lb) or payload_metric_stats.get(str(lb))
            if metrics:
                per_cluster_collision[lb].update(metrics)
            cs = per_cluster_collision[lb]
            extra = ""
            if cs.get("min_ttc") is not None:
                extra = f", min_ttc={cs['min_ttc']}s"
            print(
                f"  ℹ cluster {lb}: collision_rate={cs['collision_rate']}% "
                f"({cs['collision_count']}/{cs['n_trials']} trials){extra}"
            )

    # --- Intra-cluster variance + cross-cluster boundary detection (Phase A/H) ---
    intra_by_cluster: Dict[str, Dict[str, Any]] = {}
    boundary_pairs_data: List[Dict[str, Any]] = []
    if result_data is not None and embeddings_data is not None:
        try:
            intra_by_cluster, boundary_pairs_data = compute_intra_variance_and_boundaries(
                embeddings_data,
                result_data,
                trial_index_map=trial_index_map,
                collision_flags=collision_flags,
            )
        except Exception as exc:
            print(f"  ⚠️  Intra-variance/boundary computation failed: {exc}")

    # --- Parameter-space (initial condition) closest pairs ---
    param_boundary_pairs: List[Dict[str, Any]] = []
    if result_data is not None and trials_meta:
        try:
            print("\n📐 Computing parameter-space (IC) closest pairs...")
            param_boundary_pairs = compute_parameter_space_boundaries(
                trials_meta,
                result_data,
                collision_flags=collision_flags,
                ego_scenario_params=ego_scenario_params or None,
            )
            from ic_pair_packs import annotate_param_boundary_pairs

            param_boundary_pairs = annotate_param_boundary_pairs(
                param_boundary_pairs
            )
            for bp in param_boundary_pairs:
                role = bp.get("card_role", "?")
                print(
                    f"  IC-boundary [{role}] c{bp['cluster_a']}↔c{bp['cluster_b']}: "
                    f"dist={bp['param_dist']:.4f} "
                    f"(trials {bp['trial_a']} ↔ {bp['trial_b']})"
                )
        except Exception as exc:
            print(f"  ⚠️  Parameter-space boundary computation failed: {exc}")

    # --- Step 6: Process each medoid ---
    medoid_scope = parse_cluster_scope(args.medoids)
    boundary_scope = parse_cluster_scope(args.emb_boundaries)
    param_boundary_scope = parse_cluster_scope(args.param_boundaries)
    outlier_scope = parse_cluster_scope(args.outliers)
    # Only attach IC neighbors when those folders will be materialized.
    if (
        param_boundary_pairs
        and intra_by_cluster
        and not (param_boundary_scope is not None and len(param_boundary_scope) == 0)
    ):
        attach_param_boundary_neighbors(intra_by_cluster, param_boundary_pairs)
    print(
        f"  Build scope: medoids={args.medoids}, "
        f"emb-boundaries={args.emb_boundaries}, "
        f"param-boundaries={args.param_boundaries}, "
        f"outliers={args.outliers}"
    )

    success_count = 0
    medoids_to_run = [
        m for m in medoids if cluster_in_scope(m["cluster_label"], medoid_scope)
    ]
    if medoid_scope is not None and len(medoid_scope) == 0:
        print("  ⏭  Medoids skipped (--medoids none)")
    elif not medoids_to_run:
        print(f"  ⚠️  No medoids match --medoids {args.medoids}")

    for medoid in medoids_to_run:
        if process_medoid(
            medoid,
            run_dir,
            xodr_path,
            parser_xodr,
            dataset_name=dataset_name,
            snapshot_output_px=args.snapshot_size,
            snapshot_border_frac=args.snapshot_border_frac,
            typography=bev_typography,
            max_snapshots=args.max_snapshots,
            collision_flags=collision_flags,
            cluster_collision_stats=per_cluster_collision.get(medoid["cluster_label"]),
            n_clusters=n_clusters,
            silhouette=silhouette,
            ego_zoom_radius=args.ego_zoom_radius,
            trials_meta=trials_meta,
            contact_clearance_m=args.contact_clearance_m,
            conflict_relevance_m=args.conflict_relevance_m,
            intra_variance=intra_by_cluster.get(medoid["cluster_label"]),
            conflict_window_s=args.conflict_window_s,
            conflict_window_before_s=args.conflict_window_before_s,
            conflict_window_after_s=args.conflict_window_after_s,
        ):
            success_count += 1

    # Medoids skipped: still patch cluster.json with IC neighbors
    if (
        medoid_scope is not None
        and len(medoid_scope) == 0
        and param_boundary_pairs
        and not (
            param_boundary_scope is not None and len(param_boundary_scope) == 0
        )
    ):
        patched = patch_cluster_json_param_neighbors(run_dir, param_boundary_pairs)
        if patched:
            print(f"\n📝 Patched {patched} cluster.json file(s) with IC neighbors")

    # --- Step 7a: Auxiliary trials (outlier + emb/IC boundaries) ---
    do_aux = (
        trial_index_map
        and (intra_by_cluster or boundary_pairs_data or param_boundary_pairs)
        and not (
            (outlier_scope is not None and len(outlier_scope) == 0)
            and (boundary_scope is not None and len(boundary_scope) == 0)
            and (param_boundary_scope is not None and len(param_boundary_scope) == 0)
        )
    )
    if do_aux:
        print("\n🔸 Processing auxiliary trials (outlier + emb/IC boundaries)…")
        try:
            process_auxiliary_trials(
                run_dir=run_dir,
                intra_by_cluster=intra_by_cluster,
                boundary_pairs=boundary_pairs_data,
                trial_index_map=trial_index_map,
                collision_flags=collision_flags,
                trials_meta=trials_meta,
                xodr_path=xodr_path,
                parser_xodr=parser_xodr,
                dataset_name=dataset_name,
                snapshot_output_px=args.snapshot_size,
                snapshot_border_frac=args.snapshot_border_frac,
                typography=bev_typography,
                max_snapshots=args.max_snapshots,
                ego_zoom_radius=args.ego_zoom_radius,
                contact_clearance_m=args.contact_clearance_m,
                conflict_relevance_m=args.conflict_relevance_m,
                conflict_window_s=args.conflict_window_s,
                conflict_window_before_s=args.conflict_window_before_s,
                conflict_window_after_s=args.conflict_window_after_s,
                outlier_scope=outlier_scope,
                boundary_scope=boundary_scope,
                param_boundary_pairs=param_boundary_pairs,
                param_boundary_scope=param_boundary_scope,
            )
        except Exception as exc:
            print(f"  ⚠️  Auxiliary trial processing failed: {exc}")
    elif trial_index_map and (intra_by_cluster or boundary_pairs_data or param_boundary_pairs):
        print(
            "  ⏭  Auxiliary trials skipped "
            "(--outliers none --emb-boundaries none --param-boundaries none)"
        )

    # --- Step 7b: Create manifest ---
    # Preserve existing IC pairs when --param-boundaries none (aux-only emb rebuilds).
    existing_manifest: Dict[str, Any] = {}
    manifest_path = run_dir / "manifest.json"
    if manifest_path.is_file():
        try:
            existing_manifest = json.loads(
                manifest_path.read_text(encoding="utf-8")
            )
        except Exception:
            existing_manifest = {}

    if param_boundary_scope is not None and len(param_boundary_scope) == 0:
        manifest_param_pairs = existing_manifest.get("param_boundary_pairs")
    else:
        manifest_param_pairs = param_boundary_pairs or None

    manifest = build_run_manifest(
        dataset_name, n_clusters, medoids, run_id,
        batch_id=batch_id_out,
        boundary_pairs=boundary_pairs_data or None,
        param_boundary_pairs=manifest_param_pairs,
    )
    with manifest_path.open("w") as f:
        json.dump(manifest, f, indent=2)

    # --- Step 8: Rule-based clustering quality score (Phase D) ---
    try:
        from pipeline_imports import ensure_llm_pipeline
        ensure_llm_pipeline()
        from llm_pipeline.clustering_quality_scorer import score_run_dir
        score_run_dir(run_dir)
    except Exception as exc:
        print(f"  ⚠️  Clustering quality scoring failed: {exc}")

    print(f"\n{'='*60}")
    print(f"✅ LLM dataset build complete!")
    print(f"   Processed: {success_count}/{len(medoids_to_run)} clusters")
    print(f"   Output: {run_dir}")
    print(f"{'='*60}")

    if medoids_to_run and success_count < len(medoids_to_run):
        print("\n⚠️  Some clusters failed to process. Check logs above.")
        sys.exit(1)


if __name__ == "__main__":
    main()
