"""S4 — Join S2 boundary export trials with parameter-space pairs (by trial id only).

Per implementation_plan.md §2.2 (A2) the Explore kNN boundary filter (min-max
normalized L2) and the parameter-space pair distance (z-scored L2,
``dataset_builder.compute_parameter_space_boundaries``) are the same
*features* under a *different metric* — they must never be treated as
equal/comparable distances. This module therefore joins the two products the
only sound way: by **trial id membership**, not by distance value.

Reads:
  odd_boundary_export.json          (S2)
  parameter_space_pairs/*/pair.json (frozen product, built by dataset_builder)
  parameter_space_pairs/*/output/contrast.yaml (frozen LLM product, optional)

Writes:
  odd_boundary_pairs_join.json
"""

from __future__ import annotations

import json
from pathlib import Path
from typing import Any, Dict, List, Optional

try:
    import yaml
except ImportError:  # pragma: no cover
    yaml = None

EXPORT_FILENAME = "odd_boundary_export.json"
JOIN_FILENAME = "odd_boundary_pairs_join.json"


def _read_contrast_call(pack_dir: Path) -> Optional[Dict[str, Any]]:
    if yaml is None:
        return None
    out_dir = pack_dir / "output"
    if not out_dir.is_dir():
        return None
    for candidate in sorted(out_dir.glob("contrast*.yaml")):
        try:
            doc = yaml.safe_load(candidate.read_text(encoding="utf-8")) or {}
        except Exception:
            continue
        divergence = doc.get("critical_divergence") or {}
        return {
            "separation_call": divergence.get("separation_call") or doc.get("separation_call"),
            "separation_reason": divergence.get("separation_reason") or doc.get("separation_reason"),
            "source": candidate.name,
        }
    return None


def join_run_dir(run_dir: Path) -> Dict[str, Any]:
    run_dir = Path(run_dir)
    export_path = run_dir / EXPORT_FILENAME
    if not export_path.is_file():
        raise FileNotFoundError(f"Missing {export_path} — run S2 first.")
    export_doc = json.loads(export_path.read_text(encoding="utf-8"))

    collision_ids = {
        t["trial_id"] for t in (export_doc.get("collision_boundary") or {}).get("boundary_trials", [])
    }
    cluster_ids = {
        t["trial_id"] for t in (export_doc.get("cluster_boundary") or {}).get("boundary_trials", [])
    }

    pairs_root = run_dir / "parameter_space_pairs"
    packs: List[Dict[str, Any]] = []
    if pairs_root.is_dir():
        for pack_dir in sorted(p for p in pairs_root.iterdir() if p.is_dir()):
            pair_json = pack_dir / "pair.json"
            if not pair_json.is_file():
                continue
            pair = json.loads(pair_json.read_text(encoding="utf-8"))
            trial_a = str(pair.get("trial_a"))
            trial_b = str(pair.get("trial_b"))
            contrast = _read_contrast_call(pack_dir)
            packs.append(
                {
                    "folder": pack_dir.name,
                    "trial_a": trial_a,
                    "trial_b": trial_b,
                    "cluster_a": pair.get("cluster_a"),
                    "cluster_b": pair.get("cluster_b"),
                    "param_dist": pair.get("param_dist"),
                    "param_dist_tau": pair.get("param_dist_tau"),
                    "outcome_a": (pair.get("left") or {}).get("outcome"),
                    "outcome_b": (pair.get("right") or {}).get("outcome"),
                    "outcome_flip": (pair.get("left") or {}).get("outcome")
                    != (pair.get("right") or {}).get("outcome"),
                    "boundary_overlap": {
                        "trial_a_on_collision_boundary": trial_a in collision_ids,
                        "trial_b_on_collision_boundary": trial_b in collision_ids,
                        "trial_a_on_cluster_boundary": trial_a in cluster_ids,
                        "trial_b_on_cluster_boundary": trial_b in cluster_ids,
                    },
                    "contrast": contrast,
                }
            )

    n_packs_touching_boundary = sum(
        1
        for p in packs
        if any(p["boundary_overlap"].values())
    )

    doc = {
        "generated_at": export_doc.get("generated_at"),
        "batch_id": export_doc.get("batch_id"),
        "folder": export_doc.get("folder"),
        "kNN": export_doc.get("kNN"),
        "note": (
            "Join is by trial id membership only. Explore's boundary distance "
            "(min-max L2) and pair.param_dist (z-scored L2) are NOT the same "
            "metric — do not compare param_dist values across the two sources."
        ),
        "n_collision_boundary_trials": len(collision_ids),
        "n_cluster_boundary_trials": len(cluster_ids),
        "n_pairs": len(packs),
        "n_pairs_touching_boundary": n_packs_touching_boundary,
        "pairs": packs,
    }

    out_path = run_dir / JOIN_FILENAME
    out_path.write_text(json.dumps(doc, indent=2), encoding="utf-8")
    return {
        "join_path": str(out_path),
        "n_pairs": len(packs),
        "n_pairs_touching_boundary": n_packs_touching_boundary,
        "n_collision_boundary_trials": len(collision_ids),
        "n_cluster_boundary_trials": len(cluster_ids),
    }
