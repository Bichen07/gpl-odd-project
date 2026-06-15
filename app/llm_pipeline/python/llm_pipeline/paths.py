from __future__ import annotations

from pathlib import Path


def find_repo_root(start: Path) -> Path:
    for p in [start, *start.parents]:
        if (p / "alldatasets").is_dir() and (p / "app" / "analyzer").is_dir():
            return p
        if p.name == "gpl-odd-project":
            return p
    raise RuntimeError(f"Cannot locate gpl-odd-project root from: {start}")


def pipeline_root(start: Path) -> Path:
    return find_repo_root(start) / "app" / "llm_pipeline"


def analyzer_src(start: Path) -> Path:
    return find_repo_root(start) / "app" / "analyzer" / "src"


def results_dir(start: Path) -> Path:
    return find_repo_root(start) / "results"


def clusters_dir(start: Path) -> Path:
    return results_dir(start) / "clusters"


def prompt_templates_dir(start: Path) -> Path:
    return pipeline_root(start) / "prompt_templates"


def artifacts_root(start: Path) -> Path:
    root = pipeline_root(start) / "artifacts"
    root.mkdir(parents=True, exist_ok=True)
    return root


# Module-level defaults (repo root from this file's location)
_PKG_ROOT = Path(__file__).resolve()
REPO_ROOT = find_repo_root(_PKG_ROOT)
ANALYZER_SRC = analyzer_src(_PKG_ROOT)
RESULTS_DIR = results_dir(_PKG_ROOT)
CLUSTERS_DIR = clusters_dir(_PKG_ROOT)
PROMPT_TEMPLATES_DIR = prompt_templates_dir(_PKG_ROOT)
