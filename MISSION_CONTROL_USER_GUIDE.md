# Mission Control — User Guide

**Purpose:** Run end-to-end simulations (Sampling → esmini → Payload) from the Dashboard without opening multiple terminals.

---

## Repository layout

If the `simulation/ros/` tree (many `build/`, `devel/`, and `src/*` packages) is confusing, read **`PROJECT_STRUCTURE.md`** first. It explains Payload vs Sampling vs Analyzer vs Dashboard vs ROS/esmini, which folders are generated, and whether you still edit the launch file manually.

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

## 0. How many terminals do you need?

Each service runs in its **own terminal** and stays alive the entire time you work.  
Open all required terminals **before** opening the Dashboard.

| Terminal # | Conda env | Service | Port | When needed |
|---|---|---|---|---|
| **1** | _(any)_ | Payload CMS (`docker compose up -d`) | 3020 | Always — start first |
| **2** | `sampling` | Sampling API | 9009 | When running simulations or clustering |
| **3** | `analyzer` | Analyzer API | 9010 | When viewing heatmaps / clustering |
| **4** | _(any)_ | Dashboard (`bun run dev`) | 3000 | Always — keeps website running |
| **5** | `sampling` | **Mission Control API** ← new | 8282 | When using the Run Simulation button |
| **6** | _(lab only)_ | sdc-bionic container + roslaunch | — | ITRI lab server only |

> **Terminal 1 returns the prompt immediately** (`docker compose up -d` runs in the background).  
> **Terminals 2–5 block** — they keep running until you press `Ctrl+C`. Do not close them.  
> **Terminal 6 is not needed on your local machine.** The Mission Control panel will show Docker as ❌ and the Run Simulation button will be disabled — this is correct and expected.

---

## 1. Prerequisites

> **Note — SSH port forwarding (important!):**  
> Since you SSH from your laptop to the lab PC, your laptop browser **cannot reach `http://140.113.208.174:3000` directly** — the lab PC firewall blocks it.
>
> ### ⚠️ RUN THIS COMMAND ON YOUR LAPTOP — NOT inside the SSH session on the lab PC!
>
> If you accidentally run it inside the SSH session, SSH will try to bind lab PC ports that are already in use (`Address already in use`), **and it will squat on port 8282**, breaking the Mission Control API startup (`[Errno 98] address already in use`).
>
> **On your laptop** (open a fresh terminal — Windows PowerShell / macOS Terminal / WSL), run:
> ```bash
> ssh -L 3000:localhost:3000 \
>     -L 8282:localhost:8282 \
>     -L 3020:localhost:3020 \
>     -L 9009:localhost:9009 \
>     -L 9010:localhost:9010 \
>     carlos11@140.113.208.174
> ```

> ```bash
> ssh -L 3000:localhost:3000 -L 8282:localhost:8282 -L 3020:localhost:3020 -L 9009:localhost:9009 -L 9010:localhost:9010 carlos11@140.113.208.174
> ```
> After connecting, open **`http://localhost:3000`** in your laptop browser — **not** `140.113.208.174:3000`.
>
> **If you ran it on the lab PC by mistake and now port 8282 is blocked**, fix it like this (on the lab PC):
> ```bash
> kill $(lsof -ti :8282)   # or:  kill $(ss -tlnp | grep 8282 | awk '{print $NF}' | grep -oP 'pid=\K[0-9]+')
> ```
> Then start the Mission Control API again (step 1e).

All commands below run **on the lab PC** (inside the SSH session).

Before using Mission Control, start the following services. Each one needs its **own terminal** (SSH session).

---

### 1a. Payload CMS (port 3020)

**Terminal:** any (runs in background with `-d`)

```bash
cd /home/carlos11/Downloads/code/LAB/41_Git/gpl-odd-project/app/payload
docker compose up -d
```

**✅ What you should see:**
```
[+] Running 2/2
 ✔ Container payload-postgres-1  Running   0.0s
 ✔ Container payload-payload-1   Running   0.0s
```
The prompt returns immediately. Payload is already running — `Running 0.0s` means the containers were already up.

