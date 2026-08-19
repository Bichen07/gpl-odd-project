"""Deterministic ego-frame geometry, pass-state, adaptive BEV, and c0/c2 golden."""
from __future__ import annotations

import math
import sys
from pathlib import Path

import numpy as np
import pandas as pd
import pytest

REPO = Path(__file__).resolve().parents[1]
SRC = REPO / "app" / "analyzer" / "src"
if str(SRC) not in sys.path:
    sys.path.insert(0, str(SRC))

from conflict_frame_selector import (  # noqa: E402
    adaptive_half_extent,
    ego_centered_square_bounds,
    ego_frame_xy,
    first_pass_time,
    heading_up_rotation_deg,
    interaction_resolution_from_series,
    pair_geometry_summary,
    pass_state_from_rel_long,
    rolling_ego_motion,
    shared_pair_half_extent,
    _metrics_at,
    _normalize_traj_df,
    _pair_series,
)
from collision_partner import polygon_clearance  # noqa: E402
from csv_roadid_loader import csv_exists, get_csv_road_data  # noqa: E402


def test_ego_frame_xy_ahead_left():
    # Ego at origin facing +X; partner 4 m forward, 3 m left (+Y).
    fwd, left = ego_frame_xy(0.0, 0.0, 0.0, 4.0, 3.0)
    assert fwd == pytest.approx(4.0, abs=1e-6)
    assert left == pytest.approx(3.0, abs=1e-6)


def test_ego_frame_xy_behind_after_heading_90():
    # Ego facing +Y (π/2); partner at world (−3, 1) relative to ego at origin
    # is left and slightly ahead in ego frame? ego +Y: fwd=world y, left=−world x
    fwd, left = ego_frame_xy(0.0, 0.0, math.pi / 2, -3.0, 1.0)
    assert fwd == pytest.approx(1.0, abs=1e-6)
    assert left == pytest.approx(3.0, abs=1e-6)


def test_pass_state_bands():
    assert pass_state_from_rel_long(8.0) == "partner_ahead"
    assert pass_state_from_rel_long(0.0) == "side_overlap"
    assert pass_state_from_rel_long(-8.0) == "partner_behind"
    assert pass_state_from_rel_long(None) is None


def _series_pass_through() -> pd.DataFrame:
    """Partner starts ahead-left, Ego drives past → partner behind."""
    rows = []
    for i in range(21):
        t = i * 0.1
        ego_x = t * 10.0
        rows.append(
            {
                "time": t,
                "ex": ego_x,
                "ey": 0.0,
                "eh": 0.0,
                "ev": 10.0,
                "nx": 12.0,
                "ny": 3.0,
                "nh": 0.0,
                "nv": 0.0,
                "er": 1,
                "el": -1,
                "nr": 1,
                "nl": -1,
            }
        )
    df = pd.DataFrame(rows)
    df["dist"] = np.hypot(df["ex"] - df["nx"], df["ey"] - df["ny"])
    df["closing"] = 0.0
    df["ttc"] = np.inf
    return df


def test_pass_time_hysteresis_and_resolution_pass_first():
    series = _series_pass_through()
    # Partner at x=12; ego crosses x=12+2.5 at t=1.45 → behind after hold 0.3 s
    pt = first_pass_time(series, hold_s=0.3)
    assert pt is not None
    assert pt == pytest.approx(1.45, abs=0.15)
    assert interaction_resolution_from_series(series, peak_t=1.8) == "pass_first"


def test_resolution_yield_when_partner_stays_ahead():
    rows = []
    for i in range(11):
        t = float(i)
        rows.append(
            {
                "time": t,
                "ex": t,
                "ey": 0.0,
                "eh": 0.0,
                "ev": 1.0,
                "nx": t + 12.0,
                "ny": 0.0,
                "nh": 0.0,
                "nv": 1.0,
                "er": 1,
                "el": -1,
                "nr": 1,
                "nl": -1,
            }
        )
    df = pd.DataFrame(rows)
    df["dist"] = 12.0
    df["closing"] = 0.0
    df["ttc"] = np.inf
    assert first_pass_time(df) is None
    assert interaction_resolution_from_series(df, peak_t=5.0) == "yield"


