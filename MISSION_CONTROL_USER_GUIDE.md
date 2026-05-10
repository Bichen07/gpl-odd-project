# Mission Control — User Guide

**Purpose:** Run end-to-end simulations (Sampling → esmini → Payload) from the Dashboard without opening multiple terminals.

---

## Quick summary

| Step | What you do | Where |
|------|------------|-------|
| 1 | Start the Mission Control API | Lab server terminal |
| 2 | Open the Dashboard | Browser |
| 3 | Pick a Batch, click **🚀 Mission Control** tab | Dashboard |
| 4 | Set trial count, click **▶ Run Simulation** | Dashboard |
| 5 | Watch the live progress bar | Dashboard |
| 6 | Results appear in Payload and Dashboard automatically | Dashboard |

---

## 1. Prerequisites

Before using Mission Control you need the following services running.

### 1a. Payload CMS (port 3020)

```bash
cd app/payload
docker compose up -d
```

Verify: `curl http://localhost:3020/api/batches` returns JSON.

**Login (for browsing data):**  
Open `http://localhost:3020/admin` → use your `users` account email/password.  
First time setup: follow `app/payload/README.md` to create the first admin user.

### 1b. Sampling service (port 9009)

```bash
conda activate sampling
cd app/sampling/src
litestar run --port 9009 --host 0.0.0.0
```

### 1c. Analyzer (port 9010 / 8181)

```bash
conda activate analyzer
cd app/analyzer/src
litestar run --port 9010 --host 0.0.0.0
```

### 1d. Dashboard (port 3000)

```bash
cd app/dashboard
bun run dev
```

### 1e. Mission Control API (port 8282) — **new**

```bash
conda activate simulation    # or: pip install -r app/simulation/requirements.txt
cd app/simulation/src
litestar run --port 8282 --host 0.0.0.0
```

Expected startup output:
```
INFO    mission_control.docker: Docker daemon connected.
INFO:   Started server process [12345]
INFO:   Waiting for application startup.
INFO:   Application startup complete.
INFO:   Uvicorn running on http://0.0.0.0:8282
```

### 1f. Simulation container (sdc-bionic) — required for real runs

This only works on the **ITRI lab server** which has the `sdc-bionic` Docker image.

```bash
# Start the container (done automatically by Mission Control, but can be manual)
sdc-docker-start-container

# Start ROS inside the container (Terminal inside Docker)
sdc-docker-enter-container-shell
roslaunch simulation_adv run.launch
```

> **On your local workstation without sdc-bionic:**  
> The Mission Control UI still loads. Service health cards will show **Docker: ❌ not available**.  
> The "Run Simulation" button will be disabled with a tooltip explaining why.  
> All other features (data quality check, log viewer, status polling) work normally.

---

## 2. Add Mission Control URL to Dashboard

In `app/dashboard/.env`, set:

```
NEXT_PUBLIC_MISSION_CONTROL_API=http://localhost:8282
```

If running the API on a remote lab server, replace `localhost` with the server IP:

```
NEXT_PUBLIC_MISSION_CONTROL_API=http://140.113.208.174:8282
```

Restart the Dashboard after changing `.env`.

---

## 3. Using Mission Control in the Dashboard

### 3a. Open a Batch page

1. Go to `http://localhost:3000`
2. Click any **Batch** from the list (e.g. Batch 1)
3. The Batch detail page loads with the Explore dock

### 3b. Open the Mission Control tab

In the **left panel** (same area as "Filtering", "Clustering Selection", "LLM Analysis"), click the tab:

```
🚀 Mission Control
```

### 3c. Check Service Health

At the top of the panel you will see chip badges:

| Badge | Green means | Red means |
|-------|-------------|-----------|
| **Payload** | CMS API reachable | Check `docker compose up -d` in `app/payload` |
| **Sampling** | Sampling API running | Run `litestar run --port 9009` |
| **Docker** | Docker SDK available | Install `docker-py` or run on lab server |
| **Container** | sdc-bionic running | Start with `sdc-docker-start-container` |

