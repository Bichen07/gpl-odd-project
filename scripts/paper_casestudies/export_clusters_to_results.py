#!/usr/bin/env python3
"""Path A: export paper clustering from local analysis zips into results/.

Writes the artifacts your existing analyzer / LLM expect:

  results/batch<id>/[ego_]<k>_cluster_s=<sil>/
    clustering/selectedClusteringResult.json
    manifest.json
    cluster<N>/cluster.json   (skeleton; BEV filled later via --from-run)
    PAPER_SOURCE.json

Paper defaults (IEEE ITS 2026 figures):
  Case 1 batch7 ITRI k=4, ITRILatest k=3
  Case 2 batch9 ITRI k=4
  Case 3 batch8 ITRI k=6

Usage:
  python3 scripts/paper_casestudies/export_clusters_to_results.py
  python3 scripts/paper_casestudies/export_clusters_to_results.py --case 2
  python3 scripts/paper_casestudies/export_clusters_to_results.py --list

Then rebuild BEV when esmini CSVs exist:
  PAYLOAD_API_URL=<local-or-senior> \\
  python3 app/analyzer/src/dataset_builder.py --source payload-save \\
    --batch-id 9 --k 4 --from-run results/batch9/4_cluster_s=...
"""
from __future__ import annotations

import argparse
import json
import re
import sys
import zipfile
from collections import defaultdict
from datetime import datetime, timezone
from pathlib import Path
from typing import Any, Dict, List, Optional, Tuple

REPO = Path(__file__).resolve().parents[2]
DATA = REPO / "data" / "paper_casestudies"
RESULTS = REPO / "results"
MANIFEST = Path(__file__).resolve().parent / "manifest.json"

_DAT_PAT = re.compile(r"esmini_(\d+)_(\d+)\.dat")


def _load_analysis_zip(path: Path) -> Dict[str, Any]:
    with zipfile.ZipFile(path) as zf:
        names = zf.namelist()
        json_name = next(
            (n for n in names if n.endswith(".json") and "selected" not in n),
            None,
        )
        if json_name is None:
            json_name = next((n for n in names if n.endswith(".json")), None)
        if json_name is None:
            raise FileNotFoundError(f"No JSON in {path}")
        return json.loads(zf.read(json_name))


def _real_k(result: Dict[str, Any]) -> int:
    labels = {v["label"] for v in result.get("data", {}).values()} - {"-1"}
    return len(labels)


def _pick_clustering(
    clustering_list: List[Dict[str, Any]], k: int, silhouette: Optional[float]
) -> Tuple[int, Dict[str, Any]]:
    candidates: List[Tuple[float, int, Dict[str, Any]]] = []
    for idx, result in enumerate(clustering_list):
        if not result:
            continue
        if _real_k(result) != k:
            continue
        sil = float(result.get("scores", {}).get("silhouetteScore") or -1.0)
        candidates.append((sil, idx, result))
    if not candidates:
        raise ValueError(f"No clustering with k={k}")
    if silhouette is not None:
        sil, idx, selected = min(
            candidates, key=lambda c: abs(c[0] - silhouette)
        )
    else:
        sil, idx, selected = max(candidates, key=lambda c: c[0])
    return idx, selected


def _trial_index_map(ego_data: Dict[str, Any]) -> Dict[str, Tuple[int, int]]:
    out: Dict[str, Tuple[int, int]] = {}
    for tid, t_info in (ego_data.get("trials") or {}).items():
        if not isinstance(t_info, dict):
            continue
        edat = t_info.get("esminiDat")
        if not isinstance(edat, dict):
            continue
        m = _DAT_PAT.match(edat.get("filename") or "")
        if m:
            out[str(tid)] = (int(m.group(1)), int(m.group(2)))
    return out


def _collision_flags(ego_data: Dict[str, Any]) -> Dict[str, bool]:
    flags: Dict[str, bool] = {}
    for tid, t_info in (ego_data.get("trials") or {}).items():
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


