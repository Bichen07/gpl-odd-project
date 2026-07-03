# GPL-ODD LLM Pipeline

Multimodal LLM interpretation of behavioral **clusters** produced by the analyzer
(`results/batch<id>/<k>_cluster_s=<sil>/cluster<N>/`). The dashboard "Select and
analyze" page is the primary entry point.

## Layout

- `prompt_templates/`: the four editable cluster-interpretation prompts
  (`cluster_system_prompt.txt`, `cluster_common_sense.txt`,
  `cluster_interaction_prompt.txt`, `cluster_reviewer_prompt.txt`).
- `python/llm_pipeline/`: the Python package.
- `requirements-llm.txt`: Python dependencies for this pipeline.

Runtime debug dumps (`PipelineCapture`) are written to `artifacts/` at run time;
that folder is git-ignored and safe to delete.

## Python package

| Module | Role |
|--------|------|
| `cli.py` | Entry point: `python -m llm_pipeline.cli cluster-interpret …` |
| `cluster_interpretation_pipeline.py` | Orchestrates per-cluster interpretation from a `results/` folder; also `run_post_analyzer_cluster_interpretation()` for the analyzer controller's auto Phase 6. |
| `cluster_interpreter.py` | `ClusterInterpreter`: two-pass (analysis + reviewer) multimodal LLM calls. |
| `cluster_stats.py` | Cluster/collision statistics (also used by the analyzer's `dataset_builder`). |
| `llm_factory.py` | Model construction + defaults (Gemini / OpenAI). |
| `analyzer_bridge.py` | Makes `app/analyzer/src` importable. |
| `paths.py` | Repo/results/prompt-template path helpers. |
| `capture.py` | `PipelineCapture` debug recorder used by the sampling/analyzer services. |

## CLI usage

Run from project root (the dashboard invokes the first form via
`scripts/run_cluster_analyze.sh`):

```bash
python -m llm_pipeline.cli cluster-interpret \
    --results-dir results/batch2/4_cluster_s=0.6945 --batch-id 2 \
    --model gemini-2.5-flash --temperature 0.1 [--clusters 0,2] [--no-review] [--dry-run]
```
