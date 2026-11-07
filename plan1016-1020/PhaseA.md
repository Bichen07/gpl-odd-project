# Phase A Record — trustworthy single-case collision evidence

**Status:** `accepted — local Phase A scope` (user acceptance, 2026-11-07). The
local Phase-A evidence and visibility/profile-sensitivity implementation is the
accepted basis for Phase B. The previously inspected remote Trial is a different,
unrelated simulator run; it is excluded from this evidence chain, rather than being
a blocker. Its unavailable DAT download matters only if someone later wishes to
preserve or study that separate remote run.

**Started:** 2026-10-26  
**Last updated:** 2026-11-07  
**Phase gate:** Phase A of `1016-1020implement_plan.md`  
**Requirements in scope:** R05–R10, R24  
**Requirements explicitly deferred:** R01–R04, R11, R13–R23, R25–R27  
**Baseline commit:** `7909da0` — partial Phase A capability evidence pipeline  
**Commit(s) for this phase:** pending user acceptance

## 1. Purpose and expected result

Phase A makes an existing single collision case evidence-grounded. Its required proof chain is:

```text
existing persisted Trial event
  → positive-time, observation-linked collision evidence
  → Analyzer processed/capability.yaml
  → Trial.analysisArtifacts path + SHA-256
```

The persisted event may originally have come from a simulator collision callback, but
Phase A does not start Mission Control or create a new simulation. A future simulator
run is only an optional additional check when new data is needed.

For an archived trial that has no persisted collision callback, Phase A may instead
create a **local-only derived card** from a hashed trajectory and deterministic polygon
collision result. It is useful for the single-case demo, but it is not a remote Payload
canonical artifact and it must never be presented as a recorded event.

The resulting capability card is an engineering evidence summary, never a legal-fault, certification, or universal-safety conclusion. A real trial missing perception or run-linked capability evidence must remain `insufficient_data`.

### Phase-A deliverables now separated into three evidence layers

1. **A1 — motion/collision evidence:** derive or retrieve a collision time only from
   a recorded event or a deterministic resolver over a hashed trajectory.
2. **A2 — visibility and profile sensitivity:** write `processed/visibility.yaml`.
   It distinguishes a geometric FOV/range candidate, a clear line-of-sight
   opportunity, and actual `first_detected`. A versioned perception profile can
   support sensitivity calculations but cannot turn into historical detection.
3. **A3 — run-bound perception/control capture (future):** ingest sensor, tracker,
   planner, command, and actuator evidence only from a new, versioned run. This is
   deliberately not backfilled from the archived trajectory.

The local archived case now implements A1 and the A2 artifact contract. A3 and the
remote canonical chain remain unavailable, so the primary verdict remains
`insufficient_data`.

## 2. Scope boundary

### Included

- [x] R05: first perception remains recorded only when an actual sensor event exists; otherwise unavailable. A2 also distinguishes an assumed FOV/range candidate from a clear geometric opportunity.
- [x] R06: deterministic, non-legal engineering capability result and reason codes; profile sensitivity cannot change the primary verdict.
- [ ] R07: run-linked provenance/status preservation (blocked for the archived/remote identity check and A3 run capture).
- [x] R08: road and dynamics missing-data disclosure; line-of-sight requires complete supplied geometry rather than a trajectory-only guess.
- [x] R09: `capability.yaml` and `visibility.yaml` are structured, status-labelled artifacts available for later bounded explanation.
- [x] R10: response-time input is measured only when separately recorded; a profile latency is `assumed`/`configured` sensitivity only.
- [x] R24: read-only capability and visibility artifacts are available for the later Replayer/evidence interface; no overlay is implemented in Phase A.

### Excluded for this phase

- [ ] Actor-local Replayer overlays, LLM/agent tools, Dashboard interaction changes, cross-scenario ODD comparison, model evaluation, and voice.
- [ ] The existing `app/dashboard/.env` and `ScrollWorkspace.tsx` working-tree changes.

### Non-negotiable correctness rules

- [ ] `recorded`, `derived`, `configured`, `assumed`, and `unavailable` remain distinct.
- [ ] A zero or missing collision timestamp is never recorded as collision evidence.
- [ ] No legal-fault, certification, or universal-safety claim is generated.
- [ ] No unrelated working-tree change is included.

### Phase A provenance enforcement and hand-off rules

