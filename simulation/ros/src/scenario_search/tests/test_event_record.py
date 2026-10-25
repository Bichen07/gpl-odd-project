from scenario_search.event_record import attach_observation_ids, snapshot_collision_event


def test_collision_snapshot_preserves_the_current_observation_time():
    event = snapshot_collision_event(
        "Opposite", {"time": 12.5, "esminiSeconds": 4.25}, 7
    )
    assert event == {
        "name": "collisionWithOpposite",
        "time": 12.5,
        "esminiSeconds": 4.25,
        "observationIndex": 7,
        "source": "sampler_collision_callback",
        "timeStatus": "recorded",
    }


def test_collision_snapshot_rejects_zero_or_missing_timestamps():
    assert snapshot_collision_event("Opposite", {"time": 0, "esminiSeconds": 1}, 0) is None
    assert snapshot_collision_event("Opposite", {"time": 1}, 0) is None


def test_event_linking_uses_bulk_response_order_and_deduplicates():
    event = snapshot_collision_event("Opposite", {"time": 1, "esminiSeconds": 2}, 1)
    linked = attach_observation_ids([event, event], [{"id": 41}, {"id": 42}])
    assert linked == [{**event, "observation": 42}]
