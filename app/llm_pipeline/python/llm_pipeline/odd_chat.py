"""S5 (part 2/2) — ODD Q&A: grounded chat over ``odd_chat_briefing.json``.

Implements implementation_plan.md §7 (intent router §7.6, memory rules §7.3,
paper support / risk mitigations §7.8). This is *light RAG / grounded
prompting*, not full RAG (Lewis et al. 2020) — see plan §2.4 for the exact
distinction we must keep honest in the thesis.

Rules enforced here (plan §1 "Hard engineering rules" + §7):
  - Numbers/claims only come from the briefing JSON; the LLM may paraphrase,
    never invent thresholds (system prompt says so explicitly).
  - If the briefing marks something ``missing``, the answer must say unknown
    + which product (S2/S3/...) to run, not guess.
  - Every answer carries a ``citations`` list naming which briefing sections
    were attached for that turn — the caller (CLI or a future API route) is
    responsible for rendering them as clickable chips.
  - Dialog memory is the last K turns only (default 8); briefing is
    re-attached every turn so old hallucinations cannot silently "stick".
"""

from __future__ import annotations

import json
import re
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any, Dict, List, Optional, Tuple

from .llm_factory import create_interpretation_llm, has_llm_credentials, api_key_env_hint
from .paths import run_artifact_path

BRIEFING_FILENAME = "odd_chat_briefing.json"
CHAT_LOG_FILENAME = "odd_chat_log.jsonl"

def _load_system_prompt() -> str:
    prompt_path = (
        Path(__file__).resolve().parents[2]
        / "prompt_templates"
        / "odd_chat_system_prompt.txt"
    )
    try:
        return prompt_path.read_text(encoding="utf-8").strip()
    except OSError as exc:
        raise RuntimeError(f"Could not load Q&A system prompt: {prompt_path}") from exc


SYSTEM_PROMPT = _load_system_prompt()

INTENT_KEYWORDS: List[Tuple[str, List[str]]] = [
    ("weakness", [r"\bweak", r"\bfail(ure|ing)?\s+mode", r"\bworst\b", r"\bproblem"]),
    ("fail_conditions", [r"\bfail\b.*condition", r"\bodd\b", r"\blimit", r"high.?probab", r"when does .* (fail|collide)"]),
    ("what_next", [r"test next", r"what (should|to) test", r"next test", r"untested", r"cover(age)?"]),
    ("why_clustering", [r"\bmerge\b", r"why.*cluster", r"why.*useful", r"why keep", r"separat"]),
]


def _now_iso() -> str:
    from datetime import datetime, timezone

    return datetime.now(timezone.utc).isoformat().replace("+00:00", "Z")


def load_briefing(run_dir: Path) -> Dict[str, Any]:
    p = run_artifact_path(Path(run_dir), "odd_briefing")
    if not p.is_file():
        raise FileNotFoundError(
            f"Missing {p} — run S5 briefing build first (odd_briefing.build_briefing)."
        )
    return json.loads(p.read_text(encoding="utf-8"))


def _extract_cluster_ids(question: str) -> List[int]:
    return [int(x) for x in re.findall(r"\bcluster\s*(\d+)\b", question, flags=re.IGNORECASE)]


def _extract_pair_folders(question: str) -> List[str]:
    return [f"c{a}-c{b}" for a, b in re.findall(r"\bc(\d+)-c(\d+)\b", question, flags=re.IGNORECASE)]


def classify_intent(question: str) -> str:
    q = question.lower()
    for intent, patterns in INTENT_KEYWORDS:
        if any(re.search(pat, q) for pat in patterns):
            return intent
    return "other"


@dataclass
class RoutedContext:
    context: Dict[str, Any] = field(default_factory=dict)
    citations: List[str] = field(default_factory=list)