Phase A is the reference implementation of the cross-phase provenance contract in
the [implementation plan](1016-1020implement_plan.md#121-binding-cross-phase-data-provenance-contract).
The current `capability-card/v1` records a status, source, unit, rationale, and where
applicable a SHA-256. This is not merely documentation: the schema rejects unsupported
statuses, a numeric value without a unit, an unavailable field without a rationale,
and an illustrative assumption profile that tries to change the primary verdict.

| Current field type | Phase A rule now | What a later Phase must preserve |
| --- | --- | --- |
| Recorded batch / future recorded event | Keep Payload record URL/ID; an event also needs positive timestamp and observation relation. | Replayer, LLM, Agent, and export display it as `recorded`, never merely as an unqualified number. |
| Derived collision, speed, or future calculation | Keep source artifact hash and deterministic resolver/method name. | Show `derived`, link inputs, and recompute if upstream evidence changes. |
| Run-bound configuration | Use `configured` only when a trial's captured capability snapshot names the selected config and hash. | Do not treat a current repository default as historical fact. |
| Illustrative profile | Use `assumed`, source/rationale, applicability limitation, and sensitivity result; preserve `primary_verdict_unchanged: true`. | UI/LLM must call it an assumption; Agent cannot use it to make an avoidability or responsibility conclusion. |
| Missing perception, road, or control fact | Use `unavailable`, state why, and name the missing sensor/config/map/log. | No downstream feature may replace it with a proxy or general website value. |

#### Mandatory rule for every future Phase A input

Any new value added to `capability.yaml`, `capabilitySnapshot`, or a later evidence
artifact must include: `key`, numeric `value` plus `unit` when applicable, `status`,
source locator, rationale/applicability, and source SHA-256 for local/versioned files.
A derived value also needs the deterministic method and input references; an assumed
value also needs its citation, sensitivity result, and the measurement that would
replace it. If a later measurement supersedes the current assumption, write a new
artifact/value with a `supersedes` reference and retain this card and its hash.

No future Phase is allowed to pass a raw numeric capability field to the Dashboard,
LLM, agent, or paper/demo export without this metadata. The future acceptance test
must include one case each for `recorded`, `derived`, `assumed`, and `unavailable`.

## 3. Plan-gate verification before code changes

| Check | Result and evidence | Status |
| --- | --- | --- |
| Current baseline inspected | `7909da0` already adds event persistence, schema, card generation, and unit tests. | [x] |
| Event truth flow inspected | `scenario_sampler.py` snapshots callback data; `event_record.py` rejects zero time and maps returned observation IDs. | [x] |
| Artifact persistence gap confirmed | `dataset_builder.py` wrote local `capability.yaml` but did not PATCH `Trials.analysisArtifacts`. | [x] |
| Collision launch control inspected | Existing launch referenced undefined `headless` and hard-coded `disable_collision=true`. | [x] |
| Missing-data/assumption policy confirmed | Perception, measured latency, run-linked capability, grade, friction, lane feasibility, and right-of-way have no recorded source. | [x] |
| Payload/PostgreSQL integration environment inspected | Local Compose services started and a PostgreSQL-backed test passed. | [x] |
| Existing-data acceptance scope confirmed | User does not currently use Mission Control or need new simulation output. Existing-data processing is the Phase A acceptance scope. | [x] |

## 4. Design decisions and sources

| Decision | Alternatives considered | Why this choice | Source / evidence | Effect on implementation |
| --- | --- | --- | --- | --- |
| Persist only canonical cards | Treat every auxiliary output as canonical | A singular Trial artifact field must not be silently overwritten by auxiliary packages. | Implementation plan §5.3 | Canonical medoid path PATCHes Payload; auxiliary output remains local. |
| Relative artifact path + SHA-256 | Store absolute path or only a path | Relative path survives checkout location changes; hash binds the Payload record to bytes. | Phase A plan | Restrict accepted cards to `results/**/capability.yaml`. |
| Explicit analysis context | Infer scenario type from a filename | Filename inference is not a factual scenario archetype. | Meeting R23/R26 constraints | Batch is source-labelled; scenario archetype is unavailable in Phase A. |
| Collision opt-in | Make all search runs collide | Preserves prior safe default while allowing an evidence run. | Existing launch had collision disabled | `disable_collision:=false` is required for acceptance run. |
| Illustrative capability profile | Treat unbound config as the historical trial measurement | The archived trial has no run-bound config, sensor event, or response log. A separately labelled sensitivity profile can demonstrate the interface without changing the engineering verdict. | [Mobileye RSS](https://www.mobileye.com/technology/responsibility-sensitive-safety/), [UN R152](https://unece.org/sites/default/files/2024-04/R152r2E.pdf), and hashed project configuration files | The card keeps `insufficient_data`; all profile values have status `assumed`. |

## 5. File change record

| Change | File or artifact | What changed | Why | Verification | Status |
| --- | --- | --- | --- | --- |
| Added | `plan1016-1020/PhaseA.md` | Phase record, scope, evidence and user checks. | Phase-gated delivery record. | Manual review. | done |
| Added | `app/analyzer/src/capability_persistence.py` | Validates canonical path/hash and PATCHes Payload artifact fields. | Close database round trip. | Persistence unit tests passed. | done |
| Added | `app/analyzer/src/capability_assumptions.py` | Builds a versioned, source-labelled illustrative assumption profile and a stopping-distance sensitivity envelope. | Demonstrate replaceable capability inputs without promoting them to measurements. | Unit test and archived-card output. | done |
| Added | `app/analyzer/src/perception_profiles.py` | Validates a versioned FOV/range/latency profile and hashes its semantic content. | Let a later run use a transparent profile without treating it as historical perception. | Profile unit tests. | done |
| Added | `app/analyzer/src/visibility_analysis.py` | Produces `visibility-evidence/v1`: FOV/range candidate, clear line-of-sight only with complete geometry, and permanently separate first-detection status. | Implement A2 without inventing a sensor event. | Visibility unit tests. | done |
| Modified | `app/analyzer/src/capability_analysis.py` | Adds `analysis_context`, archived `trackId`/`velocity` support, and optional illustrative assumptions. | Preserve context truth and show explicitly separate sensitivity evidence. | Analyzer tests and archived-card generation passed. | done |
| Modified | `app/analyzer/src/capability_schema.py` | Validates batch/archetype context, visibility evidence, and assumption-profile separation. | Reject ambiguous context or a profile that tries to change the primary verdict. | Schema tests passed. | done |
| Modified | `app/analyzer/src/dataset_builder.py` | Persists only Payload-backed canonical cards; writes `visibility.yaml` before the card. | Local card alone is not Phase A proof; manual rebuilds cannot overwrite canonical references. | Code review and tests. | done |
| Modified | `app/analyzer/src/cluster_paths.py`, `app/analyzer/src/controller.py` | Registers `processed/visibility.yaml` and exposes a read-only retrieval route. | Permit later UI/LLM consumption without analysis execution. | Route is code-reviewed; service-level request remains a user check. | done |
| Modified | `simulation/ros/src/scenario_search/launch/single_parameterized_scenario_search.launch` | Declares `headless`; makes collision disable flag explicit and opt-in. | Permit reproducible collision evidence. | `roslaunch --files` resolves all included files in SDC image. | done |
| Modified | `app/analyzer/src/dataset_builder.py` | Adds `--canonical-trial-id` for exactly one manually selected trial; validates its Payload batch and fetches its metadata before persistence. | A fresh one-trial run has no clustering archive but still needs a canonical capability card. | Python compile; real trial pending. | done |
| Added | `app/analyzer/src/tests/test_capability_persistence.py` | Persistence success/failure/path tests. | Verify Payload update boundary. | Passed locally. | done |
| Modified | `app/analyzer/src/tests/test_capability_schema.py` | Context validation coverage. | Reject missing/invalid context status. | Passed locally. | done |
| Added | `scripts/build_phase_a_archived_card.py` | Explicit, local-only archived-trial card builder. | Builds one selected card without calling or modifying Payload. | `trial 12152` command below. | done |
| Modified | `scripts/build_phase_a_archived_card.py` | Writes explicit unavailable visibility evidence by default; optionally accepts versioned profile and geometry files. | Avoid silently treating FOV/range as a fact. | Rebuilt local card and inspected YAML. | done |
| Added | `app/analyzer/src/tests/test_visibility_analysis.py`, `test_perception_profiles.py` | Tests profile validation/hashing, complete-versus-partial geometry, unavailable detection, and no primary-verdict override. | Lock down the A2 truth boundary. | `6 passed` within focused test suite. | done |
| Modified | `scripts/build_phase_a_archived_card.py` | Treats an archive folder's batch label as `unavailable` until its source identity with a Payload run is verified. | Matching IDs/names must not promote archive metadata to a recorded Payload fact. | Rebuilt card and Analyzer tests. | done |
| Added | `results/batch8/6_cluster_s=0.5947/cluster1/trial_12152/processed/capability.yaml` | Existing-case artifact with a derived collision and illustrative assumptions. | Provides an inspectable Phase A demo case. | SHA-256 recorded below. | done |
| Added | `results/batch8/6_cluster_s=0.5947/cluster1/trial_12152/processed/visibility.yaml` | Existing-case visibility artifact with all fields explicitly unavailable because no profile or complete geometry is attached. | Demonstrates the missing-evidence outcome. | SHA-256 recorded below. | done |
| Modified | `app/payload/tests/int/api.int.spec.ts` | PostgreSQL-backed Trial/Event/Artifact round-trip test. | Verify persisted relation and metadata. | `npm run test:int`: 4 tests passed. | done |
| Modified | `app/payload/tests/int/trial-events.int.spec.ts` | Confirms artifact field schema. | Guard contract. | Vitest: 2 tests passed. | done |

### Deletions and migrations

No deletions or migrations are permitted in Phase A.

## 6. Implementation log

| Date/time | Change made | Result | Follow-up / blocker |
| --- | --- | --- | --- |
| 2026-10-26 | Inspected baseline and protected unrelated working-tree changes. | Phase A boundary confirmed. | Do not stage unrelated deleted docs, `.env`, or Dashboard component. |
| 2026-10-26 | Added canonical capability-card persistence and context validation. | Code complete; tests in progress. | Payload/PostgreSQL and ROS/esmini remain required. |
| 2026-10-26 | Ran initial Python test command. | Host `pytest` used Python 3.8; existing pandas import failed because `zoneinfo` is unavailable. | Replaced local card speed lookup with standard-library CSV; rerun tests. |
| 2026-10-26 | Regenerated Payload types and ran schema contract test. | Type generation succeeded; 2 schema-contract tests passed. | Full database test follows. |
| 2026-10-26 | Started local project Payload/PostgreSQL Compose services and ran the full Payload integration suite against PostgreSQL. | 4 tests passed, including recorded event → observation relation → artifact path/hash. A failed first cleanup left two fixture rows; both exact IDs were removed. | Database evidence is complete. |
| 2026-10-26 | Validated Phase A launch in the existing SDC image. | All included ROS launch files resolve with read-only project mounts. | Live-simulator validation is deferred; it is not needed for current existing-data work. |
| 2026-10-26 | Added canonical single-trial Analyzer input. | A selected existing Payload trial can receive a canonical card without needing a saved clustering analysis. | Needs an existing trial ID and its matching CSV index only when the user chooses to demonstrate it. |
| 2026-10-27 | Reconciled archived results with the remote senior Payload. | Remote `trial 12152` is in batch 8, but its Trial record has no events, capability snapshot, or capability artifact. The local archive folder has the same labels, not verified source identity. | Do not PATCH the remote service or call the archive a remote Trial artifact. |
| 2026-10-27 | Queried the remote read-only trajectory endpoint for `trial 12152`. | It returned 106 frames from 0.0–10.4 s for `Ego`, `CuttingIn`, and `Idling`; the local archive is 0.0–14.64 s and derives collision at 14.64 s. | Sources are `different_or_unverified`; never merge their state, collision, gap, or control claims. |
| 2026-10-27 | Queried remote `esminiDats/12161` metadata and attempted the supplied file URL. | Metadata identifies `esmini_8_3309.dat` (1,032,212 bytes), but `GET /api/esminiDats/file/esmini_8_3309.dat` returns HTTP 500. A control check of unrelated batch-8 `Trial 9217 → esminiDats/9224 → esmini_8_0.dat` also returns HTTP 500. | This indicates an upload-storage/service issue rather than a single missing file. Ask the deployment/data owner to recover the upload volume or server error log; Phase A source identity remains blocked. |
| 2026-10-27 | Performed a read-only metadata audit of all 2,978 remote batch-8 Trials. | All 2,978 have an `esminiDat` relation; 0 have persisted `events`, 0 have `capabilitySnapshot`, and 0 have `analysisArtifacts`. | A different batch-8 Trial may provide a different motion trace, but cannot by itself supply the recorded collision/capability provenance missing from this Phase. External ROS/sensor logs could still exist outside Payload. |
| 2026-10-27 | Rebuilt the local-only card for archived `trial_12152` with no remote identity assertion. | Collision remains derived at 14.64 s with `CuttingIn`; Ego collision speed is derived as 2.419 m/s; primary verdict remains `insufficient_data`. | Record the regenerated artifact SHA below; it is local evidence only. |
| 2026-11-07 | Directly compared the local archived trajectory with the public read-only Payload observations for remote `Trials/12152`; no Payload data was changed. | The archive manifest maps its medoid to `batch_id: 9`, `trial_index: 3054`, while remote `Trials/12152` is in `batch: 8`. After aligning the remote observation origin (13.546 s) with local 0.0 s, early Ego positions are close (0.040 m and 0.054 m at the first two frames), but `CuttingIn` has a 2.058 m initial position offset, a different motion-onset time/speed, and the Ego differs by 3.149 m at relative 10.4 s. | These are related scenario/map traces, not the same simulator run. They must remain separate sources; the DAT is no longer needed to decide that they cannot be merged. |
| 2026-11-07 | Implemented A2 deterministic visibility/profile-sensitivity artifacts. | The archived builder wrote `visibility.yaml`; because the archived case has no versioned profile or complete occluder geometry, FOV/range, clear line of sight, and first detection are all `unavailable`. The capability card includes the same visibility status and remains `insufficient_data`. | A future profile must include source/rationale/applicability/hash; clear line of sight also needs complete geometry. This does not establish historical detection. |

## 7. Automated verification

| Layer | Command or test | Expected result | Actual result / artifact | Status |
| --- | --- | --- | --- | --- |
| Unit | Analyzer schema/source/analysis/persistence tests | All Phase A assertions pass, including prohibited legal/certification verdict language and illustrative-profile separation. | `19 passed`. | [x] |
| Unit | Scenario event-record tests | Positive timestamp, mapping, and dedupe assertions pass. | `3 passed`. | [x] |
| Integration | `npm run generate:types` | Payload type generation succeeds. | Passed. | [x] |
| Integration | `npm run test:int` against local Compose PostgreSQL | Schema and Trial event/artifact persistence pass. | `2 files, 4 tests passed`. | [x] |
| Launch validation | `roslaunch --files scenario_search single_parameterized_scenario_search.launch` in `sdc-stage-2:bionic` | Launch resolves without executing simulation. | Included launch files resolved. | [x] |
| Existing-data integration | Payload/PostgreSQL Trial/Event/Artifact round trip | Existing trial structures persist an observation-linked event and artifact reference correctly. | 4 integration tests passed. | [x] |
| Deferred live-simulator check | New ROS/esmini collision → Analyzer output | Optional confirmation when new simulation data collection resumes. | Explicitly deferred by user; not a Phase A blocker. | [x] |
| Negative | Invalid path, missing API key, HTTP failure | No local-only false success. | Persistence unit tests passed. | [x] |
| Existing archived case | `python3 scripts/build_phase_a_archived_card.py … --trial-id 12152` | A local-only card has a derived collision, explicit assumptions, and unchanged primary verdict. | Generated artifact; command recorded below. | [x] |
| Unit | `PYTHONPATH=app/analyzer/src pytest -q …test_visibility_analysis.py …test_perception_profiles.py` | Visibility/profile contract is tested together with the existing capability contract. | `25 passed in 0.21s`. | [x] |

The exact final verification commands were:

```bash
PYTHONPATH=simulation/ros/src/scenario_search/src pytest -q \
  simulation/ros/src/scenario_search/tests/test_event_record.py

PYTHONPATH=app/analyzer/src pytest -q \
  app/analyzer/src/tests/test_capability_schema.py \
  app/analyzer/src/tests/test_capability_sources.py \
  app/analyzer/src/tests/test_capability_analysis.py \
  app/analyzer/src/tests/test_capability_persistence.py \
  app/analyzer/src/tests/test_visibility_analysis.py \
  app/analyzer/src/tests/test_perception_profiles.py

python3 -m py_compile \
  app/analyzer/src/perception_profiles.py \
  app/analyzer/src/visibility_analysis.py \
  app/analyzer/src/capability_analysis.py \
  app/analyzer/src/capability_schema.py \
  app/analyzer/src/dataset_builder.py \
  app/analyzer/src/controller.py \
  scripts/build_phase_a_archived_card.py
```

Results: scenario-event tests **3 passed**; Analyzer tests **25 passed**; compilation
completed with no output. The existing Payload/PostgreSQL integration results remain
recorded above; the A2 change did not alter the Payload schema.

## 8. User acceptance checklist

| # | You can do this | Expected result | Evidence to inspect | Result |
| --- | --- | --- | --- |
| 1 | Inspect the local archived-case card labelled `batch8/trial_12152`. | Collision source/status are visible; the batch identity, perception, and capability gaps remain `unavailable`; the assumption profile is visibly separate; verdict is `insufficient_data`. | [Capability card](../results/batch8/6_cluster_s=0.5947/cluster1/trial_12152/processed/capability.yaml), [action evidence](../results/batch8/6_cluster_s=0.5947/cluster1/trial_12152/processed/action.yaml), and [raw trajectory](../results/batch8/6_cluster_s=0.5947/cluster1/trial_12152/raw/trajectory.csv). | [x] |
| 1a | Inspect the companion visibility artifact. | `first_detected`, `fov_range_opportunity`, and `visibility_opportunity` are all `unavailable`; the reason is visible, not hidden. | [Visibility evidence](../results/batch8/6_cluster_s=0.5947/cluster1/trial_12152/processed/visibility.yaml). | [x] |
| 2 | Retrieve the same card from the read-only Analyzer endpoint. | Endpoint returns the same card; it does not execute analysis. | Endpoint response and SHA-256. | [ ] |
| 3 | Inspect the Payload integration test record or a selected existing trial. | Event has positive time, source, status, and exact observation relationship; artifact path/hash match local card when a real card is built. | Test output / Trial JSON. | [x] |
| 4 | Confirm the Phase record does not claim legal fault or missing values as facts. | Only engineering evidence/status claims are present. | This document and card. | [ ] |

## 9. Not ready to verify yet

| Item | Why not part of this phase | Planned phase / blocker | Current safe behaviour |
| --- | --- | --- | --- |
| First perception time | Existing payload does not store a timestamped sensor/detection event. | Add genuine sensor-event capture only if future simulation work is approved. | `unavailable`; no first-in-range proxy. |
| End-to-end latency | RSS configuration value is not trial measurement. | Requires sensing/decision/actuation timestamps. | `unavailable`. |
| Brake/lateral capability | Files are not yet run-bound to an individual trial. | Requires selected configuration and SHA at runtime. | `unavailable`; verdict remains insufficient. |
| Grade, friction, right-of-way | No per-trial source/provenance. | Map/environment data capture. | `unavailable`; no responsibility inference. |
| Remote/local source identity | The matching batch/trial labels disagree in trajectory duration; the linked remote DAT binary cannot be downloaded. | Recover the remote upload, hash/convert it, and compare the required identity fingerprint. | Keep the remote Payload record and local archive as separate sources. |
| Actor-local Replayer label | Phase B scope. | Phase B only after acceptance. | Existing captions unchanged. |

### 9.1 Remote Payload versus local archive — source-identity check

This check is read-only. It proves that the remote and local sources must **not** be
combined yet; it does not prove either source is incorrect.

| Item | Remote Payload source | Local archive source | Result |
| --- | --- | --- | --- |
| Identifier and source mapping | `Trials/12152`, `batch=8`, `esminiDat=12161` | The directory is named `results/batch8/...`, but its own `manifest.json` and `cluster.json` map the medoid to `trial_id: 12152`, `batch_id: 9`, `trial_index: 3054`. | **Mismatch:** `results/batch8` is an archive/run label, not proof of the Payload batch. The local materializer map points to batch 9/index 3054. |
| Direct motion comparison | Read-only `GET /api/observations` returns 99 persisted observations for remote Trial 12152, with source timestamps 13.546–23.946 s (10.4 s relative duration), actors `Ego`, `CuttingIn`, and `Idling`. | `raw/trajectory.csv` has 148 frames per track from 0.0–14.64 s. | **Mismatch:** duration differs by 4.24 s; no time-axis conversion can make all actor motion match. |
| Aligned Ego motion | At 13.546 and 13.646 s, remote Ego positions are `(588.948, 167.622)` and `(589.248, 167.331)`. | At local 0.0 and 0.1 s, Ego is `(588.982, 167.600)` and `(589.297, 167.308)`. | Early alignment is close (0.040 m, 0.054 m), showing similar map/scenario context; it is not sufficient identity evidence. At relative 10.4 s, Ego differs by 3.149 m. |
| Aligned `CuttingIn` motion | Remote `CuttingIn` first moves at remote 17.506 s (relative 3.96 s) with 3.006 m/s. It starts 2.058 m away from the local actor after the same time-origin alignment. | Local `CuttingIn` first moves at 4.3 s with 2.046 m/s and subsequently uses about 3.416 m/s. | **Mismatch:** dynamic actor initial state, motion timing, and speed differ. This rules out an exact run identity even though the actors share names and a static `Idling` actor/map. |
| Collision evidence | `events: []`; no persisted collision event. | `action.yaml` resolves polygon contact with `CuttingIn` at 14.64 s. | Local collision is `derived`, not a remote recorded event. |
| Linked binary | `esminiDats/12161` says `esmini_8_3309.dat`, 1,032,212 bytes. | No copied DAT file or source SHA is present. | File endpoint returns HTTP 500, so the binary cannot be hashed or converted. An unrelated batch-8 DAT control check also returns HTTP 500, indicating a service/storage issue. |
| Capability metadata | No capability snapshot or artifact fields. | Local `capability.yaml` has derived/assumed/unavailable fields. | Do not write the local card back to the remote Trial. |

**Decision:** `different` for exact-run identity. The local card may cite only its
local trajectory/action files. The remote record may be inspected separately, but its
observations cannot supply detection, gap, command, or collision facts to the local
card. Recovering `esmini_8_3309.dat` remains useful to preserve and inspect the remote
batch-8 source itself, but it cannot reconcile these already mismatching traces.

### 9.2 Data inventory, confirmed gaps, and future capture contract

The word **unavailable** below means “not present in the inspected local archive or
read-only remote Payload responses.” It does not prove that the original simulator,
ROS bag, or the data owner's private storage never contained the value.

| Evidence / field | What was confirmed | How it was checked | What it permits | What it does not permit |
| --- | --- | --- | --- | --- |
| Remote Batch/Trial relation | Payload `Trials/12152` reports `batch: 8` and `esminiDat: 12161`. | Read-only `GET /api/trials/12152?depth=0`. | Identify the remote database records that need recovery. | Prove that a similarly named local archive is the same run. |
| Local archive mapping | The selected local medoid is explicitly `batch_id: 9`, `trial_index: 3054`, despite the `results/batch8` directory label. | `results/batch8/6_cluster_s=0.5947/manifest.json` and `cluster1/raw/cluster.json`. | Locate the local source identity used when the archive was materialized. | Treat the archive directory name as a recorded Payload batch identity. |
| Remote upload metadata | `esminiDats/12161` reports filename `esmini_8_3309.dat`, 1,032,212 bytes. | Read-only `GET /api/esminiDats/12161?depth=0`. | Identify the requested original binary. | Obtain its bytes, checksum, or motion without a working download. |
| Remote trajectory | The direct observation collection returns 99 persisted frames from 13.546–23.946 s (10.4 s relative duration), with `Ego`, `CuttingIn`, and `Idling` positions, yaw, speed, acceleration, road/lane state, and agent-relative safety fields. | Read-only `GET /api/observations?where[trial][equals]=12152&sort=time`. | Inspect that remote trajectory independently and compare it numerically with a local archive. | Establish first detection, occlusion, planner reasoning, or a persisted collision event. |
| Local/remote trajectory comparison | Same early Ego path context, but differing `CuttingIn` position, motion onset, speed, later Ego position, duration, and local source batch/index. | Align remote 13.546 s to local 0.0 s and compare all available actor fields. | Conclude that these sources cannot be merged into one Phase-A evidence chain. | Infer a remote collision/event from the local derived collision at 14.64 s. |
| Remote collision/capability fields | `events` is empty; `capabilitySnapshot` and `analysisArtifacts` are absent. | Same Trial record and trajectory response. | State that remote recorded collision/capability evidence is unavailable through the inspected API. | Substitute the local polygon-derived collision or an assumed capability value. |
| Batch-8 Trial coverage | All 2,978 batch-8 Trial records have `esminiDat`; none has `events`, `capabilitySnapshot`, or `analysisArtifacts`. | Read-only all-record metadata audit with only these fields selected. | Rule out a hidden complete Phase-A card/event inside the inspected remote batch. | Rule out separate ROS bags, sensor logs, or offline exports held outside Payload. |
| Local motion archive | `raw/trajectory.csv` contains `trackId`, `time`, `x`, `y`, `velocity`, `heading`, `road_id`, `lane_id`, `lane_offset`, and `s`; three tracks span 0.0–14.64 s. | Header and CSV duration/track-count inspection. | Derive actual motion, distance/heading relations, lane state, and deterministic polygon contact from this file alone. | Identify sensor detections, traffic-right rules, friction, controller commands, or the original remote upload. |
| Local collision/action artifact | `action.yaml` resolves a `CuttingIn` collision at 14.64 s; Ego speed at that time is 2.419 m/s. | Deterministic Analyzer polygon resolver over the hashed local CSV. | A local `derived` Replayer marker and motion explanation. | Call it a recorded `esmini_collision` callback or remote Payload event. |
| Perception timeline | No sensor/tracker detection event, actor association, confidence, sensor frame, or detection timestamp is in either inspected source. | Local CSV/action schema and remote Trial/trajectory payload inspection. | Display `first_detected: unavailable`. | Use first-in-range, a generic distance threshold, or geometric proximity as actual detection. |
| Planner/control timeline | Remote frames expose `speedCmd`/`steerCmd` values but no documented command provenance or detect→plan→actuate timestamps; local archive has no command columns. | Returned frame schema and local CSV header inspection. | Flag a missing decision audit trail. | Say the AV chose to accelerate/brake, or assign a planning fault. |
| Vehicle/road capability | Repository RSS/Pacifica files supply reference values, but neither inspected run captures a selected config hash, friction, grade, lane model, or actuator measurement. | Card provenance check and repository-config comparison. | Use separate `assumed` sensitivity rows. | Call any reference value the historical vehicle limit. |

#### Required future simulator evidence (`simulation-evidence/v1` design)

Do not implement this capture until future simulation work is approved. When it is,
one run must persist the following records under a common immutable `run_id`, map
version, configuration hashes, and simulator clock:

| Stream | Minimum fields | Produces / resolves |
| --- | --- | --- |
| `simulator_ground_truth` | simulator actor ID, pose, dimensions, velocity, map/frame, simulator time, simulator/config hash, and source publisher identity | A reference world-state stream for actor association and false-positive/false-negative evaluation. It is **not** a perception event and cannot resolve first detection. |
| `perception_event` | `sim_time`, `sensor_time`, `actor_id`, ground-truth association ID, `detected|tracked|lost`, confidence, sensor frame, range/bearing, and sensor/config hash | Recorded first detection and a detection-time gap. |
| `planner_event` | `sim_time`, input snapshot hash, predicted actor IDs, selected trajectory/mode, planned acceleration/steering, safety constraint result, planner version | Whether the planner had the actor in its input and which manoeuvre it selected. |
| `control_event` | `sim_time`, command issue time, target brake/throttle/steering, actuator feedback time, measured acceleration/steering, controller version | Sensing/planning/actuation delay and command-versus-motion comparison. |
| `vehicle_capability_snapshot` | selected vehicle/config path, SHA-256, brake/longitudinal/lateral limits, calibration version, status `configured` | Run-bound limits, distinguished from a current repository default. |
| `road_environment_snapshot` | map path/SHA-256, road segment/lane geometry, grade method/value, friction source/value, weather/surface assumption if any | Valid road/lane inputs or explicit `unavailable` fields. |
| `collision_event` | positive simulator time, partner actor, observation ID, callback source/version | Recorded collision source linked to the exact observation. |

Only after these streams have compatible timestamps and verified source identity may the
system derive: first-detection gap, response budget, braking/steering feasibility, or
a **candidate engineering issue**. It still must not issue a legal-fault or
certification conclusion.

#### Perception-source audit and model-selection decision (2026-11 research update)

Static source inspection found that the existing ROS `scenario` package advertises
`detected_objects`, while `scenario_simulator.cpp` appends every agent from
`mAgentManager->GetAgents()` before the publisher converts their state into
`itri_msgs/DetectedObjectArray`. The accident recorder configuration lists this
topic, and the recorder can write a rosbag. This is a promising capture mechanism,
but the inspected code establishes only a simulator-world-state path. It does not
establish camera/LiDAR/radar visibility, occlusion, confidence, an ADS detector, or
a historical detection timestamp.

Therefore a future run must record two separately named streams, never one
ambiguous `detected_objects` evidence source:

```text
simulator_ground_truth      # simulator knows actor state
ads_perception              # evaluated detector/tracker emitted object/track
```

The first captures `source.kind: simulator_ground_truth`; the second can carry
`source.kind: perception_pipeline` and may supply `first_detected: recorded` only
after its publisher, message type, clock, configuration hash, and actor-association
method are documented. A live ROS-graph audit is required before implementing an
adapter because the topic name alone does not establish origin.

The planned model-selection order is: (1) retain current archived cases as
perception `unavailable`; (2) capture actual simulator/ADS perception output if it
exists; (3) optionally use esmini's ideal FOV/near/far mechanism as a labelled
visibility sensitivity profile; (4) only with calibration data consider a
perception-error model; and (5) treat a CARLA/AWSIM plus Autoware sensor/perception
stack as a separate, high-cost validation pilot. ASAM OSI's distinction between
GroundTruth and SensorData provides the intended contract; esmini's own documentation
states that sensor models are out of scope. See the linked model comparison and
sources in [1027meeting.md](1027meeting.md#perception-model-review-and-proposed-project-plan-future-data-capture-no-historical-backfill).

This is a documented future-data plan, not a reopening of the archived-data Phase A
closeout and not a claim that the current `trial_12152` source contains perception
evidence.

### 9.3 Archived local case `batch8` directory label / `batch9` source mapping — illustrative-assumption evidence

The local artifact is deliberately not persisted to the remote senior Payload. It uses
the archived `trajectory.csv` and `action.yaml`; its collision time is therefore
`derived` from `analyzer_polygon_resolver`, not recorded from a simulator callback.

#### Evidence index

- Candidate remote record, deliberately **not** used as local-card provenance: [Payload Trial 12152](https://gpl-odd-payloadcms.chiu41.com/admin/collections/trials/12152) and [read-only API record](https://gpl-odd-payloadcms.chiu41.com/api/trials/12152?depth=0)
- Generated local evidence: [capability.yaml](../results/batch8/6_cluster_s=0.5947/cluster1/trial_12152/processed/capability.yaml)
- Derived collision source: [action.yaml](../results/batch8/6_cluster_s=0.5947/cluster1/trial_12152/processed/action.yaml) and [trajectory.csv](../results/batch8/6_cluster_s=0.5947/cluster1/trial_12152/raw/trajectory.csv)
- Assumption inputs: [RSS parameters](../simulation/ros/src/rss/data/parameters.yaml) and [Pacifica parameters](../sdc/vehicle-configuration/pacifica-1/parameters.yaml)
- Reproduction command: [build_phase_a_archived_card.py](../scripts/build_phase_a_archived_card.py)

```bash
python3 scripts/build_phase_a_archived_card.py \
  --trial-id 12152 --archive-batch-label 8 \
  --trajectory results/batch8/6_cluster_s=0.5947/cluster1/trial_12152/raw/trajectory.csv \
  --action results/batch8/6_cluster_s=0.5947/cluster1/trial_12152/processed/action.yaml \
  --output results/batch8/6_cluster_s=0.5947/cluster1/trial_12152/processed/capability.yaml
```

The card's `illustrative_assumptions` profile is versioned
`phase-a-illustrative-assumptions/v1` and records these values as `assumed`:

| Input | Value(s) | Why included | What it does **not** mean |
| --- | --- | --- | --- |
| Brake deceleration | 5.0 m/s² | UN R152 specifies this braking demand in its relevant AEBS test. | It does not show this vehicle is approved, compliant, or capable of that braking in this case. |
| Brake deceleration | 8.2 m/s² | Current project RSS config `ego_vehicle_dynamics.alphaLon.brakeMax`; file SHA is in the card. | It does not prove that configuration governed this historical run. |
| Response time | 0.05 s and 0.5 s | Existing project RSS config offers a fast ego setting and a deliberately alternate sensitivity setting; Mobileye RSS motivates explicit response/braking assumptions. | Neither is a measured sensing-to-actuation latency. |
| Lateral acceleration | 2.5 m/s² | Current Pacifica parameter file; file SHA is in the card. | It does not establish lateral avoidance without lane geometry and controller calibration. |

At the collision-time Ego speed (2.419 m/s), the card reports a straight-line,
response-plus-braking stopping-distance envelope of 0.4778–1.7947 m. It is **not**
an avoidability reconstruction: no detection time, opening gap, friction, grade,
lane geometry, or controller state is recorded. Consequently the primary verdict
remains `insufficient_data`.

The current local-only card SHA-256 is
`4c3ea2c4fe4b6c2acf035630a1547a28ad093264d9162d979dc4781a6898e0b5`.
Its companion `visibility.yaml` SHA-256 is
`6e329a68132f0819ea9ab8189d9a5bc785123dd00170f48d7c764e6f56deda7f`.
Both were rebuilt at 2026-11-07T12:11Z. Re-running the builder updates
`generated_at`, so new artifacts must be re-hashed and their new hashes recorded
before any future canonical persistence.

The present `visibility.yaml` contains no numerical visibility claim:

| Field | Status | Reason | Permitted next use |
| --- | --- | --- | --- |
| `perception.first_detected` | `unavailable` | The trajectory-only archive contains no timestamped sensor/tracker event. | Tell the reviewer/LLM exactly which log must be captured. |
| `fov_range_opportunity` | `unavailable` | No versioned FOV/range profile was supplied. | Compare profiles only after their source, applicability, units, and hash are recorded. |
| `visibility_opportunity` | `unavailable` | No versioned profile or complete occluder geometry was supplied. | Recompute from a complete map/obstacle artifact; never infer from position alone. |

### 9.4 Capability-card value index and permitted use

The following table is a readable index of the current
[`capability.yaml`](../results/batch8/6_cluster_s=0.5947/cluster1/trial_12152/processed/capability.yaml).
It is deliberately more explicit than a prose LLM prompt: a later UI or agent can
display the same status next to each number.

| Card field | Current value | Status and direct source | May be used for | Must **not** be used for |
| --- | --- | --- | --- | --- |
| `analysis_context.batch_id` | no value | `unavailable` in the card itself; the archive path says `batch8`, while its manifest maps the local medoid to batch 9/index 3054 and the remote Trial is batch 8. | Show the provenance gap and keep the local card separate. | Linking the local archive to remote Trial 12152 or calling batch 8 a recorded card fact. |
| `collision.time` | 14.64 s; actor `CuttingIn` | `derived`; [action](../results/batch8/6_cluster_s=0.5947/cluster1/trial_12152/processed/action.yaml) and hashed [trajectory](../results/batch8/6_cluster_s=0.5947/cluster1/trial_12152/raw/trajectory.csv) resolved by `analyzer_polygon_resolver`. | Replayer event marker, collision-focused narrative, and selecting a trajectory window. | Calling it a recorded simulator callback or using it as first-perception time. |
| `ego_speed_at_collision` | 2.419 m/s | `derived`; nearest Ego sample in the hashed [trajectory](../results/batch8/6_cluster_s=0.5947/cluster1/trial_12152/raw/trajectory.csv). | Show collision-context speed and initialise the illustrative stop-distance envelope. | Reconstructing the earlier decision state or AV braking response. |
| `first_detected`, `perception_time_s` | no value | `unavailable`; no sensor event. | Show an explicit data gap and request sensor logs. | A first-in-range proxy or a perception-failure claim. |
| `response_delay_s` | no value | `unavailable`; no sensing/planning/actuation timestamps. | Show the missing response-budget component. | Equating the RSS configuration with measured end-to-end latency. |
| `emergency_brake_mps2`, `lateral_limit_mps2` | no value | `unavailable`; no run-bound configuration/calibration. | Show inputs required before a real avoidability calculation. | A claim about this trial vehicle's actual physical limit. |
| grade, friction, right-of-way, lane geometry | no value | `unavailable`; no per-trial source. | Show why road-context and lateral analysis are deferred. | Legal responsibility or a lateral-avoidance conclusion. |

#### Illustrative assumptions and sensitivity values

These values are in `illustrative_assumptions`, not in the primary evidence inputs.
They are all `assumed`, remain replaceable, and cannot change the primary
`insufficient_data` verdict.

| Assumption | Value | Source | Appropriate use | Boundary |
| --- | --- | --- | --- | --- |
| AEBS braking-demand benchmark | 5.0 m/s² | [UN R152](https://unece.org/sites/default/files/2024-04/R152r2E.pdf) | Lower comparison point in a sensitivity chart. | A regulation test requirement; not proof of this vehicle's capability, approval, or compliance. |
| Project RSS brake maximum | 8.2 m/s² | [RSS parameters](../simulation/ros/src/rss/data/parameters.yaml), SHA `1c5fea…f2eed4` | Upper project-config comparison point. | Not linked to this archived run. |
| Project RSS response value | 0.05 s | [RSS parameters](../simulation/ros/src/rss/data/parameters.yaml), same SHA | Fast illustrative response input. | Not measured sensing-to-actuation latency. |
| Alternate response value | 0.5 s | [RSS parameters](../simulation/ros/src/rss/data/parameters.yaml), same SHA | Sensitivity comparison against a slower response. | Not a measurement for Ego. |
| Pacifica lateral value | 2.5 m/s² | [Pacifica parameters](../sdc/vehicle-configuration/pacifica-1/parameters.yaml), SHA `0ab906…6ec3f6` | Show a future required input for lateral manoeuvre analysis. | Cannot establish lateral feasibility without lane geometry and controller calibration. |
| Straight-line response-plus-braking envelope | 0.4778–1.7947 m at 2.419 m/s | The four rows in the [capability card](../results/batch8/6_cluster_s=0.5947/cluster1/trial_12152/processed/capability.yaml); method `v × response_time + v² / (2 × brake_deceleration)` | An explanatory sensitivity table or chart. | Not a pre-collision gap, braking reconstruction, collision-avoidability result, or responsibility result. |

#### How the system may use the values

1. **Replayer / Dashboard:** render a collision marker at 14.64 s, identify `Ego` and
   `CuttingIn`, and expose the derived speed, assumptions, sources, and data gaps in
   an inspectable side card.
2. **LLM explanation:** quote only the structured status-labelled values. It may say
   “under the illustrative envelope” and propose the missing next measurement; it
   must not convert the envelope into fault or avoidability language.
3. **Future deterministic capability calculation:** use `evaluate_avoidability()` only
   after a recorded first-detection timestamp, an appropriate pre-collision gap,
   measured or run-bound response/capability values, and valid lane/road inputs are
   supplied. The assumptions can then be retained as comparison cases, never silently
   substituted for those measurements.
4. **Research comparison:** [Mobileye RSS](https://www.mobileye.com/technology/responsibility-sensitive-safety/)
   is suitable background for making response time and braking assumptions explicit.
   It is not a source for this vehicle's numerical capability. A vehicle-specific,
   scenario-comparable test report or run-bound calibration has higher evidential
   priority than any regulation or vendor website.

## 10. Exit evidence and user decision

### Required exit checklist

- [x] Event helper and PostgreSQL integration enforce positive time and correct observation relation; an existing real trial can be checked when selected.
- [x] Database round trip stores canonical card path/hash.
- [x] All automated checks have actual outcomes, including environment limitations.
- [x] User accepted the local Phase-A scope and explicitly deferred the unrelated remote record (2026-11-07).
- [x] Unfinished live-simulator verification is explicitly deferred.
- [x] A local, derived archived-case card and a companion `visibility.yaml` with visibly separate assumptions/evidence gaps exist.
- [ ] A separate Phase A commit is ready and excludes unrelated changes.

### Decision

- [x] **Local Phase A accepted:** user accepted the local-derived A1/A2 scope on 2026-11-07. Phase B may now begin, using only local status-labelled evidence.
- [x] **External remote record deferred:** remote `Trial 12152` is not the source of this local archive. It is excluded, not missing Phase-A evidence. Do not merge it or write local artifacts to it.
- [ ] **Separate remote-data follow-up (optional):** recover its DAT/export only if the team later wants to study that independent remote batch-8 run.
