"""Esmini CSV width/length parsing."""
from __future__ import annotations

import sys
from pathlib import Path

import pytest

REPO = Path(__file__).resolve().parents[1]
SRC = REPO / "app" / "analyzer" / "src"
sys.path.insert(0, str(SRC))

from csv_roadid_loader import get_csv_road_data


@pytest.mark.skipif(
    not (REPO / "simulation/ros/.cache/scenario_search/records/esmini_1_355.csv").is_file(),
    reason="esmini CSV not on disk",
)
def test_esmini_csv_has_width_length():
    df = get_csv_road_data(1, 355)
    assert df is not None
    assert "width" in df.columns and "length" in df.columns
    ego = df[df["name"].str.strip() == "Ego"]
    assert float(ego["width"].iloc[0]) >= 1.5
    assert float(ego["length"].iloc[0]) > 4.0
