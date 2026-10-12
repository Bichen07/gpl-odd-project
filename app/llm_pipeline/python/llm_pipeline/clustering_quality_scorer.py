"""clustering_quality_scorer.py — geometry score for one clustering.

Four equal pieces, each weight 0.25: silhouette, collision-rate spread,
time-to-collision spread, and tightness. No language-model call. The score is
the ranking number for one ``<k>_cluster_s=<sil>/`` directory.

Output:
  <run_dir>/cluster_analysis/clustering_quality.json
"""

from __future__ import annotations

import json
import math
import re
import sys
from pathlib import Path
from typing import Any, Dict, List, Optional, Tuple

from .paths import run_artifact_path, run_source_dir

_WEIGHTS = {
    "silhouette": 0.25,
    "collision_spread": 0.25,
    "ttc_spread": 0.25,
    "intra_consistency": 0.25,
}


def _load_cluster_docs(run_dir: Path) -> List[Dict[str, Any]]:
    analyzer_src = Path(__file__).resolve().parents[3] / "analyzer" / "src"
    if str(analyzer_src) not in sys.path:
        sys.path.insert(0, str(analyzer_src))
    from cluster_paths import resolve_path  # type: ignore

    docs: List[Dict[str, Any]] = []
    for cdir in sorted(run_source_dir(run_dir).glob("cluster*")):
        if not (cdir.is_dir() and cdir.name[len("cluster"):].isdigit()):
            continue
        cj = resolve_path(cdir, "cluster.json", must_exist=True)
        if cj is None:
            continue
        try:
            docs.append(json.loads(cj.read_text(encoding="utf-8")))
        except Exception:
            continue
    return docs


def _safe_std(values: List[float]) -> float:
    if len(values) < 2:
        return 0.0
    mean = sum(values) / len(values)
    return math.sqrt(sum((v - mean) ** 2 for v in values) / len(values))


def _mean_tightness(docs: List[Dict[str, Any]]) -> float:
    """Per cluster 1 − (spread around the medoid ÷ the largest cluster spread), averaged.

    Relative: the loosest cluster always scores 0. A run with no spread data
    scores 0.5.
    """
    std_dists: List[float] = []
    for doc in docs:
        iv = doc.get("cluster", {}).get("intra_variance") or {}
        std = iv.get("std_dist_to_medoid")
        if std is not None:
            std_dists.append(float(std))
    if not std_dists:
        return 0.5
    max_std = max(std_dists)
    if max_std == 0:
        return 1.0
    return sum(1.0 - s / max_std for s in std_dists) / len(std_dists)


def compute_score(docs: List[Dict[str, Any]]) -> Tuple[float, Dict[str, Any]]:
    """Return the composite score (0-100) and its sub-scores."""
    if not docs:
        return 0.0, {}

    sil = None
    for d in docs:
        s = d.get("cluster", {}).get("silhouette")
        if s is not None:
            sil = float(s)
            break
    sil_score = max(0.0, min(1.0, (sil + 1) / 2)) if sil is not None else 0.5

    # A 50-point spread of collision rates across clusters scores 1.
    crs = [float(d.get("cluster", {}).get("collision_rate") or 0) for d in docs]
    cr_std = _safe_std(crs)
    cr_score = min(1.0, cr_std / 50.0)

    # 3 s of spread in mean time-to-collision scores 1.
    ttcs = [
        float(t)
        for t in (d.get("cluster", {}).get("mean_ttc") for d in docs)
        if t is not None
    ]
    ttc_std = _safe_std(ttcs) if len(ttcs) >= 2 else 0.0
    ttc_score = min(1.0, ttc_std / 3.0)

    tightness = _mean_tightness(docs)

    sub = {
        "silhouette_raw": round(sil, 4) if sil is not None else None,
        "silhouette_score": round(sil_score, 3),
        "collision_rate_std": round(cr_std, 2),
        "collision_spread_score": round(cr_score, 3),
        "ttc_std": round(ttc_std, 3),
        "ttc_spread_score": round(ttc_score, 3),
        "intra_consistency_score": round(tightness, 3),
    }
    composite = (
        _WEIGHTS["silhouette"] * sil_score
        + _WEIGHTS["collision_spread"] * cr_score
        + _WEIGHTS["ttc_spread"] * ttc_score
        + _WEIGHTS["intra_consistency"] * tightness
    ) * 100.0
    return round(composite, 2), sub


def score_run_dir(run_dir: Path) -> Optional[Path]:
    """Compute and write ``clustering_quality.json`` for *run_dir*."""
    run_dir = Path(run_dir)
    out_path = run_artifact_path(run_dir, "quality", write=True)

    docs = _load_cluster_docs(run_dir)
    if not docs:
        print(f"[scorer] No cluster dirs found in {run_dir}")
        return None

    score, sub_scores = compute_score(docs)

    folder = run_dir.name
    k: Optional[int] = None
    sil_folder: Optional[float] = None
    m = re.match(r"(\d+)_cluster(?:_s=([\d.]+))?", folder)
    if m:
        k = int(m.group(1))
        if m.group(2):
            sil_folder = float(m.group(2))

    doc: Dict[str, Any] = {
        "folder": folder,
        "k": k,
        "silhouette": sil_folder,
        "score": score,
        "rank": None,  # filled in by the API when comparing across configs
        "sub_scores": sub_scores,
    }
    out_path.write_text(json.dumps(doc, indent=2), encoding="utf-8")
    print(f"[scorer] {folder}: score={score:.1f}")
    return out_path
