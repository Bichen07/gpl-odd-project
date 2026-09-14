"""cluster_label_reviewer.py — review already-written cluster_summary.yaml
``label``s for one run.

Each cluster's ``label`` is invented independently by the summary LLM (one
call per cluster, no view of siblings — see ``cluster_summary_prompt.txt``).
This module runs a SECOND, single LLM call over the whole run that only ever
reads what is already on disk (label + caption excerpt + risk_level) and:

  1. catches mechanism-chained labels ("Assertive Gap Late Yield Collision")
     and rewrites them to a short 2-4 word outcome archetype;
  2. catches duplicate / near-duplicate labels across clusters whose captions
     actually describe different behavior, and renames the offending one.

It never re-derives behavior from medoid_trial.yaml / contrast.yaml — that
evidence already produced the label the first time; this pass only cleans up
naming across the run. Renames are applied in place to ``cluster_summary.yaml``
(``label`` is overwritten; the previous value + reason are kept in a
``label_review`` audit block), and the full row set is written to
``analysis/quality/cluster_label_review.json``.
"""

from __future__ import annotations

import asyncio
import json
import re
from datetime import datetime, timezone
from pathlib import Path
from typing import Any, Dict, List, Optional

import yaml

from .llm_factory import (
    DEFAULT_MODEL,
    api_key_env_hint,
    create_interpretation_llm,
    has_llm_credentials,
    is_gemini_model,
    llm_api_key_for_model,
    normalize_model_name,
)
from .paths import PROMPT_TEMPLATES_DIR, run_artifact_path, run_source_dir

try:
    from langchain_community.callbacks.manager import get_openai_callback
    from langchain_core.messages import HumanMessage, SystemMessage
except ImportError:  # pragma: no cover
    pass

_REVIEWER_PROMPT_FILE = "cluster_reviewer_prompt.txt"

_SYSTEM_TEXT = (
    "You are an expert AV safety analyst auditing cluster archetype names for "
    "precision and distinctiveness across one run. Follow the task exactly. "
    "Output one ```json fenced array only, one row per cluster listed."
)


def _now_iso() -> str:
    return datetime.now(timezone.utc).isoformat().replace("+00:00", "Z")


def _cp():
    import sys

    analyzer_src = Path(__file__).resolve().parents[3] / "analyzer" / "src"
    if str(analyzer_src) not in sys.path:
        sys.path.insert(0, str(analyzer_src))
    import cluster_paths as cp  # type: ignore

    return cp


def _load_cluster_rows(run_dir: Path) -> List[Dict[str, Any]]:
    """One row per cluster<N>/output/cluster_summary.yaml already on disk."""
    run_dir = Path(run_dir)
    rows: List[Dict[str, Any]] = []
    for cdir in sorted(run_source_dir(run_dir).glob("cluster*")):
        if not (cdir.is_dir() and cdir.name[len("cluster"):].isdigit()):
            continue
        cid = int(cdir.name[len("cluster"):])
        path = _cp().resolve_path(cdir, "cluster_summary.yaml", must_exist=True)
        if path is None or not path.is_file():
            continue
        try:
            doc = yaml.safe_load(path.read_text(encoding="utf-8")) or {}
        except Exception:
            continue
        if not isinstance(doc, dict) or doc.get("stub"):
            continue
        label = str(doc.get("label") or "").strip()
        if not label:
            continue
        rows.append(
            {
                "cluster_id": cid,
                "yaml_path": path,
                "label": label,
                "risk_level": doc.get("risk_level"),
                "caption_excerpt": str(doc.get("caption") or "").strip()[:400],
            }
        )
    return rows


def _format_cluster_cards(rows: List[Dict[str, Any]]) -> str:
    lines: List[str] = []
    for r in rows:
        lines.append(f"c{r['cluster_id']}: label=\"{r['label']}\" risk_level={r.get('risk_level')}")
        if r["caption_excerpt"]:
            lines.append(f"  caption: {r['caption_excerpt']}")
    return "\n".join(lines) if lines else "(no cluster_summary.yaml labels on disk)"


def _extract_json_block(text: str) -> str:
    fences = re.findall(r"```(?:json)?\s*([\s\S]*?)```", text, re.IGNORECASE)
    if fences:
        return fences[-1].strip()
    m = re.search(r"(?m)^\s*[\[{]", text)
    if m:
        return text[m.start():].strip()
    return text.strip()


def _parse_review_json(text: str) -> Optional[List[Dict[str, Any]]]:
    raw = _extract_json_block(text)
    for candidate in (raw, text.strip()):
        try:
            parsed = json.loads(candidate)
        except json.JSONDecodeError:
            continue
        if isinstance(parsed, list):
            return parsed
        if isinstance(parsed, dict) and isinstance(parsed.get("rows"), list):
            return parsed["rows"]
    return None


def _load_prompt() -> Optional[str]:
    p = PROMPT_TEMPLATES_DIR / _REVIEWER_PROMPT_FILE
    try:
        return p.read_text(encoding="utf-8")
    except FileNotFoundError:
        print(f"[ClusterLabelReviewer] Prompt not found: {p}")
        return None


