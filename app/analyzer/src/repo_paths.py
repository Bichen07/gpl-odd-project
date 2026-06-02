"""Repository and analyzer paths (stable regardless of subpackage depth)."""
from __future__ import annotations

from pathlib import Path


def repo_root() -> Path:
    here = Path(__file__).resolve().parent
    for candidate in (here, *here.parents):
        if (candidate / "alldatasets").is_dir() and (candidate / "app" / "analyzer").is_dir():
            return candidate
    return here.parents[2]


REPO_ROOT = repo_root()
ANALYZER_SRC = REPO_ROOT / "app" / "analyzer" / "src"
