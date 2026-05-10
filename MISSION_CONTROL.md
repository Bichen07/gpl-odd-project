# Mission Control Integration Plan

**Status:** Design complete — ready for implementation  
**Goal:** Unify Payload, Sampling, Simulation, Analyzer, and Dashboard into a single "one-click" workflow  
**Estimated timeline:** 4-5 weeks across 3 phases

---

## Problem Statement

The current workflow requires **4 manual terminals (SSH/Xterm)**:

| Terminal | Command | Issue |
|----------|---------|-------|
| 1 | `sdc-docker-enter-container-shell` → `roslaunch simulation_adv run.launch` | Needs Xterm GUI |
| 2 | `litestar run --port 9009` (Sampling) | Must activate conda env manually |
| 3 | `docker compose up -d` (Payload) | Must be started before anything else |
| 4 | `rosrun scenario_search single_parameterized_scenario_search.py --batch_id X --scenario_id Y` | Easy to mis-configure |

**Pain points:**
- No visibility into simulation progress — must SSH into container to read logs
- No automatic error recovery — runaway esmini processes go undetected (cf. 120GB `.dat` incident)
- Data integrity risks — skipping `dat2csv.py` or forgetting `batch_id` corrupts Payload
- Dashboard is read-only — no "Run Simulation" button, stale until manually refreshed

---

## Architecture

### Current State (Fragmented)

```
User (Manual)
  ├── Terminal 1: Docker/ROS
  ├── Terminal 2: Sampling (port 9009)
  ├── Terminal 3: Payload (port 3020)
  └── Terminal 4: scenario_search

┌──────────────┐  GET/POST  ┌──────────────┐  GET/POST  ┌──────────────┐
│  Payload CMS │ ◄────────► │   Sampling   │ ◄────────► │  Simulation  │
│  (Port 3020) │            │  (Port 9009) │            │  (ROS/Docker)│
└──────┬───────┘            └──────────────┘            └──────┬───────┘
       │ GET clustering data                                    │ POST observations
       ▼                                                        ▼
┌──────────────┐                                        ┌──────────────┐
│   Analyzer   │                                        │ scenario_    │
│  (Port 8181) │                                        │ sampler.py   │
└──────┬───────┘                                        └──────────────┘
       │ GET /clustering
       ▼
┌──────────────┐
│   Dashboard  │  ← User manually refreshes
│  (Port 3000) │
└──────────────┘
```

### Proposed State (Unified)

```
┌──────────────────────────────────────────────────────────────────┐
│                    Dashboard (Port 3000)                          │
│  ┌────────────────────────────────────────────────────────────┐  │
│  │  Mission Control Panel                                      │  │
│  │  [▶ Run Simulation] [⏸ Pause] [⏹ Stop] [📊 View Logs]      │  │
│  │  Status: ⚙️  Running trial 42/100 | ETA: 1h 20m            │  │
│  └────────────────────────────────────────────────────────────┘  │
└──────────────────┬───────────────────────────────────────────────┘
                   │ WebSocket (real-time updates)
                   │ HTTP POST /simulation/run
                   ▼
┌──────────────────────────────────────────────────────────────────┐
│          Mission Control API (New — Port 8282)                    │
│  app/simulation/src/                                              │
│  • orchestrator.py    — Docker + ROS lifecycle                   │
│  • docker_manager.py  — Python Docker SDK wrapper                │
│  • ros_monitor.py     — ROS health checks, auto-restart          │
│  • data_validator.py  — CSV + Payload integrity checks           │
│  • controller.py      — HTTP endpoints                           │
│  • websocket_handler.py — Live status broadcasts                 │
└───┬─────────┬─────────┬─────────┬────────────────────────────────┘
    │         │         │         │
    ▼         ▼         ▼         ▼
┌────────┐ ┌────────┐ ┌────────┐ ┌──────────────────────┐
│Payload │ │Sampling│ │Analyzer│ │ Docker (sdc-bionic)   │
│(3020)  │ │(9009)  │ │(8181)  │ │ roslaunch, esmini,   │
│        │ │        │ │        │ │ dat2csv, sampler      │
└────────┘ └────────┘ └────────┘ └──────────────────────┘
```

