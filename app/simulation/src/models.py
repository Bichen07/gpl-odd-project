"""
Mission Control — shared dataclasses for requests, responses, and status messages.
"""
from __future__ import annotations

from dataclasses import dataclass, field
from enum import Enum
from typing import Any


class SimStatus(str, Enum):
    IDLE = "idle"
    STARTING = "starting"
    RUNNING = "running"
    STOPPING = "stopping"
    COMPLETED = "completed"
    FAILED = "failed"


class WsMessageType(str, Enum):
    STATUS_UPDATE = "status_update"
    TRIAL_COMPLETED = "trial_completed"
    LOG = "log"
    ERROR = "error"
    COMPLETED = "completed"


# ── HTTP request bodies ──────────────────────────────────────────────────────

@dataclass
class RunRequest:
    batch_id: int
    scenario_id: int
    n_trials: int = 100
    retry_failed: bool = True
    max_trial_duration_seconds: int = 180


@dataclass
class StopRequest:
    run_id: str


# ── HTTP responses ────────────────────────────────────────────────────────────

@dataclass
class RunResponse:
    run_id: str
    status: str
    websocket_url: str


@dataclass
class ProgressInfo:
    current_trial: int
    total_trials: int
    completed: int
    failed: int
    success_rate: float


@dataclass
class TimingInfo:
    started_at: str
    elapsed_seconds: float
    eta_seconds: float | None


@dataclass
class LastTrialInfo:
    trial_index: int
    status: str
    duration_seconds: float


@dataclass
class ServiceHealth:
    payload: bool
    sampling: bool
    docker_available: bool
    container_running: bool


@dataclass
class StatusResponse:
    run_id: str
    status: str
    batch_id: int
    scenario_id: int
    progress: ProgressInfo
    timing: TimingInfo
    last_trial: LastTrialInfo | None
    errors: list[str]
    service_health: ServiceHealth


@dataclass
class HealthResponse:
    status: str
    services: dict[str, Any]
    message: str


# ── WebSocket messages (serialized as dicts) ──────────────────────────────────

@dataclass
class WsMessage:
    type: str
    payload: dict[str, Any]

    def to_dict(self) -> dict[str, Any]:
        return {"type": self.type, "payload": self.payload}
