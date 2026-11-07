# Detailed Implementation Plan: Evidence-Grounded Human–AI Visual Analytics

## 1. Purpose, authority, and current baseline

This document converts the 27 requirements in [1016-1020meeting.md](1016-1020meeting.md) into implementation work. It is intentionally more detailed than the phase-gate strategy in [1016-1020meeting_plan.md](1016-1020meeting_plan.md): it specifies the data contracts, Dashboard behaviour, LLM context, file-level changes, alternative designs, test evidence, and expected outcome for each work package.

The meeting record is the requirement authority. The phase plan is the delivery/gate authority. This document does not authorize implementation past a manual phase gate.

### 1.1 Verified baseline

| Area | Current reality | Consequence for this plan |
| --- | --- | --- |
| Behaviour pipeline | `action.yaml`, context, trajectories, conflict windows, BEV artifacts, and a cluster/trial caption already exist. | Reuse them; do not replace them with an image-only model. |
| Replayer | A timestamped/global caption exists; actor-local labels do not. | Build annotations as a new evidence artifact, then render them on the existing Replayer. |
| Collision/capability work | Phase A (`7909da0`) implements conservative event persistence, `capability.yaml`, a capability endpoint, and synthetic tests. | Complete the database round trip before relying on a recorded collision event in a UI/LLM answer. |
| Dashboard state | Redux describes current visual interaction, but no stable AI-facing semantic contract exists. | Build `analysis_state/v1`; do not let a VLM infer hidden state from pixels. |
| LLM | Existing ODD chat retrieves a closed artifact set; Luna is the default provider. | Preserve bounded retrieval, add structured scope routing before adding agents. |
| Agent | No typed policy/approval/audit framework exists. | Add typed, server-controlled tools only after semantic state is stable. |
| ODD | A native run-level kNN boundary export exists. | Retain native dimensions; add a separate canonical comparison layer rather than merge heterogeneous scenarios. |

### 1.2 Non-negotiable scientific and safety constraints

1. `recorded`, `derived`, `configured`, `assumed`, and `unavailable` are different statuses and must remain visible from input to UI to LLM answer.
2. LLMs explain deterministic evidence; they do not calculate collision time, braking feasibility, or a responsibility outcome.
3. The project produces engineering hypotheses and evidence review, never legal fault, certification, or universal safety conclusions.
4. A first perception time, response delay, actual braking limit, road grade/friction, right-of-way, or lane feasibility without a recorded source is `unavailable`, not a proxy or a plausible default.
5. The agent receives no generic shell, arbitrary file, arbitrary URL, browser/computer, raw database, or direct Dashboard-write tool.

### 1.2.1 Binding cross-phase data-provenance contract

Every value that reaches an artifact, Dashboard card, LLM evidence bundle, tool
request, comparison table, export, or paper demonstration shall carry a provenance
envelope. A number without this envelope is not admissible evidence and must not be
rendered as a fact or supplied to a model.

```yaml
key: ego_brake_max
value: 8.2                 # omitted for unavailable, never silently defaulted
unit: m/s^2                # required for every numeric value
status: recorded | derived | configured | assumed | unavailable
source:
  kind: payload_observation | simulator_event | simulator_ground_truth | perception_pipeline | planner_pipeline | control_pipeline | analysis_artifact | run_config | external_reference | user_assumption
  locator: "..."           # Payload ID/URL, repository-relative file, DOI/URL, or immutable artifact reference
  sha256: "..."            # required for repository files and generated artifacts; record a version/access date for external references
  record_id: "..."         # required when an observation, trial, event, or batch is the source
method: "..."              # required for derived values: deterministic algorithm + version and upstream input references
rationale: "..."           # required for assumed or unavailable values
applicability: "..."       # required for assumed/configured reference values; states why it may or may not match the trial
sensitivity: "..."         # required for an assumed value used numerically; gives range/scenarios and result location
supersedes: "..."          # required when replacing a previously published value; old evidence remains retained
```

The existing `capability-card/v1` field names may represent this envelope with
`source`, `source_sha256`, `rationale`, and status-labelled inputs. Before a new
artifact schema is introduced, its Phase note must map its fields to the contract
above; no later Phase may invent a weaker provenance form.

| Status | Meaning | Required provenance and future handling | Never permitted |
| --- | --- | --- | --- |
| `recorded` | Directly stored observation, event, sensor log, or run record. | Source record ID, acquisition/run time, immutable source locator, and hash/export version where available. Preserve original value. | Inferring it from range, geometry, filename, or an LLM answer. |
| `derived` | Deterministic output from identified inputs. | Input references/hashes, algorithm/method version, parameters, generation time, and output hash. Recompute rather than edit when inputs change. | Presenting it as a direct sensor/simulator record. |
| `configured` | A configuration demonstrably selected for this exact run. | Selected config path/version/hash and run-to-config link captured at run time. | Treating a repository's current default as historical run evidence. |
| `assumed` | A replaceable demonstrator, benchmark, or externally cited value. | Citation or configuration source, rationale, applicability limitation, unit, sensitivity range/result, and replacement requirement. | Changing a primary verdict, claiming actual capability, legal fault, compliance, or certification. |
| `unavailable` | Required fact is absent or insufficiently proven. | Missing-data rationale and the exact log/config/source needed to resolve it. | Filling with a plausible default, proxy, vendor claim, or model guess. |

#### Source reliability order and replacement rule

1. **Highest:** trial-specific, timestamped sensor/control/actuation/road records and
   their immutable run artifacts.
2. **Next:** run-bound configuration, calibrated vehicle model, map/environment version,
   and a captured hash showing that the run selected it.
3. **Next:** vehicle-specific, scenario-comparable independent test report with a
   stable citation and applicability statement.
4. **Background only:** standards, regulators, peer-reviewed methods, or vendor/
   autonomous-driving technical sites. They may define a benchmark or assumption
   range, but do not become trial facts.

When a higher-ranked source becomes available, create a new provenance envelope with
`supersedes`; retain the earlier assumed/derived artifact and its hash for audit. Do
not overwrite its status or silently replace its value.

#### Source-identity gate for archived and remote data

A matching batch number, trial number, directory name, or uploaded filename is an
**identifier hint**, not proof that two artifacts came from the same simulator run.
Before a Dashboard, Analyzer, or LLM may combine a local archive with a remote
Payload record, the source-identity check must record all of the following:

1. the remote Trial and upload record IDs plus the upload-file SHA-256;
2. the local trajectory-file SHA-256;
3. matching actor set, duration, initial-state fingerprint, and clock convention; and
4. an explicit reconciliation result of `verified_same_run` or `different_or_unverified`.

If the binary upload cannot be fetched, its hash cannot be computed, or any
fingerprint disagrees, the result is `different_or_unverified`. The two sources then
remain independent provenance branches: a collision derived from the local archive
must not be written back to the remote Trial or called a recorded Payload event.
This rule also applies to source filenames such as `esmini_<batch>_<index>.dat`:
the embedded index is not globally unique and must not be used as a primary key.

#### Downstream preservation rules

| Consumer / Phase | Mandatory behaviour | Completion evidence |
| --- | --- | --- |
| Phase A — Analyzer | Reject invalid/missing status; attach source/hash/rationale; keep primary verdict independent from assumptions. | Schema/unit tests and a card with status-labelled values. |
| Phase B — Replayer/Evidence Drawer | Render status badge, unit, source link, and missing-data reason beside every quantitative annotation; no evidence means no label. | UI/E2E test for recorded, derived, assumed, and unavailable examples. |
| Phase C — `analysis_state` and Q&A | Serialize selected evidence IDs, statuses, units, hashes, citations, and limitations; server passes them unchanged to the LLM. | Fixture/hash test and answer test proving an assumption is called an assumption. |
| Phase D — Agent tools | Include input/output provenance envelopes and evidence/state hashes in proposal, approval, and audit records; tools may not promote status. | Audit test showing an attempted status promotion is rejected. |
| Phase E — ODD comparison | Carry row-level population, source, status, unit, missingness, and comparability; assumptions cannot merge or certify native boundaries. | Non-comparability and generated-prose tests. |
| Phase F — evaluation/demo/voice | Freeze evidence bundle hashes and citations; score unsupported-status errors; voice transcript follows the same source/status display. | Archived demo package and model-evaluation report. |

#### Future data-intake gate

