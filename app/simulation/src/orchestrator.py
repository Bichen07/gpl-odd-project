"""
SimulationOrchestrator — the central coordinator for a Mission Control run.

Lifecycle
---------
1. Ensure Docker container is running.
2. Health-check ROS master + Payload + Sampling.
3. Loop for n_trials:
   a. Get next parameters from Sampling API.
   b. Trigger esmini trial (via docker exec into ROS node).
   c. Wait for trial completion signal.
   d. Validate CSV + Payload.
   e. Auto-retry up to MAX_RETRIES if validation fails.
4. Broadcast status via WebSocket after every trial.
5. On completion, notify all connected clients.

Design notes
------------
* All external I/O is ``await``-wrapped so the event loop stays responsive.
* ``status_callback`` is an optional async callable ``(WsMessage) -> None``.
  The controller wires up the WebSocket broadcast here.
* The orchestrator is purposely decoupled from Litestar; it only uses
  asyncio primitives so it can be unit-tested standalone.
"""
from __future__ import annotations

import asyncio
import logging
import os
import time
import uuid
from datetime import datetime, timezone
from typing import Any, Awaitable, Callable, Optional

import requests

from data_validator import DataValidator
from docker_manager import DockerManager
from models import SimStatus, WsMessage, WsMessageType
from ros_monitor import RosMonitor

log = logging.getLogger("mission_control.orchestrator")

MAX_RETRIES = 3
# seconds to wait for a trial to finish before timing out
TRIAL_TIMEOUT_S = 120
# seconds between poll loops while waiting for trial completion
POLL_INTERVAL_S = 3


StatusCallback = Callable[[WsMessage], Awaitable[None]]


