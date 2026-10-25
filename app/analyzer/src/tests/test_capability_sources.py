from pathlib import Path

import pytest

from capability_sources import (
    resolve_vehicle_catalog_performance,
    sha256_file,
    snapshot_input,
    valid_persisted_collision,
)


def test_source_hash_and_snapshot_key_resolution(tmp_path: Path):
    source = tmp_path / "config.yaml"
    source.write_text("value: 1\n", encoding="utf-8")
    assert len(sha256_file(source)) == 64
    snapshot = {"inputs": [{"key": "brake", "status": "configured"}]}
    assert snapshot_input(snapshot, "brake")["status"] == "configured"


def test_duplicate_snapshot_key_is_rejected():
    with pytest.raises(ValueError, match="duplicate"):
        snapshot_input({"inputs": [{"key": "brake"}, {"key": "brake"}]}, "brake")


def test_persisted_collision_requires_observation_link_and_positive_time():
    invalid = {"name": "collisionWithOpposite", "esminiSeconds": 2, "timeStatus": "recorded"}
    valid = {**invalid, "observation": 12}
    assert valid_persisted_collision([invalid]) is None
    assert valid_persisted_collision([valid]) == valid


def test_vehicle_catalog_never_selects_a_default_vehicle(tmp_path: Path):
    catalog = tmp_path / "VehicleCatalog.xosc"
    catalog.write_text(
        '<OpenSCENARIO><Vehicle name="a"><Performance maxDeceleration="8" maxAcceleration="2" /></Vehicle></OpenSCENARIO>',
        encoding="utf-8",
    )
    assert resolve_vehicle_catalog_performance(catalog, None)["status"] == "unavailable"
    resolved = resolve_vehicle_catalog_performance(catalog, "a")
    assert resolved["status"] == "configured"
    assert resolved["max_deceleration_mps2"] == 8.0
