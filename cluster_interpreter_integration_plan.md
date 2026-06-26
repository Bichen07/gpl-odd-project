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
5. `**alldatasets/<dataset>/` role:** exported clustering artifacts for reproducibility (not replacement for raw CSV)

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


| Stage                     | System                   | Primary implementation                                                        |
| ------------------------- | ------------------------ | ----------------------------------------------------------------------------- |
| Simulate and record       | Simulation/ROS/esmini    | `simulation/ros/src/scenario_search/...`                                      |
| Upload trial/observations | Sampler + Payload API    | `scenario_sampler.py`, Payload collections                                    |
| Compute MFPCA/HDBSCAN     | Analyzer service         | `app/analyzer/src/controller.py` (`/trajectory_analysis`)                     |
| Select cluster config     | Dashboard Explore UI     | `app/dashboard`                                                               |
| Build medoid artifacts    | Analyzer dataset builder | `scripts/build_llm_dataset.sh`, `dataset_builder.py`                          |
| LLM interpretation        | LLM pipeline wrapper     | `scripts/run_cluster_interpretation.sh`, `cluster_interpretation_pipeline.py` |


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
results/batch<id>/<k>_cluster_s=<silhouette>/cluster<N>/{context.md,cluster.json,action,description,trajectory,BEV}
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
- shared map assets (`results/map/` — xodr + tracks + yaml/jpg/description)
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
- State definition: `[batch.ts](app/dashboard/src/app/batch/[id]/_tabs/explore/redux/slices/batch.ts)`
- Redux store mount: `[store.ts](app/dashboard/src/app/batch/[id]/_tabs/explore/redux/store.ts)`
- Redux hooks used by panels: `[hooks.ts](app/dashboard/src/app/batch/[id]/_tabs/explore/redux/hooks.ts)`

Code path:

- Dashboard calls `[getTrajectoryAnalysis()](app/dashboard/src/app/_shared/graphql/queries/clustering.ts)`
- Response is stored via `batchSlice.actions.setTrajectoryAnalysis(...)`
in `[Saves/index.tsx](app/dashboard/src/app/batch/[id]/_tabs/explore/components/dock/panels/Saves/index.tsx)`

Implication:

- If browser refreshes before saving/loading from Payload, this in-memory analysis is lost.

File form / data inside:

- In-memory object shape follows `TrajectoryAnalysisResponse` from
`[app/dashboard/src/app/_shared/graphql/queries/clustering.ts](app/dashboard/src/app/_shared/graphql/queries/clustering.ts)`
- Key fields:
  - `request` (batch ids, task grid)
  - `trials` (trial metadata keyed by trial id)
  - `mfpca` (scores, clustering results, trialOrder)
  - `heatmapFileinfo`, `trajectoriesFileinfo` (linked Payload document metadata)
- Redux state holder:
`[redux/slices/batch.ts](app/dashboard/src/app/batch/[id]/_tabs/explore/redux/slices/batch.ts)`

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
`[app/analyzer/src/controller.py](app/analyzer/src/controller.py)`:
  - `heatmap.zip` containing `trajectories.json` (`heatmapFileinfo`)
  - `trajectories.zip` containing `rawTrajectories.json` (`trajectoriesFileinfo`)
