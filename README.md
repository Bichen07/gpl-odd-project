# GPL-ODD Project

A pipeline for **ODD (Operational Design Domain) testing of Autonomous Vehicles** using logical scenario search, trajectory clustering, and (in progress) LLM-based cluster interpretation.

---

## Read This First — Two Separate Workflows

This project has **two very different use cases**. Decide which one you need before starting:

| Goal | What you need to run | Difficulty |
|---|---|---|
| **A. View existing data** — explore already-collected simulation results in the dashboard | Analyzer + Dashboard only | Easy — 10 min |
| **B. Run new simulations** — collect new trajectory data by running the AV in the simulator | Everything: Sampling + Simulator (Docker + ROS) + Analyzer + Dashboard | Hard — requires ITRI Docker image |

> **If you are a new team member just getting started:** start with Goal A. The lab server already has **many simulation trials** stored (count grows over time; quick check: open `/api/trials?limit=1` and read `totalDocs` in the JSON).

### Where trials are stored (Payload CMS)

Trials are **not** files on your laptop by default. Each simulation run creates:

| Layer | Where | What |
|---|---|---|
| **Database** | PostgreSQL behind Payload CMS | All structured records |
| **`trials` collection** | One row per simulation run | Trial ID, link to batch, scenario parameters (speed, delay), pass/fail vs KPIs |
| **`observations` collection** | Many rows per trial | Per-frame trajectory: world x/y, yaw, speed, **roadId**, **laneId** — this is the raw data the Analyzer reads |

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
5. [BEV Renderer (Research Add-on)](#5-bev-renderer-research-add-on)
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

| Tool | Install |
|---|---|
| Miniconda | https://docs.anaconda.com/miniconda/ |
| Node.js 18+ | https://nodejs.org/ |
| Bun | `curl -fsSL https://bun.sh/install \| bash` |
| Docker | https://docs.docker.com/engine/install/ (only for Goal B or local Payload) |

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

#### What is `http://localhost:9010/schema`?

That URL is the **OpenAPI / Swagger** documentation page Litestar generates automatically from Python types in the analyzer code.

- **You do not need to fill in forms there** for normal use. Seeing the page means the server is up.
- The long lists (`TrajectoryAnalysisRequest`, `ClusteringScores`, `silhouetteScore`, …) are **JSON request/response shapes**, not errors.

They are defined as `@dataclass` types in `app/analyzer/src/controller.py` (around lines 1103–1198). Short glossary:

| Name | Meaning |
|---|---|
| `TrajectoryAnalysisRequest` | What the Dashboard sends when you click **Analyze**: batch IDs, frame period, list of clustering tasks (HDBSCAN parameters, etc.). |
| `TrajectoryAnalysisResponse` | Full analyzer output: trials, MFPCA scores, UMAP coords, heatmap metadata, clustering results for each task. |
| `ClusteringTask` | One clustering configuration (method string like `hdbscan+mfpca`, `minClusterSize`, `minSamples`, …). |
| `ClusteringResult` | Labels per trial + validation scores for one task. |
| `ClusteringScores` | Optional metrics: silhouette, Calinski–Harabasz, Davies–Bouldin, relative validity (may be `null` if not computed). |
| `Mfpca` | Functional PCA scores and nested clustering / UMAP projections. |

So when the schema UI shows `#0 null` / `#1 number` under nested fields, it means “this field can be null **or** a number” in the API contract — not that something is broken.

---

### Terminal 2 — Start the Dashboard

```bash
cd app/dashboard

# First time only: build the project
bun run build

# Start the website
bun run start
```

You should see:
```
✓ Ready in 359ms
- Local: http://localhost:3000
```

Open **http://localhost:3000** in your browser. This is the main dashboard.

> **If `bun run build` fails**, see [ISSUES.md](./ISSUES.md) for the fix.

---

### Navigate the Dashboard

1. Open http://localhost:3000
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

| UI section | What it does |
|---|---|
| **Saves** | Loads a previously uploaded **`analyze.zip`** (or similar) from Payload **Documents** attached to this batch. Someone must have run Analyze + Save once to create that file. |
| **Create New → Analysis** | Calls your **local** Analyzer (`localhost:9010`) with a large grid of predefined `hdbscan+mfpca` tasks (see `app/dashboard/.../Saves/index.tsx`). Can take **many minutes** — watch the analyzer terminal. |

So:

- If Session / Batch **has no ZIP under Saves**, nothing is “lost” — it usually means **nobody saved an analysis document for that batch yet**. Run **Analysis** once, then optionally use **Save** to upload a named ZIP for faster reload later.
- Session 1 showing `analysis-3.zip` simply means that batch has at least one saved document in Payload.

---

## 4. Goal B — Run New Simulations

> **Warning:** This requires the ITRI AV Docker image (`sdc-docker`) which is only available on the lab machines. You cannot do this on a regular laptop.

**Documentation:**
- **Recommended (lab PC):** [readMD/MISSION_CONTROL_USER_GUIDE.md](readMD/MISSION_CONTROL_USER_GUIDE.md) — start dev stack, Dashboard **Mission Control** tab, or API on port 8282
- **Architecture & data flow:** [readMD/MISSION_CONTROL.md](readMD/MISSION_CONTROL.md) — call graph, Payload role, `vehicle_parameters.json`, troubleshooting
- **Legacy tmux workflow (upstream / senior):** steps below + [simulation/README.md](simulation/README.md)

You need **three terminals** running at the same time for the **legacy** path. Mission Control can reduce this to `./scripts/start_dev_stack.sh` plus the `sdc-bionic` container — see the user guide.

### Terminal 1 — Sampling Server

The sampling server tells the simulator which parameter values to try next (it uses Bayesian optimisation to find collision boundaries efficiently).

```bash
conda activate sampling
cd app/sampling/src
litestar run --port 9009 --host 0.0.0.0 --debug --reload
```

You should see:
```
✓ Uvicorn running on http://0.0.0.0:9009
✓ Application startup complete.
```

Then initialize it with the batch ID you want to test (replace `2` with your batch ID):

```bash
curl -X POST http://localhost:9009/initialize \
     -H "Content-Type: application/json" \
     -d '{"batch_id": "2"}'
```

Expected response: `{"status": "initialized"}` or similar. If you get an error, check the sampling terminal for details.

> **What is the batch ID?** Each scenario on the lab server has a numeric ID. Existing batches: 1, 2, 3.
> You can also check http://140.113.208.174:3020/admin → Batches to see the IDs.

> **What is `curl`?** It is a terminal command that sends an HTTP request, like clicking a button in the browser but from the command line. You do not open a browser for this step.

---

### Terminal 2 — Analyzer Server (same as Goal A)

```bash
conda activate analyzer
cd app/analyzer/src
litestar run --port 9010 --host 0.0.0.0 --debug --reload
```

---

### Terminal 3 — Run the Simulation

The simulation runs the ITRI AV inside Docker. For the **legacy tmux / `run.sh` workflow**, update the launch file with your batch ID before starting workers:

1. Open:
   ```
   simulation/ros/src/scenario_search/launch/single_parameterized_scenario_search.launch
   ```
2. Set `batch_id` to your batch ID (e.g. `2`).
3. Set `sampling_suggestion_api` to `http://localhost:9009`.

The ROS node reads these values from **launch parameters** (`rospy.get_param`), not from Dashboard form fields. The Dashboard **Mission Control** tab can start a run with the batch you opened, but until launch parameters are passed programmatically, keep this launch file aligned with the batch you intend to simulate. See `PROJECT_STRUCTURE.md` (manual vs Mission Control).

Then start the simulator:
```bash
cd app/simulation/scripts
tmux
./run.sh 4     # 4 = number of parallel simulation workers
```

tmux navigation:
- `Ctrl-B S` → list sessions
- `Ctrl-B N` / `Ctrl-B P` → next / previous window
- `Ctrl-C` → stop a worker

Each worker automatically:
1. Asks the sampling server for a parameter set (e.g., speed=10.2, delay=6.5)
2. Runs esmini with those parameters
3. Stores the trajectory in Payload CMS
4. Reports the outcome (collision/no collision) back to the sampling server

Stop the simulation cleanly:
```bash
# Ctrl-C in tmux, then clean up logs
rm -rf simulation/ros/.cache/scenario_search
```

---

### After Simulating — View Results

Start the dashboard (Goal A steps) and navigate to your batch. Click **Analyze** to run clustering on the new trials.

---

## 5. BEV Renderer (Research Add-on)

Generates top-down Bird's Eye View images of the most representative trial per cluster. Used as visual input for LLM-based scenario interpretation (future work).

```bash
conda activate analyzer
cd /path/to/gpl-odd-project   # repository root

bash scripts/run_bev.sh <dataset_name> <n_clusters>
# Example:
bash scripts/run_bev.sh dataset1 3
```

Required input files (place under `alldatasets/<dataset_name>/`):
```
alldatasets/dataset1/
├── trajectories.json
├── selectedClusteringResult_3Clusters.json
└── resources/xodr/hct_6.xodr
```

Output images go to `bev_output/<dataset_name>/<n>clusters/cluster_N/trial_XXXX_frame_NNN.jpg`.

> `alldatasets/` is in `.gitignore` — these are large data files not tracked by git.

---

## 6. Unit Tests

```bash
conda activate analyzer
cd /path/to/gpl-odd-project   # repository root

python3 tests/test_roadid_preservation.py    # 7 tests — roadId bug fix
python3 tests/test_cluster_medoid.py         # 9 tests — medoid selection
python3 tests/test_bev_renderer.py           # 14 tests — BEV renderer
```

All 30 tests should end with `OK`.

---

## 7. Branch & Git Strategy

```
Bichen07/gpl-odd-project (your fork)
  └── carlos1                    ← clean base
        └── feature/cluster-medoid  ← current work (Phases 1–3)
```

```bash
git branch                        # see current branch
git push carlos feature/cluster-medoid   # push to YOUR fork only

git remote -v
# carlos  https://github.com/Bichen07/gpl-odd-project.git  ← your fork
# origin  https://github.com/ian-chiu/gpl-odd-project.git  ← senior's repo (never push here)
```

---

## 8. Debugging

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

2. **Same Payload as the dashboard** — Analyzer loads `app/analyzer/.env` (`PAYLOAD_API`, `PAYLOAD_API_KEY`). Dashboard uses `app/dashboard/.env` (`NEXT_PUBLIC_PAYLOAD_API_*`). Both must point at the **same** Payload server (lab IP vs `localhost:3020`). If the analyzer talks to an empty local DB while the dashboard shows lab batches, clustering will fail or return nothing useful.

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

## 9. Payload CMS Reference

| URL | What it is |
|---|---|
| http://140.113.208.174:3020/admin | Admin UI — log in to browse and edit all data |
| http://140.113.208.174:3020/api | REST API root |
| http://140.113.208.174:3020/api/batches | List all batches (JSON) |
| http://140.113.208.174:3020/api/trials?limit=5 | First 5 trials |

**Key data collections:**

| Collection | What it stores |
|---|---|
| Scenarios | Scenario definitions (parameter ranges, `.xodr` map, `.xosc` script) |
| Sessions | Groups of related batches |
| Batches | One scenario with a sampling strategy — this is the unit you analyze |
| Trials | One simulation run (one parameter sample) |
| Observations | Per-frame trajectory data: x, y, heading, speed, roadId, laneId |
| Documents | Saved analysis results (`analyze.zip`) |

**Credentials:** Ask your supervisor. The API key in `app/dashboard/.env` is already configured for read access.

---

## 10. Documentation layout

Keep **both**:

| Doc | Role |
|---|---|
| **`README.md`** (this file) | End-to-end workflow: Payload → Analyzer → Dashboard → optional simulation. Written for someone setting up from scratch. |
| **`app/*/README.md`** | Deep detail per service (conda env file paths, Payload sampling configuration, dashboard submodule build). |

Do not delete the per-app READMEs — they complement this root overview.

---

## 11. Mission Control

**Status:** Implemented — Mission Control API (port 8282) + Dashboard **Mission Control** tab on batch Explore dock.

**What it does:**
- Starts simulation runs from the Dashboard or `POST /simulation/run`
- Orchestrates per-trial `roslaunch` inside `sdc-bionic` via `app/simulation/src/orchestrator.py`
- Shows real-time progress (WebSocket), health chips, and data-quality summary
- Validates CSV output after each trial

**Docs:**
| Doc | Use when |
|-----|----------|
| [readMD/MISSION_CONTROL_USER_GUIDE.md](readMD/MISSION_CONTROL_USER_GUIDE.md) | You want step-by-step commands (ports, SSH, container) |
| [readMD/MISSION_CONTROL.md](readMD/MISSION_CONTROL.md) | You need architecture, file call graph, Payload/simulation data flow |

**Legacy alternative:** README §4 Goal B tmux `run.sh` (same ROS stack, no Mission Control API).

**Research integration:** See `cluster_interpreter_integration_plan.md` (Track B) for post-simulation clustering / BEV automation.

---

## Related Files

| File | Purpose |
|---|---|
| `HOW_TO_RUN.md` | Short quick-reference for commands |
| `CHANGELOG.md` | Record of code changes |
| `ISSUES.md` | **Unresolved** problems and directions to verify (not a changelog of fixes) |
| `cluster_interpreter_integration_plan.md` | Research integration plan (may live next to the repo clone in your LAB folder) |
| `readMD/MISSION_CONTROL.md` | Simulation pipeline reference (call graph, Payload, vehicle_parameters, how to run) |
| `readMD/MISSION_CONTROL_USER_GUIDE.md` | Operator runbook for Mission Control on the lab PC |
| `app/analyzer/README.md` | Analyzer-specific setup details |
| `app/sampling/README.md` | Sampling server API reference |
| `app/dashboard/README.md` | Dashboard build steps |
| `app/payload/README.md` | Payload CMS local setup |
