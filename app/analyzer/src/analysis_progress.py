"""In-memory progress for the current trajectory_analysis run (polled by Dashboard)."""
from __future__ import annotations

import threading
import time
from typing import Any, Dict, Optional

_lock = threading.Lock()
_state: Dict[str, Any] = {
    "active": False,
    "batchIds": [],
    "phase": "idle",
    "current": 0,
    "total": 0,
    "message": "",
    "startedAt": None,
    "updatedAt": None,
}


def begin_run(batch_ids: list, total_tasks: int) -> None:
    with _lock:
        now = time.time()
        _state.update(
            {
                "active": True,
                "batchIds": batch_ids,
                "phase": "starting",
                "current": 0,
                "total": max(total_tasks, 1),
                "message": "Starting analysis…",
                "startedAt": now,
                "updatedAt": now,
            }
        )


def update(
    phase: str,
    current: int,
    total: int,
    message: str = "",
) -> None:
    with _lock:
        if not _state["active"]:
            return
        _state.update(
            {
                "phase": phase,
                "current": current,
                "total": max(total, 1),
                "message": message or _state.get("message", ""),
                "updatedAt": time.time(),
            }
        )


def finish() -> None:
    with _lock:
        _state.update(
            {
                "active": False,
                "phase": "complete",
                "message": "Analysis complete",
                "updatedAt": time.time(),
            }
        )


def fail(message: str) -> None:
    with _lock:
        _state.update(
            {
                "active": False,
                "phase": "error",
                "message": message,
                "updatedAt": time.time(),
            }
        )


def snapshot() -> Dict[str, Any]:
    with _lock:
        data = dict(_state)
        total = data.get("total") or 1
        current = data.get("current") or 0
        data["percent"] = round(min(100.0, (current / total) * 100.0), 1)
        if data.get("startedAt"):
            data["elapsedSec"] = int(time.time() - data["startedAt"])
        else:
            data["elapsedSec"] = 0
        return data