def _compute_medoids(
    scores: Dict[str, Any],
    result: Dict[str, Any],
    trial_index_map: Dict[str, Tuple[int, int]],
    batch_id: int,
) -> List[Dict[str, Any]]:
    import numpy as np

    assignments = result.get("data") or {}
    trial_ids: List[str] = []
    embeddings: List[List[float]] = []
    labels: List[int] = []
    for tid, item in assignments.items():
        if tid not in scores:
            continue
        raw = item if isinstance(item, str) else item.get("label", str(item))
        if str(raw) == "-1":
            continue
        trial_ids.append(str(tid))
        embeddings.append(scores[tid])
        labels.append(int(raw))
    if not trial_ids:
        return []
    X = np.asarray(embeddings, dtype=float)
    labels_arr = np.asarray(labels, dtype=int)
    medoids: List[Dict[str, Any]] = []
    for label in sorted(set(labels)):
        mask = labels_arr == label
        Xc = X[mask]
        ids = np.asarray(trial_ids)[mask]
        centroid = Xc.mean(axis=0)
        dists = np.linalg.norm(Xc - centroid, axis=1)
        order = np.argsort(dists)
        chosen = None
        for rank, j in enumerate(order):
            tid = str(ids[j])
            if tid in trial_index_map or rank == 0:
                bid, tidx = trial_index_map.get(tid, (batch_id, -1))
                chosen = {
                    "cluster_label": str(label),
                    "trial_id": tid,
                    "batch_id": int(bid),
                    "trial_index": int(tidx),
                    "size": int(mask.sum()),
                    "medoid_rank": int(rank),
                    "is_exact_medoid": rank == 0,
                }
                if tid in trial_index_map:
                    break
        if chosen:
            medoids.append(chosen)
    return medoids


