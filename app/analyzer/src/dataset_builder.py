#!/usr/bin/env python3
"""Build structured LLM dataset from medoid trials.

This script orchestrates Phase 4: for each cluster's medoid trial, it generates:
- trajectory.csv (xosc_gen format with roadId/laneId; raw timeline for BEV)
- action.yaml (structured semantic events) + description.txt (prose)
- BEV images (key timesteps) + map_overview.jpg
- cluster.json (merged cluster + medoid + scene metadata)
- context.md (consolidated LLM card: header + description + actions + snapshot index)

Output structure: results/batch<id>/<k>_cluster_s=<silhouette>/cluster<label>/
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
from typing import Any, Dict, List, Optional, Tuple
import numpy as np

import yaml
import requests

# Add analyzer src to path for flat-module imports
from repo_paths import ANALYZER_SRC, REPO_ROOT, RESULTS_DIR

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


def _fetch_payload_analysis(
    batch_id: int,
    save_doc_id: Optional[int] = None,
    duration_mode: str = "full",
    ego_name: str = "ITRI",
) -> Optional[Tuple[Dict, List, Dict, Optional[Dict]]]:
    """Fetch + parse a saved Dashboard analysis zip from Payload.

    Returns (scores, clustering_list, ego_data, selected_meta_raw) or None on error.
    Shared by load_clustering_from_payload_save() and list_clusterings_from_payload_save().
    """
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

    # 4. Unzip and parse trajectories.json (and optionally selected.json)
    try:
        with zipfile.ZipFile(io.BytesIO(dl.content)) as zf:
            zf_namelist = zf.namelist()
            json_name = next((n for n in zf_namelist if n.endswith(".json") and "selected" not in n), None)
            if json_name is None:
                json_name = next((n for n in zf_namelist if n.endswith(".json")), None)
            if json_name is None:
                print(f"❌ ERROR: No JSON file found in {doc_filename}")
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
        print(f"❌ ERROR: Failed to parse zip from {doc_filename}: {exc}")
        return None

    # 5. Navigate to ego → mfpca → duration_mode
    ego_data = analysis.get(ego_name)
    if ego_data is None:
        print(f"❌ ERROR: ego '{ego_name}' not in saved analysis. Available: {list(analysis.keys())}")
        return None

    mfpca_all = ego_data.get("mfpca", {})
    if duration_mode not in mfpca_all:
        print(f"❌ ERROR: duration_mode '{duration_mode}' not in mfpca. Available: {list(mfpca_all.keys())}")
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


def render_cluster_trajectory_overlay(
    out_path: Path,
    members: List[Tuple[int, int]],
    medoid_member: Optional[Tuple[int, int]] = None,
    title: str = "",
    max_members: int = 80,
) -> bool:
    """Render a per-cluster ego-trajectory variation image (spaghetti plot).

    Overlays every cluster member's ego path (faint blue) with the medoid path
    highlighted (red). This is the genuine "trajectory variation" signal that
    replaces the previous behaviour of mislabeling BEV[0] as an MFPCA heatmap.
    Best-effort: returns False (and writes nothing) if matplotlib is unavailable
    or no member CSV could be read.
    """
    try:
        import matplotlib
        matplotlib.use("Agg")
        import matplotlib.pyplot as plt
    except Exception as e:  # pragma: no cover
        print(f"  ⚠️  Trajectory overlay skipped (matplotlib unavailable: {e})")
        return False

    def _ego_xy(batch: int, idx: int):
        if not csv_exists(batch, idx):
            return None
        df = get_csv_road_data(batch, idx)
        if df is None or df.empty:
            return None
        ego = df[df["name"] == "Ego"].sort_values("time")
        if ego.empty:
            return None
        return ego["x"].to_numpy(), ego["y"].to_numpy()

    paths = []
    for (b, idx) in members[:max_members]:
        xy = _ego_xy(b, idx)
        if xy is not None:
            paths.append(xy)
    medoid_xy = _ego_xy(*medoid_member) if medoid_member else None
    if not paths and medoid_xy is None:
        return False

    fig, ax = plt.subplots(figsize=(6, 6), dpi=120)
    for xs, ys in paths:
        ax.plot(xs, ys, color="#1f77b4", alpha=0.18, linewidth=1.0)
    if medoid_xy is not None:
        mx, my = medoid_xy
        ax.plot(mx, my, color="#d62728", linewidth=2.5, label="medoid")
        ax.scatter([mx[0]], [my[0]], color="#2ca02c", s=36, zorder=5, label="start")
    ax.set_aspect("equal", adjustable="datalim")
    ax.set_title(title or f"Cluster ego-trajectory variation (n={len(paths)})")
    ax.set_xlabel("x [m]")
    ax.set_ylabel("y [m]")
    ax.grid(True, alpha=0.2)
    if medoid_xy is not None:
        ax.legend(loc="best", fontsize=8)
    fig.tight_layout()
    try:
        fig.savefig(out_path)
    finally:
        plt.close(fig)
    return True


def _cluster_members_from_result(
    result_data: Dict, cluster_id: int, trial_index_map: Dict[str, Tuple[int, int]]
) -> List[Tuple[int, int]]:
    """(batch, index) tuples for every member trial of *cluster_id* with a CSV map."""
    out: List[Tuple[int, int]] = []
    for tid, item in (result_data.get("data", {}) or {}).items():
        label = item.get("label") if isinstance(item, dict) else item
        if str(label) != str(cluster_id):
            continue
        bi = trial_index_map.get(str(tid))
        if bi:
            out.append(bi)
    return out


def _parse_silhouette_from_dirname(dirname: str) -> Optional[float]:
    m = re.search(r"_s=([\d.]+)", dirname)
    if not m:
        return None
    try:
        return float(m.group(1))
    except ValueError:
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
        cj = cdir / "cluster.json"
        if not cj.is_file():
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

        # Real trajectory-variation image (replaces the mislabeled BEV[0]).
        members = _cluster_members_from_result(result_data, cid, trial_index_map)
        med = doc.get("medoid", {}) or {}
        medoid_member = None
        if med.get("batch_id") is not None and med.get("trial_index") is not None:
            medoid_member = (int(med["batch_id"]), int(med["trial_index"]))
        if render_cluster_trajectory_overlay(
            cdir / "trajectory_overlay.png", members, medoid_member,
            title=f"Cluster {cid} ego-trajectory variation",
        ):
            print(f"     ↳ trajectory_overlay.png ({len(members)} members)")

    print(f"✅ Backfilled {patched} cluster.json file(s) in {rd}")
    return patched > 0


def list_clusterings_from_payload_save(
    batch_id: int,
    save_doc_id: Optional[int] = None,
    k: Optional[int] = None,
    duration_mode: str = "full",
    ego_name: str = "ITRI",
) -> bool:
    """Print every clustering candidate (index, k, silhouette, task params).

    If k is given, only candidates with that real cluster count are shown.
    Returns True on success. Used by `--list-clusterings`.
    """
    fetched = _fetch_payload_analysis(batch_id, save_doc_id, duration_mode, ego_name)
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
    """
    if k is not None and clustering_index is not None:
        print("❌ ERROR: --k and --clustering-index are mutually exclusive")
        return None

    fetched = _fetch_payload_analysis(batch_id, save_doc_id, duration_mode, ego_name)
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