class SimulationOrchestrator:
    """Orchestrates a single Mission Control simulation run."""

    def __init__(
        self,
        batch_id: int,
        scenario_id: int,
        n_trials: int,
        retry_failed: bool = True,
        max_trial_duration_seconds: int = TRIAL_TIMEOUT_S,
        status_callback: Optional[StatusCallback] = None,
    ):
        self.run_id = f"mc_{uuid.uuid4().hex[:8]}"
        self.batch_id = batch_id
        self.scenario_id = scenario_id
        self.n_trials = n_trials
        self.retry_failed = retry_failed
        self.max_trial_duration_seconds = max_trial_duration_seconds
        self._status_cb = status_callback

        self.status = SimStatus.IDLE
        self.started_at: Optional[float] = None
        self.current_trial = 0
        self.completed_trials = 0
        self.failed_trials = 0
        self.errors: list[str] = []
        self.logs: list[str] = []
        self._stop_requested = False
        self._last_trial_info: dict[str, Any] = {}

        # Service clients
        self.payload_api = os.getenv("PAYLOAD_API", "http://localhost:3020/api")
        self.sampling_api = os.getenv("SAMPLING_API", "http://localhost:9009")
        self.payload_api_key = os.getenv("PAYLOAD_API_KEY", "")
        self.docker = DockerManager()
        self.ros = RosMonitor(self.docker)
        self.validator = DataValidator(
            payload_api=self.payload_api,
            payload_api_key=self.payload_api_key,
        )

    # ── Public control ────────────────────────────────────────────────────

    async def run(self) -> None:
        """Entry point — called from the controller in a background task."""
        self.started_at = time.monotonic()
        self.status = SimStatus.STARTING
        self._log("Mission Control run started", f"run_id={self.run_id}")

        try:
            # Phase 1: infrastructure
            if not await self._ensure_infrastructure():
                self.status = SimStatus.FAILED
            else:
                # Phase 2: trial loop
                self.status = SimStatus.RUNNING
                for i in range(self.n_trials):
                    if self._stop_requested:
                        self._log("Stop requested — halting after trial", i)
                        break

                    self.current_trial = i + 1
                    await self._broadcast_status_update()
                    await self._run_trial_with_retry(i)
                    await self._broadcast_status_update()

                self.status = SimStatus.COMPLETED
                self._log("Run completed", f"success={self.completed_trials} failed={self.failed_trials}")

        except Exception as exc:
            self.status = SimStatus.FAILED
            self.errors.append(str(exc))
            log.exception("Orchestrator crashed: %s", exc)

        finally:
            await self._broadcast_completion()

    def stop(self) -> None:
        self._stop_requested = True
        self.status = SimStatus.STOPPING
        self._log("Stop requested by user.")

    # ── Infrastructure setup ──────────────────────────────────────────────

    async def _ensure_infrastructure(self) -> bool:
        """Check / start Docker + ROS + service health."""

        # Docker
        if not self.docker.is_docker_available:
            msg = (
                "Docker daemon not reachable.  "
                "This machine does not have the sdc-bionic simulation image.  "
                "Run on the ITRI lab server to execute real simulations."
            )
            self.errors.append(msg)
            self._log("ERROR: " + msg)
            return False

        if not self.docker.ensure_running():
            self.errors.append(f"Failed to start container '{self.docker.container_name}'")
            return False

        self._log("Container", self.docker.container_name, "is running.")

        # Payload
        if not await self._check_payload():
            self.errors.append("Payload CMS unreachable")
            self._log("WARNING: Payload not reachable — trial metadata will not be saved online.")
            # non-fatal: simulation can continue, CSV files are local

        # Sampling
        if not await self._check_sampling():
            self.errors.append("Sampling API unreachable — cannot get next parameters")
            return False

        # Initialize Sampling for this batch
        await self._init_sampling()

        # ROS master — do NOT require it here.
        # roslaunch (called per trial in _trigger_esmini_trial) starts the ROS master
        # itself.  Checking before any trial runs will always report "not alive".
        # We check AFTER the first roslaunch via _wait_for_ros_master() in _run_one_trial.
        self._log("Infrastructure ready.")
        return True

    # ── Single trial ──────────────────────────────────────────────────────

    async def _run_trial_with_retry(self, trial_index: int) -> None:
        for attempt in range(1, MAX_RETRIES + 1 if self.retry_failed else 2):
            result = await self._run_one_trial(trial_index)
            if result["status"] == "success":
                self.completed_trials += 1
                self._last_trial_info = result
                await self._broadcast(WsMessageType.TRIAL_COMPLETED, result)
                return
            if not self.retry_failed:
                break
            self._log(f"Trial {trial_index} failed (attempt {attempt}/{MAX_RETRIES}), retrying...")
            await self._broadcast_status_update()
            await asyncio.sleep(2)

        self.failed_trials += 1
        self._last_trial_info = {"trial_index": trial_index, "status": "failed"}
        await self._broadcast(WsMessageType.ERROR, {
            "trial_index": trial_index,
            "message": f"Trial {trial_index} failed after {MAX_RETRIES} attempts",
        })

    async def _run_one_trial(self, trial_index: int) -> dict[str, Any]:
        """Run a single esmini trial.  Returns dict with status + metadata."""
        t_start = time.monotonic()

        # 1. Ask Sampling for parameters
        params = await self._get_sampling_suggestion()
        if params is None:
            return {"trial_index": trial_index, "status": "failed", "reason": "sampling_unavailable"}

        self._log(f"Trial {trial_index}: params={params}")

        # 2. Trigger esmini scenario search (via ROS inside container)
        ok = await self._trigger_esmini_trial(trial_index, params)
        if not ok:
            return {"trial_index": trial_index, "status": "failed", "reason": "trigger_failed"}

        # 2b. Wait for ROS master to come up (roslaunch just started it)
        ros_started = await self._wait_for_ros_master(timeout_s=60)
        if not ros_started:
            self._log(f"Trial {trial_index}: ROS master did not start — roslaunch may have crashed")
            return {"trial_index": trial_index, "status": "failed", "reason": "ros_start_timeout"}

        # 3. Wait for trial to finish
        finished = await self._wait_for_trial(trial_index)
        if not finished:
            return {"trial_index": trial_index, "status": "failed", "reason": "timeout"}

        # 4. Validate CSV + Payload
        validation = self.validator.validate_trial(self.batch_id, trial_index)
        if not validation["csv_exists"]:
            return {"trial_index": trial_index, "status": "failed", "reason": "csv_missing",
                    "validation": validation}

        # 5. Register with Sampling (feedback loop)
        await self._register_sampling_result(trial_index, params)

        duration = time.monotonic() - t_start
        return {
            "trial_index": trial_index,
            "status": "success",
            "duration_seconds": round(duration, 1),
            "params": params,
            "validation": validation,
        }

    # ── Service calls ─────────────────────────────────────────────────────

    async def _check_payload(self) -> bool:
        try:
            resp = await asyncio.get_event_loop().run_in_executor(
                None,
                lambda: requests.get(
                    f"{self.payload_api}/batches/{self.batch_id}",
                    headers={"Authorization": f"users API-Key {self.payload_api_key}"},
                    timeout=5,
                    verify=False,
                ),
            )
            return resp.status_code == 200
        except Exception:
            return False

    async def _check_sampling(self) -> bool:
        try:
            # Litestar always exposes /schema — use as health probe
            resp = await asyncio.get_event_loop().run_in_executor(
                None,
                lambda: requests.get(f"{self.sampling_api}/schema", timeout=3),
            )
            return resp.status_code < 500
        except Exception:
            return False

    async def _init_sampling(self) -> None:
        try:
            await asyncio.get_event_loop().run_in_executor(
                None,
                lambda: requests.post(
                    f"{self.sampling_api}/initialize",
                    json={"batch_id": str(self.batch_id)},
                    timeout=10,
                ),
            )
            self._log("Sampling initialized for batch", self.batch_id)
        except Exception as exc:
            self._log("WARNING: Sampling init failed:", exc)

    async def _get_sampling_suggestion(self) -> dict | None:
        try:
            resp = await asyncio.get_event_loop().run_in_executor(
                None,
                lambda: requests.get(
                    f"{self.sampling_api}/suggest/{self.batch_id}",
                    timeout=30,
                ),
            )
            if resp.status_code == 200:
                data = resp.json()
                return data.get("parameters") or data
        except Exception as exc:
            self._log("Sampling suggest failed:", exc)
        return None

    async def _register_sampling_result(self, trial_index: int, params: dict) -> None:
        try:
            await asyncio.get_event_loop().run_in_executor(
                None,
                lambda: requests.post(
                    f"{self.sampling_api}/register",
                    json={
                        "batch_id": str(self.batch_id),
                        "trial_index": trial_index,
                        "outcome": None,  # filled by scenario_sampler after sim
                        "esmini_dat_id": "",
                    },
                    timeout=10,
                ),
            )
        except Exception as exc:
            self._log("WARNING: Sampling register failed:", exc)

    async def _trigger_esmini_trial(self, trial_index: int, params: dict) -> bool:
        """
        Trigger a simulation trial via roslaunch with batch_id override.

        roslaunch supports inline arg overrides:
            roslaunch scenario_search single_parameterized_scenario_search.launch batch_id:=1

        This avoids editing the launch file by hand for every run.
        Must source both ROS setup files first (melodic + workspace devel).
        """
        setup = (
            "source /opt/ros/melodic/setup.bash && "
            "source /project/mmsl_simulation/devel/setup.bash"
        )
        cmd = (
            f"bash -c '"
            f"{setup} && "
            f"roslaunch scenario_search single_parameterized_scenario_search.launch "
            f"batch_id:={self.batch_id} "
            f"sampling_suggestion_api:={self.sampling_api} "
            f"headless:=true'"   # required — run.launch uses $(arg headless) without a default
        )
        ok = await asyncio.get_event_loop().run_in_executor(
            None,
            lambda: self.docker.exec_detached(cmd),
        )
        return ok

    async def _wait_for_ros_master(self, timeout_s: int = 60) -> bool:
        """
        Poll until rosmaster responds inside the container or we time out.
        roslaunch starts rosmaster asynchronously — give it up to *timeout_s* seconds.
        """
        deadline = time.monotonic() + timeout_s
        while time.monotonic() < deadline:
            alive = await asyncio.get_event_loop().run_in_executor(
                None, self.ros.is_ros_master_alive
            )
            if alive:
                self._log("ROS master is up.")
                return True
            await asyncio.sleep(3)
        return False

    async def _wait_for_trial(self, trial_index: int) -> bool:
        """
        Poll until the CSV file appears (trial finished) or we time out.
        """
        deadline = time.monotonic() + self.max_trial_duration_seconds
        csv = self.validator.cache_root / f"esmini_{self.batch_id}_{trial_index}.csv"

        while time.monotonic() < deadline:
            if csv.exists():
                return True
            await asyncio.sleep(POLL_INTERVAL_S)

        self._log(f"Trial {trial_index} timed out after {self.max_trial_duration_seconds}s")
        return False

    # ── Broadcasts ────────────────────────────────────────────────────────

    async def _broadcast(self, msg_type: WsMessageType, payload: dict) -> None:
        if self._status_cb:
            msg = WsMessage(type=msg_type.value, payload=payload)
            try:
                await self._status_cb(msg)
            except Exception as exc:
                log.warning("Status callback failed: %s", exc)

    async def _broadcast_status_update(self) -> None:
        await self._broadcast(WsMessageType.STATUS_UPDATE, self.snapshot())

    async def _broadcast_completion(self) -> None:
        await self._broadcast(WsMessageType.COMPLETED, self.snapshot())

    # ── Logging helpers ───────────────────────────────────────────────────

    def _log(self, *args) -> None:
        msg = " ".join(str(a) for a in args)
        log.info(msg)
        self.logs.append(f"[{datetime.now(timezone.utc).strftime('%H:%M:%S')}] {msg}")
        # Keep only last 500 log lines
        if len(self.logs) > 500:
            self.logs = self.logs[-500:]

    # ── State snapshot ────────────────────────────────────────────────────

    def snapshot(self) -> dict:
        """Return a serialisable status snapshot (used by GET /status)."""
        elapsed = (time.monotonic() - self.started_at) if self.started_at else 0
        done = self.completed_trials + self.failed_trials
        avg = elapsed / done if done > 0 else 0
        remaining = max(0, self.n_trials - done)
        eta = avg * remaining if avg > 0 else None
        sr = (self.completed_trials / done) if done > 0 else 0.0

        return {
            "run_id": self.run_id,
            "status": self.status.value,
            "batch_id": self.batch_id,
            "scenario_id": self.scenario_id,
            "progress": {
                "current_trial": self.current_trial,
                "total_trials": self.n_trials,
                "completed": self.completed_trials,
                "failed": self.failed_trials,
                "success_rate": round(sr, 3),
            },
            "timing": {
                "started_at": (
                    datetime.fromtimestamp(
                        time.time() - elapsed, tz=timezone.utc
                    ).isoformat()
                    if self.started_at else None
                ),
                "elapsed_seconds": round(elapsed, 1),
                "eta_seconds": round(eta, 1) if eta else None,
            },
            "last_trial": self._last_trial_info or None,
            "errors": self.errors[-10:],
            "logs_tail": self.logs[-50:],
        }