**If you see `Starting` instead of `Running`:** wait ~10 seconds then check again with `docker compose ps`.

**Verify it works:**
```bash
curl http://localhost:3020/api/batches | head -c 100
```
Should print JSON starting with `{"docs":[...`.

**What you do NOT need to do:** You do not need to log into `http://localhost:3020/admin` to run simulations. Admin login is only for manual data browsing.

---

### 1b. Sampling service (port 9009)

**Terminal:** dedicated (blocks — keep this terminal open)

```bash
conda activate sampling
cd /home/carlos11/Downloads/code/LAB/41_Git/gpl-odd-project/app/sampling/src
litestar run --port 9009 --host 0.0.0.0
```

**✅ What you should see:**
```
Using Litestar app from app:app
┌──────────────────────────────┬──────────────────────┐
│ Litestar version             │ 2.8.2                │
│ OpenAPI                      │ Enabled path=/schema │
└──────────────────────────────┴──────────────────────┘
INFO:     Uvicorn running on http://0.0.0.0:9009 (Press CTRL+C to quit)
```
Then it waits. This terminal stays blocked.

**You will also see 404 lines like:**
```
INFO:  127.0.0.1:xxxxx - "GET /health HTTP/1.1" 404 Not Found
```
This is the Mission Control API probing for the sampling service health. **This is harmless** — the Sampling service has no `/health` route; Mission Control now uses `/schema` to check (see note below).

**Verify it works:**
```bash
curl http://localhost:9009/schema/openapi.json | python3 -m json.tool | head -5
```

---

### 1c. Analyzer (port 9010)

**Terminal:** dedicated (blocks — keep this terminal open)

**First — check if port 9010 is already in use:**
```bash
ss -tlnp | grep 9010
```
If something is already listening, kill it:
```bash
kill $(lsof -ti :9010)
```

Then start:
```bash
conda activate analyzer
cd /home/carlos11/Downloads/code/LAB/41_Git/gpl-odd-project/app/analyzer/src
litestar run --port 9010 --host 0.0.0.0
```

**✅ What you should see:**
```
Using device: cpu
Using device: cuda
Using Litestar app from app:app
INFO:     Uvicorn running on http://0.0.0.0:9010 (Press CTRL+C to quit)
```
(The `h5py not installed` UserWarning is harmless.)

**❌ If you see `[Errno 98] address already in use`:** The port is still occupied.  
Run `kill $(lsof -ti :9010)` and try again.

---

### 1d. Dashboard (port 3000)

**Terminal:** dedicated (blocks — keep this terminal open)

```bash
cd /home/carlos11/Downloads/code/LAB/41_Git/gpl-odd-project/app/dashboard
bun run dev
```

**✅ What you should see:**
```
▲ Next.js 15.5.9 (Turbopack)
   - Local:   http://localhost:3000
   - Network: http://140.113.208.174:3000
✓ Ready in 717ms
```
Then it waits. Open the Dashboard at **`http://localhost:3000`** on the machine where you browse (laptop with SSH port forwarding, or the lab PC directly). Do not rely on `http://140.113.208.174:3000` from outside the lab unless your network and firewall allow it.

When you navigate to `/batch/1` you will see in the terminal:
```
GET /batch/1 200 in 10580ms
```
`200` means success. You should see the scatter plot page.

---

### 1e. Mission Control API (port 8282) ← new service

**Terminal:** dedicated (blocks — keep this terminal open)

**One-time setup — install the Docker Python library** (only needed once):
```bash
conda activate sampling
pip install docker
```

Then start the API:
```bash
conda activate sampling
cd /home/carlos11/Downloads/code/LAB/41_Git/gpl-odd-project/app/simulation/src
litestar run --port 8282 --host 0.0.0.0
```

**✅ What you should see (with Docker available):**
```
INFO    mission_control.docker: Docker daemon connected.
Using Litestar app from app:app
INFO:     Uvicorn running on http://0.0.0.0:8282 (Press CTRL+C to quit)
```

