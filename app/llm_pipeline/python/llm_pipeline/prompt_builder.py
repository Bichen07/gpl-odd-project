from __future__ import annotations

import hashlib
import json
from pathlib import Path

from .paths import pipeline_root, artifacts_root


def _read(path: Path) -> str:
    return path.read_text(encoding="utf-8")


def build_prompt(source_file: str | Path, run_id: str, template_version: str = "v1") -> Path:
    source = Path(source_file).resolve()
    root = pipeline_root(source)
    artifacts = artifacts_root(source)

    stage2_dir = artifacts / "stage2_context" / run_id
    stage3_dir = artifacts / "stage3_prompt" / run_id
    stage3_dir.mkdir(parents=True, exist_ok=True)

    context_md = _read(stage2_dir / "context.md")
    system_tpl = _read(root / "prompt_templates" / f"system_{template_version}.txt")
    analysis_tpl = _read(root / "prompt_templates" / f"analysis_{template_version}.txt")
    rendered = analysis_tpl.replace("{{context_markdown}}", context_md)

    prompt_input = {
        "run_id": run_id,
        "stage": "stage3_prompt",
        "template_version": template_version,
        "system_prompt": system_tpl,
        "prompt": rendered,
        "metadata": {
            "context_sha256": hashlib.sha256(context_md.encode("utf-8")).hexdigest(),
        },
    }
    (stage3_dir / "prompt_input.json").write_text(
        json.dumps(prompt_input, indent=2), encoding="utf-8"
    )
    (stage3_dir / "prompt_rendered.txt").write_text(rendered, encoding="utf-8")
    (stage3_dir / "prompt_meta.json").write_text(
        json.dumps(prompt_input["metadata"], indent=2), encoding="utf-8"
    )
    return stage3_dir / "prompt_input.json"
