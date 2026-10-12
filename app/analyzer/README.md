# Analyzer

## Purpose

Service for the Dashboard to analyze trajectories in a batch for
clustering and visualization (MFPCA, UMAP, HDBSCAN).

Also builds **medoid packs** under `results/batch*/…/clusterN/` for LLM analysis:
label actions → narrate → pick BEV stamps → write context markdown.

---

## Pack layout

```text
clusterN/
  raw/          trajectory.csv, cluster.json
  processed/    action.yaml, description.txt, context_medoid.md, context_cluster.md,
                snapshots/, map_overview.jpg
  output/       medoid_trial.yaml, cluster_summary.yaml  (LLM — kept across rebuild)
  highlight_trials/
    outlier_trials/trial_*/
```

Parameter-space packs (`parameter_space_pairs/cA-cB/`): rematerialize rewrites
`process/`, `synced_bev/`, and thin side trials, but **never deletes**
`output/contrast.yaml`. Dropped far pairs archive LLM files under
`parameter_space_pairs/_preserved_llm_output/`.

---

## Artifacts: `action.yaml` vs `description.txt` vs `context_medoid.md`

Not a chain. **`action.yaml` is the hub**; the other two are sibling outputs for
different audiences. See the tree below for where each file is written.

| Artifact | Producer | Consumer | Contents |
|----------|----------|----------|----------|
| **`action.yaml`** | `labeller.py` | description, stamp select, BEV, context | Full machine event log |
| **`description.txt`** | `description.py` | Humans / debug (see note) | Prose of **entire** log (keeps junctions) |
| **`context_medoid.md`** | stamp select + sentences | Medoid LLM (+ BEV JPGs) | Timeline of **selected** stamps only |

Missing an event in `context_medoid.md` ≠ Labeller failure — check filters **F1–F3**
on the tree.

**Note — vs `xosc_gen` (Steps 1 → 2 → 2.5 → LLM):**

| xosc_gen | This project | Same role? |
|----------|--------------|------------|
| Step 1 → `action/*.yaml` | `processed/action.yaml` | **Yes** — machine event log |
| Step 2 → `description/*.txt` | `processed/description.txt` | **Same producer** (narrate from action) |
| Step 2.5 → BEV from action timestamps | BEV from filtered action stamps | **Yes** — images at key times |
| Step 3 LLM reads **description.txt + BEV** | Medoid LLM reads **`context_medoid.md` + BEV** | **Diverged** |

So `description.txt` is **not** the normal medoid LLM text input here (unlike
xosc_gen). It is mainly for **human / debug**. Pipeline may fall back to it only
if `context_medoid.md` (and legacy `context.md`) are missing. Primary LLM timeline =
`context_medoid.md`.

---

## Dataflow map (where filters and stages sit)

Orchestrator: `dataset_builder.py`. Read this tree first; details for `(1)–(4)` and
**F1–F3** are in the sections immediately below.

```text
esmini CSV + map
  │
  ├─ labeller.py (+ collision_vehicle)              ← Step 1
  │     → processed/action.yaml                     FULL event log (source of truth)
  │
  ├─ description.py                                 ← Step 2
  │     → processed/description.txt                 (ENTER/EXIT if map JunctionRoads present)
  │
  └─ conflict_frame_selector.select_action_frames   ← Step 3  (BEV / context stamp set)
        │  inputs: action.yaml + trajectory.csv
        │
        ├─ (1) Collect conflict anchors             → detail: Stage (1)
        ├─ (2) Add ± burst around COLLISION / NEAR_MISS        → detail: Stage (2)
        ├─ (3) Collect agent action boundaries, applying filters:
        │        F1 straight_junction               → detail: Filters
        │        F2 npc_stopped                     (these decide WHICH stamps exist)
        │        F3 npc_collision_mirror
        ├─ (4) Snap t → nearest traj frame; merge stamps < 0.1 s   → detail: Stage (4)
        │
        ├─ tier2_renderer + map_plotter             ← Step 4  (BEV for every selected stamp)
        │     → processed/snapshots/*.jpg
        │     → processed/snapshots/llm_snapshots.json
        │
        └─ format_conflict_timeline_sentences (+ secondary_context)  ← Step 5
              │  secondary-vehicle rule (not a filter)    → detail: Secondary-vehicle rule
              → processed/context_medoid.md         ONLY selected stamps
              → write_cluster_context_md            ← Step 6
                    → processed/context_cluster.md
```