- Stored in Payload `documents` table + uploads storage; returned as document metadata
(`id`, `url`, `filename`, etc.).
- Payload batch schema that links saved analysis docs:
`[app/payload/src/collections/Batches.ts](app/payload/src/collections/Batches.ts)` (`savedTrajectoryAnalysis`)

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
  - `[Saves/index.tsx](app/dashboard/src/app/batch/[id]/_tabs/explore/components/dock/panels/Saves/index.tsx)`
  - `[app/dashboard/src/app/_shared/graphql/queries/documents.ts](app/dashboard/src/app/_shared/graphql/queries/documents.ts)`
  - `[app/dashboard/src/app/_shared/graphql/queries/batches.ts](app/dashboard/src/app/_shared/graphql/queries/batches.ts)`
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
  - `[ClusteringSelection/index.tsx](app/dashboard/src/app/batch/[id]/_tabs/explore/components/dock/panels/ClusteringSelection/index.tsx)`
  - `[ClusteringSelection/PerEgoSelection/index.tsx](app/dashboard/src/app/batch/[id]/_tabs/explore/components/dock/panels/ClusteringSelection/PerEgoSelection/index.tsx)`
  - written to `state.batch.selectedClusteringResults` and `state.batch.selectedClusterInfos`
  in `[redux/slices/batch.ts](app/dashboard/src/app/batch/[id]/_tabs/explore/redux/slices/batch.ts)`.

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
  1. load saved analysis in Saves panel,
  2. pick clustering in ClusteringSelection,
  3. export/create `selectedClusteringResult_<k>Clusters.json` + `clustering.json`,
  4. run `build_llm_dataset.sh`.
- Option B (future redesign):
  - make `dataset_builder.py` read from `Batch.savedTrajectoryAnalysis` document directly (skip `alldatasets/` export).

### Option B deep-dive (no `alldatasets/<dataset>/` dependency)

#### 1) Which data store is used

Primary store:

- Payload `batches.savedTrajectoryAnalysis[]` (document ids)
  - schema: `[app/payload/src/collections/Batches.ts](app/payload/src/collections/Batches.ts)`
  - dashboard query/write: `[app/dashboard/src/app/_shared/graphql/queries/batches.ts](app/dashboard/src/app/_shared/graphql/queries/batches.ts)`

Document store:

- Payload `documents` collection + uploaded zip file
  - upload/delete client helpers: `[app/dashboard/src/app/_shared/graphql/queries/documents.ts](app/dashboard/src/app/_shared/graphql/queries/documents.ts)`
  - analysis save UI: `[Saves/index.tsx](app/dashboard/src/app/batch/[id]/_tabs/explore/components/dock/panels/Saves/index.tsx)`

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

File: `[scripts/build_llm_dataset.sh](scripts/build_llm_dataset.sh)`

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

## Status of `alldatasets/` (removed 2026-06)

- `alldatasets/` and `old_alldatasets/` have been **deleted** from the repo. Map/xodr assets
  now live only in `results/map/`.
- The legacy `--source alldatasets` code path still exists but has **no local input data**
  anymore; it would need data re-added under `alldatasets/<dataset>/` to run. The supported
  workflow is `--source payload-save`.
- Optional `collision.json` enrichment is still *read* from `alldatasets/<dataset>/` if that
  file happens to be present (no-op now that the folder is gone).

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
`dataset_config.dataset_for_batch_id()`. Output lands in
`results/batch<id>/<k>_cluster_s=<silhouette>/`.
- If no dataset config maps to the batch id, it falls back to `batch<id>` and prints a
warning that BEV/map assets may be unavailable.
- `scripts/build_llm_dataset.sh` only forwards `--dataset` when you explicitly pass it.

### Output folder layout (2026-06 — single source of truth under `results/`)

All generated outputs live under `results/`. `alldatasets/` and `old_alldatasets/` have
been **removed**; nothing reads or writes them anymore.