def _export_one(
    *,
    paper: str,
    batch_id: int,
    ego_name: str,
    k: int,
    zip_path: Path,
    silhouette: Optional[float],
) -> Path:
    analysis = _load_analysis_zip(zip_path)
    if ego_name not in analysis:
        raise KeyError(f"ego {ego_name} not in {zip_path.name}; have {list(analysis)}")
    ego = analysis[ego_name]
    mfpca = (ego.get("mfpca") or {}).get("full") or {}
    scores = mfpca.get("scores") or {}
    clustering_list = [c for c in (mfpca.get("clustering") or []) if c]
    idx, selected = _pick_clustering(clustering_list, k, silhouette)
    sil = float((selected.get("scores") or {}).get("silhouetteScore") or 0.0)
    tmap = _trial_index_map(ego)
    flags = _collision_flags(ego)
    medoids = _compute_medoids(scores, selected, tmap, batch_id)

    # batch7 dual-ego: keep ITRI under batch7/, other egos under batch7_<ego>/
    if ego_name == "ITRI":
        batch_label = f"batch{batch_id}"
    else:
        batch_label = f"batch{batch_id}_{ego_name}"
    run_name = f"{k}_cluster_s={sil:.4f}"
    run_dir = RESULTS / batch_label / run_name
    run_dir.mkdir(parents=True, exist_ok=True)
    (run_dir / "clustering").mkdir(exist_ok=True)

    # selectedClusteringResult.json — same shape as existing pipeline
    (run_dir / "clustering" / "selectedClusteringResult.json").write_text(
        json.dumps(selected, indent=2), encoding="utf-8"
    )

    members_by_label: Dict[str, List[str]] = defaultdict(list)
    for tid, item in (selected.get("data") or {}).items():
        lab = item.get("label") if isinstance(item, dict) else item
        if str(lab) == "-1":
            continue
        members_by_label[str(lab)].append(str(tid))

    clusters_manifest = []
    for m in medoids:
        lab = m["cluster_label"]
        clusters_manifest.append(
            {
                "label": lab,
                "trial_id": m["trial_id"],
                "batch_id": m["batch_id"],
                "trial_index": m["trial_index"],
                "size": m["size"],
            }
        )
        collided = flags.get(m["trial_id"], False)
        cj = {
            "cluster": {
                "label": lab,
                "size": m["size"],
                "n_trials": m["size"],
                "n_clusters": k,
                "silhouette": round(sil, 4),
                "collision_count": sum(
                    1 for t in members_by_label[lab] if flags.get(t)
                ),
                "collision_rate": None,
                "source": "paper_casestudy_export",
            },
            "medoid": {
                "trial_id": m["trial_id"],
                "batch_id": m["batch_id"],
                "trial_index": m["trial_index"],
                "medoid_rank": m.get("medoid_rank", 0),
                "is_exact_medoid": m.get("is_exact_medoid", True),
                "collided": collided,
            },
            "members": members_by_label[lab],
            "scene": {
                "dataset": f"paper_batch{batch_id}",
                "note": "Skeleton from paper zip; run dataset_builder --from-run to fill BEV",
            },
        }
        n = cj["cluster"]["size"] or 1
        cj["cluster"]["collision_rate"] = round(
            cj["cluster"]["collision_count"] / n, 4
        )
        cdir = run_dir / f"cluster{lab}"
        cdir.mkdir(exist_ok=True)
        (cdir / "cluster.json").write_text(
            json.dumps(cj, indent=2), encoding="utf-8"
        )

    manifest = {
        "run_id": datetime.now(timezone.utc).strftime("%Y%m%d_%H%M%S"),
        "timestamp": datetime.now(timezone.utc).isoformat(),
        "dataset": f"paper_batch{batch_id}",
        "batch_id": batch_id,
        "ego_name": ego_name,
        "n_clusters": k,
        "medoid_count": len(medoids),
        "clusters": clusters_manifest,
        "paper": paper,
        "source_zip": str(zip_path.relative_to(REPO)),
        "clustering_index": idx,
        "silhouette": round(sil, 4),
        "path_a": True,
        "note": (
            "Cluster labels match senior saved analysis (paper). "
            "BEV/action.yaml not generated yet — use dataset_builder --from-run."
        ),
    }
    (run_dir / "manifest.json").write_text(
        json.dumps(manifest, indent=2), encoding="utf-8"
    )
    (run_dir / "PAPER_SOURCE.json").write_text(
        json.dumps(
            {
                "paper": paper,
                "batch_id": batch_id,
                "ego_name": ego_name,
                "k": k,
                "clustering_index": idx,
                "silhouette": sil,
                "analysis_zip": str(zip_path.relative_to(REPO)),
                "n_trial_index_mapped": len(tmap),
                "n_collision_flags": len(flags),
            },
            indent=2,
        ),
        encoding="utf-8",
    )
    return run_dir


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--case", type=int, choices=(1, 2, 3), help="Export one case only")
    ap.add_argument("--list", action="store_true", help="List targets and exit")
    ap.add_argument(
        "--data-dir",
        type=Path,
        default=DATA,
        help="Mirror root (default data/paper_casestudies)",
    )
    args = ap.parse_args()

    cases = json.loads(MANIFEST.read_text(encoding="utf-8"))["cases"]
    if args.list:
        for c in cases:
            print(f"{c['paper']} batch={c['batch_id']} zip={c['analysis_zip']}")
            for e in c["egos"]:
                print(f"  ego={e['name']} k={e['k']} system={e.get('paper_system')}")
        return 0

    if not args.data_dir.is_dir():
        print(f"❌ Missing {args.data_dir}. Run download_mirror.py first.")
        return 1

    selected = cases
    if args.case is not None:
        selected = [c for c in cases if c["paper"].endswith(str(args.case))]
        if not selected:
            print(f"❌ No case {args.case}")
            return 1

    exported: List[Path] = []
    for c in selected:
        zip_path = args.data_dir / c["analysis_zip"]
        if not zip_path.is_file():
            print(f"❌ Missing {zip_path}")
            return 1
        for e in c["egos"]:
            print(
                f"→ {c['paper']} batch={c['batch_id']} ego={e['name']} k={e['k']}"
            )
            run_dir = _export_one(
                paper=c["paper"],
                batch_id=int(c["batch_id"]),
                ego_name=e["name"],
                k=int(e["k"]),
                zip_path=zip_path,
                silhouette=None,
            )
            print(f"  ✓ {run_dir.relative_to(REPO)}")
            exported.append(run_dir)

    print(f"\nDone: {len(exported)} run(s) under results/")
    print("Next: import media into local Payload for Dashboard Explore;")
    print("      when esmini CSVs exist, rebuild BEV with dataset_builder --from-run.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
