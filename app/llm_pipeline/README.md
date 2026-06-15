# GPL-ODD LLM Pipeline

This folder contains stage-based tooling for extracting, transforming, and
running LLM analysis from the GPL-ODD workflow.

## Layout

- `contracts/`: JSON schema contracts for stage outputs.
- `artifacts/`: materialized run artifacts grouped by stage.
- `runs/`: optional run-level logs.
- `prompt_templates/`: versioned prompt templates.
- `python/llm_pipeline/`: reusable Python package (stages 1–6, cluster interpretation, LLM factory)

## Stage Summary

1. Capture raw IO from sampling/simulation/analyzer boundaries.
2. Build compact LLM context from captured artifacts.
3. Render prompt payloads from templates and context.
4. Run LLM request and record traceable outputs.
5. Evaluate stage completeness and schema conformance.
6. Expose artifacts in dashboard panel.

## CLI Usage

Run from project root:

```bash
python -m app.llm_pipeline.python.llm_pipeline.cli context --run-id <run_id>
python -m app.llm_pipeline.python.llm_pipeline.cli prompt --run-id <run_id>
python -m app.llm_pipeline.python.llm_pipeline.cli llm --run-id <run_id>
python -m app.llm_pipeline.python.llm_pipeline.cli eval --run-id <run_id>
```
