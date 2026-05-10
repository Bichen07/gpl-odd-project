"""
Docker lifecycle manager for the sdc-bionic simulation container.

Wraps the Python Docker SDK (docker-py).  Falls back gracefully when:
  • docker-py is not installed
  • Docker daemon is not running
  • The container does not exist yet
"""
from __future__ import annotations

import logging
import subprocess
from typing import Optional

log = logging.getLogger("mission_control.docker")

# Optional import — only available when docker-py is installed
try:
    import docker
    from docker.errors import DockerException, NotFound, APIError
    _DOCKER_AVAILABLE = True
except ImportError:
    _DOCKER_AVAILABLE = False
    log.warning("docker-py not installed — Docker manager running in stub mode.")


CONTAINER_NAME = "sdc-bionic"


class DockerManager:
    """
    Manages the lifecycle of the sdc-bionic simulation container.

    Safe to instantiate even if Docker is not available — all methods
    return False / None rather than raising, so the Orchestrator can
    report a meaningful error to the Dashboard.
    """

    def __init__(self, container_name: str = CONTAINER_NAME):
        self.container_name = container_name
        self._client: Optional[object] = None
        if _DOCKER_AVAILABLE:
            try:
                self._client = docker.from_env()
                self._client.ping()  # type: ignore[union-attr]
                log.info("Docker daemon connected.")
            except Exception as exc:
                self._client = None
                log.warning("Docker daemon not reachable: %s", exc)

    # ── Availability checks ────────────────────────────────────────────────

    @property
    def is_docker_available(self) -> bool:
        return self._client is not None

    def is_running(self) -> bool:
        """Return True if the container exists and is in 'running' state."""
        if not self._client:
            return False
        try:
            container = self._client.containers.get(self.container_name)  # type: ignore
            return container.status == "running"
        except Exception:
            return False

    def get_status(self) -> str:
        """Return container status string, or 'unavailable'."""
        if not self._client:
            return "docker_unavailable"
        try:
            container = self._client.containers.get(self.container_name)  # type: ignore
            return container.status
        except Exception:
            return "not_found"

    # ── Lifecycle ─────────────────────────────────────────────────────────

    def ensure_running(self) -> bool:
        """Start the container if it is stopped.  Returns True on success."""
        if not self._client:
            log.error("Docker not available — cannot start container.")
            return False
        try:
            container = self._client.containers.get(self.container_name)  # type: ignore
            if container.status != "running":
                log.info("Starting container '%s'...", self.container_name)
                container.start()
                container.reload()
                log.info("Container '%s' started.", self.container_name)
            return True
        except Exception as exc:
            log.error("Could not start container: %s", exc)
            return False

    def stop(self) -> bool:
        """Gracefully stop the container.  Returns True on success."""
        if not self._client:
            return False
        try:
            container = self._client.containers.get(self.container_name)  # type: ignore
            container.stop(timeout=30)
            log.info("Container '%s' stopped.", self.container_name)
            return True
        except Exception as exc:
            log.error("Could not stop container: %s", exc)
            return False

    # ── Command execution ──────────────────────────────────────────────────

    def exec(self, cmd: str, workdir: str | None = None) -> tuple[int, str]:
        """
        Run *cmd* inside the container using ``docker exec``.

        Returns (exit_code, combined_output).
        Falls back to subprocess when docker-py exec is unavailable.
        """
        if not self._client:
            return -1, "Docker unavailable"
        try:
            container = self._client.containers.get(self.container_name)  # type: ignore
            kwargs: dict = {"workdir": workdir} if workdir else {}
            result = container.exec_run(cmd, **kwargs)
            return result.exit_code, (result.output or b"").decode("utf-8", errors="replace")
        except Exception as exc:
            return -1, str(exc)

    def exec_detached(self, cmd: str, workdir: str | None = None) -> bool:
        """
        Run *cmd* inside the container in a background (detached) process.
        Returns True if the exec was launched (fire-and-forget).
        """
        if not self._client:
            return False
        try:
            container = self._client.containers.get(self.container_name)  # type: ignore
            kwargs: dict = {"detach": True}
            if workdir:
                kwargs["workdir"] = workdir
            container.exec_run(cmd, **kwargs)
            return True
        except Exception as exc:
            log.error("exec_detached failed: %s", exc)
            return False

    # ── Log streaming ─────────────────────────────────────────────────────

    def tail_logs(self, lines: int = 100) -> str:
        """Return the last *lines* lines of container stdout/stderr."""
        if not self._client:
            return "(Docker unavailable)"
        try:
            container = self._client.containers.get(self.container_name)  # type: ignore
            raw = container.logs(tail=lines)
            return raw.decode("utf-8", errors="replace")
        except Exception as exc:
            return f"(error reading logs: {exc})"

    def stream_logs(self):
        """Generator that yields new log lines in real-time."""
        if not self._client:
            return
        try:
            container = self._client.containers.get(self.container_name)  # type: ignore
            for chunk in container.logs(stream=True, follow=True):
                yield chunk.decode("utf-8", errors="replace")
        except Exception as exc:
            log.error("Log stream error: %s", exc)
            return
