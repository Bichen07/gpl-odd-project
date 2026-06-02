# results/

Canonical output directory for all gpl-odd-project analysis artifacts.

```
results/
├── clusters/         # LLM cluster-interpretation runs (was llm_artifacts/)
│   └── <run_id>/
│       ├── manifest.json
│       ├── map/                  hct_6.xodr
│       ├── clustering/           embeddings.json, selectedClusteringResult.json
│       └── clusters/cluster_*/
│           ├── bev/              trial_<id>_t_<time>_<label>.jpg
│           ├── trajectory.csv    xosc_gen-format ground truth
│           ├── meta.yaml         scenario metadata
│           ├── stats.json        cluster statistics
│           └── cluster_interpretation.yaml  LLM output
│
├── bev/              Standalone BEV test runs (run_bev_tier2.sh)
│   └── bev_<dataset>_<N>cl/
│       └── <dataset>/cluster_num<N>/cluster_*/
│           └── trial_<id>_t_<time>_<label>.jpg
│
└── pipeline/         Stage 1–5 LLM pipeline debug captures
    └── stage<N>_*/
        └── <run_id>/
```

## How output is generated

| Output | Script / API | Destination |
|--------|-------------|-------------|
| Cluster artifacts + BEV | `bash scripts/build_llm_dataset.sh dataset1 4` | `results/clusters/<run_id>/` |
| BEV-only test | `bash scripts/run_bev_tier2.sh dataset1 3` | `results/bev/bev_dataset1_3cl/` |
| Stage 1–5 pipeline | LLM pipeline CLI | `results/pipeline/<stage>/<run_id>/` |
| Dashboard BEV | `POST /api/llm-artifacts/generate-bev` | `results/clusters/<runId>/clusters/*/bev/` |
