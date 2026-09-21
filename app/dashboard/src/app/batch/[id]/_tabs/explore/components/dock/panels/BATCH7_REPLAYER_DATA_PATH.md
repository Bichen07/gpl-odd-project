# Why Parameter / Projection match the paper, but Replayer (and BEV) fail on batch 7

This note traces **how Explore actually reads data**, panel by panel.
Batch **8** and **9** look right in Replayer. Batch **7** (paper Case Study 1)
does not. The scatter plots are not “smarter”; they simply **never open the
broken motion files**.

---

## 0. Shared entry: load a saved analysis zip

File: `Saves/index.tsx`

1. User clicks a save on `/batch/7` (paper zip
   `casestudy1_twoAVs.zip` or a `*.with-uniqueness.zip`).
2. Dashboard `GET`s that Payload **document** (JSON or zip).
3. The JSON is one object keyed by ego (`ITRI`, optionally `ITRILatest`).
4. `ensureTrajectoryAnalysisUniqueness(...)` may fill `uniqueResultIndices`.
5. Redux: `batchSlice.actions.setTrajectoryAnalysis(analysis)`.

That Redux blob is the **only** source for Parameter Space and Projection
Space. It is **not** enough for Replayer / LLM BEV.

What the save contains (and does **not** contain):

| Field | Used by | Motion (x,y,yaw)? |
|--------|---------|-------------------|
| `trials[id].parameters` | Parameter Space | no |
| `trials[id].testObjectives` | colors / pass-fail | no |
| `trials[id].esminiDat.filename` | filename hint only | no |
| `mfpca.scores` / clustering `data` | Projection + colors | no |
| `trajectoriesFileinfo.url` | Replayer unzip | yes, **if IDs match** |
| `heatmapFileinfo.url` | Heatmap PNG | n/a |

There is **no** per-trial `observations` / `trajectory` array inside the
analysis JSON. Payload stores motion in a **separate** trajectories zip
(and originally in `esminiDats/*.dat` on senior Payload).

---

## 1. Parameter Space (correct on batch 7 / 8 / 9)

File: `ParameterSpace/Plot/index.tsx`

```
Redux trajectoryAnalysis
  → mfpca.scores keys  = trial ids in this clustering
  → trajectoryAnalysis.trials[trialId].parameters[].value
  → 2D point (param0, param1)
  → cluster color from clusteringResult.data[trialId].label
```

Relevant draw loop:

```1187:1198:gpl-odd-project/app/dashboard/src/app/batch/[id]/_tabs/explore/components/dock/panels/ParameterSpace/Plot/index.tsx
    let trials = batchTrials[egoName];
    if (trajectoryAnalysis != null) {
      trials = [];
      for (const trialId of Object.keys(mfpca?.scores ?? {})) {
        trials.push(trajectoryAnalysis.trials[trialId]);
      }
    }
    // ...
      const point = trial!.parameters.map((p) => p.value ?? 0);
```

**Never reads** `records/esmini_*.csv`. **Never unzips** trajectories.
That is why the graph matches the paper: it is literally the paper save’s
parameter table + labels.

---

## 2. Projection Space (correct on batch 7 / 8 / 9)

File: `ProjectionSpace/Plot/index.tsx`

```
Redux trajectoryAnalysis.mfpca
  → scores[trialId] = FPC vector   (or umapProjections)
  → 2D point (FPC_i, FPC_j)
  → cluster color from clusteringResult.data[trialId].label
```

```972:986:gpl-odd-project/app/dashboard/src/app/batch/[id]/_tabs/explore/components/dock/panels/ProjectionSpace/Plot/index.tsx
    if (plotMode === "FPCs") {
      const mfpcaScores = Object.entries(mfpca.scores ?? {});
      points = mfpcaScores.map(([trialId, scores]) => {
        trialOrder.push(trialId);
        const label = clusteringResult?.data[trialId].label ?? "0";
        // ...
        return [
          ((scores[index0] - bound.x[0]) / (bound.x[1] - bound.x[0])) * 2 - 1.0,
          ((scores[index1] - bound.y[1] /* … */)
```

