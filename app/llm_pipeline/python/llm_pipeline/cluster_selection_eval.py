"""cluster_selection_eval.py — behavior score for one clustering.

Answers whether the clusters are outcome-pure and whether their summary titles
differ. No language-model call. The language-model half is
``cross_cluster_eval.json``. ``clustering_quality_scorer`` blends geometry with
that half and does not use this score.

The weighted components are outcome purity and title distinctness. Pair outcome
flips and merge candidates are recorded and not scored.

Output:
  <run_dir>/cross_cluster/input/cluster_selection_eval.json
"""

from __future__ import annotations

import json
import re
from pathlib import Path
from typing import Any, Dict, List, Optional, Tuple

from .paths import run_artifact_path, run_source_dir

_OUTPUT_FILE = "cluster_selection_eval.json"

# Composite weights over the components that could be computed (renormalized
# when a component is unavailable, e.g. no medoid cards yet).
_WEIGHTS = {
    "outcome_purity": 0.50,
    "motive_distinctness": 0.50,
}

# A cluster counts as outcome-pure when its collision rate sits at either end.
_PURE_LOW = 5.0
_PURE_HIGH = 95.0
# Two clusters look like duplicates when their collision rates are this close…
_MERGE_COLLISION_TOL_PP = 10.0
# …and their parameter ranges overlap at least this much.
_MERGE_PARAM_OVERLAP = 0.8


def _load_clusters(run_dir: Path) -> List[Dict[str, Any]]:
    """Read every ``cluster<N>`` doc, newest layout first then flat fallback."""
    out: List[Dict[str, Any]] = []
    for cdir in sorted(run_source_dir(run_dir).glob("cluster*")):
        if not cdir.is_dir() or not cdir.name[len("cluster"):].isdigit():
            continue
        path = cdir / "raw" / "cluster.json"
        if not path.is_file():
            path = cdir / "cluster.json"
        if not path.is_file():
            continue
        try:
            doc = json.loads(path.read_text(encoding="utf-8"))
        except Exception:
            continue
        blk = dict(doc.get("cluster") or {})
        blk["_label"] = str(blk.get("label", cdir.name[len("cluster"):]))
        blk["_dir"] = cdir.name
        blk["_primary_motive"] = _primary_motive(cdir)
        out.append(blk)
    return out


def _named_resolution(doc: Dict[str, Any]) -> Optional[str]:
    """Named-vehicle ``resolution``, else legacy top-level ``interaction_resolution``."""
    cm = doc.get("conflict_metrics") if isinstance(doc.get("conflict_metrics"), dict) else {}
    partner = str(cm.get("vehicle") or cm.get("partner") or "").strip()
    for row in doc.get("agent_interactions") or []:
        if not isinstance(row, dict):
            continue
        if partner and str(row.get("agent") or "").strip() != partner:
            continue
        res = row.get("resolution") or row.get("interaction_resolution")
        if isinstance(res, str) and res.strip():
            return res.strip()
        break
    val = doc.get("interaction_resolution")
    if isinstance(val, str) and val.strip():
        return val.strip()
    return None


def _primary_motive(cluster_dir: Path) -> Optional[str]:
    """Behavior token for distinctness: summary label, else named resolution.

    JSON still stores this under ``primary_motives``. Motive codes are not used.
    """
    summary_path = cluster_dir / "output" / "cluster_summary.yaml"
    if summary_path.is_file():
        try:
            import yaml  # noqa: PLC0415 - optional dependency at import time

            summary = yaml.safe_load(summary_path.read_text(encoding="utf-8")) or {}
            label = summary.get("label") if isinstance(summary, dict) else None
            if isinstance(label, str) and label.strip():
                return label.strip()
        except Exception:
            pass
    path = cluster_dir / "output" / "medoid_trial.yaml"
    if not path.is_file():
        return None
    try:
        import yaml  # noqa: PLC0415 - optional dependency at import time

        doc = yaml.safe_load(path.read_text(encoding="utf-8")) or {}
    except Exception:
        return None
    if not isinstance(doc, dict):
        return None
    return _named_resolution(doc)


