"""Persist canonical Phase A capability-card references to Payload.

Only the canonical card generated for a trial may be persisted.  The helper
accepts no arbitrary output path: cards must live below the repository's
``results/`` directory and have the fixed ``capability.yaml`` filename.
"""
from __future__ import annotations

from pathlib import Path
from typing import Any, Callable, Dict, Optional

import requests

from capability_sources import sha256_file
from repo_paths import REPO_ROOT, RESULTS_DIR


class CapabilityArtifactPersistenceError(RuntimeError):
    """Raised when a local capability card cannot be safely persisted."""


def capability_artifact_metadata(path: str | Path) -> Dict[str, str]:
    """Validate a generated card and return its stable Payload reference."""
    candidate = Path(path).resolve()
    root = RESULTS_DIR.resolve()
    try:
        candidate.relative_to(root)
    except ValueError as exc:
        raise CapabilityArtifactPersistenceError(
            "capability card must be located below results/"
        ) from exc
    if candidate.name != "capability.yaml" or not candidate.is_file():
        raise CapabilityArtifactPersistenceError(
            "canonical capability artifact must be an existing capability.yaml"
        )
    digest = sha256_file(candidate)
    if not digest:
        raise CapabilityArtifactPersistenceError("capability card SHA-256 could not be calculated")
    return {
        "capabilityCardPath": str(candidate.relative_to(REPO_ROOT)),
        "capabilityCardSha256": digest,
    }


def persist_capability_card(
    trial_id: str | int,
    path: str | Path,
    *,
    payload_api: str,
    payload_api_key: str,
    request_patch: Optional[Callable[..., Any]] = None,
    timeout_s: float = 15.0,
) -> Dict[str, str]:
    """PATCH the canonical card reference or raise a visible failure.

    A local artifact alone is insufficient Phase A evidence.  Callers must
    surface this exception and mark the build unsuccessful when the PATCH
    cannot be authenticated, completed, or acknowledged by Payload.
    """
    if not str(trial_id or "").strip():
        raise CapabilityArtifactPersistenceError("trial_id is required for capability artifact persistence")
    if not str(payload_api_key or "").strip():
        raise CapabilityArtifactPersistenceError("PAYLOAD_API_KEY is required for capability artifact persistence")

    metadata = capability_artifact_metadata(path)
    patch = request_patch or requests.patch
    endpoint = "{}/api/trials/{}".format(str(payload_api).rstrip("/"), trial_id)
    try:
        response = patch(
            endpoint,
            headers={"Authorization": "users API-Key {}".format(payload_api_key)},
            json={"analysisArtifacts": metadata},
            timeout=timeout_s,
        )
    except requests.RequestException as exc:
        raise CapabilityArtifactPersistenceError(
            "Payload capability artifact PATCH failed: {}".format(exc)
        ) from exc
    if not 200 <= int(getattr(response, "status_code", 0)) < 300:
        detail = getattr(response, "text", "")
        raise CapabilityArtifactPersistenceError(
            "Payload capability artifact PATCH returned HTTP {}: {}".format(
                getattr(response, "status_code", "unknown"), detail[:300]
            )
        )
    return metadata
