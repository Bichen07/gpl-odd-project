"""clustering_quality_scorer.py — Phase D: Composite clustering quality score.

Computes a rule-based composite score for one ``<k>_cluster_s=<sil>/`` directory,
optionally augmenting it with an LLM behavioral layer when
``cross_cluster_eval.json`` exists.

Outputs:
  <run_dir>/clustering_quality.json
"""

from __future__ import annotations

import json
import math
from pathlib import Path
from typing import Any, Dict, List, Optional, Tuple


_OUTPUT_FILE = "clustering_quality.json"

# ---------------------------------------------------------------------------
# Rule-based sub-score weights (must sum to 1.0)
# ---------------------------------------------------------------------------
_WEIGHTS = {
    "silhouette": 0.25,
    "collision_spread": 0.20,
    "ttc_spread": 0.15,
    "param_nonoverlap": 0.15,
    "intra_consistency": 0.25,
}


def _load_cluster_docs(run_dir: Path) -> List[Dict[str, Any]]:
    docs: List[Dict[str, Any]] = []
    for cdir in sorted(run_dir.glob("cluster*")):
        if not (cdir.is_dir() and cdir.name[len("cluster"):].isdigit()):
            continue
        cj = cdir / "cluster.json"
        mj = cdir / "interpretation_meta.json"
        if not cj.is_file():
            continue
        try:
            cluster_doc = json.loads(cj.read_text(encoding="utf-8"))
        except Exception:
            continue
        meta: Dict[str, Any] = {}
        if mj.is_file():
            try:
                meta = json.loads(mj.read_text(encoding="utf-8"))
            except Exception:
                pass
        docs.append({"cluster_doc": cluster_doc, "meta": meta})
    return docs


def _safe_std(values: List[float]) -> float:
    if len(values) < 2:
        return 0.0
    mean = sum(values) / len(values)
    return math.sqrt(sum((v - mean) ** 2 for v in values) / len(values))


def _param_nonoverlap_ratio(docs: List[Dict[str, Any]]) -> float:
    """Fraction of parameters whose ranges are non-overlapping across all clusters.

    For each parameter present in all clusters, check if the ranges are
    fully separated (no overlap between any pair). Non-overlapping parameters
    indicate good cluster separation in scenario-parameter space.
    """
    all_params: Dict[str, List[Tuple[float, float]]] = {}
    for d in docs:
        c = d["cluster_doc"].get("cluster", {})
        for pname, bounds in (c.get("parameter_ranges") or {}).items():
            if bounds and len(bounds) >= 2:
                all_params.setdefault(pname, []).append(
                    (float(bounds[0]), float(bounds[1]))
                )

    if not all_params:
        return 0.5  # neutral when no parameter data

    nonoverlap_count = 0
    total = 0
    for pname, ranges in all_params.items():
        if len(ranges) < 2:
            continue
        total += 1
        sorted_ranges = sorted(ranges, key=lambda r: r[0])
        overlaps = False
        for i in range(len(sorted_ranges) - 1):
            if sorted_ranges[i][1] > sorted_ranges[i + 1][0]:
                overlaps = True
                break
        if not overlaps:
            nonoverlap_count += 1

    return (nonoverlap_count / total) if total else 0.5


def _mean_intra_consistency(
    docs: List[Dict[str, Any]],
    fallback_mean_std: Optional[float] = None,
) -> float:
    """Mean intra-cluster consistency score (0-1) from LLM scores or std_dist.

    LLM intra_consistency_score (1-10) wins; otherwise derive from
    std_dist_to_medoid (lower spread → higher consistency).
    """
    scores: List[float] = []
    std_dists: List[float] = []
    for d in docs:
        meta = d.get("meta", {})
        iv = d["cluster_doc"].get("cluster", {}).get("intra_variance") or {}

        llm_score = meta.get("intra_consistency_score")
        if llm_score is not None:
            try:
                scores.append(float(llm_score) / 10.0)
                continue
            except (TypeError, ValueError):
                pass

        std = iv.get("std_dist_to_medoid")
        if std is not None:
            std_dists.append(float(std))

    if scores:
        return sum(scores) / len(scores)

    if std_dists:
        max_std = max(std_dists)
        if max_std == 0:
            return 1.0
        norm = [(1.0 - s / max_std) for s in std_dists]
        return sum(norm) / len(norm)

    return 0.5  # neutral fallback


