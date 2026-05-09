# Simulation Setup Guide - What You Have vs What You Need

## Executive Summary

**Good news:** ✅ You already have the `sdc-docker` infrastructure set up!  
**Status:** 🟡 Partially ready - missing some data files to run new simulations  
**Recommendation:** You CAN run simulations, but need to request specific files from your senior

## 🖥️ SSH / Terminal Requirements (IMPORTANT!)

**Your situation:** You're connecting via SSH to a remote machine

| Terminal | Requires GUI? | Can use SSH? | Best Tool | Notes |
|----------|---------------|--------------|-----------|-------|
| **Terminal 1** (Simulation) | ⚠️ Partial | ✅ Yes (with X11 forwarding) | **xterm** or `ssh -X` | RViz needs X display (can disable) |
| **Terminal 2** (Sampling) | ❌ No | ✅ Yes | Regular terminal, IDE terminal | Pure Python, no GUI |
| **Terminal 3** (Payload) | ❌ No | ✅ Yes | Regular terminal, IDE terminal | Docker commands only |
| **Terminal 4** (Scenario) | ❌ No | ✅ Yes | Regular terminal, IDE terminal | ROS commands, headless |
| **Browser** (Payload Admin) | ✅ Yes | ✅ Via port forward | Your local browser | Access via `http://localhost:3020/admin` |

**Key point:** You can run ALL terminals via SSH! Only Terminal 1 shows GUI warnings (RViz), but simulation still works in headless mode.

---

## Current Status Assessment

### ✅ What You Already Have (Working!)

| Component | Status | Location/Evidence |
|-----------|--------|-------------------|
| **sdc-docker tools** | ✅ Installed | `/home/carlos11/.local/bin/sdc-docker-*` |
| **Docker images** | ✅ Available | `sdc-stage-2:bionic` (30 GB), `sdc-stage-1:bionic` (30 GB) |
| **Running container** | ✅ Active | Container `sdc-bionic` (up 3 weeks) |
| **ROS workspace** | ✅ Built | `/project/mmsl_simulation` (catkin workspace) |
| **OpenDRIVE map** | ✅ Available | `simulation/ros/.cache/scenario_search/hct_6.xodr` (7.3 MB) |
| **1,206 CSV files** | ✅ Cached | Ground truth from previous simulations |
| **Payload connection** | ✅ Configured | `PAYLOAD_API=http://localhost:3020/api` |

**You're 80% ready to run simulations!**

---

## ❌ What's Missing (Need to Request)

### Critical Missing Item: OpenSCENARIO Template

**What:** The original `.xosc` template file with parameter placeholders  
**Why needed:** Required to generate new trial scenarios  
**Current status:** We only have *parameterized* `.xosc` files (already-run trials)

**Evidence:**
```bash
# We have these (already-parameterized, specific trials):
simulation/ros/.cache/scenario_search/records/scenario_0.xosc
simulation/ros/.cache/scenario_search/records/scenario_100.xosc
...

# We DON'T have this (template with $delay, $oncomingSpeed):
# scenario_template.xosc  ← MISSING!
```

**Where to find it:**
According to the code, it's stored in **Payload CMS** at:
- Database: lab server `140.113.208.174:3020`
- Table: `scenarios` collection
- Field: `openScenarioField.openScenario.url`

---

## What to Ask Your Senior For

### Option 1: Get the Template File (Recommended)

**Request:**
> "Hi [Senior's Name],
> 
> I'm working on the GPL-ODD cluster interpretation pipeline and need to run new simulations for testing. Could you please provide:
> 
> 1. **The OpenSCENARIO template file** (`.xosc`) for the main scenario
>    - The one with parameter placeholders like `$delay`, `$oncomingSpeed`
>    - Used for batches 1, 2, 3 in the existing data
> 
> 2. **The scenario configuration** from Payload:
>    - Scenario ID (from the database)
>    - Parameter bounds (min/max values for delay, speed, etc.)
> 
> I already have:
> - ✅ sdc-docker environment running
> - ✅ hct_6.xodr map file
> - ✅ 1,206 existing CSV files for development
> 
> This will let me generate new trials locally for Phase 4 testing.
> 
> Thanks!"

### Option 2: Get More CSV Files (Alternative)

If your senior says "let's not run new simulations right now," you can ask for:

