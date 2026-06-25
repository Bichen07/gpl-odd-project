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
- State definition: [`batch.ts`](app/dashboard/src/app/batch/[id]/_tabs/explore/redux/slices/batch.ts)
- Redux store mount: [`store.ts`](app/dashboard/src/app/batch/[id]/_tabs/explore/redux/store.ts)
- Redux hooks used by panels: [`hooks.ts`](app/dashboard/src/app/batch/[id]/_tabs/explore/redux/hooks.ts)

Code path:
- Dashboard calls [`getTrajectoryAnalysis()`](app/dashboard/src/app/_shared/graphql/queries/clustering.ts)
- Response is stored via `batchSlice.actions.setTrajectoryAnalysis(...)`
  in [`Saves/index.tsx`](app/dashboard/src/app/batch/[id]/_tabs/explore/components/dock/panels/Saves/index.tsx)

Implication:
- If browser refreshes before saving/loading from Payload, this in-memory analysis is lost.

File form / data inside:
- In-memory object shape follows `TrajectoryAnalysisResponse` from
  [`app/dashboard/src/app/_shared/graphql/queries/clustering.ts`](app/dashboard/src/app/_shared/graphql/queries/clustering.ts)
- Key fields:
  - `request` (batch ids, task grid)
  - `trials` (trial metadata keyed by trial id)
  - `mfpca` (scores, clustering results, trialOrder)
  - `heatmapFileinfo`, `trajectoriesFileinfo` (linked Payload document metadata)
- Redux state holder:
  [`redux/slices/batch.ts`](app/dashboard/src/app/batch/[id]/_tabs/explore/redux/slices/batch.ts)

## B) During Analyzer response generation

Storage location:
- **Payload `documents` collection** (uploaded by Analyzer backend)
- **What is persisted here:** intermediate analysis artifacts generated server-side during `/trajectory_analysis`

Code path (`app/analyzer/src/controller.py`):
- Analyzer zips and uploads:
  - `trajectories.json` (as document; mapped to `heatmapFileinfo` in response)
  - `rawTrajectories.json` (as `trajectories.zip`; mapped to `trajectoriesFileinfo`)
- Upload endpoint: `POST {PAYLOAD_API}/api/documents`

Implication:
- Even without pressing Dashboard `save`, Analyzer can already create document artifacts.
- These are returned in API response metadata, not automatically linked to batch saves list.

File form / data inside:
- Analyzer uploads zipped JSON documents in
  [`app/analyzer/src/controller.py`](app/analyzer/src/controller.py):
  - `heatmap.zip` containing `trajectories.json` (`heatmapFileinfo`)
  - `trajectories.zip` containing `rawTrajectories.json` (`trajectoriesFileinfo`)
- Stored in Payload `documents` table + uploads storage; returned as document metadata
  (`id`, `url`, `filename`, etc.).
- Payload batch schema that links saved analysis docs:
  [`app/payload/src/collections/Batches.ts`](app/payload/src/collections/Batches.ts) (`savedTrajectoryAnalysis`)

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
- **This is where the clustering result is actually saved for later reuse** (as zipped JSON document + batch relation).

File form / data inside:
- Dashboard builds a zip with one JSON entry:
  - `trajectories.json` = serialized full `trajectoryAnalysis` object from Redux
- Inside that `trajectories.json`, clustering results are under:
  - `<egoName>.mfpca[durationMode].clustering` (array of `ClusteringResult`)
  - each `ClusteringResult` includes `task`, `scores`, `data`, `trialOrder`
- Save/load/delete code:
  - [`Saves/index.tsx`](app/dashboard/src/app/batch/[id]/_tabs/explore/components/dock/panels/Saves/index.tsx)
  - [`app/dashboard/src/app/_shared/graphql/queries/documents.ts`](app/dashboard/src/app/_shared/graphql/queries/documents.ts)
  - [`app/dashboard/src/app/_shared/graphql/queries/batches.ts`](app/dashboard/src/app/_shared/graphql/queries/batches.ts)
- Batch linkage field:
  - `Batch.savedTrajectoryAnalysis[]` -> array of Payload document ids
  - queried by `GetBatchTrajectoryAnalysis`.

## D) ClusteringSelection panel source

Storage location:
- **Redux-selected result** only:
  - `state.batch.selectedClusteringResults`
  - `state.batch.selectedClusterInfos`

