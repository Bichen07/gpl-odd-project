"""Stage 2b — cluster interpretation from ``llm_artifacts`` or analyzer capture."""

from __future__ import annotations

import json
from pathlib import Path
from typing import Any, Optional

from .capture import PipelineCapture
from .cluster_interpretation_pipeline import run_stage2b_for_run_dir
from .paths import find_repo_root


def _load_manifest(run_dir: Path) -> dict[str, Any]:
    path = run_dir / "manifest.json"
    if not path.is_file():
        return {}
    return json.loads(path.read_text(encoding="utf-8"))


def resolve_run_dir(repo_root: Path, run_id: str) -> Path:
    llm_run = repo_root / "llm_artifacts" / run_id
    if llm_run.is_dir():
        return llm_run
    raise FileNotFoundError(
        f"Run directory not found: {llm_run}\n"
        "Build Phase 4 artifacts first, e.g.:\n"
        f"  bash scripts/build_llm_dataset.sh dataset1 3 {run_id}"
    )


def cluster_interpret(
    source_file: Path,
    run_id: str,
    dataset: Optional[str] = None,
    model: str = "gemini-2.5-flash",
    dry_run: bool = False,
) -> Path:
    repo_root = find_repo_root(source_file)
    run_dir = resolve_run_dir(repo_root, run_id)
    manifest = _load_manifest(run_dir)
    ds = dataset or manifest.get("dataset")
    if not ds:
        raise ValueError(
            "dataset not found in manifest; pass --dataset dataset1"
        )

    capture = PipelineCapture(source_file)
    capture.record(
        "stage2b_cluster_interpretation",
        run_id,
        "start",
        {"dataset": ds, "model": model, "dry_run": dry_run},
    )

    outputs = run_stage2b_for_run_dir(
        run_dir,
        ds,
        model=model,
        dry_run=dry_run,
    )

    stage2b_dir = (
        repo_root
        / "app"
        / "llm_pipeline"
        / "artifacts"
        / "stage2b_cluster_interpretation"
        / run_id
    )
    stage2b_dir.mkdir(parents=True, exist_ok=True)
    for label, path in outputs.items():
        src = Path(path)
        if src.is_file():
            dest = stage2b_dir / f"cluster_{label}_interpretation.yaml"
            dest.write_text(src.read_text(encoding="utf-8"), encoding="utf-8")

    summary = {"run_id": run_id, "dataset": ds, "clusters": outputs}
    (stage2b_dir / "summary.json").write_text(
        json.dumps(summary, indent=2), encoding="utf-8"
    )
    capture.record(
        "stage2b_cluster_interpretation",
        run_id,
        "complete",
        summary,
    )
    return stage2b_dir