| Step | Input | Code | Output | Why |
|------|-------|------|--------|-----|
| **1** | traj + map + collision meta | `labeller.py` + `collision_vehicle.py` | `action.yaml` | Event source of truth |
| **2** | `action.yaml` (+ traj) | `description.py` | `description.txt` | Human full-log prose |
| **3** | `action.yaml` + traj | `select_action_frames` | Stamp list | Which times get BEV / timeline |
| **4** | stamps + traj + map | `tier2_renderer` + `map_plotter` | `snapshots/*.jpg` | LLM images |
| **5** | stamps + `action.yaml` + traj | timeline sentences + `secondary_context` | `context_medoid.md` | Medoid LLM timeline |
| **6** | cluster meta | `write_cluster_context_md` | `context_cluster.md` | Cluster-summary pack |

### Stage details `(1)–(4)` (inside Step 3)

Stages **add** candidates; **F1–F3** drop some action boundaries.

#### (1) Collect conflict anchors — `_conflict_anchors`

Reads **already-written** `action.yaml` interactions (Labeller computed them in
Step 1). This stage does **not** re-detect — it only turns `key_time` into stamps.

| Type | How Labeller / `collision_vehicle` computes it (Step 1) | Stamp role |
|------|--------------------------------------------------------|------------|
| **`NEAR_MISS`** | Moving NPC; some frame has TTC &lt; 2.5 s while distance is closing. `key_time` = absolute min **center-to-center** distance. Dropped later if `min_distance_m` &gt; 5 m | peak (gets burst) |
| **`COLLISION`** | Trial `collided` KPI / Payload collision event (simulator ground truth). **Polygon gap** ≤ 0.5 m is used only to pick the partner vehicle when the trial is already `collided`; it never creates a collision. `key_time` = contact moment. Also written as Ego (and NPC-mirror) `action: COLLISION` | peak (gets burst) |
| **`CLOSEST_APPROACH`** | Moving NPC whose min **polygon gap** to Ego is &lt; 5 m, and that NPC is not already NEAR_MISS/COLLISION; keep up to 2 closest | interaction (no burst unless it is the only anchor) |

**Polygon gap (clearance):** each vehicle is an oriented rectangle (length × width,
rotated by heading). **Polygon gap** = shortest distance between the two
rectangle outlines (body-to-body), not center-to-center. `0` means the boxes
touch or overlap. Code: `collision_vehicle.polygon_clearance`.

So “Moving NPC with min polygon clearance &lt; 5 m” means: over the trial, the
smallest body-to-body gap between Ego and that moving NPC was under 5 m
(`CONFLICT_RELEVANCE_M`). That is a looser “got close” signal than NEAR_MISS
(which needs closing TTC &lt; 2.5 s).

#### (2) Add ± burst — only around geometry peaks

**Keep this stage.** It is **not** the old time-window filter. Burst **adds** extra
BEV/context samples around a peak; the old window used to **drop** far action stamps.

- Burst types: `COLLISION`, `NEAR_MISS` only (`_BURST_TYPES`).
- Offsets (s): `−2, −1, −0.5, −0.2, 0, +0.2, +0.5, +1` around that peak.
- **`CLOSEST_APPROACH` has no burst fan** because it is a weaker “nearby pass”
  fallback. Exception: if the trial has **no** COLLISION/NEAR_MISS at all, the
  primary fallback anchor gets **one** burst ring.

#### (3) Collect agent action boundaries — `_noise_filtered_action_times`

For each `agents[].actions[]` row that survives **F1–F3**, emit stamps at the
action’s time bounds for the **full trial** (no peak±window cut):

| Action span in `action.yaml` | Stamps emitted |
|------------------------------|----------------|
| Lasts more than ~0 s (`end − start > ε`), e.g. ACCELERATE 1.5→4.6 | **Two:** `{token}_start_{ACTION}` at start, `{token}_end_{ACTION}` at end |
| Instantaneous (`duration ≈ 0`), e.g. ENTER_JUNCTION at one t | **One:** `{token}_{ACTION}` at that t |