Implication:
- Choosing a cluster config updates app state for visualization/next steps.
- Choosing cluster count (e.g., 1..9) is **not written as a separate Payload field** by current UI.
- To persist for later sessions, save analysis document and reload it; then reselect in UI or export selected result file.

File form / data inside:
- Selected result structure (`ClusteringResult`):
  - `task` (HDBSCAN/MFPCA params)
  - `scores` (silhouette, dbcv, etc.)
  - `data` mapping `{ trialId -> { trialId, label } }`
  - `trialOrder` per cluster label
- Selection UI / state write:
  - [`ClusteringSelection/index.tsx`](app/dashboard/src/app/batch/[id]/_tabs/explore/components/dock/panels/ClusteringSelection/index.tsx)
  - [`ClusteringSelection/PerEgoSelection/index.tsx`](app/dashboard/src/app/batch/[id]/_tabs/explore/components/dock/panels/ClusteringSelection/PerEgoSelection/index.tsx)
  - written to `state.batch.selectedClusteringResults` and `state.batch.selectedClusterInfos`
    in [`redux/slices/batch.ts`](app/dashboard/src/app/batch/[id]/_tabs/explore/redux/slices/batch.ts).

## E) Precise answer: where your “1..9 cluster result” is saved

When you see multiple cluster counts in `http://localhost:3000/batch/1`:

1. **All computed candidate results** are saved in analysis JSON (`trajectoryAnalysis`) under:
   - `<egoName>.mfpca[durationMode].clustering[]`
2. After pressing **save**, that analysis JSON is persisted as a Payload `documents` zip and linked by:
   - `Batch.savedTrajectoryAnalysis[]`
3. **Your current chosen option in ClusteringSelection** is stored only in Redux:
   - `state.batch.selectedClusteringResults`
   - not a dedicated persistent DB column by default.

How to get result for next-step processing:

- Option A (current official pipeline):
  1) load saved analysis in Saves panel,
  2) pick clustering in ClusteringSelection,
  3) export/create `selectedClusteringResult_<k>Clusters.json` + `clustering.json`,
  4) run `build_llm_dataset.sh`.
- Option B (future redesign):
  - make `dataset_builder.py` read from `Batch.savedTrajectoryAnalysis` document directly (skip `alldatasets/` export).

### Option B deep-dive (no `alldatasets/<dataset>/` dependency)

#### 1) Which data store is used

Primary store:
- Payload `batches.savedTrajectoryAnalysis[]` (document ids)
  - schema: [`app/payload/src/collections/Batches.ts`](app/payload/src/collections/Batches.ts)
  - dashboard query/write: [`app/dashboard/src/app/_shared/graphql/queries/batches.ts`](app/dashboard/src/app/_shared/graphql/queries/batches.ts)

Document store:
- Payload `documents` collection + uploaded zip file
  - upload/delete client helpers: [`app/dashboard/src/app/_shared/graphql/queries/documents.ts`](app/dashboard/src/app/_shared/graphql/queries/documents.ts)
  - analysis save UI: [`Saves/index.tsx`](app/dashboard/src/app/batch/[id]/_tabs/explore/components/dock/panels/Saves/index.tsx)

#### 2) What data can be fetched from saved analysis

After Dashboard `save`, the uploaded zip contains `trajectories.json` with serialized `trajectoryAnalysis` object.

Usable fields:
- `<egoName>.request.tasks` (all clustering tasks run)
- `<egoName>.mfpca[durationMode].clustering[]` (all `ClusteringResult` candidates)
- `<egoName>.mfpca[durationMode].scores` and trial order
- `<egoName>.trials` and `<egoName>.batches` metadata

Important limitation:
- **Selected cluster choice in ClusteringSelection is not persisted in Payload by default.**
  - Only in Redux (`selectedClusteringResults`).
  - Therefore Option B must define how to choose one result for `k`:
    - by explicit `--clustering-index`,
    - or by task params (`minClusterSize`, `minSamples`, `epsilon`, method),
    - or by best score heuristic (`silhouette`, `dbcv`).

#### 3) Processing flow in Option B

1. Query batch -> get `savedTrajectoryAnalysis[]` document ids.
2. Choose one save id (latest by default or explicit `--save-id`).
3. Download document zip (`url`) and read `trajectories.json`.
4. Extract one `ClusteringResult` for requested `k`.
5. Convert selected result to in-memory equivalent of:
   - `selectedClusteringResult_<k>Clusters.json`
   - plus embedding/trial vectors needed for medoid computation.
