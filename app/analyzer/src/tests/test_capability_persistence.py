from pathlib import Path

import pytest

import capability_persistence
from capability_persistence import (
    CapabilityArtifactPersistenceError,
    capability_artifact_metadata,
    persist_capability_card,
)


class _Response:
    def __init__(self, status_code=200, text=""):
        self.status_code = status_code
        self.text = text


def _card_path(monkeypatch, tmp_path: Path) -> Path:
    repo = tmp_path / "repo"
    results = repo / "results"
    path = results / "batch9" / "run" / "cluster0" / "processed" / "capability.yaml"
    path.parent.mkdir(parents=True)
    path.write_text("schema_version: capability-card/v1\n", encoding="utf-8")
    monkeypatch.setattr(capability_persistence, "REPO_ROOT", repo)
    monkeypatch.setattr(capability_persistence, "RESULTS_DIR", results)
    return path


def test_persistence_patches_relative_path_and_hash(monkeypatch, tmp_path: Path):
    path = _card_path(monkeypatch, tmp_path)
    calls = []

    def patch(url, **kwargs):
        calls.append((url, kwargs))
        return _Response(200)

    metadata = persist_capability_card(
        "trial-42",
        path,
        payload_api="http://payload:3020/",
        payload_api_key="test-key",
        request_patch=patch,
    )

    assert metadata["capabilityCardPath"] == "results/batch9/run/cluster0/processed/capability.yaml"
    assert len(metadata["capabilityCardSha256"]) == 64
    assert calls[0][0] == "http://payload:3020/api/trials/trial-42"
    assert calls[0][1]["json"] == {"analysisArtifacts": metadata}
    assert calls[0][1]["headers"] == {"Authorization": "users API-Key test-key"}


def test_persistence_rejects_noncanonical_or_out_of_tree_paths(monkeypatch, tmp_path: Path):
    path = _card_path(monkeypatch, tmp_path)
    wrong_name = path.with_name("other.yaml")
    wrong_name.write_text("x: 1\n", encoding="utf-8")
    with pytest.raises(CapabilityArtifactPersistenceError, match="capability.yaml"):
        capability_artifact_metadata(wrong_name)

    outside = tmp_path / "outside" / "capability.yaml"
    outside.parent.mkdir()
    outside.write_text("x: 1\n", encoding="utf-8")
    with pytest.raises(CapabilityArtifactPersistenceError, match="below results"):
        capability_artifact_metadata(outside)


def test_persistence_fails_when_payload_does_not_acknowledge(monkeypatch, tmp_path: Path):
    path = _card_path(monkeypatch, tmp_path)
    with pytest.raises(CapabilityArtifactPersistenceError, match="HTTP 503"):
        persist_capability_card(
            "trial-42",
            path,
            payload_api="http://payload:3020",
            payload_api_key="test-key",
            request_patch=lambda *_args, **_kwargs: _Response(503, "unavailable"),
        )


def test_persistence_requires_an_api_key(monkeypatch, tmp_path: Path):
    path = _card_path(monkeypatch, tmp_path)
    with pytest.raises(CapabilityArtifactPersistenceError, match="PAYLOAD_API_KEY"):
        persist_capability_card(
            "trial-42", path, payload_api="http://payload:3020", payload_api_key=""
        )
