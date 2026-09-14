from __future__ import annotations

from pathlib import Path
from typing import Optional


def find_repo_root(start: Path) -> Path:
    for p in [start, *start.parents]:
        if (p / "results").is_dir() and (p / "app" / "analyzer").is_dir():
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


_RUN_ARTIFACTS = {
    "selection_eval": ("cross_cluster/input", "cluster_selection_eval.json"),
    "cross_eval": ("cross_cluster/output", "cross_cluster_eval.json"),
    "quality": ("analysis/quality", "clustering_quality.json"),
    "label_review": ("analysis/quality", "cluster_label_review.json"),
    "split_summary": ("analysis/logs", "split_analysis_summary.json"),
    "odd_all_trials": ("analysis/odd/input", "odd_all_trials.json"),
    "odd_boundary_export": ("analysis/odd/output", "odd_boundary_export.json"),
    "odd_boundary_snapshot": ("analysis/odd/snapshots", None),
    "odd_rules": ("analysis/odd/output", "odd_parameter_rules.json"),
    "odd_join": ("analysis/odd/output", "odd_boundary_pairs_join.json"),
    "odd_briefing": ("analysis/odd/output", "odd_chat_briefing.json"),
    "odd_chat_log": ("analysis/logs", "odd_chat_log.jsonl"),
    "paper_source": ("analysis/metadata", "PAPER_SOURCE.json"),
}

_PREVIOUS_RUN_ARTIFACT_DIRS = {
    "quality": "quality",
    "split_summary": "logs",
    "odd_all_trials": "odd/input",
    "odd_boundary_export": "odd/output",
    "odd_boundary_snapshot": "odd/snapshots",
    "odd_rules": "odd/output",
    "odd_join": "odd/output",
    "odd_briefing": "odd/output",
    "odd_chat_log": "logs",
    "paper_source": "metadata",
}


def run_source_dir(run_dir: Path, *, write: bool = False) -> Path:
    """Resolve shared core artifacts, falling back for legacy ``source/`` runs."""
    root = Path(run_dir)
    nested = root / "source"
    if write:
        root.mkdir(parents=True, exist_ok=True)
        return root
    return nested if nested.is_dir() and not (root / "manifest.json").exists() else root


def run_source_path(run_dir: Path, *parts: str, write: bool = False) -> Path:
    """Resolve a core artifact at the run root or in legacy ``source/``."""
    root = Path(run_dir)
    direct = root / Path(*parts)
    legacy = root / "source" / Path(*parts)
    if write:
        direct.parent.mkdir(parents=True, exist_ok=True)
        return direct
    if direct.exists():
        return direct
    if legacy.exists():
        return legacy
    return direct


def run_artifact_path(
    run_dir: Path,
    artifact: str,
    *,
    write: bool = False,
    snapshot_knn: Optional[int] = None,
) -> Path:
    """Resolve an organized run artifact, with legacy root-file fallback.

    Writers use ``write=True`` and always target the organized layout.
    Readers prefer the organized path and fall back to the historical root
    location so existing result folders remain usable during migration.
    """
    if artifact not in _RUN_ARTIFACTS:
        raise KeyError(f"Unknown run artifact: {artifact!r}")
    relative_dir, filename = _RUN_ARTIFACTS[artifact]
    root = Path(run_dir)
    if artifact == "odd_boundary_snapshot":
        if snapshot_knn is None:
            raise ValueError("snapshot_knn is required for odd_boundary_snapshot")
        organized = root / relative_dir / f"odd_boundary_export.kNN{snapshot_knn}.json"
        legacy = root / f"odd_boundary_export.kNN{snapshot_knn}.json"
    else:
        assert filename is not None
        organized = root / relative_dir / filename
        legacy = root / filename
    if write:
        organized.parent.mkdir(parents=True, exist_ok=True)
        return organized
    if organized.exists():
        return organized
    candidates = [legacy]
    previous_dir = _PREVIOUS_RUN_ARTIFACT_DIRS.get(artifact)
    if previous_dir:
        candidates.append(root / previous_dir / organized.name)
    for candidate in candidates:
        if candidate.exists():
            return candidate
    return organized


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
