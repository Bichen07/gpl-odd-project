# Cluster Interpreter Integration Plan (Current Workflow)

> Source baseline: `readMD/DATA_INVENTORY_AND_ANALYSIS.md`  
> Objective: establish a complete, current, and reproducible pipeline from **new** simulation CSV output to clustering and LLM interpretation.

---

## Scope

- This document replaces outdated planning content and historical troubleshooting narratives.
- `old_alldatasets/` is considered a **legacy senior snapshot** and is **not** the main data source for current experiments.
- Current experiments must be based on fresh simulation output:
  - `simulation/ros/.cache/scenario_search/records/esmini_<batch>_<index>.csv`

---

## Key Decisions

1. **Trajectory ground truth:** local esmini CSV (`records/esmini_<batch>_<index>.csv`)
2. **Clustering computation path:** Payload observations -> Analyzer `/trajectory_analysis` (MFPCA + UMAP + HDBSCAN)
3. **Selection path:** Dashboard Explore / Clustering Selection
4. **Offline interpretation path:** `build_llm_dataset.sh` + `run_cluster_interpretation.sh`
5. **`alldatasets/<dataset>/` role:** exported clustering artifacts for reproducibility (not replacement for raw CSV)

---

## Answer to the main concern (old transform method)

Question: do we keep the old transform method from `old_alldatasets`, and which component transforms data?

### Short answer

- The transform method remains **MFPCA + HDBSCAN**, but must run on **new Payload-linked simulation data**.
- Operational components:
  - Simulation + sampler upload observations to Payload
  - Dashboard triggers Analyzer clustering (`/trajectory_analysis`)
  - Selected result is exported/saved to `alldatasets/<dataset>/`
  - Offline build uses cluster files + local CSV for BEV/analysis prompts

### Responsibility table

| Stage | System | Primary implementation |
|---|---|---|
| Simulate and record | Simulation/ROS/esmini | `simulation/ros/src/scenario_search/...` |
| Upload trial/observations | Sampler + Payload API | `scenario_sampler.py`, Payload collections |
| Compute MFPCA/HDBSCAN | Analyzer service | `app/analyzer/src/controller.py` (`/trajectory_analysis`) |
| Select cluster config | Dashboard Explore UI | `app/dashboard` |
| Build medoid artifacts | Analyzer dataset builder | `scripts/build_llm_dataset.sh`, `dataset_builder.py` |
| LLM interpretation | LLM pipeline wrapper | `scripts/run_cluster_interpretation.sh`, `cluster_interpretation_pipeline.py` |

---

## End-to-End Data Flow

```text
Sampling (/initialize, /suggest, /register)
    ->
Simulation (SPSS)
    ->
esmini .dat + dat2csv
    ->
records/esmini_<batch>_<index>.csv    [ground truth]
    ->
sampler posts observations + trial data to Payload
    ->
Dashboard Explore -> Analyzer /trajectory_analysis
    ->
MFPCA + UMAP + HDBSCAN outputs
    ->
chosen clustering result (selectedClusteringResult_<k>Clusters.json)
    ->
build_llm_dataset.sh (uses clustering + local CSV)
    ->
results/<dataset>/<k>/cluster<N>/{trajectory,action,BEV,stats}
    ->
run_cluster_interpretation.sh
    ->
cluster_interpretation.yaml
```

---

## Data Contracts

## 1) Raw simulation contract (authoritative)

Expected per trial:
- `records/esmini_<batch>_<index>.csv`
- `records/scenario_<index>.xosc` (optional but expected in normal runs)

CSV schema:

```text
Version: 2, OpenDRIVE: ..., 3DModel:
time, id, name, x, y, z, h, p, r, roadId, laneId, offset, t, s, speed, wheel_angle, wheel_rot
```

## 2) Clustering artifact contract (fresh run output)

Required for reproducible offline interpretation:
- `alldatasets/<dataset>/clustering.json`
- `alldatasets/<dataset>/selectedClusteringResult_<k>Clusters.json`
- `alldatasets/<dataset>/collision.json` (recommended)
- `alldatasets/<dataset>/trajectories.json` (optional for visualization/debug)

## 3) Interpretation build contract

`build_llm_dataset.sh` requires:
- clustering artifacts above
- map assets (`alldatasets/map`, `alldatasets/resources/xodr`)
- local esmini CSV files matching chosen medoid trials

---

## Current Canonical Workflow

## Phase A — Produce fresh simulation data

1. Set batch id in both places:
   - Sampling: `POST /initialize {"batch_id":"N"}`
   - Launch: `batch_id=N`
