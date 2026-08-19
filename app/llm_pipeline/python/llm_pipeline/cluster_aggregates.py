"""Cluster aggregate stats + per-trial conflict packs (deterministic)."""
from __future__ import annotations

import json
import os
import sys
import urllib.error
import urllib.parse
import urllib.request
from pathlib import Path
from typing import Any, Dict, List, Optional, Tuple

import numpy as np

# Conflict / timeline fields that are absolute esmini seconds before clip rebase.
_TIME_KEYS = ("peak_t", "relevance_t", "brake_t")


def _cluster_paths():
    """Lazy import analyzer ``cluster_paths`` (nested-then-flat resolve)."""
    analyzer_src = Path(__file__).resolve().parents[3] / "analyzer" / "src"
    if str(analyzer_src) not in sys.path:
        sys.path.insert(0, str(analyzer_src))
    import cluster_paths as cp  # type: ignore

    return cp


def _resolve(trial_dir: Path, artifact: str) -> Optional[Path]:
    return _cluster_paths().resolve_path(trial_dir, artifact, must_exist=True)


def resolve_observation_clip_start(trial_id: str) -> Optional[float]:
    """First Payload observation ``esminiSeconds`` for a trial (= StartValidCondition clip).

    Returns None when Payload is unreachable or the trial has no observations.
    """
    tid = str(trial_id).strip()
    if not tid or not tid.isdigit():
        return None
    base = (
        os.environ.get("PAYLOAD_API")
        or os.environ.get("NEXT_PUBLIC_PAYLOAD_API_ADDRESS")
        or ""
    ).rstrip("/")
    if not base:
        return None
    if not base.endswith("/api") and "/api" not in base:
        # Allow either http://host:3020 or http://host:3020/api
        api = f"{base}/api"
    else:
        api = base
    key = (
        os.environ.get("PAYLOAD_API_KEY")
        or os.environ.get("USER_API_KEY")
        or os.environ.get("NEXT_PUBLIC_PAYLOAD_API_KEY")
        or ""
    )
    headers = {"Authorization": f"users API-Key {key}"} if key else {}
    q = urllib.parse.urlencode(
        {"limit": 1, "sort": "esminiSeconds", "where[trial][equals]": tid}
    )
    url = f"{api}/observations?{q}"
    try:
        req = urllib.request.Request(url, headers=headers)
        with urllib.request.urlopen(req, timeout=20) as resp:
            doc = json.loads(resp.read().decode("utf-8"))
    except (urllib.error.URLError, TimeoutError, json.JSONDecodeError, OSError):
        return None
    docs = doc.get("docs") or []
    if not docs:
        return None
    val = docs[0].get("esminiSeconds")
    try:
        return float(val) if val is not None else None
    except (TypeError, ValueError):
        return None


def estimate_clip_start_from_cluster_json(trial_dir: Path) -> Optional[float]:
    """Analysis clip start from medoid esmini CSV via ``clip_conditions.yaml``.

    Same rule as Replayer analysis-clip / ``parameter_space_pair_packs`` (not a separate
    road-92 guess).
    """
    cj_path = _resolve(Path(trial_dir), "cluster.json")
    if cj_path is None:
        return None
    try:
        med = (json.loads(cj_path.read_text(encoding="utf-8")).get("medoid") or {})
        batch_id = int(med.get("batch_id", 2))
        trial_index = int(med["trial_index"])
    except Exception:
        return None

    try:
        from csv_roadid_loader import get_csv_road_data  # type: ignore
        from clip_conditions import resolve_clip_start_from_df  # type: ignore

        df = get_csv_road_data(batch_id, trial_index)
        if df is None or df.empty:
            return None
        return resolve_clip_start_from_df(df, batch_id=batch_id)
    except Exception:
        return None


def load_clip_start(trial_dir: Path, trial_id: Optional[str] = None) -> Optional[float]:
    """Load clip start from ``clip_time.json``, config+CSV, or Payload fallback."""
    clip_path = Path(trial_dir) / "clip_time.json"
    if clip_path.is_file():
        try:
            data = json.loads(clip_path.read_text(encoding="utf-8"))
            if data.get("clip_start_esmini_s") is not None:
                return float(data["clip_start_esmini_s"])
        except Exception:
            pass

    # Prefer shared clip_conditions.yaml + esmini CSV (analysis-stage clock).
    from_csv = estimate_clip_start_from_cluster_json(Path(trial_dir))
    if from_csv is not None:
        return from_csv

    tid = trial_id
    if not tid:
        cj = _resolve(Path(trial_dir), "cluster.json")
        if cj is not None:
            try:
                med = (json.loads(cj.read_text(encoding="utf-8")).get("medoid") or {})
                tid = med.get("trial_id")
            except Exception:
                tid = None

    if tid:
        from_payload = resolve_observation_clip_start(str(tid))
        if from_payload is not None:
            return from_payload

    return None