Before accepting a new sensor, configuration, external reference, user-entered
assumption, or derived result, the owning Phase must answer:

1. What status applies and why?
2. What is the exact source locator, record ID, version/date, and hash?
3. Does the value have a unit and an applicability limitation?
4. If it is derived, what deterministic method/version and upstream IDs produced it?
5. If it is assumed, what source supports the range, what sensitivity result is shown,
   and which future measurement replaces it?
6. Where will the Dashboard, LLM, Agent audit record, and export show the same status?

An unanswered item is a phase-gate failure: store the field as `unavailable` instead.

#### Future perception-evidence strategy (design only; no historical backfill)

The project shall not introduce a generic perception model merely to fill an
archived trial's missing first-detection time. `simulator_ground_truth`, a
simulated/physical sensor output, a perception-model output, a tracker output,
and a planner input are separate evidence classes. A timestamped value is
`recorded` only in the evidence class that actually emitted it.

**Verified source-tree baseline.** The ROS `scenario` package advertises
`detected_objects`, but its simulator update appends every agent from
`mAgentManager->GetAgents()` before publication. The accident-recorder topic
configuration also lists `detected_objects`. Until a live ROS-graph audit proves
another publisher and its provenance, this is a simulator-world-state feed, not
an evaluated camera/LiDAR/radar/perception output. It is useful for ground-truth
association and evaluation, but may never populate `first_detected`.

| Tier | Data/model | Permitted claim | Explicit limitation | Decision |
| --- | --- | --- | --- | --- |
| 0 | Existing archived trajectories | externally observed motion and derived geometry | no perception/planner/control evidence | Current cases remain `unavailable` for first detection. |
| 1 | Existing simulator object feed / esmini OSI GroundTruth | simulator world state at simulator time | exact simulator state is not sensor output | Preserve as `source.kind: simulator_ground_truth`. |
| 2 | esmini ideal FOV/near/far filter | configured geometric visibility sensitivity | reference-point filter; esmini does not provide a full sensor model | Optional demonstrator only; cannot be detection evidence. |
| 3 | Calibrated perception-error model (PEM) | assumed/configured distribution of perception error for a stated target domain | calibration data and applicability are required | Optional research experiment; not a source of historical facts. |
| 4 | Sensor simulation + perception stack, or actual ADS logs | recorded simulated/physical detections, tracks, and latency | must retain pipeline/configuration/version identity | Preferred future evidence path. |

The selected interoperability boundary is **ASAM OSI-style semantics**, whether
or not the first pilot serializes literal OSI protobuf messages:

```text
GroundTruth / simulator world state
  -> SensorView or sensor capture
  -> detection / fusion / tracking
  -> planner input and decision
  -> control command
  -> actuator feedback
```

This distinction follows ASAM OSI's separation of `GroundTruth`, `SensorView`,
`FeatureData`, and `SensorData`; esmini can export OSI GroundTruth but explicitly
leaves sensor models out of scope. The project may use these standards/interfaces
as design references, not as evidence that an existing trial has sensor data.

**Approved future pilot sequence — only after the user approves simulation work.**

1. Run a read-only ROS topic-graph audit for the proposed test stack. For every
   object, planner, controller, and vehicle-state topic, record topic name/type,
   publisher package/node, clock, configuration hash, and whether it is world
   state or ADS output. Do not infer origin from its topic name.
2. Capture one small, reproducible cut-in run in two separate, immutable streams:
   `world_state` and `ads_perception`. Archive a rosbag (or equivalent), manifest,
   source hashes, map/configuration hashes, and a common `run_id`.
3. Add a versioned `perception_evidence/v1` adapter only after the actual message
   types are confirmed. Its minimum records are `detection`, `track`, `planner`,
   `control`, and `actuator_feedback`; each event carries simulator/ROS time,
   frame, actor/track association, producer/version, and artifact hash.
4. Validate timestamp ordering, frame transforms, actor association, missing/lost
   tracks, and that an absent detection remains absent. Test that ground truth
   cannot be promoted to a perception event.
5. Allow the Analyzer to calculate first-detection, detection-to-plan,
   plan-to-command, and command-to-feedback intervals only from the matching
   recorded event pairs. Otherwise output `unavailable`.
6. Only after the baseline works, decide whether a Tier-2 ideal-sensor sensitivity
   profile, a calibrated Tier-3 PEM, or a Tier-4 full sensor/Autoware pilot is
   proportionate to the research question and available infrastructure.

**Scope and gates.** This is a future data-intake work item attached to Phase A's
evidence contract, not a requirement to reopen the current archived-data Phase-A
closeout. Phase B can implement evidence-first Replayer annotations from existing
trajectory facts. A future perception pilot requires an approved simulator/ADS
environment, a disposable run, confirmed topic owners, storage for the immutable
artifacts, and a dedicated update to `PhaseA.md` before code changes begin.

### 1.3 Reclassified requirements and mandatory execution order

The R numbers preserve meeting traceability; they are **not** implementation order. The implementation order below is authoritative because later work relies on earlier evidence, semantics, or policy. A phase may not start merely because another UI component looks usable.

| Execution order | Reclassified work package | Requirements grouped together | Why it must happen at this point | Manual gate |
| --- | --- | --- | --- | --- |
| **1. Phase A — trustworthy single-case evidence** | Collision event, perception/capability provenance, deterministic engineering analysis | **R05–R10, R24** | Replayer, Q&A, agent, and demo text need truthful collision time/status/capability evidence first. | Complete real Payload/PostgreSQL round trip; user approves Phase-A closeout. |
| **2. Phase B — evidence-first Replayer** | Behaviour vocabulary, actor-local explanation, qualitative/quantitative drill-down | **R01–R03, R24** | The UI needs structured actor/time evidence before LLM prose can be safely placed next to a vehicle. | User approves behaviour vocabulary, annotation wording, and visual density. |
| **3. Phase C — semantic Dashboard and guided Q&A** | Machine-readable views, scope routing, bounded recursive interaction | **R13–R16, R20–R21** | The agent must first understand the current selection/filter/time/unit through facts rather than screenshots. | User approves scope categories, glossary, and suggestion behaviour. |
| **4. Phase D — constrained agent operation** | Engineering assistance, registered tools, approval/audit policy | **R04, R11, R17–R18** | Tools need the Phase-C semantic state and evidence bundle; otherwise intent and authority cannot be checked. | User approves tool allow-list, confirmation rules, retention, cost/time caps. |
| **5. Phase E — ODD and cross-scenario comparison** | Native boundaries, archetypes, canonical comparison, reusable data artifacts | **R23, R26–R27** | Cross-scenario answers should use the same evidence/status semantics and approved read-only comparison interface. | User approves archetype taxonomy and comparable feature definitions. |
| **6. Phase F — model/design evaluation, background, demos, then voice** | Model/VLM comparison, platform-pattern evaluation, regulatory background, paper demo, voice | **R12, R15, R19, R22, R25** plus final evaluation of **R01–R27** | Provider choice, external references, and voice must be evaluated against the completed evidence/interaction workflow, not in isolation. | User approves evaluation thresholds, budget, study/proxy protocol, and voice enablement. |

### 1.4 How to read and execute this document

This is the actual **implementation order**, not a reading order. Complete one Phase, save its evidence, make its separate commit, and then stop for the listed user approval. Do not begin a later Phase early.

#### Phase A — trustworthy single-case evidence (R05–R10, R24)

**Begin Phase A by freezing its baseline and opening its closeout note.**

- Confirm that the working tree's unrelated Dashboard `.env` and `ScrollWorkspace.tsx` changes remain outside the work.
- Re-read the Phase-A evidence/status policy. Record the exact simulator, Payload, Analyzer, database, and source-config versions that will be tested.
- Create a Phase-A closeout note containing the trial ID, command outputs, event/observation IDs, artifact paths/hashes, and every unavailable input.

