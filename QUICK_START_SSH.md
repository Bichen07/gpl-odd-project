# Quick Start Guide for SSH Users

**Your situation:** Running simulations via SSH on remote server

---

## 🚀 Fastest Path to Running a Simulation

### Step 1: Connect with Port Forwarding (Optional, for Payload Admin UI)

```bash
# On your LOCAL computer
ssh -L 3020:localhost:3020 carlos11@<server-ip>

# This lets you access http://localhost:3020/admin in your LOCAL browser
```

### Step 2: Start Services (4 Terminals)

**Open 4 SSH terminals or use tmux**

#### Terminal 1: Payload (Start First)
```bash
cd /home/carlos11/Downloads/code/LAB/41_Git/gpl-odd-project/app/payload
docker compose up -d

# Wait 30 seconds
docker ps | grep payload  # Should show 2 containers running
```

#### Terminal 2: Sampling API (Start Second)
```bash
cd /home/carlos11/Downloads/code/LAB/41_Git/gpl-odd-project/app/sampling/src
conda activate sampling
litestar run --port 9009 --host 0.0.0.0 --debug

# Leave running - you'll see: "Uvicorn running on http://0.0.0.0:9009"
```

#### Terminal 3: Simulation (Start Third)
```bash
cd /home/carlos11/Downloads/code/LAB/41_Git/gpl-odd-project
sdc-docker-enter-container-shell

# Inside container:
source /project/mmsl_simulation/devel/setup.bash
roslaunch simulation_adv run.launch

# Leave running - ignore RViz errors, wait for:
# "[EgoWrapper] Wait for service route_mission_handler..."
```

#### Terminal 4: Run Trial (Start Last)
```bash
cd /home/carlos11/Downloads/code/LAB/41_Git/gpl-odd-project
sdc-docker-enter-container-shell

# Inside container:
source /project/mmsl_simulation/devel/setup.bash

# Run 1 simulation trial
rosrun scenario_search single_parameterized_scenario_search.py \
    --batch_id 1 \
    --scenario_id 1 \
    --sampling_api http://localhost:9009

# This will download files, run esmini, generate CSV
# Takes ~30-60 seconds per trial
```

---

## ✅ How to Know It's Working

### Terminal 1 (Payload):
```
✔ Container payload-postgres-1  Running
✔ Container payload-payload-1   Running
```

### Terminal 2 (Sampling):
```
INFO:     Uvicorn running on http://0.0.0.0:9009
INFO:     Application startup complete
```

### Terminal 3 (Simulation):
```
[INFO] [EgoWrapper] Wait for service route_mission_handler/load_route_by_file_name
(This is normal - simulation is ready and waiting)
```

### Terminal 4 (Trial):
```
Downloading .xosc from Payload...
Calling sampling API for parameters...
Got parameters: {"OncomingStartDelay": 7.5, "OncomingSpeed": 9.2}
Launching esmini...
Simulation complete: 18.3 seconds
Converting .dat to CSV...
✅ Wrote esmini_1_<trial>.csv
```

---

## 🎯 What Scenario IDs Mean

| Scenario ID | Name | Description |
|-------------|------|-------------|
| **1** | Drive out Hct Exit | Ego exits intersection, oncoming car from right |
| **2** | Overtake Parking | Ego overtakes parked car, opposite traffic coming |
| **3** | Overtake Cutin | Ego overtakes, another car cuts in |

Use the ID in Terminal 4 command: `--scenario_id 1` (or 2, or 3)

---

## 🛠️ Using tmux (Easier than 4 Windows)

```bash
# SSH to server
ssh carlos11@<server-ip>

# Start tmux session
tmux new -s sim

# Split into 4 panes:
Ctrl+b "    # Split horizontal
Ctrl+b %    # Split vertical
Ctrl+b ↑    # Navigate up
Ctrl+b %    # Split again
Ctrl+b ↓    # Navigate down
Ctrl+b "    # Split again

# You now have 4 panes:
# ┌────────┬────────┐
# │   1    │   2    │
# ├────────┼────────┤
# │   3    │   4    │
# └────────┴────────┘

# Run commands in each pane
# Switch panes: Ctrl+b ↑↓←→

# Detach from tmux: Ctrl+b d
# Reattach later: tmux attach -t sim
```

---

## 📊 Where to Find Output

After running a trial:

```bash
# CSV file (ground truth)
ls -lh simulation/ros/.cache/scenario_search/records/esmini_1_*.csv

# Most recent:
ls -lt simulation/ros/.cache/scenario_search/records/esmini_1_*.csv | head -1

# Check file size (should be 50-500 KB):
du -h simulation/ros/.cache/scenario_search/records/esmini_1_*.csv | tail -5

# View first few lines:
head -20 simulation/ros/.cache/scenario_search/records/esmini_1_<trial>.csv
```

---

## ⚡ Run Phase 4 with Your New CSV

After simulation completes:

```bash
# Use your new trial in Phase 4
cd /home/carlos11/Downloads/code/LAB/41_Git/gpl-odd-project
conda activate analyzer

# If your trial was esmini_1_1234.csv:
bash scripts/build_llm_dataset.sh dataset1 3 "test_new_sim" --trials "1:1234"

# Mix with existing trials:
bash scripts/build_llm_dataset.sh dataset1 8 "mixed_run" \
    --trials "1:100,1:200,1:1234,1:300,1:400,1:500,1:600,1:700"
```

---

## 🐛 Quick Fixes

### "litestar: command not found"
```bash
conda activate sampling
# If fails:
conda create -n sampling python=3.10 -y
conda activate sampling
pip install litestar uvicorn
```

### "Connection refused" (Payload)
```bash
docker compose -f app/payload/docker-compose.yml restart
sleep 30
curl http://localhost:3020/api/health
```

### "No such file: SCENARIO_ID_FROM_PAYLOAD"
```bash
# Don't type "<SCENARIO_ID_FROM_PAYLOAD>" literally!
# Use actual number: 1, 2, or 3

# Get IDs:
curl -s http://localhost:3020/api/scenarios | grep '"id"' | head -3
```

### "Cannot connect to X display" (Terminal 3)
```bash
# This is NORMAL for SSH - simulation still works!
# Just means RViz GUI won't open
# Ignore the error and continue
```

---

## 📖 See Also

- **SIMULATION_GUIDE.md** - Detailed documentation with all options
- **DATA_INVENTORY.md** - Understanding existing data
- **HOW_TO_RUN.md** - Phase 4 LLM dataset building
