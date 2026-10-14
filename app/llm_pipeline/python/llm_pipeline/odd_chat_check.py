"""Score ODD Q&A answers against facts copied from one saved run.

The checker calls ``odd_chat.answer`` and looks for required numbers in the
text. It does not ask a second model to judge. Turns are appended to
``conversation_log/odd_chat_log.jsonl`` so the dashboard can open them.
"""

from __future__ import annotations

import json
import os
import re
from pathlib import Path
from typing import Any, Dict, List, Optional

from .odd_chat import answer
from .paths import find_repo_root, run_artifact_path


def _now_iso() -> str:
    from datetime import datetime, timezone

    return datetime.now(timezone.utc).isoformat().replace("+00:00", "Z")


def _ensure_api_key(start: Path) -> None:
    """Load the analyzer env file when the key is not already in the process."""
    if os.getenv("GOOGLE_API_KEY") or os.getenv("OPENAI_API_KEY"):
        return
    env_path = find_repo_root(start) / "app" / "analyzer" / ".env"
    if not env_path.is_file():
        return
    for line in env_path.read_text(encoding="utf-8").splitlines():
        stripped = line.strip()
        if not stripped or stripped.startswith("#") or "=" not in stripped:
            continue
        key, value = stripped.split("=", 1)
        key = key.strip()
        if key in ("GOOGLE_API_KEY", "OPENAI_API_KEY") and not os.getenv(key):
            os.environ[key] = value.strip().strip('"').strip("'")


def _numbers_in(text: str) -> List[float]:
    found: List[float] = []
    cleaned = text.replace(",", "")
    for match in re.finditer(r"\d+(?:\.\d+)?%?", cleaned):
        raw = match.group(0)
        if raw.endswith("%"):
            found.append(float(raw[:-1]))
            found.append(float(raw[:-1]) / 100.0)
        else:
            found.append(float(raw))
    return found


def _number_present(text: str, value: float, places: int) -> bool:
    target = round(float(value), places)
    for number in _numbers_in(text):
        if round(number, places) == target:
            return True
    return False


def _request_matches(actual: Optional[Dict[str, Any]], expected: Optional[Dict[str, Any]]) -> bool:
    if expected is None:
        return actual is None
    if not actual:
        return False
    if actual.get("need") != expected.get("need"):
        return False
    for key, value in expected.items():
        if key == "need":
            continue
        if key == "clusters":
            try:
                actual_ids = sorted(int(item) for item in (actual.get(key) or []))
                expected_ids = sorted(int(item) for item in value)
            except (TypeError, ValueError):
                return False
            if actual_ids != expected_ids:
                return False
            continue
        if str(actual.get(key)) != str(value):
            return False
    return True


def score_answer(spec: Dict[str, Any], result: Dict[str, Any]) -> List[str]:
    """Return a list of failure reasons. Empty means the answer passed."""
    text = str(result.get("answer") or "")
    lowered = text.lower()
    failures: List[str] = []

    for phrase in spec.get("must_include") or []:
        if str(phrase).lower() not in lowered:
            failures.append(f"missing {phrase}")

    alternatives = spec.get("must_include_any") or []
    if alternatives and not any(str(phrase).lower() in lowered for phrase in alternatives):
        failures.append("missing a don't-know phrase")

    for item in spec.get("numbers") or []:
        value = float(item["value"])
        places = int(item["places"])
        if not _number_present(text, value, places):
            failures.append(f"missing number {value} (rounded to {places} places)")

    for phrase in spec.get("must_not") or []:
        if re.search(rf"\b{re.escape(str(phrase))}\b", text, flags=re.IGNORECASE):
            failures.append(f"forbidden phrase {phrase}")

    if spec.get("forbid_decimal") and re.search(r"\d+\.\d+", text):
        failures.append("answer contains a decimal")

    id_rule = spec.get("trial_ids_at_least") or {}
    if id_rule:
        present = [trial_id for trial_id in id_rule.get("ids") or [] if trial_id in text]
        needed = int(id_rule.get("count") or 2)
        if len(present) < needed:
            failures.append(f"named {len(present)} medoid trial ids, need {needed}")

    expected = spec.get("expect_request", None)
    if not _request_matches(result.get("requested"), expected):
        if expected is None:
            failures.append(f"opened a file: {result.get('requested')}")
        else:
            failures.append(f"opened {result.get('requested')}, expected {expected}")

    return failures


def _strip_conversation(run_dir: Path, conversation_id: str) -> None:
    path = run_artifact_path(run_dir, "odd_chat_log")
    if not path.is_file():
        return
    kept: List[str] = []
    for line in path.read_text(encoding="utf-8").splitlines():
        if not line.strip():
            continue
        try:
            obj = json.loads(line)
        except json.JSONDecodeError:
            kept.append(line)
            continue
        if obj.get("conversation_id") != conversation_id:
            kept.append(line)
    path.write_text(("\n".join(kept) + "\n") if kept else "", encoding="utf-8")


def _write_title(run_dir: Path, conversation_id: str, title: str) -> None:
    log_path = run_artifact_path(run_dir, "odd_chat_log", write=True)
    titles_path = log_path.parent / "odd_chat_titles.json"
    titles: Dict[str, str] = {}
    if titles_path.is_file():
        try:
            loaded = json.loads(titles_path.read_text(encoding="utf-8"))
            if isinstance(loaded, dict):
                titles = {str(k): str(v) for k, v in loaded.items() if isinstance(v, str)}
        except json.JSONDecodeError:
            titles = {}
    titles[conversation_id] = title
    titles_path.write_text(json.dumps(titles, indent=2) + "\n", encoding="utf-8")


def default_questions_path() -> Path:
    return find_repo_root(Path(__file__)) / "app" / "llm_pipeline" / "qa_checks" / "s05947_questions.json"


def run_check(
    run_dir: Path,
    questions_path: Path,
    *,
    model: str = "gemini-2.5-flash",
    api_key: Optional[str] = None,
) -> Dict[str, Any]:
    run_dir = Path(run_dir)
    _ensure_api_key(run_dir)
    spec = json.loads(Path(questions_path).read_text(encoding="utf-8"))
    conversation_id = str(spec.get("conversation_id") or "qa-check")
    title = str(spec.get("title") or conversation_id)
    _strip_conversation(run_dir, conversation_id)
    _write_title(run_dir, conversation_id, title)

    rows: List[Dict[str, Any]] = []
    for item in spec.get("questions") or []:
        result = answer(
            run_dir,
            item["question"],
            model=model,
            api_key=api_key,
            history=[],
            conversation_id=conversation_id,
            log=True,
        )
        failures = score_answer(item, result)
        row = {
            "id": item.get("id"),
            "question": item.get("question"),
            "passed": not failures,
            "failures": failures,
            "requested": result.get("requested"),
            "citations": result.get("citations"),
            "answer": result.get("answer"),
        }
        rows.append(row)
        status = "PASS" if row["passed"] else "FAIL"
        detail = "" if row["passed"] else " — " + "; ".join(failures)
        print(f"{status} {row['id']}{detail}")

    report = {
        "generated_at": _now_iso(),
        "conversation_id": conversation_id,
        "title": title,
        "run_dir": str(run_dir),
        "model": model,
        "passed": sum(1 for row in rows if row["passed"]),
        "failed": sum(1 for row in rows if not row["passed"]),
        "questions": rows,
    }
    out_path = run_dir / "odd" / "output" / "odd_chat_check.json"
    out_path.parent.mkdir(parents=True, exist_ok=True)
    out_path.write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
    print(f"{report['passed']}/{report['passed'] + report['failed']} passed — {out_path}")
    return report