**If docker-py was not yet installed (before running `pip install docker`) you would see:**
```
docker-py not installed — Docker manager running in stub mode.
```
After installing docker-py and restarting, this line disappears and the Docker chip in the Dashboard turns green.

**Do NOT open `http://localhost:8282` in a browser.** The API has no homepage. The browser probes `/` and `/favicon.ico`, both return 404 — this is expected and harmless:
```
INFO: "GET / HTTP/1.1" 404 Not Found          ← harmless, just the browser probing
INFO: "GET /favicon.ico HTTP/1.1" 404 Not Found  ← harmless
```

**✅ When the Dashboard is also running, you will see real requests:**
```
INFO: "OPTIONS /simulation/health HTTP/1.1" 204 No Content    ← CORS preflight (normal)
INFO: "GET /simulation/health HTTP/1.1" 200 OK                ← ✅ working
INFO: "GET /simulation/data-quality/1 HTTP/1.1" 200 OK        ← ✅ working
```
`200 OK` on `/simulation/health` and `/simulation/data-quality/1` means the Mission Control panel is connected and reading data from the API.

**Verify from command line:**
```bash
curl http://localhost:8282/simulation/health | python3 -m json.tool
```
You should get:
```json
{
  "status": "ok",
  "services": {
    "payload": { "ok": true },
    "sampling": { "ok": true },
    "docker": { "available": true, "container_status": "running" },
    "ros": { "available": true, "ros_master_alive": false }
  },
  "active_runs": 0
}
```

---

### 1f. Simulation container (sdc-bionic) — required only for running new simulations

> **This is needed only when you want to actually run new simulations.**  
> For viewing existing data in the Dashboard, analyzing clusters, or seeing Mission Control health — you do NOT need this step.

The container (`sdc-bionic`) runs the ROS/esmini simulation stack.

#### Step 1 — Check if container is already running

```bash
docker ps | grep sdc-bionic
```

**If you see a line like this, the container is ALREADY running — skip to Step 2:**
```
53bed4010903   sdc-stage-2:bionic   ...   Up 4 weeks   sdc-bionic
```

**If you see nothing**, start it:
```bash
sdc-docker-start-container
```

**If `sdc-docker-start-container` gives "Conflict" error:**
```
docker: Error response from daemon: Conflict. The container name "/sdc-bionic" is already in use
```
The container exists but in a bad state. Stop and remove it first:
```bash
docker stop sdc-bionic
docker rm sdc-bionic
sdc-docker-start-container
```

#### Step 2 — Enter the container shell

```bash
sdc-docker-enter-container-shell
```

You will see a different prompt — you are now **inside** the container:
```
user @ carlos11-System-Product-Name in /project/mmsl_simulation |15:44:04
$
```

#### Step 3 — Source the ROS workspace (REQUIRED — do this every time)

**This is the most common mistake.** Without sourcing, `roslaunch` cannot find any package:

```bash
source /opt/ros/melodic/setup.bash
source /project/mmsl_simulation/devel/setup.bash
```

You can verify it works:
```bash
rospack find simulation_adv   # should print: /project/mmsl_simulation/src/simulation_adv
rospack find scenario_search  # should print: /project/mmsl_simulation/src/scenario_search
```

#### Step 4 — Start ROS (simulation_adv)

```bash
roslaunch simulation_adv run.launch
```

**✅ What you should see:**
```
... process[rosmaster-1]: started with pid [xxx]
... process[rosout-1]: started with pid [xxx]
... started core service [/rosmaster]
```
ROS is now running. Keep this terminal open.

**❌ What went wrong in your test:**
```
RLException: [run.launch] is neither a launch file in package [simulation_adv]
```
This means you forgot Step 3 (source the workspace). The fix is always:
```bash
source /opt/ros/melodic/setup.bash
source /project/mmsl_simulation/devel/setup.bash
roslaunch simulation_adv run.launch
```

#### Do I still need to edit the launch file by hand?

**No.** The `roslaunch` command supports inline argument overrides:

```bash
roslaunch scenario_search single_parameterized_scenario_search.launch \
  batch_id:=1 \
  sampling_suggestion_api:=http://localhost:9009
```