### Key Existing Files

| Component | File | Purpose |
|-----------|------|---------|
| Payload | `app/payload/docker-compose.yml` | CMS + PostgreSQL |
| Sampling | `app/sampling/src/handler.py` | Bayesian parameter suggestions |
| Analyzer | `app/analyzer/src/controller.py` | Clustering + BEV rendering |
| Dashboard | `app/dashboard/src/` (Next.js) | Visualization UI |
| Simulation | `simulation/ros/src/scenario_search/src/scenario_search/single_parameterized_scenario_search.py` | ROS orchestrator |
| Simulation | `simulation/ros/src/scenario_search/src/scenario_search/scenario_sampler.py` | Posts observations to Payload |
| **Placeholder** | `app/simulation/src/controller.py` | **TBI** — currently returns `"TBI"` |

---

## Payload CMS (`app/payload`) — role, structure, and login

Payload here is **not** just a database UI: it is the **system of record** for scenarios, sampling plans, batches, trials, per-frame observations, saved analyses (`documents`), and uploaded maps/scenarios. Everything else (Sampling, Analyzer, Simulation ROS nodes) reads or writes Payload through **REST** (`/api/...`) or **GraphQL** (`/api/graphql`).

### Tech stack

| Piece | Location / detail |
|-------|-------------------|
| Framework | **Next.js 15** App Router + **Payload 3** (`payload`, `@payloadcms/next`, `@payloadcms/db-postgres`) |
| Database | **PostgreSQL** (`DATABASE_URI` in `.env`; Docker `docker-compose.yml` maps host `3020` → container `3000`) |
| Config | `app/payload/src/payload.config.ts` — collections, CORS (includes dashboard URLs), `serverURL`, GraphQL |
| Types | `app/payload/src/payload-types.ts` (generated) |

### Collections (data model)

Registered in `payload.config.ts` — main simulation/analysis entities:

| Collection | Purpose |
|------------|---------|
| `sessions` | Groups related **batches** (e.g. “dataset 1 / 2 / 3” style organization). |
| `scenarios` | Logical scenario: parameters, objectives, links to OpenSCENARIO / OpenDRIVE assets. |
| `batches` | One **parameter search run** for a scenario: links `scenario`, `session`, `sampling`, optional saved `documents` (analysis zip, images). |
| `trials` | One simulation run: parameter values, KPIs, link to observations. Custom endpoints (e.g. trajectories) live in `Trials.ts`. |
| `observations` | Per-frame trajectory + agent state (`egoRoadId`, `egoLaneId`, agents’ `roadId` / `laneId`, etc.). |
| `samplings` | Sampling strategy/steps for a batch (used by `app/sampling`). |
| `openScenarios` / `openDrives` | Stored `.xosc` / `.xodr` (and metadata). |
| `documents` | Uploaded analysis artifacts (`analyze.zip`, plots). |
| `users` | Admin login + **API keys** (`auth: { useAPIKey: true }` in `Users.ts`). |
| Others | `egos`, `keyPerformanceIndicators`, `esminiDats`, `media`. |

**Typical selection path for analysis:** choose **Session** → **Batch** → **Trials** / export; the **research dashboard** mirrors this by querying the same IDs via Payload API using `PAYLOAD_API` + API key.

### Routes you actually use

| URL | Who uses it |
|-----|-------------|
| **`/admin`** | **Human operators** — Payload’s built-in admin UI: browse/edit collections, upload files, inspect trials/observations. **This is where you log in with a `users` account** (email/password created on first setup; see `app/payload/README.md`). |
| **`/api/*`** | Sampling service, Analyzer, Dashboard, simulation nodes — REST CRUD + uploads. |
| **`/api/graphql`** | Dashboard GraphQL client (`graphql-codegen`). |
| **`/`** (`app/(frontend)/page.tsx`) | Minimal welcome page; optional **SSR auth check** (`payload.auth({ headers })`) — mostly a stub; real “product” UI is **`app/dashboard`**, not this page. |
| Custom REST | e.g. `heatmapOrdering` endpoint registered in `payload.config.ts`. |

