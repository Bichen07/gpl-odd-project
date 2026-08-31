# GPL-ODD Project

A pipeline for **ODD (Operational Design Domain) testing of Autonomous Vehicles** using logical scenario search, trajectory clustering, and (in progress) LLM-based cluster interpretation.

---

## Read This First — Two Separate Workflows

This project has **two very different use cases**. Decide which one you need before starting:


| Goal                                                                                        | What you need to run                                                   | Difficulty                        |
| ------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------- | --------------------------------- |
| **A. View existing data** — explore already-collected simulation results in the dashboard   | Analyzer + Dashboard only                                              | Easy — 10 min                     |
| **B. Run new simulations** — collect new trajectory data by running the AV in the simulator | Everything: Sampling + Simulator (Docker + ROS) + Analyzer + Dashboard | Hard — requires ITRI Docker image |


> **If you are a new team member just getting started:** start with Goal A. The lab server already has **many simulation trials** stored (count grows over time; quick check: open `/api/trials?limit=1` and read `totalDocs` in the JSON).



### Where trials are stored (Payload CMS)

Trials are **not** files on your laptop by default. Each simulation run creates:


| Layer                         | Where                         | What                                                                                                          |
| ----------------------------- | ----------------------------- | ------------------------------------------------------------------------------------------------------------- |
| **Database**                  | PostgreSQL behind Payload CMS | All structured records                                                                                        |
| `**trials` collection**       | One row per simulation run    | Trial ID, link to batch, scenario parameters (speed, delay), pass/fail vs KPIs                                |
| `**observations` collection** | Many rows per trial           | Per-frame trajectory: world x/y, yaw, speed, **roadId**, **laneId** — this is the raw data the Analyzer reads |


The Dashboard loads trials via Payload's GraphQL/REST API. The Analyzer service connects to the same Payload API using `PAYLOAD_API_KEY` in its environment.

To inspect counts in a browser or terminal:

```bash
curl -s "http://140.113.208.174:3020/api/trials?limit=1" | python3 -c "import json,sys; print('total trials:', json.load(sys.stdin).get('totalDocs'))"
```

---



## Table of Contents