Health is refreshed every 15 seconds automatically.

### 3d. Set simulation parameters

| Field | Description |
|-------|-------------|
| **Batch ID** | Auto-filled from the current batch page (read-only) |
| **Scenario ID** | Auto-filled from the batch's linked scenario (read-only) |
| **Number of trials** | How many simulations to run (default: 100) |
| **Max trial duration (s)** | Timeout per trial (default: 60 s) |
| **Auto-retry** | Toggle — retries failed trials up to 3 times (default: on) |

### 3e. Run the simulation

Click **▶ Run Simulation**.

A progress bar appears immediately:

```
Trial 5 / 100   (5%)                               ETA: 1h 47m
████░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
✅ 4 ok    ❌ 1 failed    Elapsed: 1m 30s
```

The status chip changes through: `STARTING` → `RUNNING` → `COMPLETED`.

### 3f. View live logs

Click **📋 Logs** to expand the log viewer. It shows the last 50 lines from the orchestrator, updated every 3 seconds:

```
[12:04:01] Mission Control run started run_id=mc_a3f72b19
[12:04:03] Container sdc-bionic is running.
[12:04:05] Infrastructure ready.
[12:04:06] Trial 0: params={'oncomingSpeed': 8.3, 'delay': 1.2}
[12:04:24] Trial 0 completed in 18.1s
[12:04:24] Trial 1: params={'oncomingSpeed': 6.7, 'delay': 0.9}
```

### 3g. Stop a running simulation

Click **⏹ Stop** at any time. The current trial finishes cleanly, then the run ends. Completed trials are already saved to Payload.

### 3h. Check data quality

At the bottom of the panel, the **Data quality** section shows:

```
Local CSVs: 42   |   Payload trials: 42
✅ Local CSVs and Payload are in sync.
```

If they differ:
```
Local CSVs: 40   |   Payload trials: 42
⚠️ Counts differ — some trials may be missing CSVs or not yet posted to Payload.
```

Click **Refresh** to re-check.

---

## 4. How to verify simulation is running

### From Dashboard
- Progress bar moves (trial count increments every ~20 seconds)
- Status chip shows `RUNNING`
- Log viewer shows new trial lines

### From command line (SSH into lab server)

```bash
# Check Mission Control API status
curl http://localhost:8282/simulation/status | python3 -m json.tool

# Check Docker container
docker ps | grep sdc-bionic

# Watch ROS topics inside container
docker exec sdc-bionic rostopic list

# Watch esmini output (inside container)
docker exec sdc-bionic tail -f /project/mmsl_simulation/.cache/scenario_search/records/esmini_*.csv

# Check CSV count vs Payload count
curl http://localhost:8282/simulation/data-quality/1 | python3 -m json.tool
```

### Health check endpoint

```bash
curl http://localhost:8282/simulation/health | python3 -m json.tool
```

Response example:
```json
{
  "status": "ok",
  "services": {
    "payload": { "ok": true },
    "sampling": { "ok": true },
    "docker": { "available": true, "container_status": "running" },
    "ros": { "available": true, "ros_master_alive": true, "node_count": 8 }
  },
  "active_runs": 1
}
```

---

## 5. How to see simulation results

### In Dashboard

Once a run completes:
1. The status chip shows `COMPLETED`
2. A message shows: "✅ 97 ok, 3 failed"
3. **Refresh the Batch page** (`F5`) — new trials appear in the scatter plot

The Dashboard reads trials from Payload in real-time when you load/refresh the page. There is no automatic push from Mission Control to the scatter plot yet (planned for Phase B3).

### In Payload Admin UI

Go to `http://localhost:3020/admin`:
- **Trials** collection: sorted by newest first — new trials appear immediately
- **Observations** collection: filter by `trial.batch = 1` to see trajectory frames