Again: **embeddings only**. No CSV. Same paper zip as Parameter Space.

---

## 3. Replayer (wrong on batch 7 only)

File: `Replayer/index.tsx`

Replayer is a **two-stage** pipeline. Stage B is what breaks Case Study 1.

### Stage A — unzip Payload trajectories (paper motion, incomplete for CS1)

```654:684:gpl-odd-project/app/dashboard/src/app/batch/[id]/_tabs/explore/components/dock/panels/Replayer/index.tsx
  useEffect(() => {
    async function fetchAndUnzip() {
      // ...
        const url = trajectoryAnalysis[egoName].trajectoriesFileinfo.url;
        const response = await axios.get(url ?? "", { responseType: "arraybuffer" });
        const zip = await JSZip.loadAsync(zipBlob);
        // first *.json inside zip → rawTrajectories-shaped dict keyed by trialId
        updated[egoName] = jsonObject;
      setTrajectories(updated);
    }
    fetchAndUnzip();
  }, [trajectoryAnalysis]);
```

For paper Case Study 1 ITRI, that URL is `trajectories-270.zip`
(mirrored at `data/paper_casestudies/case1/trajectories-270.zip`).

| Case | Analysis trials | Trajectories zip | Overlap | Medoids in zip? |
|------|-----------------|------------------|---------|-----------------|
| CS1 / batch **7** ITRI | ~3982 | `trajectories-270.zip` ~3000 ids | **~88** | **no** (`7746` missing) |
| CS2 / batch **9** | ~2980 | `trajectories-259.zip` | ~2979 | **yes** |
| CS3 / batch **8** | ~3869 | `trajectories-249.zip` | ~3000, medoid present | **yes** |

So on batch 8/9, Stage A already has the **same trial ids** as clustering.
On batch 7, almost every clustered trial — including medoids — is **absent**
from the unzipped dict. Cars that never existed in Stage A cannot be drawn
until Stage B inserts a CSV.

### Stage B — overwrite with local `esmini_*.csv` (always on)

Flag in Replayer:

```687:693:gpl-odd-project/app/dashboard/src/app/batch/[id]/_tabs/explore/components/dock/panels/Replayer/index.tsx
  // true  = Replayer uses config-clipped CSV (same rule as LLM timelines).
  // false = keep Payload / analysis-zip only (sim-upload clip).
  const USE_ANALYSIS_CLIP_CSV = true;
```

When true, after Stage A:

1. **Medoid path** (cluster folder from `/api/cluster-analysis-status`):

   `GET /api/esmini-trajectory?batchId=7&folder=4_cluster_s=0.4804&label=0`

   Route: `app/dashboard/src/app/api/esmini-trajectory/route.ts`

   - Reads `results/batch7/<folder>/cluster0/cluster.json` →
     `medoid.batch_id`, `medoid.trial_index`.
   - Opens
     `simulation/ros/.cache/scenario_search/records/esmini_<batch_id>_<trial_index>.csv`
   - Parses frames, applies `clip_conditions.yaml`, returns
     `{ source: "esmini", trajectory, time, ... }`.
   - Replayer **replaces** `trajectories[ego][medoidTrialId]` with that payload
     even if Stage A had nothing for that id.

2. **Selected-trial path** (click medoid / scatter point):

   Parses `trials[id].esminiDat.filename` with
   `/esmini_(\d+)_(\d+)\.dat/` (does **not** match Payload suffixes
   like `esmini_7_1522-2.dat`), then
   `GET /api/esmini-trajectory?batchId=…&trialId=…&trialIndex=…`
   and overwrites again.

Helper that picks the file:

```405:414:gpl-odd-project/app/dashboard/src/app/api/_lib/esminiTrajectory.ts
  if (opts?.csvBatch != null && opts?.trialIndex != null) {
    const csvPath = path.join(
      records,
      `esmini_${Number(opts.csvBatch)}_${Number(opts.trialIndex)}.csv`,
    );
```

