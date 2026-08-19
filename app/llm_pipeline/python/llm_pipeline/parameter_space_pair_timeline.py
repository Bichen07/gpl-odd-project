"""parameter_space_pair_timeline.py — merged left/right timeline text for Parameter-space pair analysis.

Turns the synced-BEV frame index that ``app/analyzer/src/parameter_space_pair_packs.py``
already writes (``parameter_space_pairs/cA-cB/synced_bev/synced_bev_index.json``) into one
interleaved Markdown timeline, so the LLM can read "at the same shared t,
cluster A was doing X while cluster B was doing Y" directly, instead of
cross-referencing two separate ``context.md`` documents itself.

No new computation: every field rendered here (``d``, ``ttc``, ``v_ego``,
``v_partner``, ``az``, ``closing``) was already computed by
``_metrics_at()`` in ``conflict_frame_selector.py`` while building the synced
BEV images — this module only stops discarding it and formats it as text.
"""
from __future__ import annotations

import json
import re
import sys
from pathlib import Path
from typing import Any, Dict, List, Optional, Tuple

_PAIR_DIRNAME_RE = re.compile(r"^c(\d+)-c(\d+)$")


def _cluster_labels(
    pair_dir: Path,
    left_cluster: Optional[Any],
    right_cluster: Optional[Any],
) -> Tuple[str, str]:
    if left_cluster is not None and right_cluster is not None:
        return f"c{left_cluster}", f"c{right_cluster}"
    m = _PAIR_DIRNAME_RE.match(Path(pair_dir).name)
    if m:
        return f"c{m.group(1)}", f"c{m.group(2)}"
    return "left", "right"


def _pick(fr: Dict[str, Any], *keys: str) -> Any:
    for k in keys:
        if fr.get(k) is not None:
            return fr.get(k)
    return None


def _fmt_side(
    alive: Optional[bool],
    label: Optional[str],
    d: Optional[float],
    ttc: Optional[float],
    v_ego: Optional[float],
    v_partner: Optional[float],
    az: Optional[float],
    closing: Optional[float],
    rel_long: Optional[float] = None,
    rel_lat: Optional[float] = None,
    clearance: Optional[float] = None,
    pass_state: Optional[str] = None,
    roll_speed: Optional[float] = None,
) -> str:
    if not alive:
        return "ended (out of frame / clip)"
    try:
        analyzer_src = Path(__file__).resolve().parents[3] / "analyzer" / "src"
        if str(analyzer_src) not in sys.path:
            sys.path.insert(0, str(analyzer_src))
        from conflict_frame_selector import (  # type: ignore
            format_side_metric_bits,
            _event_gloss,
        )
    except Exception:
        format_side_metric_bits = None  # type: ignore
        _event_gloss = None  # type: ignore
    if format_side_metric_bits is not None:
        bits = format_side_metric_bits(
            d=d,
            ttc=ttc,
            v_ego=v_ego,
            v_partner=v_partner,
            az=az,
            closing=closing,
            rel_long_m=rel_long,
            rel_lat_m=rel_lat,
            clearance_m=clearance,
            pass_state=pass_state,
            rolling_speed_1s_mps=roll_speed,
        )
    else:
        bits = []
        if v_ego is not None:
            bits.append(f"ego speed={float(v_ego):.1f} m/s")
        if d is not None:
            bits.append(f"center-to-center distance={float(d):.1f} m")
    text = " ".join(bits) if bits else "(no metrics at this frame)"
    if label:
        gloss = _event_gloss(str(label)) if _event_gloss else str(label)
        text += f" — {gloss}"
    return text


def build_merged_timeline_text(
    pair_dir: Path,
    left_cluster: Optional[Any] = None,
    right_cluster: Optional[Any] = None,
    max_lines: int = 60,
) -> str:
    """Render one interleaved line per shared synced-BEV clock tick.

    Prefers the pack-level ``process/context.md`` (written by the analyzer at
    rebuild time). Falls back to formatting ``synced_bev_index.json`` directly.
    """
    ctx_path = Path(pair_dir) / "process" / "context.md"
    if ctx_path.is_file():
        try:
            text = ctx_path.read_text(encoding="utf-8").strip()
            if text:
                return text
        except OSError:
            pass

    idx_path = Path(pair_dir) / "synced_bev" / "synced_bev_index.json"
    if not idx_path.is_file():
        return (
            "(no process/context.md or synced_bev_index.json under this pack — "
            "rebuild parameter_space_pairs to get a merged pair context)"
        )
    try:
        doc: Dict[str, Any] = json.loads(idx_path.read_text(encoding="utf-8"))
    except Exception:
        return "(synced_bev_index.json unreadable)"

    frames = doc.get("frames") or []
    if not frames:
        return "(synced_bev_index.json has no frames)"

    left_lab, right_lab = _cluster_labels(pair_dir, left_cluster, right_cluster)
    lines: List[str] = [
        "Shared clock t = seconds from each side's own StartValidCondition "
        f"clip (0.0 = clip start; NOT the same instant as absolute esmini "
        f"time). [{left_lab}] and [{right_lab}] are read at the SAME shared "
        "t — this is the strongest anchor for 'who was doing what when the "
        "other side reached this instant'. Metrics use precise descriptions: "
        "ego and partner speeds; center-to-center distance; estimated time to "
        "collision; partner azimuth relative to ego heading; center-distance "
        "closing/opening rate; partner position in ego coordinates; longitudinal "
        "relationship; minimum distance between vehicle boundaries; and Ego's "
        "average speed during the previous 1 second.",
        "",
    ]
    truncated = len(frames) > max_lines
    shown = frames[:max_lines] if truncated else frames
    for fr in shown:
        t_s = fr.get("t_s")
        if t_s is None:
            continue
        left_txt = _fmt_side(
            fr.get("left_alive"),
            fr.get("left_label"),
            _pick(fr, "left_d", "left_d_m"),
            _pick(fr, "left_ttc", "left_ttc_s"),
            fr.get("left_v_ego"),
            fr.get("left_v_partner"),
            _pick(fr, "left_az", "left_az_deg"),
            _pick(fr, "left_closing", "left_closing_mps"),
            fr.get("left_rel_long_m"),
            fr.get("left_rel_lat_m"),
            fr.get("left_clearance_m"),
            fr.get("left_pass_state"),
            fr.get("left_rolling_speed_1s_mps"),
        )
        right_txt = _fmt_side(
            fr.get("right_alive"),
            fr.get("right_label"),
            _pick(fr, "right_d", "right_d_m"),
            _pick(fr, "right_ttc", "right_ttc_s"),
            fr.get("right_v_ego"),
            fr.get("right_v_partner"),
            _pick(fr, "right_az", "right_az_deg"),
            _pick(fr, "right_closing", "right_closing_mps"),
            fr.get("right_rel_long_m"),
            fr.get("right_rel_lat_m"),
            fr.get("right_clearance_m"),
            fr.get("right_pass_state"),
            fr.get("right_rolling_speed_1s_mps"),
        )
        lines.append(
            f"- t={float(t_s):.2f}s: [{left_lab}] {left_txt} | "
            f"[{right_lab}] {right_txt}"
        )
    if truncated:
        lines.append(f"…[{len(frames) - max_lines} more frames omitted]")
    return "\n".join(lines)