**Request:**
> "Could you provide more of the existing esmini CSV files from the lab server? Specifically:
> 
> - **Batch 2 CSVs:** Currently I only have 57 out of 2,980 trials
> - **Batch 3 CSVs:** Currently I only have 5 out of 3,869 trials
> 
> Location on lab server: `/project/mmsl_simulation/.cache/scenario_search/records/esmini_*.csv`
> 
> This would let me work with more diverse data for Phase 4 cluster interpretation."

---

## Step-by-Step: How to Run a New Simulation (Once You Have the Template)

### Prerequisites Checklist

- [x] Docker installed
- [x] sdc-docker tools installed (`pip install sdc_docker-*.whl`)
- [x] Docker images pulled (`sdc-stage-2:bionic`)
- [x] Container running (`sdc-bionic`)
- [x] OpenDRIVE map (`hct_6.xodr`)
- [ ] **OpenSCENARIO template** ← GET THIS FROM SENIOR
- [x] Payload CMS accessible (localhost:3020 or SSH tunnel)
- [x] Sampling service running (`app/sampling`, port 9009)

### Quick Test (5 minutes)

**Step 1: Verify Container**
```bash
# Check container is running
docker ps | grep sdc-bionic

# Should show:
# sdc-bionic ... Up 3 weeks
```

**Step 2: Enter Container**
```bash
# Open a terminal and enter the container
sdc-docker-enter-container-shell

# You should see:
# [container] user@sdc-bionic:/project/mmsl_simulation$
```

**Step 3: Verify ROS Environment**
```bash
# Inside container
source /project/mmsl_simulation/devel/setup.bash

# Test
rospack find scenario_search
# Should output: /project/mmsl_simulation/src/scenario_search
```

**Step 4: Check for Template File**
```bash
# Inside container
ls /project/mmsl_simulation/.cache/scenario_search/*.xosc 2>/dev/null

# If empty → need to get template from senior
# If found → you can proceed!
```

### Full Simulation Run (Once Template is Available)

#### 🔧 Setup: SSH Connection & Port Forwarding

**If connecting via SSH** (your current situation):

```bash
# On your LOCAL computer, connect with port forwarding for Payload admin UI
ssh -L 3020:localhost:3020 carlos11@<remote-server-ip>

# This lets you access http://localhost:3020/admin in your LOCAL browser
```

**Alternative: Use existing SSH session** (if already connected):
- All commands below work in regular SSH terminals
- Use **xterm** only if you want to see RViz visualization (optional)

---

#### Terminal Setup Overview

| Terminal | Location | Tool | Command Type |
|----------|----------|------|--------------|
| **Terminal 1** | Inside Docker | xterm (or SSH) | `sdc-docker-enter-container-shell` |
| **Terminal 2** | Host machine | IDE or SSH | Regular bash |
| **Terminal 3** | Host machine | IDE or SSH | Docker commands |
| **Terminal 4** | Inside Docker | xterm (or SSH) | `sdc-docker-enter-container-shell` |

---

#### **Terminal 1: Start Simulation Environment**

**Location:** Inside `sdc-bionic` Docker container  
**Tool:** xterm (if GUI wanted) OR regular SSH terminal (headless)  
**Purpose:** Run ROS simulation nodes

```bash
# Option A: SSH terminal (recommended for headless)
ssh carlos11@<server>
cd /home/carlos11/Downloads/code/LAB/41_Git/gpl-odd-project
sdc-docker-enter-container-shell

# Inside container:
source /project/mmsl_simulation/devel/setup.bash
roslaunch simulation_adv run.launch

# Expected warnings (safe to ignore):
# - "fake_lane_detection: not found" → OK
# - "Could not connect to X display" → OK (RViz, not critical)
# Simulation is running when you see:
# "[EgoWrapper] Wait for service route_mission_handler/load_route_by_file_name"
```

**Option B: With GUI (xterm + X11 forwarding)**
```bash
# Connect with X11 forwarding
ssh -X carlos11@<server>

# Open xterm
xterm &

# In xterm window:
cd /home/carlos11/Downloads/code/LAB/41_Git/gpl-odd-project
sdc-docker-enter-container-shell
source /project/mmsl_simulation/devel/setup.bash
roslaunch simulation_adv run.launch

# RViz window will open (if X11 working)
```

---

#### **Terminal 2: Start Sampling Server (on host)**