def _load_parameter_space_pairs(run_dir: Path) -> List[Dict[str, Any]]:
    pairs: List[Dict[str, Any]] = []
    for path in sorted((run_source_dir(run_dir) / "parameter_space_pairs").glob("*/pair.json")):
        try:
            pairs.append(json.loads(path.read_text(encoding="utf-8")))
        except Exception:
            continue
    return pairs


def _interval_overlap(a: Any, b: Any) -> Optional[float]:
    """Jaccard overlap of two ``[lo, hi]`` ranges, or None if unusable."""
    try:
        a_lo, a_hi = float(a[0]), float(a[1])
        b_lo, b_hi = float(b[0]), float(b[1])
    except (TypeError, ValueError, IndexError):
        return None
    inter = max(0.0, min(a_hi, b_hi) - max(a_lo, b_lo))
    union = max(a_hi, b_hi) - min(a_lo, b_lo)
    if union <= 0:
        return 1.0 if inter >= 0 else 0.0
    return inter / union


def _param_overlap(one: Dict[str, Any], two: Dict[str, Any]) -> Optional[float]:
    """Mean per-parameter range overlap between two clusters."""
    ra = one.get("parameter_ranges") or {}
    rb = two.get("parameter_ranges") or {}
    shared = [k for k in ra if k in rb]
    vals = [v for v in (_interval_overlap(ra[k], rb[k]) for k in shared) if v is not None]
    if not vals:
        return None
    return sum(vals) / len(vals)