def write_clip_time(
    trial_dir: Path,
    clip_start: float,
    *,
    trial_id: Optional[str] = None,
    source: str = "clip_conditions.yaml",
) -> Path:
    """Persist clip metadata next to medoid artifacts."""
    path = Path(trial_dir) / "clip_time.json"
    doc = {
        "clip_start_esmini_s": round(float(clip_start), 3),
        "time_origin": "analysis_clip_conditions",
        "source": source,
        "note": (
            "t=0 for Replayer/LLM timelines from app/analyzer/config/"
            "clip_conditions.yaml applied to esmini CSV (analysis-stage; "
            "simulation upload unchanged)."
        ),
    }
    if trial_id is not None:
        doc["trial_id"] = str(trial_id)
    path.write_text(json.dumps(doc, indent=2), encoding="utf-8")
    return path


def rebase_seconds(value: Any, clip_start: float) -> Any:
    """Subtract clip_start from a numeric time; leave non-numerics unchanged."""
    if value is None:
        return None
    try:
        t = float(value)
    except (TypeError, ValueError):
        return value
    return round(max(0.0, t - float(clip_start)), 3)


def rebase_conflict_pack(pack: Dict[str, Any], clip_start: float) -> Dict[str, Any]:
    """Return a copy of conflict pack with timing fields on the Payload clip clock."""
    out = dict(pack)
    for key in _TIME_KEYS:
        if key in out:
            out[key] = rebase_seconds(out.get(key), clip_start)
    if isinstance(out.get("impact"), dict) and "t" in out["impact"]:
        impact = dict(out["impact"])
        impact["t"] = rebase_seconds(impact.get("t"), clip_start)
        out["impact"] = impact
    out["clip_start_esmini_s"] = round(float(clip_start), 3)
    out["time_origin"] = "payload_observation_clip"
    return out


def rebase_decision_timeline(
    timeline: Any, clip_start: float
) -> List[Dict[str, Any]]:
    """Shift decision_timeline timestamps onto the clip clock.

    If timestamps already look rebased (all strictly below clip_start), leave them.
    """
    if not isinstance(timeline, list):
        return []
    events: List[Dict[str, Any]] = []
    raw_ts: List[float] = []
    for ev in timeline:
        if not isinstance(ev, dict):
            continue
        item = dict(ev)
        events.append(item)
        ts = item.get("timestamp", item.get("time", item.get("t")))
        try:
            if ts is not None:
                raw_ts.append(float(ts))
        except (TypeError, ValueError):
            pass
    if not events:
        return events
    # Absolute esmini times for this scenario are typically >= clip_start.
    looks_absolute = bool(raw_ts) and max(raw_ts) >= float(clip_start) - 1e-6
    if not looks_absolute:
        return events
    for item in events:
        for key in ("timestamp", "time", "t"):
            if key in item and item[key] is not None:
                item[key] = rebase_seconds(item[key], clip_start)
                break
    return events


def _percentile(vals: List[float], q: float) -> Optional[float]:
    if not vals:
        return None
    return round(float(np.percentile(np.asarray(vals, dtype=float), q)), 3)


# TTC KPI ceiling tolerance: values within this of the observed max are
# treated as "at the look-ahead ceiling" (no live conflict detected), not a
# literal measured gap. Empirical, not hardcoded to a specific seconds value,
# because the ceiling is set by Payload's KPI computation, not by us.
_CEILING_TOL = 1e-3


def _ttc_digest(vals: List[float]) -> Dict[str, Any]:
    if not vals:
        return {"n": 0, "mean": None, "std": None, "min": None,
                "p10": None, "p50": None, "p90": None,
                "ceiling_estimate": None, "at_ceiling_frac": None}
    arr = np.asarray(vals, dtype=float)
    ceiling = float(arr.max())
    at_ceiling = int(np.sum(arr >= ceiling - _CEILING_TOL))
    return {
        "n": int(len(arr)),
        "mean": round(float(arr.mean()), 3),
        "std": round(float(arr.std()), 3),
        "min": round(float(arr.min()), 3),
        "p10": _percentile(vals, 10),
        "p50": _percentile(vals, 50),
        "p90": _percentile(vals, 90),
        # Empirical ceiling honesty (Stage A1): when a large share of values
        # sit at the observed max, that max is very likely the KPI's
        # look-ahead ceiling (no live conflict found), not a real measured
        # TTC. Only meaningful when n is not tiny.
        "ceiling_estimate": round(ceiling, 3),
        "at_ceiling_frac": round(at_ceiling / len(arr), 3),
    }


