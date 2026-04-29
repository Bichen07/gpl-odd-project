from __future__ import annotations

import json
from pathlib import Path

from .paths import artifacts_root


REQUIRED_FILES = {
    "stage1_capture": ["summary.txt"],
    "stage2_context": ["context.json", "context.md"],
    "stage3_prompt": ["prompt_input.json", "prompt_rendered.txt", "prompt_meta.json"],
    "stage4_llm": ["request.json", "response.json", "result.md", "latency_cost.json"],
}


def evaluate_run(source_file: str | Path, run_id: str) -> Path:
    root = artifacts_root(Path(source_file))
    report = {"run_id": run_id, "stages": {}, "ok": True}

    for stage, files in REQUIRED_FILES.items():
        stage_dir = root / stage / run_id
        missing = [f for f in files if not (stage_dir / f).exists()]
        stage_ok = len(missing) == 0
        report["stages"][stage] = {"ok": stage_ok, "missing": missing}
        report["ok"] = report["ok"] and stage_ok

    report_dir = root / "stage5_eval" / run_id
    report_dir.mkdir(parents=True, exist_ok=True)

    (report_dir / "evaluation_report.json").write_text(
        json.dumps(report, indent=2), encoding="utf-8"
    )
    md = ["# Evaluation Report", "", f"- run_id: `{run_id}`", f"- ok: `{report['ok']}`", ""]
    for stage, info in report["stages"].items():
        md.append(f"## {stage}")
        md.append(f"- ok: `{info['ok']}`")
        if info["missing"]:
            md.append("- missing:")
            md.extend([f"  - {x}" for x in info["missing"]])
        else:
            md.append("- missing: none")
        md.append("")
    (report_dir / "evaluation_report.md").write_text("\n".join(md), encoding="utf-8")
    return report_dir / "evaluation_report.md"