def compute_rule_score(
    run_dir: Path,
    docs: Optional[List[Dict[str, Any]]] = None,
) -> Tuple[float, Dict[str, Any]]:
    """Compute the rule-based composite score (0-100) for a clustering run.

    Returns (score, sub_scores_dict).
    """
    if docs is None:
        docs = _load_cluster_docs(run_dir)

    if not docs:
        return 0.0, {}

    # --- silhouette ---
    sil = None
    for d in docs:
        s = d["cluster_doc"].get("cluster", {}).get("silhouette")
        if s is not None:
            sil = float(s)
            break
    sil_score = max(0.0, min(1.0, (sil + 1) / 2)) if sil is not None else 0.5

    # --- collision_rate spread (high spread = distinct clusters) ---
    crs = [
        float(d["cluster_doc"].get("cluster", {}).get("collision_rate") or 0)
        for d in docs
    ]
    crs_valid = [c for c in crs if c is not None]
    cr_std = _safe_std(crs_valid)
    # Normalize: std of 50 pp → score 1.0; 0 → score 0
    cr_score = min(1.0, cr_std / 50.0)

    # --- TTC spread ---
    ttcs = [
        d["cluster_doc"].get("cluster", {}).get("mean_ttc")
        for d in docs
    ]
    ttcs_valid = [t for t in ttcs if t is not None]
    ttc_std = _safe_std([float(t) for t in ttcs_valid]) if len(ttcs_valid) >= 2 else 0.0
    ttc_score = min(1.0, ttc_std / 3.0)  # 3 s std → saturates

    # --- parameter non-overlap ---
    pno = _param_nonoverlap_ratio(docs)

    # --- intra consistency ---
    ic = _mean_intra_consistency(docs)

    sub = {
        "silhouette_raw": round(sil, 4) if sil is not None else None,
        "silhouette_score": round(sil_score, 3),
        "collision_rate_std": round(cr_std, 2),
        "collision_spread_score": round(cr_score, 3),
        "ttc_std": round(ttc_std, 3),
        "ttc_spread_score": round(ttc_score, 3),
        "param_nonoverlap_score": round(pno, 3),
        "intra_consistency_score": round(ic, 3),
    }

    composite = (
        _WEIGHTS["silhouette"] * sil_score
        + _WEIGHTS["collision_spread"] * cr_score
        + _WEIGHTS["ttc_spread"] * ttc_score
        + _WEIGHTS["param_nonoverlap"] * pno
        + _WEIGHTS["intra_consistency"] * ic
    ) * 100.0

    return round(composite, 2), sub


def compute_final_score(
    rule_score: float,
    cross_eval: Optional[Dict[str, Any]],
) -> Tuple[float, bool]:
    """Blend rule score with LLM evaluation when available.

    Returns (final_score, has_llm_eval).
    """
    if cross_eval is None or cross_eval.get("stub"):
        return rule_score, False

    sep = cross_eval.get("behavioral_separation_score")
    cla = cross_eval.get("boundary_clarity_score")
    if sep is None or cla is None:
        return rule_score, False

    llm_score = ((float(sep) + float(cla)) / 2.0) * 10.0  # → 0-100 scale
    final = 0.6 * rule_score + 0.4 * llm_score
    return round(final, 2), True


def score_run_dir(run_dir: Path) -> Optional[Path]:
    """Compute and write ``clustering_quality.json`` for *run_dir*.

    Reads ``cluster*/cluster.json``, optionally ``cross_cluster_eval.json``,
    and writes the composite score. Returns the output path.
    """
    run_dir = Path(run_dir)
    out_path = run_dir / _OUTPUT_FILE

    docs = _load_cluster_docs(run_dir)
    if not docs:
        print(f"[scorer] No cluster dirs found in {run_dir}")
        return None

    rule_score, sub_scores = compute_rule_score(run_dir, docs)

    # Parse folder name for k and silhouette
    folder = run_dir.name
    k: Optional[int] = None
    sil_folder: Optional[float] = None
    import re
    m = re.match(r"(\d+)_cluster(?:_s=([\d.]+))?", folder)
    if m:
        k = int(m.group(1))
        if m.group(2):
            sil_folder = float(m.group(2))

    cross_eval: Optional[Dict[str, Any]] = None
    cross_path = run_dir / "cross_cluster_eval.json"
    if cross_path.is_file():
        try:
            cross_eval = json.loads(cross_path.read_text(encoding="utf-8"))
        except Exception:
            pass

    final_score, has_llm = compute_final_score(rule_score, cross_eval)

    llm_score_val: Optional[float] = None
    if has_llm and cross_eval:
        sep = cross_eval.get("behavioral_separation_score")
        cla = cross_eval.get("boundary_clarity_score")
        if sep is not None and cla is not None:
            llm_score_val = round(((float(sep) + float(cla)) / 2.0) * 10.0, 2)

    doc: Dict[str, Any] = {
        "folder": folder,
        "k": k,
        "silhouette": sil_folder,
        "rule_score": rule_score,
        "llm_score": llm_score_val,
        "final_score": final_score,
        "rank": None,  # filled in by the API when comparing across configs
        "sub_scores": sub_scores,
        "has_llm_eval": has_llm,
    }
    out_path.write_text(json.dumps(doc, indent=2), encoding="utf-8")
    print(
        f"[scorer] {folder}: rule={rule_score:.1f}, "
        f"llm={llm_score_val if llm_score_val is not None else 'n/a'}, "
        f"final={final_score:.1f}"
    )
    return out_path