def _ic_digest(vals: List[float]) -> Dict[str, Any]:
    if not vals:
        return {"n": 0, "mean": None, "std": None, "p10": None, "p90": None,
                "range": None}
    arr = np.asarray(vals, dtype=float)
    return {
        "n": int(len(arr)),
        "mean": round(float(arr.mean()), 4),
        "std": round(float(arr.std()), 4),
        "p10": round(float(np.percentile(arr, 10)), 4),
        "p90": round(float(np.percentile(arr, 90)), 4),
        "range": [round(float(arr.min()), 4), round(float(arr.max()), 4)],
    }


def build_enriched_cluster_aggregate(
    cluster_label: int,
    trial_ids: List[str],
    trial_mappings: Dict[str, Any],
    scenario_parameters: Optional[List[Dict]] = None,
    collision_flags: Optional[Dict[str, bool]] = None,
    intra_variance: Optional[Dict[str, Any]] = None,
) -> Dict[str, Any]:
    """Build honest distribution digests for one cluster."""
    param_id_to_name: Dict[str, str] = {}
    for p in scenario_parameters or []:
        if not isinstance(p, dict):
            continue
        pid = p.get("id") or p.get("parameterId")
        if pid is not None:
            param_id_to_name[str(pid)] = p.get("name") or str(pid)

    collisions = 0
    ttc_all: List[float] = []
    ttc_collide: List[float] = []
    ttc_survive: List[float] = []
    spret_vals: List[float] = []
    spret_capped_n = 0
    param_vals: Dict[str, List[float]] = {}

    for tid in trial_ids:
        trial = trial_mappings.get(str(tid)) or trial_mappings.get(tid)
        if not isinstance(trial, dict):
            continue
        collided = False
        if collision_flags is not None:
            collided = bool(collision_flags.get(str(tid), False))
        ttc_here: Optional[float] = None
        for m in (trial.get("testObjectives") or {}).get("criticalityMetrics") or []:
            if not isinstance(m, dict):
                continue
            kpi = (m.get("keyPerformanceIndicator") or {}).get("name", "")
            val = m.get("value")
            if val is None:
                continue
            try:
                fval = float(val)
            except (TypeError, ValueError):
                continue
            if kpi == "collision":
                if fval > 0:
                    collided = True
            elif kpi == "ttc_min":
                ttc_here = fval
                ttc_all.append(fval)
            elif kpi == "spret_min":
                if fval >= 9.0:
                    spret_capped_n += 1
                spret_vals.append(min(fval, 9.0))
        if collided:
            collisions += 1
            if ttc_here is not None:
                ttc_collide.append(ttc_here)
        else:
            if ttc_here is not None:
                ttc_survive.append(ttc_here)
        for tp in trial.get("parameters") or []:
            if not isinstance(tp, dict):
                continue
            pid = str(tp.get("parameterId", tp.get("id", "")))
            name = param_id_to_name.get(pid) or tp.get("name") or (pid or "param")
            try:
                param_vals.setdefault(str(name), []).append(float(tp.get("value", 0)))
            except (TypeError, ValueError):
                continue

    n = max(len(trial_ids), 1)
    ic = {k: _ic_digest(v) for k, v in sorted(param_vals.items())}
    # Compat box ranges for old consumers
    parameter_ranges = {
        k: d["range"] for k, d in ic.items() if d.get("range")
    }
    return {
        "cluster_label": int(cluster_label),
        "n_trials": len(trial_ids),
        "collision_count": collisions,
        "collision_rate": round(100.0 * collisions / n, 2),
        "ttc": _ttc_digest(ttc_all),
        "ttc_collide": _ttc_digest(ttc_collide),
        "ttc_survive": _ttc_digest(ttc_survive),
        "mean_ttc": _ttc_digest(ttc_all).get("mean"),
        "min_ttc": _ttc_digest(ttc_all).get("min"),
        "mean_spret": round(float(np.mean(spret_vals)), 3) if spret_vals else None,
        # SPrET is code-capped at 9.0 (see `min(fval, 9.0)` above); surface how
        # much of the mean is sitting at that cap so it reads as "no scaled
        # encroachment predicted", not "9 is a real measured value".
        "spret_capped_frac": (
            round(spret_capped_n / len(spret_vals), 3) if spret_vals else None
        ),
        "ic": ic,
        "parameter_ranges": parameter_ranges,
        "intra_variance": intra_variance or {},
    }


