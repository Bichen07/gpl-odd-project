from __future__ import annotations

from pathlib import Path


def find_repo_root(start: Path) -> Path:
    for p in [start, *start.parents]:
        if p.name == "gpl-odd-project":
            return p
    raise RuntimeError(f"Cannot locate gpl-odd-project root from: {start}")


def pipeline_root(start: Path) -> Path:
    return find_repo_root(start) / "app" / "llm_pipeline"


def artifacts_root(start: Path) -> Path:
    root = pipeline_root(start) / "artifacts"
    root.mkdir(parents=True, exist_ok=True)
    return root
