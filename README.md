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
| Bun         | `curl -fsSL https://bun.sh/install | bash`                                                                            |
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


|                    | Development (`bun run dev`)     | Production (`bun run build` + `bun run start`)          |
| ------------------ | ------------------------------- | ------------------------------------------------------- |
| **When to use**    | Daily lab work, editing UI code | Deploy-like run, no hot reload                          |
| **Needs `build`?** | No — compiles on the fly        | Yes — `bun run start` reads `.next/` from a prior build |
| **Command**        | `bun run dev`                   | `bun run build` then `bun run start`                    |
| **Hot reload**     | Yes                             | No                                                      |


**Why `localhost:3000` sometimes opens without you running anything:** `./scripts/start_dev_stack.sh` (or an old `bun run dev`) may already be listening on 3000. Check with `ss -tlnp \| grep 3000`. If something is there, use that URL or stop the old process before starting again.

**Why `bun run start` fails with “Could not find a production build”:** `start` is production mode. Run `bun run build` first (once per code change), or switch to dev mode below.

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

> **If `bun run build` fails**, see [ISSUES.md](./ISSUES.md) for the fix.

> **Port already in use (`EADDRINUSE`):** Another Dashboard is already running. Use the existing tab, or stop it (`kill $(lsof -ti :3000)` or close the terminal running `dev`/`start`), then start again.

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

## 4. Goal B — Run New Simulations

> **Warning:** This requires the ITRI AV Docker image (`sdc-docker`) which is only available on the lab machines. You cannot do this on a regular laptop.

**Documentation:**

- **Recommended (lab PC):** [readMD/MISSION_CONTROL_USER_GUIDE.md](readMD/MISSION_CONTROL_USER_GUIDE.md) — start dev stack, Dashboard **Mission Control** tab, or API on port 8282
- **Architecture & data flow:** [readMD/MISSION_CONTROL.md](readMD/MISSION_CONTROL.md) — call graph, Payload role, `vehicle_parameters.json`, troubleshooting
- **Legacy tmux workflow (upstream / senior):** steps below + [simulation/README.md](simulation/README.md)

You need **two terminals** running at the same time for the **legacy simulation** path (Sampling + Docker workers). The **Analyzer** is **not** required while simulating — start it **after** trials finish, when you open the Dashboard to cluster results (`[OriREADME.md](./OriREADME.md)` §View and Explore Simulation Result). Mission Control can reduce the dev stack to `./scripts/start_dev_stack.sh` plus the `sdc-bionic` container — see the user guide.

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

Expected response: HTTP **201** with body `{"message": "ok"}`. That means the batch is loaded and Sampling is ready. HTTP **400** means something failed (wrong JSON, or you called `/suggest` or `/register` before `/initialize`) — see **Sampling Swagger (`:9009/schema`)** below.

> **Same batch ID in Terminal 2:** This `batch_id` must match the `batch_id` arg in `[single_parameterized_scenario_search.launch](./simulation/ros/src/scenario_search/launch/single_parameterized_scenario_search.launch)`. Sampling and the simulator are separate processes — see Terminal 2 below.

#### Sampling Swagger (`:9009/schema`) — which endpoints you touch

Open `http://localhost:9009/schema` (or lab IP). Three endpoints are listed:


| Endpoint                      | Who calls it                                           | What you set                                                                        |
| ----------------------------- | ------------------------------------------------------ | ----------------------------------------------------------------------------------- |
| `**POST /initialize`**        | **You** (once per batch, or again after Payload edits) | JSON body: `{"batch_id": "1"}` — **only field required**                            |
| `**GET /suggest/{batch_id}`** | **Simulator** (SPSS), each trial                       | Nothing manual — `batch_id` is in the URL path; must match initialize + launch file |
| `**POST /register`**          | **Simulator** (SPSS), after each trial                 | Nothing manual — body includes `batch_id`, `trial_index`, `outcome`, …              |


So for **your** setup: you only type the batch ID in `**/initialize`**. The launch file sets the same batch for ROS. `/suggest` and `/register` run automatically inside the simulation loop.

