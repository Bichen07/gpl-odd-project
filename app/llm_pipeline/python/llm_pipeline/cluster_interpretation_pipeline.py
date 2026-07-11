"""Phase 6 — cluster interpretation orchestration.

Builds on Phase 4 ``llm_artifacts`` layout and Phase 5 ``ClusterInterpreter``.
Used by the offline CLI (stage2b) and optionally after analyzer clustering (6a).
"""

from __future__ import annotations

import json
import os
import re
import sys
import zipfile
from collections import defaultdict
from datetime import datetime, timezone
from io import BytesIO
from pathlib import Path
from typing import Any, Dict, List, Optional, Tuple

import numpy as np
import yaml

from .analyzer_bridge import ensure_analyzer_src
from .cluster_stats import (
    build_collision_cluster_stats,
    cluster_label_value,
    trials_in_cluster_data,
    trial_collision_flag,
)
from .llm_factory import (
    DEFAULT_MODEL,
    api_key_env_hint,
    has_llm_credentials,
    llm_api_key_for_model,
    normalize_model_name,
)
from .paths import CLUSTERS_DIR, REPO_ROOT, RESULTS_DIR

ensure_analyzer_src()
from dataset_config import DATASETS, trial_id_to_csv_indices, xodr_path_for_dataset  # noqa: E402

LLM_ARTIFACTS_DIR = CLUSTERS_DIR


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


def _clustering_assignments(clustering_result: Any) -> Dict[str, Any]:
    if clustering_result is None:
        return {}
    if isinstance(clustering_result, dict):
        return clustering_result.get("data", clustering_result)
    data = getattr(clustering_result, "data", None)
    return data if isinstance(data, dict) else {}


def cluster_labels_for_trials(
    clustering_result: Any,
    trial_ids: List[str],
) -> np.ndarray:
    assignments = _clustering_assignments(clustering_result)
    labels = []
    for tid in trial_ids:
        item = assignments.get(tid)
        if item is None:
            labels.append(-1)
        else:
            labels.append(cluster_label_value(item))
    return np.asarray(labels, dtype=int)


def trials_in_cluster(
    clustering_result: Any,
    cluster_label: int,
) -> List[str]:
    return trials_in_cluster_data(
        _clustering_assignments(clustering_result),
        cluster_label,
    )


def load_collision_flags(dataset: str) -> Dict[str, Any]:
    path = REPO_ROOT / "alldatasets" / dataset / "collision.json"
    if not path.is_file():
        return {}
    return json.loads(path.read_text(encoding="utf-8"))


def load_clustering_result_json(dataset: str, n_clusters: int) -> Optional[Dict[str, Any]]:
    candidates = [
        REPO_ROOT / "alldatasets" / dataset / f"selectedClusteringResult_{n_clusters}Clusters.json",
    ]
    from .paths import RESULTS_DIR

    candidates.append(
        RESULTS_DIR / dataset / str(n_clusters) / "clustering" / "selectedClusteringResult.json"
    )
    for path in candidates:
        if path.is_file():
            return json.loads(path.read_text(encoding="utf-8"))
    return None


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


def action_log_from_description(cluster_dir: Path) -> str:
    """Preferred LLM text signal: the rule-based Labeller/Describer output.

    Uses `context.md` if present (header + description + action table), else
    `description.txt`, else `action.yaml` rendered to a compact timeline.
    Returns "" when none are available (caller falls back to observations).
    """
    context_md = cluster_dir / "context.md"
    if context_md.is_file():
        text = context_md.read_text(encoding="utf-8").strip()
        if text:
            return text

    description = cluster_dir / "description.txt"
    if description.is_file():
        text = description.read_text(encoding="utf-8").strip()
        if text:
            return text

    action_yaml = cluster_dir / "action.yaml"
    if action_yaml.is_file():
        try:
            import yaml

            data = yaml.safe_load(action_yaml.read_text(encoding="utf-8")) or {}
        except Exception:
            data = {}
        lines: List[str] = []
        for ag in data.get("agents", []):
            rel = ag.get("relation_to_ego")
            head = f"{ag.get('name', '?')} ({ag.get('role', 'npc')})"
            if rel:
                head += f" — {rel}"
            lines.append(head)
            for ev in ag.get("actions", []):
                st, et = ev.get("start_time"), ev.get("end_time")
                span = f"{st}s" if st == et else f"{st}-{et}s"
                lines.append(
                    f"  {span}: {ev.get('action')} (road {ev.get('road_id')}, lane {ev.get('lane_id')})"
                )
        if lines:
            return "\n".join(lines)

    return ""