def _bearing_sector(az_deg: float) -> Optional[str]:
    """Mirror analyzer ``conflict_frame_selector._bearing_sector`` (lazy import,
    no hard dependency edge from llm_pipeline -> analyzer at module load time).
    """
    try:
        analyzer_src = Path(__file__).resolve().parents[3] / "analyzer" / "src"
        if str(analyzer_src) not in sys.path:
            sys.path.insert(0, str(analyzer_src))
        from conflict_frame_selector import _bearing_sector as _sector  # type: ignore

        return _sector(float(az_deg))
    except Exception:
        return None


def _frame_metric(frame: Dict[str, Any], key: str, *legacy: str) -> Any:
    """Read canonical metric key; accept legacy snapshot keys once."""
    if frame.get(key) is not None:
        return frame.get(key)
    for k in legacy:
        if frame.get(k) is not None:
            return frame.get(k)
    return None


def _impact_classification(
    frame: Dict[str, Any], partner_name: Optional[str]
) -> Optional[Dict[str, Any]]:
    """Deterministic collision geometry from the COLLISION frame's kinematics.

    Answers "who hit whom, from which angle, at what speed" from the same
    az/v_ego/v_partner/closing already computed upstream (see
    ``conflict_frame_selector.SelectedFrame``) but never surfaced to the LLM.
    This is handed to the LLM as ground truth (not inferred by it) so the
    medoid/Parameter-space pair prompts can describe collisions precisely instead of
    guessing from bare distance/ttc numbers.
    """
    az = _frame_metric(frame, "az", "az_deg")
    if az is None:
        return None
    az = float(az)
    sector = _bearing_sector(az)
    partner = partner_name or "the partner"
    v_ego = frame.get("v_ego")
    v_partner = frame.get("v_partner")
    dv = None
    if v_ego is not None and v_partner is not None:
        dv = round(float(v_partner) - float(v_ego), 2)

    # Naming: `striking_vehicle` = the one whose FRONT made contact (the mover
    # that closed the gap); `struck_vehicle` = the one whose REAR/side was hit.
    if sector in ("BEHIND", "BEHIND LEFT", "BEHIND RIGHT"):
        impact_type = "rear-end"
        striking_vehicle, struck_vehicle = partner, "Ego"
        detail = f"{partner} approaches from behind (az={az:.1f}°) and strikes Ego's rear."
    elif sector in ("FRONT", "FRONT LEFT", "FRONT RIGHT"):
        impact_type = "rear-end"
        striking_vehicle, struck_vehicle = "Ego", partner
        detail = f"Ego is trailing {partner} (az={az:.1f}°) and strikes {partner}'s rear."
    elif sector in ("LEFT", "RIGHT"):
        impact_type = "side/lateral impact"
        striking_vehicle = struck_vehicle = None
        side = "left" if sector == "LEFT" else "right"
        detail = (
            f"{partner} contacts Ego's {side} side (az={az:.1f}°) — "
            f"side-swipe or T-bone geometry, not a straight-line rear-end."
        )
    else:
        impact_type = "unclear"
        striking_vehicle = struck_vehicle = None
        detail = f"Ambiguous impact geometry at az={az:.1f}°."

    if dv is not None:
        faster = partner if dv > 0.1 else ("Ego" if dv < -0.1 else "neither (~equal)")
        detail += f" At impact v_ego={v_ego:.2f} m/s, v_partner={v_partner:.2f} m/s (faster: {faster})."

    return {
        "t": frame.get("t"),
        "partner": partner_name,
        "az": round(az, 1),
        "bearing_sector": sector,
        "d": _frame_metric(frame, "d", "d_m"),
        "v_ego": v_ego,
        "v_partner": v_partner,
        "closing": _frame_metric(frame, "closing", "closing_mps"),
        "impact_type": impact_type,
        "striking_vehicle": striking_vehicle,
        "struck_vehicle": struck_vehicle,
        "detail": detail,
    }


def apply_collision_detail(parsed: Dict[str, Any], pack: Dict[str, Any]) -> Dict[str, Any]:
    """Force ``collision_detail`` to match ``pack['impact']`` (deterministic GT).

    The LLM is asked to copy ``impact_type`` / ``struck_by`` / ``bearing_sector``
    verbatim and only author the one-sentence ``narrative`` — but LLM compliance
    with "copy this field" instructions is not guaranteed, so the structured
    fields are overwritten here the same way ``conflict_metrics`` already is.
    Only the narrative sentence (if the LLM wrote one) is kept as-is.
    """
    impact = pack.get("impact") if isinstance(pack, dict) else None
    if not isinstance(impact, dict):
        parsed.pop("collision_detail", None)
        return parsed
    existing = parsed.get("collision_detail")
    narrative = None
    if isinstance(existing, dict):
        narrative = existing.get("narrative")
    if not narrative or not isinstance(narrative, str) or not narrative.strip():
        narrative = impact.get("detail")
    parsed["collision_detail"] = {
        "impact_type": impact.get("impact_type"),
        "striking_vehicle": impact.get("striking_vehicle"),
        "struck_vehicle": impact.get("struck_vehicle"),
        "bearing_sector": impact.get("bearing_sector"),
        "narrative": narrative,
    }
    return parsed