1. Start the project PostgreSQL service and run the full Payload integration suite; the prior missing `postgres` hostname failure is not evidence of success.
2. Run one real scenario through `scenario_sampler.py`: create trial -> bulk-create observations -> resolve the collision event to the returned observation ID -> PATCH the deduplicated event list.
3. Run Analyzer for that same trial and prove the source precedence: valid persisted event, otherwise labelled polygon-derived contact, otherwise unavailable.
4. When `capability.yaml` is written, PATCH its path and SHA-256 into `Trials.analysisArtifacts`; record batch/scenario-archetype metadata or an explicit unavailable value.
5. Inspect the generated card. Missing perception, response, brake/lateral, grade, friction, lane, or right-of-way data must remain `unavailable`; the real incomplete trial must yield `insufficient_data`.
- **Required evidence:** passing `pnpm run test:int`, real trial/event/observation database records, card path/hash, Analyzer card, and closeout note.
- **Stop:** user reviews and approves the Phase-A closeout. Nothing in Phase B starts before this gate.

#### Phase B — evidence-first Replayer (R01–R03, R24)

1. Define and approve the `action-annotations/v1` controlled vocabulary, schema, evidence reference rules, and no-evidence/no-label rule.
2. Extend the Analyzer (`labeller.py` -> `dataset_builder.py`) to write `action_annotations.yaml` from trajectory/context/conflict evidence, and add a read-only annotation endpoint.
3. Add Replayer overlay rendering for annotations active at the scrubbed timestamp; map each annotation actor ID to the existing rendered actor position.
4. Add the Evidence Drawer with timestamp range, units, raw values, source links, causal-relation status, and capability badge. Retain the current global caption as a summary, not as the actor-label source.
5. Test actor/time matching, missing causal evidence, label placement, scrubbing updates, and no legal/certification text.
- **Required evidence:** versioned annotation fixture, endpoint integration test, UI/E2E scrubbing evidence, reviewer checklist.
- **Stop:** user approves wording, vocabulary, label density, and uncertainty display.

#### Phase C — make Dashboard state intelligible and add non-executing guided Q&A (R13–R16, R20–R21)

1. Build and test `analysis_state/v1` from Redux: visible view/encodings, filters, selection, time, units, cited artifacts, permitted operations, and limitations; generate a canonical state hash.
2. Add the visualization glossary so Heatmap, Parameter Space, Replayer, native/canonical ODD view, filters, selection, and units have exact machine-readable meanings.
3. Add a five-way router: `data_grounded`, `interface_method`, `general_background`, `analysis_request`, and `unsupported`.
4. Change the chat route/prompt so the server assembles the minimal evidence bundle. The first Phase-C version returns only answer, citations, limitations, and at most three dismissible suggestions; it cannot execute a tool.
5. Test fixed questions in every scope, identical state hashing, missing-data disclosure, citation display, and a rejected suggestion causing no state change.
- **Required evidence:** state schema fixtures, router-evaluation report, answer UI test, no-side-effect E2E test.
- **Stop:** user approves the glossary, scope names, limit wording, and suggestion behaviour.

#### Phase D — add constrained, auditable agent tools (R04, R11, R17–R18)

1. Implement strict request/result schemas, allow-listed read-only tools, policy validation, cost/time/rate limits, and structured audit events.
2. Add `propose_analysis` and `propose_navigation`; proposals display intent, state/evidence hash, inputs, assumptions, expected result, cost/time, and affected view.
3. Add server-signed, short-lived approval tokens. Only after a fresh user approval may an allowed job, navigation, save, or export execute.
4. Add bounded job routes/status output and proposal/approval/audit UI; prohibit shell, arbitrary files, URLs, browser, direct UI writes, and raw DB access.
5. Test all denial paths before happy paths: malformed/unknown tools, stale hash, expired token, unauthorized user, cancelled proposal, over-budget job, and prompt injection.
- **Required evidence:** policy unit tests, full audit records, approval E2E test, negative security test results.
- **Stop:** user approves exact tool list, audit retention, approval duration, and execution budget.

#### Phase E — implement scoped ODD and cross-scenario comparison (R23, R26–R27)

1. Define and approve scenario archetypes; each rule states topology, maneuver/conflict, actor roles/counts, native parameters/units, and inclusion/exclusion conditions.
2. Generate `scenario_manifest.json`, `scenario_archetype.yaml`, canonical feature table, and comparison summary with provenance, population, unit, missingness, and `not_comparable` reasons.
3. Keep native kNN boundary export unchanged; attach only scope/metric/sensitivity/coverage/uncertainty metadata and an `exploratory` label.
4. Add linked Dashboard views: native parameter space remains the source truth; comparison view shows only compatible canonical features and links every row back to native source/trials.
5. Test mismatched actor counts, units, semantics, and missingness; test generated prose/UI cannot call a result certified or universal.
- **Required evidence:** versioned archetype fixtures, compatibility/non-comparability tests, linked-view E2E test, exploratory-language test.
- **Stop:** user approves the archetype taxonomy and the final canonical comparison fields.

#### Phase F — evaluate, document, demonstrate, then add voice (R12, R15, R19, R22, R25)

1. Freeze an evaluation corpus and run Luna, Gemini, and any optional stronger/VLM baseline on identical evidence bundles; measure schema validity, citations, unsupported claims, tool validity, latency, cost, correction burden, and task success.
2. Write the background-reference registry and interaction-pattern decision log. External VSCC/NHTSA/platform material is cited background only, never selected-trial evidence.
3. Archive three reproducible demonstrations: single collision review, guided visual analysis, and cross-scenario comparison. Each must include inputs, hashes, reset/replay steps, expected output, and limitations.
4. Only if the text workflow and demonstrations pass, add voice as transcription into the *same* state/router/policy/approval/audit path. No direct voice execution is permitted.
5. Complete the R01–R27 evidence trace and obtain final user acceptance.
- **Required evidence:** model-comparison report, decision log, archived demos, voice safeguard tests if voice is enabled, complete R trace.
- **Stop:** final user acceptance; no legal, certification, or universal-safety claim is made.

The later technical sections provide the detailed schemas and file changes for the corresponding Phase. The Phase name above determines when they may be implemented.

### 1.5 Exact R01–R27 trace

| Requirement | Detailed implementation location | Primary completion artifact |
| --- | --- | --- |
| R01 | Phase B, Sections 4.2–4.4 | controlled action vocabulary and `action_annotations.yaml` |
| R02 | Phase B, Sections 4.2–4.4 | actor-local Replayer overlay plus Evidence Drawer |
| R03 | Phase B, Sections 4.3–4.4 | progressive quantitative drill-down with units/status |
| R04 | Phase D, Sections 6.2–6.4 | registered engineering-tool catalogue and policy |
| R05 | Phase A, Sections 5.2–5.4 | recorded sensor event or explicit `unavailable` perception field |
| R06 | Phase A, Sections 5.2–5.6 | deterministic engineering verdict and reason codes |
| R07 | Phase A, Sections 5.2–5.6 | versioned run-linked capability provenance |
| R08 | Phase A, Sections 5.3–5.4 | road/dynamics status fields and limitation display |
| R09 | Phase A, Sections 5.2–5.6; Phase C, Section 7 | evidence/status-bound LLM context and response schema |
| R10 | Phase A, Sections 5.3–5.6 | response-time input status and explicit missing-data behaviour |
| R11 | Phase D, Sections 6.2–6.4 | evidence-backed analysis proposals |
| R12 | Phase F, Section 10 | reviewed external-background registry |
| R13 | Phase C, Sections 7.2–7.4 | bounded, state-aware next-question suggestions |
| R14 | Phase C, Sections 7.2–7.4 | five-way scope router and source badges |
| R15 | Phase F, Sections 8.2–8.4 | identical-bundle model comparison report |
| R16 | Phase C, Sections 7.2–7.4 | supported-scope/limitation panel and unsupported response |
| R17 | Phase D, Sections 6.2–6.4 | typed tools with audit evidence |
| R18 | Phase D, Sections 6.2–6.4 | proposal/approval UI and server-checked token |
| R19 | Phase F, Sections 8.3–8.4 | interaction-pattern decision log |
| R20 | Phase C, Sections 7.2–7.4; Phase F | mixed-initiative guidance and collaboration metrics |
| R21 | Phase C, Sections 7.2–7.4 | `analysis_state/v1` and visualization glossary |
| R22 | Phase F, Section 11 | transcript through same text safeguards |
| R23 | Phase E, Sections 9.2–9.3 | scoped native exploratory-boundary artifact |
| R24 | Phases A and B | annotated Replayer plus capability card |
| R25 | Phase F, Section 12 | three reproducible demonstration packages |
| R26 | Phase E, Sections 9.1–9.3 | archetypes, canonical features, non-comparability flags |
| R27 | Phases E and F | evidence bundle/model evaluation plus reusable artifacts |