**Location:** Host machine (outside Docker)  
**Tool:** IDE terminal (Cursor) OR regular SSH  
**Purpose:** Run Litestar API for parameter suggestions

```bash
# Can use Cursor's built-in terminal OR SSH terminal
cd /home/carlos11/Downloads/code/LAB/41_Git/gpl-odd-project/app/sampling/src

# Activate conda environment
conda activate sampling

# If 'sampling' environment doesn't exist:
conda create -n sampling python=3.10 -y
conda activate sampling
pip install litestar uvicorn python-dotenv

# Start the sampling API
litestar run --port 9009 --host 0.0.0.0 --debug

# Expected output:
# INFO:     Uvicorn running on http://0.0.0.0:9009
# INFO:     Application startup complete
```

**Verify it's working:**
```bash
# In another terminal or browser
curl http://localhost:9009/
# Should return HTML or "Not Found" (server is responding)
```

---

#### **Terminal 3: Start Payload CMS (on host)**

**Location:** Host machine (outside Docker)  
**Tool:** IDE terminal OR regular SSH  
**Purpose:** Run Payload database + web interface

```bash
# Can use Cursor's built-in terminal OR SSH terminal
cd /home/carlos11/Downloads/code/LAB/41_Git/gpl-odd-project/app/payload

# Start Payload containers
docker compose up -d

# Expected output:
# ✔ Container payload-postgres-1  Running
# ✔ Container payload-payload-1   Running

# Verify it's running:
docker ps | grep payload
curl http://localhost:3020/api/health
```

**Access Payload Admin UI:**
1. Open browser on your LOCAL computer
2. Go to: `http://localhost:3020/admin`
3. **Login credentials:** (see "Payload Admin Interface" section below)

---

#### **Terminal 4: Run Scenario Search (simulation trials)**

**Location:** Inside `sdc-bionic` Docker container  
**Tool:** xterm OR regular SSH terminal  
**Purpose:** Run individual simulation trials

```bash
# Open second terminal (SSH or xterm)
cd /home/carlos11/Downloads/code/LAB/41_Git/gpl-odd-project
sdc-docker-enter-container-shell

# Inside container:
source /project/mmsl_simulation/devel/setup.bash

# Get scenario ID from Payload (see "Payload Admin Interface" section)
# Available scenario IDs: 1, 2, or 3

# Run 1 trial for batch 1, scenario 1
rosrun scenario_search single_parameterized_scenario_search.py \
    --batch_id 1 \
    --scenario_id 1 \
    --sampling_api http://localhost:9009

# IMPORTANT: Replace scenario_id with actual number (1, 2, or 3)
# Do NOT use "<SCENARIO_ID_FROM_PAYLOAD>" literally!
```

**Expected output:**
```
Downloading .xosc from Payload...
Downloading .xodr from Payload...
Calling sampling API for parameters...
Got parameters: {"OncomingStartDelay": 7.2, "OncomingSpeed": 10.5}
Substituting into template...
Wrote scenario_<trial>.xosc
Launching esmini...
Simulation complete: 15.3 seconds
Converting .dat to CSV...
Wrote esmini_1_<trial>.csv
Posting observations to Payload...
Done! Trial <trial> complete.
```

---

## 🌐 Payload Admin Interface - Detailed Guide

### Accessing Payload Admin

**Step 1: Ensure Payload is Running**
```bash
# Check containers
docker ps | grep payload

# Should show:
# payload-payload-1   Up X hours   0.0.0.0:3020->3000/tcp
# payload-postgres-1  Up X hours   5432/tcp
```

**Step 2: Access Admin Interface**

**If on the server locally:**
```
URL: http://localhost:3020/admin
```

**If via SSH (your situation):**
```bash
# Method 1: SSH port forwarding (when connecting)
ssh -L 3020:localhost:3020 carlos11@<server-ip>

# Method 2: Dynamic tunnel (if already connected)
# On your LOCAL computer, new terminal:
ssh -N -L 3020:localhost:3020 carlos11@<server-ip>
# Leave this running, then access http://localhost:3020/admin in browser
```

Then open browser: `http://localhost:3020/admin`

---

### Payload Admin Login

**Default credentials** (if first-time setup):
- Email: `admin@example.com`
- Password: Check `app/payload/.env` file

