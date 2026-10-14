"""S5 (part 2/2) — ODD Q&A over one run.

Every turn sends a short index from ``odd_chat_briefing.json``. The model may
answer from that index, or reply with one JSON request for a medoid YAML, one
pair ``contrast.yaml``, or one trial row from ``odd_all_trials.json``. Python
reads that file and the model answers. This is the closed tool list from Yao
et al. (ReAct, ICLR 2023), not a search over a corpus.

Rules enforced here:
  - Numbers come from the index or the one returned file.
  - If the briefing marks something ``missing``, the answer must say unknown
    and repeat the step on that line.
  - A trial id, cluster, or pair folder that is not in this run returns
    "not available", and the answer must say it does not know.
  - Every answer carries ``citations`` and, when a file was opened, ``requested``.
  - Dialog memory is the last K turns only (default 8). The fetched file is
    not kept for the next question.
"""

from __future__ import annotations

import json
import re
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any, Dict, List, Optional, Tuple

import yaml

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
    """Keyword slice. ``answer`` does not call this; it sends the index instead."""
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
        citations = ["boundary export", "parameter rules"]
    elif intent == "why_clustering":
        ctx["clusters"] = [
            {k: c.get(k) for k in ("id", "label", "neighbor_behavior")} for c in clusters
        ]
        ctx["pairs"] = [{k: p.get(k) for k in ("folder", "clusters", "behavior_similarity")} for p in pairs]
        ctx["quality"] = {"score": (briefing.get("run") or {}).get("quality_score")}
        citations = [f"pair {p['folder']}" for p in pairs] + ["clustering score"]
    else:
        ctx["clusters"] = [{k: c.get(k) for k in ("id", "label", "collision_rate")} for c in clusters]
        citations = ["run header"]

    return RoutedContext(ctx, citations)


_INDEX_CLUSTER_KEYS = (
    "id",
    "label",
    "n",
    "collision_rate",
    "medoid_trial_id",
    "medoid_resolution",
    "medoid_outcome",
    "parameter_ranges",
)
_INDEX_PAIR_KEYS = ("folder", "clusters")
_INDEX_RULE_KEYS = ("id", "predicate", "predicted", "support", "precision")
_PAIR_FOLDER = re.compile(r"^c\d+-c\d+$")
_TRIAL_ID = re.compile(r"^\d+$")


def build_index(briefing: Dict[str, Any]) -> Dict[str, Any]:
    """Short catalog. Captions and pair explanations stay in the files."""
    clusters = briefing.get("clusters") or []
    pairs = briefing.get("pairs") or []
    rules = briefing.get("rules") or []
    return {
        "run": briefing.get("run"),
        "missing": briefing.get("missing") or [],
        "clusters": [{k: c.get(k) for k in _INDEX_CLUSTER_KEYS} for c in clusters],
        "pairs": [{k: p.get(k) for k in _INDEX_PAIR_KEYS} for p in pairs],
        "rules": [{k: r.get(k) for k in _INDEX_RULE_KEYS} for r in rules],
        "boundary": _boundary_index(briefing.get("boundary") or {}),
    }


def _boundary_index(boundary: Dict[str, Any]) -> Dict[str, Any]:
    """kNN counts. The collision count is a boundary size, not a crash total."""
    if not boundary:
        return {}
    return {
        "kNN": boundary.get("kNN"),
        "collision_boundary_trials": boundary.get("n_collision"),
        "cluster_boundary_trials": boundary.get("n_cluster"),
        "n_trials_considered": boundary.get("n_trials_considered"),
        "n_trials_without_cluster_label": boundary.get("n_trials_without_cluster_label"),
        "note": "collision_boundary_trials is the kNN collision-boundary count, not the number of collisions.",
    }


def _trim_history(history: List[Dict[str, str]], max_history_turns: int) -> List[Dict[str, str]]:
    # History is stored as alternating user/assistant messages, so K dialog
    # turns correspond to up to 2*K message entries.
    return history[-(max_history_turns * 2):] if history else []


