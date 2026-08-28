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