1. [How the System Works](#1-how-the-system-works)
2. [Prerequisites](#2-prerequisites)
3. [Goal A — View Existing Data (Start Here)](#3-goal-a--view-existing-data-start-here)
4. [Goal B — Run New Simulations](#4-goal-b--run-new-simulations)
5. [BEV & LLM Pipeline (Research)](#5-bev--llm-pipeline-research)
6. [Unit Tests](#6-unit-tests)
7. [Branch & Git Strategy](#7-branch--git-strategy)
8. [Debugging](#8-debugging)
9. [Payload CMS Reference](#9-payload-cms-reference)
10. [Documentation layout](#10-documentation-layout)
11. [Mission Control](#11-mission-control)

---



## 1. How the System Works

```
[Simulator]  →  [Payload CMS]  →  [Analyzer]  →  [Dashboard]
 runs AV          stores all        clusters        shows you
 scenarios        trajectory        trajectories    results
                  data
```

In more detail:

1. **Simulator** runs the AV (Ego) against an Oncoming vehicle with different parameter values (speed, delay). Each run is one "trial". Results are stored automatically in Payload CMS.
2. **Payload CMS** is the central database. It stores every trial's trajectory — x/y position, roadId, laneId, speed — frame by frame.
3. **Analyzer** reads trajectories from Payload, runs MFPCA + UMAP + HDBSCAN to group trials into clusters (groups of similar behaviour).
4. **Dashboard** is the website where you explore everything visually — heatmaps, trajectory scatter plots, a video replayer for individual trials.

There are **3 existing scenarios** on the lab server:

- Batch 1: "Drive out Hct Exit with Oncoming Straight from Right"
- Batch 2: "Overtake Parking with Opposite Oncoming"
- Batch 3: "Overtake cutin"

---



## 2. Prerequisites

Install these once:


| Tool        | Install                                                                                                               |
| ----------- | --------------------------------------------------------------------------------------------------------------------- |
| Miniconda   | [https://docs.anaconda.com/miniconda/](https://docs.anaconda.com/miniconda/)                                          |
| Node.js 18+ | [https://nodejs.org/](https://nodejs.org/)                                                                            |
| Bun         | `curl -fsSL [https://bun.sh/install](https://bun.sh/install)                                                          |
| Docker      | [https://docs.docker.com/engine/install/](https://docs.docker.com/engine/install/) (only for Goal B or local Payload) |


---



## 3. Goal A — View Existing Data (Start Here)

You need **two terminals** running at the same time, plus a browser.

### Terminal 1 — Start the Analyzer Server

The analyzer reads trajectory data from Payload and does the clustering math.

From the **repository root** (the folder that contains `app/`, `README.md`, `tests/`):

```bash
conda activate analyzer
cd app/analyzer/src
litestar run --port 9010 --host 0.0.0.0 --debug --reload
```

You should see:

```
✓ Uvicorn running on http://0.0.0.0:9010
✓ Application startup complete.
```

**Required for Dashboard → Explore → Analyze.** If Analyzer is not running, the UI shows `Analyzer error (network): Network Error`.

Verify: `curl -s -o /dev/null -w '%{http_code}\n' http://localhost:9010/schema` should return `200`.

If you open the Dashboard at `http://<lab-ip>:3000` from another machine, set in `app/dashboard/.env`:

```bash
NEXT_PUBLIC_ANALYZER_API_ADDRESS=http://<lab-ip>:9010
```

(`localhost:9010` in `.env` only works when the browser runs on the same machine as Analyzer.)

Restart `bun run dev` after changing `.env`.

#### What is `http://localhost:9010/schema`?

That URL is the **OpenAPI / Swagger** documentation page Litestar generates automatically from Python types in the analyzer code.

- **You do not need to fill in forms there** for normal use. Seeing the page means the server is up.
- The long lists (`TrajectoryAnalysisRequest`, `ClusteringScores`, `silhouetteScore`, …) are **JSON request/response shapes**, not errors.

They are defined as `@dataclass` types in `app/analyzer/src/controller.py` (around lines 1103–1198). Short glossary:


| Name                         | Meaning                                                                                                                            |
| ---------------------------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| `TrajectoryAnalysisRequest`  | What the Dashboard sends when you click **Analyze**: batch IDs, frame period, list of clustering tasks (HDBSCAN parameters, etc.). |
| `TrajectoryAnalysisResponse` | Full analyzer output: trials, MFPCA scores, UMAP coords, heatmap metadata, clustering results for each task.                       |
| `ClusteringTask`             | One clustering configuration (method string like `hdbscan+mfpca`, `minClusterSize`, `minSamples`, …).                              |
| `ClusteringResult`           | Labels per trial + validation scores for one task.                                                                                 |
| `ClusteringScores`           | Optional metrics: silhouette, Calinski–Harabasz, Davies–Bouldin, relative validity (may be `null` if not computed).                |
| `Mfpca`                      | Functional PCA scores and nested clustering / UMAP projections.                                                                    |


So when the schema UI shows `#0 null` / `#1 number` under nested fields, it means “this field can be null **or** a number” in the API contract — not that something is broken.

---



### Terminal 2 — Start the Dashboard

The Dashboard can run in **development** or **production** mode. Both use port **3000** — only one can run at a time.


|                        | Development (`bun run dev`)     | Production (`bun run build` + `bun run start`)          |
| ---------------------- | ------------------------------- | ------------------------------------------------------- |
| **When to use**        | Daily lab work, editing UI code | Deploy-like run, no hot reload                          |
| **Needs** `build`**?** | No — compiles on the fly        | Yes — `bun run start` reads `.next/` from a prior build |
| **Command**            | `bun run dev`                   | `bun run build` then `bun run start`                    |
| **Hot reload**         | Yes                             | No                                                      |


**Why** `localhost:3000` **sometimes opens without you running anything:** `./scripts/start_dev_stack.sh` (or an old `bun run dev`) may already be listening on 3000. Check with `ss -tlnp \| grep 3000`. If something is there, use that URL or stop the old process before starting again.

**Why** `bun run start` **fails with “Could not find a production build”:** `start` is production mode. Run `bun run build` first (once per code change), or switch to dev mode below.

#### Option A — Development mode (recommended for lab use)

```bash
cd app/dashboard
bun run dev --hostname 0.0.0.0
```

`--hostname 0.0.0.0` lets you open the Dashboard from another machine (e.g. `http://140.113.208.174:3000`).

You should see something like:

```
▲ Next.js …
- Local:   http://localhost:3000
- Network: http://<your-lab-ip>:3000
✓ Ready
```



#### Option B — Production mode

```bash
cd app/dashboard
bun run build    # required before start; re-run after dashboard code changes
bun run start --hostname 0.0.0.0
```

You should see:

```
✓ Ready in …ms
- Local: http://localhost:3000
```

Open **[http://localhost:3000](http://localhost:3000)** in your browser. This is the main dashboard.

> **If** `bun run build` **fails**, see [ISSUES.md](./ISSUES.md) for the fix.

> **Port already in use (**`EADDRINUSE`**):** Another Dashboard is already running. Use the existing tab, or stop it (`kill $(lsof -ti :3000)` or close the terminal running `dev`/`start`), then start again.

---



### Navigate the Dashboard

1. Open [http://localhost:3000](http://localhost:3000)
2. Click **Sessions** in the top menu
3. Click a session → open the batch inside it
4. You will see several dock panels:
  - **Scenario Parameter Space** — scatter plot of sampled parameters (e.g. delay vs speed)
  - **Trajectory Projection Space** — UMAP / MFPCA projection of trajectories
  - **Replayer** — animate a selected trial
  - **Trajectory Heatmap** — spatial density on the map



#### Why points look **black** instead of colourful clusters

Cluster colours come from **which clustering run you selected**, not from opening the batch alone.

After you click **Analyze** or load a saved ZIP:

1. Open the **clustering result list** for each ego (often under **Clustering Selection** / per-ego panel — a vertical list of small cards, one per HDBSCAN parameter combination).
2. **Click one row/card** in that list to activate it.

Until you do that, Redux keeps `selectedClusterInfos` empty and the scatter plots deliberately paint every point **black** (see `Legends/index.tsx` fallback and `ParameterSpace/Plot/index.tsx` when `clusterInfo == null`).

The code that would auto-select the first clustering result is **commented out** in `app/dashboard/src/app/batch/[id]/_tabs/explore/redux/slices/batch.ts` (search for `selectFirst`), so manual selection is expected behaviour today.

**Colour mode:** ensure the Parameter Space / Projection panels use **interaction-cluster** (not only pass/fail) if you want cluster colours.

#### **Saves** vs **Create New → Analysis**


| UI section                | What it does                                                                                                                                                                                               |
| ------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Saves**                 | Loads a previously uploaded `**analyze.zip`** (or similar) from Payload **Documents** attached to this batch. Someone must have run Analyze + Save once to create that file.                               |
| **Create New → Analysis** | Calls your **local** Analyzer (`localhost:9010`) with a large grid of predefined `hdbscan+mfpca` tasks (see `app/dashboard/.../Saves/index.tsx`). Can take **many minutes** — watch the analyzer terminal. |


So:

- If Session / Batch **has no ZIP under Saves**, nothing is “lost” — it usually means **nobody saved an analysis document for that batch yet**. Run **Analysis** once, then optionally use **Save** to upload a named ZIP for faster reload later.
- Session 1 showing `analysis-3.zip` simply means that batch has at least one saved document in Payload.

---



## 4. BEV & LLM Pipeline (Research)

End-to-end path from **fresh simulation** → clustering → BEV pack → split LLM cards.

### Workflow & dataflow

```text
Sampling (/initialize, /suggest, /register)
  → Simulation (SPSS / esmini)
  → records/esmini_<batch>_<index>.csv          [trajectory ground truth]
  → sampler posts observations + KPIs to Payload
  → Dashboard Explore → Analyzer /trajectory_analysis
  → MFPCA + UMAP + HDBSCAN (in Payload saved analysis zip)
  → dataset_builder.py (clustering + local CSV → results/…)
  → llm_pipeline.cli cluster-interpret (split products)
  → Analyze UI (Split cards) / Explore Replayer (timeline from medoid_trial)
```


| Stage                                                | System                   | Primary code                                           |
| ---------------------------------------------------- | ------------------------ | ------------------------------------------------------ |
| Simulate + record                                    | esmini / ROS             | `simulation/ros/src/scenario_search/…`                 |
| Upload trials / KPIs                                 | Sampler + Payload        | `scenario_sampler.py`, Payload collections             |
| MFPCA / HDBSCAN                                      | Analyzer `:9010`         | `app/analyzer/src/controller.py`                       |
| Select / save clustering                             | Dashboard Explore        | `app/dashboard` → Payload `savedTrajectoryAnalysis`    |
| Build medoid / BEV / labels                          | Analyzer dataset builder | `app/analyzer/src/dataset_builder.py`                  |
| LLM cards (medoid / summary / Parameter-space pairs) | LLM pipeline             | `app/llm_pipeline/` → `scripts/run_cluster_analyze.sh` |


**Authoritative trajectory:** local CSV `simulation/ros/.cache/scenario_search/records/esmini_<batch>_<index>.csv`.  
**Clustering source for builds:** Payload saved analysis (not legacy `alldatasets/` / `old_alldatasets/`).

Code layout:


| Path                                          | Role                                                       |
| --------------------------------------------- | ---------------------------------------------------------- |
| `app/analyzer/src/dataset_builder.py`         | Map ensure + medoid BEV / labels / context / closest pairs |
| `app/analyzer/src/conflict_frame_selector.py` | Conflict keyframes; dual-panel pair-zoom | ego-zoom        |
| `app/analyzer/src/tier2_renderer.py`          | BEV rendering                                              |
| `app/llm_pipeline/python/llm_pipeline/`       | Split-analysis products + CLI                              |
| `app/llm_pipeline/prompt_templates/`          | Active prompts (see `app/llm_pipeline/README.md`)          |


```bash
conda activate analyzer
cd /path/to/gpl-odd-project
export PYTHONPATH="app/llm_pipeline/python:app/analyzer/src"
```



### Build LLM dataset (map + medoid BEV + labels)

**One command** creates a complete pack. Map assets under `results/map/` are checked
automatically and generated only when missing.

**Prerequisites**

1. Simulations finished and trials uploaded to Payload for the batch.
2. Dashboard **Analyze** + **Save** completed (saved analysis zip in Payload).
3. Analyzer conda env (`conda activate analyzer`).
4. esmini `odrplot` available if tracks are not yet in `results/map/` (first run only).

```bash
conda activate analyzer
cd /path/to/gpl-odd-project
export PYTHONPATH="app/llm_pipeline/python:app/analyzer/src"

# List clustering candidates (index / k / silhouette):
python3 app/analyzer/src/dataset_builder.py --batch-id 2 --list-clusterings

# CREATE best-silhouette k=4 (auto map ensure + full cluster pack):
python3 app/analyzer/src/dataset_builder.py --batch-id 2 --k 4

# Pin silhouette when several k=4 results exist:
python3 app/analyzer/src/dataset_builder.py --batch-id 2 --k 4 --silhouette 0.6945

# REBUILD BEV/labels only (existing folder; map still auto-checked):
python3 app/analyzer/src/dataset_builder.py --batch-id 2 --from-run results/batch2/4_cluster

# Map assets only (optional; normally done automatically):
python3 app/analyzer/src/dataset_builder.py --batch-id 2 --map-only
python3 app/analyzer/src/dataset_builder.py --batch-id 2 --map-only --force-map
```


| Job                        | Command                                                          |
| -------------------------- | ---------------------------------------------------------------- |
| **Create** complete folder | `python3 app/analyzer/src/dataset_builder.py --batch-id 2 --k 4` |
| **Rebuild** BEV/labels     | `… --batch-id 2 --from-run results/batch2/4_cluster`             |
| **Map only**               | `… --batch-id 2 --map-only`                                      |


> `--from-run` does **not** create a missing k. If `2_cluster_s=…` was never built,
> use CREATE with `--k 2` instead.

**Output layout**

```
results/map/                         # shared (auto-ensured)
  hct_6_no_930.xodr / _tracks.csv / .yaml / .jpg …
results/batch2/3_cluster_s=0.7036/
├── clustering/selectedClusteringResult.json
├── manifest.json                    # medoids + trajectory_projection_pairs + parameter_space_pairs
├── parameter_space_pairs/pair_c{A}_c{B}.yaml
└── clusterN/
    ├── raw/                         # trajectory.csv, cluster.json
    ├── processed/                   # action, description, context, snapshots, …
    ├── output/                      # medoid_trial / cluster_summary / shim YAMLs
    └── highlight_trials/
        ├── outlier_trials/trial_<idx>/
        ├── boundary_c<M>/trial_<idx>/   # MFPCA embedding closest pair
        └── param_boundary_c<M>/trial_<idx>/  # parameter-space closest pair
```

**Auxiliary trial scopes** (same CLI — rebuild selectively with `--from-run`):


| Flag                                | Default | What it builds                                                                                                     |
| ----------------------------------- | ------- | ------------------------------------------------------------------------------------------------------------------ |
| `--medoids`                         | `all`   | Medoid pack under `clusterN/`                                                                                      |
| `--emb-boundaries` (`--boundaries`) | `all`   | Embedding closest pairs → `highlight_trials/boundary_c*`                                                           |
| `--param-boundaries`                | `none`  | Parameter-space closest pairs → `highlight_trials/param_boundary_c*` (z-scored OncomingSpeed / OncomingStartDelay) |
| `--outliers`                        | `all`   | Top outlier → `highlight_trials/outlier_trials/`                                                                   |


```bash
# IC (Parameter Space) closest pairs only — keep existing medoids / emb pairs:
python3 app/analyzer/src/dataset_builder.py \
  --batch-id 2 --from-run results/batch2/3_cluster_s=0.7036 \
  --medoids none --outliers none \
  --emb-boundaries none --param-boundaries all
```

**Dashboard:** Explore → ClusteringSelection → **Highlight trials** can multi-select
Medoid / Closest pair (emb) / Closest pair (IC) / Outlier; markers appear in
ParameterSpace (green square = IC) and ProjectionSpace (cyan diamond = emb).

**BEV dual-panel:** each `snapshots/*.jpg` is `pair zoom | ego ±R` (default R=30 m).
Left is always the ego–partner frustum (`pair_zoom_bounds`), not the whole map.
Set `--ego-zoom-radius 0` for a single-panel fallback.


| Flag                                      | Default  | What it controls                             |
| ----------------------------------------- | -------- | -------------------------------------------- |
| `--snapshot-size`                         | `1024`   | Square BEV image resolution                  |
| `--agent-id-size`                         | `10`     | On-car agent ID font (pt)                    |
| `--ego-zoom-radius`                       | `30`     | Right-panel ego zoom (m); `0` = single panel |
| `--road-label-size` / `--lane-label-size` | tuned    | Road / lane ID fonts on snapshots            |
| `--max-snapshots`                         | uncapped | Cap BEV frames per medoid                    |
| `--force-map` / `--skip-map`              | off      | Force / skip auto map ensure                 |


Code: `dataset_builder.py` → `map_assets.py` + `tier2_renderer` / `map_plotter` / `conflict_frame_selector`.

### LLM pipeline — cluster interpretation (terminal)

After preprocess has produced `results/batch<id>/<k>_cluster_s=…/`, run interpretation
from the **repo root** in the `analyzer` conda env. Product details, prompts, and
dataflow: `[app/llm_pipeline/README.md](app/llm_pipeline/README.md)`.

#### 1. API key (required for live LLM)

The CLI reads the key from the **shell environment** (not from `app/analyzer/.env`
or `app/dashboard/.env` — those are for Payload only).


| Provider             | Env var          | Typical model      |
| -------------------- | ---------------- | ------------------ |
| **Gemini** (default) | `GOOGLE_API_KEY` | `gemini-2.5-flash` |
| OpenAI               | `OPENAI_API_KEY` | `gpt-4o`           |


```bash
# Prefer export in this terminal session (do not commit keys):
export GOOGLE_API_KEY="your-gemini-key-here"
# or:  export OPENAI_API_KEY="sk-..."
```

**Where to get a Gemini key:** [Google AI Studio](https://aistudio.google.com/apikey).

**Dashboard “Select and analyze”:** paste the same key in the UI; the Next API route
injects it into the env for `scripts/run_cluster_analyze.sh` only (never written to disk).

#### 2. Run interpretation

Default products: **medoid**, **summary**, **parameter-space-pairs**.  
`--products legacy` = alias for `medoid,summary` (thin `cluster_interpretation.yaml` pointer).

```bash
cd /path/to/gpl-odd-project
conda activate analyzer
export PYTHONPATH="app/llm_pipeline/python:app/analyzer/src"
export GOOGLE_API_KEY="your-gemini-key-here"

python3 -m llm_pipeline.cli cluster-interpret \
  --results-dir results/batch2/3_cluster_s=0.7036 --batch-id 2 \
  --products medoid,summary,parameter-space-pairs --no-review
```



#### 3. Outputs (roles)


| File                                        | Role                                                               |
| ------------------------------------------- | ------------------------------------------------------------------ |
| `clusterN/cluster_aggregate.json`           | Deterministic TTC/IC digests (from Payload KPIs)                   |
| `clusterN/medoid_trial.yaml`                | **Trial** card — motive timeline (canonical)                       |
| `clusterN/cluster_summary.yaml`             | **Cluster** card — caption + risk over digests                     |
| `parameter_space_pairs/pair_c{A}_c{B}.yaml` | Parameter-space closest-pair contrast                              |
| `clusterN/cluster_interpretation.yaml`      | Thin pointer (label/risk/caption only — **no** timeline duplicate) |


Analyze → **Split cards** is the report viewer. Explore Replayer loads the timeline from
`medoid_trial` via the status API (not from a copied shim field).

#### 4. Next (future): IC boundary model → XOSC → resim

```text
(future) IC safety / boundary model → edge IC candidates
  → OpenSCENARIO param instantiation → sim → Payload
  → rebuild dataset_builder + re-interpret
```

More detail: `app/llm_pipeline/README.md`.

---



## 5. Unit Tests

```bash
conda activate analyzer
cd /path/to/gpl-odd-project   # repository root

python3 tests/test_roadid_preservation.py    # 7 tests — roadId bug fix
python3 tests/test_cluster_medoid.py         # 9 tests — medoid selection
python3 tests/test_bev_renderer.py           # 14 tests — BEV renderer
```

All 30 tests should end with `OK`.

---



## 6. Branch & Git Strategy



### Senior repo (`ian-chiu/gpl-odd-project`) — three branches


| Branch       | Role                                                                                       | Tip (fetched) |
| ------------ | ------------------------------------------------------------------------------------------ | ------------- |
| `**dev**`    | **Default** (`upstream/HEAD` → `dev`). Active integration line; merged `update` via PR #3. | `9019911`     |
| `**main`**   | Older stable / release line                                                                | `ed1691f`     |
| `**update**` | Senior WIP feature branch (content largely merged into `dev`)                              | `6e3a1de`     |


**Which branch do we build from?** Lab fork work is on `main` (`origin/main`, default on `Bichen07/gpl-odd-project`). It contains the integrated lab-specific work (analyzer, Mission Control, LLM pipeline, cluster interpretation, etc.). Senior upstream default is `**dev`** on `ian-chiu/gpl-odd-project`.

```
ian-chiu/gpl-odd-project (upstream)
  ├── dev      ← upstream default
  ├── main
  └── update

Bichen07/gpl-odd-project (origin — your fork)
  └── main     ← default; all integrated lab work lives here
```

```bash
git branch                        # see current branch (should be main)
git push origin main              # push to YOUR fork

git remote -v
# origin    https://github.com/Bichen07/gpl-odd-project.git   ← your fork (push here)
# upstream  git@github.com:ian-chiu/gpl-odd-project.git       ← senior (fetch only; push = no_push)
```

To refresh senior branches: `git fetch upstream` then compare with `git log --oneline HEAD..upstream/dev`.

---



## 7. Debugging



### `[Errno 98] Address already in use` on port 9010

That means **another process is already listening on 9010** (usually an older Litestar analyzer you forgot to stop). The second terminal cannot bind the same port, so **that second start fails** — but the **first** analyzer may still be running fine.

Check who owns the port:

```bash
ss -tlnp | grep 9010
# or:  lsof -i :9010
```

**Fix:** Either keep using the existing analyzer only (do not start a second one), or stop the old one (`Ctrl+C` in its terminal, or `kill <pid>`), then start fresh.

---



### Dashboard “Analysis” never finishes or no clustering appears

Work through these in order:

1. **Exactly one analyzer on 9010** — `curl -s -o /dev/null -w "%{http_code}\n" http://localhost:9010/schema` should print `200`.
2. **Same Payload as the dashboard** — Analyzer loads `app/analyzer/.env` (`PAYLOAD_API`, `PAYLOAD_API_KEY`). Dashboard uses `app/dashboard/.env` (`NEXT_PUBLIC_PAYLOAD_API_`*). Both must point at the **same** Payload server (lab IP vs `localhost:3020`). If the analyzer talks to an empty local DB while the dashboard shows lab batches, clustering will fail or return nothing useful.
3. **Browser errors** — Open DevTools (F12) → **Network**. Click **Create New → Analysis** and watch for `POST .../trajectory_analysis` (via `NEXT_PUBLIC_ANALYZER_API_ADDRESS`). Red status / `ECONNREFUSED` / `502` means the dashboard cannot reach the analyzer.
4. **Very long runtime** — The dashboard sends **many** clustering tasks in one request (see `app/dashboard/.../Saves/index.tsx`). Processing can take **much longer** than a few minutes and may look stuck; watch the **analyzer terminal** for logs.
5. **Scatter plots stay black** — After analysis completes or after loading a ZIP, **click one clustering result row** in the per-ego clustering list (auto-select is disabled in code today). See §3 “Why points look black”.

---

**Check which services are running:**

```bash
ps aux | grep -E "litestar|next-server|bun" | grep -v grep
```

**Test Payload CMS is reachable:**

```bash
curl http://140.113.208.174:3020/api/batches?limit=1
# Should return JSON with batch data, not an error
```

**Test analyzer is reachable:**

```bash
curl http://localhost:9010/schema
# Should return HTML — if you get "Connection refused", the server is not running
```

**Test sampling server is reachable:**

```bash
curl http://localhost:9009/schema
# Should return HTML — the 404 on / is normal (there is no homepage, only /schema)
```

**Dashboard shows blank page:**

- Check that `app/dashboard/.env` has the correct Payload address and API key
- Re-run `bun run build` before `bun run start`
- Check browser console (F12) for specific errors

**Analyzer takes very long:**

- Normal — MFPCA on 1000+ trials takes 5–10 minutes
- Watch the analyzer terminal for progress messages

---



## 8. Payload CMS Reference


| URL                                                                                              | What it is                                    |
| ------------------------------------------------------------------------------------------------ | --------------------------------------------- |
| [http://140.113.208.174:3020/admin](http://140.113.208.174:3020/admin)                           | Admin UI — log in to browse and edit all data |
| [http://140.113.208.174:3020/api](http://140.113.208.174:3020/api)                               | REST API root                                 |
| [http://140.113.208.174:3020/api/batches](http://140.113.208.174:3020/api/batches)               | List all batches (JSON)                       |
| [http://140.113.208.174:3020/api/trials?limit=5](http://140.113.208.174:3020/api/trials?limit=5) | First 5 trials                                |


**Key data collections:**


| Collection   | What it stores                                                       |
| ------------ | -------------------------------------------------------------------- |
| Scenarios    | Scenario definitions (parameter ranges, `.xodr` map, `.xosc` script) |
| Sessions     | Groups of related batches                                            |
| Batches      | One scenario with a sampling strategy — this is the unit you analyze |
| Trials       | One simulation run (one parameter sample)                            |
| Observations | Per-frame trajectory data: x, y, heading, speed, roadId, laneId      |
| Documents    | Saved analysis results (`analyze.zip`)                               |


**Credentials:** Ask your supervisor. The API key in `app/dashboard/.env` is already configured for read access.

---



## 9. Documentation layout

Keep **both**:


| Doc                         | Role                                                                                                                    |
| --------------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| `**README.md`** (this file) | End-to-end workflow: Payload → Analyzer → Dashboard → optional simulation. Written for someone setting up from scratch. |
| `**app/*/README.md**`       | Deep detail per service (conda env file paths, Payload sampling configuration, dashboard submodule build).              |


Do not delete the per-app READMEs — they complement this root overview.

---



## 10. Mission Control

**Status:** Implemented — Mission Control API (port 8282) + Dashboard **Mission Control** tab on batch Explore dock.

**What it does:**

- Starts simulation runs from the Dashboard or `POST /simulation/run`
- Orchestrates per-trial `roslaunch` inside `sdc-bionic` via `app/simulation/src/orchestrator.py`
- Shows real-time progress (WebSocket), health chips, and data-quality summary
- Validates CSV output after each trial

**Docs:**


| Doc                                                                          | Use when                                                             |
| ---------------------------------------------------------------------------- | -------------------------------------------------------------------- |
| [readMD/MISSION_CONTROL_USER_GUIDE.md](readMD/MISSION_CONTROL_USER_GUIDE.md) | You want step-by-step commands (ports, SSH, container)               |
| [readMD/MISSION_CONTROL.md](readMD/MISSION_CONTROL.md)                       | You need architecture, file call graph, Payload/simulation data flow |


**Legacy alternative:** README §4 Goal B tmux `run.sh` (same ROS stack, no Mission Control API).

**Research integration:** See root README §5 and `app/llm_pipeline/README.md` for
clustering / BEV / split LLM cards.

---



## Related Files

| `app/llm_pipeline/README.md`              | Split LLM products, prompts, dataflow                                               |
| `HOW_TO_RUN.md`                           | Short quick-reference for commands                                                  |
| `CHANGELOG.md`                            | Record of code changes                                                              |
| `ISSUES.md`                               | **Unresolved** problems and directions to verify (not a changelog of fixes)         |
| `readMD/MISSION_CONTROL.md`               | Simulation pipeline reference (call graph, Payload, vehicle_parameters, how to run) |
| `readMD/MISSION_CONTROL_USER_GUIDE.md`    | Operator runbook for Mission Control on the lab PC                                  |
| `app/analyzer/README.md`                  | Analyzer-specific setup details                                                     |
| `app/sampling/README.md`                  | Sampling server API reference                                                       |
| `app/dashboard/README.md`                 | Dashboard build steps                                                               |
| `app/payload/README.md`                   | Payload CMS local setup                                                             |