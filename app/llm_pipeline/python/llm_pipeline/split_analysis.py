"""Orchestrate split analysis products: DT, aggregates, medoid, summary, IC pairs."""
from __future__ import annotations

import json
import re
from pathlib import Path
from typing import Any, Dict, List, Optional, Set, Tuple

import yaml

from .cluster_aggregates import (
    build_enriched_cluster_aggregate,
    extract_conflict_pack,
    find_param_boundary_trial_dir,
    format_aggregate_for_prompt,
    load_clip_start,
    rebase_conflict_pack,
    write_clip_time,
    write_cluster_aggregate,
)
from .cluster_interpretation_pipeline import (
    action_log_from_description,
    collect_bev_snapshot_paths,
    _dataset_for_results_dir,
)
from .cluster_interpreter import ClusterInterpreter
from .cluster_stats import cluster_label_value, trials_in_cluster_data
from .llm_factory import (
    DEFAULT_MODEL,
    api_key_env_hint,
    has_llm_credentials,
    normalize_model_name,
)
from .paths import PROMPT_TEMPLATES_DIR, REPO_ROOT


PRODUCT_ALIASES = {
    "medoid": "medoid",
    "summary": "summary",
    "ic-pairs": "ic-pairs",
    "ic_pairs": "ic-pairs",
    "pairs": "ic-pairs",
    "all": "all",
}


def parse_products(spec: Optional[str]) -> Set[str]:
    if not spec or spec.strip().lower() in ("all", ""):
        return {"medoid", "summary", "ic-pairs"}
    out: Set[str] = set()
    for part in spec.split(","):
        raw = part.strip().lower()
        # Ignore removed Decision-Tree product if callers still pass it.
        if raw in ("dt", "tree"):
            continue
        key = PRODUCT_ALIASES.get(raw)
        if key == "all":
            return {"medoid", "summary", "ic-pairs"}
        if key:
            out.add(key)
    return out or {"medoid", "summary", "ic-pairs"}


def _load_template(name: str) -> str:
    return (PROMPT_TEMPLATES_DIR / name).read_text(encoding="utf-8")


def _system_prompt() -> str:
    try:
        return _load_template("system_prompt.txt").strip()
    except Exception:
        return (
            "You are an expert AV safety analyst. Follow the task exactly. "
            "End with a single ```yaml fenced block matching the required schema."
        )


def _with_common_sense(task_prompt: str) -> str:
    """Prepend shared domain glossary (like xosc_gen common_sense)."""
    try:
        cs = _load_template("common_sense.txt").strip()
    except Exception:
        cs = ""
    if not cs:
        return task_prompt
    return f"{cs}\n\n{task_prompt}"


def _safe_replace(template: str, **values: str) -> str:
    out = template
    for k, v in values.items():
        out = out.replace("{" + k + "}", str(v))
    return out


def _strip_yaml_fence(body: str) -> str:
    body = (body or "").strip()
    if body.startswith("```"):
        m = re.search(r"```(?:ya?ml)?\s*([\s\S]*?)```", body, re.I)
        if m:
            return m.group(1).strip() + "\n"
        body = re.sub(r"^```(?:ya?ml)?\s*", "", body, flags=re.I)
        body = re.sub(r"\s*```\s*$", "", body)
    return body if body.endswith("\n") else body + "\n"


