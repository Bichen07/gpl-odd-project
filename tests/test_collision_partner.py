"""Collision partner resolution (GT events + polygon clearance)."""
from __future__ import annotations

import sys
from pathlib import Path

import pandas as pd
import pytest

REPO = Path(__file__).resolve().parents[1]
SRC = REPO / "app" / "analyzer" / "src"
sys.path.insert(0, str(SRC))

from collision_partner import (  # noqa: E402
    augment_interactions,
    collision_interaction_to_medoid_doc,
    enrich_collision_interaction,
    inject_collision_agent_actions,
    parse_collision_from_events,
    polygon_clearance,
    resolve_collision_partner,
)
from csv_roadid_loader import get_csv_road_data  # noqa: E402


def test_polygon_clearance_touching_boxes():
    # Two 4m x 2m cars nose-to-nose, centres 4m apart → gap ≈ 0
    gap = polygon_clearance(0.0, 0.0, 0.0, 2.0, 4.0, 4.0, 0.0, 0.0, 2.0, 4.0)
    assert gap == pytest.approx(0.0, abs=0.05)


def test_parse_collision_gt_from_events():
    meta = [{"track_id": 2, "name": "Opposite"}]
    df = pd.DataFrame(
        {
            "name": ["Ego", "Opposite"],
            "time": [1.0, 1.0],
            "x": [0.0, 3.0],
            "y": [0.0, 0.0],
            "h": [0.0, 3.14],
            "speed": [5.0, 5.0],
            "width": [2.0, 2.0],
            "length": [4.5, 4.5],
        }
    )
    events = [{"name": "collisionWithOpposite", "esminiSeconds": 1.0}]
    partner = parse_collision_from_events(events, meta, df)
    assert partner is not None
    assert partner.partner_name == "Opposite"
    assert partner.partner_track_id == 2
    assert partner.source == "gt_events"


@pytest.mark.skipif(
    not (REPO / "simulation/ros/.cache/scenario_search/records/esmini_2_1188.csv").is_file(),
    reason="batch2 trial 1188 CSV not on disk",
)
def test_batch2_trial_1188_near_miss_partner_name():
    from labeller import _normalize_columns, detect_interactions

    df = get_csv_road_data(2, 1188)
    assert df is not None
    traj = _normalize_columns(
        pd.read_csv(REPO / "results/batch2/4_cluster_s=0.6945/cluster0/trajectory.csv")
    )
    meta = [
        {"track_id": 0, "name": "Ego"},
        {"track_id": 1, "name": "Parking"},
        {"track_id": 2, "name": "Opposite"},
    ]
    base = detect_interactions(traj)
    interactions = augment_interactions(base, df, meta, collided=False)
    near = [iv for iv in interactions if iv["type"] == "NEAR_MISS"]
    assert near, "expected NEAR_MISS on trial 1188"
    assert near[0]["with_name"] == "Opposite"
    assert near[0]["key_time"] == pytest.approx(33.2, abs=0.2)


def test_collision_enrichment_has_kinematics():
    meta = [{"track_id": 0, "name": "Ego"}, {"track_id": 1, "name": "Parking"}]
    df = pd.DataFrame({
        "name": ["Ego", "Parking", "Ego", "Parking"],
        "time": [31.6, 31.6, 31.69, 31.69],
        "x": [10.0, 12.0, 10.5, 12.1],
        "y": [20.0, 20.0, 20.0, 20.0],
        "h": [0.0, 0.0, 0.0, 0.0],
        "speed": [4.3, 0.0, 4.2, 0.0],
        "roadId": [21, 21, 21, 21],
        "laneId": [-1, -1, -1, -1],
        "width": [2.2, 2.0, 2.2, 2.0],
        "length": [5.17, 4.5, 5.17, 4.5],
    })
    iv = enrich_collision_interaction({
        "type": "COLLISION",
        "with_name": "Parking",
        "with_track_id": 1,
        "key_time": 31.69,
        "min_clearance_m": 0.0,
        "source": "polygon",
    }, df, meta)
    assert iv["ego_at_collision"]["speed_mps"] == pytest.approx(4.2, abs=0.1)
    assert iv["partner_at_collision"]["speed_mps"] == 0.0
    doc = collision_interaction_to_medoid_doc(iv)
    assert doc is not None
    assert doc["partner_name"] == "Parking"
    assert doc["ego_speed_mps"] == pytest.approx(4.2, abs=0.1)


def test_inject_collision_agent_actions():
    from description import build_description

    agents = [
        {"track_id": 0, "name": "Ego", "type": "car", "role": "ego", "actions": []},
        {"track_id": 1, "name": "Parking", "type": "car", "role": "npc", "actions": []},
    ]
    iv = enrich_collision_interaction(
        {
            "type": "COLLISION",
            "with_name": "Parking",
            "with_track_id": 1,
            "key_time": 31.69,
            "min_clearance_m": 0.0,
            "source": "polygon",
        },
        pd.DataFrame({
            "name": ["Ego", "Parking"],
            "time": [31.69, 31.69],
            "x": [430.12, 434.18],
            "y": [149.9, 149.9],
            "h": [0.0, 0.0],
            "speed": [4.3, 0.0],
            "roadId": [21, 21],
            "laneId": [-1, -1],
            "width": [2.2, 2.0],
            "length": [5.17, 4.5],
        }),
        [{"track_id": 0, "name": "Ego"}, {"track_id": 1, "name": "Parking"}],
    )
    inject_collision_agent_actions(agents, [iv])
    ego_coll = [a for a in agents[0]["actions"] if a["action"] == "COLLISION"]
    park_coll = [a for a in agents[1]["actions"] if a["action"] == "COLLISION"]
    assert len(ego_coll) == 1
    assert len(park_coll) == 1
    assert ego_coll[0]["attributes"]["with_name"] == "Parking"

    text = build_description({
        "location": "hct_6",
        "duration": 31.69,
        "junction_aware": True,
        "agents": agents,
        "interactions": [iv],
    })
    assert "collides with Parking" in text
    assert "is struck by Ego" in text


@pytest.mark.skipif(
    not (REPO / "simulation/ros/.cache/scenario_search/records/esmini_2_1237.csv").is_file(),
    reason="batch2 collision trial 1237 CSV not on disk",
)
def test_batch2_collision_trial_polygon_partner():
    df = get_csv_road_data(2, 1237)
    assert df is not None
    names = sorted({str(x).strip() for x in df["name"].unique()})
    if "Ego" in names:
        names = ["Ego"] + sorted(n for n in names if n != "Ego")
    meta = [{"track_id": i, "name": n} for i, n in enumerate(names)]
    partner = resolve_collision_partner(df, meta, collided=True)
    assert partner is not None
    assert partner.key_time > 0
    assert partner.min_clearance_m < 2.0
