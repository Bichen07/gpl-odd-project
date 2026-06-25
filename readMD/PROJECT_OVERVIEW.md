# GPL-ODD Project Structure

This document explains how the repository is organized, which folders matter for daily work, and which folders you can ignore unless you are debugging a build.

If you are lost inside `simulation/ros/`, start with the mental model below, then use the folder map.

---

## Mental model (one pipeline)

The project is not one program. It is several services plus a Docker simulation stack that share **Payload CMS** as the database.

```text
OpenSCENARIO / OpenDRIVE assets
        |
        v
Payload CMS (sessions, batches, scenarios, trials, observations)
        ^
        | REST / GraphQL
        |
Sampling (port 9009)  <---->  ROS + esmini in sdc-bionic container
        |                           |
        |                           +-- CSV cache under simulation/ros/.cache/
        |
Analyzer (port 9010)  ---- reads trials from Payload, writes analysis artifacts
        |
Dashboard (port 3000) ---- visualizes batches, clustering, Mission Control UI
        |
Mission Control API (port 8282) ---- orchestrates sampling + Docker/ROS (Track B)
```

**Rule of thumb:** Payload stores metadata and results. ROS/esmini runs physics. Sampling chooses parameters. Analyzer and Dashboard read back what was stored.

---

## Top-level folders (what each one is for)

| Path | Role | Do you edit this often? |
|------|------|-------------------------|
| `app/payload` | CMS + PostgreSQL API (`/admin`, `/api`) | Rarely (schema, uploads) |
| `app/sampling` | Bayesian parameter suggestion API | Rarely |
| `app/analyzer` | Clustering, heatmaps, BEV, CSV loaders | Sometimes (research) |
| `app/dashboard` | Research web UI (scatter, replayer, Mission Control tab) | Sometimes (UI) |
| `app/simulation` | Mission Control Litestar API + `scripts/run.sh` | Sometimes (orchestration) |
| `app/llm_pipeline` | LLM prompt / dataset tooling (Track A) | Research phases |
| `simulation/ros` | ROS workspace mounted into Docker as `/project/mmsl_simulation` | Launch files, ROS nodes |
| `simulation/ros/src/esmini` | esmini simulator + `dat2csv.py` | Rarely |
| `simulation/ros/.cache` | Local trial CSV/DAT cache (`esmini_<batch>_<trial>.csv`) | Generated output |
| `sdc-docker` | Python CLI to start `sdc-bionic` container | Setup only |
| `deploy` | Files mounted into container (`/home/user`, bash scripts) | Setup / ops |
| `sdc` | Vehicle stack code + configs used inside container | Advanced |
| `semantic-maps` | Map/route data for simulation | Scenario setup |
| `alldatasets` | Exported analysis JSON for offline work | Research artifacts |
| `bev_output`, `llm_artifacts` | Generated images / LLM run outputs | Generated |
| `scripts` | Repo-level helper scripts (`run_bev.sh`, etc.) | Run from root |
| `tests` | Python unit tests | When changing backend |

---

## `app/` — web and Python services

### `app/payload` (system of record)

- **Stack:** Next.js + Payload 3 + PostgreSQL (`docker compose up -d`).
- **Human UI:** `http://<host>:3020/admin` — browse sessions, batches, trials, upload `.xosc` / `.xodr`.
- **Machine API:** `http://<host>:3020/api/...` and `/api/graphql` — used by Sampling, Analyzer, Dashboard, ROS poster.

Important paths:

| Path | Purpose |
|------|---------|
| `app/payload/src/payload.config.ts` | Registers collections and CORS |
| `app/payload/src/collections/*.ts` | Data model (`Batches`, `Trials`, `Observations`, `Scenarios`, …) |
| `app/payload/docker-compose.yml` | Starts Postgres + Payload container |

You do **not** need to understand every Next.js file under `app/payload/src/app/` to run simulations. The collections define what gets stored.

### `app/sampling` (parameter optimizer)