def evaluate_run_dir(run_dir: Path) -> Optional[Dict[str, Any]]:
    """Compute the deterministic selection-quality report for *run_dir*."""
    run_dir = Path(run_dir)
    clusters = _load_clusters(run_dir)
    if not clusters:
        return None

    k = len(clusters)
    components: Dict[str, Optional[float]] = {}
    findings: List[str] = []

    # --- 1. Outcome purity ---------------------------------------------------
    rates = [
        (c["_label"], float(c["collision_rate"]))
        for c in clusters
        if c.get("collision_rate") is not None
    ]
    mixed: List[str] = []
    if rates:
        pure = 0
        for label, rate in rates:
            if rate <= _PURE_LOW or rate >= _PURE_HIGH:
                pure += 1
            else:
                mixed.append(f"cluster{label} ({rate:.1f}%)")
        components["outcome_purity"] = pure / len(rates)
        if mixed:
            findings.append(
                "Clusters mixing safe and colliding trials: "
                + ", ".join(mixed)
                + " — these are harder to caption as one behavior."
            )
        else:
            findings.append(
                f"All {len(rates)} clusters are outcome-pure "
                f"(collision rate <= {_PURE_LOW:.0f}% or >= {_PURE_HIGH:.0f}%)."
            )
    else:
        components["outcome_purity"] = None

    # --- 2. Motive distinctness ---------------------------------------------
    motives = {c["_label"]: c["_primary_motive"] for c in clusters}
    known = {lab: m for lab, m in motives.items() if m}
    by_motive: Dict[str, List[str]] = {}
    for label, motive in known.items():
        by_motive.setdefault(motive, []).append(label)
    if known:
        components["motive_distinctness"] = len(by_motive) / len(known)
        dupes = {m: labs for m, labs in by_motive.items() if len(labs) > 1}
        if dupes:
            findings.append(
                "Repeated behavior tokens (summary label or resolution): "
                + "; ".join(
                    f"{m} in clusters {', '.join(sorted(labs))}" for m, labs in dupes.items()
                )
                + " — distinct clusters telling the same story may be over-splitting."
            )
        else:
            findings.append(
                f"All {len(known)} captioned clusters carry a distinct resolution or summary label."
            )
        if len(known) < k:
            findings.append(
                f"{k - len(known)} of {k} clusters have no usable resolution or summary label yet "
                "(medoid card missing)."
            )
    else:
        components["motive_distinctness"] = None
        findings.append(
            "No medoid cards found — behavior distinctness not evaluated. "
            "Run the medoid product first."
        )

    # --- 3. Near-identical pairs (recorded, not scored) ----------------------
    # A collision flip is not a behavior score: two different collision
    # behaviors do not flip. The list stays on the report for inspection.
    pairs = _load_parameter_space_pairs(run_dir)
    matched = [
        p for p in pairs
        if p.get("parameter_space_match", p.get("ic_match"))
    ]
    flips: List[Dict[str, Any]] = []
    for p in matched:
        a, b = p.get("collided_a"), p.get("collided_b")
        differs = isinstance(a, bool) and isinstance(b, bool) and a != b
        flips.append(
            {
                "folder": p.get("folder"),
                "clusters": [p.get("cluster_a"), p.get("cluster_b")],
                "param_dist": p.get("param_dist"),
                "outcome_flip": bool(differs),
            }
        )

    # --- 4. Merge candidates -------------------------------------------------
    merge_candidates: List[Dict[str, Any]] = []
    for i in range(len(clusters)):
        for j in range(i + 1, len(clusters)):
            one, two = clusters[i], clusters[j]
            m_one, m_two = one["_primary_motive"], two["_primary_motive"]
            if not m_one or not m_two or m_one != m_two:
                continue
            r_one, r_two = one.get("collision_rate"), two.get("collision_rate")
            if r_one is None or r_two is None:
                continue
            if abs(float(r_one) - float(r_two)) > _MERGE_COLLISION_TOL_PP:
                continue
            overlap = _param_overlap(one, two)
            if overlap is None or overlap < _MERGE_PARAM_OVERLAP:
                continue
            merge_candidates.append(
                {
                    "clusters": [one["_label"], two["_label"]],
                    "shared_motive": m_one,
                    "collision_rate": [float(r_one), float(r_two)],
                    "param_overlap": round(overlap, 3),
                }
            )
    # Same title, similar collision rate, and range overlap stay in
    # ``merge_candidates``. They are not a score: a repeated title alone
    # does not meet that triple, so the old 0/1 flag stayed 1 anyway.

    # --- Composite -----------------------------------------------------------
    usable = {k_: v for k_, v in components.items() if v is not None}
    if usable:
        total_w = sum(_WEIGHTS[k_] for k_ in usable)
        score = sum(_WEIGHTS[k_] * v for k_, v in usable.items()) / total_w
        selection_score: Optional[float] = round(100.0 * score, 2)
    else:
        selection_score = None
    if usable and len(usable) < len(_WEIGHTS):
        findings.append(
            f"Score renormalized over {len(usable)} of {len(_WEIGHTS)} components — only "
            "compare it against candidates evaluated on the same component set."
        )

    mean_overlap_vals = [
        v
        for v in (
            _param_overlap(clusters[i], clusters[j])
            for i in range(len(clusters))
            for j in range(i + 1, len(clusters))
        )
        if v is not None
    ]

    return {
        "k": k,
        "selection_score": selection_score,
        "components": {k_: (round(v, 3) if v is not None else None) for k_, v in components.items()},
        "weights": _WEIGHTS,
        "evaluated_components": sorted(usable),
        "primary_motives": motives,
        "mixed_outcome_clusters": mixed,
        "merge_candidates": merge_candidates,
        "parameter_space_pairs": flips,
        "mean_param_overlap": (
            round(sum(mean_overlap_vals) / len(mean_overlap_vals), 3) if mean_overlap_vals else None
        ),
        "findings": findings,
    }


def write_eval(run_dir: Path) -> Optional[Path]:
    """Compute and persist ``cluster_selection_eval.json``."""
    run_dir = Path(run_dir)
    report = evaluate_run_dir(run_dir)
    if report is None:
        print(f"[selection-eval] no cluster dirs in {run_dir}")
        return None
    out_path = run_artifact_path(run_dir, "selection_eval", write=True)
    out_path.write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
    score = report.get("selection_score")
    print(
        f"[selection-eval] {run_dir.name}: "
        f"score={score if score is not None else 'n/a'} "
        f"components={report.get('evaluated_components')}"
    )
    return out_path


def _trim(text: Any, limit: int = 700) -> str:
    """Collapse a narrative field to a single prompt-friendly paragraph."""
    body = " ".join(str(text or "").split())
    return body[:limit] + ("…" if len(body) > limit else "")