**HTTP codes in Swagger**


| Code                                                       | Meaning                                                                                                                        |
| ---------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| **201** + `{"message": "ok"}` on `/initialize`             | Success — batch loaded from Payload                                                                                            |
| **200** + `{"trial_index":…,"parameters":…}` on `/suggest` | Success — next parameter set                                                                                                   |
| **400**                                                    | Error — e.g. *"Should initialize first!"* if you hit `/suggest/1` or `/register` before `/initialize`, or invalid request body |


Swagger also lists generic 201/400 **schema examples** (`additionalProp1`, etc.) — those are OpenAPI placeholders, not what your server actually returns on success.

> **What is the batch ID?** Each scenario on the lab server has a numeric ID. Existing batches: 1, 2, 3.
> You can also check [http://140.113.208.174:3020/admin](http://140.113.208.174:3020/admin) → Batches to see the IDs.

> **What is `curl`?** It is a terminal command that sends an HTTP request, like clicking a button in the browser but from the command line. You do not open a browser for this step.

---

### Terminal 2 — Run the Simulation

The simulation runs the ITRI AV inside Docker. Follow senior’s legacy flow (`[OriREADME.md](./OriREADME.md)`): start Sampling first, **initialize the same batch ID**, then start workers.

#### Why set batch ID in **two** places?


| Where                                                                                                                                                                        | What it does                                                                                                                              |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| **Sampling `:9009`** — `POST /initialize` with `{"batch_id":"2"}`                                                                                                            | Loads that batch’s scenario + parameter bounds from Payload into the optimizer. Enables `/suggest/2` and `/register`.                     |
| **Launch file** — `batch_id` arg in `[single_parameterized_scenario_search.launch](./simulation/ros/src/scenario_search/launch/single_parameterized_scenario_search.launch)` | Tells the ROS simulation node which Payload batch to load (`.xosc`, map, KPIs) and which `esmini_<batch>_<index>.csv` filenames to write. |


They must be the **same ID**. Sampling does not auto-sync from the launch file — you initialize Sampling manually (Swagger or `curl`), then workers read `batch_id` from the launch file.

```text
You: POST /initialize {"batch_id":"2"}  →  Sampling ready for batch 2
Launch: batch_id=2                         →  SPSS loads batch 2 from Payload
SPSS loop: GET /suggest/2  →  run trial  →  POST /register  →  esmini_2_<i>.csv
```

If Sampling is initialized for batch `3` but launch says `batch_id=2`, `/suggest/2` may fail (not initialized) or workers write `esmini_2_*` while the optimizer tracks batch `3`.

#### Step-by-step: run, watch, and check (MobaXterm / SSH)

**Yes — use MobaXterm** to SSH into the lab PC and run all commands. That is the normal workflow.

**Which tool shows what:**

| Tool | Run simulation? | See esmini / 3D window? | Notes |
|------|-----------------|-------------------------|--------|
| **MobaXterm SSH** (from your laptop) | ✅ Steps 0–9 | ✅ **Path B** — if X11 forwarding + `DISPLAY` set | Best for **GUI** (what you remember) |
| **MobaXterm SSH** | ✅ | ❌ **Path A** headless | Best for **batch runs** — use tmux text + CSV |
| **Cursor / IDE terminal** on lab PC | ✅ Path A only | ❌ `DISPLAY` usually empty | Your `xterm` error — use MobaXterm for GUI |
| **Dashboard** (`localhost:3000`) | ❌ | ❌ | Results only after trials finish |

**Default `run.sh` = headless (Path A)** — no simulation window anywhere. To see the screen in MobaXterm, use **Path B** (disable headless + X11).

**Prerequisites:** `docker ps` shows `sdc-bionic` Up; repo at `~/Downloads/code/LAB/gpl-odd-project`.

**Paste tip (MobaXterm):** `^[[200~` / `: command not found` = bad paste. Type commands by hand.

##### What your status check means (example)

```bash
tmux ls          → no server running     # simulation STOPPED (not started or rebooted)
ss | grep 1131   → (none)              # no ROS workers
processes        → 0                    # nothing running
sampling         → trial_index 552      # Sampling OK (but sim not running!)
latest CSV       → Jan 15 dates         # no new trials for weeks — STUCK or never completed
echo $DISPLAY    → (empty)              # GUI impossible in THIS terminal — use MobaXterm X11 or Path A
```

| Reading | Meaning |
|---------|---------|
| tmux `no sessions` + ports `(none)` + processes `0` | **Stopped** — run Steps 5A–6A to start |
| tmux + ports `11311` + processes `> 0` | **Running** — attach tmux to watch |
| Running + CSV dates old | **Stuck** on ego routing — see log table below |
| `DISPLAY` empty | **Path B GUI will not work** in this terminal — use Path A or open **new MobaXterm SSH tab** with X11 |

---

**Step 0 — SSH and repo**

```bash
cd ~/Downloads/code/LAB/gpl-odd-project
```

**Step 1 — Sampling** (leave this terminal open)

```bash
conda activate sampling
cd app/sampling/src
litestar run --port 9009 --host 0.0.0.0 --debug --reload
```

**Step 2 — Initialize batch** (second SSH tab; replace `1` with your batch ID)

```bash
curl -X POST http://localhost:9009/initialize \
     -H "Content-Type: application/json" \
     -d '{"batch_id": "1"}'
```

Expect `{"message":"ok"}`. Same ID must be in the launch file (Step 3).

**Step 3 — Launch file** — edit [`single_parameterized_scenario_search.launch`](simulation/ros/src/scenario_search/launch/single_parameterized_scenario_search.launch):

- `batch_id` = Step 2 (e.g. `1`)
- `ego_position_seq` — Case 1=`21`, Case 2=`4`, Case 3=`29`
- `sampling_suggestion_api` = `http://localhost:9009`

**Step 4 — Clean stop** (always before a fresh start)

```bash
tmux kill-session -t scenario_search 2>/dev/null
tmux kill-session -t my_work 2>/dev/null
pkill -f 'rosmaster --core' || true
pkill -f 'roslaunch.*scenario_search' || true
pkill -f 'roslaunch.*sdc' || true
pkill -f single_parameterized_scenario_search || true
sleep 2
ss -tlnp | grep 1131          # must print NOTHING
ps aux | grep -E 'roslaunch|rosmaster|single_parameterized' | grep -v grep | wc -l
# must print 0
```

---

##### Path A — Headless (recommended for batch runs)

No 3D window. Watch **tmux** text and **CSV** files. Works from any SSH terminal (MobaXterm or Cursor).

**Step 5A — Start workers**

```bash
cd ~/Downloads/code/LAB/gpl-odd-project/app/simulation/scripts
tmux new -s my_work
./run.sh 1
```

Use `1` worker first; scale to `3` only after CSV files update. Detach: `Ctrl-B` then `D`.

**Step 6A — Watch text output (no GUI window)**

```bash
tmux ls                    # expect my_work + scenario_search
tmux attach -t scenario_search
```

| Keys | Action |
|------|--------|
| `Ctrl-B` then `N` / `P` | Next / prev window (`scenario_search_0`, `sdc_0`, …) |
| `Ctrl-B` then `D` | Detach (workers keep running) |

| Log line | Meaning |
|----------|---------|
| `Got global path. Initialization done.` | Healthy |
| `ego wait for waypoint` (repeating) | **Stuck** — no new CSV |
| `port 11313 is already in use` | Crashed — redo Step 4 |

---

##### Path B — See simulation screen in MobaXterm (GUI)

Use this when you want the **esmini / RViz window on your laptop** (what you did before). Requires **MobaXterm SSH from Windows**, not Cursor’s built-in terminal.

**B1 — MobaXterm session settings**

1. New Session → **SSH** → lab PC IP / user `carlos11`.
2. **Network** → check **X11-Forwarding** (MobaXterm embeds an X server — this is why GUI works here).
3. Connect. In the MobaXterm tab, verify:
   ```bash
   echo $DISPLAY
   # expect something like localhost:10.0  (NOT empty)
   ```

**B2 — Allow Docker to draw on your display**

```bash
xhost +local:docker 2>/dev/null || true
docker exec -e DISPLAY=$DISPLAY sdc-bionic bash -c 'echo DISPLAY=$DISPLAY'
# must print DISPLAY=localhost:10.0 (or similar), NOT empty
```

**B3 — Disable headless** (one-time edit)

In [`deploy/parallel/container_script`](deploy/parallel/container_script) line 17–18, use `--scenario_search` instead of `--scenario_search_headless`.

In [`app/simulation/scripts/run.sh`](app/simulation/scripts/run.sh) line 27, pass display into Docker (add `-e DISPLAY=$DISPLAY`):

```bash
docker exec -e DISPLAY=$DISPLAY -it ${CONTAINER_NAME} /bin/bash -c '...'
```

Do the same for the `sdc` window on line 29 if you want RViz there too.

**B4 — Run** (same as Path A)

Steps 0–4, then Step 5A `./run.sh 1` **from the MobaXterm tab where `DISPLAY` is set**.

Esmini/RViz windows should pop up on **your Windows desktop** (MobaXterm X server). Worker logs are still in `tmux attach -t scenario_search`.

**B5 — If GUI still does not appear**

| Check | Fix |
|-------|-----|
| `echo $DISPLAY` empty | Wrong terminal — open **MobaXterm SSH**, not Cursor IDE |
| `xterm: DISPLAY is not set` | Same — xterm/GUI need X11; headless Path A does not |
| Container `DISPLAY=` empty | Start `run.sh` from the SSH tab that has `DISPLAY`; add `-e DISPLAY=$DISPLAY` to `docker exec` in `run.sh` |
| Window flashes then closes | Trial may still be **stuck** on routing — GUI does not fix `ego wait for waypoint` |

`xterm &` is **optional** — only an extra text window. MobaXterm already shows simulation graphics via X11 when Path B is configured.

If GUI is too slow or broken, use **Path A** (headless) — batch production does not need a window.

---

**Step 7 — Check status** (any SSH tab, from repo root)

```bash
cd ~/Downloads/code/LAB/gpl-odd-project
BATCH=1
echo "=== tmux ===" && tmux ls 2>&1
echo "=== ROS ports ===" && (ss -tlnp | grep 1131 || echo "(none)")
echo "=== processes ===" && ps aux | grep -E 'roslaunch|rosmaster|single_parameterized' | grep -v grep | wc -l
echo "=== sampling ===" && curl -s http://localhost:9009/suggest/$BATCH | head -c 120; echo
echo "=== latest CSV ===" && ls -lt simulation/ros/.cache/scenario_search/records/esmini_${BATCH}_*.csv 2>/dev/null | head -3 || echo "(no new csv)"
```

**Success:** newest `esmini_<batch>_*.csv` has **today’s date** and keeps updating.  
**Stuck (your current symptom):** configs/`scenario_*.xosc` update but CSV dates stay old (e.g. Jan 15) → ego routing stall.

ROS ports: worker `0`→`11311`, `1`→`11312`, `2`→`11313` (`grep 1131` matches all).

**Step 8 — If stuck, read logs**

```bash
docker exec sdc-bionic bash -c '
  LOG=$(ls -t /home/user/.ros/log/*/single_parameterized_scenario_search*.log 2>/dev/null | head -1)
  echo "=== $LOG ===" && tail -40 "$LOG"
'
docker exec sdc-bionic bash -c '
  grep -h -E "ERROR|RLException|already in use|wait for waypoint|Got global path" \
    /home/user/.ros/log/*/single_parameterized_scenario_search*.log 2>/dev/null | tail -20
'
```

**Step 9 — Stop when done**

```bash
tmux attach -t my_work    # Ctrl-C stops ./run.sh
tmux kill-session -t scenario_search
# repeat Step 4 pkill block; verify ss | grep 1131 is empty
```

> **Dashboard** (`localhost:3000/batch/1`) shows Payload config and old trials — **not** live tmux. Parameter axes updating ≠ new simulation output.

Each worker automatically:

1. Asks the sampling server for a parameter set (e.g., speed=10.2, delay=6.5)
2. Runs esmini with those parameters
3. Stores the trajectory in Payload CMS
4. Reports the outcome (collision/no collision) back to the sampling server

#### Why simulation gets stuck (no new `esmini_*.csv`)

```text
Sampling /suggest  →  scenario JSON + .xosc written   ✅ (often works)
       ↓
Ego: wait for /global_path or /waypoints            ❌ common stall
       ↓
esmini_<batch>_<i>.dat / .csv                       never created
```

**Checklist:** launch `batch_id` = initialize batch; correct `ego_position_seq`; Step 4 clean stop; `./run.sh 1` until `Got global path`.

#### Stop simulation cleanly

Do all steps so the next `./run.sh` does not hit `Address already in use` on ports 11311–11314.

**1. Stop the monitor** (in `my_work`, or wherever `./run.sh` runs):

```bash
tmux attach -t my_work
# Ctrl-C to stop ./run.sh
```

**2. Stop worker tmux session:**

```bash
tmux kill-session -t scenario_search
```

**3. Kill stale ROS on the host** (required — `docker exec pkill` alone often **does not** free ports):

```bash
pkill -f 'rosmaster --core' || true
pkill -f 'roslaunch.*scenario_search' || true
pkill -f 'roslaunch.*sdc' || true
pkill -f single_parameterized_scenario_search || true
sleep 2
```

**4. Verify stop succeeded** (run before the next `./run.sh`):

```bash
# All three must pass:
ss -tlnp | grep 1131
# → must print NOTHING (if lines appear, ports still in use — stop not complete)

ps aux | grep -E 'roslaunch|rosmaster|single_parameterized' | grep -v grep
# → must print NOTHING (any line = background sim still running)

ps aux | grep -E 'roslaunch|rosmaster|single_parameterized' | grep -v grep | wc -l
# → must print 0
```

If `ss` still shows `rosmaster` on 11311–11314, force-kill by PID:

```bash
ss -tlnp | grep 1131    # note pid=NNNNNN in each line
kill NNNNNN NNNNNN      # one PID per port still listening
sleep 1
ss -tlnp | grep 1131    # confirm empty again
```

Optional — confirm tmux workers are gone:

```bash
tmux ls    # scenario_search may be absent after kill-session; my_work may remain until you Ctrl-C run.sh
```

**Stop is successful when:** `grep 1131` is empty **and** sim process count is **0**. Only then start `./run.sh` again.

**5. Optional — trim ROS logs** (>1GB slows startup; inside container with ROS sourced):

```bash
docker exec sdc-bionic bash -c 'source /opt/ros/melodic/setup.bash && rosclean purge -y'
# or: docker exec sdc-bionic rm -rf /home/user/.ros/log/*
```

**Do not** run `rm -rf simulation/ros/.cache/scenario_search` as a normal stop step — that **deletes all** `esmini_<batch>_*.csv` trial data. Only remove cache when you intentionally want to free disk space (`[OriREADME.md](./OriREADME.md)` §Closing the Simulation).

#### Clean restart after a failed run

```bash
# 1–3 above (stop + verify ss | grep 1131 is empty)
curl -X POST http://localhost:9009/initialize \
     -H "Content-Type: application/json" \
     -d '{"batch_id": "1"}'    # re-run after Payload edits

cd app/simulation/scripts
tmux new -s my_work
./run.sh 1    # start with 1 worker; use 3–4 only after esmini_<batch>_*.csv updates
# Ctrl-B D to detach
```

---

### After Simulating — View and Analyze Results

When simulation is done (or you have enough new `esmini_<batch>_*.csv` files), follow `[OriREADME.md](./OriREADME.md)` §View and Explore Simulation Result:

**1. Dashboard** (if not already running — Goal A):

```bash
cd app/dashboard
bun run dev    # or bun run start per your setup
```

Open the batch in the UI (e.g. `http://localhost:3000/batch/1`).

**2. Analyzer** (needed for **Create New → Analyze** in the Dashboard):

```bash
conda activate analyzer
cd app/analyzer/src
litestar run --port 9010 --host 0.0.0.0 --debug --reload
```

**3. Run clustering:** In the batch **Explore** tab → **Saves** → **Create New** → **Analyze**. The Dashboard calls Analyzer on `:9010`; processing can take many minutes.

Optional: **Save** uploads an `analyze.zip` to Payload for faster reload later.

---

## 5. BEV & LLM Pipeline (Research)

Research tooling for bird's-eye views and LLM-based cluster interpretation. Code layout:


| Path                                    | Role                                                                                  |
| --------------------------------------- | ------------------------------------------------------------------------------------- |
| `app/analyzer/src/`                     | Senior clustering stack + BEV (`map_plotter`, `renderer`, `dataset_builder`, …)       |
| `app/llm_pipeline/python/llm_pipeline/` | LLM package: stages 1–5 CLI, `cluster_interpreter`, `cluster_interpretation_pipeline` |
| `app/llm_pipeline/prompt_templates/`    | Prompt files for cluster interpretation                                               |
| `app/llm_pipeline/artifacts/`           | Captured stage outputs                                                                |


Set `PYTHONPATH` once per shell (from the **repository root**):

```bash
conda activate analyzer
cd /path/to/gpl-odd-project

export PYTHONPATH="app/llm_pipeline/python:app/analyzer/src"
```

Scripts such as `scripts/build_llm_dataset.sh` and `scripts/run_cluster_analyze.sh` set this automatically.

### BEV renderer

Generates top-down Bird's Eye View images of the most representative trial per cluster. Used as visual input for LLM cluster interpretation.

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

### LLM pipeline — cluster interpretation

After BEV snapshots and cluster stats exist under `results/<dataset>/<k>/` or `llm_artifacts/<run_id>/`:

**Build dataset artifacts (Phase 4):**

```bash
# Legacy mode — reads exported clustering files from alldatasets/<dataset>/
bash scripts/build_llm_dataset.sh dataset1 3
# Optional run id and trial override:
# bash scripts/build_llm_dataset.sh dataset1 3 my_run_001 --trials "1:100,1:200"

# Payload-save mode — reads a saved Dashboard analysis straight from Payload,
# no alldatasets/ export needed. --dataset is optional (resolved from --batch-id).
bash scripts/build_llm_dataset.sh --source payload-save --batch-id 1 --k 4
#   --save-doc-id <id>       pick a specific saved analysis (default: latest)
#   --clustering-index <n>   pick exact result instead of best-silhouette --k
#   --dataset <name>         override the batch→dataset resolution
```

> One-time map assets per dataset (only if `alldatasets/resources/xodr/` is empty):
> ```bash
> python3 scripts/generate_map_tracks.py --dataset dataset1
> cp simulation/ros/.cache/scenario_search/hct_6.xodr alldatasets/resources/xodr/hct_6.xodr
> python3 scripts/map_preprocess.py --dataset dataset1
> ```
> Without them the build still runs but logs `BEV skipped`.

**Step 5 — offline interpretation on `results/<dataset>/<k>/`:**

```bash
python3 -m llm_pipeline.cluster_interpretation_pipeline \
  --dataset dataset1 --n-clusters 3 --dry-run
```

Remove `--dry-run` and set `GOOGLE_API_KEY` (Gemini, default) or `OPENAI_API_KEY` (gpt-*) for live LLM output.

**Cluster-interpret CLI — interpret a builder results folder:**

```bash
python3 -m llm_pipeline.cli cluster-interpret \
  --results-dir results/batch2/4_cluster_s=0.6945 --batch-id 2
# Stub only (no API call):
python3 -m llm_pipeline.cli cluster-interpret \
  --results-dir results/batch2/4_cluster_s=0.6945 --batch-id 2 --dry-run
```

Or use the wrapper script (this is what the Dashboard "Select and analyze" page calls):

```bash
bash scripts/run_cluster_analyze.sh --results-dir results/batch2/4_cluster_s=0.6945 --batch-id 2
```

**Optional — run interpretation automatically after Dashboard Analyze:**

```bash
export GPL_ODD_CLUSTER_INTERPRETATION=1
# optional: export GPL_ODD_DATASET=dataset1
# optional: export GPL_ODD_CLUSTER_INTERPRET_DRY_RUN=1
```

Then restart the Analyzer (`litestar run …`) and click **Analyze** in the Dashboard.

More detail: `app/llm_pipeline/README.md` and `cluster_interpreter_integration_plan.md`.

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

### Senior repo (`ian-chiu/gpl-odd-project`) — three branches


| Branch       | Role                                                                                       | Tip (fetched) |
| ------------ | ------------------------------------------------------------------------------------------ | ------------- |
| `**dev**`    | **Default** (`upstream/HEAD` → `dev`). Active integration line; merged `update` via PR #3. | `9019911`     |
| `**main`**   | Older stable / release line                                                                | `ed1691f`     |
| `**update**` | Senior WIP feature branch (content largely merged into `dev`)                              | `6e3a1de`     |


**Which branch do we build from?** Lab fork work is on **`main`** (`origin/main`, default on `Bichen07/gpl-odd-project`). It contains the integrated lab-specific work (analyzer, Mission Control, LLM pipeline, cluster interpretation, etc.). Senior upstream default is `**dev**` on `ian-chiu/gpl-odd-project`.

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

## 9. Payload CMS Reference


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

## 10. Documentation layout

Keep **both**:


| Doc                         | Role                                                                                                                    |
| --------------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| `**README.md`** (this file) | End-to-end workflow: Payload → Analyzer → Dashboard → optional simulation. Written for someone setting up from scratch. |
| `**app/*/README.md**`       | Deep detail per service (conda env file paths, Payload sampling configuration, dashboard submodule build).              |


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


| Doc                                                                          | Use when                                                             |
| ---------------------------------------------------------------------------- | -------------------------------------------------------------------- |
| [readMD/MISSION_CONTROL_USER_GUIDE.md](readMD/MISSION_CONTROL_USER_GUIDE.md) | You want step-by-step commands (ports, SSH, container)               |
| [readMD/MISSION_CONTROL.md](readMD/MISSION_CONTROL.md)                       | You need architecture, file call graph, Payload/simulation data flow |


**Legacy alternative:** README §4 Goal B tmux `run.sh` (same ROS stack, no Mission Control API).

**Research integration:** See `cluster_interpreter_integration_plan.md` (Track B) for post-simulation clustering / BEV automation.

---

## Related Files


| File                                      | Purpose                                                                             |
| ----------------------------------------- | ----------------------------------------------------------------------------------- |
| `HOW_TO_RUN.md`                           | Short quick-reference for commands                                                  |
| `CHANGELOG.md`                            | Record of code changes                                                              |
| `ISSUES.md`                               | **Unresolved** problems and directions to verify (not a changelog of fixes)         |
| `cluster_interpreter_integration_plan.md` | Research integration plan (may live next to the repo clone in your LAB folder)      |
| `readMD/MISSION_CONTROL.md`               | Simulation pipeline reference (call graph, Payload, vehicle_parameters, how to run) |
| `readMD/MISSION_CONTROL_USER_GUIDE.md`    | Operator runbook for Mission Control on the lab PC                                  |
| `app/analyzer/README.md`                  | Analyzer-specific setup details                                                     |
| `app/llm_pipeline/README.md`              | LLM pipeline stages, CLI, cluster interpretation                                    |
| `app/sampling/README.md`                  | Sampling server API reference                                                       |
| `app/dashboard/README.md`                 | Dashboard build steps                                                               |
| `app/payload/README.md`                   | Payload CMS local setup                                                             |