def test_rolling_ego_motion_10mps():
    series = _series_pass_through()
    disp, spd = rolling_ego_motion(series, 1.0, window_s=1.0)
    assert disp == pytest.approx(10.0, abs=0.05)
    assert spd == pytest.approx(10.0, abs=0.05)


def test_polygon_clearance_matches_margin_sign():
    # Two 5.0 x 2.0 boxes, centres 6.0 m apart on x → gap ≈ 1.0 m
    gap = polygon_clearance(0.0, 0.0, 0.0, 2.0, 5.0, 6.0, 0.0, 0.0, 2.0, 5.0)
    assert gap == pytest.approx(1.0, abs=0.05)


def test_adaptive_and_shared_half_extent():
    assert adaptive_half_extent(None) == pytest.approx(8.0)
    assert adaptive_half_extent(5.0) == pytest.approx(8.0)  # clamped min
    close = adaptive_half_extent(20.0)
    assert close == pytest.approx(22.6, abs=0.05)  # d + footprint pad 2.6
    assert adaptive_half_extent(80.0) == pytest.approx(40.0)  # max clamp
    shared = shared_pair_half_extent(5.66, 5.40)
    assert shared == pytest.approx(8.26, abs=0.05)  # max(d)+footprint pad
    xmin, xmax, ymin, ymax = ego_centered_square_bounds((10.0, -4.0), 8.0)
    assert xmin == pytest.approx(2.0)
    assert xmax == pytest.approx(18.0)
    assert ymin == pytest.approx(-12.0)
    assert ymax == pytest.approx(4.0)


def test_heading_up_rotation_deg():
    assert heading_up_rotation_deg(0.0) == pytest.approx(90.0)
    assert heading_up_rotation_deg(90.0) == pytest.approx(0.0)
    assert heading_up_rotation_deg(-90.0) == pytest.approx(180.0)


def test_pair_geometry_summary_late_clearance_split():
    frames = [
        {
            "t_s": 8.0,
            "left_alive": True,
            "right_alive": True,
            "left_pass_state": "partner_ahead",
            "right_pass_state": "partner_ahead",
            "left_clearance_m": 2.0,
            "right_clearance_m": 1.95,
            "left_rel_lat_m": 3.2,
            "right_rel_lat_m": 3.15,
        },
        {
            "t_s": 10.0,
            "left_alive": True,
            "right_alive": True,
            "left_pass_state": "partner_behind",
            "right_pass_state": "partner_behind",
            "left_clearance_m": 0.52,
            "right_clearance_m": 0.26,
            "left_rel_lat_m": 3.26,
            "right_rel_lat_m": 3.15,
        },
        {
            "t_s": 10.3,
            "left_alive": True,
            "right_alive": True,
            "left_pass_state": "partner_behind",
            "right_pass_state": "partner_behind",
            "left_clearance_m": 0.517,
            "right_clearance_m": 0.266,
            "left_rel_lat_m": 3.26,
            "right_rel_lat_m": 3.15,
        },
    ]
    geom = pair_geometry_summary(frames)
    assert geom["left_resolution"] == "pass_first"
    assert geom["right_resolution"] == "pass_first"
    assert geom["left_min_clearance_m"] == pytest.approx(0.517, abs=0.001)
    assert geom["right_min_clearance_m"] == pytest.approx(0.26, abs=0.001)
    assert geom["near_identical_motion"] is True
    div = geom["first_persistent_divergence"]
    assert div is not None
    assert float(div["t_s"]) >= 10.0
    assert "clearance" in div["reason"]


def _cutting_in_series(df: pd.DataFrame):
    dfn = _normalize_traj_df(df)
    name_to_tid = (
        dfn.drop_duplicates("name")[["name", "trackId"]]
        .set_index("name")["trackId"]
        .to_dict()
    )
    tid = name_to_tid.get("CuttingIn")
    if tid is None:
        return None, dfn
    return _pair_series(dfn, int(tid)), dfn