def _write_yaml_doc(path: Path, raw: Optional[str], parsed: Optional[Dict], meta: Dict) -> Dict:
    """Write YAML + sibling *_meta.json. Prefer salvaged raw over parse_failed stubs.

    Returns the final parsed dict written to meta.
    """
    path.parent.mkdir(parents=True, exist_ok=True)

    loaded: Optional[Dict] = None
    if raw and raw.strip():
        loaded = ClusterInterpreter._safe_load_yaml_dict(_strip_yaml_fence(raw))

    final: Dict[str, Any] = {}
    if isinstance(parsed, dict):
        final.update(parsed)
    if isinstance(loaded, dict):
        # Narrative / LLM fields from salvaged raw win over parse_failed stubs
        for field in (
            "motive_summary",
            "decision_timeline",
            "outcome",
            "caption",
            "consistency_note",
            "label",
            "risk_level",
            "confidence",
            "contrast_explanation",
            "hypothesis",
            "delta",
            "open_questions",
            "clusters",
            "param_names",
        ):
            if field in loaded and loaded[field] not in (None, "", "parse_failed"):
                if field == "decision_timeline" and not loaded[field]:
                    continue
                final[field] = loaded[field]
        # Fill missing keys from loaded
        for k, v in loaded.items():
            if k not in final or final.get(k) in (None, "", "parse_failed", []):
                if v not in (None, "", "parse_failed"):
                    final[k] = v

    # Authoritative deterministic injects from caller always win last
    if isinstance(parsed, dict):
        for k in (
            "conflict_metrics",
            "trial_id",
            "cluster_id",
            "param_dist",
            "numeric_digest_ref",
        ):
            if k in parsed and parsed[k] is not None:
                final[k] = parsed[k]
        for side in ("left", "right"):
            if side in parsed and isinstance(parsed[side], dict):
                base = dict(final.get(side) or {})
                base.update(parsed[side])
                final[side] = base

    body = yaml.safe_dump(final or {"empty": True}, sort_keys=False)
    path.write_text(body if body.endswith("\n") else body + "\n", encoding="utf-8")
    meta_path = (
        path.with_name(path.stem + "_meta.json")
        if path.suffix == ".yaml"
        else path.with_name(path.name + ".meta.json")
    )
    meta_doc = {"parsed": final, **meta}
    meta_path.write_text(json.dumps(meta_doc, indent=2, default=str), encoding="utf-8")
    return final


def _trial_ref(
    payload_tid: str,
    trial_dir: Optional[Path],
    index_map: Dict[str, Tuple[int, int]],
) -> Dict[str, Any]:
    """Canonical trial naming: folder ``trial_<esmini_index>`` is primary.

    Payload trial ids differ from esmini CSV indices; analysis YAML always
    leads with the same key as the on-disk folder name.
    """
    idx: Optional[int] = None
    if payload_tid in index_map:
        idx = int(index_map[payload_tid][1])
    if idx is None and trial_dir is not None:
        m = re.match(r"trial_(\d+)$", trial_dir.name)
        if m:
            idx = int(m.group(1))
    folder = f"trial_{idx}" if idx is not None else None
    return {
        # Primary id used in LLM text + YAML (matches folder basename).
        "trial": folder or f"trial_unknown({payload_tid})",
        "trial_index": idx,
        "payload_trial_id": str(payload_tid),
        # Back-compat alias (= folder name, not Payload id).
        "trial_id": folder or str(payload_tid),
    }


def _format_caption_paragraphs(text: str) -> str:
    """Break long captions into short paragraphs for readable YAML."""
    raw = (text or "").strip()
    if not raw:
        return ""
    # Already multi-paragraph
    if "\n\n" in raw:
        return raw
    # Split on sentence end + space
    parts = re.split(r"(?<=[.!?])\s+", raw)
    paras: List[str] = []
    buf: List[str] = []
    for s in parts:
        s = s.strip()
        if not s:
            continue
        buf.append(s)
        if len(buf) >= 2 or len(" ".join(buf)) > 180:
            paras.append(" ".join(buf))
            buf = []
    if buf:
        paras.append(" ".join(buf))
    return "\n\n".join(paras)


def _load_payload_context(batch_id: int) -> Tuple[
    Optional[Dict[str, Any]],
    Optional[Dict[str, Any]],
    Optional[Dict[str, bool]],
    List[Dict],
]:
    """Return assignments, trials_meta, collision_flags, scenario_parameters."""
    from .analyzer_bridge import ensure_analyzer_src
    ensure_analyzer_src()
    try:
        from dataset_builder import (
            _collision_flags_from_ego,
            _fetch_payload_analysis,
        )
    except Exception as exc:
        print(f"  ⚠️  Payload imports failed: {exc}")
        return None, None, None, []

    fetched = _fetch_payload_analysis(batch_id=batch_id)
    if not fetched:
        return None, None, None, []
    scores, clustering_list, ego_data, _sel = fetched
    # Prefer clustering JSON already on disk when interpreting a fixed run —
    # caller passes assignments separately. Here we still need trials.
    trials = ego_data.get("trials") or {}
    flags = _collision_flags_from_ego(ego_data)
    scenario_params = list(
        (ego_data.get("scenario") or {}).get("parameters")
        or ego_data.get("parameters")
        or []
    )
    return None, trials, flags, scenario_params


