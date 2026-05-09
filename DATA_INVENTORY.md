# Data Inventory - GPL-ODD Project

## Summary: What Data Exists and Where

This document answers: **"I see ~10,000 trials in Payload, why do we only have ~1,200 CSVs locally?"**

---

## 1. Full Dataset Overview

### Payload CMS Database (lab server `140.113.208.174:3020`)

**Total: 10,200 trials across 3 datasets/batches**

| Dataset | Batch ID | Trial ID Range | Total Trials | Collisions | CSV Files Locally |
|---------|----------|----------------|--------------|------------|-------------------|
| dataset1 | 1 | 2600 - 5951 | 3,351 | 1,426 (42.6%) | **1,144** |
| dataset2 | 2 | 8135 - 11165 | 2,980 | 1,234 (41.4%) | **57** |
| dataset3 | 3 | 6122 - 13060 | 3,869 | 1,771 (45.8%) | **5** |
| **Total** | - | - | **10,200** | **4,431** | **1,206 (11.8%)** |

---

## 2. Why Only 1,206 CSVs Locally?

### Answer: Partial Download/Cache

The **local workstation** only has CSVs from:
1. Trials explicitly downloaded during development
2. Trials generated during local testing (very few, as simulation requires lab infrastructure)

The **full simulation data** (all 10,200 trials) resides on:
- ITRI lab server at `140.113.208.174`
- Inside the ROS/Docker simulation environment
- Path: `/project/mmsl_simulation/.cache/scenario_search/records/`

**This is not a bug or data loss** - it's simply that we're working with a subset.

---

## 3. What Each File Type Contains

### a. `esmini_<batch>_<trial>.csv` (Ground Truth)

**Location:** `simulation/ros/.cache/scenario_search/records/`  
**Count:** 1,206 files locally, 10,200+ on lab server  
**Size:** ~50-500 KB per file  

**Content:** Frame-by-frame simulation recording at 10 Hz

```csv
time, id, name, x, y, z, h, p, r, roadId, laneId, offset, t, s, speed, ...
0.0, 0, Ego, -8.529, 58.296, 0.0, 4.502, 0.0, 0.0, 51, 1, 0.0, 1.750, 57.544, 5.556, ...
0.0, 1, Oncoming, -35.461, 0.622, 0.0, 4.513, 0.0, 0.0, 152, -1, 0.0, -0.646, 62.018, 0.0, ...
```

**✅ Quality:** Contains CORRECT `roadId`/`laneId` for **ALL agents** (Ego + non-Ego)  
**Use:** Phase 4 `csv_roadid_loader.py` reads these directly

---

### b. `alldatasets/dataset<N>/collision.json` (Summary)

**Location:** `alldatasets/dataset1/collision.json`, etc.  
**Count:** 3 files (one per dataset)  
**Size:** ~50-150 KB

**Content:** Trial ID → collision boolean

```json
{
  "2600": false,
  "2601": true,
  "2602": true,
  ...
}
```

**Purpose:** Quick lookup: did trial X result in a collision?  
**Generated from:** Payload database (via analyzer)

---

### c. `alldatasets/dataset<N>/clustering.json` (UMAP Embeddings)

**Location:** `alldatasets/dataset1/clustering.json`  
**Count:** 3 files  
**Size:** 57 MB (dataset1), ~40-60 MB each

**Content:** Trial ID → UMAP/MFPCA embedding vector

```json
{
  "embeddings": {
    "2951": [2.863, -8.754, 4.445, -0.149],
    "2952": [5.494, -9.574, 2.099, -2.338],
    ...
  }
}
```

**Purpose:** Used for clustering visualization in dashboard  
**Generated from:** `controller.py` MFPCA transformation

---

### d. `alldatasets/dataset<N>/selectedClusteringResult_<N>Clusters.json`

**Location:** `alldatasets/dataset1/selectedClusteringResult_3Clusters.json`  
**Count:** Multiple per dataset (2, 3, 4 cluster variants)  
**Size:** ~50 KB

**Content:** Trial ID → cluster label

```json
{
  "task": {"nClusters": 0, "minClusterSize": 20, ...},
  "scores": {"silhouetteScore": 0.585, ...},
  "data": {
    "2951": "2",
    "2952": "2",
    "2953": "1",
    ...
  }
}
```

**Purpose:** HDBSCAN cluster assignments  
**Use:** Phase 4 loads this to find medoid trials

---

### e. `alldatasets/dataset<N>/trajectories.json` (Analyzer Output)

**Location:** `alldatasets/dataset1/trajectories.json`  
**Count:** 3 files  
**Size:** 130+ MB (huge!)

**Content:** Full trajectory JSON per trial (from Payload)

**⚠️ Quality:** Contains **lossy** `roadId=0` for agents due to `scenario_sampler.py` bug  
**Purpose:** Legacy format for dashboard visualization  
**Use:** Phase 4 does NOT use this - we use CSV files instead

