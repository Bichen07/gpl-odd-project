"""cluster_cards.py — text cards the language model reads.

Two builders feed the cluster summary and the label reviewer:

* ``medoid_card_block``: one cluster's medoid card (interactions, timing,
  outcome, collision line, timeline, motive summary).
* ``neighbor_cards_for_cluster``: every parameter-space pair card that touches
  one cluster, each followed by the neighbor's medoid card.

No scoring and no language-model call.
"""

from __future__ import annotations

import re
from pathlib import Path
from typing import Any, Dict, List, Optional

from .paths import run_source_dir

_PAIR_DIRNAME_RE = re.compile(r"^c(\d+)-c(\d+)$")


def _trim(text: Any, limit: int = 700) -> str:
    """Collapse a narrative field to a single prompt-friendly paragraph."""
    body = " ".join(str(text or "").split())
    return body[:limit] + ("…" if len(body) > limit else "")


def medoid_card_block(cluster_dir: Path) -> Optional[str]:
    """Single-cluster medoid-card text block, or ``None`` if not built yet."""
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
    # Collision trials only: impact type and who struck whom (omitted otherwise).
    cd = doc.get("collision_detail")
    cd_line = ""
    if isinstance(cd, dict):
        bits = [
            f"{k}={cd.get(k)}"
            for k in ("impact_type", "striking_vehicle", "struck_vehicle", "bearing_sector")
            if cd.get(k) not in (None, "", "null")
        ]
        if bits:
            cd_line = "- collision: " + ", ".join(bits) + "\n"
    # Cluster tag only — never expose trial_id to LLM-facing text.
    cname = Path(cluster_dir).name  # e.g. cluster0
    clab = cname.replace("cluster", "c") if cname.startswith("cluster") else cname
    return (
        f"### [{clab}] cluster medoid\n"
        f"- agent_interactions: {ix_txt or 'n/a'}\n"
        f"- peak_t={cm.get('peak_t')} brake_t={cm.get('brake_t')} "
        f"ttc={cm.get('ttc')} d={cm.get('d')}\n"
        f"- outcome: {_trim(doc.get('outcome'), 200)}\n"
        f"{cd_line}"
        f"- timeline: {ev_txt or 'n/a'}\n"
        f"- motive_summary: {_trim(doc.get('motive_summary'))}"
    )


def neighbor_cards_for_cluster(run_dir: Path, cluster_label: Any) -> str:
    """Parameter-space pair + neighbor-medoid cards for every pack touching this cluster.

    The cluster-summary prompt reads these to compare one cluster with its
    parameter-space-matched neighbors.
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
                f"\n- behavior_similarity: {contrast.get('behavior_similarity')}"
                f"\n- behavior_similarity_reason: {_trim(contrast.get('behavior_similarity_reason'), 300)}"
                f"\n- contrast_explanation: {_trim(contrast.get('contrast_explanation'))}"
            )
            if left_r or right_r:
                block += (
                    f"\n- left(cluster{a}).resolution={left_r}, "
                    f"right(cluster{b}).resolution={right_r}"
                )
            left_outcome = left_side.get("outcome")
            right_outcome = right_side.get("outcome")
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
