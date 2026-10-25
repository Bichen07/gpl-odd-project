"""Provenance-preserving source helpers for Phase A capability cards."""
from __future__ import annotations

import hashlib
from pathlib import Path
from typing import Any, Dict, Iterable, Optional
from xml.etree import ElementTree


def sha256_file(path: str | Path) -> Optional[str]:
    candidate = Path(path)
    if not candidate.is_file():
        return None
    digest = hashlib.sha256()
    with candidate.open("rb") as source:
        for block in iter(lambda: source.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def snapshot_input(snapshot: Optional[Dict[str, Any]], key: str) -> Optional[Dict[str, Any]]:
    """Return exactly one declared snapshot input; duplicate keys are invalid."""
    matches = [item for item in (snapshot or {}).get("inputs", []) if item.get("key") == key]
    if len(matches) > 1:
        raise ValueError("capability snapshot contains duplicate key {!r}".format(key))
    return dict(matches[0]) if matches else None


def valid_persisted_collision(events: Iterable[Dict[str, Any]] | None) -> Optional[Dict[str, Any]]:
    """Return the first recorded collision event with a positive time."""
    for event in events or []:
        if not str(event.get("name") or "").startswith("collisionWith"):
            continue
        if event.get("timeStatus", "recorded") != "recorded":
            continue
        try:
            if float(event.get("esminiSeconds")) <= 0:
                continue
        except (TypeError, ValueError):
            continue
        if event.get("observation") is None:
            continue
        return dict(event)
    return None


def resolve_vehicle_catalog_performance(
    catalog_path: str | Path, selected_vehicle: Optional[str]
) -> Dict[str, Any]:
    """Resolve performance only for an explicitly selected catalog vehicle.

    Selecting the first catalog entry would turn repository defaults into a
    false claim about a trial.  Dynamic OpenSCENARIO expressions remain
    unavailable until their parameter binding is captured at run time.
    """
    source = Path(catalog_path)
    base = {"sourcePath": str(source), "sourceSha256": sha256_file(source)}
    if not selected_vehicle:
        return {
            **base,
            "status": "unavailable",
            "rationale": "The trial does not record its selected catalog vehicle.",
        }
    if not source.is_file():
        return {**base, "status": "unavailable", "rationale": "Vehicle catalog is unavailable."}
    try:
        root = ElementTree.parse(source).getroot()
        vehicle = next((node for node in root.iter("Vehicle") if node.get("name") == selected_vehicle), None)
        performance = vehicle.find("Performance") if vehicle is not None else None
        if performance is None:
            raise ValueError("vehicle or performance entry not found")
        brake = float(performance.attrib["maxDeceleration"])
        acceleration = float(performance.attrib["maxAcceleration"])
    except (ElementTree.ParseError, KeyError, TypeError, ValueError) as exc:
        return {**base, "status": "unavailable", "rationale": "Catalog performance cannot be resolved: {}".format(exc)}
    return {
        **base,
        "status": "configured",
        "vehicle": selected_vehicle,
        "max_deceleration_mps2": brake,
        "max_acceleration_mps2": acceleration,
    }
