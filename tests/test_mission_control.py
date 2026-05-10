"""
Unit tests for the Mission Control backend.

These tests deliberately avoid any Docker/ROS/Payload dependencies so they
run on any workstation.
"""
from __future__ import annotations

import asyncio
import sys
from pathlib import Path
from unittest.mock import MagicMock, patch

import pytest

# Make sure the simulation src is importable
SRC = Path(__file__).resolve().parent.parent / "app" / "simulation" / "src"
if str(SRC) not in sys.path:
    sys.path.insert(0, str(SRC))


# ─────────────────────────────────────────────────────────────────────────────
#  models
# ─────────────────────────────────────────────────────────────────────────────

from models import RunRequest, SimStatus, WsMessage, WsMessageType


def test_run_request_defaults():
    req = RunRequest(batch_id=1, scenario_id=2)
    assert req.n_trials == 100
    assert req.retry_failed is True


def test_ws_message_serialization():
    msg = WsMessage(type=WsMessageType.STATUS_UPDATE.value, payload={"status": "running"})
    d = msg.to_dict()
    assert d["type"] == "status_update"
    assert d["payload"]["status"] == "running"


def test_sim_status_values():
    assert SimStatus.IDLE.value == "idle"
    assert SimStatus.COMPLETED.value == "completed"
    assert SimStatus.FAILED.value == "failed"


# ─────────────────────────────────────────────────────────────────────────────
#  docker_manager (stub mode — no Docker daemon needed)
# ─────────────────────────────────────────────────────────────────────────────

from docker_manager import DockerManager


def test_docker_manager_unavailable_when_no_daemon():
    """Without a Docker daemon, DockerManager reports unavailable gracefully."""
    mgr = DockerManager()
    # On CI / dev machines without Docker the client will be None
    if not mgr.is_docker_available:
        assert mgr.is_running() is False
        assert mgr.get_status() == "docker_unavailable"
        assert mgr.ensure_running() is False
        assert mgr.tail_logs() == "(Docker unavailable)"


def test_docker_exec_returns_tuple_on_unavailable():
    mgr = DockerManager()
    if not mgr.is_docker_available:
        code, out = mgr.exec("echo hello")
        assert isinstance(code, int)
        assert isinstance(out, str)


# ─────────────────────────────────────────────────────────────────────────────
#  data_validator
# ─────────────────────────────────────────────────────────────────────────────

from data_validator import DataValidator


def test_data_validator_missing_csv(tmp_path):
    validator = DataValidator(cache_root=tmp_path)
    result = validator.validate_trial(batch_id=1, trial_index=999)
    assert result["csv_exists"] is False
    assert result["checks_passed"] is False
    assert len(result["issues"]) > 0


def test_data_validator_valid_csv(tmp_path):
    """Create a minimal CSV with required columns and check it passes."""
    csv = tmp_path / "esmini_1_0.csv"
    csv.write_text(
        "roadId,laneId,egoX,egoY,egoZ,egoSpeed\n"
        "51,1,100.0,200.0,0.0,5.0\n"
    )
    validator = DataValidator(cache_root=tmp_path, payload_api="http://invalid:9999/api")
    result = validator.validate_trial(batch_id=1, trial_index=0)
    assert result["csv_exists"] is True
    assert result["csv_has_required_columns"] is True
    assert result["ego_roadid_nonzero"] is True


def test_data_validator_zero_roadid_warning(tmp_path):
    csv = tmp_path / "esmini_2_5.csv"
    csv.write_text(
        "roadId,laneId,egoX,egoY\n"
        "0,0,100.0,200.0\n"
    )
    validator = DataValidator(cache_root=tmp_path, payload_api="http://invalid:9999/api")
    result = validator.validate_trial(batch_id=2, trial_index=5)
    assert result["csv_exists"] is True
    # roadId=0 should raise a warning but NOT fail the check
    assert result["ego_roadid_nonzero"] is False
    roadid_issues = [i for i in result["issues"] if "roadid" in i.lower() or "roadId" in i]
    assert len(roadid_issues) > 0