## 2. End-to-end target architecture

```text
Payload observations + trial metadata + simulator event/config provenance
    |                         |
    |                         +--> capability snapshot / collision event
    v
Analyzer: action/context/trajectory + deterministic collision/capability analysis
    |
    +--> action.yaml, action_annotations.yaml, capability.yaml, BEV, summaries
    |
    +--> registered read-only APIs
    v
Dashboard: Heatmap / Parameter Space / Replayer / evidence drawer
    |
    +--> analysis_state/v1 (view, selection, filters, time, units, limits)
    v
Scope router -> evidence bundle -> LLM response or typed tool proposal
                                      |
                                      +--> user approval -> bounded job / navigation
    v
Answer, citations, limitations, audit event, suggested next questions
```

### 2.1 The decisive design choice: structured evidence before LLM text

The current `context + BEV + prompt -> LLM text file` pipeline is useful for a narrative, but cannot reliably drive a Replayer overlay because free text may omit actor IDs, time intervals, units, or evidence. The target flow is:

1. Deterministic code extracts actor/time/event facts from trajectories and observations.
2. It writes a machine-readable annotation artifact with explicit evidence links.
3. The Replayer renders that artifact at the matching timestamp and actor screen position.
4. The LLM receives the artifact plus limited surrounding context and creates an explanation, suggestions, and questions; it never becomes the source of the overlay fact.

This is both more reproducible and safer than asking a VLM to infer driving behaviour from BEV pixels. It follows the separation of query, transformation, visual mapping, interaction, dialogue, and presentation described in the visual-language-interface literature.[^shen]

## 3. Common artifact and prompt contracts

### 3.1 `action_annotations.yaml` — proposed schema

The Analyzer writes this beside `action.yaml` for each processed trial. It is the only source for actor-local Replayer labels.

```yaml
schema_version: action-annotations/v1
trial_id: "..."
annotations:
  - annotation_id: ego-braking-001
    actor:
      id: ego
      role: ego_vehicle
    interval:
      start_s: 12.40
      end_s: 13.10
      status: derived
    label:
      verb: braking
      short_text: "Braking"
    measurements:
      - key: longitudinal_acceleration
        value: -6.8
        unit: m/s^2
        status: derived
        evidence_ref: observation:381
      - key: time_to_collision
        value: 1.1
        unit: s
        status: derived
        evidence_ref: observation:381
    related_actor:
      id: vehicle_3
      relation: closing_conflict
      status: supported
      evidence_ref: conflict-window:19
    evidence_refs: [observation:381, action.yaml#ego-17, conflict-window:19]
    confidence: supported
```

Rules:

- `short_text` uses a controlled vocabulary: accelerating, braking, maintaining speed, turning, lane changing, approaching, yielding, conflict emerging, collision recorded, or no supported label.
- A related actor/obstacle appears only with explicit evidence; it is omitted rather than guessed.
- Numerical values always carry a unit and status. Thresholds are scenario-contextual and recorded in the artifact/rule version.
- `assumed`/`unavailable` cannot produce a categorical causal label.

### 3.2 `analysis_state/v1` — Dashboard semantic contract

The Dashboard builds canonical JSON from Redux, hashes it, and passes it to the server. It is a description of the user-visible analytical state, not an unbounded copy of application data.

```json
{
  "schema_version": "analysis-state/v1",
  "batch_id": 12,
  "view": {"kind": "replayer", "encodings": ["actor_position", "action_annotation"]},
  "selection": {"trial_ids": [381], "cluster_ids": [4], "actor_ids": ["ego", "vehicle_3"]},
  "filters": [{"key": "collision", "operator": "=", "value": true}],
  "time": {"seconds": 12.6, "window_seconds": [10.0, 15.0]},
  "units": {"speed": "m/s", "acceleration": "m/s^2"},
  "visible_evidence": ["action_annotations.yaml#ego-braking-001"],
  "available_operations": ["describe_current_view", "get_trial_evidence", "propose_navigation"],
  "limitations": ["first_perception_unavailable"],
  "state_hash": "sha256:..."
}
```

### 3.3 LLM evidence bundle and response contract

The server, not the browser, assembles a minimal evidence bundle from registered artifacts:

```text
system rules + scope policy
+ glossary terms relevant to current view
+ analysis_state/v1
+ selected action annotations
+ selected capability card / collision source
+ approved background references when needed
+ question + bounded conversation history
```

It must not send an entire batch, arbitrary files, API keys, raw DB access, or unspecified trajectories. A structured response is required:

```json
{
  "scope": "data_grounded | interface_method | general_background | analysis_request | unsupported",
  "answer": "...",
  "evidence_citations": ["capability.yaml#verdict", "action_annotations.yaml#ego-braking-001"],
  "limitations": ["first_perception_unavailable"],
  "suggestions": [{"label": "Inspect braking onset", "proposal_type": "navigation"}],
  "tool_proposal": null
}
```

The prompt explicitly prohibits legal/certification claims, requires unit/status reporting for physical facts, and requires the model to say `unavailable` when the bundle lacks a required field. Strict structured output/function schemas are an application boundary, not a replacement for validation or user approval.[^openai-tools]

## 4. Phase B — actor-local Replayer explanation

**Requirements:** R01, R02, R03, R24. **Goal:** a reviewer can scrub to a moment and immediately identify *which* actor acted, *what* it did, *when*, *why it is claimed*, and *how to inspect the underlying numbers*.

### 4.1 Method comparison and choice

| Candidate | Benefit | Failure mode | Decision |
| --- | --- | --- | --- |
| Ask LLM/VLM to caption each BEV frame | Fast prototype; natural text | Actor identity drifts, no deterministic timestamp/evidence, behaviour may be hallucinated, expensive per frame | Do not use as fact source. |
| Render only raw numeric tables | Fully inspectable | User cannot quickly connect values to the relevant vehicle; fails R02/R03 | Keep as drill-down only. |
| Rule/event extractor -> structured annotations -> overlay; LLM creates optional narrative | Traceable actor/time/evidence, inexpensive, works with existing extractor/context | Needs careful vocabulary and thresholds | **Adopt.** |

### 4.2 Implementation steps and files

1. Add an annotation DTO/validator in `app/analyzer/src/action_annotation_schema.py` **new**.
2. Extend `app/analyzer/src/labeller.py` and its context/action helpers to emit controlled-vocabulary event intervals from already available acceleration, yaw/lane-change, relative-distance/angle, TTC, and conflict-window data.
3. Modify `app/analyzer/src/dataset_builder.py` to write `processed/action_annotations.yaml` after `action.yaml`; add the artifact path/hash to the run manifest.
4. Extend `app/analyzer/src/description.py` only to cite annotations in an overall caption. It must not manufacture annotation records from prose.
5. Add a registered read-only route in `app/analyzer/src/controller.py`, for example `GET /trajectory_analysis/action-annotations/...`, accepting IDs/time range rather than a filesystem path.
6. Add a typed client and `ActionAnnotations.tsx` near `app/dashboard/src/app/batch/[id]/_tabs/explore/components/dock/panels/Replayer/index.tsx`.
7. At every Replayer frame, map actor ID to current rendered coordinates, select annotations whose interval includes time, and place short labels using collision/viewport-aware offsets. Keep the existing upper-right cluster caption as the larger-window summary.
8. On hover/click, open an Evidence Drawer: actor/role, interval, measurement table, causal relation status, artifact links, and capability-card status. Do not keep every number permanently on the canvas.

### 4.3 Dashboard layout

```text
+------------------------ Replayer canvas -------------------------+
| [ego]  Braking             [vehicle_3] Turning left             |
|   BEV actor geometry / trajectory / time scrubber                |
+------------------------------------------------------------------+
| timeline: annotations, conflict windows, collision marker        |
+-------------------+----------------------------------------------+
| Existing controls | Evidence Drawer (on selected annotation)     |
| filters / play    |  source, values, units, status, limitations  |
+-------------------+----------------------------------------------+
```

Labels are always concise; a label appears only while it applies. If the label overlaps an actor, the layout engine tries a bounded set of offsets and leader lines; if no readable placement is possible, it uses a selected-actor side card rather than attaching misleading text to the wrong vehicle.

### 4.4 Expected outcome and acceptance evidence

