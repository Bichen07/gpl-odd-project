#!/usr/bin/env python3
"""Rebuild gated IC-pair packs for an existing results run directory.

Builds ``ic_pairs/cA-cB/`` (context.md + synced pair BEVs), updates manifest
annotations, and removes legacy ``param_boundary_c*`` folders.

Offline mode (default): reconstructs trial_index_map from existing
``highlight_trials/param_boundary_c*`` packs + medoid ``cluster.json``.

Example:
  conda activate analyzer
  cd gpl-odd-project
  PYTHONPATH=app/analyzer/src \\
    python scripts/rebuild_ic_pairs.py \\
      --results-dir results/batch9/4_cluster_s=0.7482
"""
from __future__ import annotations

import argparse
import json
import re
import sys
from pathlib import Path
from typing import Dict, Tuple

REPO = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO / "app" / "analyzer" / "src"))


def _index_from_existing_packs(run_dir: Path) -> Dict[str, Tuple[int, int]]:
    """Map payload trial_id → (batch_id, esmini_index) from packs / manifest."""
    run_dir = Path(run_dir)
    batch_id = 7
    for cj in run_dir.glob("cluster*/raw/cluster.json"):
        try:
            m = (json.loads(cj.read_text(encoding="utf-8")).get("medoid") or {})
            if m.get("batch_id") is not None:
                batch_id = int(m["batch_id"])
                break
        except Exception:
            continue

    idx: Dict[str, Tuple[int, int]] = {}

    # Prefer indices persisted on manifest pairs
    man = json.loads((run_dir / "manifest.json").read_text(encoding="utf-8"))
    for bp in man.get("param_boundary_pairs") or []:
        ta, tb = str(bp.get("trial_a")), str(bp.get("trial_b"))
        if bp.get("trial_index_a") is not None:
            idx[ta] = (
                int(bp.get("batch_id_a", batch_id)),
                int(bp["trial_index_a"]),
            )
        if bp.get("trial_index_b") is not None:
            idx[tb] = (
                int(bp.get("batch_id_b", batch_id)),
                int(bp["trial_index_b"]),
            )

    # New layout pair.json
    for pj in (run_dir / "ic_pairs").glob("c*-*/pair.json"):
        try:
            doc = json.loads(pj.read_text(encoding="utf-8"))
        except Exception:
            continue
        for side in ("left", "right"):
            s = doc.get(side) or {}
            tid = str(s.get("payload_trial_id") or "")
            if tid and s.get("trial_index") is not None:
                idx[tid] = (
                    int(s.get("batch_id", batch_id)),
                    int(s["trial_index"]),
                )

    # Legacy highlight_trials/param_boundary_c*
    folder_ti: Dict[Tuple[str, str], int] = {}
    for p in run_dir.glob("cluster*/highlight_trials/param_boundary_c*/trial_*"):
        m = re.match(r"cluster(\d+)$", p.parents[2].name)
        m2 = re.match(r"param_boundary_c(\d+)$", p.parent.name)
        m3 = re.match(r"trial_(\d+)$", p.name)
        if not (m and m2 and m3):
            continue
        folder_ti[(m.group(1), m2.group(1))] = int(m3.group(1))
    for bp in man.get("param_boundary_pairs") or []:
        ca, cb = str(bp["cluster_a"]), str(bp["cluster_b"])
        ta, tb = str(bp["trial_a"]), str(bp["trial_b"])
        if ta not in idx and (ca, cb) in folder_ti:
            idx[ta] = (batch_id, folder_ti[(ca, cb)])
        if tb not in idx and (cb, ca) in folder_ti:
            idx[tb] = (batch_id, folder_ti[(cb, ca)])

    for cj in run_dir.glob("cluster*/raw/cluster.json"):
        try:
            m = json.loads(cj.read_text(encoding="utf-8")).get("medoid") or {}
            tid = str(m.get("trial_id") or "")
            if tid and m.get("trial_index") is not None:
                idx[tid] = (int(m.get("batch_id", batch_id)), int(m["trial_index"]))
        except Exception:
            pass
    return idx


def main() -> None:
    ap = argparse.ArgumentParser(description="Rebuild gated ic_pairs/cA-cB packs")
    ap.add_argument("--results-dir", required=True, type=Path)
    ap.add_argument("--dataset", default=None)
    ap.add_argument("--tau", type=float, default=0.1)
    ap.add_argument(
        "--from-payload",
        action="store_true",
        help="Load trial map from Payload (needs network + --batch-id --k)",
    )
    ap.add_argument("--batch-id", type=int, default=None)
    ap.add_argument("--k", type=int, default=None)
    ap.add_argument("--s", type=float, default=None)
    args = ap.parse_args()

    run_dir = args.results_dir.resolve()
    manifest_path = run_dir / "manifest.json"
    if not manifest_path.is_file():
        raise SystemExit(f"manifest.json missing: {manifest_path}")
    manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
    pairs = manifest.get("param_boundary_pairs") or []
    if not pairs:
        raise SystemExit("manifest has no param_boundary_pairs")

    from dataset_config import dataset_for_batch_id, xodr_path_for_dataset
    from renderer import XodrParser
    from ic_pair_packs import process_ic_pair_packs

    dataset = args.dataset or manifest.get("dataset") or "dataset1"
    batch_id = args.batch_id or manifest.get("batch_id")
    if batch_id is not None and not dataset:
        dataset = dataset_for_batch_id(int(batch_id))

    collision_flags = {
        str(bp["trial_a"]): bool(bp.get("collided_a"))
        for bp in pairs
    }
    collision_flags.update(
        {
            str(bp["trial_b"]): bool(bp.get("collided_b"))
            for bp in pairs
        }
    )

    trial_index_map: Dict[str, Tuple[int, int]]
    trials_meta = None
    if args.from_payload:
        if args.batch_id is None or args.k is None:
            raise SystemExit("--from-payload requires --batch-id and --k")
        from dataset_builder import load_clustering_from_payload_save

        loaded = load_clustering_from_payload_save(
            batch_id=args.batch_id,
            k=args.k,
            silhouette=args.s,
        )
        if loaded is None:
            raise SystemExit("Failed to load clustering from payload-save")
        _e, _r, trial_index_map, collision_flags, _m, trials_meta = loaded
    else:
        trial_index_map = _index_from_existing_packs(run_dir)
        print(f"Offline trial_index_map: {len(trial_index_map)} entries")
        missing = [
            tid
            for bp in pairs
            for tid in (str(bp["trial_a"]), str(bp["trial_b"]))
            if tid not in trial_index_map
        ]
        if missing:
            print(f"  ⚠️  missing index for: {sorted(set(missing))}")

    xodr = xodr_path_for_dataset(dataset)
    parser = XodrParser(str(xodr))

    annotated = process_ic_pair_packs(
        run_dir=run_dir,
        param_boundary_pairs=pairs,
        trial_index_map=trial_index_map,
        collision_flags=collision_flags,
        trials_meta=trials_meta,
        xodr_path=Path(xodr),
        parser_xodr=parser,
        dataset_name=dataset,
        tau=args.tau,
        scope=None,
    )

    manifest["param_boundary_pairs"] = annotated
    manifest_path.write_text(json.dumps(manifest, indent=2), encoding="utf-8")
    print(f"Updated {manifest_path}")
    kept = [
        f"c{p['cluster_a']}-c{p['cluster_b']} [{p.get('card_role')}]"
        for p in annotated
        if p.get("ic_match")
    ]
    print("Matched packs:", kept)


if __name__ == "__main__":
    main()
