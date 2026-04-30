# GPL-ODD Project

A pipeline for **Operational Design Domain (ODD) testing of Autonomous Vehicles** using logical scenario search, trajectory clustering, and LLM-based scenario interpretation.

---

## Table of Contents

1. [System Overview](#1-system-overview)
2. [Architecture & Data Flow](#2-architecture--data-flow)
3. [Prerequisites](#3-prerequisites)
4. [Service Quick-Reference](#4-service-quick-reference)
5. [Setup — First Time](#5-setup--first-time)
   - [Payload CMS](#51-payload-cms)
   - [Sampling Server](#52-sampling-server)
   - [Analyzer Server](#53-analyzer-server)
   - [Dashboard (Web UI)](#54-dashboard-web-ui)
6. [Running the Full Pipeline](#6-running-the-full-pipeline)
   - [Step 1 — Configure a Batch](#step-1--configure-a-batch-in-payload-cms)
   - [Step 2 — Start the Sampling Server](#step-2--start-the-sampling-server)
   - [Step 3 — Run Simulations](#step-3--run-simulations)
   - [Step 4 — Start the Analyzer](#step-4--start-the-analyzer-server)
   - [Step 5 — Trigger Analysis from Dashboard](#step-5--trigger-analysis-from-the-dashboard)
   - [Step 6 — Explore Results in Dashboard](#step-6--explore-results-in-the-dashboard)
7. [BEV Renderer (Phase 3)](#7-bev-renderer-phase-3)
8. [Unit Tests](#8-unit-tests)
9. [Branch & Git Strategy](#9-branch--git-strategy)
10. [Debugging & Useful Commands](#10-debugging--useful-commands)
11. [Payload CMS Admin Reference](#11-payload-cms-admin-reference)
12. [Integration Plan Reference](#12-integration-plan-reference)

---

## 1. System Overview

GPL-ODD tests ITRI's AV system in a simulator (esmini + ROS) against a large number of parameterized scenarios drawn from a **logical scenario** (a family of related scenarios defined by continuous parameters like speed, distance, lateral offset). The system:

1. **Samples** parameter combinations using Bayesian adaptive sampling (Sobol, Straddle) to find collision-boundary scenarios efficiently.
2. **Simulates** each sampled scenario using esmini and the ITRI AV ROS stack inside Docker.
3. **Stores** simulation results (trajectories, outcomes) in Payload CMS (PostgreSQL backend).
4. **Analyzes** the collected trajectories using MFPCA → UMAP → HDBSCAN clustering to group scenarios into behavioural patterns.
5. **Visualises** results in an interactive web dashboard.
6. **(In progress)** **Interprets** clusters automatically using LLM with BEV image context.

---

## 2. Architecture & Data Flow

```
┌─────────────────────────────────────────────────────────────────────┐
│  Simulation Host (Docker)                                           │
│                                                                     │
│  ┌────────────┐   suggest   ┌──────────────┐                       │
│  │ Simulation │ ──────────► │   Sampling   │ :9009                 │
│  │ (esmini +  │             │   Server     │                       │
│  │  ITRI AV)  │ ◄────────── │  (Litestar)  │                       │
│  └─────┬──────┘   sample    └──────────────┘                       │
│        │ trajectory                                                  │
│        │ + outcome                                                   │
│        ▼                                                             │
│  ┌─────────────┐                                                    │
│  │ Payload CMS │ :3020  (PostgreSQL + Next.js)                     │
│  │ - Scenarios │  Admin UI: http://140.113.208.174:3020/admin       │
│  │ - Batches   │                                                    │
│  │ - Trials    │                                                    │
│  │ - Obs.      │◄──────────────────────────────────────────────────┤
│  └──────┬──────┘                                                    │
│         │ REST API                                                   │
│         ▼                                                            │
│  ┌──────────────┐  trigger analysis  ┌───────────────┐              │
│  │  Dashboard   │ ─────────────────► │   Analyzer    │ :9010        │
│  │  (Next.js)   │                    │   (Litestar)  │              │
│  │  :3000       │ ◄───────────────── │ MFPCA/UMAP/   │              │
│  └──────────────┘  trajectories.json │ HDBSCAN       │              │
│                                      └───────────────┘              │
└─────────────────────────────────────────────────────────────────────┘
```

**Key files produced by analysis:**

| File | Contents |
|---|---|
| `trajectories.json` | Per-trial trajectory arrays with `roadId`, `laneId`, `x`, `y`, `speed` |
| `selectedClusteringResult_Nclusters.json` | Cluster labels + MFPCA scores |
| `heatmap.zip` / `analyze.zip` | Full analysis bundle stored in Payload Documents |

---

## 3. Prerequisites

| Tool | Minimum Version | Purpose |
|---|---|---|
| Git | any | source control |
| Docker + Compose | 24+ | Payload CMS + PostgreSQL |
| Python | 3.8+ | Sampling & Analyzer servers |
| Miniconda | any | isolated Python environments |
| Node.js | 18+ | Dashboard build |
| Bun | 1.0+ | Dashboard package manager & runner |

Install Bun: `curl -fsSL https://bun.sh/install | bash`

Install Miniconda: https://docs.anaconda.com/miniconda/

---

## 4. Service Quick-Reference

| Service | URL | Who starts it |
|---|---|---|
| Payload CMS (remote) | http://140.113.208.174:3020 | already running on lab server |
| Payload Admin UI | http://140.113.208.174:3020/admin | remote — open in browser |
| Sampling Server | http://localhost:9009 | you (`conda activate sampling`) |
| Analyzer Server | http://localhost:9010 | you (`conda activate analyzer`) |
| Dashboard | http://localhost:3000 | you (`bun run start`) |

> The Payload CMS instance at `140.113.208.174:3020` is a shared lab server.
> If running locally, start it with Docker (see §5.1 below).

---

## 5. Setup — First Time

### 5.1 Payload CMS

**Option A — Use the shared lab server (recommended for development)**

The `.env` in `app/dashboard/` already points to the lab server. No local setup needed. Skip to §5.2.

**Option B — Run Payload locally with Docker**

```bash
cd app/payload

# Copy and edit environment variables
cp .env.example .env
# Edit .env:
#   HOST_DATA_MOUNT_PATH=/your/local/data/path
#   DATABASE_URI=postgres://postgres:payloadpass@postgres:5432/payloaddb

# Start Payload + PostgreSQL
docker compose up -d

# Admin UI is now at http://localhost:3020/admin
# Create your first admin user on first visit.
```

Update `app/dashboard/.env`:
```bash
NEXT_PUBLIC_PAYLOAD_API_ADDRESS=http://localhost:3020
NEXT_PUBLIC_PAYLOAD_API_KEY=<your-api-key-from-admin>
NEXT_PUBLIC_ANALYZER_API_ADDRESS=http://localhost:9010
```

---

### 5.2 Sampling Server

```bash
cd app/sampling

# Create conda environment (first time only)
conda env create -f environment.yml

# Activate and start
conda activate sampling
cd src
litestar run --port 9009 --host 0.0.0.0 --debug --reload
```

Verify:
```bash
curl http://localhost:9009/schema   # returns Litestar API schema HTML
```

---

### 5.3 Analyzer Server

```bash
cd app/analyzer

# Create conda environment (first time only)
conda env create -f environment.yml

# Activate and start
conda activate analyzer
cd src
litestar run --port 9010 --host 0.0.0.0 --debug --reload
```

Verify:
```bash
curl http://localhost:9010/schema   # returns Litestar API schema HTML
```

---

### 5.4 Dashboard (Web UI)

The dashboard has a **customised** `regl-scatterplot` submodule that must be built locally before the main project. Do this in order:

```bash
cd app/dashboard

# Step 1 — build the customised scatter-plot submodule
cd third_party/regl-scatterplot
npm install
npm run build
cd ../..

# Step 2 — link submodule and install all dependencies
bun add ./third_party/regl-scatterplot
bun install

# Step 3 — build the Next.js project
bun run build

# Step 4 — start the dashboard
bun run start
# → open http://localhost:3000
```

> **Important:** `bun run start` only works after `bun run build`.
> For development with hot reload use `bun run dev` instead (skips build step).

If you see a blank page or API errors, check that `.env` contains the correct Payload address and API key.

---

## 6. Running the Full Pipeline

### Step 1 — Configure a Batch in Payload CMS

1. Open http://140.113.208.174:3020/admin (or your local admin).
2. Create or reuse a **Scenario** (defines parameter ranges, `.xodr`, `.xosc` files).
3. Create a **Session** (groups related batches).
4. Create a **Batch** and link it to the Scenario and Session.
5. In the Batch, set the **Sampling** strategy (Uniform → Sobol → Straddle).
6. Note the Batch ID — you will need it in the next step.

---

### Step 2 — Start the Sampling Server

```bash
conda activate sampling
cd app/sampling/src
litestar run --port 9009 --host 0.0.0.0 --debug --reload
```

Then initialize it with your batch:
```bash
curl -X POST http://localhost:9009/initialize \
     -H "Content-Type: application/json" \
     -d '{"batch_id": "<your-batch-id>"}'
```

---

### Step 3 — Run Simulations

The simulation requires the full Docker + ROS environment (ITRI AV stack). To start parallel simulations:

```bash
cd app/simulation/scripts
tmux                        # start tmux so simulations survive disconnects
./run.sh <parallel_count>   # e.g. ./run.sh 4  for 4 parallel workers
```

tmux navigation:
- `Ctrl-B S` → session list
- `Ctrl-B N` / `Ctrl-B P` → next / previous window
- `Ctrl-C` → stop a worker

Each worker:
1. Calls `/suggest/{batch_id}` on the sampling server to get a parameter set.
2. Runs esmini with the parameterised scenario.
3. Converts the `.dat` record to CSV for ground-truth `roadId`/`laneId`.
4. Posts the result (collision, speed, TTC) to `/register` on the sampling server.
5. Stores trajectory observations in Payload CMS.

Clean up after stopping:
```bash
rm -rf simulation/ros/.cache/scenario_search   # removes cached esmini records
```

---

### Step 4 — Start the Analyzer Server

```bash
conda activate analyzer
cd app/analyzer/src
litestar run --port 9010 --host 0.0.0.0 --debug --reload
```

---

### Step 5 — Trigger Analysis from the Dashboard

1. Open http://localhost:3000.
2. Navigate: **Sessions → your session → your batch**.
3. Click the **Save** tab → **Create New** → **Analyze**.
4. Wait a few minutes (watch the analyzer terminal for progress logs).
5. When complete, the result (`analyze.zip`) appears in the batch's Documents tab.

The analysis runs:
- MFPCA on all trajectories
- UMAP dimensionality reduction
- HDBSCAN clustering
- Medoid selection per cluster (Phase 2)
- Heatmap computation

---

### Step 6 — Explore Results in the Dashboard

Available views:

| View | What it shows |
|---|---|
| **Scenario Parameter Space** | All sampled (d, v, y) points coloured by collision outcome |
| **Trajectory Projection Space** | UMAP scatter of trajectories coloured by cluster |
| **Replayer** | Animate the ego + oncoming vehicles for a selected trial |
| **Trajectory Heatmap** | Spatial density of all trajectories on the road map |
| **Cluster Panel** | Per-cluster summary (medoid trial, member count) |

---

## 7. BEV Renderer (Phase 3)

Generates top-down (Bird's Eye View) map snapshots for each cluster medoid. These images are used as visual context for LLM-based cluster interpretation (Phase 4+).

### How it works

1. **XodrParser** parses `hct_6.xodr` and computes:
   - Road reference lines (centerline of each road)
   - Lane boundary polylines (by offsetting the reference line perpendicularly using each lane's width polynomial `w(s) = a + b·s + c·s² + d·s³`)
2. **Key frame selection** using trajectory curvature analysis (adapted from `xosc_gen/trajectory_feature.py`):
   - Computes `κ = |ẋÿ − ẍẏ| / (ẋ²+ẏ²)^1.5` for the Ego trajectory
   - Selects local maxima of κ (turning / decision moments)
   - Always includes: start, closest approach, and end
3. **BevRenderer** draws each key frame as a `.jpg` with:
   - Road map (dark gray = driving lanes, light gray = shoulder)
   - Ego trajectory path (orange dashed)
   - Oncoming trajectory path (blue dashed)
   - Agent bounding boxes with label and velocity arrow

### Run the BEV renderer

```bash
conda activate analyzer
cd /path/to/gpl-odd-project

bash scripts/run_bev.sh <dataset_name> <n_clusters>
# Example:
bash scripts/run_bev.sh dataset1 3
```

**Expected output structure:**
```
bev_output/
└── dataset1/
    └── 3clusters/
        ├── cluster_0/
        │   ├── trial_4955_frame_000.jpg   (start)
        │   ├── trial_4955_frame_001.jpg   (κ-peak, curvature=0.086)
        │   └── ...
        ├── cluster_1/
        └── cluster_2/
```

**Required input files** (place under `alldatasets/<dataset_name>/`):
```
alldatasets/
└── dataset1/
    ├── trajectories.json
    ├── selectedClusteringResult_3Clusters.json
    └── resources/
        └── xodr/
            └── hct_6.xodr
```

> `alldatasets/` is in `.gitignore` (files are large). Copy it from the shared drive.

---

## 8. Unit Tests

All tests live in `tests/`. Run with the `analyzer` conda environment.

```bash
conda activate analyzer
cd /path/to/gpl-odd-project

# Phase 1 — roadId preservation fix (7 tests)
python3 tests/test_roadid_preservation.py

# Phase 2 — cluster medoid selection (9 tests)
python3 tests/test_cluster_medoid.py

# Phase 3 — BEV renderer geometry + key frame selection (14 tests)
python3 tests/test_bev_renderer.py
```

All tests should end with `OK`. No external services or files required (mocked internally).

---

## 9. Branch & Git Strategy

```
Bichen07/gpl-odd-project (your fork)
  └── carlos1                  ← clean base (no LFS issues)
        └── feature/cluster-medoid  ← current work (Phases 1–3)
```

```bash
# Check current branch
git branch

# Push to YOUR fork only (never push to origin = ian-chiu's repo)
git push carlos feature/cluster-medoid

# See remote aliases
git remote -v
# carlos  https://github.com/Bichen07/gpl-odd-project.git  (your fork)
# origin  https://github.com/ian-chiu/gpl-odd-project.git  (senior's repo — read only)
```

> **Warning:** Never `git push origin`. That is your senior's repository.

---

## 10. Debugging & Useful Commands

```bash
# Check which services are currently running
ps aux | grep -E "litestar|next-server|bun" | grep -v grep

# Test Payload CMS connectivity
curl http://140.113.208.174:3020/api/batches?limit=1

# Test analyzer connectivity
curl http://localhost:9010/schema

# Check ground-truth roadId from esmini CSV
head -5 simulation/ros/.cache/scenario_search/records/esmini_1_51.csv

# Count cached simulation records
ls simulation/ros/.cache/scenario_search/records/*.csv | wc -l

# Quick syntax check of controller.py
python3 -c "import ast; ast.parse(open('app/analyzer/src/controller.py').read()); print('OK')"

# Browse raw observations for a trial (replace <trial_id>)
curl "http://140.113.208.174:3020/api/observations?where[trial][equals]=<trial_id>&limit=3"

# Rebuild dashboard after code changes
cd app/dashboard && bun run build && bun run start
```

---

## 11. Payload CMS Admin Reference

| URL | Purpose |
|---|---|
| `http://140.113.208.174:3020/admin` | Admin UI (login required) |
| `http://140.113.208.174:3020/api` | REST API root |
| `.../api/batches` | List all batches |
| `.../api/trials?where[batch][equals]=<id>` | Trials for a batch |
| `.../api/observations?where[trial][equals]=<id>&limit=5` | Observations (raw esmini data) for a trial |
| `.../api/documents` | Stored analysis ZIP files |

**Key collections:**

| Collection | Description |
|---|---|
| `Scenarios` | Logical scenario definition (parameter ranges, `.xodr`, `.xosc`) |
| `Sessions` | Groups of related batches |
| `Batches` | One logical scenario run with a chosen sampling strategy |
| `Trials` | Individual simulation runs (one parameter sample = one trial) |
| `Observations` | Per-frame trajectory records from esmini (roadId, laneId, x, y, speed, heading) |
| `Documents` | Stored analysis artifacts (`analyze.zip`, `heatmap.zip`) |

---

## 12. Integration Plan Reference

The ongoing LLM cluster-interpretation work is tracked in:

```
/home/carlos11/Downloads/code/LAB/41_Git/cluster_interpreter_integration_plan.md
```

Phase status:

| Phase | Name | Status |
|---|---|---|
| 0 | Data audit & roadId fix | ✅ Done |
| 1 | roadId ground-truth in controller.py | ✅ Done |
| 2 | Cluster medoid selection | ✅ Done |
| 3 | BEV renderer | ✅ Done |
| 4 | Context builder (text + image captions) | 🔜 Next |
| 5 | LLM prompt → cluster interpretation YAML | 🔜 Planned |
| 6 | Dashboard integration | 🔜 Planned |

Change log: `CHANGELOG.md` (in this repo root)
