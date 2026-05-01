# GPL-ODD Project

A pipeline for **ODD (Operational Design Domain) testing of Autonomous Vehicles** using logical scenario search, trajectory clustering, and (in progress) LLM-based cluster interpretation.

---

## Read This First — Two Separate Workflows

This project has **two very different use cases**. Decide which one you need before starting:

| Goal | What you need to run | Difficulty |
|---|---|---|
| **A. View existing data** — explore already-collected simulation results in the dashboard | Analyzer + Dashboard only | Easy — 10 min |
| **B. Run new simulations** — collect new trajectory data by running the AV in the simulator | Everything: Sampling + Simulator (Docker + ROS) + Analyzer + Dashboard | Hard — requires ITRI Docker image |

> **If you are a new team member just getting started:** start with Goal A. The lab server already has **1178 simulation trials** stored and ready to explore.

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

```bash
conda activate analyzer
cd /home/carlos11/Downloads/code/LAB/41_Git/gpl-odd-project/app/analyzer/src
litestar run --port 9010 --host 0.0.0.0 --debug --reload
```

You should see:
```
✓ Uvicorn running on http://0.0.0.0:9010
✓ Application startup complete.
```

**Verify it works** — open this URL in your browser:
```
http://localhost:9010/schema
```
You will see a page titled "Litestar" with a list of API endpoints. That page is for developers to test the API — you do not need to use it manually. If you can see it, the server is working.

---

### Terminal 2 — Start the Dashboard

```bash
cd /home/carlos11/Downloads/code/LAB/41_Git/gpl-odd-project/app/dashboard

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
3. Click a session (1, 2, or 3) → then click the batch inside it
4. You will see the batch page with several views:
   - **Scenario Parameter Space** — a scatter plot of all trials coloured by collision outcome
   - **Trajectory Projection Space** — UMAP view of trajectory clusters
   - **Replayer** — click any trial to animate the Ego vehicle
   - **Trajectory Heatmap** — density map of all trajectories overlaid on the road

5. To run the clustering analysis on a batch:
   - Click the **Save** tab in the batch page
   - Click **Create New** → then click **Analyze**
   - Wait a few minutes — progress appears in the analyzer terminal
   - When done, the result appears in the batch's Documents tab

---

## 4. Goal B — Run New Simulations

> **Warning:** This requires the ITRI AV Docker image (`sdc-docker`) which is only available on the lab machines. You cannot do this on a regular laptop.

You need **three terminals** running at the same time.

### Terminal 1 — Sampling Server

The sampling server tells the simulator which parameter values to try next (it uses Bayesian optimisation to find collision boundaries efficiently).

```bash
conda activate sampling
cd /home/carlos11/Downloads/code/LAB/41_Git/gpl-odd-project/app/sampling/src
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
cd /home/carlos11/Downloads/code/LAB/41_Git/gpl-odd-project/app/analyzer/src
litestar run --port 9010 --host 0.0.0.0 --debug --reload
```

---

### Terminal 3 — Run the Simulation

The simulation runs the ITRI AV inside Docker. Before running, update the launch file with your batch ID:

1. Open:
   ```
   simulation/ros/scenario_search/launch/single_parameterized_scenario_search.launch
   ```
2. Set `batch_id` to your batch ID (e.g. `2`).
3. Set `sampling_suggestion_api` to `http://localhost:9009`.

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
cd /home/carlos11/Downloads/code/LAB/41_Git/gpl-odd-project

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
cd /home/carlos11/Downloads/code/LAB/41_Git/gpl-odd-project

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

## Related Files

| File | Purpose |
|---|---|
| `HOW_TO_RUN.md` | Short quick-reference for commands |
| `CHANGELOG.md` | Record of code changes |
| `ISSUES.md` | Known problems and open questions |
| `../cluster_interpreter_integration_plan.md` | Full LLM integration research plan (Phases 0–6) |
| `app/analyzer/README.md` | Analyzer-specific setup details |
| `app/sampling/README.md` | Sampling server API reference |
| `app/dashboard/README.md` | Dashboard build steps |
| `app/payload/README.md` | Payload CMS local setup |