def build_messages(
    briefing: Dict[str, Any],
    question: str,
    history: List[Dict[str, str]],
    max_history_turns: int = 8,
    returned_file: Optional[str] = None,
) -> List[Dict[str, str]]:
    """Index on every turn. The returned file is attached only for the second call."""
    index = build_index(briefing)
    messages: List[Dict[str, str]] = [{"role": "system", "content": SYSTEM_PROMPT}]
    messages.append(
        {
            "role": "system",
            "content": "INDEX (cluster id, name, size, collision rate, medoid trial id, "
            "resolution, outcome, parameter ranges, pair folders, sampled rules, "
            "kNN boundary counts, and missing):\n" + json.dumps(index, indent=2),
        }
    )
    if returned_file is None:
        messages.append(
            {
                "role": "system",
                "content": "If the INDEX is enough, answer now. If a fact is missing, reply with "
                "only the JSON object from rule 7. A sentence that says you need more "
                "information is wrong. A similarity question is the pair JSON. A question "
                "about what makes Ego fail is the summary JSON.",
            }
        )
    else:
        messages.append(
            {
                "role": "system",
                "content": "A file has already been returned below. Answer in prose. Do not reply with JSON. "
                "Use the word measurement for brake_t, ttc, peak_t, impact time, and critical_divergence.at. "
                "Use the word model for a timeline description, a motive_summary, or behavior_similarity. "
                "Example: Measurement: brake_t 7.7 s and ttc 2.22 s. The medoid model's sentence says the brake is for CuttingIn. "
                "Do not use the word deterministic.",
            }
        )
    messages.extend(_trim_history(history, max_history_turns))
    messages.append({"role": "user", "content": question})
    if returned_file is not None:
        messages.append({"role": "user", "content": returned_file})
    return messages


def _drop_embedded_request(text: str) -> str:
    """A prose answer should not also show the JSON request."""
    cleaned = re.sub(r"\{[^{}]*\"need\"\s*:[^{}]*\}", "", text or "").strip()
    return cleaned or (text or "").strip()


def parse_request(text: str) -> Optional[Dict[str, Any]]:
    """A request is a message that is only one JSON object with a ``need`` key."""
    raw = (text or "").strip()
    raw = re.sub(r"^```(?:json)?\s*", "", raw, flags=re.IGNORECASE)
    raw = re.sub(r"\s*```$", "", raw).strip()
    if not raw.startswith("{") or not raw.endswith("}"):
        return None
    try:
        obj = json.loads(raw)
    except json.JSONDecodeError:
        return None
    if not isinstance(obj, dict) or "need" not in obj:
        return None
    return obj


def _not_available(kind: str) -> Tuple[str, str, bool]:
    return "not available", "not available", False