```text
results/
├── map/                                    # shared, generated map assets (one set per map name)
│   ├── hct_6.xodr            hct_6_tracks.csv
│   ├── hct_6.yaml            hct_6.jpg           hct_6_description.txt
│   ├── hct_6_no_930.xodr     hct_6_no_930_tracks.csv         # dataset2 uses a different map
│   └── hct_6_no_930.yaml     hct_6_no_930.jpg    hct_6_no_930_description.txt
└── batch<id>/                              # e.g. batch1/, batch2/
    └── <k>_cluster_s=<silhouette>/         # e.g. batch1/4_cluster_s=0.7341/
        ├── manifest.json                   # run-level: dataset, batch_id, k, medoid list
        ├── clustering/
        │   └── selectedClusteringResult.json   # the exact ClusteringResult that was used
        └── cluster<N>/                     # one folder per cluster (its medoid trial)
            ├── context.md                  # consolidated LLM card: header + description + action table + snapshot index
            ├── cluster.json                # merged cluster + medoid + scene metadata (replaces meta/medoid/stats)
            ├── action.yaml                 # structured semantic events (Labeller output)
            ├── description.txt             # natural-language scenario summary (from action.yaml)
            ├── trajectory.csv              # raw per-frame state of the medoid trial (BEV + reproducibility only)
            ├── map_overview.jpg            # full-map render with the medoid trajectory
            └── snapshots/*.jpg             # BEV key-frame images (named by time + event)
```

> **2026-06 consolidation applied.** `observations.json`, `meta.yaml`, `medoid.json`, and
> `stats.json` are **no longer written**. `cluster.json` carries the merged metadata and
> `context.md` is the single LLM-facing card. `meta.yaml` is still built transiently as a
> Labeller input, then deleted. A 4-cluster run dropped from ~8.3 MB to ~3.9 MB.

