# How to Run — gpl-odd-project (Carlos Fork)

This guide explains how to start every service, run tests, and see results
on the website or in the terminal.

---

## Quick Reference

| Service | Port | Command |
|---|---|---|
| Payload CMS (already running) | 3020 | auto-started with Docker |
| Analyzer server | 9010 | see below |
| Sampling server | 9009 | see below |
| Dashboard (web UI) | 3000 | see below |

---

## 1. Start the Analyzer Server

The analyzer processes trajectories, runs MFPCA clustering, and (Phase 2+)
selects cluster medoids.

```bash
conda activate analyzer
cd app/analyzer/src
litestar run --port 9010 --host 0.0.0.0 --debug
```

Verify it is running:
```bash
curl http://localhost:9010/schema
# → should return HTML (Litestar Analyzer Server)
```

---

## 2. Start the Sampling Server

```bash
conda activate sampling
cd app/sampling/src
litestar run --port 9009 --host 0.0.0.0 --debug
```

---

## 3. Open the Dashboard (Web UI)

```bash
cd app/dashboard
bun run start
# → opens at http://localhost:3000
```

Or for development with hot reload:
```bash
bun run dev
```

---

## 4. Re-Run the Analyzer on Existing Data

After the Phase 1 `roadId` fix, you need to re-run the analyzer on your
existing batch to regenerate `trajectories.json` with correct `roadId` values.

1. Open the Dashboard at http://localhost:3000
2. Navigate: **Sessions → your session → your batch**
3. Click the **Save** tab → **Create New** → **Analyze**
4. Wait a few minutes (progress visible in the analyzer terminal)
5. When done, download `analyze.zip` from the batch in Payload Admin UI:
   http://localhost:3020/admin

The new `trajectories.json` inside `analyze.zip` will now have correct
`roadId` values (e.g. 51, 52, 152) instead of 0.

---

## 5. Run Unit Tests

```bash
# Phase 1 — roadId preservation fix (7 tests)
conda activate analyzer
python3 test_roadid_preservation.py

# Phase 2 — cluster medoid selection (9 tests)
conda activate analyzer
python3 test_cluster_medoid.py
```

Expected output: all tests pass with OK at the bottom.

---

## 6. Current Branch Map

```
carlos1  (Bichen07 base — clean, no LFS issues)
  └── fix/roadid-gt-bichen     (Phase 1 — pushed to Bichen07)
  └── feature/cluster-medoid   (Phase 2 — current work)
```

To see which branch you are on:
```bash
git branch
```

To push your work to YOUR fork (Bichen07):
```bash
git push carlos <branch-name>
```

> ⚠️ Never push to `origin` — that is your senior's repo (ian-chiu).

---

## 7. What Each Phase Adds (and Where to See It)

| Phase | What it does | How to see the result |
|---|---|---|
| Phase 1 | Fixes `roadId=0` bug in `controller.py` | Re-run analyzer → `trajectories.json` now has real roadIds |
| Phase 2 | `get_cluster_medoids()` — picks most representative trial per cluster | Terminal: call function after clustering; future: shown in dashboard |
| Phase 3 | BEV renderer — draws top-down map snapshots | New `.jpg` files in `app/llm_pipeline/artifacts/` |
| Phase 4 | SimLabeller — classifies vehicle actions (brake, turn…) | Terminal: `action_log` dict per trial |
| Phase 5 | LLM prompt → cluster interpretation YAML | `app/llm_pipeline/artifacts/stage2b_cluster_interpretation/` |
| Phase 6 | Wire everything into dashboard panel | Dashboard: new "Cluster Interpretation" card beside heatmap |

---

## 8. Payload CMS Admin

- Admin UI: http://localhost:3020/admin
- API root: http://localhost:3020/api
- Key collections: `Batches`, `Trials`, `Observations`, `Documents`

To browse stored roadId values for a specific trial:
```
http://localhost:3020/api/observations?where[trial][equals]=<trial_id>&limit=5
```

---

## 9. Useful Debug Commands

```bash
# Check which services are running
ps aux | grep -E "litestar|next-server|bun" | grep -v grep

# Check cached esmini CSV (ground truth roadId)
head -3 simulation/ros/.cache/scenario_search/records/esmini_1_51.csv

# Count total simulation runs cached
ls simulation/ros/.cache/scenario_search/records/*.csv | wc -l

# Run a quick Python syntax check on controller.py
python3 -c "import ast; ast.parse(open('app/analyzer/src/controller.py').read()); print('OK')"
```

---

## 10. Integration Plan Reference

Full plan with all 7 phases:
```
/home/carlos11/Downloads/code/LAB/41_Git/cluster_interpreter_integration_plan.md
```

Change log:
```
CHANGELOG.md  (in this repo root)
```