def route(question: str, briefing: Dict[str, Any]) -> RoutedContext:
    """§7.6 intent router — keyword/regex v1 (embeddings optional later)."""
    cluster_ids = _extract_cluster_ids(question)
    pair_folders = _extract_pair_folders(question)
    clusters = briefing.get("clusters") or []
    pairs = briefing.get("pairs") or []

    ctx: Dict[str, Any] = {"run": briefing.get("run"), "missing": briefing.get("missing")}
    citations: List[str] = []

    if cluster_ids or pair_folders:
        picked_clusters = [c for c in clusters if c.get("id") in cluster_ids] or clusters
        picked_pairs = (
            [p for p in pairs if p.get("folder") in pair_folders]
            or [p for p in pairs if set(p.get("clusters") or []) & set(cluster_ids)]
        )
        ctx["clusters"] = picked_clusters
        ctx["pairs"] = picked_pairs
        citations += [f"cluster{c['id']}/summary" for c in picked_clusters]
        citations += [f"pair {p['folder']}" for p in picked_pairs]
        return RoutedContext(ctx, citations)

    intent = classify_intent(question)

    if intent == "weakness":
        top = sorted(clusters, key=lambda c: c.get("collision_rate") or -1, reverse=True)[:3]
        ctx["clusters"] = top
        ctx["pairs"] = pairs[:5]
        citations = [f"cluster{c['id']}/summary" for c in top] + [f"pair {p['folder']}" for p in pairs[:5]]
    elif intent == "fail_conditions":
        ctx["rules"] = briefing.get("rules")
        ctx["boundary"] = briefing.get("boundary")
        citations = [f"rule {r['id']}" for r in (briefing.get("rules") or [])]
        if briefing.get("boundary"):
            citations.append(f"boundary export kNN={briefing['boundary'].get('kNN')}")
    elif intent == "what_next":
        ctx["boundary"] = briefing.get("boundary")
        ctx["rules"] = briefing.get("rules")
        ctx["merge_candidates"] = briefing.get("merge_candidates")
        citations = ["boundary export", "parameter rules"]
    elif intent == "why_clustering":
        ctx["clusters"] = [
            {k: c.get(k) for k in ("id", "label", "neighbor_behavior")} for c in clusters
        ]
        ctx["pairs"] = [{k: p.get(k) for k in ("folder", "clusters", "behavior_similarity")} for p in pairs]
        ctx["merge_candidates"] = briefing.get("merge_candidates")
        ctx["quality"] = {"selection_score": (briefing.get("run") or {}).get("selection_score")}
        citations = [f"pair {p['folder']}" for p in pairs] + ["selection-eval"]
    else:
        ctx["clusters"] = [{k: c.get(k) for k in ("id", "label", "collision_rate")} for c in clusters]
        citations = ["run header"]

    return RoutedContext(ctx, citations)


def build_messages(
    briefing: Dict[str, Any],
    question: str,
    history: List[Dict[str, str]],
    max_history_turns: int = 8,
) -> Tuple[List[Dict[str, str]], List[str]]:
    routed = route(question, briefing)
    # History is stored as alternating user/assistant messages, so K dialog
    # turns correspond to up to 2*K message entries.
    trimmed_history = history[-(max_history_turns * 2):] if history else []

    messages: List[Dict[str, str]] = [{"role": "system", "content": SYSTEM_PROMPT}]
    messages.append(
        {
            "role": "system",
            "content": "BRIEFING (only source of truth for numbers/ids in this run):\n"
            + json.dumps(routed.context, indent=2),
        }
    )
    messages.extend(trimmed_history)
    messages.append({"role": "user", "content": question})
    return messages, routed.citations


def answer(
    run_dir: Path,
    question: str,
    *,
    model: str = "gemini-2.5-flash",
    api_key: Optional[str] = None,
    temperature: float = 0.1,
    history: Optional[List[Dict[str, str]]] = None,
    conversation_id: str = "default",
    dry_run: bool = False,
    log: bool = True,
) -> Dict[str, Any]:
    run_dir = Path(run_dir)
    briefing = load_briefing(run_dir)
    messages, citations = build_messages(briefing, question, history or [])

    if dry_run or not has_llm_credentials(model, api_key):
        text = (
            "[dry-run / no API key set — set --api-key or "
            f"{api_key_env_hint(model)}] Would answer using sources: {', '.join(citations) or 'run header'}."
        )
        result = {"answer": text, "citations": citations, "model": model, "dry_run": True}
    else:
        llm = create_interpretation_llm(model, api_key=api_key, temperature=temperature)
        lc_messages = [(m["role"] if m["role"] != "system" else "system", m["content"]) for m in messages]
        # langchain chat models accept (role, content) tuples for system/human/ai roles;
        # map our roles to the ones langchain expects.
        role_map = {"system": "system", "user": "human", "assistant": "ai"}
        lc_messages = [(role_map.get(r, "human"), c) for r, c in lc_messages]
        resp = llm.invoke(lc_messages)
        text = getattr(resp, "content", str(resp))
        result = {"answer": text, "citations": citations, "model": model, "dry_run": False}

    if log:
        _append_log(run_dir, question, result, briefing, conversation_id)
    return result


def _append_log(
    run_dir: Path,
    question: str,
    result: Dict[str, Any],
    briefing: Dict[str, Any],
    conversation_id: str,
) -> None:
    entry = {
        "timestamp": _now_iso(),
        "conversation_id": conversation_id or "default",
        "question": question,
        "answer": result.get("answer"),
        "citations": result.get("citations"),
        "model": result.get("model"),
        "dry_run": result.get("dry_run"),
        "briefing_generated_at": briefing.get("generated_at"),
    }
    p = run_artifact_path(Path(run_dir), "odd_chat_log", write=True)
    with p.open("a", encoding="utf-8") as f:
        f.write(json.dumps(entry) + "\n")
