# Paper case studies (IEEE ITS 2026)

Offline mirror of senior Payload assets + Path A export into `results/` so your
existing analyzer / LLM can use **the same clusters as the paper**.

## Layout

```text
data/paper_casestudies/     ← Layer A backup (gitignored binaries)
scripts/paper_casestudies/  ← download / export / import helpers
results/batch7|8|9…/        ← Path A cluster skeletons (for LLM)
```

| Paper | Batch | Analysis zip | Ego / k |
|-------|-------|--------------|---------|
| Case Study 1 | 7 | `casestudy1_twoAVs.zip` | ITRI k=4, ITRILatest k=3 |
| Case Study 2 | 9 | `casestudy2.zip` | ITRI k=4 |
| Case Study 3 | 8 | `casestudy3.zip` | ITRI k=6 |

## 1. Download mirror (while senior server is up)

```bash
python3 scripts/paper_casestudies/download_mirror.py
# or:
PAYLOAD_API_URL=https://gpl-odd-payloadcms.chiu41.com \
PAYLOAD_API_KEY=… \
python3 scripts/paper_casestudies/download_mirror.py
```

## 2. Export paper clusters → `results/` (Path A)

```bash
python3 scripts/paper_casestudies/export_clusters_to_results.py
```

Creates e.g. `results/batch9/4_cluster_s=0.7482/` with:

- `clustering/selectedClusteringResult.json` (paper labels)
- `manifest.json` + `cluster*/cluster.json` skeletons
- `PAPER_SOURCE.json`

Case 1 System B lands under `results/batch7_ITRILatest/…`.

## 3. Local / lab Payload + Dashboard (batches 1–4 and 7–9)

Your lab Payload is `http://140.113.208.174:3020` (same as `localhost:3020`).

**One-shot import** (uploads media, rewrites URLs off senior’s host, creates batches 7–9):

```bash
python3 scripts/paper_casestudies/migrate_to_lab_payload.py
```

This creates:

| Paper | Lab batch | Lab session | Saved analysis |
|-------|-----------|-------------|----------------|
| Case Study 1 | **7** | `paper_cs1` | `lab_casestudy1_twoAVs.zip` |
| Case Study 3 | **8** | `paper_cs3` | `lab_casestudy3.zip` |
| Case Study 2 | **9** | `paper_cs2` | `lab_casestudy2.zip` |

Batches **5–6** are unused placeholders (needed so paper keeps ids 7–9).

Dashboard `.env` should be:

```env
NEXT_PUBLIC_PAYLOAD_API_ADDRESS=http://140.113.208.174:3020
NEXT_PUBLIC_PAYLOAD_API_KEY=4a18c49f-0d97-45a9-9a1f-4088d456541e
```

Restart Dashboard. You get **your batches 1–4** and **paper batches 7–9** without senior’s PC.

## 4. Fill BEV / run your LLM (existing code)

Paper Path A folders are **skeletons only** (labels + `cluster.json`). They do
**not** look like a local Mission Control run: there are no
`simulation/ros/.cache/scenario_search/records/esmini_*.csv` for senior batch 7.

**CSV source for paper CS2 (batch 9):** convert the already-mirrored trajectories
zip (no senior PC required):

```bash
# writes esmini_7_<trial_index>.csv into simulation/ros/.cache/.../records/
python3 scripts/paper_casestudies/materialize_esmini_csv_from_trajectories.py \
  --analysis-zip data/paper_casestudies/case2/casestudy2.zip \
  --trajectories-zip data/paper_casestudies/case2/trajectories-259.zip \
  --results-dir results/batch9/4_cluster_s=0.7482
```

Then build the full pack (BEV / action / boundaries) and LLM:

```bash
conda activate analyzer
export PYTHONPATH="app/analyzer/src:app/llm_pipeline/python"

python3 app/analyzer/src/dataset_builder.py \
  --source payload-save --batch-id 9 --k 4 \
  --dataset dataset2 --ego-name ITRI \
  --analysis-zip data/paper_casestudies/case2/casestudy2.zip \
  --from-run results/batch9/4_cluster_s=0.7482 \
  --xodr results/map/hct_6_no_930.xodr \
  --param-boundaries all

bash scripts/run_cluster_analyze.sh \
  --results-dir results/batch9/4_cluster_s=0.7482 \
  --batch-id 9 \
  --products medoid,summary,parameter-space-pairs --no-review
```

Or list candidates offline:

```bash
python3 app/analyzer/src/dataset_builder.py \
  --source payload-save --batch-id 7 --list-clusterings \
  --analysis-zip data/paper_casestudies/case1/casestudy1_twoAVs.zip \
  --ego-name ITRI
```

## Why Path A export?

Senior’s zip has clustering for Dashboard, not `results/` BEV packs.
Export copies **paper cluster membership** into `results/` so your LLM compares
to the paper figures; `dataset_builder --from-run` then fills BEV without
re-clustering.