def build_run_manifest(
    dataset: str,
    n_clusters: int,
    medoids: List[Dict[str, Any]],
    run_id: str,
    batch_id: Optional[int] = None,
) -> Dict[str, Any]:
    """Create the top-level manifest.json for this run."""
    return {
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
        scope_fontsize=args.scope_font_size,
        title_fontsize=args.title_font_size,
    )


def write_context_md(
    cluster_dir: Path,
    cluster_doc: Optional[Dict[str, Any]],
    action_data: Optional[Dict[str, Any]],
) -> None:
    """Write a single self-contained LLM context card for one cluster.

    Combines the cluster/medoid header, the prose description, the structured
    agent action timeline, and an ordered index of BEV snapshots so the model
    can read one file (plus the images) instead of stitching several artifacts.
    """
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

    # Scenario description (prose)
    desc_path = cluster_dir / "description.txt"
    if desc_path.is_file():
        lines.append("## Scenario description")
        lines.append("")
        lines.append(desc_path.read_text(encoding="utf-8").strip())
        lines.append("")

    # Structured agent action timeline
    if action_data and action_data.get("agents"):
        lines.append("## Agent actions")
        lines.append("")
        for ag in action_data["agents"]:
            role = ag.get("role", "npc")
            header = f"### {ag.get('name', '?')} ({ag.get('type', 'car')}, {role})"
            rel = ag.get("relation_to_ego")
            if rel:
                header += f" — {rel}"
            lines.append(header)
            lines.append("")
            lines.append("| time | action | road | lane |")
            lines.append("|------|--------|------|------|")
            for ev in ag.get("actions", []):
                st = ev.get("start_time")
                et = ev.get("end_time")
                tspan = f"{st:.1f}s" if st == et else f"{st:.1f}–{et:.1f}s"
                lines.append(
                    f"| {tspan} | {ev.get('action')} | {ev.get('road_id')} | {ev.get('lane_id')} |"
                )
            lines.append("")

    # Interactive (multi-agent) events from the Interactive Action Detector.
    interactions = (action_data or {}).get("interactions") or []
    if interactions:
        lines.append("## Interactions (multi-agent conflicts)")
        lines.append("")
        lines.append("| key time | type | with agent | detail |")
        lines.append("|----------|------|------------|--------|")
        for iv in interactions:
            det = []
            if iv.get("min_distance_m") is not None:
                det.append(f"min dist {iv['min_distance_m']}m")
            if iv.get("min_clearance_m") is not None:
                det.append(f"min clearance {iv['min_clearance_m']}m")
            if iv.get("min_ttc_s") is not None:
                det.append(f"min TTC {iv['min_ttc_s']}s")
            if iv.get("ego_reaction_accel") is not None:
                det.append(f"ego accel {iv['ego_reaction_accel']}m/s²")
            lines.append(
                f"| {iv.get('key_time')}s | {iv.get('type')} | "
                f"{iv.get('with_name') or ('track ' + str(iv.get('with_track_id')))} | {', '.join(det)} |"
            )
        lines.append("")

    # BEV snapshot index
    snap_dir = cluster_dir / "snapshots"
    snaps = sorted(p.name for p in snap_dir.glob("*.jpg")) if snap_dir.is_dir() else []
    if snaps or (cluster_dir / "map_overview.jpg").is_file():
        lines.append("## BEV snapshots (chronological)")
        lines.append("")
        if (cluster_dir / "map_overview.jpg").is_file():
            lines.append("- `map_overview.jpg` — whole-map view with the medoid trajectory")
        for name in snaps:
            lines.append(f"- `snapshots/{name}`")
        lines.append("")

    (cluster_dir / "context.md").write_text("\n".join(lines), encoding="utf-8")


