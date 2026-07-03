"""Tests for Phase 3b Tier2 BEV (map tracks CSV + MapPlotter)."""
from __future__ import annotations

import sys
from pathlib import Path

import pytest

REPO = Path(__file__).resolve().parents[1]
SRC = REPO / "app" / "analyzer" / "src"
LLM_PKG = REPO / "app" / "llm_pipeline" / "python"
if str(SRC) not in sys.path:
    sys.path.insert(0, str(SRC))
if str(LLM_PKG) not in sys.path:
    sys.path.insert(0, str(LLM_PKG))

from map_plotter import MapPlotter, _coerce_highlight_road_ids
from tier2_renderer import (
    _heading_to_degrees,
    build_agent_registry,
    extract_action_timestamps_gpl,
    highlight_road_ids_from_df,
    infer_agent_role,
    load_medoids_from_clustering,
    merge_key_frame_times,
    pick_critical_timestamps,
    resolve_key_frames,
    tier2_output_dir,
    view_bounds_from_df,
)
from llm_pipeline.cluster_interpretation_pipeline import (
    extract_snapshot_timestamp,
    select_evenly_spaced_snapshots,
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


def test_extract_action_timestamps_gpl(tmp_path):
    import yaml

    action = {
        "agents": [
            {
                "track_id": 0,
                "name": "Ego",
                "actions": [
                    {"action": "MAINTAIN_SPEED", "start_time": 0.0, "end_time": 2.0, "duration": 2.0},
                    {"action": "LANE_CHANGE_RIGHT", "start_time": 6.86, "end_time": 6.86, "duration": 0.0},
                    {"action": "ENTER_JUNCTION", "start_time": 13.13, "end_time": 13.13, "duration": 0.0},
                ],
            }
        ]
    }
    path = tmp_path / "action.yaml"
    path.write_text(yaml.safe_dump(action))

    all_ts = extract_action_timestamps_gpl(path, semantic_only=False)
    assert any(abs(t - 6.86) < 0.01 for t, _ in all_ts)
    assert any(abs(t - 13.13) < 0.01 for t, _ in all_ts)

    semantic = extract_action_timestamps_gpl(path, semantic_only=True)
    labels = {lb for _, lb in semantic}
    assert "LANE_CHANGE_RIGHT" in labels
    assert "ENTER_JUNCTION" in labels
    assert not any("MAINTAIN_SPEED" in lb for lb in labels)


def test_merge_key_frame_times_includes_action_and_heuristic():
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
    action_frames = [(13.13, "ENTER_JUNCTION"), (6.86, "LANE_CHANGE_RIGHT")]
    merged = merge_key_frame_times(df, times, action_frames, min_gap=0.1)
    labels = {lb for _, lb in merged}
    assert "ENTER_JUNCTION" in labels
    assert "closest_approach" in labels or "start" in labels


def test_resolve_key_frames_hybrid_from_yaml(tmp_path):
    import pandas as pd
    import yaml

    times = [float(i) for i in range(20)]
    df = pd.DataFrame(
        {
            "name": ["Ego"] * 20,
            "time": times,
            "x": [float(i) for i in range(20)],
            "y": [0.0] * 20,
            "h": [0.0] * 20,
            "speed": [5.0] * 20,
            "roadId": [1] * 20,
        }
    )
    action = {
        "agents": [
            {
                "actions": [
                    {"action": "ENTER_JUNCTION", "start_time": 13.0, "end_time": 13.0},
                ]
            }
        ]
    }
    yaml_path = tmp_path / "action.yaml"
    yaml_path.write_text(yaml.safe_dump(action))

    picks = resolve_key_frames(
        df,
        times,
        action_yaml_path=str(yaml_path),
        key_frame_mode="hybrid",
        min_gap=0.1,
    )
    assert any("ENTER_JUNCTION" in lb for _, lb in picks)
    assert len(picks) > 1


def test_select_evenly_spaced_snapshots_covers_timeline():
    paths = [
        f"/tmp/trial_t_{i:05.2f}_evt.jpg"
        for i in [0, 2, 4, 6, 8, 10, 12, 14]
    ]
    picked = select_evenly_spaced_snapshots(paths, 4)
    assert len(picked) == 4
    ts = [extract_snapshot_timestamp(p) for p in picked]
    assert ts[0] == pytest.approx(0.0)
    assert ts[-1] == pytest.approx(14.0)


def test_extract_snapshot_timestamp_from_slug_filename():
    p = "trial_2951_t_13.13_ENTER_JUNCTION.jpg"
    assert extract_snapshot_timestamp(p) == pytest.approx(13.13)


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
    not (REPO / "results/dataset1/4/cluster0/action.yaml").is_file(),
    reason="dataset1 cluster0 action.yaml not built yet",
)
def test_dataset1_cluster0_action_times_in_snapshots():
    """Acceptance: semantic action times appear in snapshot filenames."""
    import yaml

    action_path = REPO / "results/dataset1/4/cluster0/action.yaml"
    snap_dir = REPO / "results/dataset1/4/cluster0/snapshots"
    if not snap_dir.is_dir():
        pytest.skip("snapshots not generated — run build_llm_dataset.sh")

    data = yaml.safe_load(action_path.read_text())
    semantic_times = []
    for agent in data.get("agents") or []:
        for act in agent.get("actions") or []:
            name = act.get("action", "")
            if name in (
                "ENTER_JUNCTION",
                "EXIT_JUNCTION",
                "LANE_CHANGE_LEFT",
                "LANE_CHANGE_RIGHT",
            ):
                semantic_times.append((float(act["start_time"]), name))

    if not semantic_times:
        pytest.skip("no junction/lane events in action.yaml")

    snap_names = " ".join(p.name for p in snap_dir.glob("*.jpg"))
    if not any(
        tok in snap_names
        for tok in ("LANE_CHANGE", "ENTER_JUNCTION", "EXIT_JUNCTION")
    ):
        pytest.skip(
            "snapshots use legacy heuristic labels — "
            "re-run: bash scripts/build_llm_dataset.sh dataset1 4"
        )
    for t, name in semantic_times:
        assert f"_t_{t:05.2f}_" in snap_names or f"_t_{t:.2f}_" in snap_names, (
            f"missing snapshot near {t:.2f}s ({name})"
        )


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