def critical_time_from_action_log(action_log: str) -> Optional[float]:
    """Latest collision / near-miss / min-TTC timestamp mentioned in the log.

    The rule-based Describer emits an ``Interactions:`` section such as
    ``t=27.7s: near miss with track 2 (min distance 5.37 m, min TTC 0.0 s)``.
    Surfacing this time lets the LLM prompt explicitly demand coverage through
    the critical moment instead of stopping at the emergency-braking apex.
    """
    if not action_log:
        return None
    times: List[float] = []
    for m in re.finditer(
        r"t=(\d+(?:\.\d+)?)s?:[^\n]*(?:collision|near miss|min TTC)",
        action_log,
        re.I,
    ):
        try:
            times.append(float(m.group(1)))
        except ValueError:
            continue
    return max(times) if times else None


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


_SNAPSHOT_TS_RE = re.compile(r"_t_(\d+(?:\.\d+)?)(?:_|\.jpg|\.png)", re.I)


def extract_snapshot_timestamp(path_or_name: str) -> float:
    """Parse time from snapshot filename, e.g. trial_2951_t_13.13_ENTER_JUNCTION.jpg."""
    name = Path(path_or_name).name
    m = _SNAPSHOT_TS_RE.search(name)
    if m:
        return float(m.group(1))
    m2 = re.search(r"t[_=](\d+(?:\.\d+)?)", name, re.I)
    return float(m2.group(1)) if m2 else 0.0


def select_evenly_spaced_snapshots(
    paths: List[str],
    max_count: int,
) -> List[str]:
    """
    Pick up to *max_count* snapshots spread across the timeline (xosc_gen style).
    Each target time uses the closest unused real snapshot.
    """
    if not paths or max_count <= 0:
        return []
    sorted_paths = sorted(paths, key=extract_snapshot_timestamp)
    if len(sorted_paths) <= max_count:
        return sorted_paths

    times = [extract_snapshot_timestamp(p) for p in sorted_paths]
    t_min, t_max = times[0], times[-1]
    if max_count == 1:
        return [sorted_paths[0]]

    targets = [
        t_min + i * (t_max - t_min) / (max_count - 1)
        for i in range(max_count)
    ]
    chosen_indices: List[int] = []
    available = set(range(len(sorted_paths)))
    for tgt in targets:
        best_i = min(available, key=lambda i: abs(times[i] - tgt))
        chosen_indices.append(best_i)
        available.discard(best_i)

    chosen_indices.sort()
    return [sorted_paths[i] for i in chosen_indices]


