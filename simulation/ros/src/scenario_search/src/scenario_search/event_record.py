"""Pure helpers for truthful, observation-linked trial events.

The ROS sampler imports this module so the event mapping can be tested without
starting ROS.  A zero timestamp is never promoted to recorded collision data.
"""
from __future__ import absolute_import


def _positive_number(value):
    try:
        return float(value) > 0.0
    except (TypeError, ValueError):
        return False


def snapshot_collision_event(agent_name, observation, observation_index):
    """Create a recorded collision event or return ``None`` when unsafe."""
    if not isinstance(observation, dict) or not str(agent_name or "").strip():
        return None
    if not isinstance(observation_index, int) or observation_index < 0:
        return None
    if not _positive_number(observation.get("time")):
        return None
    if not _positive_number(observation.get("esminiSeconds")):
        return None
    return {
        "name": "collisionWith{}".format(str(agent_name).strip()),
        "time": float(observation["time"]),
        "esminiSeconds": float(observation["esminiSeconds"]),
        "observationIndex": observation_index,
        "source": "sampler_collision_callback",
        "timeStatus": "recorded",
    }


def attach_observation_ids(events, observations):
    """Link event indices to the ordered response from ``/observations/bulk``.

    The bulk endpoint returns creates in input order.  Refuse the entire event
    set when that invariant cannot be established instead of mis-linking it.
    """
    if not isinstance(events, list) or not isinstance(observations, list):
        raise ValueError("events and observations must be lists")
    result = []
    seen = set()
    for event in events:
        if not isinstance(event, dict):
            continue
        index = event.get("observationIndex")
        if not isinstance(index, int) or index < 0 or index >= len(observations):
            raise ValueError("event observationIndex is outside uploaded observations")
        observation = observations[index]
        observation_id = observation.get("id") if isinstance(observation, dict) else None
        if observation_id is None:
            raise ValueError("uploaded observation has no id")
        key = (event.get("name"), index, event.get("source"))
        if key in seen:
            continue
        seen.add(key)
        item = dict(event)
        item["observation"] = observation_id
        item.setdefault("source", "sampler_observation")
        item.setdefault("timeStatus", "recorded")
        result.append(item)
    return result
