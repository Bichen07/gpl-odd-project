"""Trajectory-projection (MFPCA) closest-pair packs under ``results/.../trajectory_projection_pairs/cA-cB/``.

Symmetric to ``parameter_space_pairs/cA-cB/``. Replaces legacy
``cluster*/highlight_trials/boundary_c*`` per-side folders.
"""
from __future__ import annotations

import json
import shutil
from pathlib import Path
from typing import Any, Dict, List, Optional, Set, Tuple

from parameter_space_pair_packs import (
    PARAMETER_SPACE_EGO_ZOOM_RADIUS_M,
    PARAMETER_SPACE_SNAPSHOT_OUTPUT_PX,
    estimate_clip_start_from_esmini_df,
    pair_folder_name,
    render_synced_parameter_space_pair_bevs,
    side_trial_dir,
    write_parameter_space_trial_context_md,
)


def trajectory_projection_pairs_root(run_dir: Path) -> Path:
    """Prefer ``trajectory_projection_pairs/``; fall back to legacy ``boundary_pairs/``."""
    run_dir = Path(run_dir)
    new = run_dir / "trajectory_projection_pairs"
    if new.is_dir():
        return new
    legacy = run_dir / "boundary_pairs"
    if legacy.is_dir():
        return legacy
    return new


def trajectory_projection_pair_pack_dir(run_dir: Path, cluster_a: Any, cluster_b: Any) -> Path:
    return trajectory_projection_pairs_root(run_dir) / pair_folder_name(cluster_a, cluster_b)


def annotate_trajectory_projection_pairs(
    pairs: List[Dict[str, Any]],
) -> List[Dict[str, Any]]:
    """Tag outcome contrast for LLM cards (no distance gate — all pairs kept)."""
    out: List[Dict[str, Any]] = []
    for bp in pairs:
        row = dict(bp)
        ca = bool(row.get("collided_a"))
        cb = bool(row.get("collided_b"))
        row["card_role"] = "primary" if ca != cb else "secondary"
        row["pair_kind"] = "trajectory_projection"
        out.append(row)
    print(
        f"  📐 Trajectory-projection: {len(out)} pair(s) "
        f"(primary={sum(1 for p in out if p.get('card_role')=='primary')}, "
        f"secondary={sum(1 for p in out if p.get('card_role')=='secondary')})"
    )
    return out


def remove_legacy_trajectory_projection_dirs(run_dir: Path) -> List[str]:
    """Delete ``cluster*/highlight_trials/boundary_c*`` (and flat legacy)."""
    removed: List[str] = []
    run_dir = Path(run_dir)
    for cluster_dir in sorted(run_dir.glob("cluster*")):
        if not cluster_dir.is_dir():
            continue
        for base in (cluster_dir / "highlight_trials", cluster_dir):
            if not base.is_dir():
                continue
            for child in list(base.iterdir()):
                if child.is_dir() and child.name.startswith("boundary_c"):
                    shutil.rmtree(child, ignore_errors=True)
                    removed.append(str(child.relative_to(run_dir)))
    return removed


def find_trajectory_projection_pair_side_dir(
    run_dir: Path,
    cluster: Any,
    other_cluster: Any,
    trial_id: str,
    trial_index_map: Optional[Dict[str, Tuple[int, int]]] = None,
) -> Optional[Path]:
    """Resolve ``trajectory_projection_pairs/cA-cB/c{cluster}_trial_{idx}/``."""
    pack = trajectory_projection_pair_pack_dir(run_dir, cluster, other_cluster)
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


