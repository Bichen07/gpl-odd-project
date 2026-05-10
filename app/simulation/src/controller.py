"""
Mission Control HTTP + WebSocket controller.

Endpoints
---------
POST  /simulation/run            start a new simulation run
POST  /simulation/stop           stop the current run
GET   /simulation/status/{id}    get current status snapshot
GET   /simulation/status         get status of all active runs
GET   /simulation/logs/{id}      get buffered logs for a run
GET   /simulation/health         service health check
WS    /simulation/stream/{id}    real-time WebSocket stream
"""
from __future__ import annotations

import asyncio
import json
import logging
import os
from typing import Any

from litestar import Controller, WebSocket, get, post, websocket
from litestar.datastructures import State
from litestar.exceptions import HTTPException

from data_validator import DataValidator
from docker_manager import DockerManager
from models import RunRequest, SimStatus
from orchestrator import SimulationOrchestrator
from ros_monitor import RosMonitor

log = logging.getLogger("mission_control.controller")

# In-memory registry: run_id → orchestrator
_RUNS: dict[str, SimulationOrchestrator] = {}
# WebSocket registry: run_id → list of connected sockets
_WS_CLIENTS: dict[str, list[WebSocket]] = {}


# ── Helpers ───────────────────────────────────────────────────────────────────

async def _broadcast_to_ws(run_id: str, msg_dict: dict) -> None:
    """Send *msg_dict* as JSON to all connected WebSocket clients for *run_id*."""
    dead: list[WebSocket] = []
    for ws in _WS_CLIENTS.get(run_id, []):
        try:
            await ws.send_data(json.dumps(msg_dict))
        except Exception:
            dead.append(ws)
    for ws in dead:
        _WS_CLIENTS[run_id].remove(ws)


def _make_status_cb(run_id: str):
    """Return an async callable that broadcasts a WsMessage to all WebSocket clients."""
    async def _cb(msg) -> None:
        await _broadcast_to_ws(run_id, msg.to_dict())
    return _cb


# ── Controller ────────────────────────────────────────────────────────────────

