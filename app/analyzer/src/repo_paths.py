"""Repository and analyzer paths (stable regardless of invocation directory)."""
from __future__ import annotations

from pathlib import Path


def repo_root() -> Path:
    here = Path(__file__).resolve().parent
    for candidate in (here, *here.parents):
        # The analyzer app is the stable marker; accept any of the top-level
        # project dirs alongside it. alldatasets/ is no longer used.
        if (candidate / "app" / "analyzer").is_dir() and (
            (candidate / "scripts").is_dir()
            or (candidate / "results").is_dir()
        ):
            return candidate
    return here.parents[2]


REPO_ROOT = repo_root()
ANALYZER_SRC = REPO_ROOT / "app" / "analyzer" / "src"

# All generated outputs live under results/
RESULTS_DIR     = REPO_ROOT / "results"
MAP_DIR         = RESULTS_DIR / "map"        # shared generated map assets (xodr, tracks, yaml, jpg)
CLUSTERS_DIR    = RESULTS_DIR / "clusters"   # per-run cluster + LLM artifacts
BEV_DIR         = RESULTS_DIR / "bev"        # standalone BEV test outputs
PIPELINE_DIR    = RESULTS_DIR / "pipeline"   # stage 1-5 LLM pipeline captures
