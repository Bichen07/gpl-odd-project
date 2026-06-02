# Open issues & directions to verify

Only **unresolved** problems and **decisions still to make**. Explained behaviour and fixes already documented in `README.md` are **not** duplicated here.

---

## 1. New simulations: batch `samplingUrl` is often `null`

Simulator workers expect the batch record to point at a running sampling server. If `samplingUrl` is empty, the search loop may not get suggestions.

**Direction:** Set `samplingUrl` in Payload Admin before Goal B, or confirm with senior how lab machines configure this.

---

## 2. Goal B blocked without ITRI `sdc-docker` image

Running new simulations needs the lab Docker/ROS stack and image access.

**Direction:** Obtain image / machine access from supervisor.

---

## 3. BEV map still differs from paper / website

Lane boundaries were added; dashed centre markings, junction polish, or wrong `.xodr` variant (`hct_6` vs `hct_6_no_930`) may still explain gaps.

**Direction:** Compare renders using `hct_6_no_930.xodr` from Payload; decide if renderer should draw lane marking types from OpenDRIVE.

---

## 4. `alldatasets/` source of truth

Large exports are gitignored; no single documented shared location.

**Direction:** NAS/shared path or “export from Payload Documents” workflow owned by the lab.

---

## 5. Dashboard “Analysis” sends a very large task grid

`app/dashboard/.../Saves/index.tsx` builds **many** `hdbscan+mfpca` tasks (nested loops over min cluster size, min samples, epsilon, …). One POST can run for a long time or hit browser/proxy timeouts while the UI looks idle.

**Direction:** Confirm with senior whether the full grid is intentional; consider fewer tasks for dev, progress UI, or server-side chunking.

---

## 6. Cluster colours require manual selection

`redux/slices/batch.ts` has auto-select of the first clustering result **commented out** (`selectFirst`), so scatter plots stay black until the user clicks a clustering row.

**Direction:** Product decision — uncomment / restore auto-select vs keep explicit choice.

---

## 7. Analyzer: port already in use (`Errno 98`)

Starting `litestar run --port 9010` twice leaves the first process owning the port; the second exits with **Address already in use**. Only one analyzer should run on 9010.

**Direction:** Operational — see `README.md` § Debugging → port conflict.

---

## 8a. Simulation persists `roadId=0` for non-Ego agents (Phase 1 Bug 2)

`simulation/.../scenario_sampler.py:1405–1410` builds `agent_observation` with
`roadId: 0, laneId: 0, s: 0, t: 0, laneOffset: 0` instead of reading
`agentRow["roadId"]`, `agentRow["laneId"]`, etc. as the Ego block above does.
Verified empirically against batch 2 trial 1234 in lab Payload: every
`agents[*].roadId` and `agents[*].laneId` is `0` while `egoRoadId` is correct.

**Impact:** All historical Observations have lossy agent road-membership.
The analyzer fix in `controller.py` cannot recover this because the data is
already 0 in Payload.

**Direction:**
- Patch the sampler to mirror the Ego block (≈ 6 lines). Cannot regression
  test locally (needs `sdc-docker` — Issue 2). Hold for next lab simulation.
- Until then, Phase 4 SimLabeller reconstructs agent `(road_id, lane_id)`
  spatially from `(x, y)` against `hct_6.xodr` via `XodrParser`.

---

## 8b. Local CSV cache incomplete: only 1206/10200 trials available

**Problem:**
- **Payload (lab database)**: 10,200 total trials across 3 datasets
  - Dataset 1 (batch 1): 3,351 trials (Payload IDs 2600-5951)
  - Dataset 2 (batch 2): 2,980 trials (Payload IDs 8135-11165)
  - Dataset 3 (batch 3): 3,869 trials (Payload IDs 6122-13060)
- **Local CSV cache**: Only 1,206 esmini CSV files
  - Batch 1: 1,144 CSVs (trial indices 0-1233, incomplete)
  - Batch 2: 57 CSVs
  - Batch 3: 5 CSVs

