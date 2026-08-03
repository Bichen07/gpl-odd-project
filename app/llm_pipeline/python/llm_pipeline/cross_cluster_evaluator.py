"""cross_cluster_evaluator.py — Phase 6b: Cross-cluster behavioral comparison.

Reads all per-cluster cluster.json + cluster_summary.yaml for one
``<k>_cluster_s=<sil>/`` directory, optionally loads boundary trial
descriptions, then asks the LLM to rate inter-cluster separation and
boundary clarity.

Outputs:
  <run_dir>/cross_cluster_eval.json
"""

from __future__ import annotations

import asyncio
import json
import re
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any, Dict, List, Optional

from .llm_factory import (
    DEFAULT_MODEL,
    api_key_env_hint,
    create_interpretation_llm,
    has_llm_credentials,
    is_gemini_model,
    llm_api_key_for_model,
    normalize_model_name,
)
from .paths import PROMPT_TEMPLATES_DIR

try:
    from langchain_community.callbacks.manager import get_openai_callback
    from langchain_core.messages import HumanMessage, SystemMessage
except ImportError:  # pragma: no cover
    pass

_CROSS_PROMPT_FILE = "cross_cluster_prompt.txt"
_OUTPUT_FILE = "cross_cluster_eval.json"


@dataclass
class CrossClusterEval:
    behavioral_separation_score: int
    boundary_clarity_score: int
    inter_notes: str
    cluster_summaries: List[Dict[str, Any]] = field(default_factory=list)
    merge_candidates: List[str] = field(default_factory=list)
    split_candidates: List[str] = field(default_factory=list)
    token_usage: Dict[str, int] = field(default_factory=dict)
    raw_json: str = ""


def _narrative_from_yaml(path: Path) -> Dict[str, Any]:
    """Map cluster_summary.yaml (or medoid) fields into the eval meta shape."""
    try:
        import yaml  # type: ignore

        doc = yaml.safe_load(path.read_text(encoding="utf-8"))
    except Exception:
        return {}
    if not isinstance(doc, dict):
        return {}
    return {
        "cluster_label": doc.get("label"),
        "behavior_description": doc.get("caption") or doc.get("motive_summary"),
        "confidence": doc.get("confidence"),
        "safety_assessment": {
            "risk_level": doc.get("risk_level"),
            "failure_mode": doc.get("consistency_note"),
        },
    }


def _load_cluster_docs(run_dir: Path) -> List[Dict[str, Any]]:
    """Load cluster.json + narrative YAML for every cluster<N> folder.

    Prefer ``cluster_summary.yaml``; fall back to ``medoid_trial.yaml``.
    """
    docs: List[Dict[str, Any]] = []
    import sys

    analyzer_src = Path(__file__).resolve().parents[3] / "analyzer" / "src"
    if str(analyzer_src) not in sys.path:
        sys.path.insert(0, str(analyzer_src))
    from cluster_paths import resolve_path  # type: ignore

    for cdir in sorted(run_dir.glob("cluster*")):
        if not (cdir.is_dir() and cdir.name[len("cluster"):].isdigit()):
            continue
        cj = resolve_path(cdir, "cluster.json", must_exist=True)
        if cj is None:
            continue
        try:
            cluster_doc = json.loads(cj.read_text(encoding="utf-8"))
        except Exception:
            continue
        meta: Dict[str, Any] = {}
        for name in ("cluster_summary.yaml", "medoid_trial.yaml"):
            yp = resolve_path(cdir, name, must_exist=True)
            if yp is None:
                continue
            meta = _narrative_from_yaml(yp)
            if meta.get("cluster_label") or meta.get("behavior_description"):
                break
            meta = {}
        docs.append({"cluster_doc": cluster_doc, "meta": meta, "cluster_dir": cdir})
    return docs


def _load_boundary_pairs(run_dir: Path) -> List[Dict[str, Any]]:
    """Load boundary_pairs from manifest.json."""
    manifest_path = run_dir / "manifest.json"
    if not manifest_path.is_file():
        return []
    try:
        manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
        return manifest.get("boundary_pairs") or []
    except Exception:
        return []