2. Run simulation campaign.
3. Confirm CSV files are generated for batch N.
4. Confirm Payload has corresponding trials/observations.

**Checks**

```bash
ls simulation/ros/.cache/scenario_search/records/esmini_<N>_*.csv | wc -l
```

Exit criteria:
- fresh CSV count increases
- Payload batch N has non-zero trials and observations

---

## Phase B — Transform to MFPCA + HDBSCAN

Use Dashboard path:
- Batch -> Explore -> Saves -> Create New -> Analysis
- Analyzer endpoint: `POST http://localhost:9010/trajectory_analysis`

Then:
- choose one clustering in Clustering Selection
- Use Selection
- save/export artifacts to `alldatasets/<dataset>/`

Exit criteria:
- selected clustering for target `k` exists
- exported files correspond to new campaign (not old snapshot)

---

## Where Dashboard analysis data is stored (exact)

This section maps `Analysis`, `Clustering Selection`, and `save` behavior to real storage.

## A) Immediately after clicking **Analysis**

Storage location:
- **Frontend Redux memory only** (`state.batch.trajectoryAnalysis`)

Code path:
- Dashboard calls `getTrajectoryAnalysis()` (`queries/clustering.ts`)
- Response is stored via `batchSlice.actions.setTrajectoryAnalysis(...)`
  in `Saves/index.tsx`

Implication:
- If browser refreshes before saving/loading from Payload, this in-memory analysis is lost.

## B) During Analyzer response generation

Storage location:
- **Payload `documents` collection** (uploaded by Analyzer backend)

Code path (`app/analyzer/src/controller.py`):
- Analyzer zips and uploads:
  - `trajectories.json` (as document; mapped to `heatmapFileinfo` in response)
  - `rawTrajectories.json` (as `trajectories.zip`; mapped to `trajectoriesFileinfo`)
- Upload endpoint: `POST {PAYLOAD_API}/api/documents`

Implication:
- Even without pressing Dashboard `save`, Analyzer can already create document artifacts.
- These are returned in API response metadata, not automatically linked to batch saves list.

## C) After clicking Dashboard **save** in Saves panel

Storage location:
- **Payload `documents` collection** (new zip uploaded by Dashboard)
- **Payload `batches.savedTrajectoryAnalysis`** relation is updated with document id

Code path:
- `Saves/index.tsx`:
  - zips Redux `trajectoryAnalysis` into `trajectories.json` (inside `.zip`)
  - uploads via `postDocument()` -> `/documents`
  - calls `appendBatchTrajectoryAnalysisSave(batchId, docId, existingIds)`
- `queries/batches.ts`:
  - `Batch.savedTrajectoryAnalysis { id, url, filename }` is read/written

Implication:
- This is the authoritative "saved analysis list" shown in Saves panel.
- ClusteringSelection panel itself reads from Redux (loaded analysis), not directly from disk.

## D) ClusteringSelection panel source

Storage location:
- **Redux-selected result** only:
  - `state.batch.selectedClusteringResults`
  - `state.batch.selectedClusterInfos`

Implication:
- Choosing a cluster config updates app state for visualization/next steps.
- To persist for later sessions, save analysis and/or export clustering files.

---

## Can we skip creating `alldatasets/<dataset>/`?

Short answer: **partially**.

## What you can do without `alldatasets/`

- Dashboard visualization, filtering, cluster selection, and interactive review can run directly from:
  - in-memory Redux analysis
  - or a saved analysis document loaded from Payload

## What currently still requires `alldatasets/`

- `scripts/build_llm_dataset.sh` -> `dataset_builder.py` currently expects:
  - `alldatasets/<dataset>/clustering.json`
  - `alldatasets/<dataset>/selectedClusteringResult_<k>Clusters.json`
  - optional `collision.json`

Therefore, for the existing offline BEV/action/prompt pipeline:
- **Yes, keep `alldatasets/<dataset>/` (or redesign dataset_builder).**

## Redesign option (future)

To remove `alldatasets/`, implement a new loader path in `dataset_builder.py`:
- fetch latest saved analysis document from `Batch.savedTrajectoryAnalysis`
- parse clustering payload directly from Payload docs
- build medoids + artifacts without filesystem export

Until implemented, `alldatasets/` remains the required bridge for offline reproducible runs.

---

## Phase C — Build cluster medoid artifacts from CSV