- **Entry:** `app/sampling/src/app.py` → Litestar on port **9009**.
- **Core logic:** `handler.py` (`SurrogateHandler`) talks to Payload for batch/scenario config and exposes `/initialize`, `/suggest/{batch_id}`, `/register`.
- **Health check:** There is **no** `/health` route. Litestar always serves OpenAPI at `/schema` (Mission Control uses that as a liveness probe).

### `app/analyzer` (trajectory analysis)

- **Entry:** `app/analyzer/src/app.py` → Litestar on port **9010** (or 8181 in some docs).
- **Core logic:** `controller.py` — clustering, UMAP, heatmaps; `bev_renderer.py`, `csv_roadid_loader.py` for research pipeline.
- **Config:** `app/analyzer/.env` — `PAYLOAD_API`, `PAYLOAD_API_KEY`.

### `app/dashboard` (research UI)

- **Entry:** `app/dashboard` → `bun run dev` on port **3000**.
- **Batch page:** `src/app/batch/[id]/` — dock panels (Parameter Space, Replayer, Mission Control, …).
- **Env:** `app/dashboard/.env` — Payload URL, Analyzer URL, `NEXT_PUBLIC_MISSION_CONTROL_API`.

### `app/simulation` (Mission Control API)

- **Entry:** `app/simulation/src/app.py` → Litestar on port **8282**.
- **Routes:** under `/simulation/*` (not `/`). Opening `http://localhost:8282/` in a browser returns 404 by design.
- **Legacy helper:** `app/simulation/scripts/run.sh` — tmux + parallel workers (old README flow).

---

## `simulation/` — ROS workspace (the confusing part)

Your `tree -L 3` under `simulation/` shows:

```text
simulation/
  README.md          # ITRI Docker / catkin setup notes
  doc/               # Images, troubleshooting
  itri_tools/        # Bag preprocessing utilities
  ros/
    build/           # catkin build products — do not edit
    devel/           # sourced setup.bash — do not edit
    .cache/          # esmini CSV/DAT output — important for debugging
    src/             # actual ROS packages — edit launch + Python here
```

### What to ignore unless building ROS

- `simulation/ros/build/` — compiler output from `catkin_make`.
- `simulation/ros/devel/` — generated `setup.bash`, libraries; sourced inside container.
- Most of `simulation/ros/src/esmini/resources/` — upstream esmini demo maps/scenarios (hundreds of sample files).

### ROS packages you actually care about

Under `simulation/ros/src/`:

| Package | What it does |
|---------|----------------|
| `scenario_search` | Parameter search loop, posts to Payload (`single_parameterized_scenario_search.py`, `scenario_sampler.py`) |
| `simulation_adv` | Main simulation launch (`run.launch`) |
| `scenario` | Scenario updater, navigation |
| `simulation_utils` | Shared helpers |
| `esmini` | Simulator binaries/scripts (`dat2csv.py`) |
| `*_msgs`, `*_srvs` | ROS message definitions |

**Launch file (manual workflow):**  
`simulation/ros/src/scenario_search/launch/single_parameterized_scenario_search.launch`

Default arguments there include:

```xml
<arg name="sampling_suggestion_api" default="http://localhost:9009" />
<arg name="batch_id" default="3" />
```

The Python node reads **ROS parameters** set from this launch file (not command-line flags):

- `simulation/ros/src/scenario_search/src/scenario_search/single_parameterized_scenario_search.py` uses `rospy.get_param("/single_parameterized_scenario_search/batch_id")`, etc.

### Local simulation artifacts

| Location | Content |
|----------|---------|
| `simulation/ros/.cache/scenario_search/records/` | `esmini_<batchId>_<trialIndex>.csv` |
| Payload `trials` / `observations` | Same trials after `scenario_sampler.py` POSTs to CMS |

CSV count on disk can be lower than trial count in Payload if only a subset was synced or cache was cleaned.

---

## `esmini` inside this repo

Path: `simulation/ros/src/esmini/`

