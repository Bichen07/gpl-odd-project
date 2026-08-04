"""IC closest-pair packs under ``results/.../ic_pairs/cA-cB/``.

Gates pairs by z-scored L2 caliper ``param_dist ≤ IC_PARAM_DIST_TAU``, writes
per-side trial packs + peak-aligned pair-zoom|pair-zoom BEVs, and removes the
legacy ``cluster*/highlight_trials/param_boundary_c*`` layout.
"""
from __future__ import annotations

import json
import shutil
import tempfile
from pathlib import Path
from typing import Any, Dict, List, Optional, Sequence, Tuple

# Z-scored L2 caliper in 2D IC space (OncomingSpeed, OncomingStartDelay).
IC_PARAM_DIST_TAU = 0.1

# Match dataset_builder CLI defaults for IC pair BEVs.
IC_SNAPSHOT_OUTPUT_PX = 512
IC_EGO_ZOOM_RADIUS_M = 25.0
IC_MAX_SYNCED_FRAMES = 18  # wider pre-peak window (−15s) needs more stamps
IC_REBASE_MERGE_TOL_S = 0.25


def pair_folder_name(cluster_a: Any, cluster_b: Any) -> str:
    a, b = int(cluster_a), int(cluster_b)
    if a > b:
        a, b = b, a
    return f"c{a}-c{b}"


def annotate_param_boundary_pairs(
    pairs: List[Dict[str, Any]],
    *,
    tau: float = IC_PARAM_DIST_TAU,
) -> List[Dict[str, Any]]:
    """Tag each closest-pair with ``ic_match`` / ``card_role``.

    ``card_role``:
      - ``primary``   — matched IC + outcome mismatch (why different?)
      - ``secondary`` — matched IC + same outcome (over-split?)
      - ``skipped``   — param_dist > tau (not a matched natural experiment)

    Also logs an elbow sanity check on sorted distances (does not override tau).
    """
    dists = [
        float(p["param_dist"])
        for p in pairs
        if isinstance(p.get("param_dist"), (int, float))
    ]
    if len(dists) >= 3:
        ordered = sorted(dists)
        gaps = [ordered[i + 1] - ordered[i] for i in range(len(ordered) - 1)]
        if gaps:
            i_gap = int(max(range(len(gaps)), key=lambda i: gaps[i]))
            elbow_lo, elbow_hi = ordered[i_gap], ordered[i_gap + 1]
            print(
                f"  📐 IC param_dist elbow: {elbow_lo:.4f} → {elbow_hi:.4f} "
                f"(gap={gaps[i_gap]:.4f}); caliper τ={tau}"
            )

    out: List[Dict[str, Any]] = []
    for bp in pairs:
        row = dict(bp)
        d = row.get("param_dist")
        matched = isinstance(d, (int, float)) and float(d) <= float(tau)
        row["ic_match"] = bool(matched)
        row["param_dist_tau"] = float(tau)
        if not matched:
            row["card_role"] = "skipped"
        else:
            ca = bool(row.get("collided_a"))
            cb = bool(row.get("collided_b"))
            row["card_role"] = "primary" if ca != cb else "secondary"
        out.append(row)
    n_ok = sum(1 for p in out if p.get("ic_match"))
    print(
        f"  📐 IC gate: {n_ok}/{len(out)} pairs with param_dist ≤ {tau} "
        f"(primary={sum(1 for p in out if p.get('card_role')=='primary')}, "
        f"secondary={sum(1 for p in out if p.get('card_role')=='secondary')})"
    )
    return out


def ic_pairs_root(run_dir: Path) -> Path:
    return Path(run_dir) / "ic_pairs"


def pair_pack_dir(run_dir: Path, cluster_a: Any, cluster_b: Any) -> Path:
    return ic_pairs_root(run_dir) / pair_folder_name(cluster_a, cluster_b)


def side_trial_dir(
    pack_dir: Path,
    cluster: Any,
    trial_index: int,
) -> Path:
    return pack_dir / f"c{int(cluster)}_trial_{int(trial_index)}"


def find_ic_pair_side_dir(
    run_dir: Path,
    cluster: Any,
    other_cluster: Any,
    trial_id: str,
    trial_index_map: Optional[Dict[str, Tuple[int, int]]] = None,
) -> Optional[Path]:
    """Resolve ``ic_pairs/cA-cB/c{cluster}_trial_{idx}/`` (new layout)."""
    pack = pair_pack_dir(run_dir, cluster, other_cluster)
    if not pack.is_dir():
        return None
    if trial_index_map and str(trial_id) in trial_index_map:
        _b, ti = trial_index_map[str(trial_id)]
        cand = side_trial_dir(pack, cluster, ti)
        if cand.is_dir():
            return cand
    prefix = f"c{int(cluster)}_trial_"
    subs = sorted(
        p for p in pack.iterdir() if p.is_dir() and p.name.startswith(prefix)
    )
    if len(subs) == 1:
        return subs[0]
    return None