def extract_conflict_pack(trial_dir: Path) -> Dict[str, Any]:
    """Read conflict timing/metrics from llm_snapshots.json + action.yaml."""
    pack: Dict[str, Any] = {
        "trial_dir": str(trial_dir),
        "peak_t": None,
        "relevance_t": None,
        "brake_t": None,
        "d": None,
        "ttc": None,
        "partner": None,
        "outcome_hint": None,
        "snapshot_count": 0,
        "impact": None,
    }
    snap_dir = _resolve(trial_dir, "snapshots")
    snaps_path = (snap_dir / "llm_snapshots.json") if snap_dir is not None else None
    if snaps_path is not None and snaps_path.is_file():
        try:
            doc = json.loads(snaps_path.read_text(encoding="utf-8"))
        except Exception:
            doc = {}
        pack["peak_t"] = doc.get("peak_t")
        pack["relevance_t"] = doc.get("relevance_t")
        pack["partner"] = doc.get("partner_name")
        frames = doc.get("snapshots") or []
        pack["snapshot_count"] = len(frames)
        d_vals, ttc_vals = [], []
        collided = False
        collision_frame: Optional[Dict[str, Any]] = None
        for fr in frames:
            if not isinstance(fr, dict):
                continue
            d_v = _frame_metric(fr, "d", "d_m")
            ttc_v = _frame_metric(fr, "ttc", "ttc_s")
            if d_v is not None:
                d_vals.append(float(d_v))
            if ttc_v is not None:
                ttc_vals.append(float(ttc_v))
            label = str(fr.get("label") or "")
            if "COLLISION" in label.upper():
                collided = True
                if collision_frame is None:
                    collision_frame = fr
        if d_vals:
            pack["d"] = round(min(d_vals), 3)
        if ttc_vals:
            pack["ttc"] = round(min(ttc_vals), 3)
        pack["outcome_hint"] = "collision" if collided else "survive_or_near_miss"
        if collision_frame is not None:
            pack["impact"] = _impact_classification(collision_frame, pack["partner"])

    action_path = _resolve(trial_dir, "action.yaml")
    if action_path is not None:
        try:
            import yaml
            data = yaml.safe_load(action_path.read_text(encoding="utf-8")) or {}
        except Exception:
            data = {}
        brake_t = None
        for ag in data.get("agents") or []:
            if str(ag.get("role", "")).lower() != "ego" and int(ag.get("track_id", -1)) != 0:
                continue
            for ev in ag.get("actions") or []:
                act = str(ev.get("action") or "").upper()
                if act in ("EMERGENCY_BRAKE",) or "HARD_BRAKE" in act:
                    st = ev.get("start_time")
                    if st is not None:
                        brake_t = float(st) if brake_t is None else min(brake_t, float(st))
                elif act == "DECELERATE" and brake_t is None:
                    # Prefer emergency; fall back to first decelerate
                    st = ev.get("start_time")
                    if st is not None:
                        brake_t = float(st)
            break
        if brake_t is not None:
            pack["brake_t"] = round(brake_t, 3)
        for ix in data.get("interactions") or []:
            if not isinstance(ix, dict):
                continue
            typ = str(ix.get("type") or "").upper()
            if typ in ("NEAR_MISS", "COLLISION") or "COLLISION" in typ:
                if pack.get("ttc") is None and ix.get("min_ttc_s") is not None:
                    pack["ttc"] = float(ix["min_ttc_s"])
                if pack.get("d") is None and ix.get("min_distance_m") is not None:
                    pack["d"] = float(ix["min_distance_m"])
                if "COLLISION" in typ:
                    pack["outcome_hint"] = "collision"

    # Prefer explicit collided from a local trial meta if present
    for meta_name in ("trial_meta.json", "medoid.json"):
        mp = trial_dir / meta_name
        if mp.is_file():
            try:
                m = json.loads(mp.read_text(encoding="utf-8"))
                if m.get("collided") is not None:
                    pack["collided"] = bool(m["collided"])
            except Exception:
                pass

    return pack