6. Continue existing pipeline:
   - map trial_id -> csv index (`dataset_config.py` / explicit mapping args),
   - medoid selection,
   - `trajectory.csv`, `action.yaml`, BEV snapshots, prompt input generation.

#### 4) Detailed modification plan for `build_llm_dataset.sh`

File: [`scripts/build_llm_dataset.sh`](scripts/build_llm_dataset.sh)

Add new CLI options and pass-through:
1. Keep existing mode:
   - `build_llm_dataset.sh <dataset> <k>`
2. Add Option B mode flags:
   - `--source payload-save`
   - `--batch-id <id>`
   - `--save-id <document_id>` (optional; default latest)
   - `--duration-mode <full|...>` (default `full`)
   - `--clustering-index <n>` OR task filters:
     - `--method hdbscan+mfpca`
     - `--min-cluster-size ...`
     - `--min-samples ...`
     - `--cluster-selection-epsilon ...`
3. Forward all these flags to `dataset_builder.py`.

No heavy logic should be added in shell script; only argument parsing and forwarding.

#### 5) Detailed modification plan for `dataset_builder.py` (required)

Primary changes:
1. Add `--source` switch with values:
   - `alldatasets` (default, current behavior)
   - `payload-save` (new Option B behavior)
2. For `payload-save`:
   - call Payload API to get batch saves
   - download selected zip
   - parse `trajectories.json`
3. Implement selection resolver:
   - filter clustering candidates by target `k`
   - apply `--clustering-index` or task-param matching
   - fail fast with clear error if ambiguous/no match
4. Build normalized in-memory structures currently returned by `load_clustering_data(...)`:
   - `embeddings_data` equivalent
   - `result_data` equivalent
5. Reuse existing medoid computation and downstream artifact generation unchanged.
6. Add deterministic logging:
   - chosen save id, chosen clustering index, task params, score summary.

#### 6) Optional but recommended payload-side enhancement

To remove ambiguity, persist user’s chosen clustering result at save time:
- In `Saves/index.tsx`, include selected result metadata in saved zip (e.g. `selected.json`)
  or save a dedicated document for selected clustering.
- Then Option B can load exact user choice directly without heuristic selection.

#### 7) Validation checklist for Option B

1. `build_llm_dataset.sh --source payload-save ...` runs without `alldatasets/<dataset>/`.
2. Selected clustering trial ids map to existing local `esmini_<batch>_<index>.csv`.
3. Medoid files and BEV snapshots are generated as before.
4. Output equivalence test:
   - compare Option A vs Option B on same save and same clustering choice.

---

## Can we skip creating `alldatasets/<dataset>/`?

**Yes — Option B (`--source payload-save`) is now implemented and tested.**

## What you can do without `alldatasets/`

- Dashboard visualization, filtering, cluster selection, and interactive review
- `build_llm_dataset.sh --source payload-save` — full pipeline without any `alldatasets/` export

## What `alldatasets/` is still used for

- Legacy `--source alldatasets` (default) mode
- Optional `collision.json` enrichment (still read from `alldatasets/<dataset>/` if present)

## Option B: `--source payload-save` ✅ IMPLEMENTED (2026-06)

Loader path in `dataset_builder.py`:
- `load_clustering_from_payload_save()` fetches `Batch.savedTrajectoryAnalysis`
- downloads the analysis zip, parses `trajectories.json`
- selects one `ClusteringResult` by `--k` (best silhouette) or `--clustering-index`
- if `selected.json` exists in the zip (added by Dashboard on save), uses that index directly
- builds `trial_index_map` from `esminiDat.filename` in the zip — no extra Payload API calls
- reuses all existing medoid computation + artifact generation unchanged

Dashboard (`Saves/index.tsx`) now adds `selected.json` to every saved zip, recording the
user's exact cluster choice with its array index and task params.

### `--dataset` is optional in payload-save mode (2026-06 update)

- `--dataset` no longer needs to be passed. When omitted, `dataset_builder.py` resolves
  the canonical dataset (`dataset1` / `dataset2` / `dataset3`) from `--batch-id` via
  `dataset_config.dataset_for_batch_id()`. Output then lands in `results/<resolved>/<k>/`.