def remove_legacy_param_boundary_dirs(run_dir: Path) -> List[str]:
    """Delete ``cluster*/highlight_trials/param_boundary_c*`` (and flat legacy)."""
    removed: List[str] = []
    run_dir = Path(run_dir)
    for cluster_dir in sorted(run_dir.glob("cluster*")):
        if not cluster_dir.is_dir():
            continue
        for base in (cluster_dir / "highlight_trials", cluster_dir):
            if not base.is_dir():
                continue
            for child in list(base.iterdir()):
                if child.is_dir() and child.name.startswith("param_boundary_c"):
                    shutil.rmtree(child, ignore_errors=True)
                    removed.append(str(child.relative_to(run_dir)))
    return removed


def write_ic_trial_context_md(
    trial_dir: Path,
    *,
    cluster: Any,
    payload_trial_id: str,
    trial_index: int,
    action_data: Optional[Dict[str, Any]],
    selection: Any = None,
    snap_filenames: Optional[List[str]] = None,
    card_role: str = "",
    peer_cluster: Any = None,
    clip_start_s: Optional[float] = None,
    conflict_window_before_s: float = 15.0,
    conflict_window_after_s: float = 8.0,
    conflict_window_s: Optional[float] = None,
) -> Path:
    """Write ``context.md`` for an IC-pair side (no medoid cluster header)."""
    from conflict_frame_selector import (
        format_conflict_timeline_sentences,
        _resolve_conflict_windows,
    )
    from cluster_paths import write_path

    lines: List[str] = [
        f"# IC-pair trial — cluster {cluster}",
        "",
        f"- **Payload trial id**: {payload_trial_id}",
        f"- **esmini index**: {trial_index}",
        f"- **Folder**: {trial_dir.name}",
    ]
    if peer_cluster is not None:
        lines.append(f"- **Paired with cluster**: {peer_cluster}")
    if card_role:
        lines.append(f"- **Card role**: {card_role}")
    if clip_start_s is not None:
        lines.append(
            f"- **clip_start_esmini_s**: {float(clip_start_s):.3f} "
            "(StartValidCondition; timeline uses shared clock t′ = esmini − clip)"
        )
    lines.append("")

    if selection is not None and getattr(selection, "frames", None):
        off = float(clip_start_s or 0.0)
        frames = list(selection.frames)
        peak = getattr(selection, "peak_t", None)
        before, after = _resolve_conflict_windows(
            conflict_window_s=conflict_window_s,
            conflict_window_before_s=conflict_window_before_s,
            conflict_window_after_s=conflict_window_after_s,
        )
        if peak is not None:
            lo, hi = float(peak) - before, float(peak) + after
            frames = [fr for fr in frames if lo - 1e-6 <= float(fr.t) <= hi + 1e-6]

        class _Sel:
            pass

        sel_view = _Sel()
        sel_view.frames = frames
        sel_view.partner_name = getattr(selection, "partner_name", None)
        lines.append(
            format_conflict_timeline_sentences(
                sel_view,
                filenames=snap_filenames,
                action_data=action_data,
                clock_offset_s=off,
                clock_name="shared" if clip_start_s is not None else "",
            ).rstrip()
        )
        lines.append("")

    out = write_path(trial_dir, "context.md")
    out.write_text("\n".join(lines), encoding="utf-8")
    return out


def _snap_time(time_steps: Sequence[float], t: float) -> float:
    if not time_steps:
        return float(t)
    import numpy as np

    arr = np.asarray(time_steps, dtype=float)
    return float(arr[int(np.argmin(np.abs(arr - float(t))))])


def estimate_clip_start_from_esmini_df(
    df,
    *,
    map_id: Optional[str] = None,
    batch_id: Optional[int] = None,
) -> Optional[float]:
    """Analysis-stage t=0 from ``app/analyzer/config/clip_conditions.yaml``.

    Accepts esmini CSV (``roadId`` / ``name``) or trajectory.csv (``road_id`` /
    ``trackId``). Same rule as Replayer analysis-clip mode (not a separate guess).
    """
    if df is None or getattr(df, "empty", True):
        return None
    try:
        from clip_conditions import resolve_clip_start_from_df
        from conflict_frame_selector import _normalize_traj_df

        d = _normalize_traj_df(df)
        return resolve_clip_start_from_df(d, map_id=map_id, batch_id=batch_id)
    except Exception:
        return None


def _frame_priority(fr) -> int:
    """Higher = keep when merging nearby rebased times."""
    lab = str(getattr(fr, "label", "") or "").upper()
    role = str(getattr(fr, "role", "") or "").lower()
    if "COLLISION" in lab:
        return 100
    if "NEAR_MISS" in lab:
        return 90
    if role == "peak":
        return 85
    if role == "burst":
        return 70
    if "HARD_BRAKE" in lab or "EMERGENCY" in lab:
        return 65
    if "APPROACH" in lab or "RELEVANCE" in lab:
        return 55
    if "DECELERATE" in lab or "ACCELERATE" in lab or "STOPPED" in lab:
        return 40
    if role == "action":
        return 30
    return 10