def resolve_medoid_dir(cluster_dir: Path) -> Path:
    """Medoid artifacts live directly under clusterN/."""
    return cluster_dir


def find_param_boundary_trial_dir(
    run_dir: Path, src_cluster: str, tgt_cluster: str, trial_id: str,
    trial_index_map: Optional[Dict[str, Tuple[int, int]]] = None,
) -> Optional[Path]:
    """Locate Parameter-space pair side pack.

    Prefer ``parameter_space_pairs/cA-cB/c{src}_trial_<idx>/``; fall back to legacy
    ``cluster{src}/highlight_trials/param_boundary_c{tgt}/trial_<idx>/``.
    """
    import sys

    analyzer_src = Path(__file__).resolve().parents[3] / "analyzer" / "src"
    if str(analyzer_src) not in sys.path:
        sys.path.insert(0, str(analyzer_src))
    try:
        from parameter_space_pair_packs import find_parameter_space_pair_side_dir  # type: ignore

        found = find_parameter_space_pair_side_dir(
            run_dir, src_cluster, tgt_cluster, trial_id, trial_index_map
        )
        if found is not None:
            return found
    except Exception:
        pass

    cp = _cluster_paths()
    cluster_dir = run_dir / f"cluster{src_cluster}"
    base = cp.resolve_highlight_subdir(
        cluster_dir, f"param_boundary_c{tgt_cluster}", must_exist=True
    )
    if base is None:
        return None
    if trial_index_map and str(trial_id) in trial_index_map:
        _b, ti = trial_index_map[str(trial_id)]
        cand = base / f"trial_{ti}"
        if cand.is_dir():
            return cand
    subs = sorted(
        p for p in base.iterdir() if p.is_dir() and p.name.startswith("trial_")
    )
    if len(subs) == 1:
        return subs[0]
    return None


def collect_synced_parameter_space_bev_paths(
    run_dir: Path, cluster_a: Any, cluster_b: Any, max_n: int = 6
) -> List[str]:
    """Peak-aligned pair-zoom|pair-zoom JPGs under ``parameter_space_pairs/cA-cB/synced_bev/``."""
    import sys

    analyzer_src = Path(__file__).resolve().parents[3] / "analyzer" / "src"
    if str(analyzer_src) not in sys.path:
        sys.path.insert(0, str(analyzer_src))
    from parameter_space_pair_packs import pair_pack_dir  # type: ignore

    synced = pair_pack_dir(run_dir, cluster_a, cluster_b) / "synced_bev"
    if not synced.is_dir():
        return []
    files = sorted(synced.glob("t_*.jpg"))
    if not files:
        files = sorted(synced.glob("tprime_*.jpg"))
    if not files:
        files = sorted(synced.glob("*.jpg"))
    return [str(p) for p in files[: max(0, max_n)]]


def write_cluster_aggregate(cluster_dir: Path, aggregate: Dict[str, Any]) -> Path:
    cp = _cluster_paths()
    out = cp.write_path(cluster_dir, "cluster_aggregate.json")
    out.write_text(json.dumps(aggregate, indent=2), encoding="utf-8")
    # Patch cluster.json soft fields for compat
    cj = cp.resolve_path(cluster_dir, "cluster.json", must_exist=True)
    if cj is not None:
        try:
            doc = json.loads(cj.read_text(encoding="utf-8"))
            cluster = doc.setdefault("cluster", {})
            ttc = aggregate.get("ttc") or {}
            cluster["mean_ttc"] = ttc.get("mean")
            cluster["min_ttc"] = ttc.get("min")
            cluster["ttc_digest"] = ttc
            cluster["ttc_collide"] = aggregate.get("ttc_collide")
            cluster["ttc_survive"] = aggregate.get("ttc_survive")
            cluster["ic_digest"] = aggregate.get("ic")
            if aggregate.get("parameter_ranges"):
                cluster["parameter_ranges"] = aggregate["parameter_ranges"]
            if aggregate.get("collision_rate") is not None:
                cluster["collision_rate"] = aggregate["collision_rate"]
            if aggregate.get("collision_count") is not None:
                cluster["collision_count"] = aggregate["collision_count"]
            if aggregate.get("mean_spret") is not None:
                cluster["mean_spret"] = aggregate["mean_spret"]
            cj.write_text(json.dumps(doc, indent=2), encoding="utf-8")
        except Exception as exc:
            print(f"  ⚠️  Could not patch {cj}: {exc}")
    return out