def process_medoid(
    medoid: Dict[str, Any],
    run_dir: Path,
    xodr_path: Path,
    parser: XodrParser,
    dataset_name: str = "dataset1",
    snapshot_output_px: int = 1024,
    snapshot_border_frac: float = 0.10,
    typography=None,
    key_frame_mode: str = "action",
    max_snapshots: Optional[int] = None,
    semantic_only: bool = False,
    collision_flags: Optional[Dict[str, bool]] = None,
    cluster_collision_stats: Optional[Dict[str, Any]] = None,
    n_clusters: Optional[int] = None,
    silhouette: Optional[float] = None,
    ego_zoom_radius: float = 30.0,
    trials_meta: Optional[Dict[str, Any]] = None,
    contact_clearance_m: float = 0.5,
    conflict_relevance_m: float = 5.0,
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
    trajectory_path = cluster_dir / "trajectory.csv"
    try:
        registry = build_trajectory_csv(observations, parser, trajectory_path)
        print(f"  ✓ Generated trajectory.csv")
    except Exception as e:
        print(f"  ❌ Failed to build trajectory.csv: {e}")
        del df
        return False
    
    # 5. Build meta.yaml (intermediate input for the labeller; removed from output later)
    location_for_meta = Path(xodr_path).stem
    meta_path = cluster_dir / "meta.yaml"
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
    
    # 6. Action labelling (Step 2) + scenario description (Step 3)
    #    Rule-based, map-agnostic (taxonomy.py / labeller.py / description.py).
    from pipeline_imports import ensure_llm_pipeline

    ensure_llm_pipeline()
    from llm_pipeline.cluster_stats import trial_collision_flag

    action_data_for_ctx: Optional[Dict[str, Any]] = None
    trial_id = str(medoid.get("trial_id") or "")
    medoid_collided = trial_collision_flag(collision_flags or {}, trial_id) or bool(
        medoid.get("collided")
    )
    trial_info = (trials_meta or {}).get(trial_id) if trials_meta else None
    trial_events = trial_info.get("events") if isinstance(trial_info, dict) else None
    try:
        from labeller import label_trajectory, save_action_yaml
        from description import build_description, save_description_txt

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
        save_action_yaml(action_data, cluster_dir / "action.yaml")
        save_description_txt(build_description(action_data),
                            cluster_dir / "description.txt")
        if not map_yaml.is_file():
            print("  ⚠️  action/description built WITHOUT junction info — run "
                  "scripts/map_preprocess.py first")
        print(f"  ✓ Generated action.yaml + description.txt")
    except Exception as e:
        print(f"  ⚠️  Action/description generation failed: {e}")

    # 7. Generate BEV snapshots (Step 4 — MapPlotter + odrplot tracks)
    snapshots_dir = cluster_dir / "snapshots"
    try:
        from tier2_renderer import (
            Tier2BevRenderer,
            infer_collision_timestep,
            resolve_tier2_paths,
        )

        _xodr, map_tracks, location = resolve_tier2_paths(dataset_name)
        if map_tracks.is_file():
            action_yaml = cluster_dir / "action.yaml"
            collision_ts = None
            if medoid_collided:
                with open(meta_path) as mf:
                    meta_for_collision = yaml.safe_load(mf) or {}
                collision_ts = infer_collision_timestep(
                    df,
                    meta_agents=meta_for_collision.get("agents", []),
                    trial_events=trial_events,
                    collided=True,
                )
                if collision_ts is not None:
                    print(f"  ✓ Collision key time {collision_ts:.2f}s")

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
            snaps = tier2.render_trial_from_esmini_csv(
                batch_id,
                trial_index,
                str(snapshots_dir),
                n_snapshots=max_snapshots,
                file_prefix=f"trial_{trial_index}",
                overview_dir=str(cluster_dir),
                action_yaml_path=str(action_yaml) if action_yaml.is_file() else None,
                key_frame_mode=key_frame_mode,
                semantic_only=semantic_only,
                collision_timestep=collision_ts,
                collision_trial=medoid_collided,
            )
            print(f"  ✓ Generated {len(snaps)} BEV snapshots + map_overview.jpg")
        else:
            print(f"  ⚠️  BEV skipped — run: python3 scripts/generate_map_tracks.py")
    except Exception as e:
        print(f"  ⚠️  BEV generation failed: {e}")
    
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
        cluster_doc = {
            "cluster": {
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
            },
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
        with (cluster_dir / "cluster.json").open("w") as f:
            json.dump(cluster_doc, f, indent=2)
        print(f"  ✓ Saved cluster.json")
    except Exception as e:
        cluster_doc = None
        print(f"  ⚠️  Failed to write cluster.json: {e}")

    # 9. Consolidated LLM context card (description + actions + snapshot index)
    try:
        write_context_md(cluster_dir, cluster_doc, action_data_for_ctx)
        print(f"  ✓ Saved context.md")
    except Exception as e:
        print(f"  ⚠️  Failed to write context.md: {e}")

    # meta.yaml is an intermediate input to the labeller only — drop it from output.
    try:
        (cluster_dir / "meta.yaml").unlink(missing_ok=True)
    except Exception:
        pass

    # Clean up dataframe
    del df
    
    print(f"  ✅ Cluster {label} processing complete")
    return True


def main():
    parser = argparse.ArgumentParser(
        description="Build LLM dataset from medoid trials"
    )

    # --- Source mode ---
    parser.add_argument(
        "--source",
        choices=("alldatasets", "payload-save"),
        default="alldatasets",
        help="Where to load clustering data from (default: alldatasets)",
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
        "--k",
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
        default=1024,
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
        default=30.0,
        help="Right BEV panel zooms to ±this many metres around the ego "
             "(default: 30). Set 0 to disable the dual-panel composite.",
    )
    parser.add_argument(
        "--road-label-size",
        type=float,
        default=10,
        help="Font size (pt) for red road ID boxes on map_overview.jpg (default: 5.6)",
    )
    parser.add_argument(
        "--lane-label-size",
        type=float,
        default=12,
        help="Font size (pt) for black lane ID boxes on map_overview.jpg (default: 5.6)",
    )
    parser.add_argument(
        "--road-label-plain-size",
        type=float,
        default=10,
        help="Font size (pt) for unhighlighted road IDs on full-network hct_6.jpg (default: 4.8)",
    )
    parser.add_argument(
        "--agent-id-size",
        type=float,
        default=10,
        help="Font size (pt) for on-car agent ID circles in snapshots (default: 4.0)",
    )
    parser.add_argument(
        "--info-font-size",
        type=float,
        default=15.0,
        help="Font size (pt) for top-left agent list and top-right time label (default: 8.0)",
    )
    parser.add_argument(
        "--scope-font-size",
        type=float,
        default=15.0,
        help="Font size (pt) for bottom-left scope text in snapshots (default: 7.0)",
    )
    parser.add_argument(
        "--title-font-size",
        type=float,
        default=15.0,
        help="Font size (pt) for map_overview title (default: 7.0)",
    )
    parser.add_argument(
        "--from-run",
        type=str,
        default=None,
        metavar="PATH",
        help="Rebuild from an existing results run (reads manifest.json + "
             "clustering/selectedClusteringResult.json). Use with --batch-id to "
             "reload collision KPI / trial events from Payload.",
    )
    parser.add_argument(
        "--key-frame-mode",
        choices=("action", "hybrid", "heuristic"),
        default="action",
        help="BEV key frames: action.yaml events (default), hybrid (+ heuristics), or heuristic only",
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
        "--semantic-only",
        action="store_true",
        help="Only use semantic maneuver events from action.yaml (skip speed segments)",
    )

    args = parser.parse_args()

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
            dataset_name = f"batch{args.batch_id}"
            print(f"   ⚠️  No dataset config maps to batch {args.batch_id}; "
                  f"using '{dataset_name}' (BEV/map assets may be unavailable)")
        else:
            dataset_name = "unknown"

    bev_typography = build_bev_typography(args)
    run_id = args.run_id or datetime.utcnow().strftime("%Y%m%d_%H%M%S")

    print(f"🚀 Building LLM dataset for {dataset_name} (k={n_clusters})")
    print(f"   Source: {args.source}")
    print(f"   Run ID: {run_id}")

    result_data: Optional[Dict[str, Any]] = None
    trial_index_map: Optional[Dict[str, Tuple[int, int]]] = None
    payload_collision_flags: Optional[Dict[str, bool]] = None
    payload_metric_stats: Dict[str, Dict[str, Any]] = {}
    trials_meta: Dict[str, Any] = {}

    # --- Step 1: Load clustering data ---
    ref_silhouette: Optional[float] = None
    if args.from_run:
        ref_path = Path(args.from_run)
        if not ref_path.is_absolute():
            candidates = [RESULTS_DIR / ref_path, PROJECT_ROOT / ref_path]
            ref_path = next((p for p in candidates if p.is_dir()), ref_path)
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
            )
            if fetched:
                _scores, _clist, ego_data, _sel = fetched
                payload_collision_flags = _collision_flags_from_ego(ego_data)
                trials_meta = ego_data.get("trials") or {}
                payload_metric_stats = _cluster_metric_stats_from_ego(ego_data, result_data)
                n_coll = sum(1 for v in payload_collision_flags.values() if v)
                print(f"  Loaded collision KPI for {len(payload_collision_flags)} trials "
                      f"({n_coll} collided)")
            else:
                print("  ⚠️  Could not fetch Payload analysis — cluster collision stats may be incomplete")

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
            print(f"   bash scripts/build_llm_dataset.sh {dataset_name} {n_clusters} --trials '1:100,1:200,1:300'")
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
    silhouette: Optional[float] = args.silhouette or ref_silhouette
    if silhouette is None and result_data is not None:
        sv = (result_data.get("scores", {}) or {}).get("silhouetteScore")
        if isinstance(sv, (int, float)):
            silhouette = float(sv)
    cluster_dirname = f"{n_clusters}_cluster"
    if silhouette is not None:
        cluster_dirname += f"_s={silhouette:.4f}"
    run_dir = RESULTS_DIR / batch_label / cluster_dirname
    run_dir.mkdir(parents=True, exist_ok=True)
    print(f"📁 Output dir: {run_dir.relative_to(RESULTS_DIR.parent)}")

    # --- Shared map assets (results/map/), generated once by
    #     generate_map_tracks.py + map_preprocess.py. No per-run copy. ---
    shared_map_dir = RESULTS_DIR / "map"
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
        print(f"   Run: python3 scripts/generate_map_tracks.py --dataset {dataset_name}")
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

    # --- Step 6: Process each medoid ---
    success_count = 0
    for medoid in medoids:
        if process_medoid(
            medoid,
            run_dir,
            xodr_path,
            parser_xodr,
            dataset_name=dataset_name,
            snapshot_output_px=args.snapshot_size,
            snapshot_border_frac=args.snapshot_border_frac,
            typography=bev_typography,
            key_frame_mode=args.key_frame_mode,
            max_snapshots=args.max_snapshots,
            semantic_only=args.semantic_only,
            collision_flags=collision_flags,
            cluster_collision_stats=per_cluster_collision.get(medoid["cluster_label"]),
            n_clusters=n_clusters,
            silhouette=silhouette,
            ego_zoom_radius=args.ego_zoom_radius,
            trials_meta=trials_meta,
            contact_clearance_m=args.contact_clearance_m,
            conflict_relevance_m=args.conflict_relevance_m,
        ):
            success_count += 1

        # Per-cluster trajectory-variation overlay (real "heatmap" input for the LLM).
        if result_data is not None and trial_index_map:
            try:
                lb = medoid["cluster_label"]
                members = _cluster_members_from_result(result_data, int(lb), trial_index_map)
                medoid_member = (medoid["batch_id"], medoid["trial_index"])
                if render_cluster_trajectory_overlay(
                    run_dir / f"cluster{lb}" / "trajectory_overlay.png",
                    members, medoid_member,
                    title=f"Cluster {lb} ego-trajectory variation",
                ):
                    print(f"  ✓ trajectory_overlay.png ({len(members)} members)")
            except Exception as e:
                print(f"  ⚠️  Trajectory overlay failed: {e}")

    # --- Step 7: Create manifest ---
    manifest = build_run_manifest(dataset_name, n_clusters, medoids, run_id, batch_id=batch_id_out)
    manifest_path = run_dir / "manifest.json"
    with manifest_path.open("w") as f:
        json.dump(manifest, f, indent=2)

    print(f"\n{'='*60}")
    print(f"✅ LLM dataset build complete!")
    print(f"   Processed: {success_count}/{len(medoids)} clusters")
    print(f"   Output: {run_dir}")
    print(f"{'='*60}")

    if success_count < len(medoids):
        print("\n⚠️  Some clusters failed to process. Check logs above.")
        sys.exit(1)


if __name__ == "__main__":
    main()