def _boundary_description_text(run_dir: Path, bp: Dict[str, Any]) -> str:
    """Read description.txt for both sides of a boundary pair."""
    ca, ta = bp.get("cluster_a"), bp.get("trial_a")
    cb, tb = bp.get("cluster_b"), bp.get("trial_b")

    def _read(cluster_label: Any, trial_id: Any) -> str:
        import sys

        analyzer_src = Path(__file__).resolve().parents[3] / "analyzer" / "src"
        if str(analyzer_src) not in sys.path:
            sys.path.insert(0, str(analyzer_src))
        from cluster_paths import resolve_highlight_subdir, resolve_path  # type: ignore

        cdir = run_dir / f"cluster{cluster_label}"
        tgt = cb if cluster_label == ca else ca
        bdir = resolve_highlight_subdir(cdir, f"boundary_c{tgt}", must_exist=True)
        for sub in sorted(bdir.glob("trial_*")) if bdir else []:
            desc = resolve_path(sub, "description.txt", must_exist=True)
            if desc is None:
                desc = sub / "description.txt"
                if not desc.is_file():
                    continue
            return desc.read_text(encoding="utf-8").strip()
        return ""

    text_a = _read(ca, ta)
    text_b = _read(cb, tb)
    emb = bp.get("embedding_dist", "?")

    parts = [
        f"=== Boundary C{ca} ↔ C{cb} (embedding_dist={emb}) ===",
        f"--- Trial from C{ca} (trial_id={ta}, collided={bp.get('collided_a', '?')}) ---",
        text_a or "(no description available)",
        f"--- Trial from C{cb} (trial_id={tb}, collided={bp.get('collided_b', '?')}) ---",
        text_b or "(no description available)",
    ]
    return "\n".join(parts)


def _format_cluster_summaries(docs: List[Dict[str, Any]]) -> str:
    lines: List[str] = []
    for d in docs:
        c = d["cluster_doc"].get("cluster", {})
        meta = d["meta"]
        label = c.get("label", "?")
        cr = c.get("collision_rate")
        iv = c.get("intra_variance") or {}
        consistency = meta.get("intra_consistency_score") or iv.get("intra_consistency_score")
        archetype = meta.get("cluster_label") or f"Cluster {label}"
        desc = (meta.get("behavior_description") or "")[:300]
        lines.append(
            f"Cluster {label}: label={archetype!r}, "
            f"collision_rate={cr}%, "
            f"intra_consistency={consistency if consistency is not None else 'n/a'}, "
            f"n_trials={c.get('n_trials', '?')}"
        )
        if desc:
            lines.append(f"  Description: {desc}")
    return "\n".join(lines)


def _format_boundary_pairs(run_dir: Path, boundary_pairs: List[Dict[str, Any]]) -> str:
    if not boundary_pairs:
        return "(No boundary trial descriptions available)"
    parts = []
    for bp in boundary_pairs:
        parts.append(_boundary_description_text(run_dir, bp))
    return "\n\n".join(parts)


def _extract_json_block(text: str) -> str:
    fences = re.findall(r"```(?:json)?\s*([\s\S]*?)```", text, re.IGNORECASE)
    if fences:
        return fences[-1].strip()
    m = re.search(r"(?m)^\s*\{", text)
    if m:
        return text[m.start():].strip()
    return text.strip()


def _parse_eval_json(text: str) -> Optional[Dict[str, Any]]:
    raw = _extract_json_block(text)
    for candidate in (raw, text.strip()):
        try:
            parsed = json.loads(candidate)
            if isinstance(parsed, dict):
                return parsed
        except json.JSONDecodeError:
            continue
    return None