def fetch_request(run_dir: Path, request: Dict[str, Any]) -> Tuple[Any, str, bool]:
    """Read one file. An unknown id returns ``not available`` and does not guess."""
    run_dir = Path(run_dir)
    need = request.get("need")
    if need == "medoid":
        try:
            cluster_id = int(request.get("cluster"))
        except (TypeError, ValueError):
            return _not_available("medoid")
        path = run_dir / f"cluster{cluster_id}" / "output" / "medoid_trial.yaml"
        if not path.is_file():
            return _not_available("medoid")
        doc = yaml.safe_load(path.read_text(encoding="utf-8")) or {}
        metrics = doc.get("conflict_metrics") or {}
        body = {
            "cluster": cluster_id,
            "measurements": {
                "trial_id": doc.get("trial_id") or metrics.get("trial_id"),
                "brake_t": metrics.get("brake_t"),
                "ttc": metrics.get("ttc"),
                "peak_t": metrics.get("peak_t"),
                "collided": metrics.get("collided"),
                "outcome": doc.get("outcome"),
                "collision_detail": doc.get("collision_detail"),
            },
            "medoid_model_sentences": {
                "agent_interactions": doc.get("agent_interactions"),
                "decision_timeline": doc.get("decision_timeline"),
                "motive_summary": doc.get("motive_summary"),
            },
        }
        return body, f"medoid cluster{cluster_id}", True
    if need == "pair":
        folder = str(request.get("folder") or "")
        if not _PAIR_FOLDER.match(folder):
            return _not_available("pair")
        path = run_dir / "parameter_space_pairs" / folder / "output" / "contrast.yaml"
        if not path.is_file():
            return _not_available("pair")
        doc = yaml.safe_load(path.read_text(encoding="utf-8")) or {}
        left = doc.get("left") or {}
        right = doc.get("right") or {}
        divergence = doc.get("critical_divergence") or {}
        body = {
            "folder": folder,
            "measurements": {
                "param_dist": doc.get("param_dist"),
                "critical_divergence_at": divergence.get("at"),
                "left_outcome": left.get("outcome"),
                "right_outcome": right.get("outcome"),
            },
            "model_label": {
                "behavior_similarity": doc.get("behavior_similarity"),
                "behavior_similarity_reason": doc.get("behavior_similarity_reason"),
                "left_resolution": left.get("resolution"),
                "right_resolution": right.get("resolution"),
            },
        }
        return body, f"pair {folder}", True
    if need == "trial":
        trial_id = str(request.get("trial_id") or "")
        if not _TRIAL_ID.match(trial_id):
            return _not_available("trial")
        path = run_artifact_path(run_dir, "odd_all_trials")
        if not path.is_file():
            return _not_available("trial")
        doc = json.loads(path.read_text(encoding="utf-8"))
        for row in doc.get("trials") or []:
            if str(row.get("trial_id")) == trial_id:
                return (
                    {
                        "trial_id": str(row.get("trial_id")),
                        "parameters": row.get("parameters"),
                        "passed": row.get("passed"),
                        "cluster_label": row.get("cluster_label"),
                    },
                    f"trial {trial_id}",
                    True,
                )
        return _not_available("trial")
    if need == "summary":
        return _fetch_summary(run_dir, request)
    if need == "bev":
        return _fetch_bev(run_dir, request)
    return _not_available("unknown")


def _cluster_id_list(request: Dict[str, Any]) -> List[int]:
    raw = request.get("clusters")
    if raw is None and request.get("cluster") is not None:
        raw = [request.get("cluster")]
    if isinstance(raw, int):
        raw = [raw]
    ids: List[int] = []
    for item in raw or []:
        try:
            ids.append(int(item))
        except (TypeError, ValueError):
            continue
    return ids


def _collision_rates(run_dir: Path) -> Dict[int, Any]:
    try:
        briefing = load_briefing(run_dir)
    except (OSError, json.JSONDecodeError, FileNotFoundError):
        return {}
    rates: Dict[int, Any] = {}
    for cluster in briefing.get("clusters") or []:
        try:
            rates[int(cluster.get("id"))] = cluster.get("collision_rate")
        except (TypeError, ValueError):
            continue
    return rates


def _medoid_collision_end(run_dir: Path, cluster_id: int) -> Optional[Dict[str, Any]]:
    path = run_dir / f"cluster{cluster_id}" / "output" / "medoid_trial.yaml"
    if not path.is_file():
        return None
    doc = yaml.safe_load(path.read_text(encoding="utf-8")) or {}
    metrics = doc.get("conflict_metrics") or {}
    return {
        "trial_id": doc.get("trial_id") or metrics.get("trial_id"),
        "brake_t": metrics.get("brake_t"),
        "peak_t": metrics.get("peak_t"),
        "ttc": metrics.get("ttc"),
        "outcome": doc.get("outcome"),
        "collision_detail": doc.get("collision_detail"),
    }


