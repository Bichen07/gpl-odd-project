"""Golden checks: clip_conditions.yaml on raw vs already-clipped esmini CSV."""
from __future__ import annotations

import sys
from pathlib import Path

import pytest

ANALYZER_SRC = Path(__file__).resolve().parents[1]
if str(ANALYZER_SRC) not in sys.path:
    sys.path.insert(0, str(ANALYZER_SRC))

from clip_conditions import (  # noqa: E402
    active_profile,
    load_clip_config,
    resolve_clip_start_from_csv,
    reload_clip_config,
)

REPO = Path(__file__).resolve().parents[4]
RECORDS = REPO / "simulation/ros/.cache/scenario_search/records"

RAW_CSV = RECORDS / "esmini_2_772.csv"
CLIPPED_CSV = RECORDS / "esmini_7_2287.csv"


@pytest.fixture(autouse=True)
def _reload_config():
    reload_clip_config()
    yield
    reload_clip_config()


def test_config_loads_and_has_both_profiles():
    cfg = load_clip_config()
    assert cfg.get("active") in ("current_startvalid", "analysis_adjustable")
    assert "current_startvalid" in cfg["profiles"]
    assert "analysis_adjustable" in cfg["profiles"]


@pytest.mark.skipif(not RAW_CSV.is_file(), reason="esmini_2_772.csv missing")
def test_raw_batch2_current_profile_near_road92_gate():
    """Raw CSV: current_startvalid ≈ t=10.78 + 0.1 at ~(300,58)."""
    cfg = load_clip_config()
    # Force legacy profile for this assertion
    cfg = dict(cfg)
    cfg["active"] = "current_startvalid"
    clip = resolve_clip_start_from_csv(RAW_CSV, batch_id=2, config=cfg)
    assert clip is not None
    assert 10.5 <= clip <= 11.5, f"unexpected clip {clip}"


@pytest.mark.skipif(not RAW_CSV.is_file(), reason="esmini_2_772.csv missing")
def test_raw_batch2_world_xy_profile_is_farther():
    """analysis_adjustable for batch2 is ~(420,142), later than road-92 gate."""
    cfg = dict(load_clip_config())
    cfg["active"] = "analysis_adjustable"
    clip = resolve_clip_start_from_csv(RAW_CSV, batch_id=2, config=cfg)
    assert clip is not None
    assert 20.0 <= clip <= 30.0, f"expected far clip ~24s, got {clip}"


@pytest.mark.skipif(not CLIPPED_CSV.is_file(), reason="esmini_7_2287.csv missing")
def test_already_clipped_batch7_world_xy_starts_near_zero():
    """Payload-style CSV already at gate → current profile ≈ 0; far profile later."""
    cfg = dict(load_clip_config())
    cfg["active"] = "current_startvalid"
    clip0 = resolve_clip_start_from_csv(CLIPPED_CSV, batch_id=7, config=cfg)
    assert clip0 is not None
    assert clip0 <= 0.3, f"expected near 0 for already-clipped CSV, got {clip0}"

    cfg["active"] = "analysis_adjustable"
    clip_far = resolve_clip_start_from_csv(CLIPPED_CSV, batch_id=7, config=cfg)
    assert clip_far is not None
    assert clip_far >= 10.0, f"expected far clip on clipped CSV, got {clip_far}"
    assert clip_far > clip0


@pytest.mark.skipif(not CLIPPED_CSV.is_file(), reason="esmini_7_2287.csv missing")
def test_already_clipped_batch7_current_profile_fallback():
    """roadId may be stripped; fallback world XY still finds the gate."""
    cfg = dict(load_clip_config())
    cfg["active"] = "current_startvalid"
    clip = resolve_clip_start_from_csv(CLIPPED_CSV, batch_id=7, config=cfg)
    assert clip is not None
    # +0.1 offset on t=0 → 0.1
    assert clip <= 0.3, f"expected near 0 for already-clipped CSV, got {clip}"


@pytest.mark.skipif(
    not (RECORDS / "esmini_1_36.csv").is_file(), reason="esmini_1_36 missing"
)
def test_batch1_overrides_both_profiles():
    cfg = dict(load_clip_config())
    path = RECORDS / "esmini_1_36.csv"
    cfg["active"] = "current_startvalid"
    c0 = resolve_clip_start_from_csv(path, batch_id=1, config=cfg)
    cfg["active"] = "analysis_adjustable"
    c1 = resolve_clip_start_from_csv(path, batch_id=1, config=cfg)
    assert c0 is not None and c1 is not None
    assert c1 > c0 + 1.0, f"batch1 far should be later: {c0} vs {c1}"


def test_active_profile_merge():
    prof = active_profile("hct_6")
    assert prof.get("_profile_name")
    assert "type" in prof


def test_batch1_override_applied():
    prof = active_profile("hct_6", batch_id=1)
    # Force current profile name from file
    cfg = dict(load_clip_config())
    cfg["active"] = "current_startvalid"
    prof = active_profile("hct_6", cfg, batch_id=1)
    assert float(prof.get("x", 0)) == -14.0
    assert float(prof.get("y", 0)) == 7.0