class SimulationController(Controller):
    path = "/simulation"

    # ── Health ────────────────────────────────────────────────────────────

    @get("/health")
    async def health(self) -> dict[str, Any]:
        """Check availability of all dependent services."""
        docker = DockerManager()
        ros = RosMonitor(docker)
        validator = DataValidator()

        payload_ok = False
        try:
            import requests as _req
            r = _req.get(
                (os.getenv("PAYLOAD_API", "http://localhost:3020/api") + "/batches"),
                headers={"Authorization": f"users API-Key {os.getenv('PAYLOAD_API_KEY','')}"},
                timeout=4, verify=False,
            )
            payload_ok = r.status_code < 500
        except Exception:
            pass

        sampling_ok = False
        try:
            import requests as _req
            r = _req.get(os.getenv("SAMPLING_API", "http://localhost:9009") + "/health", timeout=3)
            sampling_ok = r.status_code < 500
        except Exception:
            pass

        return {
            "status": "ok",
            "services": {
                "payload": {"ok": payload_ok},
                "sampling": {"ok": sampling_ok},
                "docker": {
                    "available": docker.is_docker_available,
                    "container_status": docker.get_status(),
                },
                "ros": ros.health_check(),
            },
            "active_runs": len(_RUNS),
        }

    # ── Run ───────────────────────────────────────────────────────────────

    @post("/run")
    async def run(self, data: RunRequest) -> dict[str, Any]:
        """Start a new simulation run."""
        orch = SimulationOrchestrator(
            batch_id=data.batch_id,
            scenario_id=data.scenario_id,
            n_trials=data.n_trials,
            retry_failed=data.retry_failed,
            max_trial_duration_seconds=data.max_trial_duration_seconds,
            status_callback=_make_status_cb("__placeholder__"),
        )
        # Wire the real run_id into the callback
        run_id = orch.run_id
        orch._status_cb = _make_status_cb(run_id)
        _RUNS[run_id] = orch
        _WS_CLIENTS[run_id] = []

        # Start orchestration in the background
        asyncio.create_task(orch.run())
        log.info("Started run %s (batch=%d scenario=%d n=%d)",
                 run_id, data.batch_id, data.scenario_id, data.n_trials)

        return {
            "run_id": run_id,
            "status": SimStatus.STARTING.value,
            "websocket_url": f"/simulation/stream/{run_id}",
        }

    # ── Stop ──────────────────────────────────────────────────────────────

    @post("/stop/{run_id:str}")
    async def stop(self, run_id: str) -> dict[str, str]:
        """Request graceful stop of a running simulation."""
        orch = _RUNS.get(run_id)
        if orch is None:
            raise HTTPException(status_code=404, detail=f"Run '{run_id}' not found.")
        orch.stop()
        return {"run_id": run_id, "status": "stopping"}

    # ── Status ────────────────────────────────────────────────────────────

    @get("/status")
    async def status_all(self) -> list[dict[str, Any]]:
        """Return snapshots for all active runs."""
        return [orch.snapshot() for orch in _RUNS.values()]

    @get("/status/{run_id:str}")
    async def status(self, run_id: str) -> dict[str, Any]:
        """Return a detailed status snapshot for a specific run."""
        orch = _RUNS.get(run_id)
        if orch is None:
            raise HTTPException(status_code=404, detail=f"Run '{run_id}' not found.")
        return orch.snapshot()

    # ── Logs ──────────────────────────────────────────────────────────────

    @get("/logs/{run_id:str}")
    async def logs(self, run_id: str) -> dict[str, Any]:
        """Return buffered log lines for a run."""
        orch = _RUNS.get(run_id)
        if orch is None:
            raise HTTPException(status_code=404, detail=f"Run '{run_id}' not found.")
        return {"run_id": run_id, "logs": orch.logs}

    # ── Data quality ──────────────────────────────────────────────────────

    @get("/data-quality/{batch_id:int}")
    async def data_quality(self, batch_id: int) -> dict[str, Any]:
        """
        Compare local CSV count vs Payload trial count for a batch.
        Useful for the Dashboard Data Quality panel.
        """
        validator = DataValidator()
        return validator.summary(batch_id)

    # ── WebSocket ─────────────────────────────────────────────────────────

    @websocket("/stream/{run_id:str}")
    async def stream(self, socket: WebSocket, run_id: str) -> None:
        """
        WebSocket endpoint that streams real-time status updates.

        Client connects here and receives JSON messages until the
        simulation completes or the connection is closed.
        """
        await socket.accept()

        # Register client
        if run_id not in _WS_CLIENTS:
            _WS_CLIENTS[run_id] = []
        _WS_CLIENTS[run_id].append(socket)

        # Send current snapshot immediately on connect
        orch = _RUNS.get(run_id)
        if orch:
            await socket.send_data(json.dumps({
                "type": "status_update",
                "payload": orch.snapshot(),
            }))
        else:
            await socket.send_data(json.dumps({
                "type": "error",
                "payload": {"message": f"Run '{run_id}' not found — it may have already finished."},
            }))

        # Keep alive — wait for client disconnect or run completion
        try:
            while True:
                orch = _RUNS.get(run_id)
                if orch and orch.status in (SimStatus.COMPLETED, SimStatus.FAILED):
                    # Send one final snapshot then close
                    await socket.send_data(json.dumps({
                        "type": "completed",
                        "payload": orch.snapshot(),
                    }))
                    break
                try:
                    msg = await asyncio.wait_for(socket.receive_data(), timeout=30)
                    if msg in (None, b"", ""):
                        break  # client closed
                except asyncio.TimeoutError:
                    # Send a keepalive ping
                    await socket.send_data(json.dumps({"type": "ping"}))
        except Exception:
            pass
        finally:
            if run_id in _WS_CLIENTS and socket in _WS_CLIENTS[run_id]:
                _WS_CLIENTS[run_id].remove(socket)
            await socket.close()
