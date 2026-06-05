# results/

Generated analysis outputs (local only — not committed; see root `.gitignore`).

## Layout (V1)

```
results/
└── <dataset>/                    e.g. dataset1
    └── <n_clusters>/             e.g. 2
        ├── manifest.json
        ├── map/                  hct_6.xodr, hct_6.yaml, hct_6.jpg
        ├── clustering/           selectedClusteringResult.json
        └── cluster<N>/
            ├── medoid.json
            ├── trajectory.csv
            ├── meta.yaml
            ├── action.yaml
            ├── description.txt
            ├── map_overview.jpg
            ├── snapshots/          BEV keyframes (trial_*_t_*.jpg)
            ├── observations.json
            ├── stats.json
            └── cluster_interpretation.yaml   (after LLM step)
```

## How to generate

| Output | Command |
|--------|---------|
| Full cluster dataset + BEV | `bash scripts/build_llm_dataset.sh dataset1 2` |
| Map metadata (one-time) | `python3 scripts/map_preprocess.py --dataset dataset1` |
| LLM interpretation | `bash scripts/run_cluster_interpretation.sh dataset1 2` |

Legacy folders `results/clusters/`, `results/bev/`, and `results/pipeline/` are removed; use the layout above.