def _shared_t_to_esmini(df: pd.DataFrame, t_shared: float) -> float:
    from parameter_space_pair_packs import estimate_clip_start_from_esmini_df

    clip = estimate_clip_start_from_esmini_df(df) or 0.0
    return float(clip) + float(t_shared)


@pytest.mark.skipif(
    not csv_exists(9, 3673) or not csv_exists(9, 2045),
    reason="batch9 pair CSVs (trials 3673/2045) not on disk",
)
def test_c0_c2_pass_first_and_late_clearance_margin():
    df0 = get_csv_road_data(9, 3673)
    df2 = get_csv_road_data(9, 2045)
    assert df0 is not None and df2 is not None
    s0, n0 = _cutting_in_series(df0)
    s2, n2 = _cutting_in_series(df2)
    assert s0 is not None and s2 is not None
    assert interaction_resolution_from_series(s0) == "pass_first"
    assert interaction_resolution_from_series(s2) == "pass_first"

    t0 = _shared_t_to_esmini(df0, 10.27)
    t2 = _shared_t_to_esmini(df2, 10.27)
    m0 = _metrics_at(s0, t0, "CuttingIn", None, source_df=n0)
    m2 = _metrics_at(s2, t2, "CuttingIn", None, source_df=n2)
    assert m0["pass_state"] == "partner_behind"
    assert m2["pass_state"] == "partner_behind"
    # Signed geometry at the diagnosed stamp (plan: c0 fwd=-4.626/left=3.257).
    assert m0["rel_long_m"] == pytest.approx(-4.626, abs=0.05)
    assert m0["rel_lat_m"] == pytest.approx(3.257, abs=0.05)
    assert m2["rel_long_m"] == pytest.approx(-4.382, abs=0.05)
    assert m2["rel_lat_m"] == pytest.approx(3.153, abs=0.05)
    assert m0["clearance_m"] is not None and m2["clearance_m"] is not None
    # c0 keeps a positive footprint gap; c2 is in contact (GT collision).
    assert m0["clearance_m"] > m2["clearance_m"]
    assert m0["clearance_m"] > 0.15
    assert m2["clearance_m"] < 0.05

    # Instantaneous Δv at t=8 is not the geometric split: rolling speeds similar.
    t0_early = _shared_t_to_esmini(df0, 8.0)
    t2_early = _shared_t_to_esmini(df2, 8.0)
    e0 = _metrics_at(s0, t0_early, "CuttingIn", None, source_df=n0)
    e2 = _metrics_at(s2, t2_early, "CuttingIn", None, source_df=n2)
    if e0["rolling_speed_1s_mps"] is not None and e2["rolling_speed_1s_mps"] is not None:
        assert abs(e0["rolling_speed_1s_mps"] - e2["rolling_speed_1s_mps"]) < 1.5


@pytest.mark.skipif(
    not csv_exists(9, 2070),
    reason="batch9 medoid CSV trial 2070 not on disk",
)
def test_c0_medoid_is_pass_first_not_yield():
    df = get_csv_road_data(9, 2070)
    assert df is not None
    series, _ = _cutting_in_series(df)
    assert series is not None
    assert interaction_resolution_from_series(series) == "pass_first"
    assert first_pass_time(series) is not None


def test_event_gloss_uses_same_noun_and_pair_times():
    from conflict_frame_selector import _event_gloss

    action = {
        "agents": [
            {
                "name": "Ego",
                "track_id": 0,
                "actions": [
                    {"action": "ACCELERATE", "start_time": 2.4, "end_time": 6.9},
                ],
            }
        ]
    }
    assert (
        _event_gloss("ego_start_ACCELERATE", t=2.4, action_data=action)
        == "Ego begins acceleration (ends at t=6.90 s)"
    )
    assert (
        _event_gloss("ego_end_ACCELERATE", t=6.9, action_data=action)
        == "Ego ends acceleration (started at t=2.40 s)"
    )
    assert _event_gloss("ego_start_ACCELERATE") == "Ego begins acceleration"