def medoid_card_block(cluster_dir: Path) -> Optional[str]:
    """Single-cluster medoid-card text block, or ``None`` if not built yet.

    Factored out of :func:`medoid_digest` so callers that need just ONE
    cluster's card (e.g. the cluster-summary prompt's own-medoid and
    neighbor-medoid inputs) don't have to re-parse every cluster in the run.
    """
    try:
        import yaml
    except Exception:
        return "(pyyaml unavailable)"

    path = Path(cluster_dir) / "output" / "medoid_trial.yaml"
    if not path.is_file():
        return None
    try:
        doc = yaml.safe_load(path.read_text(encoding="utf-8")) or {}
    except Exception:
        return None
    cm = doc.get("conflict_metrics") or {}
    interactions = doc.get("agent_interactions") or []
    ix_txt = "; ".join(
        f"{row.get('agent')}: {row.get('resolution') or row.get('interaction_resolution') or 'n/a'}"
        for row in interactions
        if isinstance(row, dict) and row.get("agent")
    )
    tl = doc.get("decision_timeline") or []
    ev_txt = "; ".join(
        f"t={e.get('timestamp')}: {_trim(e.get('description'), 160)}"
        for e in tl
        if isinstance(e, dict) and str(e.get("description") or "").strip()
    )
    # Older cards stored a motive token on each stamp, or a motive_evidence list.
    if not ev_txt:
        ev_txt = "; ".join(
            f"t={e.get('timestamp')}: {_trim(e.get('description'), 160)}"
            for e in tl
            if isinstance(e, dict)
            and e.get("motive") not in (None, "", "null")
            and not str(e.get("description") or "").strip()
        )
    if not ev_txt:
        ev = doc.get("motive_evidence") or []
        ev_txt = "; ".join(
            f"{e.get('motive')}@{e.get('at')}: {_trim(e.get('evidence'), 160)}"
            for e in ev
            if isinstance(e, dict)
        )
    # Cluster tag only — never expose trial_id to LLM-facing digests.
    cname = Path(cluster_dir).name  # e.g. cluster0
    clab = cname.replace("cluster", "c") if cname.startswith("cluster") else cname
    return (
        f"### [{clab}] cluster medoid\n"
        f"- agent_interactions: {ix_txt or 'n/a'}\n"
        f"- peak_t={cm.get('peak_t')} brake_t={cm.get('brake_t')} "
        f"ttc={cm.get('ttc')} d={cm.get('d')}\n"
        f"- outcome: {_trim(doc.get('outcome'), 200)}\n"
        f"- timeline: {ev_txt or 'n/a'}\n"
        f"- motive_summary: {_trim(doc.get('motive_summary'))}"
    )


def medoid_digest(run_dir: Path) -> str:
    """One block per cluster: typed motive fields from the medoid card."""
    blocks: List[str] = []
    for cdir in sorted(
        d for d in Path(run_dir).glob("cluster*")
        if d.is_dir() and d.name[len("cluster"):].isdigit()
    ):
        block = medoid_card_block(cdir)
        if block:
            blocks.append(block)
    return "\n\n".join(blocks) if blocks else "(no medoid cards yet)"


def parameter_space_pair_digest(run_dir: Path) -> str:
    """One block per Parameter-space pair from contrast cards only."""
    try:
        import yaml
    except Exception:
        yaml = None  # type: ignore[assignment]

    blocks: List[str] = []
    for pdir in sorted((Path(run_dir) / "parameter_space_pairs").glob("*")):
        if not pdir.is_dir():
            continue
        m = _PAIR_DIRNAME_RE.match(pdir.name)
        if m:
            a, b = m.group(1), m.group(2)
        else:
            a = b = "?"
        block = (
            f"### {pdir.name}\n"
            f"- clusters: cluster{a} vs cluster{b}"
        )
        contrast: Optional[Dict[str, Any]] = None
        if yaml is not None:
            candidates = [
                pdir / "output" / "contrast.yaml",
                pdir / "contrast.yaml",
                *sorted((pdir / "output").glob("*.yaml")),
            ]
            for cand in candidates:
                if not cand.is_file():
                    continue
                try:
                    loaded = yaml.safe_load(cand.read_text(encoding="utf-8"))
                except Exception:
                    continue
                if isinstance(loaded, dict) and loaded:
                    contrast = loaded
                    break
        if contrast:
            left_side = contrast.get("left") or {}
            right_side = contrast.get("right") or {}
            left_r = left_side.get("resolution") or left_side.get("interaction_resolution")
            right_r = right_side.get("resolution") or right_side.get("interaction_resolution")
            cdiv = contrast.get("critical_divergence") or {}
            block += (
                f"\n- separation_call: {contrast.get('separation_call')}"
                f"\n- separation_reason: {_trim(contrast.get('separation_reason'), 300)}"
                f"\n- contrast_explanation: {_trim(contrast.get('contrast_explanation'))}"
            )
            if left_r or right_r:
                block += f"\n- left.resolution={left_r}, right.resolution={right_r}"
            elif left_side.get("primary_motive") or right_side.get("primary_motive"):
                block += (
                    f"\n- legacy_motive left={left_side.get('primary_motive')}, "
                    f"right={right_side.get('primary_motive')}"
                )
            if cdiv:
                block += (
                    f"\n- critical_divergence: at={cdiv.get('at')} "
                    f"{_trim(cdiv.get('description'), 200)}"
                )
        else:
            block += "\n- (no Parameter-space pair card yet — pack facts only)"
        blocks.append(block)
    return "\n\n".join(blocks) if blocks else "(no Parameter-space pair packs)"