Folder-name change (2026-06): the run dir is now
`results/batch<id>/<k>_cluster_s=<silhouette>/`. The `s=<silhouette>` suffix (4 d.p. of the
selected result's `silhouetteScore`) keeps **multiple results with the same `k`** but
different HDBSCAN params in separate folders. The batch id is resolved from `--batch-id`
(payload-save) or from `dataset_config` (legacy alldatasets mode). Map assets are shared at
`results/map/` (no per-run copy); each distinct map name (e.g. `hct_6`, `hct_6_no_930`) has
its own asset set there.

#### Per-file reference (what produces it, what consumes it)

Current layout (after the 2026-06 consolidation):

| File | Size¹ | Produced by | Consumed by | Purpose |
|------|-------|-------------|-------------|---------|
| `context.md` | ~2 KB | `dataset_builder.write_context_md()` | LLM pipeline (primary text) | Single self-contained card: header (k/size/silhouette/medoid) + description + per-agent action table + ordered snapshot index. |
| `cluster.json` | ~1 KB | `dataset_builder` | LLM pipeline | Merged `cluster` (label/size/n_trials/n_clusters/silhouette/collision) + `medoid` (trial_id/batch/index/rank) + `scene` (location/duration/frame_count/agent dims). Replaces meta/medoid/stats. |
| `action.yaml` | ~2 KB | analyzer Labeller | LLM pipeline (fallback text + grounding) | Structured semantic events per agent (MAINTAIN_SPEED, LANE_CHANGE, ENTER_JUNCTION…), junction-aware. |
| `description.txt` | ~1 KB | analyzer Describer (from `action.yaml`) | LLM pipeline (embedded in `context.md`) | Natural-language summary. |
| `trajectory.csv` | ~190 KB | `dataset_builder` (medoid CSV) | BEV renderer | Raw per-frame timeline. Source for snapshots + reproducibility. **Not** put in the prompt. |
| `map_overview.jpg` | ~44 KB | BEV renderer | LLM pipeline (image) | Whole-map context with trajectory. |
| `snapshots/*.jpg` | ~424 KB / 8–28 imgs | BEV renderer | LLM pipeline (images) | Key-frame BEV at action timestamps. Primary visual input. |

¹ Sizes from `results/batch1/4_cluster_s=0.7341/cluster0/` (now ~680 KB/cluster, ~3.9 MB/run).

Removed in 2026-06 (no longer written): `observations.json` (~794 KB, duplicated
`trajectory.csv`), `meta.yaml`, `medoid.json`, `stats.json` (folded into `cluster.json`).

### File inventory: redundancy & consolidation plan (observations, 2026-06)

Reference baseline: `xosc_gen/main.py` runs a staged pipeline. Its rule-based "prepare"
phase (`--steps prepare`, **Steps 0 → 2.5**) is exactly the part that builds the artifacts an
LLM later reads in Step 3:

| xosc_gen step | What it does | Output | gpl-odd-project equivalent |
|---------------|--------------|--------|----------------------------|
| 0 preprocess  | load raw track + metadata + map | `metadata/*.yaml`, `trajectory/*.csv`, `map/*.yaml`, `*_tracks.csv` | `meta.yaml`, `trajectory.csv`, `results/map/*` |
| 1 Labeller    | label per-agent actions | `action/*.yaml` | `action.yaml` |
| 2 Describer   | natural-language description | `description/*.txt` | `description.txt` |
| 2.5 BEV       | render key-frame snapshots at action timestamps | `snapshots/*.jpg` | `snapshots/*.jpg` + `map_overview.jpg` |
| (3 LLM)       | reads **description + snapshots + map** | — | `cluster_interpretation_pipeline.run_one_cluster()` |

Crucially, xosc_gen's Step 3 feeds the LLM the **description, the BEV images, and the map** —
not the raw per-frame trajectory. It has **no `observations.json`**.

**What information the LLM actually needs (per cluster):**

1. Cluster identity & weight — which cluster, its size / share, and the selected silhouette
   (so the model knows how representative the medoid is). → from `cluster.json` / `manifest.json`.
2. A semantic action timeline — what each agent does and when, junction-aware.
   → `action.yaml` (structured) and `description.txt` (prose). This is the strongest text signal.
3. Visual context — BEV key-frame snapshots + a whole-map overview. → `snapshots/`, `map_overview.jpg`.
4. Map context — roads/junctions of the location. → `results/map/<map>.yaml` (already summarised
   inside `description.txt` via junction-aware labelling).

Raw per-frame coordinates (`trajectory.csv` / `observations.json`) are **not** good LLM input:
1816 frames of x/y/heading add tokens without adding interpretable meaning, and the model reads
the BEV images for geometry instead.

**Redundancy found (today):**

- `observations.json` (~794 KB) is `trajectory.csv` (~190 KB) reshaped to wide JSON — the **same
  per-frame data stored twice**. `trajectory.csv` feeds the BEV renderer; `observations.json`
  feeds only `action_log_from_observations()`, which **downsamples it to ~16 points**.
- `action_log_from_observations()` is explicitly a *fallback* ("when xosc_gen Labeller output is
  unavailable"). We now always produce `action.yaml` + `description.txt`, so the LLM is currently
  fed the *crude* derived log while the *better* semantic files sit unused.
- `meta.yaml`, `medoid.json`, `stats.json` overlap (cluster_label, trial_id/medoid_trial_id,
  batch_id, trial_index, size/cluster_size, duration, agents) across three small files.

**Can we integrate the redundant files into one? — Yes:**

1. Drop stored `observations.json`. Keep `trajectory.csv` as the single raw timeline. If the
   sampled action-log is still wanted, derive it on the fly from `trajectory.csv` (it is already
   downsampled to ~16 rows), so nothing is persisted twice. (Saves ~3 MB per 4-cluster run.)
2. Merge `meta.yaml` + `medoid.json` + `stats.json` → one `cluster.json` (or `info.json`) with
   nested `medoid`, `cluster`, and `scene` blocks. One read, no duplicated keys.
3. Optionally add one consolidated **LLM context card** per cluster (`context.md` / `context.json`)
   that stitches: cluster id + size + silhouette → the prose `description.txt` → the agent action
   table from `action.yaml` → an ordered list of snapshot filenames with their event labels. The
   LLM then reads a single self-contained file plus the images.

**How to process so the LLM interprets better:**

- ✅ The interpreter's text input now prefers `context.md` → `description.txt` → `action.yaml`
  (via `action_log_from_description()`), falling back to the old observations log only for
  legacy runs. This is the xosc_gen Step 3 contract and removes the only consumer of
  `observations.json`.
- Keep feeding BEV `snapshots/*.jpg` + `map_overview.jpg` as the visual channel (unchanged).
- The cluster header (k, size, silhouette, medoid trial) is prepended in `context.md` so the
  model frames the medoid as "the representative of N similar trials," not a one-off.
- Keep raw `trajectory.csv` for reproducibility / BEV only; never put it in the prompt.

**Implemented per-cluster layout (2026-06):**

```text
cluster<N>/
├── context.md          # consolidated LLM card: header + description + action table + snapshot index
├── cluster.json        # merged cluster + medoid + scene (replaces meta + medoid + stats)
├── action.yaml         # structured events (grounding / tools)
├── description.txt      # prose (embedded into context.md)
├── trajectory.csv      # raw timeline (BEV + reproducibility only)
├── map_overview.jpg
└── snapshots/*.jpg
```

This removed `observations.json` and collapsed three metadata files into one `cluster.json`,
making the LLM input a single description-centric card backed by images — matching xosc_gen
Steps 0–2.5.

**Code changes (2026-06):**

- `dataset_builder.py`: `process_medoid()` now writes `cluster.json` + `context.md`
  (`write_context_md()`), stops writing `observations.json`/`stats.json`/`medoid.json`, and
  deletes the transient `meta.yaml` after labelling. `process_medoid()` takes `silhouette`.
- `cluster_interpretation_pipeline.py`: `interpret_cluster_dir()` reads `cluster.json` (falls
  back to `stats.json`/`medoid.json`); new `action_log_from_description()` supplies the LLM
  text from `context.md`/`description.txt`/`action.yaml` (falls back to observations).
- `build_llm_dataset.sh`: summary updated to list the new per-cluster files.

### One-time map asset prerequisite (per map)

BEV rendering needs the map track + metadata assets in `results/map/`. If that folder is
empty (fresh checkout), run once per map before the build:

```bash
python3 scripts/generate_map_tracks.py --dataset dataset1   # writes results/map/hct_6.xodr + hct_6_tracks.csv
python3 scripts/map_preprocess.py     --dataset dataset1    # writes results/map/hct_6.{yaml,jpg,_description.txt}
# dataset2 uses a different map (hct_6_no_930): repeat with --dataset dataset2
```

Note: `--dataset` is still the correct flag **for these two map scripts** (it selects the
xodr + output map name via `dataset_config`). Only `build_llm_dataset.sh` dropped `--dataset`.
`map_preprocess.py` also accepts `--map-id hct_6` directly; `generate_map_tracks.py` takes
`--dataset` (or `--all` for every map variant).

`generate_map_tracks.py` now copies the source xodr into `results/map/` automatically, so
no manual `cp` is needed. Without these assets the build still completes but logs
`BEV skipped` / `action built WITHOUT junction info`.

---

## Phase C — Build cluster medoid artifacts from CSV

```bash
cd gpl-odd-project
conda activate analyzer

# One-time map assets per map (skip if results/map already populated)
python3 scripts/generate_map_tracks.py --dataset <dataset>
python3 scripts/map_preprocess.py     --dataset <dataset>

# payload-save build — the supported path. --dataset is NOT needed (resolved from --batch-id).
# Pick the result with --k (best silhouette), --clustering-index <i>, or a saved selected.json:
bash scripts/build_llm_dataset.sh --source payload-save --batch-id <batch> --k <k>
bash scripts/build_llm_dataset.sh --source payload-save --batch-id <batch> --clustering-index <i>

# List candidates for a given k (index, silhouette, HDBSCAN params) before picking:
bash scripts/build_llm_dataset.sh --source payload-save --batch-id <batch> --k <k> --list-clusterings
```

> The legacy positional form `build_llm_dataset.sh <dataset> <k>` (`--source alldatasets`)
> still exists but has no local input data after the `alldatasets/` removal. Use payload-save.

This stage generates (under `results/batch<id>/<k>_cluster_s=<silhouette>/cluster<N>/`):

- `context.md` (consolidated LLM card), `cluster.json` (merged metadata)
- `action.yaml`, `description.txt`
- `trajectory.csv`, `map_overview.jpg`, `snapshots/*.jpg`

Exit criteria:

- every cluster folder under `results/batch<id>/<k>_cluster_s=<silhouette>/` has `context.md`,
  `cluster.json`, `action.yaml`, `description.txt`, `map_overview.jpg`, and `snapshots/`

Verified runs (2026-06):

- batch 1, `--k 4` → `results/batch1/4_cluster_s=0.7341/` (4 clusters, 8–13 BEV snapshots each)
- batch 1, `--clustering-index 328` → `results/batch1/4_cluster_s=0.7037/` (same k=4, lower silhouette)
- batch 1, `--k 2` → `results/batch1/2_cluster_s=0.5972/`
- batch 2, `--k 4` → `results/batch2/4_cluster_s=0.6945/` (uses the `hct_6_no_930` map)
- shared map assets for both maps live in `results/map/`.

---

## Phase D — LLM interpretation

```bash
bash scripts/run_cluster_interpretation.sh <dataset> <k>
```

Output:

- `results/batch<id>/<k>_cluster_s=<silhouette>/cluster<N>/cluster_interpretation.yaml`

Exit criteria:

- interpretation YAML exists for all target clusters

---

## Implementation Map (What code does what)


| Purpose                      | Path                                                                    |
| ---------------------------- | ----------------------------------------------------------------------- |
| Analyzer clustering endpoint | `app/analyzer/src/controller.py`                                        |
| CSV loader with road fields  | `app/analyzer/src/csv_roadid_loader.py`                                 |
| Dataset trial-id mapping     | `app/analyzer/src/dataset_config.py`                                    |
| Build Steps 1-4              | `app/analyzer/src/dataset_builder.py`                                   |
| BEV rendering                | `app/analyzer/src/tier2_renderer.py`, `app/analyzer/src/map_plotter.py` |
| Action labelling             | `app/analyzer/src/sim_labeller.py`, `app/analyzer/src/labeller.py`      |
| Build wrapper                | `scripts/build_llm_dataset.sh`                                          |
| Interpretation wrapper       | `scripts/run_cluster_interpretation.sh`                                 |
| Interpretation pipeline      | `app/analyzer/src/cluster_interpretation_pipeline.py`                   |
| Cluster interpreter logic    | `app/llm_pipeline/python/llm_pipeline/cluster_interpreter.py`           |


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

# A) Ensure shared map assets in results/map/ (one-time per map)
python3 scripts/generate_map_tracks.py --dataset dataset1
python3 scripts/map_preprocess.py     --dataset dataset1

# B-legacy) Build medoid artifacts from alldatasets/ (requires exported clustering files)
#   → output: results/batch1/4_cluster/
bash scripts/build_llm_dataset.sh dataset1 4

# B-new) Build medoid artifacts directly from Payload saved analysis (no alldatasets/ needed)
#   --dataset is optional; when omitted it is resolved from --batch-id (batch 1 → dataset1)
#   → output: results/batch1/4_cluster/
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

- `results/batch<id>/<k>_cluster_s=<silhouette>/manifest.json`
- `results/batch<id>/<k>_cluster_s=<silhouette>/cluster<N>/...` (complete Step 1-4 artifacts)
- `results/batch<id>/<k>_cluster_s=<silhouette>/cluster<N>/cluster_interpretation.yaml`
- shared map assets in `results/map/`

For reproducibility:

- the saved Payload analysis (`Batch.savedTrajectoryAnalysis` doc) + `manifest.json`
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
   `results/batch<n>/<k>_cluster_s=<silhouette>/cluster*/` folders are complete
5. Run `run_cluster_interpretation.sh` and review YAML outputs

**Legacy alldatasets path** (`bash scripts/build_llm_dataset.sh dataset1 4`) remains in code but
has no local input data after the `alldatasets/` removal.