def test_data_validator_count_csvs(tmp_path):
    for i in range(5):
        (tmp_path / f"esmini_3_{i}.csv").write_text("roadId\n1\n")
    (tmp_path / "esmini_4_0.csv").write_text("roadId\n1\n")  # different batch
    validator = DataValidator(cache_root=tmp_path)
    assert validator.count_local_csvs(3) == 5
    assert validator.count_local_csvs(4) == 1
    assert validator.count_local_csvs(99) == 0


def test_data_validator_summary(tmp_path):
    for i in range(3):
        (tmp_path / f"esmini_7_{i}.csv").write_text("roadId\n1\n")
    validator = DataValidator(cache_root=tmp_path, payload_api="http://invalid:9999/api")
    s = validator.summary(7)
    assert s["batch_id"] == 7
    assert s["local_csv_count"] == 3
    assert s["payload_trial_count"] == -1  # Payload unreachable
    assert s["in_sync"] is None


# ─────────────────────────────────────────────────────────────────────────────
#  ros_monitor
# ─────────────────────────────────────────────────────────────────────────────

from ros_monitor import RosMonitor, MAX_DAT_SIZE_BYTES


def test_ros_monitor_no_docker():
    mock_docker = MagicMock()
    mock_docker.is_docker_available = False
    mock_docker.is_running.return_value = False
    ros = RosMonitor(mock_docker)
    health = ros.health_check()
    assert health["available"] is False


def test_ros_monitor_container_stopped():
    mock_docker = MagicMock()
    mock_docker.is_docker_available = True
    mock_docker.is_running.return_value = False
    ros = RosMonitor(mock_docker)
    health = ros.health_check()
    assert health["available"] is False
    assert "not running" in health["reason"]


def test_ros_monitor_dat_runaway_detection():
    mock_docker = MagicMock()
    mock_docker.is_docker_available = True
    mock_docker.is_running.return_value = True
    # Simulate a 2 GB .dat file
    mock_docker.exec.return_value = (0, str(MAX_DAT_SIZE_BYTES * 2))
    ros = RosMonitor(mock_docker)
    assert ros.is_dat_runaway("/tmp/test.dat") is True


def test_ros_monitor_dat_normal_size():
    mock_docker = MagicMock()
    mock_docker.exec.return_value = (0, "1048576")  # 1 MB
    ros = RosMonitor(mock_docker)
    assert ros.is_dat_runaway("/tmp/test.dat") is False


# ─────────────────────────────────────────────────────────────────────────────
#  orchestrator (unit — no real IO)
# ─────────────────────────────────────────────────────────────────────────────

from orchestrator import SimulationOrchestrator


def test_orchestrator_initial_state():
    orch = SimulationOrchestrator(batch_id=1, scenario_id=1, n_trials=5)
    assert orch.status == SimStatus.IDLE
    assert orch.completed_trials == 0
    assert orch.failed_trials == 0
    assert orch.current_trial == 0


def test_orchestrator_stop_sets_flag():
    orch = SimulationOrchestrator(batch_id=1, scenario_id=1, n_trials=10)
    orch.stop()
    assert orch._stop_requested is True
    assert orch.status == SimStatus.STOPPING


def test_orchestrator_snapshot_keys():
    orch = SimulationOrchestrator(batch_id=2, scenario_id=3, n_trials=50)
    snap = orch.snapshot()
    for key in ("run_id", "status", "batch_id", "scenario_id", "progress", "timing", "errors"):
        assert key in snap, f"Missing key: {key}"
    assert snap["progress"]["total_trials"] == 50


def test_orchestrator_fails_without_docker():
    """Orchestrator should fail gracefully when Docker isn't available."""
    messages = []

    async def capture_cb(msg):  # type: ignore[override]
        messages.append(msg.to_dict())

    orch = SimulationOrchestrator(
        batch_id=1,
        scenario_id=1,
        n_trials=1,
        status_callback=capture_cb,
    )
    # Patch DockerManager to report unavailability
    # Force docker unavailable by setting _client to None (is_docker_available is a property)
    orch.docker._client = None
    asyncio.get_event_loop().run_until_complete(orch.run())

    assert orch.status == SimStatus.FAILED
    assert any("Docker" in e for e in orch.errors)
    # Should still broadcast a completion message
    types = [m["type"] for m in messages]
    assert "completed" in types