```bash
# On server, check credentials:
cd /home/carlos11/Downloads/code/LAB/41_Git/gpl-odd-project/app/payload
grep PAYLOAD_SECRET .env
grep ADMIN_EMAIL .env

# Or check Docker container logs:
docker logs payload-payload-1 | grep -i "admin\|email\|password"
```

**If no .env file exists**, Payload may be using defaults. Try:
- Email: `test@example.com` or `admin@test.com`
- Password: `test` or check container environment variables

```bash
# Check environment variables:
docker exec payload-payload-1 env | grep -i admin
```

---

### What to Do in Payload Admin

#### 1️⃣ **View Scenarios** (Required for simulation)

**Navigation:** Admin Dashboard → Collections → **Scenarios**

You should see 3 scenarios:
1. **ID: 1** - "Drive out Hct Exit with Oncoming"
2. **ID: 2** - "Overtake Parking with Opposite Oncoming"
3. **ID: 3** - "Overtake cutin"

**For each scenario, note:**
- **Scenario ID** (use this in Terminal 4 command)
- **OpenSCENARIO file** (template .xosc)
- **OpenDRIVE file** (map .xodr)
- **Parameters** (delay range, speed range)

**Screenshot of what you should see:**
```
┌─────────────────────────────────────────────────────┐
│ Scenarios Collection                                │
├─────────────────────────────────────────────────────┤
│ ID │ Name                               │ Status    │
├────┼────────────────────────────────────┼───────────┤
│ 1  │ Drive out Hct Exit with Oncoming  │ published │
│ 2  │ Overtake Parking...                │ published │
│ 3  │ Overtake cutin                     │ published │
└─────────────────────────────────────────────────────┘
```

**Click on a scenario to view details:**
- Parameters section → Min/Max values
- OpenDRIVE field → Map file URL
- OpenSCENARIO field → Template file URL

---

#### 2️⃣ **View Batches** (Optional - check existing data)

**Navigation:** Admin Dashboard → Collections → **Batches**

You should see existing batches:
- **Batch 1** → ~1,144 trials (dataset1)
- **Batch 2** → ~57 trials (dataset2)
- **Batch 3** → ~5 trials (dataset3)

**What this shows:**
- Which scenario each batch uses
- Total number of trials
- Completion status

---

#### 3️⃣ **View Observations** (Optional - inspect trial data)

**Navigation:** Admin Dashboard → Collections → **Observations**

This shows frame-by-frame trajectory data for all trials.

**Useful for:**
- Verifying simulation ran correctly
- Checking if new trials are being recorded
- Inspecting `roadId`/`laneId` values (will see agent roadId=0 bug here)

**Filter by trial:**
```
In Observations page, use filter:
- Field: "trial"
- Operator: "equals"
- Value: <trial_id>
```

---

#### 4️⃣ **View Trials** (Optional - check simulation results)

**Navigation:** Admin Dashboard → Collections → **Trials**

Shows summary of each trial:
- Trial ID
- Batch ID
- Parameters used
- Outcome (collision, TTC, etc.)
- Timestamp

---

### Do You NEED to Login to Admin?

**Short answer: NO, not required for running simulations!**

**When you NEED Payload Admin:**
- ✅ First time setup: verify scenarios exist
- ✅ Get scenario IDs (1, 2, or 3)
- ✅ Download OpenSCENARIO templates (if missing locally)
- ✅ Debug: check if new trials are being recorded
- ✅ Monitor: verify observations are being saved

**When you DON'T need it:**
- ❌ Running simulations (Terminal 4 uses API directly)
- ❌ Viewing existing CSV files (use `ls` command)
- ❌ Phase 4 LLM dataset building (uses CSV files)

**Recommendation:**
1. Login ONCE to verify scenarios exist and get IDs
2. Note down the scenario IDs (1, 2, 3)
3. Use those IDs in Terminal 4 commands
4. Login again only if you need to debug or check results

---

### Quick Payload API Queries (Alternative to Admin UI)

Instead of logging into admin, you can query via API:

```bash
# Get all scenarios
curl -s http://localhost:3020/api/scenarios | jq '.docs[] | {id, name}'

# Output:
# {
#   "id": 1,
#   "name": "Drive out Hct Exit with Oncoming"
# }
# {
#   "id": 2,
#   "name": "Overtake Parking with Opposite Oncoming"
# }
# {
#   "id": 3,
#   "name": "Overtake cutin"
# }

# Get batch info
curl -s http://localhost:3020/api/batches | jq '.docs[] | {id, scenario: .scenario.name}'

# Get recent trials
curl -s "http://localhost:3020/api/trials?limit=5&sort=-createdAt" | jq '.docs[] | {id, batch: .batch.id, createdAt}'
```

---

## 🔍 SSH-Specific Troubleshooting

### Issue: X11 Forwarding Not Working

**Symptom:** `Could not connect to any X display` when running RViz

**Solution 1: Run in Headless Mode (Recommended)**
```bash
# Simulation works fine without GUI!
# Just ignore the RViz errors - simulation nodes are still running
# Check with: rostopic list (should show many topics)
```

**Solution 2: Enable X11 Forwarding**
```bash
# On LOCAL computer:
ssh -X carlos11@<server-ip>

# Test X11:
xeyes  # Should show eyes window

# If xeyes fails:
# 1. Install X11 server on local machine:
#    - Windows: Install VcXsrv or Xming
#    - Mac: Install XQuartz
#    - Linux: X11 usually pre-installed
# 2. Configure X11 forwarding on server:
#    sudo nano /etc/ssh/sshd_config
#    Set: X11Forwarding yes
#    sudo systemctl restart sshd
```

---

### Issue: Port 3020 Already in Use

**Symptom:** Can't access Payload admin, connection refused

**Check if Payload is actually running:**
```bash
docker ps | grep payload
ss -tlnp | grep 3020  # Check what's using port 3020
```

**If Payload not on 3020, check port mapping:**
```bash
docker port payload-payload-1
# Should show: 3000/tcp -> 0.0.0.0:3020

# If different port, use that in SSH forwarding:
ssh -L 3020:localhost:<actual-port> carlos11@<server>
```

---

### Issue: Multiple Terminals Confusing

**Use tmux or screen for better session management:**

```bash
# Install tmux (if not installed)
sudo apt install tmux

# Create new session with 4 panes
tmux new -s simulation

# Split terminal:
Ctrl+b "    # Split horizontally
Ctrl+b %    # Split vertically
Ctrl+b ↑↓←→ # Navigate between panes

# Layout:
# ┌─────────────┬─────────────┐
# │ Terminal 1  │ Terminal 2  │
# │ (sim nodes) │ (sampling)  │
# ├─────────────┼─────────────┤
# │ Terminal 3  │ Terminal 4  │
# │ (payload)   │ (scenario)  │
# └─────────────┴─────────────┘

# Detach: Ctrl+b d
# Reattach: tmux attach -t simulation
```

---

### Issue: Cursor IDE Terminal vs Xterm

**When to use each:**

| Task | Best Tool | Why |
|------|-----------|-----|
| Run sampling server | **Cursor IDE terminal** | Easy to see logs, restart quickly |
| Check Payload | **Cursor IDE terminal** | Simple docker commands |
| Run simulation (Terminal 1) | **xterm** or SSH | May need X11, easier in dedicated window |
| Run trials (Terminal 4) | **SSH terminal** | No GUI needed, can run in background |
| Monitor logs | **Cursor IDE terminal** | Syntax highlighting, search |
| Debug Python | **Cursor IDE terminal** | Integrated debugger access |

**Pro tip:** Use Cursor IDE for Terminals 2 & 3, xterm for Terminals 1 & 4

---

## Troubleshooting Common Issues

### Issue 1: Container Not Running

**Symptom:** `docker: Error response from daemon: Conflict`

**Solution:**
```bash
# Check if container exists
docker ps -a | grep sdc-bionic

# If "Exited" status, restart it:
docker start sdc-bionic

# If "Up" status but having issues, recreate:
sdc-docker-stop-container
sdc-docker-start-container
```

### Issue 2: ROS Packages Not Found

**Symptom:** `rospack find scenario_search` fails

**Solution:**
```bash
# Inside container, rebuild workspace
cd /project/mmsl_simulation
source /opt/ros/melodic/setup.bash
source /repository/ros/install/setup.bash
catkin_make
source devel/setup.bash
```

### Issue 3: Payload Connection Refused

**Symptom:** `Connection refused` when querying Payload