Example: Ego ACCELERATE `1.5–4.6` → `ego_start_ACCELERATE` @ 1.5 and
`ego_end_ACCELERATE` @ 4.6 (if not filtered by F1–F3).

#### (4) Snap + merge

- Snap each candidate `t` to nearest trajectory time.
- Within `0.1` s, combine labels; frame `role` priority
  **peak > burst > interaction > action** (lower wins; labels still merged).

| Role | Meaning |
|------|---------|
| **peak** | `COLLISION` / `NEAR_MISS` key_time (or primary fallback that gets a burst) |
| **burst** | Fixed offset sample around that peak (`APPROACH_*` / `POST_*`) |
| **interaction** | Conflict stamp without burst (e.g. `CLOSEST_APPROACH`) |
| **action** | Maneuver boundary (`ego_start_ACCELERATE`, …) |

---

## Filters F1–F3 (detail for names on the tree)

Applied inside `select_action_frames` (stage 3) when building the stamp set, so
they decide which BEV JPGs and timeline lines exist.
**Does not rewrite `action.yaml`.** `description.txt` still sees the full log.

| ID | Name | Drops |
|----|------|-------|
| F1 | `straight_junction` | straight junction enter / exit |
| F2 | `npc_stopped` | non-ego `STOPPED` |
| F3 | `npc_collision_mirror` | NPC-side copy of a `COLLISION` |

**No `npc_idle` filter:** Labeller never emits `MAINTAIN_SPEED` (constant speed is
the implicit baseline between maneuvers; see `taxonomy.Thresholds`). The selector
still skips NPC `MAINTAIN_SPEED` only so that old logs (e.g. batch1) render cleanly.