def _assignments_from_run(run_dir: Path) -> Optional[Dict[str, Any]]:
    p = run_dir / "clustering" / "selectedClusteringResult.json"
    if not p.is_file():
        return None
    try:
        doc = json.loads(p.read_text(encoding="utf-8"))
        return doc.get("data") or doc
    except Exception:
        return None


def _trial_index_map_from_trials(trials: Dict[str, Any]) -> Dict[str, Tuple[int, int]]:
    pat = re.compile(r"esmini_(\d+)_(\d+)\.dat")
    out: Dict[str, Tuple[int, int]] = {}
    for tid, t in (trials or {}).items():
        if not isinstance(t, dict):
            continue
        edat = t.get("esminiDat")
        if not isinstance(edat, dict):
            continue
        m = pat.match(str(edat.get("filename", "")))
        if m:
            out[str(tid)] = (int(m.group(1)), int(m.group(2)))
    return out


def _params_for_trial(
    tid: str,
    trials: Dict[str, Any],
    scenario_parameters: List[Dict],
) -> Dict[str, float]:
    param_id_to_name: Dict[str, str] = {}
    for p in scenario_parameters or []:
        if not isinstance(p, dict):
            continue
        pid = p.get("id") or p.get("parameterId")
        if pid is not None:
            param_id_to_name[str(pid)] = p.get("name") or str(pid)
    t = trials.get(str(tid)) or trials.get(tid) or {}
    out: Dict[str, float] = {}
    for tp in (t.get("parameters") or []) if isinstance(t, dict) else []:
        if not isinstance(tp, dict):
            continue
        pid = str(tp.get("parameterId", tp.get("id", "")))
        name = param_id_to_name.get(pid) or tp.get("name") or pid
        try:
            out[str(name)] = float(tp.get("value", 0))
        except (TypeError, ValueError):
            continue
    return out


def _outcome_from_pack_and_flags(
    tid: str, pack: Dict[str, Any], flags: Optional[Dict[str, bool]]
) -> str:
    if flags and str(tid) in flags:
        return "collision" if flags[str(tid)] else "safe"
    hint = str(pack.get("outcome_hint") or "")
    if "collision" in hint:
        return "collision"
    if pack.get("collided"):
        return "collision"
    return "safe"


def write_legacy_shim(
    cluster_dir: Path,
    cluster_id: int,
    summary: Optional[Dict[str, Any]],
    medoid: Optional[Dict[str, Any]],
    aggregate: Optional[Dict[str, Any]],
) -> Path:
    """Thin pointer YAML for older Explore clients.

    Does **not** copy the medoid decision timeline (that lives only in
    ``medoid_trial.yaml``). Caption/label/risk come from ``cluster_summary``.
    Explore Replayer should prefer ``medoid_trial`` / status API, which reads
    the timeline from the medoid file.
    """
    label = (summary or {}).get("label") or f"Cluster {cluster_id}"
    risk = (summary or {}).get("risk_level") or "medium"
    conf = (summary or {}).get("confidence") or "medium"
    caption = (summary or {}).get("caption") or ""
    rate = (aggregate or {}).get("collision_rate")
    medoid_tid = (medoid or {}).get("trial_id")
    doc = {
        "cluster_id": cluster_id,
        "cluster_label": label,
        "confidence": conf,
        "behavior_description": caption,
        "safety_assessment": {
            "risk_level": risk,
            "failure_mode": (summary or {}).get("consistency_note") or "",
            "collision_rate": f"{rate}%" if rate is not None else "n/a",
        },
        "canonical_artifacts": {
            "cluster_summary": "cluster_summary.yaml",
            "medoid_trial": "medoid_trial.yaml",
            "medoid_trial_id": medoid_tid,
            "note": (
                "Cluster narrative = cluster_summary.yaml; "
                "trial motive timeline = medoid_trial.yaml (not duplicated here)."
            ),
        },
        "parameter_conditions": {
            "trigger": "See cluster_summary.yaml + cluster_aggregate.json",
            "safe_range": "See IC digests in cluster_aggregate.json (descriptive only)",
            "risky_boundary": "Not modeled yet",
        },
    }
    path = cluster_dir / "cluster_interpretation.yaml"
    path.write_text(yaml.safe_dump(doc, sort_keys=False), encoding="utf-8")
    meta = {
        "cluster_id": cluster_id,
        "cluster_label": label,
        "confidence": conf,
        "behavior_description": caption,
        "safety_assessment": doc["safety_assessment"],
        "parameter_conditions": doc["parameter_conditions"],
        "canonical_artifacts": doc["canonical_artifacts"],
        "split_analysis_shim": True,
    }
    (cluster_dir / "interpretation_meta.json").write_text(
        json.dumps(meta, indent=2, default=str), encoding="utf-8"
    )
    return path