**Solution:**
```bash
# On host machine, start Payload
cd app/payload
docker compose up -d

# Wait 30 seconds, then test
curl http://localhost:3020/api/health
```

### Issue 4: Missing Template Error

**Symptom:** `FileNotFoundError: scenario_template.xosc`

**Solution:** This is expected - you need to get the template from your senior (see "What to Ask" section above).

---

## What Each File Does

### Input Files (What You Need)

| File | Purpose | Example | Where to Get |
|------|---------|---------|--------------|
| `.xosc` template | Scenario definition with parameter placeholders | `$delay = ???` | **FROM SENIOR** (Payload DB) |
| `.xodr` map | Road network geometry | `<road id="51">` | ✅ Already have |
| Scenario config | Parameter bounds, agent configs | `delay: [0.5, 5.0]` | **FROM SENIOR** (Payload DB) |

### Output Files (What Simulation Produces)

| File | Content | Size | Location |
|------|---------|------|----------|
| `scenario_<N>.xosc` | Parameterized scenario | ~15 KB | `records/` |
| `esmini_<batch>_<trial>.dat` | Binary recording | ~5-50 MB | `records/` |
| `esmini_<batch>_<trial>.csv` | ✅ Ground truth CSV | ~50-500 KB | `records/` |

---

## Current Workflow Recommendation

### For Phase 4 Development (Now)

**Use the existing 1,206 CSV files:**
```bash
# Work with what you have
bash scripts/build_llm_dataset.sh dataset1 3 "" --trials "1:100,1:200,1:300"

# Process multiple trials
bash scripts/build_llm_dataset.sh dataset1 8 "" --trials "1:50,1:100,1:150,1:200,1:250,1:300,1:350,1:400"
```

**Advantages:**
- ✅ No setup needed
- ✅ Faster development cycle
- ✅ Known-good data

### For Phase 5+ (Later)

**Once you have the template, run new simulations to:**
1. Test different scenario variations
2. Generate trials for specific edge cases
3. Validate the LLM pipeline end-to-end
4. Ensure `scenario_sampler.py` bug fix works

---

## Decision Matrix: Should You Ask for Template or CSVs?

| If... | Request | Why |
|-------|---------|-----|
| You need to test Phase 4 code changes ASAP | **More CSV files** | Faster, no simulation complexity |
| You want to test new scenario parameters | **Template file** | Required for generating new scenarios |
| You need to validate bug fixes | **Template file** | Must run simulations to test |
| You're blocked on data availability | **More CSV files** | Unblocks work immediately |
| Your senior has limited time | **More CSV files** | Simpler request, one-time transfer |
| You have 1-2 weeks for setup | **Template file** | Worth the investment for future work |

**My recommendation:** Start by asking for **more CSV files** (Option 2) to unblock Phase 4, then request the **template file** (Option 1) once Phase 4 is working well.

---

## Summary: Email Template for Your Senior

```
Subject: GPL-ODD Project - Data Request for Phase 4 Development

Hi [Senior's Name],

I'm implementing Phase 4 (LLM dataset preparation) for the GPL-ODD cluster 
interpreter. I've verified my local environment has:

✅ sdc-docker container running
✅ ROS workspace built
✅ 1,206 CSV files from previous simulations
✅ OpenDRIVE map (hct_6.xodr)

To continue, I need one of the following (prioritized):

Option 1 (Preferred): More existing CSV files
- Batch 2: Need 2,923 more CSVs (currently have 57/2,980)
- Batch 3: Need 3,864 more CSVs (currently have 5/3,869)
- Source: /project/mmsl_simulation/.cache/scenario_search/records/esmini_*.csv
- This will let me process diverse trials for cluster analysis

Option 2 (If feasible): OpenSCENARIO template
- The .xosc template with $delay, $oncomingSpeed placeholders
- Scenario config from Payload (parameter bounds, scenario ID)
- This will let me run new simulations for testing

Could you help with Option 1 (CSV files)? I can work with those immediately 
while we plan Option 2 for later.

Thanks!
[Your Name]
```

---

## Next Steps

1. ✅ Review this guide
2. 🔲 Decide: CSV files (quick) or template (complete)
3. 🔲 Contact your senior with the email template above
4. 🔲 While waiting, continue Phase 4 with existing 1,206 CSVs
5. 🔲 Once you get data, follow the simulation steps above

**You're very close to having a complete setup!**
