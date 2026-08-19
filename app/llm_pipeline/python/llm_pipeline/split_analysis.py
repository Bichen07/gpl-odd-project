"""Orchestrate split analysis products: DT, aggregates, medoid, summary, Parameter-space pairs."""
from __future__ import annotations

import json
import re
from pathlib import Path
from typing import Any, Dict, List, Optional, Set, Tuple

import yaml

from .cluster_aggregates import (
    apply_collision_detail,
    build_enriched_cluster_aggregate,
    collect_synced_parameter_space_bev_paths,
    extract_conflict_pack,
    find_param_boundary_trial_dir,
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


def _cp():
    """Analyzer cluster_paths (nested write / nested-then-flat read)."""
    import sys

    analyzer_src = Path(__file__).resolve().parents[3] / "analyzer" / "src"
    if str(analyzer_src) not in sys.path:
        sys.path.insert(0, str(analyzer_src))
    import cluster_paths as cp  # type: ignore

    return cp


def resolve_parameter_space_contrast_path(pack_dir: Path) -> Optional[Path]:
    """Prefer ``output/contrast.yaml``; fall back to legacy pack-root file."""
    pack_dir = Path(pack_dir)
    nested = pack_dir / "output" / "contrast.yaml"
    if nested.is_file():
        return nested
    legacy = pack_dir / "contrast.yaml"
    if legacy.is_file():
        return legacy
    return None


def touching_parameter_space_pair_folders(results_dir: Path, cluster_id: Any) -> List[Path]:
    """Parameter-space pair pack dirs under ``parameter_space_pairs/`` that include ``cluster_id``."""
    import re
    import sys

    cid = int(cluster_id)
    analyzer_src = Path(__file__).resolve().parents[3] / "analyzer" / "src"
    if str(analyzer_src) not in sys.path:
        sys.path.insert(0, str(analyzer_src))
    try:
        from parameter_space_pair_packs import parameter_space_pairs_root  # type: ignore

        root = parameter_space_pairs_root(Path(results_dir))
    except Exception:
        root = Path(results_dir) / "parameter_space_pairs"
        if not root.is_dir():
            root = Path(results_dir) / "ic_pairs"
    if not root.is_dir():
        return []
    out: List[Path] = []
    for p in sorted(root.glob("c*-c*")):
        if not p.is_dir():
            continue
        m = re.match(r"^c(\d+)-c(\d+)$", p.name)
        if not m:
            continue
        if cid in (int(m.group(1)), int(m.group(2))):
            out.append(p)
    return out


def missing_parameter_space_contrasts_for_cluster(results_dir: Path, cluster_id: Any) -> List[str]:
    """Pack folder names that touch this cluster but lack ``output/contrast.yaml``."""
    missing: List[str] = []
    for pack in touching_parameter_space_pair_folders(results_dir, cluster_id):
        if resolve_parameter_space_contrast_path(pack) is None:
            missing.append(pack.name)
    return missing


def medoid_trial_path(results_dir: Path, cluster_id: Any) -> Optional[Path]:
    """Path to ``clusterN/output/medoid_trial.yaml`` if it exists."""
    cdir = Path(results_dir) / f"cluster{int(cluster_id)}"
    path = _cp().resolve_path(cdir, "medoid_trial.yaml", must_exist=True)
    return path if path is not None and path.is_file() else None


def _pair_folder_set(pairs: Optional[List[str]]) -> Optional[Set[str]]:
    if not pairs:
        return None
    out: Set[str] = set()
    for p in pairs:
        name = str(p).strip()
        if not name:
            continue
        if name.endswith(".yaml"):
            name = name[: -len(".yaml")]
        if "/" in name:
            name = name.rstrip("/").split("/")[-1]
        out.add(name)
    return out or None

PRODUCT_ALIASES = {
    "medoid": "medoid",
    "summary": "summary",
    "parameter-space-pairs": "parameter-space-pairs",
    "parameter_space_pairs": "parameter-space-pairs",
    "pairs": "parameter-space-pairs",
    # Legacy aliases (pre-rename: ic_pairs / IC closest pairs)
    "ic-pairs": "parameter-space-pairs",
    "ic_pairs": "parameter-space-pairs",
    "cross-eval": "cross-eval",
    "cross_eval": "cross-eval",
    "selection": "cross-eval",
    "all": "all",
}

_ALL_PRODUCTS = {"medoid", "summary", "parameter-space-pairs", "cross-eval"}

# Default: medoid trial narrative only. Summary / Parameter-space pairs are opt-in.
DEFAULT_PRODUCTS = frozenset({"medoid"})


def parse_products(spec: Optional[str]) -> Set[str]:
    if not spec or not str(spec).strip():
        return set(DEFAULT_PRODUCTS)
    if str(spec).strip().lower() == "all":
        return set(_ALL_PRODUCTS)
    out: Set[str] = set()
    for part in spec.split(","):
        raw = part.strip().lower()
        # Ignore removed products if callers still pass them.
        if raw in ("dt", "tree", "legacy"):
            continue
        key = PRODUCT_ALIASES.get(raw)
        if key == "all":
            return set(_ALL_PRODUCTS)
        if key:
            out.add(key)
    return out or set(DEFAULT_PRODUCTS)



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
    """Write a single YAML artifact (no sibling *_meta.json).

    Optional pipeline fields (token usage, stubs) go under ``llm_meta``.
    Prefer salvaged raw over parse_failed stubs. Returns the final document.
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
            "primary_motive",
            "secondary_motives",
            "interaction_resolution",
            "control_response",
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
        # Fill missing keys from loaded (skip pipeline-only keys)
        for k, v in loaded.items():
            if k == "llm_meta":
                continue
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
        # collision_detail is deterministic (cluster_aggregates.apply_collision_detail
        # already ran before this call). If the caller omitted it (non-collision
        # trial), drop any hallucinated value salvaged from the raw LLM YAML instead
        # of letting it leak through the "fill missing keys from loaded" pass above.
        if "collision_detail" not in parsed:
            final.pop("collision_detail", None)

    llm_meta: Dict[str, Any] = {}
    if isinstance(meta, dict):
        for k, v in meta.items():
            if v is not None:
                llm_meta[k] = v
    if llm_meta:
        final["llm_meta"] = llm_meta

    body = yaml.safe_dump(final or {"empty": True}, sort_keys=False)
    path.write_text(body if body.endswith("\n") else body + "\n", encoding="utf-8")
    # Drop obsolete sidecar if a prior run left one behind.
    meta_path = (
        path.with_name(path.stem + "_meta.json")
        if path.suffix == ".yaml"
        else path.with_name(path.name + ".meta.json")
    )
    if meta_path.is_file():
        try:
            meta_path.unlink()
        except OSError:
            pass
    return final


def _trial_ref(
    payload_tid: str,
    trial_dir: Optional[Path],
    index_map: Dict[str, Tuple[int, int]],
    *,
    trial_index: Optional[int] = None,
) -> Dict[str, Any]:
    """Canonical trial naming: ``trial_<esmini_index>`` is primary.

    Payload trial ids differ from esmini CSV indices; analysis YAML always
    leads with the folder index. Resolution order:
    1. explicit ``trial_index`` (e.g. from pair.json)
    2. Payload ``index_map``
    3. folder name ``cN_trial_<idx>`` or legacy ``trial_<idx>``
    """
    idx: Optional[int] = int(trial_index) if trial_index is not None else None
    if idx is None and payload_tid in index_map:
        idx = int(index_map[payload_tid][1])
    if idx is None and trial_dir is not None:
        m = re.match(r"(?:c\d+_)?trial_(\d+)$", trial_dir.name)
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


def run_split_analysis(
    results_dir: Path,
    *,
    batch_id: Optional[int] = None,
    dataset: Optional[str] = None,
    model: str = DEFAULT_MODEL,
    api_key: Optional[str] = None,
    products: Optional[str] = None,
    clusters: Optional[List[int]] = None,
    pairs: Optional[List[str]] = None,
    dry_run: bool = False,
    temperature: float = 0.1,
    max_llm_snapshots: Optional[int] = 8,
) -> Dict[str, Any]:
    """Run selected products on a builder results dir."""
    results_dir = Path(results_dir)
    prods = parse_products(products)
    pair_filter = _pair_folder_set(pairs)
    model = normalize_model_name(model)
    ds = _dataset_for_results_dir(results_dir, dataset, batch_id)
    print(
        f"[split-analysis] dir={results_dir} products={sorted(prods)} "
        f"model={model}"
        + (f" pairs={sorted(pair_filter)}" if pair_filter else "")
    )

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
    need_llm = bool(prods & _ALL_PRODUCTS) and not dry_run
    interpreter = None
    if need_llm:
        if not has_llm_credentials(model, api_key):
            print(f"  ⚠️  {api_key_env_hint(model)} missing — forcing dry_run stubs")
            dry_run = True
        else:
            interpreter = ClusterInterpreter(
                model=model, api_key=api_key, temperature=temperature, do_review=False
            )

    outputs: Dict[str, Any] = {"clusters": {}, "parameter_space_pairs": []}

    medoid_tpl = _load_template("medoid_trial_prompt.txt")
    summary_tpl = _load_template("cluster_summary_prompt.txt")
    pair_tpl = _load_template("parameter_space_pair_prompt.txt")

    # --- Pass 1 (no LLM): build every cluster's aggregate first -------------
    # Aggregates stay on disk for dashboard / selection-eval; they are NOT fed
    # into the cluster-summary LLM prompt (summary uses medoid + IC contrasts only).
    per_cluster: Dict[int, Dict[str, Any]] = {}
    for cluster_dir in cluster_dirs:
        cid = int(cluster_dir.name[len("cluster"):])
        if clusters is not None and cid not in clusters:
            continue
        cj = {}
        cj_path = _cp().resolve_path(cluster_dir, "cluster.json", must_exist=True)
        if cj_path is not None:
            cj = json.loads(cj_path.read_text(encoding="utf-8"))
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
        agg_path = write_cluster_aggregate(cluster_dir, aggregate)

        per_cluster[cid] = {
            "cluster_dir": cluster_dir,
            "cj": cj,
            "cblk": cblk,
            "mblk": mblk,
            "medoid_tid": medoid_tid,
            "iv": iv,
            "trial_ids": trial_ids,
            "aggregate": aggregate,
            "agg_path": agg_path,
        }

    # --- Pass 3 (LLM, per product) --------------------------------------
    for cid, pc in per_cluster.items():
        cluster_dir = pc["cluster_dir"]
        cj = pc["cj"]
        cblk = pc["cblk"]
        mblk = pc["mblk"]
        medoid_tid = pc["medoid_tid"]
        iv = pc["iv"]
        aggregate = pc["aggregate"]
        agg_path = pc["agg_path"]
        print(f"\n[split-analysis] cluster{cid}")

        cluster_out: Dict[str, Any] = {"aggregate": str(agg_path)}
        summary_parsed = None
        medoid_parsed = None

        # --- medoid ---
        # LLM sees: prompt_templates + processed/context_medoid.md + snapshots BEV.
        # conflict_metrics is computed for OUTPUT GT inject only — not sent to the model.
        if "medoid" in prods:
            pack = extract_conflict_pack(cluster_dir)
            pack["trial_id"] = medoid_tid
            pack["collided"] = mblk.get("collided")
            # Align Replayer / Heatmap: rebase absolute esmini times onto
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
                    trial_context=ctx or "(no description)",
                )
            )
            bev = collect_bev_snapshot_paths(
                cluster_dir, max_llm_snapshots=max_llm_snapshots
            )
            out_path = _cp().write_path(cluster_dir, "medoid_trial.yaml")
            if dry_run or interpreter is None:
                stub = {
                    "trial_id": medoid_tid,
                    "outcome": "collision" if mblk.get("collided") else "safe",
                    "conflict_metrics": pack,
                    "interaction_resolution": "unresolved",
                    "control_response": "none",
                    "primary_motive": "unclear",
                    "motive_summary": "stub (dry_run)",
                    "decision_timeline": [],
                    "open_questions": [],
                    "stub": True,
                }
                if clip_start is not None:
                    stub["clip_start_esmini_s"] = round(float(clip_start), 3)
                    stub["time_origin"] = "payload_observation_clip"
                stub = apply_collision_detail(stub, pack)
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
                # Inject authoritative (already-rebased) metrics into OUTPUT only.
                parsed["conflict_metrics"] = pack
                parsed["trial_id"] = parsed.get("trial_id") or medoid_tid
                if clip_start is not None:
                    parsed["clip_start_esmini_s"] = round(float(clip_start), 3)
                    parsed["time_origin"] = "payload_observation_clip"
                parsed = apply_collision_detail(parsed, pack)
                # Motives live on decision_timeline[].motive — drop legacy list if
                # the model still emits it so the on-disk schema stays single-timeline.
                if isinstance(parsed, dict):
                    parsed.pop("motive_evidence", None)
                medoid_parsed = _write_yaml_doc(
                    out_path, raw, parsed, {"token_usage": tokens}
                )
            cluster_out["medoid_trial"] = str(out_path)
            print(f"  ✓ {out_path.name}")

        outputs["clusters"][str(cid)] = cluster_out

    # --- Parameter-space pairs (gated matched packs under parameter_space_pairs/cA-cB/) ---
    if "parameter-space-pairs" in prods:
        print("\n[split-analysis] Parameter-space matched pairs…")
        from .cluster_selection_eval import medoid_card_block

        manifest = {}
        mp = results_dir / "manifest.json"
        if mp.is_file():
            manifest = json.loads(mp.read_text(encoding="utf-8"))
        pairs = (
            manifest.get("parameter_space_pairs")
            or manifest.get("param_boundary_pairs")
            or []
        )
        # Annotate if older manifests lack parameter_space_match / ic_match
        try:
            import sys as _sys

            _asrc = Path(__file__).resolve().parents[3] / "analyzer" / "src"
            if str(_asrc) not in _sys.path:
                _sys.path.insert(0, str(_asrc))
            from parameter_space_pair_packs import (  # type: ignore
                annotate_parameter_space_pairs,
                pair_folder_name,
                pair_pack_dir,
                write_pair_process_context_md,
            )

            sample0 = pairs[0] if pairs else {}
            if pairs and (
                "parameter_space_match" not in (sample0 or {})
                and "ic_match" not in (sample0 or {})
            ):
                pairs = annotate_parameter_space_pairs(pairs)
        except Exception:
            pair_folder_name = lambda a, b: f"c{min(int(a),int(b))}-c{max(int(a),int(b))}"
            pair_pack_dir = lambda rd, a, b: Path(rd) / "parameter_space_pairs" / pair_folder_name(a, b)
            write_pair_process_context_md = None  # type: ignore

        pair_root = results_dir / "parameter_space_pairs"
        if not pair_root.is_dir() and (results_dir / "ic_pairs").is_dir():
            pair_root = results_dir / "ic_pairs"
        pair_root.mkdir(exist_ok=True)
        for bp in pairs:
            matched = bp.get("parameter_space_match", bp.get("ic_match"))
            if matched is False:
                print(
                    f"  ⏭  c{bp.get('cluster_a')}↔c{bp.get('cluster_b')} "
                    f"param_dist={bp.get('param_dist')} (not parameter-space-matched)"
                )
                continue
            ca, cb = str(bp["cluster_a"]), str(bp["cluster_b"])
            folder = pair_folder_name(ca, cb)
            if pair_filter is not None and folder not in pair_filter:
                continue
            if pair_filter is None and clusters is not None and (
                int(ca) not in clusters and int(cb) not in clusters
            ):
                continue

            pack_dir = pair_pack_dir(results_dir, ca, cb)
            if not pack_dir.is_dir():
                print(f"  ⚠️  missing pack for {folder} — rebuild parameter_space_pairs first")
                continue

            # Gate: both cluster medoid cards must exist before parameter-space LLM.
            left_medoid_p = medoid_trial_path(results_dir, ca)
            right_medoid_p = medoid_trial_path(results_dir, cb)
            if left_medoid_p is None or right_medoid_p is None:
                missing = []
                if left_medoid_p is None:
                    missing.append(f"cluster{ca}/output/medoid_trial.yaml")
                if right_medoid_p is None:
                    missing.append(f"cluster{cb}/output/medoid_trial.yaml")
                print(
                    f"  ⏭  {folder} skipped — run medoid first for both endpoints "
                    f"(missing: {', '.join(missing)})"
                )
                continue

            process_ctx = pack_dir / "process" / "context.md"
            synced_dir = pack_dir / "synced_bev"
            if not process_ctx.is_file() and write_pair_process_context_md is not None:
                pair_doc = dict(bp)
                pj = pack_dir / "pair.json"
                if pj.is_file():
                    try:
                        pair_doc = json.loads(pj.read_text(encoding="utf-8"))
                    except Exception:
                        pair_doc = dict(bp)
                write_pair_process_context_md(
                    pack_dir,
                    left_cluster=ca,
                    right_cluster=cb,
                    pair_doc=pair_doc,
                )
            if not process_ctx.is_file():
                print(
                    f"  ⏭  {folder} skipped — missing process/context.md "
                    "(rebuild parameter_space_pairs)"
                )
                continue
            if not synced_dir.is_dir() or not any(synced_dir.glob("t_*.jpg")):
                print(
                    f"  ⏭  {folder} skipped — missing synced_bev frames "
                    "(rebuild parameter_space_pairs)"
                )
                continue

            ta, tb = str(bp["trial_a"]), str(bp["trial_b"])
            left_dir = find_param_boundary_trial_dir(
                results_dir, ca, cb, ta, index_map
            )
            right_dir = find_param_boundary_trial_dir(
                results_dir, cb, ca, tb, index_map
            )

            # Thin sides may lack llm_snapshots — packs are best-effort.
            left_pack = extract_conflict_pack(left_dir) if left_dir else {}
            right_pack = extract_conflict_pack(right_dir) if right_dir else {}
            left_ref = _trial_ref(
                ta,
                left_dir,
                index_map,
                trial_index=bp.get("trial_index_a"),
            )
            right_ref = _trial_ref(
                tb,
                right_dir,
                index_map,
                trial_index=bp.get("trial_index_b"),
            )
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
            if bp.get("collided_a") is not None:
                left_out = "collision" if bp["collided_a"] else "safe"
            if bp.get("collided_b") is not None:
                right_out = "collision" if bp["collided_b"] else "safe"
            card_role = bp.get("card_role") or (
                "primary" if left_out != right_out else "secondary"
            )

            pair_context = process_ctx.read_text(encoding="utf-8")
            if len(pair_context) > 12000:
                pair_context = pair_context[:12000] + "\n…[truncated]"
            # LLM sees only: process/context.md + synced BEV + both medoid_trial.yaml
            # cards + prompt_templates. No pair_facts / left_block / right_block.
            left_medoid_card = medoid_card_block(results_dir / f"cluster{ca}") or ""
            right_medoid_card = medoid_card_block(results_dir / f"cluster{cb}") or ""

            prompt = _with_common_sense(
                _safe_replace(
                    pair_tpl,
                    pair_context=pair_context,
                    left_medoid_trial=left_medoid_card,
                    right_medoid_trial=right_medoid_card,
                )
            )
            bev = collect_synced_parameter_space_bev_paths(results_dir, ca, cb, max_n=8)
            out_dir = pack_dir / "output"
            out_dir.mkdir(parents=True, exist_ok=True)
            out_path = out_dir / "contrast.yaml"
            # Drop legacy flat / pack-root YAML if present
            legacy_flat = pair_root / f"pair_c{ca}_c{cb}.yaml"
            if legacy_flat.is_file():
                legacy_flat.unlink(missing_ok=True)
            legacy_root = pack_dir / "contrast.yaml"
            if legacy_root.is_file() and legacy_root.resolve() != out_path.resolve():
                legacy_root.unlink(missing_ok=True)

            base_doc = {
                "clusters": [int(ca), int(cb)],
                "param_dist": bp.get("param_dist"),
                "card_role": card_role,
                "param_names": bp.get("param_names"),
                "left": {
                    **left_ref,
                    "cluster": int(ca),
                    "outcome": left_out,
                    "params": left_params,
                    "conflict_metrics": left_pack,
                    "interaction_resolution": "unresolved",
                    "control_response": "none",
                    "primary_motive": "unclear",
                },
                "right": {
                    **right_ref,
                    "cluster": int(cb),
                    "outcome": right_out,
                    "params": right_params,
                    "conflict_metrics": right_pack,
                    "interaction_resolution": "unresolved",
                    "control_response": "none",
                    "primary_motive": "unclear",
                },
                "delta": {},
                "contrast_timeline": [],
                "critical_divergence": {},
                "motive_contrast": "unclear",
            }
            if dry_run or interpreter is None:
                stub = {
                    **base_doc,
                    "contrast_explanation": "stub (dry_run)",
                    "separation_call": "inconclusive",
                    "separation_reason": "stub",
                    "hypothesis": "",
                    "stub": True,
                }
                _write_yaml_doc(out_path, None, stub, {"stub": True})
            else:
                raw, tokens, parsed = interpreter.complete_yaml_prompt(
                    prompt,
                    system_prompt=_system_prompt(),
                    bev_snapshot_paths=bev[:8],
                    section_title="Parameter-space pair synced BEV (left|right at same t′)",
                )
                if parsed is None:
                    parsed = {
                        **base_doc,
                        "contrast_explanation": "parse_failed",
                        "separation_call": "inconclusive",
                    }
                parsed.setdefault("left", {})
                parsed.setdefault("right", {})
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
                parsed["card_role"] = card_role
                for key in (
                    "contrast_explanation",
                    "hypothesis",
                    "separation_reason",
                ):
                    if isinstance(parsed.get(key), str):
                        parsed[key] = _format_caption_paragraphs(parsed[key])
                _write_yaml_doc(out_path, raw, parsed, {"token_usage": tokens})
            outputs["parameter_space_pairs"].append(str(out_path))
            print(f"  ✓ {folder}/output/contrast.yaml [{card_role}]")


    # --- Cluster summaries (AFTER parameter-space-pairs so same-invocation contrasts exist) ---
    if "summary" in prods:
        from .cluster_selection_eval import (
            medoid_card_block,
            neighbor_cards_for_cluster,
        )

        print("\n[split-analysis] cluster summaries…")
        for cid, pc in per_cluster.items():
            cluster_dir = pc["cluster_dir"]
            aggregate = pc["aggregate"]
            cluster_out = outputs["clusters"].setdefault(str(cid), {})
            print(f"\n[split-analysis] summary cluster{cid}")

            own_medoid_card = medoid_card_block(cluster_dir)
            if own_medoid_card is None:
                print(
                    f"  ⏭  cluster_summary skipped — run medoid first "
                    f"(missing cluster{cid}/output/medoid_trial.yaml)"
                )
                continue
            missing_contrasts = missing_parameter_space_contrasts_for_cluster(results_dir, cid)
            if missing_contrasts:
                print(
                    f"  ⏭  cluster_summary skipped — run parameter-space-pairs first for "
                    f"{', '.join(missing_contrasts)} "
                    f"(need parameter_space_pairs/*/output/contrast.yaml)"
                )
                continue

            cluster_ctx_path = _cp().resolve_path(
                cluster_dir, "context_cluster.md", must_exist=True
            )
            cluster_context = (
                cluster_ctx_path.read_text(encoding="utf-8").strip()
                if cluster_ctx_path is not None
                else "(no context_cluster.md yet — rebuild processed/)"
            )
            # LLM sees: this cluster medoid_trial.yaml + touching contrasts
            # + optional context_cluster.md. No numeric/relative digest dumps.
            neighbor_cards = neighbor_cards_for_cluster(results_dir, cid)
            prompt = _with_common_sense(
                _safe_replace(
                    summary_tpl,
                    medoid_trial=own_medoid_card,
                    neighbor_cards=neighbor_cards,
                    cluster_context=cluster_context,
                )
            )
            out_path = _cp().write_path(cluster_dir, "cluster_summary.yaml")
            if dry_run or interpreter is None:
                stub = {
                    "cluster_id": cid,
                    "label": f"Cluster {cid}",
                    "risk_level": "high" if (aggregate.get("collision_rate") or 0) > 50 else "low",
                    "confidence": "medium",
                    "numeric_digest_ref": True,
                    "caption": "stub (dry_run)",
                    "consistency_note": "",
                    "motive_consistency_note": "",
                    "neighbor_comparison": [],
                    "distinct_from_neighbors": None,
                    "neighborhood_separation": "ambiguous",
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
                if isinstance(parsed.get("motive_consistency_note"), str):
                    parsed["motive_consistency_note"] = _format_caption_paragraphs(
                        parsed["motive_consistency_note"]
                    )
                summary_parsed = _write_yaml_doc(
                    out_path, raw, parsed, {"token_usage": tokens}
                )
            cluster_out["cluster_summary"] = str(out_path)
            print(f"  ✓ {out_path.name}")

    # --- Deterministic selection quality (always; no LLM, no network) ---------
    try:
        from .cluster_selection_eval import write_eval

        sel_path = write_eval(results_dir)
        if sel_path is not None:
            outputs["selection_eval"] = str(sel_path)
    except Exception as exc:
        print(f"  ⚠️  selection eval failed: {exc}")

    # --- Cross-cluster evaluation (LLM verdict over medoid + Parameter-space pair cards) ---
    if "cross-eval" in prods:
        print("\n[split-analysis] cross-eval")
        try:
            from .cross_cluster_evaluator import run_cross_cluster_eval

            cross_path = run_cross_cluster_eval(
                run_dir=results_dir,
                model=model,
                temperature=temperature,
                api_key=api_key,
                dry_run=dry_run,
            )
            if cross_path is not None:
                outputs["cross_eval"] = str(cross_path)
                # Re-score so clustering_quality.json picks up the LLM layer.
                from .clustering_quality_scorer import score_run_dir

                score_run_dir(results_dir)
        except Exception as exc:
            print(f"  ⚠️  cross-eval failed: {exc}")

    summary_path = results_dir / "split_analysis_summary.json"
    summary_path.write_text(json.dumps(outputs, indent=2), encoding="utf-8")
    print(f"\n[split-analysis] done → {summary_path}")
    return outputs