- Fixture trajectories produce expected annotation IDs, actor IDs, time ranges, units, and evidence references.
- Missing causal evidence produces no “because of vehicle X” label.
- UI tests show frame scrubbing updates labels and the selected annotation opens its correct evidence drawer.
- A human reviewer can answer actor, action, time, source, and provisional status from one selected annotation.
- Prohibited wording tests reject fault, liability, certification, and unsupported causal terms.

## 5. Phase A — single-case collision, physical capability, and candidate responsibility analysis

**Requirements:** R05–R10, R24. **Goal:** transform a single trial into a transparent engineering review without turning missing data or an engineering conclusion into legal responsibility.

### 5.1 Method comparison and choice

| Candidate | Why insufficient | Chosen replacement |
| --- | --- | --- |
| LLM reads BEV/context and decides whether collision was avoidable | Cannot guarantee units, perception timing, or physics; an explanation is not a calculation. | Deterministic capability card first; LLM only explains cited fields. |
| Use first object-in-range as first detection | Range is not sensor perception/tracking/decision evidence. | Require a recorded sensor event; otherwise `unavailable`. |
| Use one RSS/config value as measured trial braking ability | A config file proves a configured parameter, not historical runtime binding or measured latency. | Record selected source/hash at trial time; otherwise configured/unavailable. |
| Legal-fault classifier | Neither project data nor external crash data establishes jurisdictional legal liability. | Engineering labels and review questions only. |

### 5.2 Deterministic analysis flow

```text
valid collision event (recorded) OR polygon contact resolver (derived)
  + trajectory / control observations
  + visibility evidence (derived only when profile + complete geometry permit it)
  + sensor/tracker event, if recorded
  + run-linked vehicle/config/map provenance
      -> validate units/status/source/hash
      -> calculate collision timing, required stopping/maneuver quantities
      -> capability-card verdict + reason codes
      -> LLM explanation with explicit limitations
```

The capability decision must use only validated inputs. For synthetic tests, inputs may be deliberately provided to exercise a verdict. Those fixture values must not be displayed as trial measurements.

#### A1–A3 implementation sequence and status contract

Phase A is deliberately split into three ordered evidence layers. This avoids the
common but incorrect shortcut “a trajectory was visible in retrospect, therefore
the ADS detected it.” The status of a field is part of its value and travels with it
to every later phase.

| Layer | Concrete output | What it can establish | What it cannot establish | Current archived-case result |
| --- | --- | --- | --- | --- |
| **A1 — motion/collision** | `action.yaml`, `capability.yaml` | recorded collision event, or a deterministic polygon-derived contact; actor motion and collision-time kinematics | perception, planner rationale, or legal responsibility | Derived `CuttingIn` contact at 14.64 s; primary verdict `insufficient_data`. |
| **A2 — visibility/profile sensitivity** | `visibility.yaml`, optional card `profile_sensitivity` | a FOV/range candidate from a versioned profile; clear geometric opportunity only with complete map/occluder geometry; conditional timing sensitivity | an actual historical detection, track, plan, command, or actuator response | All visibility fields unavailable: no profile and no complete geometry were archived. |
| **A3 — recorded pipeline evidence** | future `perception_evidence/v1` and run manifest | first detection, detection-to-plan, plan-to-command, and command-to-feedback intervals when emitted by the evaluated pipeline | legal fault/certification, even with complete telemetry | Deferred: requires an approved new run and source audit. |

**Field contract.** `first_detected` is `recorded` only if a timestamped detector or
tracker emitted it. `fov_range_opportunity` may be `derived` only from a profile with
FOV/range units, source, rationale, applicability limits, and content hash.
`visibility_opportunity` may be `derived` only if coverage is explicitly `complete`
and the map/static/dynamic occluder evidence used by the ray/footprint procedure is
identified and hashed. Otherwise the result is `unavailable`. A profile’s latency is
`assumed` or `configured`, never a measured historical response delay.

### 5.3 Implementation steps and files

1. Close Phase-A integration in `simulation/ros/src/scenario_search/src/scenario_search/scenario_sampler.py`, `event_record.py`, `single_parameterized_scenario_search.py`, `app/payload/src/collections/Trials.ts`, and `app/payload/tests/int/trial-events.int.spec.ts`: event timestamps must be positive, linked to the correct observation, deduplicated, and persisted after bulk-observation response validation.
2. Complete source provenance in `capability_provenance.py` and `app/analyzer/src/capability_sources.py`: selected RSS/Pacifica/catalog/map input paths and SHA-256 must be saved. The resolver must not choose the first catalog vehicle.
3. Keep `app/analyzer/src/collision_vehicle.py` precedence: valid persisted event -> polygon-derived contact -> unavailable. The output identifies which source won.
4. Keep validation and calculation separate in `capability_schema.py` and `capability_analysis.py`; write `processed/capability.yaml` beside `action.yaml` from `dataset_builder.py`.
5. After writing, PATCH `analysisArtifacts.capabilityCardPath` and `capabilityCardSha256` back to Payload; do not merely expose a local file.
6. Build A2 in `app/analyzer/src/perception_profiles.py` and `visibility_analysis.py`; add `processed/visibility.yaml` to `cluster_paths.py`; use it in `dataset_builder.py` and `capability_analysis.py`. The profile validator must require status, source, rationale, applicability, units, and a deterministic hash. The Analyzer must write unavailable evidence, rather than guess, when a profile or complete geometry is absent.
7. Expose A1/A2 only through read-only Analyzer endpoints in `controller.py`; Phase B, not Phase A, renders a compact Replayer capability/visibility badge and actor-local labels.
8. Add sensor-detection capture only when the simulator emits an actual timestamped detection/tracking event. Add any new Payload observation fields and migration/test at that time; do not add an empty pseudo-sensor field.

**Implemented Phase-A files and checks.** The A2 implementation is in
`perception_profiles.py`, `visibility_analysis.py`, `capability_schema.py`,
`capability_analysis.py`, `dataset_builder.py`, `cluster_paths.py`,
`controller.py`, and `scripts/build_phase_a_archived_card.py`. The focused analyzer
suite covers the profile validator, profile hashing, complete versus incomplete
geometry, unavailable detection, and the rule that sensitivity cannot change the
primary verdict. Its current result is `25 passed`; the full Phase-A acceptance
record, exact artifact hashes, and outstanding remote-chain blocker are in
[PhaseA.md](PhaseA.md).

### 5.4 Required card behaviour

| Input absent | Card/UI/LLM behaviour |
| --- | --- |
| Sensor detection event | `first_detected: unavailable`; omit avoidability conclusion requiring it. |
| Versioned FOV/range profile | `fov_range_opportunity: unavailable`; do not treat a generic distance threshold as a visibility fact. |
| Complete occluder/map geometry | `visibility_opportunity: unavailable`; do not call an unobstructed line of sight from positions alone. |
| Actual run-linked brake/lateral capability | Report source hash/status only; real verdict remains `insufficient_data` if it is essential. |
| Grade/friction/right-of-way | Display `unavailable`; do not infer downhill responsibility. |
| Full valid evidence | Emit one engineering verdict plus reason codes and sensitivity/assumption results where assumptions were explicitly approved. |

### 5.4.1 Phase-A checklist, hand-off, and gate

**Before accepting A1/A2:**

- [ ] Each persisted/derived collision shows actor, timestamp, status, source, and source hash where a file source exists.
- [ ] `visibility.yaml` exists beside a canonical/selected card and clearly separates `first_detected`, FOV/range candidate, and line-of-sight opportunity.
- [ ] Every profile is versioned and hashed; every number has a unit, source, status, rationale, and applicability limitation.
- [ ] A missing profile, missing geometry, or missing sensor event produces `unavailable`, not a fallback claim.
- [ ] Sensitivity output says `primary_verdict_unchanged: true`; an LLM cannot replace the deterministic verdict.
- [ ] Tests prove complete-geometry, incomplete-geometry, missing-profile, and profile-disagreement cases.
- [ ] The PhaseA record contains commands, artifact paths/hashes, data gaps, user checks, and the decision about the remote canonical chain.

**How later phases consume the result:**

