"""
ROS node health monitor.

All checks are done via `docker exec` into the sdc-bionic container so they
work from any host machine without a local ROS installation.

Monitoring functions return plain dicts — no exceptions propagate to callers.
"""
from __future__ import annotations

import logging
import os
from typing import TYPE_CHECKING

if TYPE_CHECKING:
    from docker_manager import DockerManager

log = logging.getLogger("mission_control.ros")

# Known ROS topics that signal simulation health
TOPIC_SCENARIO_STABLE = "/scenario_monitor/scenario_stable"
TOPIC_RECORD_FILEPATH  = "/esmini_record_filepath"

# Maximum .dat file size before we consider esmini runaway (bytes → 1 GB)
MAX_DAT_SIZE_BYTES = 1_073_741_824


class RosMonitor:
    """
    Lightweight monitor that polls ROS state via docker exec.

    Requires a running DockerManager pointing at the sdc-bionic container.
    All methods return structured dicts so callers can decide what to do.
    """

    def __init__(self, docker: "DockerManager"):
        self._docker = docker

    # ── ROS Master ────────────────────────────────────────────────────────

    def is_ros_master_alive(self) -> bool:
        """Ping rosmaster by running ``rostopic list`` inside the container."""
        code, out = self._docker.exec("rostopic list")
        if code == 0 and "/" in out:
            return True
        log.warning("ROS master check failed (exit=%d): %s", code, out[:200])
        return False

    # ── Active topics ─────────────────────────────────────────────────────

    def list_topics(self) -> list[str]:
        code, out = self._docker.exec("rostopic list")
        if code != 0:
            return []
        return [line.strip() for line in out.splitlines() if line.strip()]

    def topic_exists(self, topic: str) -> bool:
        return topic in self.list_topics()

    # ── Node health ───────────────────────────────────────────────────────

    def list_nodes(self) -> list[str]:
        code, out = self._docker.exec("rosnode list")
        if code != 0:
            return []
        return [line.strip() for line in out.splitlines() if line.strip()]

    def node_alive(self, node_name: str) -> bool:
        """Return True if *node_name* appears in ``rosnode list``."""
        return node_name in self.list_nodes()

    def get_node_info(self, node_name: str) -> str:
        _, out = self._docker.exec(f"rosnode info {node_name}")
        return out

    # ── esmini watchdog ───────────────────────────────────────────────────

    def get_dat_file_size(self, dat_path: str) -> int:
        """Return size of a .dat file in bytes, or -1 if inaccessible."""
        code, out = self._docker.exec(f"stat -c %s {dat_path}")
        if code != 0:
            return -1
        try:
            return int(out.strip())
        except ValueError:
            return -1

    def is_dat_runaway(self, dat_path: str) -> bool:
        """Return True if .dat exceeds MAX_DAT_SIZE_BYTES (runaway esmini)."""
        size = self.get_dat_file_size(dat_path)
        if size < 0:
            return False
        if size > MAX_DAT_SIZE_BYTES:
            log.error(
                "Runaway .dat file detected (%d bytes > %d limit): %s",
                size, MAX_DAT_SIZE_BYTES, dat_path
            )
            return True
        return False

    def kill_esmini(self) -> bool:
        """Kill any running esmini processes inside the container."""
        code, out = self._docker.exec("pkill -f esmini")
        log.warning("kill_esmini: exit=%d out=%s", code, out[:100])
        return code == 0

    # ── Summary dict ─────────────────────────────────────────────────────

    def health_check(self) -> dict:
        """
        Return a summary of the current ROS environment.
        Safe to call even when Docker is unavailable.
        """
        if not self._docker.is_docker_available:
            return {"available": False, "reason": "Docker not available"}
        if not self._docker.is_running():
            return {"available": False, "reason": "Container not running"}

        ros_alive = self.is_ros_master_alive()
        nodes = self.list_nodes() if ros_alive else []
        topics = self.list_topics() if ros_alive else []

        return {
            "available": True,
            "ros_master_alive": ros_alive,
            "node_count": len(nodes),
            "nodes": nodes,
            "topic_count": len(topics),
            "scenario_stable_topic": TOPIC_SCENARIO_STABLE in topics,
            "record_filepath_topic": TOPIC_RECORD_FILEPATH in topics,
        }