---

### f. OpenDRIVE Map Files

**Location:** `simulation/ros/.cache/scenario_search/hct_6.xodr`  
**Count:** 2 variants (`hct_6.xodr`, `hct_6_no_930.xodr`)  
**Size:** 7.3 MB each

**Content:** Road network definition (XML)

```xml
<OpenDRIVE>
  <road id="51" junction="-1">
    <link>
      <predecessor elementType="road" elementId="152"/>
    </link>
    <planView>
      <geometry s="0.0" x="-8.5" y="58.3" hdg="4.5" length="60.0">
        <line/>
      </geometry>
    </planView>
    <lanes>
      ...
    </lanes>
  </road>
  ...
</OpenDRIVE>
```

**Purpose:**  
- Used by esmini during simulation
- Used by Phase 3 BEV renderer to draw lane boundaries
- Used by Phase 4 `assign_agent_road_id()` for spatial fallback

---

### g. OpenSCENARIO Files

**Template (original):**  
- **NOT on this workstation** - must download from Payload
- URL stored in `scenario.openScenarioField.openScenario.url`
- Contains placeholders like `$delay`, `$oncomingSpeed`

**Parameterized (per-trial):**  
- Location: `simulation/ros/.cache/scenario_search/records/scenario_<N>.xosc`
- Count: 1,206 files (one per simulated trial)
- Template with substituted parameters

**Example:**
```xml
<OpenSCENARIO>
  <ParameterDeclarations>
    <ParameterDeclaration name="delay" value="2.5"/>
    <ParameterDeclaration name="oncomingSpeed" value="8.33"/>
  </ParameterDeclarations>
  <Entities>
    <ScenarioObject name="Ego">...</ScenarioObject>
    <ScenarioObject name="Oncoming">...</ScenarioObject>
  </Entities>
  ...
</OpenSCENARIO>
```

**Purpose:** Defines vehicle behaviors, initial positions, trigger conditions

---

## 4. Data Flow Summary

```
Lab Payload CMS (10,200 trials)
    ↓
[Analyzer clustering] → alldatasets/dataset*/clustering.json
    ↓
[This workstation] → Only 1,206 CSV files cached locally
    ↓
[Phase 4 csv_roadid_loader.py] → Reads available CSVs
    ↓
[llm_dataset_builder.py] → Generates LLM-ready outputs
```

---

## 5. How to Get More Data

### Option 1: Download Specific CSV Files

If you need specific trials and have SSH access to `140.113.208.174`:

```bash
# On lab server
cd /project/mmsl_simulation/.cache/scenario_search/records/

# Compress and download
tar czf batch2_csvs.tar.gz esmini_2_*.csv
scp batch2_csvs.tar.gz user@local-workstation:/path/to/gpl-odd-project/simulation/ros/.cache/scenario_search/records/
```

### Option 2: Query Payload API Directly

If Payload is accessible (requires VPN/SSH tunnel):

```bash
# Tunnel to lab Payload
ssh -L 3020:localhost:3020 user@140.113.208.174

# Then use Phase 4 with Payload API (auto-compute medoids)
bash scripts/build_llm_dataset.sh dataset2 5
```

### Option 3: Work with What We Have

**Current approach (recommended for development):**

```bash
# Use manual trial specification
bash scripts/build_llm_dataset.sh dataset1 3 "" --trials "1:100,1:200,1:300"
```

Pick trials from the 1,206 available CSVs.

---

## 6. Quality Assessment

| Data Source | Ego roadId | Agent roadId | Availability |
|-------------|------------|--------------|--------------|
| **Local CSV cache** | ✅ Correct | ✅ Correct | 1,206 trials (12%) |
| **Payload database** | ✅ Correct | ❌ Always 0 | 10,200 trials (100%) |
| **alldatasets/trajectories.json** | ✅ Correct | ❌ Always 0 | 10,200 trials (100%) |

**Recommendation:** Always use `csv_roadid_loader.py` to read local CSVs for Phase 4.

---

## 7. Storage Requirements

| Location | Size | Notes |
|----------|------|-------|
| `simulation/ros/.cache/scenario_search/records/` | ~200 MB | 1,206 CSVs + .xosc files |
| `alldatasets/dataset1/` | ~185 MB | clustering.json (57 MB) + trajectories.json (130 MB) |
| `alldatasets/dataset2/` | ~140 MB | |
| `alldatasets/dataset3/` | ~180 MB | |
| **Total local data** | **~700 MB** | Workable on any modern machine |

Lab server has full dataset: ~6-8 GB (estimated).

---

## 8. Questions?

See also:
- `ISSUES.md` section 8b for missing data explanation
- `cluster_interpreter_integration_plan.md` Phase 1 for data flow details
- `HOW_TO_RUN.md` for working with the existing data