### Access control (why “login to select data”)

- **Browser:** Use **`http://<host>:3020/admin`** (or whatever `PAYLOAD_PUBLIC_SERVER_URL` is). Only authenticated **Users** get write access on many collections (`usersAccess` in `access.ts` for create/update/delete); **read** on batches is often public (`read: () => true` on `Batches`) so APIs can list data, but **editing** scenarios/batches still expects a logged-in admin.
- **Programs:** Use **`Authorization: users API-Key <key>`** (User API keys from Payload admin). The Analyzer/Dashboard `.env` uses this — no interactive login for services.

So “login to select data” today means: **log into Payload Admin** to pick scenarios/batches/trials or manage uploads; the **scatter/analysis UI** is the separate **Dashboard** app, which authenticates to Payload **via API key**, not your browser session.

---

### How this becomes “one website” (aligned with Mission Control)

Today you effectively have **three faces**: Payload Admin (data/CMS), Dashboard (viz), and terminals (simulation). The plan unifies **control and visibility**, not necessarily a single Next.js bundle on day one:

1. **Same origin via reverse proxy (fastest operational win)**  
   One hostname, e.g. `https://odd.lab/` with paths:
   - `/admin` → Payload (port 3020)
   - `/` or `/app` → Dashboard (port 3000)
   - `/analyzer` or `/api/analyzer` → Analyzer (8181) if exposed  
   Cookies stay scoped; CORS headaches shrink. Payload `cors` in `payload.config.ts` already lists dashboard origins — add the unified hostname when you introduce it.

2. **Mission Control API as backend-for-frontend (Phase B)**  
   The Dashboard **Mission Control** tab calls **your** orchestrator (port 8282). That service calls Sampling + Docker + ROS and **checks Payload health** (`GET /api/batches`, etc.) using the **same API key pattern** — users never paste URLs; they pick **batch/scenario** in UI and click Run.

3. **Optional deep merge (later)**  
   Embed Dashboard routes inside Payload’s Next app, or vice versa, **or** use iframe/embed only for admin — higher effort; proxy + Mission Control usually suffices.

**Summary:** Payload stays the **authoritative store**; “single website” in the plan means **one browser entry point** (proxy + Dashboard tabs including Mission Control), **one identity story** (SSO later if needed), and **automated** simulation/analysis instead of jumping between Admin, Dashboard, and SSH.

---

## Implementation Phases

### Phase B1 — Core API (2 weeks)

**Branch:** `feature/mission-control-api`  
**Goal:** Trigger simulations programmatically; no manual terminals needed.

#### Files to Create

| File | Purpose | Est. lines |
|------|---------|-----------|
| `app/simulation/src/orchestrator.py` | Main simulation loop | ~400 |
| `app/simulation/src/docker_manager.py` | Docker SDK wrapper | ~200 |
| `app/simulation/src/ros_monitor.py` | ROS topic monitor | ~150 |
| `app/simulation/src/data_validator.py` | Integrity validation | ~150 |
| `app/simulation/src/controller.py` | HTTP endpoints (modify) | +100 |
| `app/simulation/src/websocket_handler.py` | Live status broadcasts | ~100 |

#### Orchestrator Pseudocode

```python
class SimulationOrchestrator:
    async def run(self):
        self.status = "starting"

        # Step 1: Docker + ROS initialization
        await self._ensure_docker_running()     # docker_manager.py
        await self._start_ros_master()
        await self._wait_for_ros_topics()

        # Step 2: Service health checks
        await self._check_payload_health()
        await self._check_sampling_health()

        # Step 3: Trial loop
        self.status = "running"
        for i in range(self.n_trials):
            self.current_trial = i + 1
            params   = await self._get_sampling_suggestion()  # POST /suggest
            result   = await self._run_esmini_trial(params)
            await self._validate_csv_output(result.csv_path)  # data_validator.py
            await self._validate_payload_post(result.trial_id)
            if result.status == "failed":
                await self._handle_trial_failure(result)      # auto-retry ×3
            await self._broadcast_status()                    # websocket

        self.status = "completed"
        await self._trigger_analyzer_clustering()
        await self._broadcast_completion()
```