_PAIR_DIRNAME_RE = re.compile(r"^c(\d+)-c(\d+)$")


def neighbor_cards_for_cluster(run_dir: Path, cluster_label: Any) -> str:
    """Parameter-space pair + neighbor-medoid cards for every pack touching this cluster.

    Narrower than :func:`parameter_space_pair_digest` (which lists every pack in the run):
    this is what the cluster-summary prompt (Stage B) reads to judge whether
    ONE cluster is distinct from its actual parameter-space-matched neighbors — the
    outcome-grounded evidence a raw numeric digest cannot provide on its own.
    """
    run_dir = Path(run_dir)
    cid = str(cluster_label)
    parameter_space_pairs_dir = run_source_dir(run_dir) / "parameter_space_pairs"
    if not parameter_space_pairs_dir.is_dir():
        return f"(no parameter_space_pairs/ directory in this run — cluster{cid} has no neighbor cards)"

    try:
        import yaml
    except Exception:
        yaml = None  # type: ignore[assignment]

    blocks: List[str] = []
    for pdir in sorted(parameter_space_pairs_dir.glob("c*-c*")):
        if not pdir.is_dir():
            continue
        m = _PAIR_DIRNAME_RE.match(pdir.name)
        if not m:
            continue
        a, b = m.group(1), m.group(2)
        if cid not in (a, b):
            continue
        other = b if a == cid else a

        block = (
            f"### {pdir.name} (this cluster = cluster{cid}, neighbor = cluster{other})\n"
            "- pair metadata is omitted here by design; use contrast evidence below"
        )

        contrast: Optional[Dict[str, Any]] = None
        cpath = pdir / "output" / "contrast.yaml"
        if not cpath.is_file():
            cpath = pdir / "contrast.yaml"
        if yaml is not None and cpath.is_file():
            try:
                loaded = yaml.safe_load(cpath.read_text(encoding="utf-8"))
            except Exception:
                loaded = None
            if isinstance(loaded, dict) and loaded and not loaded.get("stub"):
                contrast = loaded

        if contrast:
            left_side = contrast.get("left") or {}
            right_side = contrast.get("right") or {}
            left_r = left_side.get("resolution") or left_side.get("interaction_resolution")
            right_r = right_side.get("resolution") or right_side.get("interaction_resolution")
            block += (
                f"\n- separation_call: {contrast.get('separation_call')}"
                f"\n- separation_reason: {_trim(contrast.get('separation_reason'), 300)}"
                f"\n- contrast_explanation: {_trim(contrast.get('contrast_explanation'))}"
            )
            if left_r or right_r:
                block += (
                    f"\n- left(cluster{a}).resolution={left_r}, "
                    f"right(cluster{b}).resolution={right_r}"
                )
            elif left_side.get("primary_motive") or right_side.get("primary_motive"):
                block += (
                    f"\n- legacy_motive left(cluster{a})={left_side.get('primary_motive')}, "
                    f"right(cluster{b})={right_side.get('primary_motive')}"
                )
            left_outcome = (contrast.get("left") or {}).get("outcome")
            right_outcome = (contrast.get("right") or {}).get("outcome")
            if left_outcome is not None or right_outcome is not None:
                block += (
                    f"\n- outcomes (from contrast): cluster{a}={left_outcome}, "
                    f"cluster{b}={right_outcome}"
                )
        else:
            block += (
                "\n- (no LLM contrast card yet — run parameter-space-pairs for this pack first; "
                "pack facts only)"
            )

        neighbor_card = medoid_card_block(run_source_dir(run_dir) / f"cluster{other}")
        block += "\n\n" + (
            neighbor_card or f"(cluster{other} has no medoid card yet)"
        )
        blocks.append(block)

    if not blocks:
        return (
            f"(no parameter_space_pairs packs touch cluster{cid} in this run — rebuild with "
            "--param-boundaries all, or this cluster may simply have no "
            "parameter-space-matched neighbor within the caliper)"
        )
    return "\n\n".join(blocks)