def _slug_safe(s: str, max_len: int = 40) -> str:
    out = "".join(c if c.isalnum() or c in "-_" else "_" for c in s).strip("_")
    return (out or "event")[:max_len]


def _merge_rebased_action_times(
    left_frames: Sequence[Any],
    right_frames: Sequence[Any],
    clip_l: float,
    clip_r: float,
    *,
    merge_tol_s: float = IC_REBASE_MERGE_TOL_S,
    max_frames: int = IC_MAX_SYNCED_FRAMES,
) -> List[Dict[str, Any]]:
    """Union of both trials' action/conflict stamps on a shared Replayer clock."""
    events: List[Dict[str, Any]] = []
    for fr in left_frames or []:
        events.append(
            {
                "t_prime": float(fr.t) - float(clip_l),
                "side": "L",
                "fr": fr,
                "prio": _frame_priority(fr),
            }
        )
    for fr in right_frames or []:
        events.append(
            {
                "t_prime": float(fr.t) - float(clip_r),
                "side": "R",
                "fr": fr,
                "prio": _frame_priority(fr),
            }
        )
    events = [e for e in events if e["t_prime"] >= -0.5]
    events.sort(key=lambda e: (e["t_prime"], -e["prio"]))

    clusters: List[Dict[str, Any]] = []
    for ev in events:
        if clusters and abs(ev["t_prime"] - clusters[-1]["t_prime"]) <= merge_tol_s:
            cur = clusters[-1]
            # Weighted time toward higher-priority stamp
            if ev["prio"] > cur["prio"]:
                cur["t_prime"] = ev["t_prime"]
                cur["prio"] = ev["prio"]
            if ev["side"] == "L" and (
                cur.get("left_fr") is None
                or ev["prio"] >= _frame_priority(cur["left_fr"])
            ):
                cur["left_fr"] = ev["fr"]
            if ev["side"] == "R" and (
                cur.get("right_fr") is None
                or ev["prio"] >= _frame_priority(cur["right_fr"])
            ):
                cur["right_fr"] = ev["fr"]
        else:
            clusters.append(
                {
                    "t_prime": ev["t_prime"],
                    "prio": ev["prio"],
                    "left_fr": ev["fr"] if ev["side"] == "L" else None,
                    "right_fr": ev["fr"] if ev["side"] == "R" else None,
                }
            )

    if len(clusters) > max_frames:
        # Prefer conflict-centred stamps
        clusters.sort(key=lambda c: (-c["prio"], c["t_prime"]))
        keep = sorted(clusters[:max_frames], key=lambda c: c["t_prime"])
        clusters = keep
    return clusters


