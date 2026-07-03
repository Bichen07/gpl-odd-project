from __future__ import annotations

import json
from dataclasses import asdict, is_dataclass
from datetime import datetime, timezone
from pathlib import Path
from typing import Any

from .paths import artifacts_root


def _to_jsonable(data: Any) -> Any:
    if is_dataclass(data):
        return asdict(data)
    if isinstance(data, dict):
        return {str(k): _to_jsonable(v) for k, v in data.items()}
    if isinstance(data, list):
        return [_to_jsonable(v) for v in data]
    if isinstance(data, tuple):
        return [_to_jsonable(v) for v in data]
    if isinstance(data, (str, int, float, bool)) or data is None:
        return data
    return str(data)


class PipelineCapture:
    def __init__(self, source_file: str | Path) -> None:
        self.source_file = Path(source_file).resolve()
        self.root = artifacts_root(self.source_file)

    def _run_dir(self, stage: str, run_id: str) -> Path:
        d = self.root / stage / run_id
        d.mkdir(parents=True, exist_ok=True)
        return d

    def record(self, stage: str, run_id: str, event: str, payload: Any) -> Path:
        now = datetime.now(timezone.utc).isoformat()
        safe_event = event.replace("/", "_")
        out = self._run_dir(stage, run_id) / f"{safe_event}.json"
        envelope = {
            "run_id": run_id,
            "stage": stage,
            "event": event,
            "created_at": now,
            "payload": _to_jsonable(payload),
        }
        out.write_text(json.dumps(envelope, indent=2), encoding="utf-8")
        self._update_summary(stage, run_id)
        return out

    def _update_summary(self, stage: str, run_id: str) -> None:
        d = self._run_dir(stage, run_id)
        files = sorted([p.name for p in d.glob("*.json") if p.is_file()])
        summary = d / "summary.txt"
        lines = [
            f"run_id: {run_id}",
            f"stage: {stage}",
            f"artifact_count: {len(files)}",
            "files:",
            *[f"- {f}" for f in files],
        ]
        summary.write_text("\n".join(lines) + "\n", encoding="utf-8")