def process_trajectory_projection_pair_packs(
    run_dir: Path,
    trajectory_projection_pairs: List[Dict[str, Any]],
    trial_index_map: Dict[str, Tuple[int, int]],
    collision_flags: Optional[Dict[str, bool]],
    trials_meta: Optional[Dict[str, Any]],
    xodr_path: Path,
    parser_xodr: Any,
    *,
    dataset_name: str = "dataset1",
    snapshot_output_px: int = PARAMETER_SPACE_SNAPSHOT_OUTPUT_PX,
    snapshot_border_frac: float = 0.10,
    typography=None,
    ego_zoom_radius: float = PARAMETER_SPACE_EGO_ZOOM_RADIUS_M,
    contact_clearance_m: float = 0.5,
    conflict_relevance_m: float = 5.0,
    conflict_window_s: Optional[float] = None,
    conflict_window_before_s: float = 15.0,
    conflict_window_after_s: float = 8.0,
    scope: Optional[Set[Any]] = None,
) -> List[Dict[str, Any]]:
    """Materialize trajectory-projection closest pairs under ``trajectory_projection_pairs/cA-cB/``; drop legacy dirs."""
    from csv_roadid_loader import get_csv_road_data
    from dataset_builder import process_trial_to_dir, cluster_in_scope
    from cluster_paths import resolve_path, snapshots_dir
    from conflict_frame_selector import select_action_frames
    from tier2_renderer import unique_time_steps
    from map_plotter import DEFAULT_BEV_TYPOGRAPHY
    import yaml as _yaml

    if typography is None:
        typography = DEFAULT_BEV_TYPOGRAPHY

    run_dir = Path(run_dir)
    annotated = annotate_trajectory_projection_pairs(trajectory_projection_pairs)
    _win_kw = dict(
        conflict_window_s=conflict_window_s,
        conflict_window_before_s=float(conflict_window_before_s),
        conflict_window_after_s=float(conflict_window_after_s),
    )

    if scope is not None and len(scope) == 0:
        print("  ⏭  Trajectory-projection pair packs skipped")
        return annotated

    root = trajectory_projection_pairs_root(run_dir)
    root.mkdir(parents=True, exist_ok=True)

    def _events(tid: str):
        info = (trials_meta or {}).get(str(tid))
        return info.get("events") if isinstance(info, dict) else None

    built = 0
    for bp in annotated:
        ca, cb = int(bp["cluster_a"]), int(bp["cluster_b"])
        if not (cluster_in_scope(ca, scope) or cluster_in_scope(cb, scope)):
            continue
        ta, tb = str(bp["trial_a"]), str(bp["trial_b"])
        if ta not in trial_index_map or tb not in trial_index_map:
            print(f"  ⚠️  Emb pair {ta}/{tb} missing from index map — skipped")
            continue
        ba, tia = trial_index_map[ta]
        bb, tib = trial_index_map[tb]
        bp["trial_index_a"] = int(tia)
        bp["batch_id_a"] = int(ba)
        bp["trial_index_b"] = int(tib)
        bp["batch_id_b"] = int(bb)
        pack = trajectory_projection_pair_pack_dir(run_dir, ca, cb)
        if pack.is_dir():
            shutil.rmtree(pack, ignore_errors=True)
        pack.mkdir(parents=True, exist_ok=True)
        left_dir = side_trial_dir(pack, ca, tia)
        right_dir = side_trial_dir(pack, cb, tib)
        role = str(bp.get("card_role") or "secondary")
        emb = bp.get("embedding_dist")
        emb_s = f"{float(emb):.4f}" if isinstance(emb, (int, float)) else "?"
        print(
            f"  🔹 Trajectory-projection pair [{role}] c{ca}↔c{cb} embedding_dist={emb_s} "
            f"→ {pack.relative_to(run_dir)}"
        )

        ok_l = process_trial_to_dir(
            ba,
            tia,
            ta,
            left_dir,
            xodr_path,
            parser_xodr,
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
            bb,
            tib,
            tb,
            right_dir,
            xodr_path,
            parser_xodr,
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

                    clip_s = estimate_clip_start_from_esmini_df(
                        pd.read_csv(traj_path),
                        batch_id=bi,
                    )
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
            write_parameter_space_trial_context_md(
                side_dir,
                cluster=cl,
                payload_trial_id=tid,
                trial_index=ti,
                action_data=action_data,
                selection=selection,
                card_role=role,
                peer_cluster=peer,
                clip_start_s=clip_s,
                heading="MFPCA embedding-pair trial",
                **_win_kw,
            )
            if selection is not None:
                snap_dir = snapshots_dir(side_dir)
                snap_dir.mkdir(parents=True, exist_ok=True)
                try:
                    names = [
                        f"trial_{ti}_t_{fr.t:.2f}_{fr.title_event()}.jpg"
                        if hasattr(fr, "title_event")
                        else f"trial_{ti}_t_{fr.t:.2f}.jpg"
                        for fr in (selection.frames or [])
                    ]
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
                paths = render_synced_parameter_space_pair_bevs(
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

    removed = remove_legacy_trajectory_projection_dirs(run_dir)
    if removed:
        print(f"  🧹 Removed {len(removed)} legacy boundary_c* folder(s)")
    print(f"  ✓ Built {built} trajectory-projection pair pack(s) under {root}")
    return annotated