### From the CSV cache

```bash
ls -lth simulation/ros/.cache/scenario_search/records/ | head -20
# New files like esmini_1_5960.csv, esmini_1_5961.csv appear as trials finish
```

---

## 6. API Reference

All endpoints are at `http://localhost:8282`.

| Method | Path | Description |
|--------|------|-------------|
| `GET` | `/simulation/health` | Service availability check |
| `POST` | `/simulation/run` | Start a simulation run |
| `POST` | `/simulation/stop/{run_id}` | Stop a running simulation |
| `GET` | `/simulation/status` | All active run snapshots |
| `GET` | `/simulation/status/{run_id}` | Single run snapshot |
| `GET` | `/simulation/logs/{run_id}` | Buffered log lines |
| `GET` | `/simulation/data-quality/{batch_id}` | CSV vs Payload trial count |
| `WS` | `/simulation/stream/{run_id}` | Real-time WebSocket stream |

**Start a run (curl):**
```bash
curl -X POST http://localhost:8282/simulation/run \
  -H "Content-Type: application/json" \
  -d '{
    "batch_id": 1,
    "scenario_id": 1,
    "n_trials": 50,
    "retry_failed": true,
    "max_trial_duration_seconds": 60
  }'
```

Response:
```json
{
  "run_id": "mc_a3f72b19",
  "status": "starting",
  "websocket_url": "/simulation/stream/mc_a3f72b19"
}
```

---

## 7. Env vars

| Variable | Default | Description |
|----------|---------|-------------|
| `PAYLOAD_API` | `http://localhost:3020/api` | Payload REST API base URL |
| `PAYLOAD_API_KEY` | _(empty)_ | Payload user API key |
| `SAMPLING_API` | `http://localhost:9009` | Sampling Litestar service URL |
| `DASHBOARD_URL` | `http://localhost:3000` | Added to CORS allow-list |
| `NEXT_PUBLIC_MISSION_CONTROL_API` | `http://localhost:8282` | Set in Dashboard `.env` |

Set in `app/simulation/src` by reading the system environment or creating an `.env` file there.

---

## 8. Troubleshooting

| Symptom | Likely cause | Fix |
|---------|-------------|-----|
| "Run Simulation" button is grey | Docker not available | Run on ITRI lab server |
| All health chips red | Mission Control API not started | `litestar run --port 8282` |
| Status stuck at STARTING | Sampling not responding | `conda activate sampling && litestar run --port 9009` |
| Payload chip red | Payload CMS stopped | `cd app/payload && docker compose up -d` |
| Trials not appearing in scatter plot | Dashboard cache | Refresh the batch page (F5) |
| CSV count ≠ Payload count | dat2csv incomplete / Payload POST failed | Check logs; re-run the failed trials |
| Container status "not_found" | sdc-bionic image not present | Run on the ITRI lab server where image is installed |

---

## 9. Files created

| File | Role |
|------|------|
| `app/simulation/src/models.py` | Shared dataclasses (request/response/status) |
| `app/simulation/src/docker_manager.py` | Docker SDK wrapper |
| `app/simulation/src/ros_monitor.py` | ROS health monitor via docker exec |
| `app/simulation/src/data_validator.py` | CSV + Payload integrity checks |
| `app/simulation/src/orchestrator.py` | Main simulation loop |
| `app/simulation/src/controller.py` | HTTP + WebSocket Litestar controller |
| `app/simulation/src/app.py` | Litestar app + CORS config |
| `app/simulation/requirements.txt` | Python dependencies |
| `app/dashboard/src/app/_shared/api/missionControl.ts` | TypeScript API client |
| `app/dashboard/src/app/batch/[id]/_tabs/explore/components/dock/panels/MissionControl/index.tsx` | Dashboard UI panel |
| `tests/test_mission_control.py` | 18 unit tests (all pass) |