def run_split_analysis(
    results_dir: Path,
    *,
    batch_id: Optional[int] = None,
    dataset: Optional[str] = None,
    model: str = DEFAULT_MODEL,
    api_key: Optional[str] = None,
    products: Optional[str] = None,
    clusters: Optional[List[int]] = None,
    dry_run: bool = False,
    temperature: float = 0.1,
    max_llm_snapshots: Optional[int] = 8,
) -> Dict[str, Any]:
    """Run selected products on a builder results dir."""
    results_dir = Path(results_dir)
    prods = parse_products(products)
    model = normalize_model_name(model)
    ds = _dataset_for_results_dir(results_dir, dataset, batch_id)
    print(f"[split-analysis] dir={results_dir} products={sorted(prods)} model={model}")

    assignments = _assignments_from_run(results_dir) or {}
    # Resolve batch id
    bid = batch_id
    if bid is None:
        m = re.search(r"batch(\d+)", str(results_dir))
        if m:
            bid = int(m.group(1))
    trials: Dict[str, Any] = {}
    flags: Dict[str, bool] = {}
    scenario_params: List[Dict] = []
    if bid is not None:
        _asg, trials_m, flags_m, scenario_params = _load_payload_context(bid)
        trials = trials_m or {}
        flags = flags_m or {}

    # Fallback collision flags from cluster.json medoids only — incomplete
    index_map = _trial_index_map_from_trials(trials)

    cluster_dirs = sorted(
        d for d in results_dir.glob("cluster*")
        if d.is_dir() and d.name[len("cluster"):].isdigit()
    )
    need_llm = bool(prods & {"medoid", "summary", "ic-pairs"}) and not dry_run
    interpreter = None
    if need_llm:
        if not has_llm_credentials(model, api_key):
            print(f"  ⚠️  {api_key_env_hint(model)} missing — forcing dry_run stubs")
            dry_run = True
        else:
            interpreter = ClusterInterpreter(
                model=model, api_key=api_key, temperature=temperature, do_review=False
            )

    outputs: Dict[str, Any] = {"clusters": {}, "ic_pairs": []}

    medoid_tpl = _load_template("medoid_trial_prompt.txt")
    summary_tpl = _load_template("cluster_summary_prompt.txt")
    pair_tpl = _load_template("ic_pair_prompt.txt")

    for cluster_dir in cluster_dirs:
        cid = int(cluster_dir.name[len("cluster"):])
        if clusters is not None and cid not in clusters:
            continue
        print(f"\n[split-analysis] cluster{cid}")
        cj = {}
        if (cluster_dir / "cluster.json").is_file():
            cj = json.loads((cluster_dir / "cluster.json").read_text(encoding="utf-8"))
        cblk = cj.get("cluster") or {}
        mblk = cj.get("medoid") or {}
        medoid_tid = str(mblk.get("trial_id") or "")
        iv = cblk.get("intra_variance") or {}

        trial_ids = trials_in_cluster_data(assignments, cid) if assignments else []
        aggregate = build_enriched_cluster_aggregate(
            cid,
            trial_ids or [medoid_tid] if medoid_tid else [],
            trials,
            scenario_params,
            flags,
            intra_variance=iv,
        )
        # Prefer on-disk collision stats if Payload missing
        if not trial_ids and cblk.get("collision_rate") is not None:
            aggregate["collision_rate"] = cblk.get("collision_rate")
            aggregate["collision_count"] = cblk.get("collision_count")
            aggregate["n_trials"] = cblk.get("n_trials") or cblk.get("size")
            if cblk.get("parameter_ranges"):
                aggregate["parameter_ranges"] = cblk["parameter_ranges"]
        write_cluster_aggregate(cluster_dir, aggregate)

        cluster_out: Dict[str, Any] = {"aggregate": str(cluster_dir / "cluster_aggregate.json")}
        summary_parsed = None
        medoid_parsed = None

        # --- medoid ---
        if "medoid" in prods:
            pack = extract_conflict_pack(cluster_dir)
            pack["trial_id"] = medoid_tid
            pack["collided"] = mblk.get("collided")
            # Align LLM / Replayer / Heatmap: rebase absolute esmini times onto
            # the Payload observation clip (StartValidCondition → t=0).
            clip_start = load_clip_start(cluster_dir, medoid_tid)
            if clip_start is not None:
                write_clip_time(
                    cluster_dir, clip_start, trial_id=medoid_tid
                )
                pack = rebase_conflict_pack(pack, clip_start)
                print(
                    f"  clip_start_esmini_s={clip_start:.3f} "
                    f"(medoid times rebased to Payload clock)"
                )
            else:
                print(
                    "  ⚠️  No Payload clip_start; medoid times stay absolute esmini"
                )
            ctx = action_log_from_description(cluster_dir)
            # Truncate travelogue-heavy context for LLM
            if len(ctx) > 6000:
                ctx = ctx[:6000] + "\n…[truncated]"
            prompt = _with_common_sense(
                _safe_replace(
                    medoid_tpl,
                    conflict_metrics=json.dumps(pack, indent=2),
                    trial_context=ctx or "(no description)",
                )
            )
            bev = collect_bev_snapshot_paths(
                cluster_dir, max_llm_snapshots=max_llm_snapshots
            )
            out_path = cluster_dir / "medoid_trial.yaml"
            if dry_run or interpreter is None:
                stub = {
                    "trial_id": medoid_tid,
                    "outcome": "collision" if mblk.get("collided") else "safe",
                    "conflict_metrics": pack,
                    "motive_summary": "stub (dry_run)",
                    "decision_timeline": [],
                    "open_questions": [],
                    "stub": True,
                }
                if clip_start is not None:
                    stub["clip_start_esmini_s"] = round(float(clip_start), 3)
                    stub["time_origin"] = "payload_observation_clip"
                _write_yaml_doc(out_path, None, stub, {"stub": True})
                medoid_parsed = stub
            else:
                raw, tokens, parsed = interpreter.complete_yaml_prompt(
                    prompt,
                    system_prompt=_system_prompt(),
                    bev_snapshot_paths=bev,
                    section_title="Medoid BEV",
                )
                if parsed is None:
                    parsed = {
                        "trial_id": medoid_tid,
                        "outcome": "collision" if mblk.get("collided") else "safe",
                        "conflict_metrics": pack,
                        "motive_summary": "parse_failed",
                        "decision_timeline": [],
                    }
                # Inject authoritative (already-rebased) metrics. Timeline should
                # already use the same Payload clock because the prompt pack was
                # rebased before the LLM call.
                parsed["conflict_metrics"] = pack
                parsed["trial_id"] = parsed.get("trial_id") or medoid_tid
                if clip_start is not None:
                    parsed["clip_start_esmini_s"] = round(float(clip_start), 3)
                    parsed["time_origin"] = "payload_observation_clip"
                medoid_parsed = _write_yaml_doc(
                    out_path, raw, parsed, {"token_usage": tokens}
                )
            cluster_out["medoid_trial"] = str(out_path)
            print(f"  ✓ {out_path.name}")

        # --- summary ---
        if "summary" in prods:
            digest = format_aggregate_for_prompt(aggregate)
            prompt = _with_common_sense(
                _safe_replace(summary_tpl, numeric_digest=digest)
            )
            out_path = cluster_dir / "cluster_summary.yaml"
            if dry_run or interpreter is None:
                stub = {
                    "cluster_id": cid,
                    "label": f"Cluster {cid}",
                    "risk_level": "high" if (aggregate.get("collision_rate") or 0) > 50 else "low",
                    "confidence": "medium",
                    "numeric_digest_ref": True,
                    "caption": "stub (dry_run)",
                    "consistency_note": "",
                    "stub": True,
                }
                _write_yaml_doc(out_path, None, stub, {"stub": True})
                summary_parsed = stub
            else:
                raw, tokens, parsed = interpreter.complete_yaml_prompt(
                    prompt,
                    system_prompt=_system_prompt(),
                    bev_snapshot_paths=None,
                    section_title="",
                )
                if parsed is None:
                    parsed = {
                        "cluster_id": cid,
                        "label": f"Cluster {cid}",
                        "risk_level": "medium",
                        "caption": "parse_failed",
                    }
                parsed["cluster_id"] = cid
                parsed["numeric_digest_ref"] = True
                if isinstance(parsed.get("caption"), str):
                    parsed["caption"] = _format_caption_paragraphs(parsed["caption"])
                if isinstance(parsed.get("consistency_note"), str):
                    parsed["consistency_note"] = _format_caption_paragraphs(
                        parsed["consistency_note"]
                    )
                summary_parsed = _write_yaml_doc(
                    out_path, raw, parsed, {"token_usage": tokens}
                )
            cluster_out["cluster_summary"] = str(out_path)
            print(f"  ✓ {out_path.name}")

        # Legacy shim when we produced either card
        if summary_parsed is not None or medoid_parsed is not None:
            write_legacy_shim(
                cluster_dir, cid, summary_parsed, medoid_parsed, aggregate
            )
            cluster_out["legacy_shim"] = str(cluster_dir / "cluster_interpretation.yaml")

        outputs["clusters"][str(cid)] = cluster_out

    # --- IC pairs ---
    if "ic-pairs" in prods:
        print("\n[split-analysis] IC closest pairs…")
        manifest = {}
        mp = results_dir / "manifest.json"
        if mp.is_file():
            manifest = json.loads(mp.read_text(encoding="utf-8"))
        pairs = manifest.get("param_boundary_pairs") or []
        pair_dir = results_dir / "ic_pairs"
        pair_dir.mkdir(exist_ok=True)
        for bp in pairs:
            ca, cb = str(bp["cluster_a"]), str(bp["cluster_b"])
            if clusters is not None and (
                int(ca) not in clusters and int(cb) not in clusters
            ):
                continue
            ta, tb = str(bp["trial_a"]), str(bp["trial_b"])
            left_dir = find_param_boundary_trial_dir(
                results_dir, ca, cb, ta, index_map
            )
            right_dir = find_param_boundary_trial_dir(
                results_dir, cb, ca, tb, index_map
            )
            # Prefer exact index folders
            if index_map.get(ta):
                _b, ti = index_map[ta]
                cand = results_dir / f"cluster{ca}" / f"param_boundary_c{cb}" / f"trial_{ti}"
                if cand.is_dir():
                    left_dir = cand
            if index_map.get(tb):
                _b, ti = index_map[tb]
                cand = results_dir / f"cluster{cb}" / f"param_boundary_c{ca}" / f"trial_{ti}"
                if cand.is_dir():
                    right_dir = cand

            left_pack = extract_conflict_pack(left_dir) if left_dir else {}
            right_pack = extract_conflict_pack(right_dir) if right_dir else {}
            left_ref = _trial_ref(ta, left_dir, index_map)
            right_ref = _trial_ref(tb, right_dir, index_map)
            # Prefer short trial_dir for YAML (relative-ish basename path)
            if left_dir:
                try:
                    left_pack = {
                        **left_pack,
                        "trial_dir": str(left_dir.relative_to(REPO_ROOT)),
                    }
                except ValueError:
                    left_pack = {**left_pack, "trial_dir": str(left_dir)}
            if right_dir:
                try:
                    right_pack = {
                        **right_pack,
                        "trial_dir": str(right_dir.relative_to(REPO_ROOT)),
                    }
                except ValueError:
                    right_pack = {**right_pack, "trial_dir": str(right_dir)}
            left_params = _params_for_trial(ta, trials, scenario_params)
            right_params = _params_for_trial(tb, trials, scenario_params)
            left_out = _outcome_from_pack_and_flags(ta, left_pack, flags)
            right_out = _outcome_from_pack_and_flags(tb, right_pack, flags)
            # Prefer flag from bp
            if bp.get("collided_a") is not None:
                left_out = "collision" if bp["collided_a"] else "safe"
            if bp.get("collided_b") is not None:
                right_out = "collision" if bp["collided_b"] else "safe"

            pair_facts = (
                f"clusters {ca}↔{cb} param_dist={bp.get('param_dist')} "
                f"names={bp.get('param_names')}\n"
                f"{left_ref['trial']} (payload {ta}) outcome={left_out} "
                f"params={left_params}\n"
                f"{right_ref['trial']} (payload {tb}) outcome={right_out} "
                f"params={right_params}\n"
                f"Cite trials as {left_ref['trial']} / {right_ref['trial']} "
                f"(folder names), not bare Payload ids."
            )
            left_block = json.dumps({
                **left_ref,
                "cluster": int(ca),
                "outcome": left_out,
                "params": left_params,
                "conflict_metrics": left_pack,
            }, indent=2)
            right_block = json.dumps({
                **right_ref,
                "cluster": int(cb),
                "outcome": right_out,
                "params": right_params,
                "conflict_metrics": right_pack,
            }, indent=2)
            prompt = _with_common_sense(
                _safe_replace(
                    pair_tpl,
                    pair_facts=pair_facts,
                    left_block=left_block,
                    right_block=right_block,
                )
            )
            bev: List[str] = []
            for d in (left_dir, right_dir):
                if d:
                    bev.extend(
                        collect_bev_snapshot_paths(d, max_llm_snapshots=4)
                    )
            out_path = pair_dir / f"pair_c{ca}_c{cb}.yaml"
            if dry_run or interpreter is None:
                stub = {
                    "clusters": [int(ca), int(cb)],
                    "param_dist": bp.get("param_dist"),
                    "param_names": bp.get("param_names"),
                    "left": {**left_ref, "cluster": int(ca), "outcome": left_out,
                             "params": left_params, "conflict_metrics": left_pack},
                    "right": {**right_ref, "cluster": int(cb), "outcome": right_out,
                              "params": right_params, "conflict_metrics": right_pack},
                    "delta": {},
                    "contrast_explanation": "stub (dry_run)",
                    "hypothesis": "",
                    "stub": True,
                }
                _write_yaml_doc(out_path, None, stub, {"stub": True})
            else:
                raw, tokens, parsed = interpreter.complete_yaml_prompt(
                    prompt,
                    system_prompt=_system_prompt(),
                    bev_snapshot_paths=bev[:10],
                    section_title="IC pair BEV (left then right)",
                )
                if parsed is None:
                    parsed = {
                        "clusters": [int(ca), int(cb)],
                        "param_dist": bp.get("param_dist"),
                        "contrast_explanation": "parse_failed",
                    }
                parsed.setdefault("left", {})
                parsed.setdefault("right", {})
                # Authoritative naming + metrics (overwrite LLM trial_id confusion)
                parsed["left"] = {**left_ref, **(parsed.get("left") or {})}
                parsed["right"] = {**right_ref, **(parsed.get("right") or {})}
                parsed["left"].update(left_ref)
                parsed["right"].update(right_ref)
                parsed["left"]["params"] = left_params
                parsed["right"]["params"] = right_params
                parsed["left"]["conflict_metrics"] = left_pack
                parsed["right"]["conflict_metrics"] = right_pack
                parsed["left"]["cluster"] = int(ca)
                parsed["right"]["cluster"] = int(cb)
                parsed["left"]["outcome"] = left_out
                parsed["right"]["outcome"] = right_out
                parsed["param_dist"] = bp.get("param_dist")
                if isinstance(parsed.get("contrast_explanation"), str):
                    parsed["contrast_explanation"] = _format_caption_paragraphs(
                        parsed["contrast_explanation"]
                    )
                if isinstance(parsed.get("hypothesis"), str):
                    parsed["hypothesis"] = _format_caption_paragraphs(
                        parsed["hypothesis"]
                    )
                _write_yaml_doc(out_path, raw, parsed, {"token_usage": tokens})
            outputs["ic_pairs"].append(str(out_path))
            print(f"  ✓ {out_path.name}")

    summary_path = results_dir / "split_analysis_summary.json"
    summary_path.write_text(json.dumps(outputs, indent=2), encoding="utf-8")
    print(f"\n[split-analysis] done → {summary_path}")
    return outputs