def _fetch_summary(run_dir: Path, request: Dict[str, Any]) -> Tuple[Any, str, bool]:
    cluster_ids = _cluster_id_list(request)
    if not cluster_ids:
        return _not_available("summary")
    rates = _collision_rates(run_dir)
    cards: List[Dict[str, Any]] = []
    for cluster_id in cluster_ids:
        path = run_dir / f"cluster{cluster_id}" / "output" / "cluster_summary.yaml"
        if not path.is_file():
            continue
        doc = yaml.safe_load(path.read_text(encoding="utf-8")) or {}
        card: Dict[str, Any] = {
            "cluster": cluster_id,
            "label": doc.get("label"),
            "caption": doc.get("caption"),
            "consistency_note": doc.get("consistency_note"),
            "risk_level": doc.get("risk_level"),
            "neighbor_comparison": doc.get("neighbor_comparison"),
        }
        rate = rates.get(cluster_id)
        try:
            full_collision = float(rate) >= 100
        except (TypeError, ValueError):
            full_collision = False
        if full_collision:
            end = _medoid_collision_end(run_dir, cluster_id)
            if end:
                card["collision_end"] = end
        cards.append(card)
    if not cards:
        return _not_available("summary")
    joined = ", ".join(str(card["cluster"]) for card in cards)
    return {"clusters": cards}, f"summary {joined}", True


def _fetch_bev(run_dir: Path, request: Dict[str, Any]) -> Tuple[Any, str, bool]:
    try:
        cluster_id = int(request.get("cluster"))
    except (TypeError, ValueError):
        return _not_available("bev")
    path = run_dir / f"cluster{cluster_id}" / "processed" / "snapshots" / "llm_snapshots.json"
    if not path.is_file():
        return _not_available("bev")
    doc = json.loads(path.read_text(encoding="utf-8"))
    frames = []
    for snap in doc.get("snapshots") or []:
        if not isinstance(snap, dict):
            continue
        frames.append(
            {
                "t": snap.get("t"),
                "label": snap.get("label"),
                "d": snap.get("d"),
                "ttc": snap.get("ttc"),
                "v_ego": snap.get("v_ego"),
            }
        )
    if not frames:
        return _not_available("bev")
    return (
        {
            "cluster": cluster_id,
            "note": "BEV frame table. No image is stored for this run.",
            "frames": frames,
        },
        f"bev cluster{cluster_id}",
        True,
    )


def _returned_file_text(body: Any, ok: bool) -> str:
    if not ok:
        return (
            "RETURNED FILE: not available. Say you don't know. Do not guess a value."
        )
    return "RETURNED FILE (the only extra source for this turn):\n" + json.dumps(body, indent=2)


def _normalize_request(request: Dict[str, Any]) -> Dict[str, Any]:
    need = request.get("need")
    if need == "medoid":
        try:
            cluster_id = int(request.get("cluster"))
        except (TypeError, ValueError):
            cluster_id = request.get("cluster")
        return {"need": "medoid", "cluster": cluster_id}
    if need == "pair":
        return {"need": "pair", "folder": str(request.get("folder") or "")}
    if need == "trial":
        return {"need": "trial", "trial_id": str(request.get("trial_id") or "")}
    if need == "summary":
        return {"need": "summary", "clusters": _cluster_id_list(request)}
    if need == "bev":
        try:
            cluster_id = int(request.get("cluster"))
        except (TypeError, ValueError):
            cluster_id = request.get("cluster")
        return {"need": "bev", "cluster": cluster_id}
    return {"need": str(need or "")}