def format_aggregate_for_prompt(agg: Dict[str, Any]) -> str:
    """Compact text block for cluster-summary LLM (with ODD framing)."""
    lines = [
        "Scenario family: oncoming interaction on a mapped urban/suburban road "
        "network (gpl-odd / hct_6-style) — junctions, possible parked roadside "
        "agents, NOT highway free-flow cruise.",
        "TTC in this digest = Payload polygon look-ahead KPI (mostly longitudinal). "
        "It is NOT a universal severity scale: the same seconds mean different "
        "things on highway vs urban, and lateral pass-by / near-miss can look "
        "'tight' on TTC while still being a successful yield. Prefer collision_rate "
        "and collide-vs-survive TTC split over absolute TTC myths. "
        "Do not invent MTTC / joint lateral–longitudinal scores — they are not in "
        "this digest; if severity is ambiguous, say so.",
        "",
        f"Cluster {agg.get('cluster_label')}: n_trials={agg.get('n_trials')}, "
        f"collision_rate={agg.get('collision_rate')}% "
        f"({agg.get('collision_count')}/{agg.get('n_trials')})",
    ]
    ttc = agg.get("ttc") or {}
    lines.append(
        f"TTC (all trials): n={ttc.get('n')} mean={ttc.get('mean')}s "
        f"std={ttc.get('std')} "
        f"p10/p50/p90={ttc.get('p10')}/{ttc.get('p50')}/{ttc.get('p90')}s "
        f"min={ttc.get('min')}s"
    )
    tc, ts = agg.get("ttc_collide") or {}, agg.get("ttc_survive") or {}
    if tc.get("n"):
        lines.append(
            f"TTC | collided trials: mean={tc.get('mean')}s p50={tc.get('p50')}s "
            f"n={tc.get('n')} — expected near 0s: TTC is defined at/through the "
            "contact frame, this is definitional, not a near-miss-that-failed."
        )
    if ts.get("n"):
        lines.append(
            f"TTC | survived trials: mean={ts.get('mean')}s p50={ts.get('p50')}s "
            f"n={ts.get('n')}"
        )
        at_ceiling = ts.get("at_ceiling_frac")
        if at_ceiling is not None and at_ceiling >= 0.2:
            lines.append(
                f"  ⚠ {at_ceiling * 100:.0f}% of survived trials sit at/above "
                f"the observed TTC ceiling ({ts.get('ceiling_estimate')}s) for "
                "this run — read that as 'no live conflict detected inside the "
                "KPI look-ahead window', NOT 'a "
                f"{ts.get('ceiling_estimate')}-second gap'. Do not average this "
                "ceiling value into a claim about typical conflict tightness."
            )
    if agg.get("mean_spret") is not None:
        capped = agg.get("spret_capped_frac")
        cap_note = (
            f"; {capped * 100:.0f}% of trials are at the 9.0 cap (code-applied "
            "ceiling — no scaled encroachment predicted, not a measured 9)"
            if capped is not None and capped >= 0.2
            else ""
        )
        lines.append(
            f"mean_spret={agg.get('mean_spret')} (SPrET = Scaled Predictive "
            "Encroachment Time, secondary KPI; descriptive only" + cap_note + ")"
        )
    for name, d in (agg.get("ic") or {}).items():
        unit = "m/s" if "Speed" in str(name) else ("s" if "Delay" in str(name) else "")
        u = f" {unit}" if unit else ""
        lines.append(
            f"IC {name}: mean={d.get('mean')}{u} std={d.get('std')} "
            f"p10={d.get('p10')} p90={d.get('p90')} range={d.get('range')}"
        )
    iv = agg.get("intra_variance") or {}
    if iv:
        lines.append(
            f"Embedding spread (FPC/embedding-space units, NOT meters): "
            f"mean_dist_to_medoid={iv.get('mean_dist_to_medoid')} "
            f"std={iv.get('std_dist_to_medoid')} "
            f"outlier_trial_ids={iv.get('outlier_trial_ids', [])[:3]}"
        )
    lines.append(
        "Relative reading cues for THIS batch only: collision_rate is primary; "
        "within survivors, lower p10 TTC ⇒ tighter conflicts; compare clusters "
        "to each other rather than to highway headway lore (e.g. '3 s is safe')."
    )
    return "\n".join(lines)


# ─── Stage A2: cross-cluster relative ranking (deterministic, no LLM) ──────
#
# A raw absolute number ("survivor TTC p10 = 1.95s") has no universal
# severity — the same seconds mean different things across scenario families.
# Telling the LLM that in prose is a soft constraint it can still ignore by
# falling back on generic priors. The fix computed here is structural: rank
# every cluster in THIS run against its siblings (same ODD, same scenario
# family, so the comparison is apples-to-apples by construction) and hand the
# LLM the precomputed rank sentence instead of asking it to judge magnitude.

