# Known Issues & Open Questions

This file tracks all confusing points, known bugs, and open questions discovered while working through the project. Use this to decide what to investigate next.

---

## Issue 1 — Confusion: What is `/schema` and what does `curl` mean?

**Status:** Explanation only — not a bug.

**What happened:** The README says "verify with `curl http://localhost:9010/schema`" but it's unclear what `curl` is and whether to open the URL in a browser.

**Explanation:**
- `curl` is a **terminal command** that fetches a URL and prints the response. It's used for quick checks without opening a browser. For example: `curl http://localhost:9009/schema` prints HTML to the terminal.
- You can also just **open the URL in your browser** — both work the same way.
- The `/schema` page is the **Swagger UI** (a developer tool that auto-generates interactive API docs). You don't use it during normal workflow — it's only for developers who want to manually test an API endpoint.
- **Normal users never need `/schema`.** The dashboard (http://localhost:3000) is the interface you actually use.
- The scary-looking nested fields (`TrajectoryAnalysisRequest`, `ClusteringScores`, `#0 null`) are **OpenAPI type definitions** generated from `@dataclass` in `app/analyzer/src/controller.py` (~1103–1198). See root **README.md → Goal A → "What is `/schema`?"** for a glossary.

**The `/schema` "Try it out" button confusion:** When you clicked "Try it out → Execute" on the `/initialize` endpoint, it correctly showed you a `curl` command as an example. That is what the Swagger UI does — it shows you equivalent commands. The initialize endpoint is meant to be called from the terminal (or by the simulation scripts), not manually from the browser.

---

## Issue 2 — Confusion: When do I need the Sampling Server?

**Status:** Explanation only — not a bug.

**What happened:** The README listed the sampling server as a setup step, making it seem always required.

**Explanation:** The sampling server is **only needed when running new simulations**. It acts as the "brain" that tells the simulator which parameter values to try next. If you are just viewing existing data in the dashboard, you do not start the sampling server at all.

**Recommendation:** Use the simplified two-goal structure in the README. Skip the sampling server entirely if you are only exploring results.

---

## Issue 3 — Batch `samplingUrl` is `null` for all existing batches

**Status:** Open — potential issue if you try to run new simulations.

**What happened:** When checking the Payload API, all 3 batches have `samplingUrl: null`. This means the batch records do not know where the sampling server is.

**Why it matters:** When the simulator starts, it reads the batch to find the sampling server URL. If the URL is null, the simulator cannot suggest parameter values and the simulation loop will fail or get stuck.

**Suggestion:** Before running new simulations, update the batch in the Payload Admin UI:
1. Open http://140.113.208.174:3020/admin → Batches → select your batch
2. Set the `samplingUrl` field to `http://<your-machine-ip>:9009` (use your actual IP, not `localhost`, because the simulator runs inside Docker)
3. Then start the sampling server and initialize it with that batch ID

---

## Issue 4 — Simulation requires ITRI AV Docker image (not publicly available)

**Status:** Hard blocker for new members without the image.

**What happened:** The simulation environment uses a Docker image called `sdc-docker` (ITRI AV stack + ROS). This image is not in the repository and must be obtained separately from the lab.

**Suggestion:**
- Contact your supervisor to get the Docker image.
- Command to pull it (once you have access): `sdc-docker-update-image`
- Without this image, Goal B (running new simulations) is not possible.
- Goal A (viewing existing data) works fine without it.

---

## Issue 5 — Dashboard build is non-obvious (submodule must be built first)

**Status:** Resolved — README now documents this. But can fail on first try.

**What happened:** The dashboard uses a customised `regl-scatterplot` library that lives in `third_party/regl-scatterplot`. This submodule must be built with `npm` before `bun install` can link it. If you run `bun install` first, the submodule is not built yet and the link fails. Running `bun add ./third_party/regl-scatterplot` multiple times creates duplicate entries in `package.json` and corrupts `bun.lock`.

**Fix if you hit this:**
```bash
cd app/dashboard
# Remove corrupted lockfile
rm -f bun.lock
# Remove duplicate lines in package.json if needed (keep only one "regl-scatterplot" entry)
bun install
bun run build
bun run start
```

**Correct order from scratch:**
```bash
cd app/dashboard/third_party/regl-scatterplot
npm install && npm run build
cd ../..
bun install      # do NOT run "bun add ./third_party/..." again
bun run build
bun run start
```

---

## Issue 6 — BEV images missing lane details (partially fixed)

**Status:** Partially resolved.

**What happened:** The initial BEV renderer only drew road reference lines (one thin line per road), not lane boundaries. Compared to the paper's figures, the images looked incomplete.

**Fix applied:** `XodrParser` was rewritten to compute real lane boundary polylines by offsetting the reference line perpendicularly using each lane's width polynomial `w(s) = a + b·s + c·s² + d·s³`. Driving lane boundaries are now drawn in dark gray.

**Remaining issue:** The map still looks different from the paper's visualisation. Possible reasons:
- The paper may use a different `.xodr` file (`hct_6_no_930.xodr` from the Payload server, not `hct_6.xodr` from `alldatasets/`)
- Lane markings (dashed/solid lines at lane centres) are not yet drawn — only lane boundaries
- Junction geometry may not be rendering correctly

**Suggestion:** Try downloading `hct_6_no_930.xodr` from the Payload server and use it as the BEV renderer input:
```bash
curl -o alldatasets/resources/xodr/hct_6_no_930.xodr \
     "http://140.113.208.174:3020/api/openDrives/file/hct_6_no_930.xodr"
bash scripts/run_bev.sh dataset1 3   # then update the xodr path in run_bev.sh
```

---

## Issue 7 — `alldatasets/` is gitignored (large files)

**Status:** By design — but new members need to know where to get these files.

**What happened:** `alldatasets/` contains `trajectories.json` (10–50 MB per batch), `.xodr` map files (7 MB), and clustering results. These are too large for Git and are excluded by `.gitignore`.

**Suggestion:** Store `alldatasets/` on a shared drive or NAS and document the path here.

**Current known location:** Ask your supervisor. Alternatively, download the analysis result from Payload Admin UI:
1. http://140.113.208.174:3020/admin → Batches → Documents → download `analyze.zip`
2. Unzip and place the files under `alldatasets/<dataset_name>/`

---

## Issue 8 — Analyzer re-run regenerates `trajectories.json` with corrected `roadId` values

**Status:** Fixed in code — but you need to re-run the analyzer on existing data to get corrected files.

**What happened:** There was a bug in `app/analyzer/src/controller.py` (lines 1583–1607) where `roadId` was always written as `0` in `trajectories.json`, even though esmini and Payload had the correct values (e.g., 51, 152). This was fixed in Phase 1.

**Action needed:** Re-run the analyzer (click Analyze in the dashboard) on any batch where you need correct `roadId` values. The new `analyze.zip` will have fixed values.

---

## Issue 9 — Sampling Server `400 Not Found` on `/`

**Status:** Not a bug — expected behaviour.

**What happened:** Opening `http://localhost:9009/` in a browser shows:
```json
{"status_code": 404, "detail": "Not Found"}
```
And the terminal shows a long stack trace.

**Explanation:** Litestar API servers do not have a root `/` page. The 404 is correct — there is nothing at `/`. The valid URL is `/schema`. The long stack trace in the terminal is because `--debug` mode is enabled; in production mode it would be a one-line log message.

**Not a problem.** The server is working correctly.

---

## Issue 10 — `bun run start` requires `bun run build` first

**Status:** Explanation only.

**What happened:** Running `bun run start` without first running `bun run build` results in an error like "no .next directory found" or an empty page.

**Explanation:** Next.js production mode (`bun run start`) serves pre-built files from the `.next/` directory. That directory does not exist until you build. `bun run dev` does not require a build (it compiles on the fly) but is slower for daily use.

**Reminder:**
- First time or after code changes: `bun run build` then `bun run start`
- For development with hot reload: `bun run dev` (no build step needed)

---

## Issue 11 — Parameter Space / Projection Space: all points are black

**Status:** Expected behaviour unless you select a clustering run.

**Cause:** Scatter plots take colours from `selectedClusterInfos[egoName]` in Redux. That is only set when you **click one card/row** in the per-ego clustering result list (after **Analyze** completes or after loading a saved ZIP). Until then `clusterInfo` is `null` and the UI falls back to solid black (`ParameterSpace/Plot/index.tsx`, `Legends/index.tsx`).

**Why:** Auto-selecting the first clustering result was implemented but is **commented out** in `batch.ts` (`selectFirst` block near `setTrajectoryAnalysis`).

**Fix:** After analysis loads → open clustering selection panel → click one result → points become colourful. Ensure colour mode is **interaction-cluster** where applicable.

---

## Open Questions

| # | Question | Who to ask |
|---|---|---|
| 1 | Where is the `sdc-docker` Docker image hosted? | Supervisor |
| 2 | What is the correct Payload admin login credentials? | Supervisor |
| 3 | Is there a shared drive with `alldatasets/` for all batches? | Supervisor |
| 4 | Are there more scenarios planned beyond batches 1–3? | Supervisor |
| 5 | Which `.xodr` file should BEV renderer use — `hct_6.xodr` or `hct_6_no_930.xodr`? | Compare outputs |
| 6 | Phase 4 (Context Builder): should LLM receive images + text captions, or text only? | Research decision |