| Later Phase | Uses from A1/A2 | Must preserve | Must not do |
| --- | --- | --- | --- |
| B — Replayer | action timestamps, collision source/status, `visibility.yaml`, capability-card limitation/badge data | source/status/unit and the no-evidence/no-label rule | place “detected” or responsibility labels over an actor when only geometry/profile exists. |
| C — guided Q&A | minimal cited evidence bundle and its data gaps | the distinction among recorded, derived, assumed, and unavailable | answer a missing historical fact with a generic model value. |
| D — agent | read-only request schemas for collision window, profile comparison, and evidence-gap listing | state/artifact hashes and explicit user approval for any future job | invent inputs or execute generic file/shell/browser actions. |
| E — cross-scenario ODD | status-labelled collision/visibility summaries and missingness flags | separate native spaces and populations | mix profiles/runs or call a native boundary certified. |
| F — evaluation/demo | fixed evidence cases containing both complete and incomplete inputs | grounding, uncertainty calibration, and citation tests | score a model by unsupported liability answers. |

**Phase-B entry decision:** Phase B code is permitted after the user accepts the
local A1/A2 evidence scope recorded in `PhaseA.md`. A remote Payload Trial that does
not match the local archive is an **excluded external source**, not an incomplete
input to the local analysis. It must never be merged with or overwritten by local
artifacts. Recovering that remote source is an optional, separate data-preservation
task and is not a Phase-B gate.

### 5.5 Theory and research basis

RSS is useful as a formal, parameterized engineering safety framework for safe distance, cut-ins, visibility, right-of-way, and collision avoidance; it is not a legal-fault engine.[^rss] The project may use its assumptions as named input categories and test envelopes, but must not claim RSS compliance. NHTSA crash data are useful background for which context fields matter, but reports can be incomplete and are not evidence for a project trial.[^nhtsa]

### 5.6 Expected outcome and acceptance evidence

- Synthetic late cut-in, early-visible cut-in, no-brake, missing-lane, and two-brake-limit disagreement tests cover the permitted four verdict labels.
- A2 tests cover a profile with complete geometry, incomplete geometry, an absent profile, and a conditional sensitivity result that cannot override `insufficient_data`.
- Unit validation rejects unitless numeric inputs, invalid statuses, source-less physical values, and legal/certification phrasing.
- A real Postgres-backed round trip proves trial -> observations -> event relationship -> card -> stored card path/hash.
- Incomplete real trials visibly yield `insufficient_data`; only test fixtures can demonstrate non-insufficient verdicts until provenance is captured.

## 6. Phase D — constrained engineering agent

**Requirements:** R04, R11, R17, R18. **Goal:** permit useful analysis assistance without giving an LLM general computer control.

### 6.1 Method comparison and choice

| Candidate | Benefit | Risk | Decision |
| --- | --- | --- | --- |
| Computer-use agent clicking the Dashboard | Works without APIs | Cannot reliably prove semantic intent, can click unsafe/unrelated actions, weak audit trail | Reject for normal operation. |
| Agent with shell/file/URL access | Flexible | Excessive authority and data-exfiltration risk | Reject. |
| Typed, allow-listed application tools plus confirmation | Narrower initial capability, but uses stable IDs and returns auditable structured results | Requires API/schema work | **Adopt.** |

### 6.2 Tool catalogue and execution policy

| Tool | Inputs | Result | Permission |
| --- | --- | --- | --- |
| `describe_current_view` | `analysis_state/v1` | view/filter/selection/glossary explanation | read-only |
| `get_trial_evidence` | registered `trial_id` | action, card, collision, artifact citations | read-only |
| `summarize_selection` | selected registered trial IDs | aggregate, cited values/missingness | read-only |
| `compare_scenario_archetypes` | registered archetype IDs | canonical values + non-comparability | read-only |
| `search_run_artifacts` | typed artifact query | registered current-run artifact refs | read-only |
| `propose_navigation` | desired state | human-readable proposed state change | proposal only |
| `propose_analysis` | registered method and inputs | cost/time/outputs/assumptions | proposal only |
| `run_analysis`, `apply_navigation`, `export_report` | approved `plan_id` | bounded result | explicit current confirmation |

### 6.3 Implementation steps and files

1. Add `app/llm_pipeline/python/llm_pipeline/agent_schemas.py`: strict schemas for scope, citations, tool request/result, plan, approval, and response card.
2. Add `agent_tools.py`: implementations only for the catalogue above; use registered batch/run/trial/artifact IDs, never raw paths.
3. Add `agent_policy.py`: allow-list, request identity, state/evidence hash, rate/cost/time limits, output-size bounds, and denial reason.
4. Add `agent_audit.py`: append immutable structured records for intent, normalized args, evidence/state hashes, result refs, approval, provider/model, latency, usage/cost estimate, and final citations. Secrets are never written.
5. Add `agent_router.py` before drafting with `odd_chat.py`; it can ask the LLM for a schema-valid proposal, but policy validation happens in application code.
6. Add Dashboard server routes: `app/dashboard/src/app/api/analysis-agent/route.ts`, `approve/route.ts`, and `jobs/[id]/route.ts`.
7. Add ChatDrawer proposal cards showing purpose, inputs, assumptions, outputs, affected view, predicted cost/time, and Approve/Edit/Reject. A user rejection must cause no state change.

### 6.4 Expected outcome and acceptance evidence

- Unknown tool, raw file path, shell request, arbitrary URL, stale state hash, expired approval, changed arguments, over-budget request, and unauthorized user fail before execution.
- Every successful call has a complete audit record linked to result artifacts.
- Read-only answers can proceed without confirmation; any state/job/export action remains pending until a fresh server-checked confirmation.
- An analyst can replay why an action was proposed, which data it used, what it did, and what it returned.

## 7. Phase C — semantic Dashboard and mixed-initiative Q&A

**Requirements:** R13, R14, R16, R20, R21; foundation for R04/R11/R17/R18. **Goal:** move from one-shot chat to state-aware, bounded human–AI collaboration.

### 7.1 Method comparison and choice

| Candidate | Why not sufficient | Chosen approach |
| --- | --- | --- |
| Screenshot/BEV sent to a VLM | Cannot reveal filters, hidden selection, units, operation permissions, or data provenance consistently. | `analysis_state/v1` + glossary is authoritative; images are optional secondary context. |
| One generic chat prompt | Confuses project facts, UI explanation, general knowledge, and actions. | Scope router with five explicit response modes. |
| Autonomous recommendations/actions | Removes analyst control and makes intent ambiguous. | Suggestions/proposals are visible, editable, dismissible, and non-executing by default. |

### 7.2 Dashboard behaviour

1. Every chat message displays one scope badge: **Project evidence**, **Interface/method**, **General background**, **Analysis proposal**, or **Unsupported**.
2. Project-evidence answers show artifact citations and missing-data badges. General background answers show external references and state they are not trial evidence.
3. After a grounded answer, show at most three suggestions based on the current state, for example: “inspect ego braking onset,” “compare selected trial to cluster medoid,” or “show non-comparable scenario fields.”
4. The user may accept, edit, or dismiss a suggestion. Accepting a proposal opens a plan/approval card; it does not execute immediately.
5. A visible scope/limits panel explains what current view, data, units, model, tools, and unavailable fields are in use.

### 7.3 Implementation steps and files

1. Create `app/dashboard/src/app/batch/[id]/_tabs/explore/lib/analysisState.ts` to build canonical state and hash from Redux.
2. Add `app/dashboard/src/app/_shared/utils/visualizationGlossary.ts` and types for views, encodings, filters, units, selection, annotations, native/canonical ODD view, and allowed operations.
3. Extend `chatContext.tsx`, `ChatDrawer.tsx`, and `app/dashboard/src/app/api/odd-chat/route.ts` to send only schema-valid state and render scope/citation/limit/suggestion cards.
4. Add `agent_router.py`, `agent_schemas.py`, `agent_system_prompt.txt`, and `visual_semantics_prompt.txt` in `app/llm_pipeline/`; preserve existing `odd_chat.py` artifact retrieval as one tool/evidence source.
5. Build a fixed router evaluation corpus: data-grounded question, UI question, general question, supported analysis proposal, unsupported request, legal-fault request, missing-field request, and prompt-injection attempt.

### 7.4 Expected outcome and acceptance evidence

- Identical visible Dashboard state produces identical canonical JSON/hash; secrets and hidden data are absent.
- The fixed corpus returns correct scope, citations/limitations, and no tool/action token for an answer-only interaction.
- A rejected suggestion changes neither filters nor selection nor job state.
- A reviewer can see why the LLM knew a fact and which visual state it was discussing.

