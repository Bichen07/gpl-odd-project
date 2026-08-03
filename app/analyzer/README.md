# Analyzer

## Purpose

Service for the Dashboard to analyze trajectories in a batch for
clustering and visualization (MFPCA, UMAP, HDBSCAN).

## Path A artifact contract (action → description → BEV)

Medoid / trial packs under `results/batch*/…/clusterN/` use nested layout:

```text
clusterN/
  raw/          trajectory.csv, cluster.json
  processed/    action.yaml, description.txt, context.md, snapshots/, map_overview.jpg
  output/       medoid_trial*.yaml, cluster_summary*, cluster_interpretation*
  highlight_trials/
    outlier_trials/trial_*/
    boundary_c*/trial_*/
    param_boundary_c*/trial_*/
```

Build order (xosc_gen Steps 1 → 2 → 2.5):

```text
esmini CSV
  → labeller.py (+ collision_partner) → processed/action.yaml  [single source of truth]
  → description.py                    → processed/description.txt  [human prose]
  → conflict_frame_selector.select_action_frames
       (timestamps ⊆ action.yaml only; noise filter may drop stamps, never invent)
  → tier2_renderer + map_plotter      → processed/snapshots/*.jpg
  → format_conflict_timeline_sentences → processed/context.md  [LLM sentence timeline]
```

**BEV timestamps:** action.yaml boundaries + interaction key times, plus burst
samples at −2/−1/−0.5/−0.2/0/+0.2/+0.5/+1 s around labelled COLLISION/NEAR_MISS.
**Banned:** inventing kinematic labels Labeller never emitted (`ego_HARD_BRAKE`
from `np.gradient`, `MAX_CLOSING`, unconstrained TTC extrema, …).
Hard-brake BEV frames appear only when Labeller emits `EMERGENCY_BRAKE`
(`taxonomy.Thresholds.EMERGENCY_DECEL = -4.0` m/s² mean accel).

| Module | Owns |
|--------|------|
| `taxonomy.py` / `labeller.py` | Action vocabulary + detection |
| `description.py` | Human prose from `action.yaml` (no raw az table) |
| `conflict_frame_selector.py` | Action timestamps + sentence timeline / evidence helpers |
| `tier2_renderer.py` / `map_plotter.py` | Render dual-panel BEVs at those times |
| `cluster_paths.py` | Nested write / nested-then-flat read |
| `dataset_builder.py` | Orchestrates the order above |

CLI: `--conflict-window-s` only **filters** action stamps near a labelled conflict
peak; it is not a kinematic search window.

## Setup

### Install Miniconda

- Follow the steps here: https://docs.anaconda.com/miniconda/

### Create Environment

All dependencies are listed in `environment.yml`. Create the Conda
environment with:

```bash
conda env create -f environment.yml
```

### Configure Payload access

Copy `.env.example` to `.env` in this directory (`app/analyzer/.env`):

```bash
cp .env.example .env
```

Set:

- `PAYLOAD_API` — **base URL only**, e.g. `http://140.113.208.174:3020` (do **not** include `/api`; the code adds `/api/...` paths).
- `PAYLOAD_API_KEY` — same API key as `app/dashboard/.env`.

The Dashboard and Analyzer must point at the **same** Payload instance.

## Run the Server

### Activate Conda Environment

```bash
conda activate analyzer
```

### Start the Server

From `app/analyzer/src`:

```bash
litestar run --port 9010 --debug --host 0.0.0.0 --reload
# Adjust the command arguments if needed
```

Or use `./scripts/start_dev_stack.sh` from the repo root (starts Analyzer on port 9010).

## Start Analyzing from Dashboard

1. Open `http://localhost:3000/batch/<batch_id>` → **Explore**.
2. Open the **Saves** panel → **Create New** → **Analysis**.
3. A progress bar appears while the Analyzer runs (default: ~488 HDBSCAN tasks; can take **15–60+ minutes** for ~200 trials). The Dashboard polls `GET http://localhost:9010/analysis_progress` for live `task N/488` counts — **restart Analyzer** after code updates so this route exists.
4. When complete, open **Clustering Selection** to pick a clustering result.
5. Optional: **save** uploads the analysis JSON to Payload Documents.

**Troubleshooting:** If Analysis fails immediately with HTTP 500, check `logs/dev_stack/analyzer.log` and verify `PAYLOAD_API` in `.env` (no double `/api`). Smoke test:

```bash
curl -X POST http://localhost:9010/trajectory_analysis \
  -H "Content-Type: application/json" \
  -d '{"batchIds":["3"],"framePeriod":0.1,"tasks":[{"method":"hdbscan+mfpca","nClusters":0,"minClusterSize":20,"minSamples":3,"clusterSelectionEpsilon":1.5,"clusterSelectionMethod":"eom"}]}'
```
