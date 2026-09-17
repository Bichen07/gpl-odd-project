# Project Setup

## Prerequisites

- [Node.js](https://nodejs.org/) installed
- [Bun](https://bun.sh/docs/installation) installed

## 1. Setup the Customized `regl-scatterplot` Submodule

> **Note:** The `regl-scatterplot` package has been customized.
> You need to manually install and build it locally before using it in the main project.

```bash
# Navigate to the submodule directory
cd ./third_party/regl-scatterplot

# Install submodule dependencies
npm install

# Build the submodule
npm run build

# Return to the project root
cd ../../
```

## 2. Link Submodule and Install Main Project Dependencies

```bash
# Add the local customized package to your Bun project
bun add ./third_party/regl-scatterplot

# Install main project dependencies
bun install
```

## 3. Build and Run

```bash
# Build the project
bun run build

# Start the project
bun run start
```

---

## Explore performance (`/batch/[id]`) — what we implemented

Work focused on **batch 7** (`lab_casestudy1_twoAVs`) dual-ego paper saves (~3982 trials, ~488 HDBSCAN candidates) and related Clustering Selection / Heatmap / Replayer / Saves behavior.

### Problem (observed on batch 7)

| Symptom | Root cause |
|---------|------------|
| Clustering Selection freezes for seconds on load | Browser re-ran uniqueness over ~**488** HDBSCAN candidates × thousands of trials on the main thread |
| Heatmap / Replayer opened ~**20** cluster panes | Load picked the **first** grid clustering (often high **k**), not a small-k result |
| “k > 8” default did not stick | Eligibility used `clusterInfos` before ready (`k===0` kept all candidates) |
| Heatmap still slow after filter | `heatmap_ordering` Payload Python call **8–15s**; both egos’ PNGs loaded when both AVs selected |
| Two systems mixed in Clustering Selection | Separate UI toggle; should follow Controls → Filtering → **Showing AVs** only |
| **Cluster Counts: 4** showed an empty list | Uniqueness **v1** compared across different **k**; refined k=4 partitions collapsed into earlier k=2/3 “uniques” |
| Switching Clustering Selection freezes / kills the tab | Filtering `reset()` on every `clusterInfo` change rewrote `filteredTrialIds` → Heatmap `toDataURL` recrop + full Replayer WebGL rebuild (dual ego × ~4k trials) |
| No “dataset built” badge on batch 7 after `dataset_builder` | Status API required *all* emb/IC pair packs; incomplete pairs hid preprocess. Folder key also used laggy `clusterInfos` for **k** |

### UX constraints (kept)

- Full trial set still available in Parameter Space / Projection (no pagination that drops trials).
- Full heatmap PNGs still load for the **selected** ego(s).
- Default dock layout unchanged.
- Uniqueness **rule** mostly unchanged (`duplicatedFilterRatio` default `0.005`, algorithm **`perEgoSelection-v2`**). **v2** only compares candidates with the **same** non-noise cluster count.
- High-k clusterings still available via **Show k > 8** (opt-in).
- Raw paper zips are **never overwritten**.

---

### Implementation summary

#### 1. Precomputed uniqueness (analyzer + dashboard)

HDBSCAN grid stays in the save. Uniqueness indices are derived once and stored next to `clustering[]`.

```text
Analyzer /trajectory_analysis
  → HDBSCAN → mfpca[durationMode].clustering[]
  → attach uniqueResultIndices + noiseRatioByIndex + uniquenessMeta
  → analysis.zip / live API (trajectories.json)

Dashboard
  → if fields present + algorithm/ratio match → skip O(N²) loop
  → else compute via shared TS helper (optionally capped at k≤8)

Saves
  → on load of raw zip without fields: ensure uniqueness (k≤8) in memory
  → if computed: auto-save sibling `*.with-uniqueness.zip` (original kept)
  → if sibling already listed: load sibling instead (no recompute)
  → clicking `*.with-uniqueness.zip`: ensure is a no-op
  → manual: Create New → save (named zip + optional selected.json)
```

**Storage** (additive on `Mfpca` inside analysis zip → `trajectories.json`):

```json
{
  "clustering": [ /* ~488 ClusteringResult, unchanged */ ],
  "uniqueResultIndices": [0, 3, 17],
  "noiseRatioByIndex": { "0": 0.02, "3": 0.01 },
  "uniquenessMeta": {
    "duplicatedFilterRatio": 0.005,
    "algorithm": "perEgoSelection-v2",
    "maxClusterCount": 8
  }
}
```

#### 2. Default k ≤ 8 (list + uniqueness + auto-select)

- `DEFAULT_MAX_CLUSTER_COUNT = 8`.
- Count **k from `result.data`** (`clusterCountFromResult`) — do not wait on Redux `clusterInfos`.
- Uniqueness / list skip `k > 8` unless **Show k > 8**.
- On analysis load, `pickPreferredClustering` selects a result with **2 ≤ k ≤ 8** so Heatmap/Replayer do not open ~20 panes.

#### 3. Showing AVs is the only ego filter

- Controls → Filtering → **Showing AVs** → Redux `state.batch.egos`.
- Clustering Selection / Heatmap / Parameter Space / Projection / Replayer all follow `egos`.
- Removed the temporary Clustering Selection ego ToggleButtonGroup.

#### 4. Ego-scoped on-disk results

- `ITRI` → `results/batch{id}`
- `ITRILatest` → `results/batch{id}_ITRILatest`
- `cluster-analysis-status` and `cluster-evaluate` take `?egoName=`.

#### 5. Heatmap / Replayer speed on clustering select

- Load / crop / modes only for `state.batch.egos`.
- If filtered trial count **> 400**, skip Payload `heatmap_ordering` and reuse clustering `trialOrder`.
- Filtering full `reset()` only when **analysis loads**, not on every clustering click.
- Heatmap crops keep canvas pixels (**no `toDataURL` PNG encode**); cache by clustering index.
- Replayer: full WebGL rebuild only when pane **label set** / filter changes; same-k switches only reassign agents.

#### 6. Clustering Selection badges (“Dataset built” / “Analysis done”)

| Badge | Meaning |
|--------|---------|
| **Analysis done** (green) | LLM YAMLs present (`medoid_trial.yaml` / `cluster_summary.yaml`) |
| **Dataset built** (blue) | `dataset_builder` medoid packs with `action.yaml` under `results/batchN/…` |

- Match folder via `k_cluster_s=<sil>` + **task params** + medoid labels (`clusteringMatchesSavedResult`).
- Folder key uses `clusterCountFromResult` (not laggy `clusterInfos`).
- Preprocess/dataset badge: every `clusterN` has `action.yaml`; incomplete emb/IC pairs do **not** hide the badge.
- Labeled rows sort to the **top** of the list.

#### 7. Example dataset build (batch 7, not part of the npm app)

Clustering **index 88** (`hdbscan+mfpca`, minClusterSize=20, minSamples=7, ε=0, silhouette≈0.4804) was built to:

`results/batch7/4_cluster_s=0.4804/`

```bash
conda activate analyzer
export PYTHONPATH="app/analyzer/src:app/llm_pipeline/python"
python3 app/analyzer/src/dataset_builder.py \
  --source payload-save --batch-id 7 --clustering-index 88 \
  --dataset dataset1 --ego-name ITRI \
  --analysis-zip data/paper_casestudies/case1/casestudy1_twoAVs.zip \
  --from-run results/batch7/4_cluster_s=0.4804 \
  --xodr results/map/hct_6.xodr \
  --param-boundaries all --emb-boundaries all
```

---

### Code map (review these)

| What | File | Notes |
|------|------|--------|
| TS uniqueness + k helpers | [`explore/utils/clusteringUniqueness.ts`](src/app/batch/[id]/_tabs/explore/utils/clusteringUniqueness.ts) | `perEgoSelection-v2`, same-k compare; `ensure*` returns `{ analysis, didCompute }`; `*.with-uniqueness` filename helpers |
| Python uniqueness | [`app/analyzer/src/clustering_uniqueness.py`](../analyzer/src/clustering_uniqueness.py) | Parity with TS v2 |
| Analyzer hook | [`app/analyzer/src/controller.py`](../analyzer/src/controller.py) | Attach uniqueness on analysis |
| Analyzer tests | [`app/analyzer/src/tests/test_clustering_uniqueness.py`](../analyzer/src/tests/test_clustering_uniqueness.py) | Collapse / distinct / rank / null / noise |
| `Mfpca` types | [`_shared/graphql/queries/clustering.ts`](src/app/_shared/graphql/queries/clustering.ts) | Optional uniqueness fields |
| Prefer k≤8 on load | [`explore/redux/slices/batch.ts`](src/app/batch/[id]/_tabs/explore/redux/slices/batch.ts) | `pickPreferredClustering` in `setTrajectoryAnalysis` |
| Clustering Selection UI | [`.../PerEgoSelection/index.tsx`](src/app/batch/[id]/_tabs/explore/components/dock/panels/ClusteringSelection/PerEgoSelection/index.tsx) | k≤8, uniqueness, badges, sort by label rank, Show k > 8 |
| Clustering Selection egos | [`.../ClusteringSelection/index.tsx`](src/app/batch/[id]/_tabs/explore/components/dock/panels/ClusteringSelection/index.tsx) | Maps `state.batch.egos` only |
| Showing AVs + select cascade | [`.../Controls/Filtering/index.tsx`](src/app/batch/[id]/_tabs/explore/components/dock/panels/Controls/Filtering/index.tsx) | `setEgos`; full `reset()` only on analysis load |
| Load / auto-save uniqueness | [`.../Saves/index.tsx`](src/app/batch/[id]/_tabs/explore/components/dock/panels/Saves/index.tsx) | Sibling redirect; auto-save `*.with-uniqueness.zip` |
| Heatmap | [`.../Heatmap/index.tsx`](src/app/batch/[id]/_tabs/explore/components/dock/panels/Heatmap/index.tsx) | Ego filter; skip ordering >400; canvas crop cache |
| Replayer | [`.../Replayer/index.tsx`](src/app/batch/[id]/_tabs/explore/components/dock/panels/Replayer/index.tsx) | Pane-key gated WebGL rebuild |
| Results dir helper | [`api/_lib/resultsBatchDir.ts`](src/app/api/_lib/resultsBatchDir.ts) | `resultsBatchDir` / `resolveResultsBatchDir` |
| Status API (badges) | [`api/cluster-analysis-status/route.ts`](src/app/api/cluster-analysis-status/route.ts) | Soft dataset-built check via `action.yaml` |
| Evaluate API | [`api/cluster-evaluate/route.ts`](src/app/api/cluster-evaluate/route.ts) | `?egoName=` |

---

### Effects

| Situation | Behavior |
|-----------|----------|
| New analyzer run | Save/API includes uniqueness fields |
| Load raw paper zip (first time) | Compute uniqueness → auto-save `*.with-uniqueness.zip` |
| Load raw zip when sibling exists | Redirect to sibling → **no** uniqueness recompute |
| Load `*.with-uniqueness.zip` | Fields present → ensure no-op |
| Clustering Selection default | List / uniqueness only **k≤8**; **Show k > 8** to expand |
| Cluster Counts: 4 | Unique k=4 rows appear (v2 same-k uniqueness) |
| Switch between k=4 results | No full filter reset; faster Heatmap/Replayer |
| Built `results/batchN/…` with `action.yaml` | Row shows **Dataset built** and sorts near top |
| LLM YAMLs present | Row shows **Analysis done** |
| Showing AVs = one system | Only that ego in panels |
| Filtered trials > 400 | No slow `heatmap_ordering` round-trip |

---

### How to verify

```bash
# Analyzer uniqueness unit tests
cd app/analyzer/src && python3 -c "
import tests.test_clustering_uniqueness as t
for n in sorted(dir(t)):
    if n.startswith('test_'):
        getattr(t, n)(); print('pass', n)
"
```

Manual (batch 7):

1. Open `http://localhost:3000/batch/7` → Saves → load raw zip **or** `*.with-uniqueness.zip`.
2. First raw load: wait for auto-save toast / new Saves row; later loads of raw or sibling skip recompute.
3. Controls → Filtering → **Showing AVs** → keep one system.
4. Clustering Selection: **k≤8**; Heatmap/Replayer ≤8 panes.
5. **Cluster Counts: 4** → rows appear; switch between them without tab freeze.
6. Row for silhouette ≈0.4804 / minClusterSize 20 / minSamples 7 / ε 0 → **Dataset built** (after `results/batch7/4_cluster_s=0.4804` exists).
7. Optional: **Show k > 8**; Create New → **save** for a named zip.

---

### Optional follow-ups (not implemented)

- Virtualize Clustering Selection list DOM.
- Precompute per-cluster heatmap crop PNGs into the save.
- DOM/`ref` replay playhead (avoid 50ms React `setState` while playing).
- Materialize missing emb/IC pair CSVs for incomplete batch7 boundary packs.
