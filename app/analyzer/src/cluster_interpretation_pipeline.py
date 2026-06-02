"""Phase 6 — cluster interpretation orchestration.

Builds on Phase 4 ``llm_artifacts`` layout and Phase 5 ``ClusterInterpreter``.
Used by the offline CLI (stage2b) and optionally after analyzer clustering (6a).
"""

from __future__ import annotations

import json
import os
import sys
import zipfile
from collections import defaultdict
from datetime import datetime, timezone
from io import BytesIO
from pathlib import Path
from typing import Any, Dict, List, Optional, Tuple

import numpy as np
import yaml

from repo_paths import ANALYZER_SRC, REPO_ROOT, CLUSTERS_DIR

if str(ANALYZER_SRC) not in sys.path:
    sys.path.insert(0, str(ANALYZER_SRC))

from dataset_config import DATASETS, trial_id_to_csv_indices, xodr_path_for_dataset

LLM_ARTIFACTS_DIR = CLUSTERS_DIR  # results/clusters/
LLM_PIPELINE_SRC = REPO_ROOT / "app" / "llm_pipeline" / "src"
if str(LLM_PIPELINE_SRC) not in sys.path:
    sys.path.insert(0, str(LLM_PIPELINE_SRC))


def dataset_from_batch_id(batch_id: int) -> Optional[str]:
    for name, cfg in DATASETS.items():
        if int(cfg["batch_id"]) == int(batch_id):
            return name
    return None


def pick_clustering_result(
    results: List[Any],
    n_clusters: Optional[int] = None,
) -> Optional[Any]:
    valid = [r for r in results if r is not None]
    if not valid:
        return None
    if n_clusters is not None:
        for r in valid:
            nc = getattr(r.task, "nClusters", 0) or 0
            if int(nc) == int(n_clusters):
                return r
    for r in valid:
        if getattr(r.task, "nClusters", 0):
            return r
    return valid[0]


def cluster_labels_for_trials(
    clustering_result: Any,
    trial_ids: List[str],
) -> np.ndarray:
    labels = []
    for tid in trial_ids:
        item = clustering_result.data.get(tid)
        if item is None:
            labels.append(-1)
        else:
            labels.append(int(item.label))
    return np.asarray(labels, dtype=int)


def trials_in_cluster(
    clustering_result: Any,
    cluster_label: int,
) -> List[str]:
    out = []
    for tid, item in clustering_result.data.items():
        if int(item.label) == int(cluster_label):
            out.append(str(tid))
    return out


def build_cluster_stats(
    cluster_label: int,
    trial_ids: List[str],
    trial_mappings: Dict[str, Any],
    scenario_parameters: Optional[List[Dict]] = None,
) -> Dict[str, Any]:
    """Aggregate trial-level metrics for LLM cluster context."""
    param_id_to_name: Dict[str, str] = {}
    if scenario_parameters:
        for p in scenario_parameters:
            pid = p.get("id") or p.get("parameterId")
            name = p.get("name") or str(pid)
            if pid is not None:
                param_id_to_name[str(pid)] = name

    collisions = 0
    ttc_vals: List[float] = []
    spret_vals: List[float] = []
    param_vals: Dict[str, List[float]] = defaultdict(list)

    for tid in trial_ids:
        trial = trial_mappings.get(tid)
        if not trial:
            continue
        for m in trial.get("testObjectives", {}).get("criticalityMetrics", []):
            kpi = (m.get("keyPerformanceIndicator") or {}).get("name", "")
            val = m.get("value")
            if val is None:
                continue
            if kpi == "collision" and float(val) > 0:
                collisions += 1
            elif kpi == "ttc_min":
                ttc_vals.append(float(val))
            elif kpi == "spret_min":
                spret_vals.append(float(min(val, 9.0)))

        for tp in trial.get("parameters", []):
            pid = str(tp.get("parameterId", ""))
            name = param_id_to_name.get(pid, pid or "param")
            param_vals[name].append(float(tp.get("value", 0)))

    parameter_ranges = {
        k: [float(min(v)), float(max(v))]
        for k, v in param_vals.items()
        if v
    }

    return {
        "cluster_label": int(cluster_label),
        "n_trials": len(trial_ids),
        "collision_rate": round(100.0 * collisions / max(len(trial_ids), 1), 2),
        "mean_ttc": round(float(np.mean(ttc_vals)), 3) if ttc_vals else None,
        "min_ttc": round(float(np.min(ttc_vals)), 3) if ttc_vals else None,
        "mean_spret": round(float(np.mean(spret_vals)), 3) if spret_vals else None,
        "parameter_ranges": parameter_ranges,
    }