## 8. Phase F — visualization model, VLM, and interaction-pattern evaluation

**Requirements:** R15, R19, R27. **Goal:** choose models and interaction patterns based on the project’s evidence tasks, not marketing claims.

### 8.1 Finding: no drop-in model understands this custom system

Chart-focused VLM research (for example ChartInstruct) improves comprehension of conventional static charts, but it does not know the project's actor IDs, simulator coordinates, timeline semantics, filters, or collision definitions.[^chartinstruct] It is therefore a useful optional *baseline* for chart/image questions, not an authoritative Replayer/collision reasoner.

Systems such as Microsoft Data Formulator and LIDA are more relevant as interaction-design references: they combine natural language with inspectable concepts/data transformations and keep analysts in the loop.[^dataformulator][^lida] They should not be copied as code-generating, unrestricted agents for this safety-analysis system.

### 8.2 Candidate comparison plan

| Candidate class | Intended role | Included? | Evaluation boundary |
| --- | --- | --- | --- |
| `gpt-6-luna` | frequent scope routing, grounded explanation, structured proposal | Default candidate | Must pass schema/citation/unsupported-claim checks. |
| Gemini 2.5 Flash | existing provider/fallback baseline | Yes | Same prompt/evidence bundle, not separate favourable prompt. |
| Stronger general model (Sol/Astra or available equivalent) | offline difficult-case baseline | Optional | Compare only on fixed hard cases and budget. |
| VLM / chart-specialized research model | screenshot/chart comprehension baseline | Optional research experiment | Cannot produce recorded/capability verdict or tool call. |

### 8.3 Fixed evaluation set

Create `app/llm_pipeline/qa_checks/agent_model_eval.json` with at least 40 versioned cases. Each stores evidence-bundle hash and expected scope, citations, limitations, forbidden claims, and expected tool-policy result. Include:

- identify the actor/behaviour from an annotation;
- explain a capability card with missing first perception;
- refuse legal fault/certification;
- distinguish a Dashboard UI question from project data;
- propose, but not execute, a comparison;
- identify non-comparable scenario dimensions;
- reject malformed tool arguments and prompt injection;
- answer an external background question with external citations.

Measure schema-validity, citation precision/recall, unsupported-claim rate, physical-status fidelity, tool validity, latency, actual input/output tokens, cost, correction burden, and task completion. Keep the lightest model only if it meets the predeclared quality threshold; OpenAI's current guidance also recommends comparing models on the same task rather than selecting solely by price.[^modelselection]

### 8.4 Expected outcome and acceptance evidence

- A reproducible report compares Luna and Gemini using identical bundles.
- Design log records adopted/rejected patterns from Power BI, Tableau, Looker, Data Formulator, and the reason each fits or does not fit scenario analysis.
- Any optional VLM result is labelled an experiment and cannot overrule structured evidence.

## 9. Phase E — ODD boundary and cross-scenario comparison

**Requirements:** R23, R26, R27. **Goal:** support meaningful comparison without pretending that different actor counts and parameter dimensions form one universal ODD coordinate space.

### 9.1 Method comparison and choice

| Candidate | Problem | Decision |
| --- | --- | --- |
| Merge every run into a padded high-dimensional vector | Missing actors/dimensions change distance meaning; false comparison | Reject. |
| One native plot per scenario only | Faithful but cannot answer cross-scenario questions | Retain as truth layer, add canonical summary. |
| Native-space plots + explicit archetypes + canonical compatible features | Preserves source geometry and allows bounded comparison | **Adopt.** |

### 9.2 Implementation steps and files

1. Add `app/analyzer/src/scenario_comparison/manifest.py`, `archetypes.py`, `canonical_features.py`, and `summary.py`.
2. Write `scenario_manifest.json`: map/simulator/config versions and hashes, topology, maneuver/conflict class, actor roles/counts, native parameters/units/ranges, sample coverage, population, and input statuses.
3. Write versioned `scenario_archetype.yaml`: stable archetype ID plus inclusion/exclusion/comparison rules. An archetype is never inferred solely from a filename.
4. Write `cross_scenario_features.parquet`/CSV and `cross_scenario_summary.json`: canonical feature values, units, missingness, source, population, and `not_comparable` reason code.
5. Keep existing native kNN export unchanged in mathematical meaning; only attach manifest/archetype link, metric, sensitivity, coverage, uncertainty, and `exploratory_native_boundary` labels.
6. Add an Analyzer read endpoint/tool result and linked Dashboard native/canonical panels under Parameter Space.

### 9.3 Dashboard behaviour and acceptance evidence

- Native mode shows the original scenario family, dimensions, metric, coverage, and exploratory label.
- Comparison mode shows only compatible canonical features; non-comparable dimensions, actor-count mismatch, units, and missingness are explicit.
- Selecting a comparison row links back to source native plots/trials.
- Tests reject text such as “certified boundary,” “universal ODD,” or unqualified “the ODD boundary.”

ASAM OpenODD supports a machine-readable operational-domain representation and motivates the manifest approach; it does not prove a boundary is certified.[^openodd]

## 10. Phase F — external regulatory and crash-data background

**Requirements:** R12. **Goal:** make VSCC/NHTSA/standards useful contextual material without blending them with the project's trial facts.

### Implementation

1. Add a reviewed background registry, proposed path `docs/references/safety_background_registry.yaml`, with source URL/version/date, subject, jurisdiction, allowed use, and explicit non-evidentiary warning.
2. Add a `background_reference` response type to the LLM schema. It contains citation, summary, applicability limits, and the statement: “This is background, not evidence of the selected trial.”
3. Preserve VSCC material as pending until an authoritative applicable document/version is selected and reviewed. Do not convert a type-approval threshold into an emergency-braking truth for the simulation.
4. Permit NHTSA SGO data as a source of scenario/context questions, not a ground-truth fault label or direct performance comparison.[^nhtsa]

### Acceptance

- Every external reference response clearly separates background from project evidence.
- Tests reject a prompt that uses an external report as proof of what the ego vehicle measured or did.

## 11. Phase F — voice input, last

**Requirements:** R22. **Goal:** add convenient voice input without creating a second, weaker safety/control path.

### Implementation

1. After text Q&A, routing, policy, audit, and approval pass evaluation, add `app/dashboard/src/app/api/analysis-agent/voice/route.ts` and a push-to-talk component near `ChatDrawer.tsx`.
2. Voice produces a visible editable transcript. The transcript, rather than audio alone, becomes the input to the same `analysis_state/v1`, scope router, prompt, response schema, proposal card, confirmation gate, and audit event as typed text.
3. Show transcription uncertainty and require user correction when an actor ID, unit, trial ID, or requested action is ambiguous.
4. Do not enable direct voice commands for job execution/navigation/export; confirmation remains visual and typed/clicked.

### Acceptance

- Text and voice requests with the same transcript take the same scope/policy path.
- Transcription failure, ambiguous actor name, rejected action, and interrupted recording are tested.
- Voice cannot call a tool that typed input cannot call.

## 12. Phase F — paper demonstrations, evaluation, and evidence trace

**Requirements:** R25 and final validation for R01–R27. **Goal:** prove that the research contribution is reproducible, not merely a polished live demo.

### 12.1 Three required demonstrations

| Demo | Question | Evidence/interaction | Required limitation |
| --- | --- | --- | --- |
| Single collision review | What happened, what did each actor do, and what engineering data are missing? | Replayer annotation -> Evidence Drawer -> capability card -> grounded Q&A | First perception/capability shown unavailable if not recorded. |
| Guided visual analysis | How does an analyst move from a cluster result to a concrete case? | Heatmap/Parameter selection -> Replayer -> suggested evidence check -> cited answer | Suggestion is non-executing until approved. |
| Cross-scenario exploration | Which findings are comparable across intersection scenarios? | Native boundary -> archetype/canonical view -> non-comparability explanation | No universal/certified boundary claim. |

### 12.2 Deliverables and files

- `docs/demos/single_case_collision/`, `guided_analysis/`, and `cross_scenario/`: input IDs/hashes, command/script, expected visual state, expected artifacts/answer, limitation, and reset instruction.
- `docs/evaluation/interaction-pattern-decision-log.md`: adopted/rejected large-platform/research patterns and rationale.
- `docs/evaluation/model-comparison.md`: provider/model/version, fixtures, metrics, raw result links, limitation, and selection decision.
- `docs/evaluation/r_trace_evidence.md`: R01–R27 -> implementation files -> artifact -> test/evaluation evidence.

