# results/

Generated analysis outputs (local only — not committed; see root `.gitignore`).

## Layout

```
results/
├── map/                              # shared map assets (auto-ensured)
└── batch<id>/                        # e.g. batch2
    └── <k>_cluster_s=<silhouette>/   # e.g. 4_cluster_s=0.6945
        ├── manifest.json
        ├── clustering/selectedClusteringResult.json
        └── cluster<N>/
            ├── cluster.json
            ├── context.md
            ├── action.yaml
            ├── description.txt
            ├── trajectory.csv
            ├── map_overview.jpg
            ├── snapshots/              # conflict-centered BEV keyframes
            └── cluster_interpretation.yaml   (after LLM step)
```

## How to generate

```bash
conda activate analyzer

# CREATE complete LLM dataset pack (auto map ensure)
python3 app/analyzer/src/dataset_builder.py --batch-id 2 --k 4

# Map assets only
python3 app/analyzer/src/dataset_builder.py --batch-id 2 --map-only

# REBUILD BEV/labels in an existing pack
python3 app/analyzer/src/dataset_builder.py --batch-id 2 --from-run results/batch2/4_cluster
```

| Output | Command |
|--------|---------|
| Full cluster dataset + BEV | `python3 app/analyzer/src/dataset_builder.py --batch-id 2 --k 4` |
| Map assets | `python3 app/analyzer/src/dataset_builder.py --batch-id 2 --map-only` |
| LLM interpretation | `bash scripts/run_cluster_analyze.sh --results-dir results/batch2/…` |