#### API Endpoints

```
POST  /simulation/run            — Start simulation run
POST  /simulation/stop           — Stop running simulation
GET   /simulation/status/{id}    — Get progress/ETA
GET   /simulation/logs/{id}      — Stream logs
WS    /simulation/stream/{id}    — Real-time status updates
```

#### API Contract

**Request `POST /simulation/run`:**
```json
{
  "batch_id": 1,
  "scenario_id": 1,
  "n_trials": 100,
  "options": { "retry_failed": true, "max_trial_duration_seconds": 60 }
}
```

**Response:**
```json
{
  "run_id": "run_1234567890",
  "status": "starting",
  "websocket_url": "ws://localhost:8282/simulation/stream/run_1234567890"
}
```

**WebSocket messages (server → client):**
```json
{ "type": "status_update",  "payload": { "status": "running", "current_trial": 43 } }
{ "type": "trial_completed","payload": { "trial_id": "5952", "duration_seconds": 19.1 } }
{ "type": "error",          "payload": { "error_type": "esmini_timeout", "recoverable": true } }
{ "type": "completed",      "payload": { "successful": 97, "failed": 3 } }
```

#### Data Integrity Validation (after each trial)

```python
checks = {
    "csv_exists":                  csv_path.exists(),
    "csv_has_roadId":              "roadId" in pd.read_csv(csv_path).columns,
    "payload_trial_created":       payload_api.trial_exists(trial_id),
    "payload_observations_count":  payload_api.count_obs(trial_id) == len(csv),
}
# If any check fails → alert + retry
```

Known constraints:
- ✅ Ego `roadId` is non-zero (Bug 1 fixed — `controller.py` Phase 1)
- ⚠️ Agent `roadId` may be 0 (Bug 2 — `scenario_sampler.py:1405`, documented in `ISSUES.md`)

#### Success Criteria

- [ ] Can start simulation from `curl` with no manual terminals
- [ ] Docker container auto-starts if stopped
- [ ] 100 trials complete end-to-end
- [ ] CSV + Payload integrity validated per trial

---

### Phase B2 — Dashboard UI (1 week)

**Branch:** `feature/mission-control-ui`  
**Goal:** "Run Simulation" button in Dashboard with live progress.

#### Files to Create

```
app/dashboard/src/
├── app/batch/[id]/_tabs/mission-control/
│   ├── page.tsx                   ← Mission Control tab
│   ├── RunSimulationButton.tsx
│   ├── SimulationStatusCard.tsx
│   └── SimulationProgress.tsx
└── lib/
    └── missionControlClient.ts   ← HTTP + WebSocket client
```

#### Client Interface

```typescript
export class MissionControlClient {
  async runSimulation(batchId: number, scenarioId: number, nTrials: number): Promise<RunResponse>
  async stopSimulation(runId: string): Promise<void>
  async getStatus(runId: string): Promise<StatusResponse>
  subscribeToUpdates(runId: string, cb: (msg: WsMessage) => void): () => void
}
```

#### User Flow

1. Open Batch detail page → click "Mission Control" tab
2. Set scenario + trial count → click **▶ Run Simulation**
3. Progress bar: "Running trial 1/100 (ETA: 2h 15m)"
4. On completion: "✅ 100 trials added" → Dashboard auto-refreshes

#### Success Criteria

- [ ] "Run Simulation" button visible in Batch detail
- [ ] Real-time progress bar updates every ~2 s
- [ ] Dashboard auto-refreshes on completion without page reload
- [ ] No SSH required to monitor simulation

---

### Phase B3 — Advanced Features (1-2 weeks)

**Branch:** `feature/mission-control-advanced`  
**Goal:** Error recovery, multi-batch queue, live logs.

#### Features