- If no dataset config maps to the batch id, it falls back to `batch<id>` and prints a
  warning that BEV/map assets may be unavailable.
- `scripts/build_llm_dataset.sh` only forwards `--dataset` when you explicitly pass it.

### One-time map asset prerequisite (per dataset)

BEV rendering needs the map track + metadata assets. If `alldatasets/resources/xodr/` is
empty (fresh checkout), run once per dataset before the build:

```bash
python3 scripts/generate_map_tracks.py --dataset dataset1
cp simulation/ros/.cache/scenario_search/hct_6.xodr alldatasets/resources/xodr/hct_6.xodr
python3 scripts/map_preprocess.py --dataset dataset1
```

Without these, the build still completes but logs `BEV skipped` / `action built WITHOUT
junction info`.

---

## Phase C — Build cluster medoid artifacts from CSV

```bash
cd gpl-odd-project
conda activate analyzer

# One-time map assets per dataset (skip if alldatasets/resources/xodr already populated)
python3 scripts/generate_map_tracks.py --dataset <dataset>
cp simulation/ros/.cache/scenario_search/hct_6.xodr alldatasets/resources/xodr/hct_6.xodr
python3 scripts/map_preprocess.py --dataset <dataset>

# Legacy alldatasets build:
bash scripts/build_llm_dataset.sh <dataset> <k>

# OR payload-save build (no alldatasets export, --dataset optional → resolved from batch id):
bash scripts/build_llm_dataset.sh --source payload-save --batch-id <batch> --k <k>
```

This stage generates:
- `trajectory.csv`, `meta.yaml`
- `action.yaml`, `description.txt`
- `snapshots/*.jpg`, `map_overview.jpg`
- `stats.json`, `observations.json`, `medoid.json`

Exit criteria:
- every cluster folder under `results/<dataset>/<k>/` has complete Step 1-4 files

Verified run (2026-06, batch 1, k=4): `results/dataset1/4/` with 4 cluster folders,
8–13 BEV snapshots each, silhouette 0.734.

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

**alldatasets mode:**
- `selectedClusteringResult_<k>Clusters.json` exists
- selected clustering references trial ids from the same campaign

**payload-save mode:**
- `Batch.savedTrajectoryAnalysis` list has at least one document
- zip contains `trajectories.json` with non-empty `mfpca.full.clustering[]`

## Gate 4 — Local coverage for medoids

- medoid-derived CSV indices exist locally for target dataset
- if missing, sync CSVs or explicitly restrict trials

---

## Minimal Commands (Operator Runbook)

```bash
cd /home/carlos11/Downloads/code/LAB/gpl-odd-project

# A) Ensure map assets for dataset (one-time per dataset)
python3 scripts/generate_map_tracks.py --dataset dataset1
cp simulation/ros/.cache/scenario_search/hct_6.xodr alldatasets/resources/xodr/hct_6.xodr
python3 scripts/map_preprocess.py --dataset dataset1

# B-legacy) Build medoid artifacts from alldatasets/ (requires exported clustering files)
bash scripts/build_llm_dataset.sh dataset1 4

# B-new) Build medoid artifacts directly from Payload saved analysis (no alldatasets/ needed)
#   --dataset is optional; when omitted it is resolved from --batch-id (batch 1 → dataset1)
bash scripts/build_llm_dataset.sh \
  --source payload-save \
  --batch-id 1 \
  --k 4
# Options: --save-doc-id 46   (specific save, default: latest)
#          --clustering-index 445   (exact index instead of --k)
#          --ego-name ITRI          (default: ITRI)
#          --duration-mode full     (default: full)

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

Option B (`--source payload-save`) is now fully implemented and smoke-tested.
The new canonical workflow skips `alldatasets/` export entirely.

1. Run/confirm new simulation batch outputs (`esmini_<batch>_*.csv`)
2. Re-run Dashboard Analysis on that batch (Analyzer `:9010`)
3. In Dashboard → Saves panel, click **save** to persist analysis to Payload
   (`selected.json` is now included in the zip automatically)
4. Run `build_llm_dataset.sh --source payload-save --batch-id <n> --k <k>`
   (`--dataset` optional — resolved from batch id) and verify
   `results/<dataset>/<k>/cluster*/` folders are complete
5. Run `run_cluster_interpretation.sh` and review YAML outputs

**Legacy alldatasets path** (`bash scripts/build_llm_dataset.sh dataset1 4`) still works unchanged.
