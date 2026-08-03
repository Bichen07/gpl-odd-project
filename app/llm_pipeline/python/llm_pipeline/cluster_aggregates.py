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
    """Offline estimate of Payload clip start from medoid esmini CSV.

    Approximates ``StartValidCondition`` (ReachPosition to first Ego frame on
    road 92 near s=0, tolerance 3 m) then adds one observation frame (0.1 s) to
    match Payload's first kept ``esminiSeconds``.
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

    # Prefer analyzer helper when importable.
    try:
        from csv_roadid_loader import get_csv_road_data  # type: ignore

        df = get_csv_road_data(batch_id, trial_index)
        if df is None or df.empty:
            return None
        ego = df[df["name"].astype(str).str.lower() == "ego"].sort_values("time")
        if ego.empty:
            return None
        tgt_rows = ego[(ego["roadId"] == 92) & (ego["s"].abs() <= 3.0)]
        if tgt_rows.empty:
            return None
        tgt = tgt_rows.iloc[0]
        dx = ego["x"].astype(float) - float(tgt["x"])
        dy = ego["y"].astype(float) - float(tgt["y"])
        dist = (dx * dx + dy * dy) ** 0.5
        hit = ego[dist <= 3.0]
        if hit.empty:
            return None
        # Payload first obs ≈ condition fire + one 0.1 s sample tick.
        return round(float(hit.iloc[0]["time"]) + 0.1, 3)
    except Exception:
        return None


def load_clip_start(trial_dir: Path, trial_id: Optional[str] = None) -> Optional[float]:
    """Load clip start from ``clip_time.json``, Payload, or esmini CSV estimate."""
    clip_path = Path(trial_dir) / "clip_time.json"
    if clip_path.is_file():
        try:
            data = json.loads(clip_path.read_text(encoding="utf-8"))
            if data.get("clip_start_esmini_s") is not None:
                return float(data["clip_start_esmini_s"])
        except Exception:
            pass

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

    return estimate_clip_start_from_cluster_json(Path(trial_dir))


def write_clip_time(
    trial_dir: Path,
    clip_start: float,
    *,
    trial_id: Optional[str] = None,
    source: str = "payload_first_observation",
) -> Path:
    """Persist clip metadata next to medoid artifacts."""
    path = Path(trial_dir) / "clip_time.json"
    doc = {
        "clip_start_esmini_s": round(float(clip_start), 3),
        "time_origin": "payload_observation_clip",
        "source": source,
        "note": (
            "t=0 for Replayer/Heatmap/medoid_trial matches first Payload "
            "observation (StartValidCondition / startObservationSamplingConditions)."
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


def _ttc_digest(vals: List[float]) -> Dict[str, Any]:
    if not vals:
        return {"n": 0, "mean": None, "std": None, "min": None,
                "p10": None, "p50": None, "p90": None}
    arr = np.asarray(vals, dtype=float)
    return {
        "n": int(len(arr)),
        "mean": round(float(arr.mean()), 3),
        "std": round(float(arr.std()), 3),
        "min": round(float(arr.min()), 3),
        "p10": _percentile(vals, 10),
        "p50": _percentile(vals, 50),
        "p90": _percentile(vals, 90),
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
        "ic": ic,
        "parameter_ranges": parameter_ranges,
        "intra_variance": intra_variance or {},
    }


def extract_conflict_pack(trial_dir: Path) -> Dict[str, Any]:
    """Read conflict timing/metrics from llm_snapshots.json + action.yaml."""
    pack: Dict[str, Any] = {
        "trial_dir": str(trial_dir),
        "peak_t": None,
        "relevance_t": None,
        "brake_t": None,
        "d_min": None,
        "ttc_min": None,
        "partner": None,
        "outcome_hint": None,
        "snapshot_count": 0,
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
        for fr in frames:
            if not isinstance(fr, dict):
                continue
            if fr.get("d_m") is not None:
                d_vals.append(float(fr["d_m"]))
            if fr.get("ttc_s") is not None:
                ttc_vals.append(float(fr["ttc_s"]))
            label = str(fr.get("label") or "")
            if "COLLISION" in label.upper():
                collided = True
        if d_vals:
            pack["d_min"] = round(min(d_vals), 3)
        if ttc_vals:
            pack["ttc_min"] = round(min(ttc_vals), 3)
        pack["outcome_hint"] = "collision" if collided else "survive_or_near_miss"

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
                if pack.get("ttc_min") is None and ix.get("min_ttc_s") is not None:
                    pack["ttc_min"] = float(ix["min_ttc_s"])
                if pack.get("d_min") is None and ix.get("min_distance_m") is not None:
                    pack["d_min"] = float(ix["min_distance_m"])
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
    """Locate IC-pair side pack.

    Prefer ``ic_pairs/cA-cB/c{src}_trial_<idx>/``; fall back to legacy
    ``cluster{src}/highlight_trials/param_boundary_c{tgt}/trial_<idx>/``.
    """
    import sys

    analyzer_src = Path(__file__).resolve().parents[3] / "analyzer" / "src"
    if str(analyzer_src) not in sys.path:
        sys.path.insert(0, str(analyzer_src))
    try:
        from ic_pair_packs import find_ic_pair_side_dir  # type: ignore

        found = find_ic_pair_side_dir(
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


def collect_synced_ic_bev_paths(
    run_dir: Path, cluster_a: Any, cluster_b: Any, max_n: int = 6
) -> List[str]:
    """Peak-aligned pair-zoom|pair-zoom JPGs under ``ic_pairs/cA-cB/synced_bev/``."""
    import sys

    analyzer_src = Path(__file__).resolve().parents[3] / "analyzer" / "src"
    if str(analyzer_src) not in sys.path:
        sys.path.insert(0, str(analyzer_src))
    from ic_pair_packs import pair_pack_dir  # type: ignore

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
            f"n={tc.get('n')}"
        )
    if ts.get("n"):
        lines.append(
            f"TTC | survived trials: mean={ts.get('mean')}s p50={ts.get('p50')}s "
            f"n={ts.get('n')}"
        )
    if agg.get("mean_spret") is not None:
        lines.append(
            f"mean_spret={agg.get('mean_spret')} (secondary KPI; treat as descriptive)"
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
            f"Embedding spread: mean_dist_to_medoid={iv.get('mean_dist_to_medoid')} "
            f"std={iv.get('std_dist_to_medoid')} "
            f"outlier_trial_ids={iv.get('outlier_trial_ids', [])[:3]}"
        )
    lines.append(
        "Relative reading cues for THIS batch only: collision_rate is primary; "
        "within survivors, lower p10 TTC ⇒ tighter conflicts; compare clusters "
        "to each other rather than to highway headway lore (e.g. '3 s is safe')."
    )
    return "\n".join(lines)
