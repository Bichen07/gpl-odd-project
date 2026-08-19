"""cluster_selection_eval.py — programmatic verdict on a clustering selection.

Answers "is this candidate a good *behavioral* decomposition?" from artifacts
already on disk, with no LLM call. It is the deterministic half of the hybrid
cluster-selection evaluation; the LLM half lands in ``cross_cluster_eval.json``
and is blended by ``clustering_quality_scorer``.

Silhouette alone is a poor guide here: in Case Study 3 the highest-silhouette
k=6 candidate merges two behaviorally distinct collision-free clusters, which
these checks catch and silhouette does not.

Inputs (all optional except cluster.json):
  <run_dir>/cluster*/raw/cluster.json      sizes, collision rates, param ranges
  <run_dir>/cluster*/output/medoid_trial.yaml   primary_motive per cluster
  <run_dir>/parameter_space_pairs/*/pair.json           near-identical-Parameter-space pairs + outcomes

Output:
  <run_dir>/cluster_selection_eval.json
"""

from __future__ import annotations

import json
import re
from pathlib import Path
from typing import Any, Dict, List, Optional, Tuple

_OUTPUT_FILE = "cluster_selection_eval.json"

# Composite weights over the components that could be computed (renormalized
# when a component is unavailable, e.g. no medoid cards yet).
_WEIGHTS = {
    "outcome_purity": 0.30,
    "motive_distinctness": 0.30,
    "parameter_space_pair_decisiveness": 0.25,
    "no_merge_candidates": 0.15,
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
    for cdir in sorted(run_dir.glob("cluster*")):
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


def _primary_motive(cluster_dir: Path) -> Optional[str]:
    path = cluster_dir / "output" / "medoid_trial.yaml"
    if not path.is_file():
        return None
    try:
        import yaml  # noqa: PLC0415 - optional dependency at import time

        doc = yaml.safe_load(path.read_text(encoding="utf-8")) or {}
    except Exception:
        return None
    val = doc.get("primary_motive")
    if isinstance(val, str) and val.strip() and val.strip() != "unclear":
        return val.strip()
    return None


def _load_parameter_space_pairs(run_dir: Path) -> List[Dict[str, Any]]:
    pairs: List[Dict[str, Any]] = []
    for path in sorted((run_dir / "parameter_space_pairs").glob("*/pair.json")):
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
                "Repeated primary motives: "
                + "; ".join(
                    f"{m} in clusters {', '.join(sorted(labs))}" for m, labs in dupes.items()
                )
                + " — distinct clusters telling the same story may be over-splitting."
            )
        else:
            findings.append(
                f"All {len(known)} captioned clusters carry a distinct primary motive."
            )
        if len(known) < k:
            findings.append(
                f"{k - len(known)} of {k} clusters have no usable primary_motive yet "
                "(medoid card missing or 'unclear')."
            )
    else:
        components["motive_distinctness"] = None
        findings.append(
            "No medoid cards found — motive distinctness not evaluated. "
            "Run the medoid product first."
        )

    # --- 3. Parameter-space pair decisiveness --------------------------------------------
    pairs = _load_parameter_space_pairs(run_dir)
    matched = [
        p for p in pairs
        if p.get("parameter_space_match", p.get("ic_match"))
    ]
    flips: List[Dict[str, Any]] = []
    if matched:
        decisive = 0
        for p in matched:
            a, b = p.get("collided_a"), p.get("collided_b")
            differs = isinstance(a, bool) and isinstance(b, bool) and a != b
            if differs:
                decisive += 1
            flips.append(
                {
                    "folder": p.get("folder"),
                    "clusters": [p.get("cluster_a"), p.get("cluster_b")],
                    "param_dist": p.get("param_dist"),
                    "outcome_flip": bool(differs),
                }
            )
        components["parameter_space_pair_decisiveness"] = decisive / len(matched)
        verdict = (
            "the boundary separates outcomes under near-identical initial conditions"
            if decisive * 2 >= len(matched)
            else "these boundaries rarely change the outcome, so they may be splitting "
            "trials that behave alike"
        )
        findings.append(
            f"{decisive} of {len(matched)} near-identical-Parameter-space pairs flip outcome across a "
            f"cluster boundary — {verdict}."
        )
    else:
        components["parameter_space_pair_decisiveness"] = None
        findings.append(
            "No Parameter-space pair packs with parameter_space_match found — boundary clarity not evaluated. "
            "Rebuild with --param-boundaries all."
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
    if known:
        components["no_merge_candidates"] = 0.0 if merge_candidates else 1.0
        if merge_candidates:
            findings.append(
                "Merge candidates (same motive, similar collision rate, overlapping "
                "parameter ranges): "
                + "; ".join(
                    f"cluster{c['clusters'][0]}+cluster{c['clusters'][1]}"
                    for c in merge_candidates
                )
            )
    else:
        components["no_merge_candidates"] = None

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
    out_path = run_dir / _OUTPUT_FILE
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
    # Motives live on decision_timeline entries (no separate motive_evidence list).
    tl = doc.get("decision_timeline") or []
    ev_txt = "; ".join(
        f"{e.get('motive')}@{e.get('timestamp')}: {_trim(e.get('description'), 160)}"
        for e in tl
        if isinstance(e, dict) and e.get("motive") not in (None, "", "null")
    )
    # Backward compat for older medoid_trial.yaml that still had motive_evidence.
    if not ev_txt:
        ev = doc.get("motive_evidence") or []
        ev_txt = "; ".join(
            f"{e.get('motive')}@{e.get('at')}: {_trim(e.get('evidence'), 160)}"
            for e in ev
            if isinstance(e, dict)
        )
    return (
        f"### {Path(cluster_dir).name} (medoid trial {doc.get('trial_id') or '?'})\n"
        f"- interaction_resolution: {doc.get('interaction_resolution')}\n"
        f"- control_response: {doc.get('control_response')}\n"
        f"- primary_motive: {doc.get('primary_motive')}\n"
        f"- secondary_motives: {doc.get('secondary_motives')}\n"
        f"- peak_t={cm.get('peak_t')} brake_t={cm.get('brake_t')} "
        f"ttc={cm.get('ttc')} d={cm.get('d')}\n"
        f"- outcome: {_trim(doc.get('outcome'), 200)}\n"
        f"- timeline_motives: {ev_txt or 'n/a'}\n"
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
            left_m = (contrast.get("left") or {}).get("primary_motive")
            right_m = (contrast.get("right") or {}).get("primary_motive")
            cdiv = contrast.get("critical_divergence") or {}
            block += (
                f"\n- separation_call: {contrast.get('separation_call')}"
                f"\n- separation_reason: {_trim(contrast.get('separation_reason'), 300)}"
                f"\n- contrast_explanation: {_trim(contrast.get('contrast_explanation'))}"
            )
            if left_m or right_m:
                motive_contrast = contrast.get("motive_contrast") or (
                    "same" if left_m and left_m == right_m else "different"
                )
                block += (
                    f"\n- left.primary_motive={left_m}, right.primary_motive="
                    f"{right_m} (motive_contrast={motive_contrast})"
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
    parameter_space_pairs_dir = run_dir / "parameter_space_pairs"
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
            left_m = (contrast.get("left") or {}).get("primary_motive")
            right_m = (contrast.get("right") or {}).get("primary_motive")
            block += (
                f"\n- separation_call: {contrast.get('separation_call')}"
                f"\n- separation_reason: {_trim(contrast.get('separation_reason'), 300)}"
                f"\n- contrast_explanation: {_trim(contrast.get('contrast_explanation'))}"
            )
            if left_m or right_m:
                block += (
                    f"\n- left(cluster{a}).primary_motive={left_m}, "
                    f"right(cluster{b}).primary_motive={right_m}"
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

        neighbor_card = medoid_card_block(run_dir / f"cluster{other}")
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
        d for d in run_dir.glob("cluster*")
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
    """Compact deterministic digest for LLM, excluding raw pair.json fields."""
    run_dir = Path(run_dir)
    clusters = _load_clusters(run_dir)
    report = evaluate_run_dir(run_dir) or {}
    lines: List[str] = ["## Clusters", ""]
    for c in clusters:
        rng = c.get("parameter_ranges") or {}
        rng_txt = ", ".join(
            f"{name}=[{float(v[0]):.2f}, {float(v[1]):.2f}]"
            for name, v in rng.items()
            if isinstance(v, (list, tuple)) and len(v) >= 2
        )
        lines.append(
            f"- cluster{c['_label']}: n={c.get('n_trials')}, "
            f"collision_rate={c.get('collision_rate')}%, "
            f"mean_ttc={c.get('mean_ttc')}, "
            f"primary_motive={c.get('_primary_motive') or 'n/a'}"
            + (f", {rng_txt}" if rng_txt else "")
        )

    if report.get("findings"):
        lines += ["", "## Deterministic checks", ""]
        for f in report["findings"]:
            lines.append(f"- {f}")
        lines.append(
            f"- deterministic selection_score = {report.get('selection_score')} "
            f"(components: {report.get('components')})"
        )
    return "\n".join(lines) + "\n"
