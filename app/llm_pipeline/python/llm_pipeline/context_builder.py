from __future__ import annotations

import json
from pathlib import Path
from typing import Any

from .paths import artifacts_root


def _load_stage1_records(stage1_dir: Path) -> list[dict[str, Any]]:
    records: list[dict[str, Any]] = []
    for p in sorted(stage1_dir.glob("*.json")):
        if p.name == "summary.txt":
            continue
        try:
            records.append(json.loads(p.read_text(encoding="utf-8")))
        except Exception:
            continue
    return records


def build_context(source_file: str | Path, run_id: str) -> Path:
    root = artifacts_root(Path(source_file))
    stage1_dir = root / "stage1_capture" / run_id
    stage2_dir = root / "stage2_context" / run_id
    stage2_dir.mkdir(parents=True, exist_ok=True)

    records = _load_stage1_records(stage1_dir)
    event_names = [r.get("event", "unknown") for r in records]
    sample_payload = [r.get("payload", {}) for r in records[:5]]

    context = {
        "run_id": run_id,
        "stage": "stage2_context",
        "summary": f"Captured {len(records)} stage1 events for run {run_id}.",
        "sections": [
            {
                "title": "Observed Events",
                "content": ", ".join(event_names) if event_names else "No stage1 records found.",
            },
            {
                "title": "Sample Payload Preview",
                "content": json.dumps(sample_payload, indent=2),
            },
        ],
    }

    context_json = stage2_dir / "context.json"
    context_json.write_text(json.dumps(context, indent=2), encoding="utf-8")

    context_md = stage2_dir / "context.md"
    md_lines = [
        f"# Context for Run `{run_id}`",
        "",
        context["summary"],
        "",
        "## Observed Events",
        context["sections"][0]["content"],
        "",
        "## Sample Payload Preview",
        "```json",
        context["sections"][1]["content"],
        "```",
        "",
    ]
    context_md.write_text("\n".join(md_lines), encoding="utf-8")
    return context_json