def _response_text(content) -> str:
    if isinstance(content, str):
        return content
    if isinstance(content, list):
        return "".join(
            b if isinstance(b, str) else (b.get("text") or "") if isinstance(b, dict) else str(b)
            for b in content
        )
    return str(content or "")


def _invoke(llm, model: str, messages, timeout: int = 120):
    loop = asyncio.new_event_loop()
    asyncio.set_event_loop(loop)

    async def _run():
        return await llm.ainvoke(messages)

    try:
        if is_gemini_model(model):
            resp = loop.run_until_complete(asyncio.wait_for(_run(), timeout=timeout))
            meta = getattr(resp, "usage_metadata", None) or {}
            tokens = {
                "Prompt": int(meta.get("input_tokens", 0) or 0),
                "Completion": int(meta.get("output_tokens", 0) or 0),
                "Total": int(meta.get("total_tokens", 0) or 0),
            }
            return resp, tokens
        with get_openai_callback() as cb:
            resp = loop.run_until_complete(asyncio.wait_for(_run(), timeout=timeout))
            return resp, {
                "Prompt": cb.prompt_tokens,
                "Completion": cb.completion_tokens,
                "Total": cb.total_tokens,
            }
    finally:
        loop.close()


def review_run_dir(
    run_dir: Path,
    *,
    model: str = DEFAULT_MODEL,
    temperature: float = 0.1,
    api_key: Optional[str] = None,
    dry_run: bool = False,
) -> Optional[Path]:
    """Review every cluster_summary.yaml ``label`` in one run; rename in place
    where justified. Writes ``analysis/quality/cluster_label_review.json``.

    Returns the output path, or ``None`` if there are fewer than 2 labeled
    clusters to compare (nothing to review).
    """
    run_dir = Path(run_dir)
    rows = _load_cluster_rows(run_dir)
    out_path = run_artifact_path(run_dir, "label_review", write=True)

    if len(rows) < 2:
        print(f"[ClusterLabelReviewer] Need >=2 labeled clusters; found {len(rows)} — skipped")
        return None

    model = normalize_model_name(model)
    if dry_run or not has_llm_credentials(model, api_key):
        reason = "dry_run" if dry_run else f"{api_key_env_hint(model)} not set"
        stub = {
            "generated_at": _now_iso(),
            "rows": [
                {
                    "cluster_id": r["cluster_id"],
                    "original_label": r["label"],
                    "new_label": r["label"],
                    "changed": False,
                    "reason": f"skipped ({reason})",
                }
                for r in rows
            ],
            "n_changed": 0,
            "stub": True,
        }
        out_path.write_text(json.dumps(stub, indent=2), encoding="utf-8")
        return out_path

    prompt_tmpl = _load_prompt()
    if not prompt_tmpl:
        return None
    full_prompt = prompt_tmpl.replace("{cluster_cards}", _format_cluster_cards(rows))

    llm = create_interpretation_llm(
        model, api_key=llm_api_key_for_model(model, api_key), temperature=temperature
    )
    messages = [SystemMessage(content=_SYSTEM_TEXT), HumanMessage(content=full_prompt)]
    try:
        resp, tokens = _invoke(llm, model, messages)
        raw = _response_text(resp.content)
    except Exception as exc:
        print(f"[ClusterLabelReviewer] LLM call failed: {exc}")
        return None

    parsed_rows = _parse_review_json(raw)
    if parsed_rows is None:
        print("[ClusterLabelReviewer] Could not parse JSON from LLM response")
        return None

    by_cluster = {r["cluster_id"]: r for r in rows}
    n_changed = 0
    for row in parsed_rows:
        if not isinstance(row, dict):
            continue
        try:
            cid = int(row.get("cluster_id"))
        except (TypeError, ValueError):
            continue
        src = by_cluster.get(cid)
        if src is None:
            continue
        new_label = str(row.get("new_label") or "").strip()
        if not bool(row.get("changed")) or not new_label or new_label == src["label"]:
            continue
        try:
            doc = yaml.safe_load(src["yaml_path"].read_text(encoding="utf-8")) or {}
        except Exception:
            continue
        if not isinstance(doc, dict):
            continue
        doc["label_review"] = {
            "previous_label": src["label"],
            "reason": str(row.get("reason") or ""),
            "reviewed_at": _now_iso(),
        }
        doc["label"] = new_label
        body = yaml.safe_dump(doc, sort_keys=False)
        src["yaml_path"].write_text(body if body.endswith("\n") else body + "\n", encoding="utf-8")
        n_changed += 1
        print(f"  ✓ c{cid}: \"{src['label']}\" → \"{new_label}\"")

    doc_out = {
        "generated_at": _now_iso(),
        "rows": parsed_rows,
        "n_changed": n_changed,
        "token_usage": tokens,
    }
    out_path.write_text(json.dumps(doc_out, indent=2), encoding="utf-8")
    print(f"[ClusterLabelReviewer] Wrote {out_path} ({n_changed} renamed)")
    return out_path
