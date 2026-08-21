"""S5 (part 1/2) — deterministic ``odd_chat_briefing.json`` builder.

No LLM call in this module. Assembles the fixed "knowledge base" that S5's
chat (``odd_chat.py``) is only ever allowed to cite from, per
implementation_plan.md §7.5. Mirrors the field extraction already used by
``cluster-run-report/route.ts`` so the Run Report tab and the chat briefing
never disagree about what a given YAML/JSON means.

Truncates long free-text fields (caption / consistency_note / contrast
explanation) to keep the briefing near the ~8-15k token budget in §7.5.
"""

from __future__ import annotations

import json
import re
from pathlib import Path
from typing import Any, Dict, List, Optional

import yaml

BRIEFING_FILENAME = "odd_chat_briefing.json"


def _read_json(p: Path) -> Optional[Dict[str, Any]]:
    if not p.is_file():
        return None
    try:
        return json.loads(p.read_text(encoding="utf-8"))
    except Exception:
        return None


def _read_yaml(p: Path) -> Optional[Dict[str, Any]]:
    if not p.is_file():
        return None
    try:
        return yaml.safe_load(p.read_text(encoding="utf-8")) or None
    except Exception:
        return None


def _resolve_artifact(cluster_dir: Path, name: str) -> Optional[Path]:
    """Nested (output/<name>) then flat (<name>) layout, matching cluster_paths.resolve_path."""
    nested = cluster_dir / "output" / name
    if nested.is_file():
        return nested
    flat = cluster_dir / name
    if flat.is_file():
        return flat
    return None


def _truncate(text: Optional[str], max_chars: int = 320) -> Optional[str]:
    if not text:
        return None
    text = " ".join(text.split())
    if len(text) <= max_chars:
        return text
    return text[: max_chars - 1].rstrip() + "\u2026"