# (metric, path-in-aggregate, ascending, label, unit) — ascending=True means
# "lower is tighter/worse" for a risk framing (TTC, SPrET-margin); collision
# rate ascending=True means "lower is safer".
_RELATIVE_METRICS: List[Tuple[str, Tuple[str, ...], bool, str, str]] = [
    ("collision_rate", ("collision_rate",), True, "collision_rate", "%"),
    (
        "ttc_survive_p10",
        ("ttc_survive", "p10"),
        True,
        "survivor TTC p10",
        "s",
    ),
    ("mean_spret", ("mean_spret",), True, "mean_spret", ""),
]


def _get_path(d: Dict[str, Any], path: Tuple[str, ...]) -> Optional[float]:
    cur: Any = d
    for key in path:
        if not isinstance(cur, dict):
            return None
        cur = cur.get(key)
    try:
        return float(cur) if cur is not None else None
    except (TypeError, ValueError):
        return None


def _rank_ascending(values: Dict[Any, float]) -> Dict[Any, int]:
    """1-based rank, ties share the same (lowest) rank."""
    ordered = sorted(set(values.values()))
    rank_of_value = {v: i + 1 for i, v in enumerate(ordered)}
    return {k: rank_of_value[v] for k, v in values.items()}


def _ordinal(n: int) -> str:
    if 10 <= n % 100 <= 20:
        suffix = "th"
    else:
        suffix = {1: "st", 2: "nd", 3: "rd"}.get(n % 10, "th")
    return f"{n}{suffix}"


def relative_cluster_digest(
    aggregates: Dict[Any, Dict[str, Any]],
) -> Dict[str, str]:
    """Per-cluster sentence ranking this run's clusters against each other.

    Pure Python / no LLM. Input is every cluster's ``cluster_aggregate.json``
    dict for the SAME run (same ODD, same scenario family), keyed by cluster
    label. Output maps ``str(cluster_label) -> sentence`` describing where
    this cluster ranks on each metric among only its siblings in this run.
    """
    labels = list(aggregates.keys())
    k = len(labels)
    if k <= 1:
        only = str(labels[0]) if labels else None
        return (
            {only: "Only one cluster in this run — no sibling to rank against."}
            if only is not None
            else {}
        )

    per_metric_values: Dict[str, Dict[Any, float]] = {}
    per_metric_ranks: Dict[str, Dict[Any, int]] = {}
    for key, path, ascending, _label, _unit in _RELATIVE_METRICS:
        vals: Dict[Any, float] = {}
        for lab in labels:
            v = _get_path(aggregates[lab], path)
            if v is not None:
                vals[lab] = v if ascending else -v
        if len(vals) < 2:
            continue
        per_metric_values[key] = {
            lab: (vals[lab] if ascending else -vals[lab]) for lab in vals
        }
        per_metric_ranks[key] = _rank_ascending(vals)

    out: Dict[str, str] = {}
    for lab in labels:
        n_here = 0
        for key, path, ascending, label, unit in _RELATIVE_METRICS:
            ranks = per_metric_ranks.get(key)
            if ranks is None or lab not in ranks:
                continue
            n_here = len(ranks)
            r = ranks[lab]
            v = per_metric_values[key][lab]
            n = len(ranks)
            tie_n = sum(1 for rr in ranks.values() if rr == r)
            tie_txt = "tied for " if tie_n > 1 else ""
            sense = "lowest" if r == 1 else ("highest" if r == n else _ordinal(r))
            qual = ""
            if key == "ttc_survive_p10":
                qual = " (tightest)" if r == 1 else (" (loosest)" if r == n else "")
            elif key == "collision_rate":
                qual = " (safest)" if r == 1 else (" (riskiest)" if r == n else "")
            u = f"{unit}" if unit else ""
            out.setdefault(str(lab), "")
            piece = (
                f"{label} ({v:.3g}{u}) is {tie_txt}{sense}{qual} of {n} "
                "clusters in this run"
            )
            out[str(lab)] = (
                piece if not out[str(lab)] else out[str(lab)] + "; " + piece
            )
        if not out.get(str(lab)):
            out[str(lab)] = (
                "No comparable metric available across siblings for this "
                "cluster yet — treat any absolute number below as "
                "descriptive only, not graded."
            )
        else:
            out[str(lab)] = (
                out[str(lab)]
                + f". Read magnitude relative to these {n_here} sibling "
                "clusters only — not against highway/urban lore or a "
                "universal seconds threshold."
            )
    return out