- **Not** the separate `LAB/esmini` repo at workspace root unless you symlink/copy; the project uses the **vendored copy inside the ROS workspace**.
- **Runtime:** esmini runs inside `sdc-bionic`, driven by ROS nodes.
- **Post-processing:** `esmini/scripts/dat2csv.py` turns `.dat` recordings into CSV columns (including `roadId`, `laneId`).
- **Sample assets:** `esmini/resources/xosc`, `esmini/resources/xodr` — demos; project scenarios for datasets usually live in Payload uploads or `alldatasets/resources/`.

---

## Docker / deploy / `sdc`

| Path | Role |
|------|------|
| `sdc-docker/` | Install wheel, `sdc-docker-start-container`, `sdc-docker-enter-container-shell` |
| `deploy/container_settings.sh` | Host paths mounted into container |
| `deploy/home`, `deploy/parallel/container_script` | In-container user home and worker scripts used by `run.sh` |
| `sdc/vehicle-configuration/pacifica-1` | Ego parameters YAML |
| `semantic-maps/` | OpenDRIVE-related map data on host, mounted to `/data/semantic-maps` |

Container name: **`sdc-bionic`**. Host repo path `simulation/ros` is mounted as **`/project/mmsl_simulation`** inside the container.

---

## Manual README workflow vs Dashboard Mission Control

### Original README (`README.md` ~Terminal 3)

Still valid for the **legacy tmux / multi-worker** path:

1. Edit `single_parameterized_scenario_search.launch` — set `batch_id` and `sampling_suggestion_api`.
2. Start container + ROS.
3. Run `app/simulation/scripts/run.sh` with worker count.

The launch file defaults matter because the ROS node loads batch ID from **launch parameters**.

### Mission Control (Dashboard tab)

- **Already integrated in the UI:** batch ID and scenario ID are taken from the batch page you opened; health checks, data-quality panel, progress UI, stop/logs.
- **Not fully replacing launch-file editing yet:** the Mission Control backend starts trials via `rosrun` with CLI-style flags, but `single_parameterized_scenario_search.py` does **not** parse `--batch_id` / `--scenario_id` from argv — it only reads ROS params from the launch file. Until that is wired (rosparam set or launch args passed programmatically), you may still need the launch file (or equivalent `rosparam`) aligned with the batch you run.

**Practical guidance today**

| Goal | What to do |
|------|------------|
| View existing batch 1 data in Dashboard | Payload + Dashboard (+ Analyzer for clustering) — no launch edit |
| Legacy parallel simulation (`run.sh`) | Edit launch `batch_id`, start container/ROS, run `run.sh` |
| Mission Control “Run Simulation” | Start Terminals 1–5 (+ container/ROS for real trials); ensure launch defaults match your batch if trials mis-target another batch |

---

## Quick “where is X?” index

| I want to… | Look here |
|------------|-----------|
| Change which batch ROS uses (manual flow) | `simulation/ros/src/scenario_search/launch/single_parameterized_scenario_search.launch` |
| See how parameters are suggested | `app/sampling/src/handler.py` |
| See how trials are written to Payload | `simulation/ros/src/scenario_search/src/scenario_search/scenario_sampler.py` |
| Fix analyzer `roadId` handling | `app/analyzer/src/controller.py`, `csv_roadid_loader.py` |
| Mission Control HTTP API | `app/simulation/src/controller.py`, `orchestrator.py` |
| Dashboard Mission Control panel | `app/dashboard/.../panels/MissionControl/index.tsx` |
| Payload collection schemas | `app/payload/src/collections/` |
| Check local CSV outputs | `simulation/ros/.cache/scenario_search/records/` |

---

## Related docs

- `README.md` — original multi-terminal simulation steps
- `MISSION_CONTROL_USER_GUIDE.md` — which terminals to start, what output to expect
- `MISSION_CONTROL.md` — Track B design
- `SIMULATION_GUIDE.md` — SSH/Xterm simulation troubleshooting