**Not a filter:** the secondary-vehicle rule (Step 5) removes no stamp and no JPG.
It only decides which extra vehicle is described on a timeline line — see
[Secondary-vehicle rule](#secondary-vehicle-rule-step-5).


**Removed:** former `conflict_time_window` (peak−15 s / peak+8 s). CLI
`--conflict-window-*` no longer affects medoid stamp selection.

#### F1 — `straight_junction`

| | |
|--|--|
| **Drop** | `ENTER_JUNCTION` / `EXIT_JUNCTION` when `intent == GO_STRAIGHT` (default if missing) **and** `\|heading_change_deg\| < 25°` |
| **Keep** | Turning junction: intent ≠ `GO_STRAIGHT` **or** `\|Δheading\| ≥ 25°` |
| **Code** | `_is_straight_junction_action` |

#### F2 — `npc_stopped`

Drop non-ego `STOPPED`. Keep ego `STOPPED`.

#### F3 — `npc_collision_mirror`

For one Ego–NPC crash, Labeller writes **two** `COLLISION` action rows at the
same `t` (same contact, both sides):

| Where | Meaning |
|-------|---------|
| Ego `actions: COLLISION` (with CuttingIn) | Ego’s view of the hit |
| CuttingIn `actions: COLLISION` (with Ego) | **NPC-side mirror** of the same hit |

| | |
|--|--|
| **Drop** | Non-ego (NPC-side) `COLLISION` stamp — duplicate peak / garbled slug |
| **Keep** | Ego `COLLISION` (+ `interactions[]` COLLISION peak) |
| **Note** | This pack only models **Ego-involved** collisions; not NPC–NPC without Ego |

## Secondary-vehicle rule (Step 5)

Context builder only (`secondary_context.py`). The primary conflict vehicle
(from the first COLLISION / NEAR_MISS, else the fallback) is on every line.
Other vehicles are handled in two parts:

| Part | Rule | Code |
|------|------|------|
| Pick (once per trial) | Not Ego, not primary. Qualifies if **≤ 40 m** at trial start, conflict peak, or an Ego deceleration; **or** a collision partner; **or** in Ego's forward corridor (60 m ahead, ±4 m). Rank: collision partner, then smallest boundary gap. Keep **≤ 2**. | `select_secondary_agents` |
| Mention (per line) | A picked vehicle is described on a line only when **≤ 40 m** at that stamp. | `secondary_inline_clauses` |

The BEV crop follows the primary vehicle, so a secondary vehicle can be
off-frame; the text clause is how it still reaches the LLM.

---

## Worked example (`batch8/…/cluster1`)

| `action.yaml` event | In context / BEV? | Why |
|---------------------|-------------------|-----|
| Ego `ENTER_JUNCTION` / `EXIT_JUNCTION` (straight) | **No** | F1 |
| Ego `ACCELERATE` / `DECELERATE` | **Yes** | Passed F1–F3 |
| Ego `TURN_RIGHT` @ 19.0 | **Yes** | Full-trial bounds (no time window) |
| CuttingIn `STOPPED` | **No** | F2 |
| CuttingIn `LANE_CHANGE_*` / `TURN_*` | **Yes** | Passed F1–F3 |
| `NEAR_MISS` + burst | **Yes** | Stages (1)–(2) |

**Removed (do not reintroduce):** `DANGEROUS_CUT_IN` + old `post_peak_cut_in`;
former peak±15/8 time-window filter.

---

## Modules

| Module | Owns |
|--------|------|
| `taxonomy.py` / `labeller.py` | Vocabulary + detection → `action.yaml` |
| `description.py` | Full-log prose → `description.txt` |
| `conflict_frame_selector.py` | Stamp select + medoid timeline sentences |
| `secondary_context.py` | Secondary-vehicle rule on timeline lines |
| `tier2_renderer.py` / `map_plotter.py` | BEV JPGs at selected times |
| `cluster_paths.py` | Nested write / nested-then-flat read |
| `dataset_builder.py` | Orchestrates steps 1–6 |

Code comments may say **Path A** for this action-first pack. There is no BEV
“Path B”. Other docs’ Path A/B (sim GUI, Mission Control, paper export) are unrelated.

---

## Setup

### Install Miniconda

- Follow the steps here: https://docs.anaconda.com/miniconda/

### Create Environment

All dependencies are listed in `environment.yml`. Create the Conda
environment with:

```bash
conda env create -f environment.yml
```

### Configure Payload access

Copy `.env.example` to `.env` in this directory (`app/analyzer/.env`):

```bash
cp .env.example .env
```

Set:

- `PAYLOAD_API` — **base URL only**, e.g. `http://140.113.208.174:3020` (do **not** include `/api`; the code adds `/api/...` paths).
- `PAYLOAD_API_KEY` — same API key as `app/dashboard/.env`.

The Dashboard and Analyzer must point at the **same** Payload instance.

## Run the Server

### Activate Conda Environment

```bash
conda activate analyzer
```

### Start the Server

From `app/analyzer/src`:

```bash
litestar run --port 9010 --debug --host 0.0.0.0 --reload
# Adjust the command arguments if needed
```

Or use `./scripts/start_dev_stack.sh` from the repo root (starts Analyzer on port 9010).

## Start Analyzing from Dashboard

1. Open `http://localhost:3000/batch/<batch_id>` → **Explore**.
2. Open the **Saves** panel → **Create New** → **Analysis**.
3. A progress bar appears while the Analyzer runs (default: ~488 HDBSCAN tasks; can take **15–60+ minutes** for ~200 trials). The Dashboard polls `GET http://localhost:9010/analysis_progress` for live `task N/488` counts — **restart Analyzer** after code updates so this route exists.
4. When complete, open **Clustering Selection** to pick a clustering result.
5. Optional: **save** uploads the analysis JSON to Payload Documents.

**Troubleshooting:** If Analysis fails immediately with HTTP 500, check `logs/dev_stack/analyzer.log` and verify `PAYLOAD_API` in `.env` (no double `/api`). Smoke test:

```bash
curl -X POST http://localhost:9010/trajectory_analysis \
  -H "Content-Type: application/json" \
  -d '{"batchIds":["3"],"framePeriod":0.1,"tasks":[{"method":"hdbscan+mfpca","nClusters":0,"minClusterSize":20,"minSamples":3,"clusterSelectionEpsilon":1.5,"clusterSelectionMethod":"eom"}]}'
```