def _asked_and_sent(requested: Dict[str, Any], body: Any, ok: bool) -> Tuple[str, str]:
    need = requested.get("need")
    if need == "medoid":
        cluster_id = requested.get("cluster")
        asked = f"asked: medoid cluster {cluster_id}"
        sent = (
            f"sent: medoid of cluster {cluster_id} — measurements, medoid model sentences"
            if ok
            else "sent: not available"
        )
        return asked, sent
    if need == "pair":
        folder = requested.get("folder")
        asked = f"asked: pair {folder}"
        sent = (
            f"sent: pair {folder} — measurements, model label"
            if ok
            else "sent: not available"
        )
        return asked, sent
    if need == "trial":
        trial_id = requested.get("trial_id")
        asked = f"asked: trial {trial_id}"
        sent = f"sent: trial {trial_id}" if ok else "sent: not available"
        return asked, sent
    if need == "summary":
        clusters = requested.get("clusters") or []
        joined = ", ".join(str(item) for item in clusters)
        asked = f"asked: summary clusters {joined}"
        has_end = False
        if isinstance(body, dict):
            has_end = any(
                isinstance(card, dict) and card.get("collision_end")
                for card in (body.get("clusters") or [])
            )
        if not ok:
            sent = "sent: not available"
        elif has_end:
            sent = f"sent: summary of cluster {joined}, plus each collision end"
        else:
            sent = f"sent: summary of cluster {joined}"
        return asked, sent
    if need == "bev":
        cluster_id = requested.get("cluster")
        asked = f"asked: bev cluster {cluster_id}"
        sent = (
            f"sent: BEV frame table of cluster {cluster_id}"
            if ok
            else "sent: not available"
        )
        return asked, sent
    return f"asked: {need}", "sent: not available"


def _invoke(llm: Any, messages: List[Dict[str, str]]) -> str:
    role_map = {"system": "system", "user": "human", "assistant": "ai"}
    lc_messages = [(role_map.get(m["role"], "human"), m["content"]) for m in messages]
    resp = llm.invoke(lc_messages)
    content = getattr(resp, "content", str(resp))
    if isinstance(content, list):
        parts = []
        for block in content:
            if isinstance(block, str):
                parts.append(block)
            elif isinstance(block, dict):
                parts.append(str(block.get("text") or ""))
            else:
                parts.append(str(getattr(block, "text", "")))
        return "".join(parts).strip()
    return str(content).strip()


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
    history = history or []
    messages = build_messages(briefing, question, history)

    if dry_run or not has_llm_credentials(model, api_key):
        text = (
            "[dry-run / no API key set — set --api-key or "
            f"{api_key_env_hint(model)}] Would answer from the index, "
            "or from one requested medoid, pair, or trial file."
        )
        result = {
            "answer": text,
            "citations": ["index"],
            "requested": None,
            "asked": None,
            "sent": None,
            "model": model,
            "dry_run": True,
        }
    else:
        llm = create_interpretation_llm(model, api_key=api_key, temperature=temperature)
        first = _invoke(llm, messages)
        request = parse_request(first)
        requested = None
        asked = None
        sent = None
        citations = ["index"]
        if request is not None:
            requested = _normalize_request(request)
            body, citation, ok = fetch_request(run_dir, requested)
            asked, sent = _asked_and_sent(requested, body, ok)
            citations = [citation]
            follow = build_messages(
                briefing,
                question,
                history,
                returned_file=_returned_file_text(body, ok),
            )
            text = _invoke(llm, follow)
            if parse_request(text) is not None:
                if not ok:
                    asked = (
                        requested.get("trial_id")
                        or requested.get("folder")
                        or requested.get("cluster")
                    )
                    text = f"I don't know. {asked} is not in this run."
                else:
                    follow.append(
                        {
                            "role": "user",
                            "content": "Write the answer in sentences. Do not output JSON.",
                        }
                    )
                    text = _invoke(llm, follow)
        else:
            text = first
        text = _drop_embedded_request(text)
        result = {
            "answer": text,
            "citations": citations,
            "requested": requested,
            "asked": asked,
            "sent": sent,
            "model": model,
            "dry_run": False,
        }

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
        "requested": result.get("requested"),
        "asked": result.get("asked"),
        "sent": result.get("sent"),
        "model": result.get("model"),
        "dry_run": result.get("dry_run"),
        "briefing_generated_at": briefing.get("generated_at"),
    }
    p = run_artifact_path(Path(run_dir), "odd_chat_log", write=True)
    with p.open("a", encoding="utf-8") as f:
        f.write(json.dumps(entry) + "\n")