`batch_id:=1` overrides the default in the file without editing it. Mission Control API uses exactly this command — it fills in the batch ID from whatever batch you opened in the Dashboard.

> **The launch file default `batch_id` (currently 3) only matters if you run `roslaunch` with no overrides.** As long as you either pass `batch_id:=N` on the command line, or use Mission Control, you never need to edit the file.

After this, Mission Control health check will show:
```json
"ros": { "available": true, "ros_master_alive": true, "node_count": 8 }
```
And the "Run Simulation" button becomes enabled (if Docker + Sampling + Payload are also green).

> **On your laptop (without sdc-bionic image):**  
> Docker chip shows ❌, "Run Simulation" button is disabled with tooltip "Docker not available on this machine".  
> This is correct — esmini simulations can only run on the lab PC where the image is installed.

---

### 1g. Quick verification — check all services at once

**Run this single command to verify everything is running:**

```bash
echo "=== Service Status ===" && \
echo -n "Dashboard  (3000): " && (ss -tlnp | grep -q ':3000 ' && echo "✅ Running" || echo "❌ NOT running") && \
echo -n "Payload    (3020): " && (curl -s -o /dev/null -w "%{http_code}" http://localhost:3020/api/batches | grep -q 200 && echo "✅ Running" || echo "❌ NOT running") && \
echo -n "Sampling   (9009): " && (ss -tlnp | grep -q ':9009 ' && echo "✅ Running" || echo "❌ NOT running") && \
echo -n "Analyzer   (9010): " && (ss -tlnp | grep -q ':9010 ' && echo "✅ Running" || echo "❌ NOT running") && \
echo -n "Mission Control (8282): " && (ss -tlnp | grep -q ':8282 ' && echo "✅ Running" || echo "❌ NOT running - START THIS!")
```

**Expected output when all services are running:**
```
=== Service Status ===
Dashboard  (3000): ✅ Running
Payload    (3020): ✅ Running
Sampling   (9009): ✅ Running
Analyzer   (9010): ✅ Running
Mission Control (8282): ✅ Running
```

**If Mission Control shows ❌ NOT running**, you missed step 1e. Go back and start it:
```bash
conda activate sampling
cd /home/carlos11/Downloads/code/LAB/41_Git/gpl-odd-project/app/simulation/src
litestar run --port 8282 --host 0.0.0.0
```

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
| "Run Simulation" button is grey with "Docker not available" tooltip | Mission Control API not running — port 8282 unreachable | Start Terminal 5: `conda activate sampling && cd app/simulation/src && litestar run --port 8282 --host 0.0.0.0` |
| "Run Simulation" button still grey after starting API | Docker chip ❌ — docker-py not installed | `conda activate sampling && pip install docker` then restart MC API |
| `curl: (7) Failed to connect to localhost port 8282` | Mission Control API not running | Start Terminal 5 |
| All health chips red | Mission Control API not started | Start Terminal 5 |
| `http://140.113.208.174:3000` times out or is refused | SSH firewall blocks direct IP | Use SSH port forwarding: `ssh -L 3000:localhost:3000 -L 8282:localhost:8282 ...` then open `http://localhost:3000` |
| `roslaunch simulation_adv run.launch` → "is neither a launch file" | ROS workspace not sourced | Inside container: `source /opt/ros/melodic/setup.bash && source /project/mmsl_simulation/devel/setup.bash` |
| Status stuck at STARTING | Sampling not responding | `conda activate sampling && litestar run --port 9009` |
| Payload chip red | Payload CMS stopped | `cd app/payload && docker compose up -d` |
| Trials not appearing in scatter plot | Dashboard cache | Refresh the batch page (F5) |
| CSV count ≠ Payload count | dat2csv incomplete / Payload POST failed | Check logs; re-run the failed trials |
| Container status "not_found" | sdc-bionic image not present | Run on the ITRI lab server where image is installed |
| Need different batch_id without editing launch file | Use CLI override | `roslaunch scenario_search single_parameterized_scenario_search.launch batch_id:=2` |

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
