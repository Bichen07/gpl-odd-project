"""Capture only configuration provenance that can be demonstrated per trial."""
from __future__ import absolute_import

import hashlib
import os


def _project_root(start):
    current = os.path.abspath(start)
    while current and current != os.path.dirname(current):
        if os.path.basename(current) == "gpl-odd-project":
            return current
        current = os.path.dirname(current)
    return None


def _sha256(path):
    if not path or not os.path.isfile(path):
        return None
    digest = hashlib.sha256()
    with open(path, "rb") as source:
        for block in iter(lambda: source.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def build_capability_snapshot():
    """Return a conservative manifest; absent runtime selection stays unavailable."""
    root = _project_root(os.path.dirname(__file__))
    relative_paths = (
        "simulation/ros/src/rss/data/parameters.yaml",
        "sdc/vehicle-configuration/pacifica-1/parameters.yaml",
        "simulation/ros/src/scenario/data/resources/xosc/Catalogs/Vehicles/VehicleCatalog.xosc",
    )
    inputs = []
    for relative_path in relative_paths:
        path = os.path.join(root, relative_path) if root else None
        inputs.append({
            "key": "source_manifest:" + relative_path,
            "status": "unavailable",
            "sourcePath": relative_path,
            "sourceSha256": _sha256(path),
            "rationale": (
                "The file is versioned, but this run does not record the selected "
                "runtime vehicle/controller binding. It cannot establish a trial capability."
            ),
        })
    return {
        "schemaVersion": "capability-snapshot/v1",
        "resolverVersion": "phase-a-provenance/v1",
        "inputs": inputs,
    }
