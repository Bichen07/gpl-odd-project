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
import json
import logging
import os
import re
import shlex
import time
import uuid
from datetime import datetime, timezone
from pathlib import Path
from typing import Any, Awaitable, Callable, Optional

import requests

from data_validator import DataValidator
from docker_manager import DockerManager
from mission_control_paths import CONTAINER_MISSION_CONTROL, write_run_manifest
from mission_control_paths import run_dir_host as mc_run_dir_host
from models import SimStatus, WsMessage, WsMessageType
from ros_monitor import RosMonitor

log = logging.getLogger("mission_control.orchestrator")

MAX_RETRIES = 3
# seconds to wait for a trial to finish before timing out (ROS + esmini + dat2csv)
TRIAL_TIMEOUT_S = 180
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
                write_run_manifest(
                    self.run_id,
                    batch_id=self.batch_id,
                    scenario_id=self.scenario_id,
                    n_trials=self.n_trials,
                    sampling_api_host=self.sampling_api,
                    sampling_api_container=self._sampling_api_for_container(),
                )
                self._log(
                    "Run artifact directory (host)",
                    str(mc_run_dir_host(self.run_id)),
                )
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
        """Run a single esmini trial.  Returns dict with status + metadata.

        **Important:** ``single_parameterized_scenario_search`` calls ``/suggest`` *inside*
        the container.  Mission Control must **not** call ``/suggest`` here — that would
        consume the next trial and desynchronise filenames (``esmini_<batch>_<idx>.csv``
        uses Sampling's ``trial_index``, not this loop index).

        ROS registers outcomes with Sampling when the simulation finishes; do not POST
        ``/register`` from here with ``outcome: null`` (that marks the trial failed).
        """
        t_start = time.monotonic()

        # Wall-clock anchor: any CSV written/updated *after* this is treated as this trial.
        trial_started_wall = time.time()

        self._log(
            f"Trial {trial_index} (run step): awaiting ROS + Sampling — "
            f"CSV will be esmini_{self.batch_id}_<trial_index>.csv from container",
        )

        # 1. Trigger esmini scenario search (via ROS inside container; ROS calls /suggest)
        ok = await self._trigger_esmini_trial(trial_index)
        if not ok:
            return {"trial_index": trial_index, "status": "failed", "reason": "trigger_failed"}

        # 2. Wait for ROS master to come up (roslaunch just started it)
        ros_started = await self._wait_for_ros_master(timeout_s=90)
        if not ros_started:
            self._log(f"Trial {trial_index}: ROS master did not start — roslaunch may have crashed")
            self._log_roslaunch_tail(trial_index)
            return {"trial_index": trial_index, "status": "failed", "reason": "ros_start_timeout"}

        # 3. Wait for the trial CSV (Sampling trial index comes from the filename)
        sampling_trial_index = await self._wait_for_trial_csv(trial_started_wall)
        if sampling_trial_index is None:
            return {"trial_index": trial_index, "status": "failed", "reason": "timeout"}

        self._log(f"Trial {trial_index}: completed Sampling trial_index={sampling_trial_index}")

        # 4. Validate CSV + Payload (use Sampling index — matches disk + Payload)
        validation = self.validator.validate_trial(self.batch_id, sampling_trial_index)
        if not validation["csv_exists"]:
            return {
                "trial_index": trial_index,
                "status": "failed",
                "reason": "csv_missing",
                "sampling_trial_index": sampling_trial_index,
                "validation": validation,
            }

        duration = time.monotonic() - t_start
        return {
            "trial_index": trial_index,
            "status": "success",
            "duration_seconds": round(duration, 1),
            "sampling_trial_index": sampling_trial_index,
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

    def _sampling_api_for_container(self) -> str:
        """
        URL passed to ``roslaunch`` inside Docker.

        With ``--network host``, ``http://localhost:9009`` matches the host.
        On bridge networks, set ``SAMPLING_API_FOR_CONTAINER`` (e.g. host gateway IP).
        """
        return os.getenv("SAMPLING_API_FOR_CONTAINER", self.sampling_api).strip()

    def _write_trial_launch_script(self, trial_index: int) -> tuple[str, str]:
        """
        Write ``trial_<N>_launch.sh`` on the host (visible in container via mount).

        Returns (container_script_path, container_log_path).
        """
        host_dir = mc_run_dir_host(self.run_id)
        host_dir.mkdir(parents=True, exist_ok=True)
        sampling = self._sampling_api_for_container()
        export_sampling = f"export MC_SAMPLING_URL={shlex.quote(sampling)}\n"

        script = f"""#!/usr/bin/env bash
set -euo pipefail
{export_sampling}source /opt/ros/melodic/setup.bash
source /project/mmsl_simulation/devel/setup.bash
export ROS_MASTER_URI="${{ROS_MASTER_URI:-http://localhost:11311}}"
export ROS_HOSTNAME="${{ROS_HOSTNAME:-localhost}}"
exec roslaunch scenario_search single_parameterized_scenario_search.launch \\
  batch_id:={self.batch_id} \\
  sampling_suggestion_api:=${{MC_SAMPLING_URL}} \\
  headless:=true
"""
        host_script = host_dir / f"trial_{trial_index}_launch.sh"
        host_script.write_text(script, encoding="utf-8")
        host_script.chmod(0o755)

        rel = f"runs/{self.run_id}/trial_{trial_index}_launch.sh"
        c_script = f"{CONTAINER_MISSION_CONTROL}/{rel}"
        c_log = f"{CONTAINER_MISSION_CONTROL}/runs/{self.run_id}/trial_{trial_index}_roslaunch.log"
        return c_script, c_log

    def _log_roslaunch_tail(self, trial_index: int, max_lines: int = 35) -> None:
        host_log = mc_run_dir_host(self.run_id) / f"trial_{trial_index}_roslaunch.log"
        if not host_log.is_file():
            self._log("No roslaunch log at", str(host_log))
            return
        lines = host_log.read_text(encoding="utf-8", errors="replace").splitlines()
        tail = "\n".join(lines[-max_lines:])
        self._log("roslaunch log tail:\n" + tail)

    async def _trigger_esmini_trial(self, trial_index: int) -> bool:
        """
        Start ``roslaunch`` inside the container in a **detached** OS process.

        ``docker exec_run(..., detach=True)`` often tears down the exec session and
        kills the child before ``roslaunch`` can start roscore.  We instead write a
        small script on the bind-mounted volume and run ``nohup bash script >> log &``
        via a short synchronous ``docker exec``.
        """
        c_script, c_log = self._write_trial_launch_script(trial_index)

        inner = (
            f"chmod +x {shlex.quote(c_script)} && "
            f"nohup bash {shlex.quote(c_script)} >> {shlex.quote(c_log)} 2>&1 & "
            f"sleep 2 && echo MC_DISPATCH_OK"
        )
        dispatch = f"bash -lc {shlex.quote(inner)}"

        def _dispatch() -> tuple[int, str]:
            return self.docker.exec(dispatch, timeout=30)

        code, out = await asyncio.get_event_loop().run_in_executor(None, _dispatch)
        ok = code == 0 and "MC_DISPATCH_OK" in out
        if not ok:
            self._log(
                "ERROR: roslaunch dispatch failed",
                f"exit={code} out={out[:500]}",
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

    async def _wait_for_trial_csv(self, trial_started_wall: float) -> int | None:
        """
        Poll until an esmini CSV for this batch appears or is updated after *trial_started_wall*.

        Filenames (see ``single_parameterized_scenario_search``):
          - ``esmini_<batch>_<trial_index>.csv``
          - ``esmini_rss_reference_model_<batch>_<trial_index>.csv`` (reference / preventable flow)

        The numeric index is Sampling's ``trial_index``, not Mission Control's loop index.
        """
        pat_standard = re.compile(rf"^esmini_{self.batch_id}_(\d+)\.csv$")
        pat_ref = re.compile(rf"^esmini_rss_reference_model_{self.batch_id}_(\d+)\.csv$")
        deadline = time.monotonic() + self.max_trial_duration_seconds
        mtime_floor = trial_started_wall - 5.0

        def _candidate_paths() -> list[Path]:
            root = self.validator.cache_root
            if not root.is_dir():
                return []
            paths: list[Path] = []
            paths.extend(root.glob(f"esmini_{self.batch_id}_*.csv"))
            paths.extend(root.glob(f"esmini_rss_reference_model_{self.batch_id}_*.csv"))
            return paths

        while time.monotonic() < deadline:
            best: tuple[float, Path] | None = None
            for p in _candidate_paths():
                if not p.is_file():
                    continue
                try:
                    mt = p.stat().st_mtime
                except OSError:
                    continue
                if mt < mtime_floor:
                    continue
                if best is None or mt > best[0]:
                    best = (mt, p)
            if best:
                m = pat_standard.match(best[1].name) or pat_ref.match(best[1].name)
                if m:
                    return int(m.group(1))
            await asyncio.sleep(POLL_INTERVAL_S)

        self._log(
            f"No new esmini CSV for batch {self.batch_id} within {self.max_trial_duration_seconds}s "
            "(see roslaunch log; increase Max trial duration if ego/esmini needs more time)",
        )
        return None

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