**Reason:**
The local workstation only has CSVs from trials that were explicitly downloaded
or generated during development. The full dataset resides on the ITRI lab's
simulation server (ROS + Docker stack) at `140.113.208.174`.

**Workaround for Phase 4:**
1. Use `--trials` flag to manually specify available CSV indices:
   ```bash
   bash scripts/build_llm_dataset.sh dataset1 3 "" --trials "1:100,1:200,1:300"
   ```
2. Or download more CSV files from the lab server if accessible

**To run new simulations** (requires lab environment):
See detailed instructions in Phase 1 of `cluster_interpreter_integration_plan.md`.

---

## 8c. How to run simulations (requires ITRI lab infrastructure)

**Prerequisites (all on lab server `140.113.208.174`):**
1. **ROS Melodic** environment
2. **Docker** with `sdc-bionic` image containing:
   - esmini simulator
   - ROS packages: `itri_msgs`, scenario search nodes
   - Python 2/3 hybrid environment
3. **Payload CMS** (port 3020) with PostgreSQL database
4. **OpenSCENARIO template** (`.xosc`) for the scenario
5. **OpenDRIVE map** (`hct_6.xodr`)

**Data flow for a single trial:**
```
Payload CMS (scenario config + .xosc template + .xodr map)
    ↓ [ROS node queries]
single_parameterized_scenario_search.py
    ↓ [downloads files, calls sampling API]
app/sampling (Litestar, suggests next parameters)
    ↓ [returns {delay: X, speed: Y, ...}]
single_parameterized_scenario_search.py
    ↓ [substitutes params into .xosc template]
    ↓ [writes scenario_<trial>.xosc to disk]
    ↓ [launches esmini via ROS]
esmini (runs simulation, writes .dat binary)
    ↓ [simulation completes]
dat2csv.py --extended --file_refs esmini_<batch>_<trial>.dat
    ↓ [converts to CSV with roadId, laneId, s, t columns]
esmini_<batch>_<trial>.csv
    ↓ [scenario_sampler.py reads CSV]
Payload CMS (writes Observation records via POST /api/observations)
```

**Minimal command to run 1 trial** (inside ROS/Docker environment):
```bash
# 1. Activate ROS
source /opt/ros/melodic/setup.bash
source /project/mmsl_simulation/devel/setup.bash

# 2. Launch simulation (requires roscore + esmini_simulator node running)
rosrun scenario_search single_parameterized_scenario_search.py \
    --batch_id 1 \
    --scenario_id <scenario_payload_id> \
    --sampling_api http://localhost:9009

# This will:
# - Query Payload for scenario config
# - Download .xosc template and .xodr map
# - Call sampling API for parameters
# - Run esmini simulation
# - Convert .dat → CSV
# - Write Observations to Payload
```

**Why we can't run this locally:**
1. The `sdc-bionic` Docker image is proprietary (ITRI internal)
2. `single_parameterized_scenario_search.py` has Python 2/3 incompatibilities
3. Missing ROS packages (`itri_msgs`) not in public repos
4. esmini requires specific configuration for the lab's scenarios

**Current strategy:**
Work with the existing 1,206 cached CSVs for Phase 4 development. Request
additional CSVs from lab colleagues if specific trials are needed.

---

## 8d. Analyzer vs Dashboard Payload URL mismatch

Analyzer reads `PAYLOAD_API` from `app/analyzer/.env`. Dashboard reads `NEXT_PUBLIC_PAYLOAD_API_ADDRESS` from `app/dashboard/.env`. If one points at `localhost:3020` and the other at the lab IP, they operate on **different** databases.

**Direction:** Align both to the same Payload base URL when debugging “empty trials” or failed analysis.

---

## Open questions

| Topic | Owner |
|---|---|
| `sdc-docker` image hosting | Supervisor |
| Shared `alldatasets/` location | Lab |
| Full clustering grid vs faster dev runs | Senior / code owner |
| LLM Phase 4: images + captions vs text-only | Research |