def neighbor_rollup_digest(run_dir: Path) -> str:
    """Roll up every cluster's own ``neighbor_comparison`` verdicts.

    Reads each ``cluster<N>/output/cluster_summary.yaml`` (Stage B) and
    compacts its localized distinct/similar/ambiguous-vs-IC-neighbor
    judgments into one block, so the whole-partition cross-cluster verdict
    can CITE these per-cluster checks instead of re-deriving them.
    """
    try:
        import yaml
    except Exception:
        return "(pyyaml unavailable)"

    run_dir = Path(run_dir)
    lines: List[str] = []
    any_found = False
    for cdir in sorted(
        d for d in run_source_dir(run_dir).glob("cluster*")
        if d.is_dir() and d.name[len("cluster"):].isdigit()
    ):
        path = cdir / "output" / "cluster_summary.yaml"
        if not path.is_file():
            continue
        try:
            doc = yaml.safe_load(path.read_text(encoding="utf-8")) or {}
        except Exception:
            continue
        if not isinstance(doc, dict) or doc.get("stub"):
            continue
        ncs = doc.get("neighbor_comparison")
        distinct = doc.get("distinct_from_neighbors")
        note = doc.get("motive_consistency_note")
        if not ncs and distinct is None and not note:
            continue
        any_found = True
        lines.append(f"### {cdir.name}: distinct_from_neighbors={distinct}")
        if isinstance(note, str) and note.strip():
            lines.append(f"- motive_consistency_note: {_trim(note, 250)}")
        if isinstance(ncs, list):
            for nc in ncs:
                if not isinstance(nc, dict):
                    continue
                lines.append(
                    f"- vs cluster{nc.get('neighbor_cluster')} "
                    f"({nc.get('parameter_space_pair_folder')}): {nc.get('verdict')} — "
                    f"{_trim(nc.get('reason'), 200)}"
                )
    if not any_found:
        return (
            "(no per-cluster neighbor_comparison verdicts yet — run the "
            "summary product first, per cluster, before this rollup is useful)"
        )
    return "\n".join(lines)


def digest_for_prompt(run_dir: Path) -> str:
    """Compact *derived* selection-eval digest for the LLM.

    Never dumps ``cluster.json`` raw rows (n_trials, collision_rate, mean_ttc,
    parameter_ranges). Those stay rule-side in ``evaluate_run_dir`` /
    ``cluster_selection_eval.json``; the LLM only sees scored findings.
    """
    run_dir = Path(run_dir)
    report = evaluate_run_dir(run_dir) or {}
    lines: List[str] = [
        "## Deterministic selection-eval (rule-based; not raw cluster.json)",
        "",
        f"- selection_score = {report.get('selection_score')}",
        f"- components = {report.get('components')}",
        f"- evaluated_components = {report.get('evaluated_components')}",
    ]
    motives = report.get("primary_motives") or {}
    if motives:
        lines.append("- behavior_tokens (summary label or resolution): " + ", ".join(
            f"c{lab}={m or 'n/a'}" for lab, m in sorted(motives.items(), key=lambda x: str(x[0]))
        ))
    merges = report.get("merge_candidates") or []
    if merges:
        lines.append("- merge_candidates:")
        for mc in merges:
            lines.append(f"  - {mc}")
    findings = report.get("findings") or []
    if findings:
        lines += ["", "## Findings", ""]
        for f in findings:
            lines.append(f"- {f}")
    elif report.get("selection_score") is None:
        lines.append("- (selection-eval empty — run medoid / packs first)")
    return "\n".join(lines) + "\n"
