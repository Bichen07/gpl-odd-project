# Stage Owner Map

This document lists stage inputs/outputs, owner files, and verification commands.

## Stage 0: Contracts and Layout

- Inputs: none.
- Outputs:
  - `app/llm_pipeline/contracts/*.schema.json`
  - `app/llm_pipeline/prompt_templates/*`
  - `app/llm_pipeline/python/llm_pipeline/*`
- Owner files:
  - `app/llm_pipeline/python/llm_pipeline/paths.py`
  - `app/llm_pipeline/python/llm_pipeline/capture.py`
- Verify:
  - `python -m app.llm_pipeline.python.llm_pipeline.cli --help`

## Stage 1: Capture Existing Pipeline IO

- Inputs:
  - Sampling API request/response payloads.
  - Simulation suggest/register payloads.
  - Analyzer request/response payloads.
- Outputs:
  - `app/llm_pipeline/artifacts/stage1_capture/<run_id>/*.json`
  - `app/llm_pipeline/artifacts/stage1_capture/<run_id>/summary.txt`
- Owner files:
  - `app/sampling/src/controller.py`
  - `app/sampling/src/handler.py`
  - `simulation/ros/src/scenario_search/src/scenario_search/single_parameterized_scenario_search.py`
  - `app/analyzer/src/controller.py`
- Verify:
  - Run one sampling/analyzer request and check artifact files are generated.

## Stage 2: Context Build

- Inputs:
  - `stage1_capture` JSON artifacts.
- Outputs:
  - `app/llm_pipeline/artifacts/stage2_context/<run_id>/context.json`
  - `app/llm_pipeline/artifacts/stage2_context/<run_id>/context.md`
- Owner file:
  - `app/llm_pipeline/python/llm_pipeline/context_builder.py`
- Verify:
  - `python -m app.llm_pipeline.python.llm_pipeline.cli context --run-id <run_id>`

## Stage 3: Prompt Build

- Inputs:
  - `context.md`
  - `prompt_templates/system_v1.txt`
  - `prompt_templates/analysis_v1.txt`
- Outputs:
  - `app/llm_pipeline/artifacts/stage3_prompt/<run_id>/prompt_input.json`
  - `app/llm_pipeline/artifacts/stage3_prompt/<run_id>/prompt_rendered.txt`
  - `app/llm_pipeline/artifacts/stage3_prompt/<run_id>/prompt_meta.json`
- Owner file:
  - `app/llm_pipeline/python/llm_pipeline/prompt_builder.py`
- Verify:
  - `python -m app.llm_pipeline.python.llm_pipeline.cli prompt --run-id <run_id>`

## Stage 4: LLM Runner

- Inputs:
  - Stage 3 prompt artifacts and LLM env (`LLM_API_KEY`, `LLM_MODEL`, `LLM_ENDPOINT`).
- Outputs:
  - `app/llm_pipeline/artifacts/stage4_llm/<run_id>/request.json`
  - `app/llm_pipeline/artifacts/stage4_llm/<run_id>/response.json`
  - `app/llm_pipeline/artifacts/stage4_llm/<run_id>/result.md`
  - `app/llm_pipeline/artifacts/stage4_llm/<run_id>/latency_cost.json`
- Owner file:
  - `app/llm_pipeline/python/llm_pipeline/llm_runner.py`
- Verify:
  - `python -m app.llm_pipeline.python.llm_pipeline.cli llm --run-id <run_id>`

## Stage 5: Evaluation

- Inputs:
  - Stage 1-4 outputs.
- Outputs:
  - `app/llm_pipeline/artifacts/stage5_eval/<run_id>/evaluation_report.json`
  - `app/llm_pipeline/artifacts/stage5_eval/<run_id>/evaluation_report.md`
- Owner file:
  - `app/llm_pipeline/python/llm_pipeline/evaluate.py`
- Verify:
  - `python -m app.llm_pipeline.python.llm_pipeline.cli eval --run-id <run_id>`

## Stage 6: Dashboard Integration

- Inputs:
  - Artifact tree under `app/llm_pipeline/artifacts`.
- Outputs:
  - Dashboard tab for listing runs and viewing stage files.
- Owner files:
  - `app/dashboard/src/app/api/llm-artifacts/route.ts`
  - `app/dashboard/src/app/batch/[id]/_tabs/explore/components/dock/panels/LlmAnalysis/index.tsx`
  - `app/dashboard/src/app/batch/[id]/_tabs/explore/components/dock/layout.tsx`
- Verify:
  - Open batch page and confirm `LLM Analysis` tab renders artifact content.