That directory is **local sim cache**, not Payload:

```text
simulation/ros/.cache/scenario_search/records/esmini_<batch>_<index>.csv
```

### Where those CSVs come from (two different worlds)

**Lab batches 1–4 (this machine’s own sims):**

```text
esmini .dat  →  dat2csv.py  →  records/esmini_<batch>_<index>.csv
```

**Paper batches 7–9 (senior Payload):**

```text
Payload document trajectories-*.zip
  → scripts/paper_casestudies/materialize_esmini_csv_from_trajectories.py
  → same records/esmini_<batch>_<index>.csv
```

Materialize maps analysis `esminiDat.filename` → a CSV index, then writes
**only trials that exist as keys in `rawTrajectories.json`**.

For Case Study 1, medoid `7746` is **not** a key in `trajectories-270.zip`.
Materialize therefore never wrote the true motion for that trial.
`esmini_7_1522.csv` on disk is some **other** local/paper leftover that
happens to share the **filename index** `1522` (Payload also used
`esmini_7_1522-2.dat` because `1522` already collided).

Stage B then happily loads that wrong CSV. Replayer (and BEV from
`dataset_builder`) both believe they have “trial 7746”.

Batch 8/9 work because materialize **did** find the medoid ids in their
trajectories zips, so CSV content matches Stage A and the paper Replayer.

---

## 4. End-to-end picture

```text
                    ┌─────────────────────────────────────┐
                    │ Payload save zip (clustering)       │
                    │ parameters + mfpca.scores + labels  │
                    └──────────────┬──────────────────────┘
                                   │
              ┌────────────────────┼────────────────────┐
              ▼                    ▼                    ▼
     Parameter Space      Projection Space         Replayer
     trials.parameters    mfpca.scores        trajectoriesFileinfo.url
              │                    │                    │
              │                    │                    ▼
              │                    │           unzip trajectories-*.zip
              │                    │           (CS1: ~88 / 3982 ids)
              │                    │                    │
              │                    │                    ▼  USE_ANALYSIS_CLIP_CSV
              │                    │           /api/esmini-trajectory
              │                    │                    │
              │                    │                    ▼
              │                    │           records/esmini_7_*.csv
              │                    │           (CS1: wrong / missing motion)
              ▼                    ▼                    ▼
           paper-correct        paper-correct        wrong cars / BEV
```

BEV snapshots under `results/batch7/4_cluster_s=0.4804/` use the **same**
CSV resolver (`csv_roadid_loader` / sidecar `trial_csv_index_map.json`) as
Stage B. Fixing Replayer without regenerating CSVs will not fix BEV, and
the reverse is also true.

---

## 5. Concrete reasons it is wrong (batch 7)

1. **ID namespace split.** Case 1 clustering ids (`7746`, …) live in
   `casestudy1_twoAVs.zip`. Case 1 motion ids live in
   `trajectories-270.zip` (`2951`–`5951`). Almost no overlap.
2. **`USE_ANALYSIS_CLIP_CSV = true` prefers CSV over the zip.** Even the
   88 overlapping trials would be replaced if a CSV exists.
3. **Filename index ≠ unique trial.** Payload `esmini_7_1522-2.dat` and
   sidecar `trial_csv_index_map.json` both collapse to `esmini_7_1522.csv`.
   Two Payload trials share index `1522`.
4. **Local cache is shared across paper cases.** Case 2 materialize also
   writes `esmini_7_*.csv` (senior filenames were still `esmini_7_…` even
   when the lab batch id is 9). Case 1 can load Case 2 / lab leftovers.
5. **Lab Payload does not have trial `7746`.** `/api/trials/7746` 404s.
   `resolveTrialIndex` cannot recover the senior dat. The dashboard cannot
   “just fetch Payload motion” for that id.
6. **Regex drop of `-N` suffix.**
   `/esmini_(\d+)_(\d+)\.dat/` ignores `esmini_7_1522-2.dat` uniqueness.