class CrossClusterEvaluator:
    """Run a single LLM call to evaluate inter-cluster separation for one run dir."""

    def __init__(
        self,
        model: str = DEFAULT_MODEL,
        temperature: float = 0.1,
        api_key: Optional[str] = None,
        prompt_dir: Optional[str] = None,
    ):
        self.model = normalize_model_name(model)
        self.temperature = temperature
        self._api_key = api_key
        self.prompt_dir = Path(prompt_dir) if prompt_dir else PROMPT_TEMPLATES_DIR
        self._loop: Optional[asyncio.AbstractEventLoop] = None
        self.llm = create_interpretation_llm(
            self.model,
            api_key=llm_api_key_for_model(self.model, api_key),
            temperature=temperature,
        )

    def _ensure_loop(self) -> asyncio.AbstractEventLoop:
        if self._loop is None or self._loop.is_closed():
            self._loop = asyncio.new_event_loop()
            asyncio.set_event_loop(self._loop)
        return self._loop

    def _run_async(self, coro):
        return self._ensure_loop().run_until_complete(coro)

    def _load_prompt(self) -> Optional[str]:
        p = self.prompt_dir / _CROSS_PROMPT_FILE
        try:
            return p.read_text(encoding="utf-8")
        except FileNotFoundError:
            print(f"[CrossClusterEvaluator] Prompt not found: {p}")
            return None

    @staticmethod
    def _safe_format(template: str, **kw) -> str:
        out = template or ""
        for k, v in kw.items():
            out = out.replace("{" + k + "}", str(v))
        return out

    def _invoke(self, messages, timeout: int = 180):
        async def _run():
            return await self.llm.ainvoke(messages)

        if is_gemini_model(self.model):
            resp = self._run_async(asyncio.wait_for(_run(), timeout=timeout))
            meta = getattr(resp, "usage_metadata", None) or {}
            tokens = {
                "Prompt": int(meta.get("input_tokens", 0) or 0),
                "Completion": int(meta.get("output_tokens", 0) or 0),
                "Total": int(meta.get("total_tokens", 0) or 0),
            }
            return resp, tokens

        with get_openai_callback() as cb:
            resp = self._run_async(asyncio.wait_for(_run(), timeout=timeout))
            return resp, {
                "Prompt": cb.prompt_tokens,
                "Completion": cb.completion_tokens,
                "Total": cb.total_tokens,
            }

    @staticmethod
    def _response_text(content) -> str:
        if isinstance(content, str):
            return content
        if isinstance(content, list):
            return "".join(
                b if isinstance(b, str) else (b.get("text") or "") if isinstance(b, dict) else str(b)
                for b in content
            )
        return str(content or "")

    def evaluate(self, run_dir: Path) -> Optional[CrossClusterEval]:
        prompt_tmpl = self._load_prompt()
        if not prompt_tmpl:
            return None

        docs = _load_cluster_docs(run_dir)
        if len(docs) < 2:
            print("[CrossClusterEvaluator] Need ≥2 clusters; found", len(docs))
            return None

        boundary_pairs = _load_boundary_pairs(run_dir)
        cluster_summaries_text = _format_cluster_summaries(docs)
        boundary_pairs_text = _format_boundary_pairs(run_dir, boundary_pairs)

        # Extract system context (everything before <Cluster Summaries>)
        system_text = prompt_tmpl.split("<Cluster Summaries>")[0].strip()
        full_prompt = self._safe_format(
            prompt_tmpl,
            cluster_summaries=cluster_summaries_text,
            boundary_trial_pairs=boundary_pairs_text,
        )

        messages = [
            SystemMessage(content=system_text),
            HumanMessage(content=full_prompt),
        ]

        try:
            resp, tokens = self._invoke(messages)
            raw = self._response_text(resp.content)
        except Exception as exc:
            print(f"[CrossClusterEvaluator] LLM call failed: {exc}")
            return None

        parsed = _parse_eval_json(raw)
        if parsed is None:
            print("[CrossClusterEvaluator] Could not parse JSON from LLM response")
            return None

        result = CrossClusterEval(
            behavioral_separation_score=int(parsed.get("behavioral_separation_score", 5)),
            boundary_clarity_score=int(parsed.get("boundary_clarity_score", 5)),
            inter_notes=str(parsed.get("inter_notes", "")),
            cluster_summaries=list(parsed.get("cluster_summaries") or []),
            merge_candidates=list(parsed.get("merge_candidates") or []),
            split_candidates=list(parsed.get("split_candidates") or []),
            token_usage=tokens,
            raw_json=raw,
        )
        print(
            f"[CrossClusterEvaluator] separation={result.behavioral_separation_score}, "
            f"clarity={result.boundary_clarity_score}, tokens={tokens.get('Total', 0)}"
        )
        return result


def run_cross_cluster_eval(
    run_dir: Path,
    model: str = DEFAULT_MODEL,
    temperature: float = 0.1,
    api_key: Optional[str] = None,
    dry_run: bool = False,
) -> Optional[Path]:
    """Evaluate one ``<k>_cluster_s=<sil>/`` directory and write ``cross_cluster_eval.json``.

    Returns the output path on success, None on failure.
    """
    run_dir = Path(run_dir)
    out_path = run_dir / _OUTPUT_FILE

    model = normalize_model_name(model)
    if dry_run or not has_llm_credentials(model, api_key):
        reason = "dry_run" if dry_run else f"{api_key_env_hint(model)} not set"
        stub = {
            "behavioral_separation_score": None,
            "boundary_clarity_score": None,
            "inter_notes": f"Cross-cluster evaluation skipped ({reason})",
            "cluster_summaries": [],
            "merge_candidates": [],
            "split_candidates": [],
            "stub": True,
        }
        out_path.write_text(json.dumps(stub, indent=2), encoding="utf-8")
        return out_path

    evaluator = CrossClusterEvaluator(
        model=model,
        temperature=temperature,
        api_key=api_key,
    )
    result = evaluator.evaluate(run_dir)
    if result is None:
        return None

    doc = {
        "behavioral_separation_score": result.behavioral_separation_score,
        "boundary_clarity_score": result.boundary_clarity_score,
        "inter_notes": result.inter_notes,
        "cluster_summaries": result.cluster_summaries,
        "merge_candidates": result.merge_candidates,
        "split_candidates": result.split_candidates,
        "token_usage": result.token_usage,
    }
    out_path.write_text(json.dumps(doc, indent=2), encoding="utf-8")
    print(f"[CrossClusterEvaluator] Wrote {out_path}")
    return out_path