| Feature | Implementation |
|---------|---------------|
| **Auto-retry** | Up to 3 retries per failed trial |
| **ROS watchdog** | Monitor `/rosout`, restart crashed nodes |
| **Runaway guard** | Kill esmini if `.dat` file > 1 GB |
| **Multi-batch queue** | Sequential execution, user-reorderable |
| **Live log viewer** | `SimulationLogsViewer.tsx` — tail esmini output |
| **Data quality panel** | Show CSV count vs Payload count, highlight `roadId=0` trials |
| **Reprocess button** | Trigger `csv_roadid_loader.py` for affected trials |

#### Success Criteria

- [ ] Failed trials auto-retry (target success rate > 95 %)
- [ ] Can queue 3+ batches, run sequentially
- [ ] Live logs stream to Dashboard
- [ ] Data quality issues surfaced in UI

---

## Before vs After

| | Before | After |
|-|--------|-------|
| **Start simulation** | 4 terminals (Xterm/SSH) | 1 button click |
| **Monitor progress** | SSH + tail logs | Real-time progress bar |
| **Error recovery** | Manual | Automatic retry + restart |
| **Data integrity** | Hope nothing is skipped | Validated per trial |
| **Dashboard freshness** | Manual refresh | Auto-refresh on completion |

---

## Integration with Track A (Research Pipeline)

| Track A Phase | Mission Control hook |
|---------------|---------------------|
| Phase 1 — roadId fix | Data validator re-uses fixed logic |
| Phase 2 — Medoids | Post-simulation: auto-cluster → auto-select medoids |
| Phase 3 — BEV | Post-simulation: auto-render BEV frames |
| Phase 4 — SimLabeller | Auto-generate LLM artifact dataset |
| Phase 5 — LLM | Optionally auto-run `cluster_interpreter.py` |
| Phase 6 — Dashboard integration | Mission Control becomes primary trigger for end-to-end pipeline |

---

## Risks and Mitigations

| Risk | Mitigation |
|------|-----------|
| Docker SDK permission denied | Add user to `docker` group; test `docker ps` without `sudo` |
| ROS node crashes | Monitor `/rosout`; auto-restart failed nodes |
| Runaway esmini (120 GB `.dat`) | Poll file size; kill process if > 1 GB |
| Payload/Sampling network timeout | Exponential backoff; configurable timeout |
| WebSocket drops | Auto-reconnect; HTTP polling fallback |
| Concurrent simulation conflict | Lock: 1 run per batch at a time |

---

## Developer Notes

### Setup

```bash
# Create conda env for Mission Control API
conda create -n simulation python=3.10
conda activate simulation
pip install litestar uvicorn docker requests websockets pyyaml

# Dashboard (Phase B2)
bun add react-toastify
```

### Testing

```bash
# Start API
cd app/simulation/src && litestar run --port 8282 --debug

# Trigger a run
curl -X POST http://localhost:8282/simulation/run \
  -H "Content-Type: application/json" \
  -d '{"batch_id":1,"scenario_id":1,"n_trials":5}'

# Poll status
curl http://localhost:8282/simulation/status/<run_id>
```

### Common Pitfalls

**Use Docker SDK, not subprocess:**
```python
# Bad
subprocess.run(["sdc-docker-start-container"])

# Good
import docker
docker.from_env().containers.get("sdc-bionic").start()
```

**Use WebSocket, not polling:**
```python
# Bad — 100 separate HTTP requests
for _ in range(100):
    status = requests.get("/status").json(); time.sleep(2)

# Good — single persistent connection
async with websockets.connect(f"ws://localhost:8282/stream/{run_id}") as ws:
    async for msg in ws:
        print(json.loads(msg)["current_trial"])
```

---

## Next Steps

1. ✅ Design complete (this document)
2. [ ] Review with team — approve Phase B1 scope
3. [ ] Set up `conda activate simulation` env with `docker` SDK
4. [ ] Create branch `feature/mission-control-api`
5. [ ] Implement `orchestrator.py` (start with `_ensure_docker_running` + 1-trial loop)

See `cluster_interpreter_integration_plan.md` → **Track B** for the full roadmap and Git branch strategy.