def collect_bev_snapshot_paths(
    cluster_dir: Path,
    max_llm_snapshots: Optional[int] = None,
) -> List[str]:
    """Collect BEV image paths from a cluster dir.

    Supports both the V1 layout (``snapshots/``) and the legacy layout
    (``bev/``). When *max_llm_snapshots* is set, evenly subsample for LLM.
    """
    paths: List[str] = []
    for sub in ("snapshots", "bev"):
        d = cluster_dir / sub
        if d.is_dir():
            found = sorted(d.glob("*.jpg")) + sorted(d.glob("*.png"))
            if found:
                paths = [str(p) for p in found]
                break
    if not paths:
        return []

    paths.sort(key=extract_snapshot_timestamp)
    if max_llm_snapshots is not None and len(paths) > max_llm_snapshots:
        return select_evenly_spaced_snapshots(paths, max_llm_snapshots)
    return paths


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
    d: Dict[str, Any] = {
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
    if getattr(interp, "intra_consistency_score", None) is not None:
        d["intra_consistency_score"] = interp.intra_consistency_score
    if getattr(interp, "intra_notes", None) is not None:
        d["intra_notes"] = interp.intra_notes
    return d


def write_stub_interpretation(
    cluster_dir: Path,
    cluster_id: int,
    medoid_trial_id: str,
    cluster_stats: Dict[str, Any],
    reason: str,
) -> Path:
    out = cluster_dir / "cluster_interpretation.yaml"
    meta = cluster_dir / "interpretation_meta.json"

    # Do NOT clobber a previously successful (non-stub) interpretation with a
    # failure stub. A re-run that fails (e.g. the LLM intermittently returns
    # prose instead of YAML) must preserve the good result already on disk.
    if reason not in ("dry_run",) and meta.is_file():
        try:
            prior = json.loads(meta.read_text(encoding="utf-8"))
            if not prior.get("stub", False):
                print(
                    f"  ⚠️  cluster{cluster_id}: new run failed ({reason}); "
                    "keeping previous successful interpretation on disk."
                )
                return out
        except (json.JSONDecodeError, OSError):
            pass

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
    raw_yaml = yaml.safe_dump(payload, sort_keys=False)
    out.write_text(raw_yaml, encoding="utf-8")
    # Also persist a meta sidecar so the dashboard can reload results (stub or real)
    # without re-running the analysis.
    meta.write_text(
        json.dumps(
            {
                **payload,
                "token_usage": {"Prompt": 0, "Completion": 0, "Total": 0},
                "raw_yaml": raw_yaml,
                "stub": True,
            },
            indent=2,
        ),
        encoding="utf-8",
    )
    return out


def interpret_cluster_dir(
    cluster_dir: Path,
    cluster_id: int,
    dataset: str,
    model: str = DEFAULT_MODEL,
    dry_run: bool = False,
    heatmap_search_dirs: Optional[List[Path]] = None,
    api_key: Optional[str] = None,
    trial_mappings: Optional[Dict[str, Any]] = None,
    scenario_parameters: Optional[List[Dict]] = None,
    clustering_result: Any = None,
    max_llm_snapshots: Optional[int] = None,
    prompt_overrides: Optional[Dict[str, str]] = None,
    bev_selection: Optional[List[str]] = None,
    temperature: float = 0.1,
    do_review: bool = True,
) -> Optional[Path]:
    """Run interpretation for one cluster directory.

    Works for both the ``llm_artifacts/.../clusters/cluster_*`` layout and the
    builder's ``results/batch<id>/<k>_cluster_s=.../cluster<N>/`` layout.

    Optional UI overrides: ``prompt_overrides`` (dict of prompt text keyed
    system|common_sense|interaction|reviewer), ``bev_selection`` (explicit list
    of snapshot file names or paths to send to the LLM), ``temperature`` and
    ``do_review`` (skip the reviewer pass when False).
    """
    # Prefer the consolidated cluster.json (2026-06 layout); fall back to the
    # legacy stats.json / medoid.json triplet for older runs.
    stats: Dict[str, Any] = {}
    cluster_json_path = cluster_dir / "cluster.json"
    if cluster_json_path.is_file():
        doc = json.loads(cluster_json_path.read_text(encoding="utf-8"))
        c = doc.get("cluster", {})
        m = doc.get("medoid", {})
        stats = {
            "cluster_label": c.get("label"),
            "cluster_size": c.get("size"),
            "n_trials": c.get("n_trials"),
            "n_clusters": c.get("n_clusters"),
            "collision_rate": c.get("collision_rate"),
            "collision_count": c.get("collision_count"),
            "mean_ttc": c.get("mean_ttc"),
            "min_ttc": c.get("min_ttc"),
            "mean_spret": c.get("mean_spret"),
            "parameter_ranges": c.get("parameter_ranges") or {},
            "medoid_trial_id": m.get("trial_id"),
            "medoid_collided": m.get("collided"),
        }
    else:
        stats_path = cluster_dir / "stats.json"
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
        if clustering_result is not None
        else []
    )
    if trial_mappings and trial_ids:
        cluster_stats = build_cluster_stats(
            label, trial_ids, trial_mappings, scenario_parameters
        )
    elif stats.get("collision_rate") is not None:
        cluster_stats = {
            "cluster_label": label,
            "n_trials": stats.get("n_trials", stats.get("cluster_size", 1)),
            "collision_rate": float(stats.get("collision_rate", 0.0)),
            "mean_ttc": stats.get("mean_ttc"),
            "min_ttc": stats.get("min_ttc"),
            "mean_spret": stats.get("mean_spret"),
            "parameter_ranges": stats.get("parameter_ranges") or {},
        }
    else:
        collision_flags = load_collision_flags(dataset)
        clustering_json = clustering_result
        if clustering_json is None:
            n_k = int(stats.get("n_clusters") or 0)
            if n_k:
                clustering_json = load_clustering_result_json(dataset, n_k)
        if clustering_json and collision_flags:
            cluster_stats = build_collision_cluster_stats(
                label, clustering_json, collision_flags
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

    # Text signal for the LLM: prefer the rich Labeller/Describer output
    # (description.txt + action.yaml). Fall back to the crude per-frame log
    # derived from observations.json only for legacy runs.
    action_log = action_log_from_description(cluster_dir)
    if not action_log:
        obs_path = cluster_dir / "observations.json"
        observations = (
            json.loads(obs_path.read_text(encoding="utf-8")) if obs_path.is_file() else []
        )
        action_log = action_log_from_observations(observations)

    # Surface the single-trajectory (medoid) outcome separately from the
    # cluster-wide collision rate, plus the critical/closest-approach time, so
    # the LLM can reason about THIS trajectory and cover the full timeline.
    if stats.get("medoid_collided") is not None:
        cluster_stats["medoid_collided"] = bool(stats.get("medoid_collided"))
    crit_time = critical_time_from_action_log(action_log)
    if crit_time is not None:
        cluster_stats["medoid_critical_time"] = crit_time

    # Intra-cluster variance (Phase A) — read from cluster.json and pass to formatter.
    iv = stats.get("intra_variance") or {}
    if not iv and cluster_json_path.is_file():
        doc = json.loads(cluster_json_path.read_text(encoding="utf-8"))
        iv = doc.get("cluster", {}).get("intra_variance") or {}
    if iv:
        cluster_stats["intra_variance"] = iv
        # Load outlier description from the generated sub-directory (Phase I).
        outlier_ids = iv.get("outlier_trial_ids", [])
        if outlier_ids:
            outlier_desc_text = ""
            outlier_trials_dir = cluster_dir / "outlier_trials"
            for sub in sorted(outlier_trials_dir.glob("trial_*")) if outlier_trials_dir.is_dir() else []:
                desc_f = sub / "description.txt"
                if desc_f.is_file():
                    outlier_desc_text = desc_f.read_text(encoding="utf-8").strip()
                    break
            if outlier_desc_text:
                cluster_stats["outlier_description"] = outlier_desc_text

    # Explicit user selection of snapshots wins; otherwise auto-collect (with
    # optional even subsampling). Selection entries may be bare file names
    # (resolved under snapshots/ or bev/) or absolute/relative paths.
    bev_paths: List[str] = []
    if bev_selection:
        snap_dirs = [cluster_dir / "snapshots", cluster_dir / "bev"]
        for entry in bev_selection:
            p = Path(entry)
            if p.is_file():
                bev_paths.append(str(p))
                continue
            name = p.name
            for d in snap_dirs:
                cand = d / name
                if cand.is_file():
                    bev_paths.append(str(cand))
                    break
        bev_paths.sort(key=extract_snapshot_timestamp)
        print(f"[interpret] Using {len(bev_paths)} user-selected BEV snapshots")
    else:
        bev_paths = collect_bev_snapshot_paths(cluster_dir, max_llm_snapshots=max_llm_snapshots)
        if max_llm_snapshots is not None and bev_paths:
            print(
                f"[interpret] Using {len(bev_paths)} evenly spaced BEV snapshots "
                f"(max_llm_snapshots={max_llm_snapshots})"
            )
    # Prefer a genuine per-cluster variation image (trajectory overlay / MFPCA
    # heatmap) living next to the cluster; else fall back to alldatasets search.
    # If none exists we leave it None — we no longer reuse BEV[0] as a fake heatmap.
    heatmap = None
    for cand in (cluster_dir / "trajectory_overlay.png", cluster_dir / "mfpca_heatmap.png"):
        if cand.is_file():
            heatmap = cand
            break
    if heatmap is None:
        heatmap = resolve_mfpca_heatmap(dataset, cluster_id, heatmap_search_dirs)

    model = normalize_model_name(model)
    if dry_run or not has_llm_credentials(model, api_key):
        if dry_run:
            reason = "dry_run"
        else:
            reason = f"{api_key_env_hint(model)} not set"
        return write_stub_interpretation(
            cluster_dir, cluster_id, medoid_trial_id, cluster_stats, reason
        )

    if not bev_paths:
        return write_stub_interpretation(
            cluster_dir,
            cluster_id,
            medoid_trial_id,
            cluster_stats,
            "missing BEV snapshots",
        )

    from .cluster_interpreter import ClusterInterpreter

    xodr = xodr_path_for_dataset(dataset)
    from .paths import PROMPT_TEMPLATES_DIR

    prompt_dir = PROMPT_TEMPLATES_DIR
    interpreter = ClusterInterpreter(
        model=model,
        xodr_path=str(xodr) if xodr.is_file() else None,
        prompt_dir=str(prompt_dir),
        api_key=llm_api_key_for_model(model, api_key),
        temperature=temperature,
        prompt_overrides=prompt_overrides,
        do_review=do_review,
    )

    result = interpreter.analyze_cluster(
        cluster_id=cluster_id,
        cluster_stats=cluster_stats,
        medoid_trial_id=medoid_trial_id,
        medoid_action_log=action_log,
        bev_snapshot_paths=bev_paths,
        mfpca_heatmap_path=str(heatmap) if heatmap else None,
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
    model: str = DEFAULT_MODEL,
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


# ---------------------------------------------------------------------------
# V1 layout runner + CLI:  results/<dataset>/<n_clusters>/cluster<N>/
# ---------------------------------------------------------------------------

def run_stage2b_for_dataset_k(
    dataset: str,
    n_clusters: int,
    model: str = DEFAULT_MODEL,
    dry_run: bool = False,
    api_key: Optional[str] = None,
    max_llm_snapshots: Optional[int] = None,
) -> Dict[str, str]:
    """Interpret every ``cluster<N>`` folder under results/<dataset>/<k>/.

    Without an API key (or with ``dry_run``) a stub interpretation is written
    so the structure and downstream wiring can be validated offline. With
    ``GOOGLE_API_KEY`` (Gemini, default) or ``OPENAI_API_KEY`` (gpt-*) set,
    the real ClusterInterpreter runs.
    """
    model = normalize_model_name(model)
    from .paths import RESULTS_DIR

    run_dir = RESULTS_DIR / dataset / str(n_clusters)
    if not run_dir.is_dir():
        raise FileNotFoundError(
            f"No results dir: {run_dir}\n"
            f"Run: python3 app/analyzer/src/dataset_builder.py {dataset} {n_clusters}"
        )

    outputs: Dict[str, str] = {}
    search_dirs = [run_dir, REPO_ROOT, Path.cwd()]
    cluster_dirs = sorted(
        d for d in run_dir.glob("cluster*")
        if d.is_dir() and d.name[len("cluster"):].isdigit()
    )
    if not cluster_dirs:
        raise FileNotFoundError(f"No cluster<N> folders under {run_dir}")

    clustering_result = load_clustering_result_json(dataset, n_clusters)
    collision_flags = load_collision_flags(dataset)

    for cluster_dir in cluster_dirs:
        cluster_id = int(cluster_dir.name[len("cluster"):])
        out = interpret_cluster_dir(
            cluster_dir, cluster_id, dataset,
            model=model, dry_run=dry_run, heatmap_search_dirs=search_dirs,
            max_llm_snapshots=max_llm_snapshots,
            clustering_result=clustering_result,
        )
        if out and clustering_result and collision_flags:
            cs = build_collision_cluster_stats(
                cluster_id, clustering_result, collision_flags
            )
            print(
                f"  ℹ cluster{cluster_id}: collision_rate={cs['collision_rate']}% "
                f"({cs['collision_count']}/{cs['n_trials']} trials)"
            )
        if out:
            outputs[str(cluster_id)] = str(out)
            print(f"  ✓ cluster{cluster_id} → {out.name}")
    return outputs


def _dataset_for_results_dir(results_dir: Path, dataset: Optional[str], batch_id: Optional[int]) -> Optional[str]:
    """Resolve dataset name for a ``results/batch<id>/<k>_cluster_s=.../`` dir."""
    if dataset:
        return dataset
    bid = batch_id
    if bid is None:
        # results/batch<id>/<k>_cluster_s=.../  → grab the batch<id> component
        for part in results_dir.resolve().parts:
            m = re.fullmatch(r"batch(\d+)", part)
            if m:
                bid = int(m.group(1))
                break
    if bid is not None:
        try:
            from dataset_config import dataset_for_batch_id
            return dataset_for_batch_id(bid)
        except Exception:
            return dataset_from_batch_id(bid)
    return None


def run_results_dir_interpretation(
    results_dir: Path,
    dataset: Optional[str] = None,
    batch_id: Optional[int] = None,
    model: str = DEFAULT_MODEL,
    dry_run: bool = False,
    api_key: Optional[str] = None,
    clusters: Optional[List[int]] = None,
    prompt_overrides: Optional[Dict[str, str]] = None,
    images_by_cluster: Optional[Dict[str, List[str]]] = None,
    temperature: float = 0.1,
    do_review: bool = True,
    max_llm_snapshots: Optional[int] = None,
) -> Dict[str, str]:
    """Interpret every ``cluster<N>`` under a builder ``results/batch<id>/<k>_..`` dir.

    Each cluster's ``cluster.json`` already carries collision stats, so no external
    clustering/collision files are required. UI overrides (prompts, per-cluster image
    selection, temperature, review toggle) are threaded straight to the interpreter.
    """
    results_dir = Path(results_dir)
    if not results_dir.is_dir():
        raise FileNotFoundError(f"No results dir: {results_dir}")

    ds = _dataset_for_results_dir(results_dir, dataset, batch_id)
    if not ds:
        raise ValueError(
            "Could not resolve dataset for results dir; pass --dataset or --batch-id"
        )

    model = normalize_model_name(model)
    search_dirs = [results_dir, REPO_ROOT, Path.cwd()]
    cluster_dirs = sorted(
        d for d in results_dir.glob("cluster*")
        if d.is_dir() and d.name[len("cluster"):].isdigit()
    )
    if not cluster_dirs:
        raise FileNotFoundError(f"No cluster<N> folders under {results_dir}")

    outputs: Dict[str, str] = {}
    for cluster_dir in cluster_dirs:
        cid = int(cluster_dir.name[len("cluster"):])
        if clusters is not None and cid not in clusters:
            continue
        sel = None
        if images_by_cluster:
            sel = images_by_cluster.get(str(cid)) or images_by_cluster.get(cid)  # type: ignore[arg-type]
        out = interpret_cluster_dir(
            cluster_dir, cid, ds,
            model=model, dry_run=dry_run, heatmap_search_dirs=search_dirs,
            api_key=api_key, max_llm_snapshots=max_llm_snapshots,
            prompt_overrides=prompt_overrides, bev_selection=sel,
            temperature=temperature, do_review=do_review,
        )
        if out:
            outputs[str(cid)] = str(out)
            print(f"  ✓ cluster{cid} → {out.name}")
    return outputs


def main() -> int:
    import argparse

    ap = argparse.ArgumentParser(
        description="Step 5 — cluster interpretation on results/<dataset>/<k>/"
    )
    ap.add_argument("--dataset", required=True, help="dataset1 / dataset2 / dataset3")
    ap.add_argument("--n-clusters", type=int, required=True)
    ap.add_argument(
        "--model",
        nargs="+",
        default=[DEFAULT_MODEL],
        metavar="MODEL",
        help=(
            f"LLM model id (default: {DEFAULT_MODEL}). "
            "Multiple words allowed, e.g. --model gemini flash 2.5"
        ),
    )
    ap.add_argument("--api-key", default=None, help="API key (overrides env)")
    ap.add_argument("--dry-run", action="store_true",
                    help="force stub output even if an API key is set")
    ap.add_argument(
        "--max-llm-snapshots",
        type=int,
        default=10,
        metavar="N",
        help="Evenly subsample BEV images sent to LLM (default: 10; 0 = all on disk)",
    )
    args = ap.parse_args()

    model = normalize_model_name(" ".join(args.model))
    has_key = has_llm_credentials(model, args.api_key)
    mode = "DRY-RUN (stub)" if (args.dry_run or not has_key) else f"LIVE ({model})"
    print(f"🔹 Cluster interpretation — {args.dataset} k={args.n_clusters} — {mode}")
    if not has_key and not args.dry_run:
        print(
            f"   ℹ️  {api_key_env_hint(model)} not set → writing stub interpretations. "
            f"Export your key and re-run for real LLM output."
        )

    max_llm = args.max_llm_snapshots if args.max_llm_snapshots > 0 else None
    outputs = run_stage2b_for_dataset_k(
        args.dataset,
        args.n_clusters,
        model=model,
        dry_run=args.dry_run,
        api_key=args.api_key,
        max_llm_snapshots=max_llm,
    )
    print(f"✅ Wrote {len(outputs)} cluster_interpretation.yaml files")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