def render_synced_ic_pair_bevs(
    *,
    left_df,
    right_df,
    left_action_yaml: Path,
    right_action_yaml: Path,
    left_label: str,
    right_label: str,
    out_dir: Path,
    dataset_name: str,
    xodr_path: Path,
    snapshot_output_px: int = IC_SNAPSHOT_OUTPUT_PX,
    snapshot_border_frac: float = 0.10,
    typography=None,
    ego_zoom_radius: float = IC_EGO_ZOOM_RADIUS_M,
    max_frames: int = IC_MAX_SYNCED_FRAMES,
    conflict_window_before_s: float = 15.0,
    conflict_window_after_s: float = 8.0,
    conflict_window_s: Optional[float] = None,
    left_traj_csv: Optional[Path] = None,
    left_meta_yaml: Optional[Path] = None,
    right_traj_csv: Optional[Path] = None,
    right_meta_yaml: Optional[Path] = None,
    parser_xodr: Any = None,
) -> List[str]:
    """Write shared-clock ego±R|ego±R JPGs into ``out_dir``.

    One shared time ``t'`` (esmini − StartValidCondition clip per side). Frames =
    action stamps in either side's ``[peak−before, peak+after]`` window
    (defaults 15 s / 8 s; OR across sides). Panels use ego ±``ego_zoom_radius`` m.
    Ended side → map-only at last ego-zoom bounds.
    Title: ``t = X.XXs  —  cA_slug; cB_slug``.
    """
    from map_plotter import DEFAULT_BEV_TYPOGRAPHY
    from conflict_frame_selector import _resolve_conflict_windows
    from tier2_renderer import (
        Tier2BevRenderer,
        compose_dual_bev,
        resolve_tier2_paths,
        unique_time_steps,
        _ego_position_lookup,
        _agent_position_lookup,
        esmini_df_to_trajectory_csv,
        write_meta_yaml,
        highlight_conflict_corridor_roads,
        view_bounds_from_df,
        clear_snapshot_dir,
        _metric_chip_text,
    )
    from conflict_frame_selector import (
        select_action_frames,
        _pair_series,
        _metrics_at,
        _normalize_traj_df,
    )

    if typography is None:
        typography = DEFAULT_BEV_TYPOGRAPHY

    out_dir = Path(out_dir)
    out_dir.mkdir(parents=True, exist_ok=True)
    clear_snapshot_dir(out_dir)

    _xodr, map_tracks, location = resolve_tier2_paths(dataset_name)
    if not map_tracks.is_file():
        print("    ⚠️  map tracks missing — synced IC BEVs skipped")
        return []

    zoom_r = float(ego_zoom_radius) if ego_zoom_radius else IC_EGO_ZOOM_RADIUS_M

    renderer = Tier2BevRenderer(
        str(map_tracks),
        str(xodr_path if Path(xodr_path).is_file() else _xodr),
        location=location,
        dataset_name=dataset_name,
        snapshot_output_px=int(snapshot_output_px),
        snapshot_border_frac=snapshot_border_frac,
        typography=typography,
        ego_zoom_radius=zoom_r,
    )

    def _clip_from_labelled(traj_src: Optional[Path], df_n) -> float:
        if traj_src is not None and Path(traj_src).is_file():
            try:
                import pandas as pd

                clip = estimate_clip_start_from_esmini_df(pd.read_csv(traj_src))
                if clip is not None:
                    return float(clip)
            except Exception:
                pass
        clip = estimate_clip_start_from_esmini_df(df_n)
        if clip is None:
            print("    ⚠️  clip_start unavailable — using esmini t=0 for this side")
            return 0.0
        return float(clip)

    def _ego_zoom_bounds(ego_xy) -> Tuple[float, float, float, float]:
        ex, ey = float(ego_xy[0]), float(ego_xy[1])
        return (ex - zoom_r, ex + zoom_r, ey - zoom_r, ey + zoom_r)

    def _last_ego_bounds(side) -> Tuple[float, float, float, float]:
        ego = side["ego_at"](side["t_max"])
        if ego is not None:
            return _ego_zoom_bounds(ego)
        return side["vbounds"]

    def _panel_caption(label: str) -> str:
        return f"{label} ego \u00b1{zoom_r:.0f}m"

    def _render_ended_panel(path: str, side, label: str) -> None:
        """Same BEV panel pipeline as live side; t past end → map only, no cars."""
        bounds = _last_ego_bounds(side)
        renderer._render_one_panel(
            path,
            traj_csv=side["traj"],
            meta_yaml=side["meta"],
            highlight=side["highlight"],
            view_bounds=bounds,
            t=float(side["t_max"]) + 10.0,
            time_label=_panel_caption(label),
            draw_labels=True,
            label_anchors=None,
            metric_chip=None,
            label_avoid_xy=None,
        )

    def _prep(df, action_yaml: Path, *, traj_src: Optional[Path]):
        df_n = _normalize_traj_df(df)
        ts = unique_time_steps(df_n if "time" in df_n.columns else df)
        sel = select_action_frames(
            df_n,
            action_yaml_path=str(action_yaml),
            time_steps=ts,
            conflict_window_s=conflict_window_s,
            conflict_window_before_s=float(conflict_window_before_s),
            conflict_window_after_s=float(conflict_window_after_s),
        )
        work = Path(tempfile.mkdtemp(prefix="ic_pair_bev_"))
        traj = work / "trajectory.csv"
        meta = work / "meta.yaml"
        registry = esmini_df_to_trajectory_csv(df, traj)
        write_meta_yaml(
            registry, df, meta, dataset=dataset_name, location=location
        )
        clip = _clip_from_labelled(traj_src, df_n)
        peak = sel.peak_t
        if peak is None and ts:
            peak = float(ts[len(ts) // 2])
        highlight = highlight_conflict_corridor_roads(
            df,
            renderer.map_tracks_csv,
            partner_name=sel.partner_name,
            context_name=sel.context_partner_name,
            max_roads=5,
            at_time=peak,
        )
        partner_tid = sel.partner_track_id
        series = (
            _pair_series(df_n, int(partner_tid))
            if partner_tid is not None
            else None
        )
        t_max = float(max(ts)) if ts else 0.0
        return {
            "df": df_n,
            "ts": ts,
            "t_max": t_max,
            "clip": float(clip),
            "peak": float(peak) if peak is not None else 0.0,
            "selection": sel,
            "work": work,
            "traj": traj,
            "meta": meta,
            "highlight": highlight or [],
            "vbounds": view_bounds_from_df(df),
            "ego_at": _ego_position_lookup(df),
            "partner_at": (
                _agent_position_lookup(df, name=sel.partner_name)
                if sel.partner_name
                else (lambda _t: None)
            ),
            "partner_name": sel.partner_name,
            "partner_tid": partner_tid,
            "series": series,
        }

    left = _prep(left_df, left_action_yaml, traj_src=left_traj_csv)
    right = _prep(right_df, right_action_yaml, traj_src=right_traj_csv)

    # Keep t' if inside either side's [peak−before, peak+after] (OR).
    peak_l = left["peak"] - left["clip"]
    peak_r = right["peak"] - right["clip"]
    win_before, win_after = _resolve_conflict_windows(
        conflict_window_s=conflict_window_s,
        conflict_window_before_s=conflict_window_before_s,
        conflict_window_after_s=conflict_window_after_s,
    )

    def _in_union_window(t_prime: float) -> bool:
        t = float(t_prime)
        return (
            (peak_l - win_before - 1e-6) <= t <= (peak_l + win_after + 1e-6)
            or (peak_r - win_before - 1e-6) <= t <= (peak_r + win_after + 1e-6)
        )

    keyframes = _merge_rebased_action_times(
        left["selection"].frames,
        right["selection"].frames,
        left["clip"],
        right["clip"],
        max_frames=max_frames * 3,
    )
    keyframes = [kf for kf in keyframes if _in_union_window(kf["t_prime"])]
    if len(keyframes) > max_frames:
        keyframes.sort(key=lambda c: (-c["prio"], c["t_prime"]))
        keyframes = sorted(keyframes[:max_frames], key=lambda c: c["t_prime"])
    if not keyframes:
        for peak in (peak_l, peak_r):
            for d in (-2.0, -1.0, -0.5, 0.0, 0.5, 1.0):
                tp = peak + d
                if _in_union_window(tp):
                    keyframes.append(
                        {
                            "t_prime": tp,
                            "prio": 50,
                            "left_fr": None,
                            "right_fr": None,
                        }
                    )
        keyframes.sort(key=lambda c: c["t_prime"])
        dedup: List[Dict[str, Any]] = []
        for kf in keyframes:
            if dedup and abs(kf["t_prime"] - dedup[-1]["t_prime"]) < 0.05:
                continue
            dedup.append(kf)
        keyframes = dedup[:max_frames]

    written: List[str] = []
    index: List[Dict[str, Any]] = []
    try:
        for kf in keyframes:
            t_prime = float(kf["t_prime"])
            t_l_req = left["clip"] + t_prime
            t_r_req = right["clip"] + t_prime
            left_alive = bool(left["ts"]) and t_l_req <= left["t_max"] + 1e-3
            right_alive = bool(right["ts"]) and t_r_req <= right["t_max"] + 1e-3
            if not left_alive and not right_alive:
                continue

            t_l = _snap_time(left["ts"], t_l_req) if left_alive else None
            t_r = _snap_time(right["ts"], t_r_req) if right_alive else None
            ego_l = left["ego_at"](t_l) if left_alive and t_l is not None else None
            ego_r = right["ego_at"](t_r) if right_alive and t_r is not None else None
            if left_alive and ego_l is None:
                left_alive = False
            if right_alive and ego_r is None:
                right_alive = False
            if not left_alive and not right_alive:
                continue

            partner_l = (
                left["partner_at"](t_l) if left_alive and t_l is not None else None
            )
            partner_r = (
                right["partner_at"](t_r) if right_alive and t_r is not None else None
            )

            fr_l = kf.get("left_fr") if left_alive else None
            fr_r = kf.get("right_fr") if right_alive else None

            # Title / filename slugs: only real critical actions (omit bare "state").
            parts: List[str] = []
            file_bits: List[str] = []
            if fr_l is not None:
                sl = _slug_safe(fr_l.title_event())
                parts.append(f"{left_label}_{sl}")
                file_bits.append(f"{left_label}_{sl}")
            elif not left_alive:
                file_bits.append(f"{left_label}_ended")
            if fr_r is not None:
                sr = _slug_safe(fr_r.title_event())
                parts.append(f"{right_label}_{sr}")
                file_bits.append(f"{right_label}_{sr}")
            elif not right_alive:
                file_bits.append(f"{right_label}_ended")

            if parts:
                title = f"t = {t_prime:.2f}s  —  " + "; ".join(parts)
            else:
                title = f"t = {t_prime:.2f}s"
            fname = f"t_{t_prime:05.2f}_" + "__".join(file_bits) + ".jpg"
            fname = fname.replace(" ", "_")
            out_path = out_dir / fname

            left_tmp = str(left["work"] / "panel_l.jpg")
            right_tmp = str(right["work"] / "panel_r.jpg")
            m_l: Dict[str, Any] = {}
            m_r: Dict[str, Any] = {}

            if left_alive and ego_l is not None and t_l is not None:
                bounds_l = _ego_zoom_bounds(ego_l)
                m_l = _metrics_at(
                    left["series"], t_l, left["partner_name"], left["partner_tid"]
                )
                chip_l = _metric_chip_text(m_l.get("d_m"), m_l.get("ttc_s"))
                avoid_l = [ego_l] + ([partner_l] if partner_l else [])
                renderer._render_one_panel(
                    left_tmp,
                    traj_csv=left["traj"],
                    meta_yaml=left["meta"],
                    highlight=left["highlight"],
                    view_bounds=bounds_l,
                    t=t_l,
                    time_label=_panel_caption(left_label),
                    draw_labels=True,
                    label_anchors=avoid_l,
                    metric_chip=chip_l,
                    label_avoid_xy=avoid_l,
                )
            else:
                _render_ended_panel(left_tmp, left, left_label)

            if right_alive and ego_r is not None and t_r is not None:
                bounds_r = _ego_zoom_bounds(ego_r)
                m_r = _metrics_at(
                    right["series"], t_r, right["partner_name"], right["partner_tid"]
                )
                chip_r = _metric_chip_text(m_r.get("d_m"), m_r.get("ttc_s"))
                avoid_r = [ego_r] + ([partner_r] if partner_r else [])
                renderer._render_one_panel(
                    right_tmp,
                    traj_csv=right["traj"],
                    meta_yaml=right["meta"],
                    highlight=right["highlight"],
                    view_bounds=bounds_r,
                    t=t_r,
                    time_label=_panel_caption(right_label),
                    draw_labels=True,
                    label_anchors=avoid_r,
                    metric_chip=chip_r,
                    label_avoid_xy=avoid_r,
                )
            else:
                _render_ended_panel(right_tmp, right, right_label)

            if not compose_dual_bev(left_tmp, right_tmp, str(out_path), title=title):
                continue
            written.append(str(out_path))
            index.append(
                {
                    "file": fname,
                    "t_s": round(t_prime, 3),
                    "left_alive": left_alive,
                    "right_alive": right_alive,
                    "left_clip_start_s": left["clip"],
                    "right_clip_start_s": right["clip"],
                    "left_label": getattr(fr_l, "label", None),
                    "right_label": getattr(fr_r, "label", None),
                    "left_d_m": m_l.get("d_m"),
                    "left_ttc_s": m_l.get("ttc_s"),
                    "right_d_m": m_r.get("d_m"),
                    "right_ttc_s": m_r.get("ttc_s"),
                    "title": title,
                }
            )
        (out_dir / "synced_bev_index.json").write_text(
            json.dumps(
                {
                    "align": "shared_clip_clock",
                    "note": (
                        "Single shared t = esmini_t - clip_start per side. "
                        "Frames kept if inside left [peak−before, peak+after] OR "
                        "right same (defaults before=15s, after=8s). "
                        f"Panels: ego ±{zoom_r:.0f}m. "
                        "Ended side = map-only at last ego-zoom bounds."
                    ),
                    "conflict_window_before_s": win_before,
                    "conflict_window_after_s": win_after,
                    "ego_zoom_radius_m": zoom_r,
                    "left_peak_s": round(peak_l, 3),
                    "right_peak_s": round(peak_r, 3),
                    "window_lo_s": round(min(peak_l, peak_r) - win_before, 3),
                    "window_hi_s": round(max(peak_l, peak_r) + win_after, 3),
                    "left_clip_start_s": left["clip"],
                    "right_clip_start_s": right["clip"],
                    "left_t_max_s": left["t_max"],
                    "right_t_max_s": right["t_max"],
                    "frames": index,
                },
                indent=2,
            ),
            encoding="utf-8",
        )
    finally:
        shutil.rmtree(left["work"], ignore_errors=True)
        shutil.rmtree(right["work"], ignore_errors=True)

    return written


def process_ic_pair_packs(
    run_dir: Path,
    param_boundary_pairs: List[Dict[str, Any]],
    trial_index_map: Dict[str, Tuple[int, int]],
    collision_flags: Optional[Dict[str, bool]],
    trials_meta: Optional[Dict[str, Any]],
    xodr_path: Path,
    parser_xodr: Any,
    *,
    dataset_name: str = "dataset1",
    snapshot_output_px: int = IC_SNAPSHOT_OUTPUT_PX,
    snapshot_border_frac: float = 0.10,
    typography=None,
    ego_zoom_radius: float = IC_EGO_ZOOM_RADIUS_M,
    contact_clearance_m: float = 0.5,
    conflict_relevance_m: float = 5.0,
    conflict_window_s: Optional[float] = None,
    conflict_window_before_s: float = 15.0,
    conflict_window_after_s: float = 8.0,
    tau: float = IC_PARAM_DIST_TAU,
    scope: Optional[set] = None,
) -> List[Dict[str, Any]]:
    """Materialize gated IC pairs under ``ic_pairs/cA-cB/`` and drop legacy dirs."""
    from csv_roadid_loader import get_csv_road_data
    from dataset_builder import process_trial_to_dir, cluster_in_scope
    from cluster_paths import resolve_path
    from conflict_frame_selector import select_action_frames
    from tier2_renderer import unique_time_steps
    from map_plotter import DEFAULT_BEV_TYPOGRAPHY
    import yaml as _yaml

    if typography is None:
        typography = DEFAULT_BEV_TYPOGRAPHY

    run_dir = Path(run_dir)
    annotated = annotate_param_boundary_pairs(param_boundary_pairs, tau=tau)
    _win_kw = dict(
        conflict_window_s=conflict_window_s,
        conflict_window_before_s=float(conflict_window_before_s),
        conflict_window_after_s=float(conflict_window_after_s),
    )

    if scope is not None and len(scope) == 0:
        print("  ⏭  IC-pair packs skipped")
        return annotated

    root = ic_pairs_root(run_dir)
    root.mkdir(parents=True, exist_ok=True)

    # Drop legacy flat LLM YAMLs only; pair folders are replaced per matched pair.
    for child in list(root.iterdir()):
        if child.is_file() and child.name.startswith("pair_c") and child.suffix == ".yaml":
            child.unlink(missing_ok=True)
        elif child.is_file() and child.name.endswith("_meta.json"):
            child.unlink(missing_ok=True)

    def _events(tid: str):
        info = (trials_meta or {}).get(str(tid))
        return info.get("events") if isinstance(info, dict) else None

    built = 0
    for bp in annotated:
        if not bp.get("ic_match"):
            # Remove stale pack if a prior run materialised a far pair
            stale = pair_pack_dir(run_dir, bp["cluster_a"], bp["cluster_b"])
            if stale.is_dir():
                shutil.rmtree(stale, ignore_errors=True)
            print(
                f"  ⏭  IC pair c{bp['cluster_a']}↔c{bp['cluster_b']} "
                f"param_dist={bp.get('param_dist')} > τ={tau} (skipped)"
            )
            continue
        ca, cb = int(bp["cluster_a"]), int(bp["cluster_b"])
        if not (cluster_in_scope(ca, scope) or cluster_in_scope(cb, scope)):
            continue
        ta, tb = str(bp["trial_a"]), str(bp["trial_b"])
        if ta not in trial_index_map or tb not in trial_index_map:
            print(f"  ⚠️  IC pair {ta}/{tb} missing from index map — skipped")
            continue
        ba, tia = trial_index_map[ta]
        bb, tib = trial_index_map[tb]
        # Persist indices on the pair row for offline rebuilds
        bp["trial_index_a"] = int(tia)
        bp["batch_id_a"] = int(ba)
        bp["trial_index_b"] = int(tib)
        bp["batch_id_b"] = int(bb)
        pack = pair_pack_dir(run_dir, ca, cb)
        if pack.is_dir():
            shutil.rmtree(pack, ignore_errors=True)
        pack.mkdir(parents=True, exist_ok=True)
        left_dir = side_trial_dir(pack, ca, tia)
        right_dir = side_trial_dir(pack, cb, tib)
        role = str(bp.get("card_role") or "primary")
        print(
            f"  🔹 IC-pair [{role}] c{ca}↔c{cb} param_dist={bp.get('param_dist'):.4f} "
            f"→ {pack.relative_to(run_dir)}"
        )

        ok_l = process_trial_to_dir(
            ba, tia, ta, left_dir, xodr_path, parser_xodr,
            dataset_name=dataset_name,
            snapshot_output_px=snapshot_output_px,
            snapshot_border_frac=snapshot_border_frac,
            typography=typography,
            max_snapshots=0,
            collided=bool((collision_flags or {}).get(ta, bp.get("collided_a"))),
            trial_events=_events(ta),
            contact_clearance_m=contact_clearance_m,
            conflict_relevance_m=conflict_relevance_m,
            **_win_kw,
        )
        ok_r = process_trial_to_dir(
            bb, tib, tb, right_dir, xodr_path, parser_xodr,
            dataset_name=dataset_name,
            snapshot_output_px=snapshot_output_px,
            snapshot_border_frac=snapshot_border_frac,
            typography=typography,
            max_snapshots=0,
            collided=bool((collision_flags or {}).get(tb, bp.get("collided_b"))),
            trial_events=_events(tb),
            contact_clearance_m=contact_clearance_m,
            conflict_relevance_m=conflict_relevance_m,
            **_win_kw,
        )
        if not (ok_l and ok_r):
            print("    ⚠️  side pack failed — pair incomplete")
            continue

        for side_dir, cl, peer, tid, bi, ti in (
            (left_dir, ca, cb, ta, ba, tia),
            (right_dir, cb, ca, tb, bb, tib),
        ):
            action_path = resolve_path(side_dir, "action.yaml", must_exist=True)
            action_data = None
            selection = None
            clip_s: Optional[float] = None
            traj_path = resolve_path(side_dir, "trajectory.csv", must_exist=True)
            if traj_path and Path(traj_path).is_file():
                try:
                    import pandas as pd

                    clip_s = estimate_clip_start_from_esmini_df(pd.read_csv(traj_path))
                except Exception:
                    clip_s = None
            if action_path and action_path.is_file():
                try:
                    action_data = _yaml.safe_load(
                        action_path.read_text(encoding="utf-8")
                    )
                except Exception:
                    action_data = None
                df = get_csv_road_data(bi, ti)
                if df is not None and not df.empty:
                    try:
                        selection = select_action_frames(
                            df,
                            action_yaml_path=str(action_path),
                            time_steps=unique_time_steps(df),
                            **_win_kw,
                        )
                    except Exception:
                        selection = None
            write_ic_trial_context_md(
                side_dir,
                cluster=cl,
                payload_trial_id=tid,
                trial_index=ti,
                action_data=action_data,
                selection=selection,
                card_role=role,
                peer_cluster=peer,
                clip_start_s=clip_s,
                **_win_kw,
            )
            # Persist selection metrics even when per-trial JPGs are skipped
            # (synced_bev is the visual product).
            if selection is not None:
                from cluster_paths import snapshots_dir

                snap_dir = snapshots_dir(side_dir)
                snap_dir.mkdir(parents=True, exist_ok=True)
                try:
                    names = [
                        f"trial_{ti}_t_{fr.t:.2f}_{fr.title_event()}.jpg"
                        if hasattr(fr, "title_event")
                        else (
                            f"trial_{ti}_t_{fr.t:.2f}_{fr.concise_slug()}.jpg"
                            if hasattr(fr, "concise_slug")
                            else f"trial_{ti}_t_{fr.t:.2f}.jpg"
                        )
                        for fr in (selection.frames or [])
                    ]
                    # Pad/truncate to frames length for zip in to_llm_json
                    while len(names) < len(selection.frames or []):
                        names.append(f"trial_{ti}_frame_{len(names)}.jpg")
                    doc = selection.to_llm_json(
                        file_prefix=f"trial_{ti}", filenames=names
                    )
                    (snap_dir / "llm_snapshots.json").write_text(
                        json.dumps(doc, indent=2), encoding="utf-8"
                    )
                except Exception:
                    pass

        left_df = get_csv_road_data(ba, tia)
        right_df = get_csv_road_data(bb, tib)
        left_action = resolve_path(left_dir, "action.yaml", must_exist=True)
        right_action = resolve_path(right_dir, "action.yaml", must_exist=True)
        left_traj = resolve_path(left_dir, "trajectory.csv", must_exist=True)
        right_traj = resolve_path(right_dir, "trajectory.csv", must_exist=True)
        left_meta = resolve_path(left_dir, "meta.yaml", must_exist=True)
        right_meta = resolve_path(right_dir, "meta.yaml", must_exist=True)
        synced = pack / "synced_bev"
        n_bev = 0
        if (
            left_df is not None
            and right_df is not None
            and left_action
            and right_action
        ):
            try:
                paths = render_synced_ic_pair_bevs(
                    left_df=left_df,
                    right_df=right_df,
                    left_action_yaml=left_action,
                    right_action_yaml=right_action,
                    left_label=f"c{ca}",
                    right_label=f"c{cb}",
                    out_dir=synced,
                    dataset_name=dataset_name,
                    xodr_path=xodr_path,
                    snapshot_output_px=snapshot_output_px,
                    snapshot_border_frac=snapshot_border_frac,
                    typography=typography,
                    ego_zoom_radius=ego_zoom_radius,
                    **_win_kw,
                    left_traj_csv=left_traj,
                    left_meta_yaml=left_meta,
                    right_traj_csv=right_traj,
                    right_meta_yaml=right_meta,
                    parser_xodr=parser_xodr,
                )
                n_bev = len(paths)
                print(f"    ✓ {n_bev} synced pair BEVs → {synced.name}/")
            except Exception as exc:
                print(f"    ⚠️  synced BEV failed: {exc}")

        pair_doc = {
            **bp,
            "folder": pair_folder_name(ca, cb),
            "left": {
                "cluster": ca,
                "payload_trial_id": ta,
                "trial_index": tia,
                "batch_id": ba,
                "dir": left_dir.name,
                "outcome": "collision" if bp.get("collided_a") else "safe",
            },
            "right": {
                "cluster": cb,
                "payload_trial_id": tb,
                "trial_index": tib,
                "batch_id": bb,
                "dir": right_dir.name,
                "outcome": "collision" if bp.get("collided_b") else "safe",
            },
            "synced_bev_count": n_bev,
        }
        (pack / "pair.json").write_text(
            json.dumps(pair_doc, indent=2), encoding="utf-8"
        )
        built += 1

    removed = remove_legacy_param_boundary_dirs(run_dir)
    if removed:
        print(f"  🧹 Removed {len(removed)} legacy param_boundary folder(s)")
    print(f"  ✓ Built {built} IC-pair pack(s) under {root}")
    return annotated