None of (1)–(6) apply to Parameter / Projection, which never leave the
analysis JSON.

---

## 6. How to solve it

Need **one** motion table keyed by **analysis trial id**, then point both
Replayer Stage B and `dataset_builder` at it.

### Preferred: get the missing trajectories zip from senior Payload

`ITRI.trajectoriesFileinfo` in the save still points at senior:

`https://gpl-odd-payloadcms.chiu41.com/api/documents/file/trajectories-270.zip`

The **mirrored** `data/paper_casestudies/case1/trajectories-270.zip` is
**14.6 MB**; the save’s `filesize` is **~38.8 MB**. The mirror is likely a
**truncated / wrong document** (IDs don’t match ITRI clustering).

If senior is reachable:

1. Re-download the **full** `trajectories-270.zip` referenced by ITRI
   (not a same-named smaller file).
2. Confirm medoids exist as keys:
   `7746`, `8797`, `7898`, `7698` (or current manifest trial_ids).
3. Materialize **into a case1-only prefix or sidecar**, not blindly over
   shared `esmini_7_*.csv` that Case 2 also uses. Example:
   write `esmini_7_<allocatedIndex>.csv` **and** a sidecar that
   `prefer_batch_id=7` wins, **or** write
   `esmini_paper7_<trialId>.csv` and teach the API that name.
4. Rebuild
   `results/batch7/4_cluster_s=0.4804` so BEV uses the new CSVs.
5. Keep `USE_ANALYSIS_CLIP_CSV` on once CSV === paper motion.

### If senior zip still lacks those ids: convert `esminiDats`

Each clustered trial in the analysis JSON has
`esminiDat.url` → senior `/api/esminiDats/file/esmini_7_1522-2.dat`.

1. Download the **suffixed** `.dat` (the `-2` file, not `esmini_7_1522.dat`).
2. Run the same `dat2csv.py` path lab sims use.
3. Store under a **unique** CSV name (never overwrite unsuffixed `1522`).
4. Record `trialId → csv path` in sidecar; wire
   `/api/esmini-trajectory` and `dataset_builder` to that map **before**
   filename parsing.

### Temporary dashboard-only mitigation (does not fix BEV)

Set `USE_ANALYSIS_CLIP_CSV = false` so Replayer keeps Stage A zip only.

- Batch 8/9: still OK (zip has the ids).
- Batch 7: medoids **still missing** from current `trajectories-270.zip`,
  so cars still vanish unless Stage B can insert **correct** CSV.
  This toggle only helps after the **real** zip is restored.

### Do **not** treat as a fix

- Remapping sidecar `prefer_batch_id=7` so medoids point at
  `esmini_7_1522.csv` **without** replacing file contents. That is what
  already happened; BEV still shows the wrong scenario.
- Using lab `/api/trials/:id` for paper trial ids.

---

## 7. Files to change when implementing the real fix

| Piece | File |
|--------|------|
| Replayer Stage A/B | `Replayer/index.tsx` (`USE_ANALYSIS_CLIP_CSV`, medoid ingest) |
| CSV resolve | `app/dashboard/src/app/api/esmini-trajectory/route.ts` |
| CSV parse | `app/dashboard/src/app/api/_lib/esminiTrajectory.ts` |
| Medoid ids in UI | `app/dashboard/src/app/api/cluster-analysis-status/route.ts` |
| BEV / LLM packs | `app/analyzer/src/dataset_builder.py` (`_load_csv_index_sidecar`) |
| Zip → CSV | `scripts/paper_casestudies/materialize_esmini_csv_from_trajectories.py` |

Verification: after a correct CSV exists for analysis id `7746`, Replayer
medoid C0 and
`results/batch7/4_cluster_s=0.4804/cluster0/processed/snapshots/` must show
the same agents as paper Case Study 1 (Ego + Oncoming on the drive-out
geometry), not a Parking / leftover local trial.