def build_briefing(run_dir: Path) -> Dict[str, Any]:
    run_dir = Path(run_dir)
    folder = run_dir.name
    m = re.match(r"(\d+)_cluster_s=([-0-9.]+)", folder)
    k = int(m.group(1)) if m else None
    silhouette = float(m.group(2)) if m else None

    missing: List[str] = []

    quality = _read_json(run_dir / "clustering_quality.json")
    selection = _read_json(run_dir / "cluster_selection_eval.json")
    if selection is None:
        missing.append("no cluster_selection_eval.json — selection-eval not run")

    # ── Clusters ──────────────────────────────────────────────────────────
    clusters: List[Dict[str, Any]] = []
    for cluster_dir in sorted(run_dir.glob("cluster*")):
        cm = re.match(r"cluster(\d+)$", cluster_dir.name)
        if not cm or not cluster_dir.is_dir():
            continue
        cid = int(cm.group(1))

        cj_path = _resolve_artifact(cluster_dir, "cluster.json") or (
            cluster_dir / "raw" / "cluster.json" if (cluster_dir / "raw" / "cluster.json").is_file() else None
        )
        cj = _read_json(cj_path) if cj_path else None
        cluster_stats = (cj or {}).get("cluster") or {}

        medoid = _read_yaml(_resolve_artifact(cluster_dir, "medoid_trial.yaml") or Path("/nonexistent"))
        summary = _read_yaml(_resolve_artifact(cluster_dir, "cluster_summary.yaml") or Path("/nonexistent"))
        if medoid is None:
            missing.append(f"cluster{cid}: no medoid_trial.yaml")
        if summary is None:
            missing.append(f"cluster{cid}: no cluster_summary.yaml")

        clusters.append(
            {
                "id": cid,
                "label": (summary or {}).get("label"),
                "risk_level": (summary or {}).get("risk_level"),
                "n": cluster_stats.get("n_trials") or cluster_stats.get("size"),
                "collision_rate": cluster_stats.get("collision_rate"),
                "parameter_ranges": cluster_stats.get("parameter_ranges"),
                "neighborhood_separation": (summary or {}).get("neighborhood_separation"),
                "medoid_trial_id": (medoid or {}).get("trial_id"),
                "medoid_motive": (medoid or {}).get("primary_motive"),
                "medoid_outcome": (medoid or {}).get("outcome"),
                "summary_caption_short": _truncate((summary or {}).get("caption")),
                "consistency_note_short": _truncate((summary or {}).get("consistency_note")),
            }
        )

    # ── Parameter-space pairs ────────────────────────────────────────────
    pairs: List[Dict[str, Any]] = []
    pairs_root = run_dir / "parameter_space_pairs"
    if pairs_root.is_dir():
        for pack_dir in sorted(p for p in pairs_root.iterdir() if p.is_dir()):
            pair = _read_json(pack_dir / "pair.json")
            if pair is None:
                continue
            contrast = _read_yaml(_resolve_artifact(pack_dir, "contrast.yaml") or Path("/nonexistent"))
            divergence = (contrast or {}).get("critical_divergence") or {}
            outcome_a = (pair.get("left") or {}).get("outcome")
            outcome_b = (pair.get("right") or {}).get("outcome")
            pairs.append(
                {
                    "folder": pack_dir.name,
                    "clusters": [pair.get("cluster_a"), pair.get("cluster_b")],
                    "param_dist": pair.get("param_dist"),
                    "outcome_flip": outcome_a != outcome_b if outcome_a and outcome_b else None,
                    "separation_call": divergence.get("separation_call") or (contrast or {}).get("separation_call"),
                    "explanation_short": _truncate(
                        divergence.get("contrast_explanation")
                        or divergence.get("separation_reason")
                        or (contrast or {}).get("contrast_explanation")
                    ),
                }
            )
    if not pairs:
        missing.append("no parameter_space_pairs — pair contrast evidence unavailable")

    # ── S2/S3/S4 (may not exist yet) ──────────────────────────────────────
    boundary_doc = _read_json(run_dir / "odd_boundary_export.json")
    if boundary_doc is None:
        missing.append("no odd_boundary_export.json — run S2 (odd_export.export_run_dir)")
        boundary: Optional[Dict[str, Any]] = None
    else:
        collision_edges = (boundary_doc.get("collision_boundary") or {}).get("edges") or []
        top_edges = sorted(collision_edges, key=lambda e: e.get("param_dist", 1e9))[:5]
        boundary = {
            "kNN": boundary_doc.get("kNN"),
            "kpi": (boundary_doc.get("kpi") or {}).get("name"),
            "n_collision": len((boundary_doc.get("collision_boundary") or {}).get("boundary_trials") or []),
            "n_cluster": len((boundary_doc.get("cluster_boundary") or {}).get("boundary_trials") or []),
            "n_trials_considered": boundary_doc.get("n_trials_considered"),
            "n_trials_without_cluster_label": boundary_doc.get("n_trials_without_cluster_label"),
            "top_edges_short": top_edges,
        }

    rules_doc = _read_json(run_dir / "odd_parameter_rules.json")
    if rules_doc is None:
        missing.append("no odd_parameter_rules.json — run S3 (odd_rules.train_rules)")
        rules: List[Dict[str, Any]] = []
    else:
        rules = [
            {k2: r.get(k2) for k2 in ("id", "predicate", "predicted", "support", "precision", "boundary_trial_hits")}
            for r in (rules_doc.get("rules") or [])
        ]

    join_doc = _read_json(run_dir / "odd_boundary_pairs_join.json")
    pairs_touching_boundary = join_doc.get("n_pairs_touching_boundary") if join_doc else None

    findings = (selection or {}).get("findings") or []
    merge_candidates = (selection or {}).get("merge_candidates") or []

    doc = {
        "generated_at": _now_iso(),
        "run": {
            "batch_id": _batch_id_from_run_dir(run_dir),
            "folder": folder,
            "k": k,
            "silhouette": silhouette,
            "quality_score": (quality or {}).get("final_score"),
            "quality_rule_score": (quality or {}).get("rule_score"),
            "selection_score": (selection or {}).get("selection_score"),
        },
        "clusters": clusters,
        "pairs": pairs,
        "rules": rules,
        "boundary": boundary,
        "pairs_touching_boundary": pairs_touching_boundary,
        "findings": findings,
        "merge_candidates": merge_candidates,
        "open_questions": _harvest_open_questions(run_dir),
        "missing": missing,
    }

    out_path = run_dir / BRIEFING_FILENAME
    out_path.write_text(json.dumps(doc, indent=2), encoding="utf-8")
    return doc


def _batch_id_from_run_dir(run_dir: Path) -> Optional[int]:
    m = re.match(r"batch(\d+)$", run_dir.resolve().parent.name)
    return int(m.group(1)) if m else None


def _harvest_open_questions(run_dir: Path) -> List[str]:
    """Best-effort scrape of any ``open_questions:`` list left by medoid/pair/summary YAML."""
    out: List[str] = []
    for p in run_dir.glob("cluster*/output/*.yaml"):
        doc = _read_yaml(p)
        if isinstance(doc, dict) and isinstance(doc.get("open_questions"), list):
            out.extend(str(q) for q in doc["open_questions"])
    for p in run_dir.glob("parameter_space_pairs/*/output/*.yaml"):
        doc = _read_yaml(p)
        if isinstance(doc, dict) and isinstance(doc.get("open_questions"), list):
            out.extend(str(q) for q in doc["open_questions"])
    return out


def _now_iso() -> str:
    from datetime import datetime, timezone

    return datetime.now(timezone.utc).isoformat().replace("+00:00", "Z")