```bash
cd gpl-odd-project
conda activate analyzer
python3 scripts/generate_map_tracks.py --dataset <dataset>
python3 scripts/map_preprocess.py --dataset <dataset>
bash scripts/build_llm_dataset.sh <dataset> <k>
```

This stage generates:
- `trajectory.csv`, `meta.yaml`
- `action.yaml`, `description.txt`
- `snapshots/*.jpg`, `map_overview.jpg`
- `stats.json`, `observations.json`, `medoid.json`

Exit criteria:
- every cluster folder under `results/<dataset>/<k>/` has complete Step 1-4 files

---

## Phase D — LLM interpretation

```bash
bash scripts/run_cluster_interpretation.sh <dataset> <k>
```

Output:
- `results/<dataset>/<k>/cluster<N>/cluster_interpretation.yaml`

Exit criteria:
- interpretation YAML exists for all target clusters

---

## Implementation Map (What code does what)

| Purpose | Path |
|---|---|
| Analyzer clustering endpoint | `app/analyzer/src/controller.py` |
| CSV loader with road fields | `app/analyzer/src/csv_roadid_loader.py` |
| Dataset trial-id mapping | `app/analyzer/src/dataset_config.py` |
| Build Steps 1-4 | `app/analyzer/src/dataset_builder.py` |
| BEV rendering | `app/analyzer/src/tier2_renderer.py`, `app/analyzer/src/map_plotter.py` |
| Action labelling | `app/analyzer/src/sim_labeller.py`, `app/analyzer/src/labeller.py` |
| Build wrapper | `scripts/build_llm_dataset.sh` |
| Interpretation wrapper | `scripts/run_cluster_interpretation.sh` |
| Interpretation pipeline | `app/analyzer/src/cluster_interpretation_pipeline.py` |
| Cluster interpreter logic | `app/llm_pipeline/python/llm_pipeline/cluster_interpreter.py` |

---

## Required Environment and Services

1. Payload reachable and populated for target batch
2. Analyzer running on `:9010`
3. Dashboard running on `:3000`
4. Analyzer and Dashboard `.env` share same `PAYLOAD_API` and `PAYLOAD_API_KEY`

Service checks:

```bash
curl -s -o /dev/null -w "%{http_code}\n" http://localhost:9010/progress
curl -s -o /dev/null -w "%{http_code}\n" http://localhost:3000
```

---

## Quality Gates (must pass before interpretation)

## Gate 1 — CSV integrity

- expected CSV header exists
- agents present (`Ego`, `Oncoming`, etc.)
- non-empty roadId/laneId fields in CSV

## Gate 2 — Payload readiness

- batch trial count > 0
- observations exist for sampled trials

## Gate 3 — Clustering readiness

- `selectedClusteringResult_<k>Clusters.json` exists
- selected clustering references trial ids from the same campaign

## Gate 4 — Local coverage for medoids

- medoid-derived CSV indices exist locally for target dataset
- if missing, sync CSVs or explicitly restrict trials

---

## Minimal Commands (Operator Runbook)

```bash
cd /home/carlos11/Downloads/code/LAB/41_Git/gpl-odd-project

# A) Ensure map assets for dataset
python3 scripts/generate_map_tracks.py --dataset dataset1
python3 scripts/map_preprocess.py --dataset dataset1

# B) Build medoid artifacts from local CSV + clustering files
bash scripts/build_llm_dataset.sh dataset1 4

# C) Run interpretation
bash scripts/run_cluster_interpretation.sh dataset1 4
```

---

## Deliverables

For each run:
- `results/<dataset>/<k>/manifest.json`
- `results/<dataset>/<k>/cluster<N>/...` (complete Step 1-4 artifacts)
- `results/<dataset>/<k>/cluster<N>/cluster_interpretation.yaml`

For reproducibility:
- frozen clustering files in `alldatasets/<dataset>/`
- clear record of source batch id and simulation date

---

## Non-Goals (Removed from this plan)

- Historical bug timelines and old root-cause narratives
- Legacy `old_alldatasets` comparisons as primary workflow
- Extended mission-control feature roadmap unrelated to CSV->cluster->interpretation path
- Deep background exposition from prior drafts

---

## Next Action List (Immediate)

1. Run/confirm new simulation batch outputs (`esmini_<batch>_*.csv`)
2. Re-run Dashboard Analysis on that batch (Analyzer `:9010`)
3. Select clustering and export fresh `alldatasets/<dataset>/` artifacts
4. Run `build_llm_dataset.sh` and verify complete cluster folders
5. Run `run_cluster_interpretation.sh` and review YAML outputs

This is the canonical pipeline for current and future experiments.