### 12.3 Completion criteria

1. An independent reviewer reproduces each demo from archived inputs without undocumented manual edits.
2. Evaluation reports task success, evidence/citation accuracy, unsupported-claim rate, tool validity, confirmation compliance, latency, cost, correction burden, interruption burden, and uncertainty calibration.
3. Every R01–R27 has a link to a code/artifact/test result; an unchecked R blocks final completion.

## 13. Delivery order and gates

1. **Phase A closeout:** obtain real database round-trip evidence; store card path/hash; preserve unavailable fields. User approval required.
2. **Phase B:** action annotations and evidence-first Replayer. User approves vocabulary/visual density.
3. **Phase C:** semantic state, glossary, scope router, and non-executing Q&A suggestions. User approves scope wording.
4. **Phase D:** typed tools, approval, bounded jobs, audit. User approves allow-list, retention, and cost/time limits.
5. **Phase E:** archetype/canonical comparison. User approves taxonomy and comparable feature definitions.
6. **Phase F:** formal evaluation, background registry, demos, then voice. User approves evaluation thresholds, budget, consent/proxy protocol, and voice enablement.

## 14. References and implementation decisions

[^shen]: L. Shen et al., [Towards Natural Language Interfaces for Data Visualization: A Survey](https://doi.org/10.1109/TVCG.2022.3148007), *IEEE TVCG*, 2023. Basis for separating intent, data transformation, visual mapping, interaction, dialogue, and presentation.

[^rss]: Mobileye, [Responsibility-Sensitive Safety](https://www.mobileye.com/technology/responsibility-sensitive-safety/); M. Strauss and S. Mitsch, [Slow Down, Move Over: Formal Verification, Refinement, and Testing of RSS](https://arxiv.org/abs/2305.08812). Basis for named safety/capability assumptions and deterministic test envelopes, not legal responsibility or compliance claims.

[^nhtsa]: NHTSA, [Standing General Order on Crash Reporting](https://www.nhtsa.gov/laws-regulations/standing-general-order-crash-reporting). Basis for contextual crash-data fields and data-quality caution; external incident reports are not project-trial evidence.

[^openai-tools]: OpenAI, [Function calling](https://developers.openai.com/api/docs/guides/function-calling) and [Using tools](https://developers.openai.com/api/docs/guides/tools). Basis for strict schemas/typed tools; application policy and confirmation remain mandatory.

[^chartinstruct]: A. Masry et al., [ChartInstruct: Instruction Tuning for Chart Comprehension and Reasoning](https://arxiv.org/abs/2403.09028). Research baseline for chart understanding, with limited applicability to dynamic BEV/replayer semantics.

[^dataformulator]: C. Wang et al., [Data Formulator: AI-powered Concept-driven Visualization Authoring](https://www.microsoft.com/en-us/research/publication/data-formulator-ai-powered-concept-driven-visualization-authoring/). Interaction reference for inspectable human–AI visualization authoring, not a drop-in automotive-analysis model.

[^lida]: Microsoft, [LIDA](https://github.com/microsoft/lida). Reference for visualization-generation pipelines; its code-generation/execution model is not adopted because this project requires typed, restricted analysis tools.

[^modelselection]: OpenAI, [Model selection](https://developers.openai.com/api/docs/guides/model-selection). Current provider guidance for comparing models on representative work/cost/latency rather than assuming one default is universally best.

[^openodd]: ASAM, [OpenODD](https://www.asam.net/standards/detail/openodd/). Basis for machine-readable ODD/scenario manifests, not a certification statement.

## 15. Implementation readiness checklist

- [ ] Phase-A database integration evidence is available and reviewed.
- [ ] Actor annotation vocabulary and evidence schema are approved.
- [ ] Capability-card status/assumption policy is approved.
- [ ] `analysis_state/v1` and glossary are approved before agent tools.
- [ ] Tool allow-list, approval expiry, audit retention, and budgets are approved.
- [ ] Archetype taxonomy and canonical features are approved before cross-scenario claims.
- [ ] Fixed model/evaluation corpus and success thresholds are approved before provider selection.
- [ ] Three demonstrations are reproducible and every R01–R27 has evidence.

## 16. Mandatory per-Phase record and user-verification protocol

This protocol is mandatory for every implementation Phase. It makes the phase record the user-facing contract for checking that a function behaves as intended.

### 16.1 Record lifecycle

1. The six records `PhaseA.md` through `PhaseF.md` **may be pre-created** in this folder from [PhaseTemplate.md](PhaseTemplate.md). Before their Phase begins, they remain `planned` and contain only scope, intended tasks, dependencies, research/design choices, and proposed verification.
2. Pre-creating a record is planning only. It does **not** authorize code changes, tests that mutate project state, generated production artifacts, or a completion claim for that future Phase.
3. At the approved plan gate for the current Phase, change only its record to `in_progress`. Complete its baseline, actual data-status classification, planned verification, and scope boundary before the first implementation change.
4. A later Phase may be refined while another Phase is active only where work overlaps (for example, recording an API dependency or an agreed schema). It must remain `planned`; do not implement its exclusive files/features, run its acceptance tests as a completion claim, or alter its status.
5. During implementation, update the current Phase record after every meaningful loop: add/modify/delete/rename file entries, design decisions, failed/reverted attempts, test commands/results, generated artifacts, and blockers.
6. When code/tests are ready, set the current record to `awaiting_user_acceptance`. Complete its user acceptance table with only operations that are currently available to the user and their observable expected results.
7. Stop implementation. Do not begin the next Phase's task implementation until the user explicitly accepts the current record. After acceptance, record the decision/date, make the separate Phase commit, mark the record `complete`, then change the next Phase record from `planned` to `in_progress`.

### 16.2 Required content of every `Phase*.md`

| Required section | Why the user needs it |
| --- | --- |
| Purpose and expected result | States what this Phase is meant to achieve, without promising later work. |
| R requirements in/out of scope | Makes it possible to check that every meeting requirement is accounted for. |
| Plan-gate evidence and source/assumption status | Shows what was verified before implementation and what remains unavailable. |
| Design decision and alternatives | Explains why a method was chosen over plausible alternatives. |
| File change record | Lists every added, modified, renamed, deleted, or reverted file/artifact and why. |
| Automated verification | Records actual unit/integration/UI/negative/regression outcomes; skipped environments are not passes. |
| User acceptance checklist | Gives concrete operations the user can perform and expected visible results/evidence. |
| Not ready to verify yet | Separates later-phase work and known blockers from regressions. |
| Exit evidence and approval | Provides the only valid basis for transitioning to the next Phase. |

### 16.3 Rules for files, checks, and claims

- A deletion must be recorded with exact target, rationale, replacement/migration, recovery path, and user approval when material. A Phase record must never hide deletion by listing only additions.
- User-owned/unrelated files, especially Dashboard credentials and unrelated UI work, remain outside the Phase commit and are marked out of scope in the record.
- Every check records its actual output/status: pass, fail, unavailable, or skipped with reason. “Not run” never becomes “passed.”
- Every acceptance item has a user action, expected result, and inspectable evidence. “The UI looks correct” is not an acceptance criterion.
- The record must identify features deliberately not implemented in this Phase, so the user does not spend time trying to verify later functionality early.
- No record may claim legal fault, certification, a universal ODD boundary, or measured data from an assumption/configuration.

### 16.4 Phase-specific filenames and acceptance focus

| Phase | Record file | User primarily verifies before approval |
| --- | --- | --- |
| A | `PhaseA.md` | recorded/derived collision truth, capability-card statuses, missing-data behaviour, database/artifact links |
| B | `PhaseB.md` | actor-local Replayer label, timestamp/actor match, Evidence Drawer source/units/status, no unsupported cause |
| C | `PhaseC.md` | state-aware scope/citations/limits, guided suggestions, no state change when a suggestion is rejected |
| D | `PhaseD.md` | visible tool proposal, approval before action, audit trail, rejection of unsafe/unregistered tools |
| E | `PhaseE.md` | native versus canonical comparison, non-comparability flags, exploratory-boundary language |
| F | `PhaseF.md` | reproducible demos, model-evaluation evidence, background/source separation, voice safeguards if enabled |
