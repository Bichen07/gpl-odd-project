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
        ├── ic_pairs/cA-cB/           # ParameterSpace / IC closest pairs
        ├── boundary_pairs/cA-cB/     # MFPCA embedding closest pairs
        └── cluster<N>/
            ├── …
            └── highlight_trials/outlier_trials/   # (optional)
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

# Paper case studies (Path A): export labels from local zip, then rebuild BEV
python3 scripts/paper_casestudies/export_clusters_to_results.py
python3 app/analyzer/src/dataset_builder.py --batch-id 9 --k 4 \
  --analysis-zip data/paper_casestudies/case2/casestudy2.zip \
  --from-run results/batch9/4_cluster
```

See `scripts/paper_casestudies/README.md` for mirroring senior Payload offline.

| Output | Command |
|--------|---------|
| Full cluster dataset + BEV | `python3 app/analyzer/src/dataset_builder.py --batch-id 2 --k 4` |
| Map assets | `python3 app/analyzer/src/dataset_builder.py --batch-id 2 --map-only` |
| LLM interpretation | `bash scripts/run_cluster_analyze.sh --results-dir results/batch2/…` |
