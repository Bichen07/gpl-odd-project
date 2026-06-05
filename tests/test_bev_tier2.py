"""Tests for Phase 3b Tier2 BEV (map tracks CSV + MapPlotter)."""
from __future__ import annotations

import sys
from pathlib import Path

import pytest

REPO = Path(__file__).resolve().parents[1]
SRC = REPO / "app" / "analyzer" / "src"
if str(SRC) not in sys.path:
    sys.path.insert(0, str(SRC))

from map_plotter import MapPlotter, _coerce_highlight_road_ids
from tier2_renderer import (
    _heading_to_degrees,
    build_agent_registry,
    highlight_road_ids_from_df,
    infer_agent_role,
    load_medoids_from_clustering,
    pick_critical_timestamps,
    tier2_output_dir,
    view_bounds_from_df,
)
from dataset_config import get_dataset_config, trial_id_to_csv_indices


def test_tier2_output_dir_layout():
    p = tier2_output_dir("/tmp/bev", "dataset1", 3, 2)
    assert p == Path("/tmp/bev/dataset1/cluster_num3/cluster_2")


def test_view_bounds_proportional_padding():
    import pandas as pd

    df = pd.DataFrame(
        {
            "x": [0.0, 100.0, 50.0],
            "y": [0.0, 0.0, 80.0],
        }
    )
    xmin, xmax, ymin, ymax = view_bounds_from_df(df, pad_frac=0.10)
    assert xmin == pytest.approx(-10.0)
    assert xmax == pytest.approx(110.0)
    assert ymin == pytest.approx(-8.0)
    assert ymax == pytest.approx(88.0)


def test_pick_critical_timestamps_min_count():
    import pandas as pd

    times = [float(i) * 0.5 for i in range(40)]
    rows = []
    for t in times:
        rows.append(
            {
                "name": "Ego",
                "time": t,
                "x": t * 2,
                "y": 0.0,
                "h": 0.0,
                "speed": max(0.0, 10.0 - t),
                "roadId": 1 if t < 10 else 2,
            }
        )
        rows.append(
            {
                "name": "Oncoming",
                "time": t,
                "x": 80.0 - t * 2,
                "y": 0.0,
                "h": 3.14,
                "speed": 5.0,
                "roadId": 1,
            }
        )
    df = pd.DataFrame(rows)
    picks = pick_critical_timestamps(df, times, max_frames=10, min_gap=0.3)
    assert len(picks) >= 6
    labels = {lb for _, lb in picks}
    assert picks[0] == (0, "start")
    assert picks[-1][0] == len(times) - 1
    assert picks[-1][1] == "end"


def test_agent_registry_display_ids():
    import pandas as pd

    df = pd.DataFrame(
        [
            {"name": "Ego", "time": 0, "x": 0, "y": 0, "h": 0, "width": 2.2, "length": 5.0},
            {"name": "Parking", "time": 0, "x": 1, "y": 1, "h": 0, "width": 2.0, "length": 4.5},
        ]
    )
    reg = build_agent_registry(df)
    assert reg[0]["display_id"] == 1 and reg[0]["role"] == "Ego"
    assert reg[1]["display_id"] == 2 and infer_agent_role("Parking") == "Parking"


def test_dataset2_trial_id_mapping():
    b, idx = trial_id_to_csv_indices("dataset2", "8135")
    assert b == 2 and idx == 0
    cfg = get_dataset_config("dataset2")
    assert cfg["xodr"] == "hct_6_no_930.xodr"


def test_load_medoids_dataset2():
    cluster = REPO / "alldatasets/dataset2/selectedClusteringResult_3Clusters.json"
    traj = REPO / "alldatasets/dataset2/trajectories.json"
    if not cluster.is_file():
        pytest.skip("dataset2 clustering missing")
    medoids = load_medoids_from_clustering(str(cluster), "dataset2", str(traj))
    # Only clusters with a local esmini CSV are returned (57 trials for batch 2)
    assert isinstance(medoids, dict)


def test_heading_to_degrees():
    assert abs(_heading_to_degrees(0.0)) < 0.01
    assert abs(_heading_to_degrees(1.57) - 90.0) < 2.0
    assert _heading_to_degrees(45.0) == 45.0


def test_coerce_highlight_road_ids():
    assert _coerce_highlight_road_ids("51,152,206") == {"51", "152", "206"}
    assert _coerce_highlight_road_ids([51, 152]) == {"51", "152"}
    assert _coerce_highlight_road_ids(None) == set()


def test_map_tracks_csv_border_lanes_parsed():
    tracks = REPO / "alldatasets/resources/xodr/hct_6_tracks.csv"
    if not tracks.is_file():
        pytest.skip("hct_6_tracks.csv not generated")
    plotter = MapPlotter()
    lanes, *_ = plotter._parse_and_process_map_data(str(tracks))
    borders = [l for l in lanes if l["type"] == "border"]
    assert len(borders) >= 300


def test_map_tracks_csv_parses():
    tracks = REPO / "alldatasets/resources/xodr/hct_6_tracks.csv"
    if not tracks.is_file():
        pytest.skip("hct_6_tracks.csv not generated — run scripts/generate_map_tracks.py")
    plotter = MapPlotter()
    lanes, *_ = plotter._parse_and_process_map_data(str(tracks))
    assert len(lanes) > 100
    driving = [l for l in lanes if l["type"] == "driving"]
    assert len(driving) > 50


@pytest.mark.skipif(
    not (REPO / "simulation/ros/.cache/scenario_search/records/esmini_1_1000.csv").is_file(),
    reason="esmini CSV for trial 1000 not on disk",
)
def test_tier2_render_one_frame(tmp_path):
    from tier2_renderer import Tier2BevRenderer

    tracks = REPO / "alldatasets/resources/xodr/hct_6_tracks.csv"
    xodr = REPO / "alldatasets/resources/xodr/hct_6.xodr"
    if not tracks.is_file():
        pytest.skip("missing hct_6_tracks.csv")

    renderer = Tier2BevRenderer(str(tracks), str(xodr))
    snaps = renderer.render_trial_from_esmini_csv(
        batch_id=1,
        trial_index=1000,
        output_dir=str(tmp_path),
        n_snapshots=2,
        file_prefix="trial_1000",
    )
    assert len(snaps) == 2
    assert Path(snaps[0].path).is_file()
    assert Path(snaps[0].path).stat().st_size > 5_000