def action_log_from_observations(observations: List[Dict[str, Any]]) -> str:
    """Lightweight action log when xosc_gen Labeller output is unavailable."""
    if not observations:
        return "No observation timeline available for medoid trial."

    lines: List[str] = []
    prev_speed: Optional[float] = None
    step = max(1, len(observations) // 16)

    for obs in observations[::step]:
        t = float(obs.get("time", obs.get("timestep", 0)))
        speed = float(obs.get("egoSpeed", 0))
        road = obs.get("egoRoadId", "?")
        lane = obs.get("egoLaneId", "?")

        note = ""
        if prev_speed is not None:
            dv = speed - prev_speed
            if dv < -0.8:
                note = " — decelerating"
            elif dv > 0.8:
                note = " — accelerating"
        prev_speed = speed

        lines.append(
            f"Time={t:.1f}s: Ego speed={speed:.1f} m/s, road={road}, lane={lane}{note}"
        )

        for ag in (obs.get("agents") or [])[:2]:
            lines.append(
                f"  Agent {ag.get('name', '?')}: speed={float(ag.get('speed', 0)):.1f} m/s"
            )

    return "\n".join(lines)


def resolve_mfpca_heatmap(
    dataset: str,
    cluster_id: int,
    search_dirs: Optional[List[Path]] = None,
) -> Optional[Path]:
    candidates: List[Path] = [
        REPO_ROOT / "alldatasets" / dataset / f"mfpca_heatmap_cluster{cluster_id}.png",
        REPO_ROOT / "alldatasets" / dataset / f"mfpca_heatmap_cluster{cluster_id}.jpg",
    ]
    for d in search_dirs or []:
        if not d or not d.exists():
            continue
        candidates.extend(sorted(d.glob("*fullheatmap*.png")))
        candidates.extend(sorted(d.glob("mfpca_heatmap*.png")))

    for p in candidates:
        if p.is_file():
            return p
    return None


def collect_bev_snapshot_paths(cluster_dir: Path) -> List[str]:
    bev_dir = cluster_dir / "bev"
    if not bev_dir.is_dir():
        return []
    paths = sorted(bev_dir.glob("*.jpg")) + sorted(bev_dir.glob("*.png"))
    return [str(p) for p in paths]


def compute_cluster_medoids(
    X_rep: np.ndarray,
    trial_ids: List[str],
    cluster_labels: np.ndarray,
) -> Dict[int, str]:
    from sklearn.metrics import pairwise_distances_argmin

    X = np.asarray(X_rep, dtype=np.float64)
    ids = np.asarray(trial_ids)
    labels = np.asarray(cluster_labels, dtype=int)
    medoids: Dict[int, str] = {}
    for label in sorted(set(labels.tolist()) - {-1}):
        mask = labels == label
        X_cluster = X[mask]
        ids_cluster = ids[mask]
        centroid = X_cluster.mean(axis=0, keepdims=True)
        idx = pairwise_distances_argmin(centroid, X_cluster, metric="euclidean")[0]
        medoids[int(label)] = str(ids_cluster[idx])
    return medoids


def medoids_to_process_list(
    medoid_map: Dict[int, str],
    clustering_result: Any,
    dataset: str,
) -> List[Dict[str, Any]]:
    medoids = []
    for label, trial_id in sorted(medoid_map.items()):
        batch_id, trial_index = None, None
        try:
            batch_id, trial_index = trial_id_to_csv_indices(dataset, trial_id)
        except Exception:
            batch_id, trial_index = None, None

        size = len(trials_in_cluster(clustering_result, label))
        medoids.append(
            {
                "cluster_label": str(label),
                "trial_id": str(trial_id),
                "batch_id": batch_id,
                "trial_index": trial_index,
                "size": size,
            }
        )
    return medoids


def interpretation_to_dict(interp: Any) -> Dict[str, Any]:
    return {
        "cluster_id": interp.cluster_id,
        "cluster_label": interp.cluster_label,
        "confidence": interp.confidence,
        "behavior_description": interp.behavior_description,
        "safety_assessment": interp.safety_assessment,
        "parameter_conditions": interp.parameter_conditions,
        "ego_perspective_summary": interp.ego_perspective_summary,
        "token_usage": interp.token_usage,
        "raw_yaml": interp.raw_yaml,
    }


def write_stub_interpretation(
    cluster_dir: Path,
    cluster_id: int,
    medoid_trial_id: str,
    cluster_stats: Dict[str, Any],
    reason: str,
) -> Path:
    payload = {
        "cluster_id": cluster_id,
        "cluster_label": f"Cluster {cluster_id} (offline stub)",
        "confidence": "low",
        "behavior_description": (
            f"LLM interpretation skipped ({reason}). "
            f"Cluster has {cluster_stats.get('n_trials', 0)} trials; "
            f"medoid trial {medoid_trial_id}."
        ),
        "safety_assessment": {
            "collision_rate_pct": cluster_stats.get("collision_rate"),
            "note": reason,
        },
        "parameter_conditions": cluster_stats.get("parameter_ranges", {}),
        "ego_perspective_summary": [],
    }
    out = cluster_dir / "cluster_interpretation.yaml"
    out.write_text(yaml.safe_dump(payload, sort_keys=False), encoding="utf-8")
    return out


def interpret_cluster_dir(
    cluster_dir: Path,
    cluster_id: int,
    dataset: str,
    model: str = "gpt-4o",
    dry_run: bool = False,
    heatmap_search_dirs: Optional[List[Path]] = None,
    trial_mappings: Optional[Dict[str, Any]] = None,
    scenario_parameters: Optional[List[Dict]] = None,
    clustering_result: Any = None,
) -> Optional[Path]:
    """Run interpretation for one ``llm_artifacts/.../clusters/cluster_*`` directory."""
    stats_path = cluster_dir / "stats.json"
    stats: Dict[str, Any] = {}
    if stats_path.is_file():
        stats = json.loads(stats_path.read_text(encoding="utf-8"))

    medoid_trial_id = str(stats.get("medoid_trial_id") or stats.get("trial_id", ""))
    if not medoid_trial_id:
        meta_path = cluster_dir / "medoid.json"
        if meta_path.is_file():
            medoid_trial_id = str(json.loads(meta_path.read_text()).get("trial_id", ""))

    label = int(stats.get("cluster_label", cluster_id))
    trial_ids = (
        trials_in_cluster(clustering_result, label)
        if clustering_result is not None and trial_mappings
        else []
    )
    if trial_mappings and trial_ids:
        cluster_stats = build_cluster_stats(
            label, trial_ids, trial_mappings, scenario_parameters
        )
    else:
        cluster_stats = {
            "n_trials": stats.get("cluster_size", 1),
            "collision_rate": 0.0,
            "mean_ttc": None,
            "min_ttc": None,
            "mean_spret": None,
            "parameter_ranges": {},
        }

    obs_path = cluster_dir / "observations.json"
    if obs_path.is_file():
        observations = json.loads(obs_path.read_text(encoding="utf-8"))
    else:
        observations = []
    action_log = action_log_from_observations(observations)

    bev_paths = collect_bev_snapshot_paths(cluster_dir)
    heatmap = resolve_mfpca_heatmap(dataset, cluster_id, heatmap_search_dirs)
    if heatmap is None and bev_paths:
        heatmap = Path(bev_paths[0])

    api_key = os.getenv("OPENAI_API_KEY", "").strip()
    if dry_run or not api_key:
        reason = "dry_run" if dry_run else "OPENAI_API_KEY not set"
        return write_stub_interpretation(
            cluster_dir, cluster_id, medoid_trial_id, cluster_stats, reason
        )

    if not bev_paths or heatmap is None:
        return write_stub_interpretation(
            cluster_dir,
            cluster_id,
            medoid_trial_id,
            cluster_stats,
            "missing BEV snapshots or MFPCA heatmap",
        )

    from cluster_interpreter import ClusterInterpreter

    xodr = xodr_path_for_dataset(dataset)
    prompt_dir = REPO_ROOT / "app" / "llm_pipeline" / "prompt_templates"
    interpreter = ClusterInterpreter(
        model=model,
        xodr_path=str(xodr) if xodr.is_file() else None,
        prompt_dir=str(prompt_dir),
    )

    result = interpreter.analyze_cluster(
        cluster_id=cluster_id,
        cluster_stats=cluster_stats,
        medoid_trial_id=medoid_trial_id,
        medoid_action_log=action_log,
        bev_snapshot_paths=bev_paths,
        mfpca_heatmap_path=str(heatmap),
    )
    if result is None:
        return write_stub_interpretation(
            cluster_dir,
            cluster_id,
            medoid_trial_id,
            cluster_stats,
            "LLM analysis failed",
        )

    out = cluster_dir / "cluster_interpretation.yaml"
    out.write_text(result.raw_yaml, encoding="utf-8")
    meta = cluster_dir / "interpretation_meta.json"
    meta.write_text(
        json.dumps(interpretation_to_dict(result), indent=2),
        encoding="utf-8",
    )
    return out


def run_stage2b_for_run_dir(
    run_dir: Path,
    dataset: str,
    model: str = "gpt-4o",
    dry_run: bool = False,
    trial_mappings: Optional[Dict[str, Any]] = None,
    scenario_parameters: Optional[List[Dict]] = None,
    clustering_result: Any = None,
) -> Dict[str, str]:
    """Interpret every cluster_* folder under ``run_dir/clusters``."""
    clusters_root = run_dir / "clusters"
    if not clusters_root.is_dir():
        raise FileNotFoundError(f"No clusters directory: {clusters_root}")

    outputs: Dict[str, str] = {}
    search_dirs = [run_dir, REPO_ROOT, Path.cwd()]

    for cluster_dir in sorted(clusters_root.glob("cluster_*")):
        if not cluster_dir.is_dir():
            continue
        label_str = cluster_dir.name.replace("cluster_", "")
        try:
            cluster_id = int(label_str)
        except ValueError:
            continue
        out = interpret_cluster_dir(
            cluster_dir,
            cluster_id,
            dataset,
            model=model,
            dry_run=dry_run,
            heatmap_search_dirs=search_dirs,
            trial_mappings=trial_mappings,
            scenario_parameters=scenario_parameters,
            clustering_result=clustering_result,
        )
        if out:
            outputs[label_str] = str(out)
    return outputs


def build_llm_run_from_analyzer(
    run_id: str,
    dataset: str,
    medoid_map: Dict[int, str],
    clustering_result: Any,
    n_clusters: int,
) -> Path:
    """Phase 4 dataset build for analyzer-derived medoids."""
    from renderer import XodrParser
    from dataset_builder import build_run_manifest, process_medoid

    run_dir = LLM_ARTIFACTS_DIR / run_id
    run_dir.mkdir(parents=True, exist_ok=True)

    medoids = medoids_to_process_list(medoid_map, clustering_result, dataset)
    xodr_path = xodr_path_for_dataset(dataset)
    import shutil

    map_dir = run_dir / "map"
    map_dir.mkdir(exist_ok=True)
    map_dest = map_dir / xodr_path.name
    if not map_dest.exists():
        shutil.copy(xodr_path, map_dest)

    parser = XodrParser(str(map_dest))

    for medoid in medoids:
        if medoid.get("batch_id") is None or medoid.get("trial_index") is None:
            continue
        process_medoid(
            medoid, run_dir, map_dest, parser, dataset_name=dataset
        )
        cluster_dir = run_dir / "clusters" / f"cluster_{medoid['cluster_label']}"
        medoid_json = {
            "trial_id": medoid["trial_id"],
            "batch_id": medoid["batch_id"],
            "trial_index": medoid["trial_index"],
        }
        (cluster_dir / "medoid.json").write_text(
            json.dumps(medoid_json, indent=2), encoding="utf-8"
        )
        stats_path = cluster_dir / "stats.json"
        if stats_path.is_file():
            stats = json.loads(stats_path.read_text())
            stats["medoid_trial_id"] = medoid["trial_id"]
            stats_path.write_text(
                json.dumps(stats, indent=2), encoding="utf-8"
            )

    manifest = build_run_manifest(dataset, n_clusters, medoids, run_id)
    (run_dir / "manifest.json").write_text(
        json.dumps(manifest, indent=2), encoding="utf-8"
    )
    return run_dir


def zip_interpretations(run_dir: Path) -> BytesIO:
    buf = BytesIO()
    with zipfile.ZipFile(buf, mode="w", compression=zipfile.ZIP_DEFLATED) as zf:
        for yml in sorted(run_dir.glob("clusters/cluster_*/cluster_interpretation.yaml")):
            zf.write(yml, arcname=yml.relative_to(run_dir).as_posix())
        manifest = run_dir / "manifest.json"
        if manifest.is_file():
            zf.write(manifest, arcname="manifest.json")
    buf.seek(0)
    return buf


def run_post_analyzer_cluster_interpretation(
    analyzer_run_id: str,
    batch_mappings: Dict[str, Any],
    trial_mappings: Dict[str, Any],
    mfpca_value: Dict[str, Any],
    clustering_results: List[Any],
    capture: Any = None,
) -> Optional[Path]:
    """6a hook: build artifacts + stage2b after dashboard clustering."""
    n_clusters_env = os.getenv("GPL_ODD_N_CLUSTERS")
    n_clusters = int(n_clusters_env) if n_clusters_env else None

    clustering_result = pick_clustering_result(clustering_results, n_clusters)
    if clustering_result is None:
        print("[Phase6] No clustering result — skipping interpretation")
        return None

    if n_clusters is None:
        n_clusters = int(getattr(clustering_result.task, "nClusters", 0) or 0)
    if n_clusters <= 0:
        print("[Phase6] Could not determine cluster count — skipping")
        return None

    batch_id = int(list(batch_mappings.keys())[0])
    dataset = os.getenv("GPL_ODD_DATASET") or dataset_from_batch_id(batch_id)
    if not dataset:
        print(f"[Phase6] Unknown batch_id {batch_id} — set GPL_ODD_DATASET")
        return None

    trial_ids = list(mfpca_value["trial_ids"])
    labels = cluster_labels_for_trials(clustering_result, trial_ids)
    medoid_map = compute_cluster_medoids(
        mfpca_value["X_rep"], trial_ids, labels
    )
    if not medoid_map:
        print("[Phase6] No medoids found")
        return None

    run_id = analyzer_run_id
    print(f"[Phase6] Building LLM artifacts for run {run_id} ({dataset}, k={n_clusters})")
    run_dir = build_llm_run_from_analyzer(
        run_id, dataset, medoid_map, clustering_result, n_clusters
    )

    batch = list(batch_mappings.values())[0]
    scenario_params = batch.get("scenario", {}).get("parameters", [])

    outputs = run_stage2b_for_run_dir(
        run_dir,
        dataset,
        dry_run=os.getenv("GPL_ODD_CLUSTER_INTERPRET_DRY_RUN", "").lower()
        in ("1", "true", "yes"),
        trial_mappings=trial_mappings,
        scenario_parameters=scenario_params,
        clustering_result=clustering_result,
    )

    stage2b_root = REPO_ROOT / "app" / "llm_pipeline" / "artifacts" / "stage2b_cluster_interpretation" / run_id
    stage2b_root.mkdir(parents=True, exist_ok=True)
    for label, path in outputs.items():
        src = Path(path)
        if src.is_file():
            dest = stage2b_root / f"cluster_{label}_interpretation.yaml"
            dest.write_text(src.read_text(encoding="utf-8"), encoding="utf-8")

    summary = {
        "run_id": run_id,
        "dataset": dataset,
        "n_clusters": n_clusters,
        "medoids": {str(k): v for k, v in medoid_map.items()},
        "interpreted": list(outputs.keys()),
        "created_at": datetime.now(timezone.utc).isoformat(),
    }
    (stage2b_root / "summary.json").write_text(
        json.dumps(summary, indent=2), encoding="utf-8"
    )

    if capture is not None:
        capture.record(
            "stage2b_cluster_interpretation",
            run_id,
            "complete",
            summary,
        )

    print(f"[Phase6] Wrote {len(outputs)} interpretations → {stage2b_root}")
    return run_dir
