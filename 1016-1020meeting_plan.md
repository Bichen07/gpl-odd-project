# Integrated Implementation Plan: Evidence-Grounded Human–AI Visual Analytics for Autonomous-Driving Safety

**Scope:** This is one integrated plan for the 16 and 20 October 2026 meeting goals. It replaces the previous split between a “1016 plan” and a “1020 extension.” The system is an engineering decision-support and research-demonstration platform. It does not issue legal liability findings, vehicle certification, or universal safety guarantees.

## 0. Evidence audit: current system, gaps, and planning boundary

This section is based on a code inspection on 26 October 2026, not on intended design. “Existing” means an implementation was found. “Partial” means the implementation supports only part of the required claim. “New” means there is no implementation in the inspected paths.

| Capability | Status | Evidence found in the current project | Planning consequence |
| --- | --- | --- | --- |
| Per-frame ego and other-vehicle kinematics | **Existing** | Observations.ts records time, ego speed/acceleration and agent TTC, position, yaw, yaw rate, dimensions, distance, and relative velocity/acceleration fields. | Reuse as recorded evidence for R01–R03 and R05–R10; do not duplicate trajectories. |
| Trial event schema | **Partial** | Trials.ts defines events with name, time, esmini seconds, and observation index. scenario_sampler.py creates in-memory events, but its event PATCH code is commented out. | First implement reliable event persistence before any collision-time or collision-partner claim. |
| Behavior/context artifacts | **Existing** | Analyzer dataset generation writes action.yaml, descriptions, trajectory/context artifacts, and conflict-centred windows. | Extend the vocabulary and provenance; do not replace the existing action/context pipeline. |
| Replayer explanation | **Partial** | replayerCaption.ts and the Replayer render a selected cluster/trial caption and time-aligned timeline. The current model is one caption box per cluster window, not a label beside each actor. | Add actor-local labels and actor/cause links for R02; retain the current cluster caption as a complementary summary. |
| Parameter-space and ODD-boundary export | **Existing, exploratory** | The odd-boundary-export API persists kNN boundary trials, edges, selected KPI, and all-trial parameter rows; it explicitly documents the distance metric. | Use it as a native-space exploratory artifact for R23, not as a certified ODD boundary. |
| ODD Q&A with bounded artifact retrieval | **Existing, narrow** | odd_chat.py uses a closed request list for run briefing, medoid, pair, trial, summary, and BEV artifacts; it emits citations and limits history. | Preserve this allow-list pattern, then add a typed scope router and the broader approved tools required by R13–R21. |
| General agent tools / approvals / audit trail | **New** | No generic semantic-state contract, approval endpoint, or tool audit record was found in the inspected Dashboard and pipeline paths. | Add the constrained tool layer; do not expose shell, arbitrary file, browser, or dashboard-write access to the model. |
| Capability card and avoidability calculation | **New** | There is no versioned capability snapshot/card, sensor-detection record, or deterministic braking/steering replay artifact. | Implement deterministic Analyzer artifacts before allowing LLM explanations of R05–R10 and R24. |
| Cross-scenario semantic alignment | **New** | Current boundary export preserves one run’s parameter space, but no scenario-archetype manifest or canonical cross-scenario feature layer was found. | Keep native spaces separate and add explicit alignment artifacts for R26. |
| GPT-6 Luna default support | **Existing, needs production hardening** | llm_factory.py defaults to gpt-6-luna and routes generic gpt names to ChatOpenAI; Dashboard ODD chat also defaults to Luna. | Do not repeat model migration work. Add server-side credential handling, structured output/tool calling, budget controls, and regression evaluation. |

### 0.1 Verified limitations that must remain visible to users

1. A first sensor-detection time is **not** currently recorded. “First in range” may be used only as a labelled proxy, never as a recorded perception fact.
2. The current event persistence path cannot establish a reliable collision time or partner until the commented persistence code is replaced and tested.
3. A model-generated responsibility statement is an engineering hypothesis. The system must never issue a legal-fault, certification, or safety-guarantee conclusion.
4. A visual or kNN boundary from one parameter space is not automatically comparable with another scenario that has a different actor count or dimensions.

### 0.2 Planned implementation boundary

The first research prototype will use deterministic code for measurements, collision-event resolution, capability calculations, and evidence provenance. The LLM will classify intent, select from registered tools, explain cited results, and suggest next steps. It will not calculate a verdict from prose alone or gain unrestricted computer control.

## 1. Product outcome

The finished system supports one continuous workflow:

1. An analyst explores collision and near-boundary trials in the Heatmap, Parameter Space, Projection Space, and Replayer.
2. The Replayer explains what each vehicle is doing at the current time.
3. A deterministic capability analysis produces an avoidability/responsibility hypothesis with all assumptions and sources visible.
4. A conversational assistant answers questions from the current analysis state, cites evidence, explains uncertainty, and proposes useful next steps.
5. The assistant can use narrowly defined analysis tools after the user approves any state-changing or costly action.
6. The system compares scenario families through semantic alignment without pretending that differently dimensioned parameter spaces are the same ODD boundary.

The core design rule is:

> Deterministic data and physics produce facts; the LLM interprets, explains, routes questions, and plans approved tool use.

---

## 2. Feasibility decision

### Feasible now

- Per-agent behavior labels and interactions already exist in `action.yaml`.
- Collision, near-miss, TTC, trajectory, map/lane, and kinematic analysis are already available in Analyzer artifacts.
- The Dashboard already has Replayer, filtering, lasso selection, parameter/projection views, and selected-trial chat attachments.
- The LLM pipeline already persists run artifacts and conversations.
- Payload already stores trial parameters, KPI values, the raw esmini `.dat`, and per-frame observations.

### Feasible after explicit data and API work

- Capability-aware avoidability and responsibility hypotheses.
- Mixed-initiative Q&A with evidence-linked suggestions.
- General Q&A with reliable “out of scope” handling.
- Approved tool use for summaries, comparisons, navigation proposals, and queued analysis jobs.
- Cross-scenario comparison by scenario archetype and canonical features.
- Voice interaction built on the same verified text workflow.

### Not a valid claim for this project

- “The AI can determine legal fault.”
- “The visualization is a certified ODD boundary.”
- “A single brake figure proves the ADS is safe.”
- “The model understands the dashboard only by looking at screenshots.”
- “Different scenario parameter spaces can be combined without a semantic alignment method.”

---

## 3. Verified data inventory and gaps

### 3.1 Data currently saved by Payload

| Evidence | Current location | Available for analysis? | Notes |
| --- | --- | --- | --- |
| Batch, ego, sampled parameters | `Trial.parameters` | Yes | Stored per trial. |
| KPI value and pass/fail | `Trial.testObjectives.criticalityMetrics` | Yes | Includes values such as collision/TTC when configured by the scenario. |
| Raw simulator recording | `Trial.esminiDat` | Yes | The original `.dat` can be converted/rebuilt into trajectory data. |
| Ego trajectory | `Observation`: position, yaw, road/lane/junction, speed, acceleration, yaw rate, speed/steer commands | Yes | Per-frame data is sufficient to derive observed longitudinal behavior. |
| Other-agent trajectory | `Observation.agents`: position, yaw, road/lane/junction, speed, acceleration, yaw rate, dimensions, relative quantities | Yes | Includes TTC/RSS-related values when emitted by the sampler. |
| Collision partner/event schema | `Trial.events` | Schema exists; persistence is incomplete | See critical gap below. |
| Vehicle dimensions | Observation agent fields; catalog/config files | Partly | Agent dimensions can be per frame; ego dimensions also come from vehicle configuration/catalog files. |

### 3.2 Critical gaps found in the current implementation

1. `app/payload/src/collections/Trials.ts` defines an `events` array, but `single_parameterized_scenario_search.py` creates the trial without `events`.
2. `scenario_sampler.py` collects events, but the later PATCH that would attach them to the trial is commented out.
3. The collision callback currently creates `collisionWith…` with `time: 0` and `esminiSeconds: 0`; this must not be used as the collision time.
4. Payload does **not** store a versioned snapshot of the actual vehicle capability configuration used by a trial: maximum commanded brake, maximum acceleration, lateral limit, jerk/build model, friction, map grade, or controller/RSS/catalog source.
5. Payload does **not** store an actual sensor-detection time. “First seen” therefore cannot be asserted from the current log.
6. Map grade/slope semantics are not guaranteed to be present for every scenario.

### 3.3 Data-status policy for every capability result

Every field in the capability card must use exactly one status:

| Status | Meaning | UI wording |
| --- | --- | --- |
| `recorded` | Directly stored by the current trial/run. | “Recorded from trial observation …” |
| `derived` | Deterministically computed from recorded data. | “Derived from speed samples …” |
| `configured` | Read from a versioned simulator/controller/catalog configuration. | “Configured in RSS ego dynamics …” |
| `assumed` | A documented fallback chosen for demonstration because no measured value exists. | “Assumed for this replay; replace when calibrated data is available.” |
| `unavailable` | Required information is absent. | “Result is insufficient for this component.” |

The UI must never visually hide an `assumed` or `unavailable` status.

---

## 4. Capability and responsibility model

### 4.1 Required capability card

For each trial, write `capability.yaml` beside `action.yaml`. The card must include:

- trial ID, batch, scenario archetype, artifact version, and build time;
- every input with value, unit, status, source path/API record, and source hash/version;
- ego and intruder dimensions, speed, acceleration, relative gap, TTC, lane/road context, and collision time;
- perception instant and its method (`lane_offset`, `first_in_range`, or `unavailable`);
- response delay, brake build, tested braking limits, lateral limits, in-lane geometry result, and road-grade applicability;
- replay trace summaries for every tested limit;
- verdict, explanatory reason codes, uncertainty, and prohibited claims.

### 4.2 Capability sources and demonstrator assumptions

| Capability | Preferred source | Fallback for demonstration | Required label |
| --- | --- | --- | --- |
| Ego observed speed/acceleration/yaw | Payload observations or esmini CSV | Not needed if trajectory exists | recorded/derived |
| Ego brake cap | Versioned `simulation/ros/src/rss/data/parameters.yaml` and selected catalog vehicle | 8.2 and 10.0 m/s² sensitivity runs | configured or assumed |
| Ego comfort deceleration | `sdc/vehicle-configuration/pacifica-1/parameters.yaml` | Display only; never use as emergency brake | configured |
| Lateral limit/geometry | Pacifica configuration and map/lane geometry | Mark unavailable when lane geometry is missing | configured/unavailable |
| Collision partner and contact time | Valid Payload event, esmini event, or analyzer collision resolver | Derive from CSV/ground-truth KPI; label method | recorded/derived |
| Sensor detection | Sensor-model event/log | First-in-range proxy with stated range/bearing | assumed |
| Friction/grade | Scenario/map/environment artifact | Fixed, documented dry/flat assumption for demo only | recorded/assumed |

The first implementation should demonstrate that the system handles both complete and incomplete data honestly. It may analyze a case with assumptions, but it must show the assumptions and support replacing them with calibrated values later.

### 4.3 Allowed result labels

- `unavoidable_under_stated_assumptions`
- `may_be_system_issue`
- `depends_on_capability_limit`
- `insufficient_data`

The word “responsibility” is limited to an engineering hypothesis, for example: “The entering vehicle may be the primary cause under the recorded/assumed conditions.” Legal fault and certification pass/fail are prohibited strings in generated answers.

---

## 5. Target architecture

```text
Dashboard view + user question / voice transcript
                 |
                 v
    analysis_state.json + scope router
                 |
        +--------+---------+
        |                  |
 unsupported           supported / needs tool
        |                  |
        v                  v
 scope explanation   constrained tool planner
                           |
                  user confirmation gate
                           |
                           v
  capability / selection / archetype / run-artifact tools
                           |
                           v
     evidence bundle + deterministic checks + provenance
                           |
                           v
 LLM explanation + suggested next questions + audit event
```

The model never receives shell access, raw database access, or unrestricted browser/computer control. The application owns authentication, tool authorization, execution timeout, rate/cost limits, and confirmation state.

---

## 6. File-by-file implementation plan

### 6.1 Payload and simulation data capture

| File / folder | Change |
| --- | --- |
| `app/payload/src/collections/Trials.ts` | Add a `capabilitySnapshot` group: schema version, simulator/config hashes, values/status/source for longitudinal/lateral/sensing/road assumptions, and a link or JSON summary for the generated capability card. Add an `analysisArtifacts` group for current card/version and provenance. Keep this compact; do not duplicate per-frame data. |
| `app/payload/src/collections/Observations.ts` | Keep current kinematics. Add sensor detection fields only if the simulator can emit them; do not fabricate a detection column. Add an observation schema migration/test if fields are introduced. |
| `app/payload/src/payload-types.ts` | Regenerate after Payload schema changes; do not hand-edit generated types. |
| `simulation/ros/src/scenario_search/src/scenario_search/scenario_sampler.py` | Record collision timestamp from `current_observation`; set real `time`, `esminiSeconds`, and observation index. Re-enable or replace the event PATCH only after the trial exists. Include event source/method. |
| `simulation/ros/src/scenario_search/src/scenario_search/single_parameterized_scenario_search.py` | On trial creation, persist a capability snapshot manifest or enqueue an idempotent post-trial update. Include event references once observation IDs exist. |
| `simulation/ros/src/rss/data/parameters.yaml` | Treat as a versioned configured source; do not modify it for a demonstration. The snapshot records its hash and selected values. |
| `sdc/vehicle-configuration/pacifica-1/parameters.yaml` | Treat as a versioned geometry/controller source; do not use its comfort deceleration as emergency braking. |
| `simulation/ros/src/scenario/data/resources/xosc/Catalogs/Vehicles/VehicleCatalog.xosc` | Resolve the actual selected vehicle, rather than reading the first catalog entry. Record catalog performance limits and source hash. |
| `app/payload/tests/` | Add API tests for valid event persistence, capability snapshot validation, and protection against missing required provenance fields. |

### 6.2 Deterministic Analyzer artifacts

| New or changed file | Responsibility |
| --- | --- |
| `app/analyzer/src/capability_sources.py` **new** | Read and hash RSS, Pacifica, catalog, map, Payload trial, and trajectory sources; return normalized values with status/source metadata. |
| `app/analyzer/src/capability_analysis.py` **new** | Determine perception proxy, replay braking with delay/build, test both braking caps, test in-lane swerve where geometry exists, and emit verdict/reason codes. |
| `app/analyzer/src/capability_schema.py` **new** | Typed card schema and validation; rejects unitless or provenance-free capability values. |
| `app/analyzer/config/capability_assumptions.yaml` **new** | Version-controlled demonstrator fallbacks: sensing range/bearing, response/build profile, friction/grade defaults, tolerance. Every fallback must include rationale and applicability. |
| `app/analyzer/src/dataset_builder.py` | Build `processed/capability.yaml` immediately after `action.yaml`; add it to context/artifact manifests. |
| `app/analyzer/src/collision_vehicle.py` | Prefer a valid persisted event, otherwise preserve its existing CSV/KPI resolution path and record which source won. |
| `app/analyzer/src/description.py` | Render a concise, non-legal capability/avoidability sentence only from the card. |
| `app/analyzer/src/controller.py` | Add read-only endpoints for a trial capability card and an archetype comparison; add an approved-job endpoint only after Phase 4. |
| `tests/test_capability_sources.py` **new** | Test source precedence, hashes, unknown/missing values, and fallback labeling. |
| `tests/test_capability_analysis.py` **new** | Synthetic late cut-in, early-visible cut-in, 8.2/10.0 disagreement, missing lanes, and no-brake cases. |
| `tests/test_payload_event_persistence.py` **new** | Test nonzero collision time, trial event linkage, and event/trajectory consistency. |

### 6.3 LLM pipeline and agent tools

| New or changed file | Responsibility |
| --- | --- |
| `app/llm_pipeline/python/llm_pipeline/llm_factory.py` | Add the selected OpenAI model IDs through a generic `is_openai_model()` branch, rather than limiting support to `gpt-4*`/`gpt-5*`. Keep provider keys server-side. |
| `app/llm_pipeline/python/llm_pipeline/agent_schemas.py` **new** | Pydantic/JSON schemas for question classification, scope status, citations, tool calls, analysis plans, approvals, and response cards. |
| `app/llm_pipeline/python/llm_pipeline/agent_tools.py` **new** | Implement the allow-listed read-only tools below. No shell, arbitrary URL, or arbitrary file-path tool is permitted. |
| `app/llm_pipeline/python/llm_pipeline/agent_router.py` **new** | Route questions: interface guidance, data-grounded, general background, analysis request, unsupported. Build an evidence bundle from the semantic state. |
| `app/llm_pipeline/python/llm_pipeline/agent_audit.py` **new** | Append structured audit events: intent, input state hash, tool calls/results, confirmation, model/version, token usage, and final citations. |
| `app/llm_pipeline/python/llm_pipeline/odd_chat.py` | Reuse conversation history but call the router/tool layer before drafting an answer. Keep current ODD briefing as one evidence source, not the only source. |
| `app/llm_pipeline/prompt_templates/agent_system_prompt.txt` **new** | Define scope vocabulary, required evidence format, prohibited legal/certification claims, and refusal behavior. |
| `app/llm_pipeline/prompt_templates/visual_semantics_prompt.txt` **new** | Explain the semantic-state schema and the meanings of Heatmap, Parameter Space, Projection Space, Replayer, filters, selections, and capability cards. |
| `app/llm_pipeline/python/llm_pipeline/paths.py` | Register paths for `capability.yaml`, `analysis_state.json`, `agent_audit.jsonl`, and generated scenario-archetype artifacts. |
| `tests/test_agent_router.py` **new** | Test scope classification, citations, unsupported/legal requests, and malformed tool calls. |

### 6.4 Dashboard and user control

| New or changed file | Responsibility |
| --- | --- |
| `app/dashboard/src/app/batch/[id]/_tabs/explore/lib/analysisState.ts` **new** | Build a versioned `analysis_state.json` from Redux: view type, encodings, filters, selection, time, available operations, evidence, and limits. |
| `app/dashboard/src/app/batch/[id]/_tabs/explore/components/dock/chatContext.tsx` | Extend the chat attachment with semantic-state version/hash and explicit user intent. |
| `app/dashboard/src/app/batch/[id]/_tabs/explore/components/dock/ChatDrawer.tsx` | Show answer scope status, evidence citations, assumption badges, tool activity, approval requests, and suggested next questions. |
| `app/dashboard/src/app/batch/[id]/_tabs/explore/components/dock/panels/Replayer/index.tsx` | Draw current action verb per vehicle and the capability verdict line; show an assumption warning instead of hiding uncertainty. |
| `app/dashboard/src/app/batch/[id]/_tabs/explore/components/dock/panels/ParameterSpace/` | Render responsibility/avoidability marks only from deterministic cards; preserve current cluster IDs and coordinates. |
| `app/dashboard/src/app/api/odd-chat/route.ts` | Keep it as compatibility path; replace client-supplied API key handling in production with server-side configuration and route questions through the agent router. |
| `app/dashboard/src/app/api/analysis-agent/route.ts` **new** | Create/read-only tool-request endpoint. Validate batch/run identity, state schema, user intent, and tool schemas. |
| `app/dashboard/src/app/api/analysis-agent/approve/route.ts` **new** | Require an explicit approval token before navigation, writing, or job execution. |
| `app/dashboard/src/app/api/analysis-agent/jobs/[id]/route.ts` **new** | Read job status/log/output only; jobs run in Analyzer under a bounded allow-list. |
| `app/dashboard/src/app/_shared/utils/` | Add visualization glossary data and response evidence types. |

---

## 7. Tool policy and agent operation

### Read-only tools: no confirmation required

| Tool | Inputs | Output |
| --- | --- | --- |
| `describe_current_view` | `analysis_state` | encodings, filters, visible limits, and glossary explanation |
| `get_trial_evidence` | `trial_id` | action, collision, capability card, assumptions, and artifact refs |
| `summarize_selection` | selected trial IDs | aggregate outcomes with cited trial IDs |
| `compare_scenario_archetypes` | archetype IDs | aligned features, non-comparable fields, distributions, and coverage |
| `search_run_artifacts` | typed artifact query | only registered artifacts inside the current run |

### Planning tools: no execution without a later confirmation

| Tool | Output |
| --- | --- |
| `propose_analysis` | method, inputs, expected artifacts, cost/time estimate, scope status |
| `propose_navigation` | view/filter/time target and a human-readable reason |

### Confirmed tools only

| Tool | Confirmation requirement |
| --- | --- |
| `run_analysis` | user approves an exact `plan_id`; server checks cost/time limit |
| `apply_navigation` | user approves the target state; UI visibly applies it |
| `save_human_assessment` | user explicitly submits the form |
| `export_report` | user selects export destination and confirms |

The model never receives a generic “execute code,” “browse arbitrary sites,” “read arbitrary file,” or “edit dashboard state” function. This is more reliable than using computer-use to click the UI because every action has typed semantics and can be audited.

---

## 8. LLM, API-token, and cost plan

### 8.1 Decision: use GPT-6 Luna as the default

Use `gpt-6-luna` as the default model for the Dashboard LLM analysis, Q&A, guided suggestions, and constrained tool planning. Its public Standard price is lower than Gemini 2.5 Flash for both input and output tokens: approximately USD 0.0009 rather than USD 0.0037 for a 4k-input/1k-output text turn. Gemini 2.5 Flash remains a configured fallback and evaluation baseline so that the current available Google quota can be used for rollback and evidence-based comparison.

Price alone does not establish task quality. Before the default is enabled for every user route, run the fixed project evaluation suite and smoke-test structured responses, citations, scope limits, and permitted tool arguments. Provider choice affects language, routing, structured planning, and optional tool-call selection only; deterministic code remains responsible for physics, evidence extraction, and capability verdicts.

### 8.2 Cost and capability comparison

Prices below are public paid-tier, short-context text prices per 1 million tokens, checked on 23 October 2026. Gemini output pricing includes thinking tokens. Actual billing depends on prompt size, output length, caching, thinking budget, tool calls, and service tier; recheck official pricing before deployment.

| Model | Provider | Input / 1M | Output / 1M | Example: 4k input + 1k output | Role in this project |
| --- | --- | ---: | ---: | ---: | --- |
| `gpt-6-luna` | OpenAI | USD 0.10 | USD 0.50 | about USD 0.0009 | **Default.** Grounded Dashboard answers, guided Q&A, and schema-constrained tool plans. |
| `gemini-2.5-flash` | Google | USD 0.30 | USD 2.50 | about USD 0.0037 | Fallback and controlled baseline; retain current quota for comparison or incident rollback. |
| `gemini-2.5-flash-lite` | Google | USD 0.10 | USD 0.40 | about USD 0.0008 | Optional high-volume classification/formatting model after separate validation. |
| `gpt-4.1-nano` | OpenAI | USD 0.10 | USD 0.40 | about USD 0.0008 | Do **not** adopt for new work: OpenAI labels it deprecated. |
| `gpt-6.1-sol` | OpenAI | USD 2.00 | USD 10.00 | about USD 0.018 | Optional offline comparison for difficult tool plans, not the normal default. |
| `gpt-6-astra` | OpenAI | USD 10.00 | USD 50.00 | about USD 0.090 | Offline expert baseline only; never use for routine Dashboard turns. |

For non-interactive batch evaluation, OpenAI Batch/Flex pricing is lower than Standard pricing, but it is not appropriate for an interactive Dashboard turn.

### 8.3 Routing policy

| Request type | Initial model | Rule |
| --- | --- | --- |
| Normal grounded Dashboard answer | `gpt-6-luna` | Attach deterministic evidence, source IDs, and scope status to every answer. |
| Intent/scope classification and low-risk suggestions | `gpt-6-luna` | Require a validated structured response; use the Gemini fallback if validation or service health fails. |
| Capability/avoidability result | No LLM for calculation | Analyzer produces the card and verdict; Luna only explains cited card fields. |
| Agent tool plan | `gpt-6-luna` | Tool arguments must pass JSON-schema and policy validation before an approval step. |
| Provider fallback / regression comparison | `gemini-2.5-flash` | Use the same evidence bundle; never silently change the deterministic result. |
| Difficult offline review | `gpt-6.1-sol` or `gpt-6-astra` | Limited budget, human review, never automatic system action. |

### 8.4 Required provider changes, credentials, and token controls

1. **Completed:** `DEFAULT_MODEL` is `"gpt-6-luna"` in `app/llm_pipeline/python/llm_pipeline/llm_factory.py`.
2. **Completed:** the factory uses generic `is_openai_model()` detection, so `gpt-6-luna` constructs a `ChatOpenAI` client rather than relying on a hard-coded gpt-4/gpt-5 list.
3. **Completed:** the Dashboard route/model selection includes `gpt-6-luna`, and the ODD chat route defaults to it. Gemini remains selectable for fallback and comparison.
4. Provision a new server-only `OPENAI_API_KEY`; it is now required for the default path. Keep the existing `GOOGLE_API_KEY` server-only for fallback and comparison. Neither key may appear in `NEXT_PUBLIC_*`, client request bodies, source control, prompts, or logs.
5. Set server-only configuration: `LLM_DEFAULT_PROVIDER=openai`, `LLM_DEFAULT_MODEL=gpt-6-luna`, `LLM_ROUTER_MODEL=gpt-6-luna`, `LLM_GEMINI_FALLBACK_MODEL=gemini-2.5-flash`, `LLM_MAX_OUTPUT_TOKENS`, and `LLM_DAILY_BUDGET_USD`. Keep `PAYLOAD_API_KEY` separate.
6. Use OpenAI Responses-compatible structured outputs and registered tools only. Record provider, model ID, input/output tokens when supplied, tool-call count, latency, estimated cost, fallback reason, and evaluation result in `agent_audit.jsonl`. Never record secrets or authorization headers.
7. Add a daily cost ceiling and per-request maximum output budget before exposing the default model. On provider/API failure, return a safe grounded error or use the configured Gemini fallback; do not retry an unsafe tool action.

### 8.5 Migration gate and ongoing evaluation

Create `app/llm_pipeline/qa_checks/agent_model_eval.json` with at least 40 fixed cases: visualization explanation, selected-trial factual question, capability-card explanation, missing-data disclosure, legal-liability refusal, allowed tool plan, malformed tool call, and cross-scenario non-comparability.

Before enabling Luna in each route, run GPT-6 Luna and Gemini 2.5 Flash on the identical evidence bundle. Compare valid JSON/schema rate, citation accuracy, unsupported-claim rate, scope status, valid tool arguments, latency, actual token use, and cost. The migration passes only if Luna produces no unsupported capability or responsibility claim, meets the route's schema/citation requirements, and its tool plan passes policy validation. If a route fails, direct that route to the Gemini fallback while fixing the prompt, schema, or implementation; do not replace deterministic analysis with an LLM answer.

---
## 9. Cross-scenario ODD plan

A single scenario family can have a useful sampled parameter-space boundary. It is not automatically comparable to another family with different actors or dimensions.

### Required artifacts

- `scenario_manifest.json`: schema version, road topology, maneuver, ego/other actor roles/counts, parameter names/units/ranges, map, weather/road state, simulator/config versions.
- `scenario_archetype.yaml`: stable archetype identifier and comparison rules.
- `cross_scenario_features.parquet` or `.csv`: canonical features plus units, status, missingness, and source.
- `cross_scenario_summary.json`: distributions, coverage, result population, non-comparable dimensions, and links to native views.

### Canonical comparison features

- road topology and junction class;
- maneuver/conflict type;
- ego and other-actor count/roles;
- relative speed, gap, minimum TTC, required deceleration, braking margin;
- collision/near-miss outcome and capability verdict;
- scenario coverage and uncertainty flags.

Native parameter plots remain the truth for each archetype. Linked views compare canonical features across archetypes. A common high-dimensional risk model is an explicitly experimental later stage; validate it on held-out scenario families and never call it a universal ODD boundary.

---

## 10. Implementation phases and acceptance criteria

### Phase A — Data truth and capability analysis

Implement event persistence, capability snapshots, source resolution, card generation, and synthetic tests.

**Done when:** every card shows recorded/derived/configured/assumed/unavailable status; a collision event has nonzero time or a documented derived method; all four verdicts are covered by automated tests.

### Phase B — Replayer and evidence-first explanation

Render vehicle verbs and verdicts, add assumption badges, and build capability citations into existing trial/context artifacts.

**Done when:** scrubbing changes labels correctly; a viewer can identify the braking vehicle and see why a verdict is provisional.

### Phase C — Semantic state and guided Q&A

Publish `analysis_state.json`, add the visualization glossary, scope router, citations, and non-executing suggested next questions.

**Done when:** interface questions are grounded in state; unsupported/legal requests return an explicit limit and engineering alternative; rejecting a suggestion changes nothing.

### Phase D — Constrained agent tools

Implement read-only tools, schema validation, audit trail, planning, approval, and bounded analysis jobs.

**Done when:** no unregistered tool can be called; navigation/jobs require confirmation; a reviewer can replay intent, evidence, tool result, and answer.

### Phase E — Cross-scenario comparison

Build manifests/archetypes/canonical features and linked views.

**Done when:** the UI exposes non-comparable dimensions; every comparison identifies its population/schema; no shared plot overclaims an ODD boundary.

### Phase F — Human–AI evaluation and voice

Run task-based evaluation, then add push-to-talk through the same backend workflow.

**Done when:** study measures evidence accuracy, tool validity, user control, task success, time, and uncertainty calibration; voice cannot bypass confirmation.

---

## 11. Evaluation matrix

| Area | Metric | Required test |
| --- | --- | --- |
| Capability facts | provenance completeness; card-schema validity | Missing source or unit fails card validation. |
| Avoidability | expected synthetic verdict | 8.2/10.0 disagreement returns `depends_on_capability_limit`. |
| Event reliability | valid persisted/derived contact time | Zero timestamp is rejected unless explicitly marked unavailable. |
| LLM grounding | citation precision/recall; unsupported-claim rate | Collision statements cite correct card/trial. |
| Tool safety | tool-schema validity; unauthorized-call rate | No generic shell/file/browser call can be issued. |
| User control | confirmation compliance; cancellation success | Navigation/job does not run before approval. |
| Guidance | acceptance/rejection/edit rate; interruption burden | Suggestions are useful and dismissible. |
| Cross-scenario | schema alignment; held-out archetype performance | Actor-count mismatch is exposed, not silently merged. |
| Collaboration | task success, time, corrections, confidence | Analyst can reproduce answer evidence from audit record. |

---

## 12. References

### Visual analytics and human–AI collaboration

- H. Shen et al., [Towards Natural Language Interfaces for Data Visualization: A Survey](https://doi.org/10.1109/TVCG.2022.3148007), *IEEE TVCG*, 2023.
- A. Monadjemi et al., [A Scoping Review of Mixed Initiative Visual Analytics in the Automation Renaissance](https://doi.org/10.1111/cgf.70434), *Computer Graphics Forum*, 2026.
- M. D. C. de Andrade et al., [Talking to Data: A Systematic Review of the Rise of Conversational Agents for Visual Analytics](https://doi.org/10.1109/ACCESS.2025.3638950), *IEEE Access*, 2025.

### Production interaction references

- [Tableau Agent in Pulse](https://help.tableau.com/current/online/en-us/pulse_ask_discover_qa.htm): scoped conversational analytics, suggested questions, and evidence-linked insights.
- [Conversational Analytics in Looker](https://docs.cloud.google.com/looker/docs/conversational-analytics-overview): semantic-model grounding and governed data agents.
- [Copilot in Power BI reports and semantic models](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-reports-overview): report-scoped Q&A and source-visual references.

### OpenAI implementation and pricing

- OpenAI official documentation: [Responses API overview](https://developers.openai.com/api/reference/responses/overview), [Using tools](https://developers.openai.com/api/docs/guides/tools), and [Computer use](https://developers.openai.com/api/docs/guides/tools-computer-use).
- OpenAI official documentation: [Models](https://developers.openai.com/api/docs/models), [Pricing](https://developers.openai.com/api/docs/pricing), and [Voice agents](https://developers.openai.com/api/docs/guides/voice-agents).

### Google model pricing

- Google AI for Developers, [Gemini Developer API pricing](https://ai.google.dev/gemini-api/docs/pricing): Gemini 2.5 Flash and Flash-Lite paid-tier, batch, caching, grounding, and free-tier terms.

### ODD and scenario semantics

- M. K. Al-Mutawalli et al., [Online Identification of Operational Design Domains of Automated Driving System Features](https://doi.org/10.1109/IV55156.2024.10588716), *IEEE Intelligent Vehicles Symposium*, 2024.
- [Trustworthy Compiler Design for Generating Concrete Scenarios Toward Certifying Autonomous Driving Safety](https://ieeexplore.ieee.org/document/10582462/), IEEE, 2024.

---

## 13. Requirement-to-implementation trace

This is the completion contract for the meeting record. Every R identifier from 1016-1020meeting.md has a concrete implementation location, an acceptance check, and an evidence source. A row is not “done” merely because an LLM can produce a plausible sentence.

| Requirement | Existing foundation | Planned implementation and file area | Acceptance evidence |
| --- | --- | --- | --- |
| R01 behavior vocabulary | action.yaml and context artifacts exist. | Extend Analyzer action schema and provenance in the Section 6.2 pipeline; add explicit actor, time interval, evidence fields, and supported/missing behavior vocabulary. | Fixture trajectories produce expected longitudinal, lateral, vehicle–vehicle, and vehicle–environment labels with source timestamps. |
| R02 actor-local Replayer labels | Current Replayer has one cluster/trial caption and timeline. | Phase B: extend Replayer panel and add an action-annotation DTO from Analyzer. | At any scrubbed frame, a reviewer can identify the labelled actor and, when known, the causal actor/obstacle; no ambiguous global-only label. |
| R03 qualitative/quantitative balance | Speed, acceleration, TTC, distance, and relative state fields exist. | Phase B: annotation card links each phrase to measurements, units, and local context; add progressive disclosure instead of permanent dense tables. | Every displayed qualitative claim opens its quantitative evidence; context-sensitive thresholds are shown or the label is withheld. |
| R04 constrained engineering agent | ODD chat already has a closed artifact request list. | Phase C/D: agent router, typed schemas, allow-listed tools, and audit events in Section 6.3. | Attempted request for shell, arbitrary path, URL, or unregistered operation is rejected and logged. |
| R05 first-perception timeline | Trajectories can show physical position, not sensor detection. | Phase A: add sensor event field only when simulator emits it; otherwise compute a named first-in-range proxy with input geometry and status. | Card reports recorded, assumed proxy, or unavailable; it never represents a proxy as sensor fact. |
| R06 avoidability versus responsibility | Collision and TTC-related values exist; no capability verdict exists. | Phase A: capability analysis returns engineering labels only and explanation prohibition rules in the agent prompt/router. | Synthetic unavoidable, avoidable-no-brake, and insufficient-data cases yield the correct non-legal label and cited inputs. |
| R07 capability and improvement paths | Vehicle/configuration files exist, but no per-trial snapshot exists. | Phase A: source resolver, version hashes, capability snapshot and sensitivity runs for brake, acceleration, lateral limit, delay, and assumptions. | Changing a configured or assumed limit changes a reproducible card; all values have units, source, and status. |
| R08 road context and dynamics | Road/lane/junction fields are available; grade/right-of-way are not guaranteed. | Add map/road resolver and mark absent grade/right-of-way unavailable; require human review text for responsibility hypotheses. | A missing map field produces unavailable, not a fabricated slope/right-of-way conclusion. |
| R09 physics-grounded LLM | Existing chat uses run artifacts and citations. | Give the LLM only validated card/evidence DTOs; validate unit-bearing explanation references and prohibit unsupported physics claims. | Evaluation cases catch a wrong-sign acceleration, uncited number, or unsupported causal claim. |
| R10 brake and total response time | Observed control/kinematic values exist; an end-to-end budget does not. | Capability model records sensing/proxy, perception-processing, decision, actuation, and build delays separately. | Card shows every component and status; no human-comparison claim appears without a cited selected benchmark. |
| R11 broader analytical assistance | Current chat retrieves briefing/pair/trial data only. | Add proposed re-filter, re-draw, and reinterpret actions as non-executing plans; allow execution only through confirmed tools. | User can inspect, edit, reject, or approve each plan; rejection changes no analysis state. |
| R12 regulatory and crash context | No cited project background layer. | Add a research/background registry that links VSCC review and NHTSA materials separately from trial evidence. | UI and report label external source as background; it is never cited as proof of a project-trial fact. |
| R13 recursive Q&A | Existing chat preserves a bounded history. | Add suggested next questions and state-derived analysis suggestions after an answer; use a dismissible, non-executing UI. | Suggestions cite current selection/state and can be dismissed without side effect. |
| R14 general versus grounded Q&A | Current ODD chat is run-grounded only. | Router emits scope: data-grounded, interface/method, general background, analysis request, or unsupported. | Evaluation set verifies source badge, citation policy, and out-of-scope response for all five routes. |
| R15 model comparison | Luna and Gemini factory support exist. | Run fixed evaluation set under both providers; compare schema validity, citation accuracy, latency, cost, and unsupported claims. | Default selection is backed by saved evaluation results, not cost or marketing alone. |
| R16 scope disclosure | Missing-data text exists in ODD chat prompts/briefing. | Standardize scope/status response card with data, semantics, method, permission, and tool limits. | Legal, unavailable-data, and unavailable-tool prompts return a clear limit plus a supported next step. |
| R17 auditable tool use | Current retrieval is allow-listed but not a general tool framework. | Implement typed read-only tools, policy validator, request identity checks, audit log, and confirmation for state/cost changes. | All calls appear in audit record; malformed arguments and unauthorized tools are rejected before execution. |
| R18 human-controlled policy | No visible intent/approval object was found. | Dashboard semantic state includes extracted intent, objective, proposed plan, assumptions, expected output, and confirmation token. | User can edit/reject the visible plan; the server rejects stale or unapproved plan IDs. |
| R19 interface-pattern benchmark | Current Dashboard offers specialized visual views. | Review Tableau/Power BI/Looker patterns; adopt only scoped Q&A, source visual/evidence references, feedback, and governed semantic-state concepts. | Design rationale records each adopted/rejected pattern and a task evaluation checks it with scenario analysts. |
| R20 human–AI collaboration | Existing chat is primarily result Q&A. | Phase C: guided evidence checks; Phase F: evaluate task success, control, correction, confidence, and interruption burden. | Human study/proxy evaluation reports both task result and collaboration metrics, not only model quality. |
| R21 machine-readable visualization semantics | Redux holds interaction state but no versioned agent contract was found. | Add analysisState builder with view, encodings, filters, selection, time, units, available operations, and limitation flags. | Same visible state serializes deterministically; agent answer cites state hash/version and does not rely solely on screenshot reading. |
| R22 voice | No voice workflow was found. | Phase F only: push-to-talk feeds the same transcript, router, plan, approval, and evidence UI as text. | Voice cannot invoke an action that typed input cannot invoke; transcript and confirmation are stored. |
| R23 native ODD-boundary exploration | Existing kNN export and parameter views. | Add scenario manifest/archetype and explicitly label native-space boundary method, metric, sensitivity, coverage, and uncertainty. | Boundary report names the scenario family, dimensions, metric, and sample coverage; it does not say certified ODD. |
| R24 single-case collision analysis | Observations, TTC/collision metrics, and trajectories exist. | Combine event resolver, capability card, perception status, evidence links, and non-legal narrative in one case-review workflow. | Demo case opens trajectory, capability card, assumptions, cited explanation, and improvement hypotheses from one trial ID. |
| R25 paper demonstration | Existing Dashboard views and cluster workflow. | Create three fixed demonstration scenarios and a script covering question, evidence, interaction, outcome, limitation, and application. | Reproducible demo checklist and archived artifacts run without undocumented manual steps. |
| R26 cross-scenario comparison | One run’s parameter export exists; no cross-run semantic alignment. | Create scenario manifest, archetype rules, canonical feature dataset, non-comparability flags, and linked native views. | Different actor counts retain separate native plots; only compatible canonical features are compared and missingness is visible. |
| R27 reusable methods and complete data analysis | Analyzer, Dashboard, clustering, and ODD chat artifacts already exist. | Reuse existing artifacts through one evidence-bundle schema; assess external systems/models only through the fixed evaluation set. | Every answer identifies available/missing artifacts; no inferred field appears without recorded/derived/configured/assumed/unavailable status. |

---

## 14. Research basis and final design decisions

### 14.1 Sources consulted for this plan

| Source | What it establishes for this project | Decision derived from it |
| --- | --- | --- |
| [Shen et al., Towards Natural Language Interfaces for Data Visualization](https://doi.org/10.1109/TVCG.2022.3148007) | A visualization NLI spans query interpretation, transformation, visual mapping, view transformation, interaction, dialogue, and presentation. | Do not treat chat as a text box added to the Dashboard. Use semantic state, scope routing, and visual operations as separate components. |
| [Monadjemi et al., Mixed-Initiative Visual Analytics review](https://doi.org/10.1111/cgf.70434) | Mixed-initiative systems distribute goal, action, cognitive, and decision contributions between analyst and automation. | The agent may suggest/plan and execute constrained read-only work, while the analyst keeps approval over changes, jobs, and conclusions. |
| [Power BI Copilot report and semantic-model guidance](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-reports-overview) | Production analytical copilots scope answers to report/semantic-model data and can reference contributing visuals. | Make the Q&A scope explicit and attach evidence/state citations; distinguish data-grounded answers from general knowledge. |
| [Power BI semantic-model access controls](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-semantic-models) | AI access is governed at the semantic-model level and can be disabled for readers. | Make the Dashboard's semantic state and tool permission policy server-controlled rather than trusting a client prompt. |
| [ASAM OpenODD 1.0](https://www.asam.net/standards/detail/openodd/) | ODDs benefit from a machine-readable model/exchange representation. | Use versioned scenario manifests/archetypes and preserve each native parameter space; do not force heterogeneous scenarios into one false coordinate system. |
| [NHTSA Standing General Order crash reporting](https://www.nhtsa.gov/laws-regulations/standing-general-order-crash-reporting) | ADS/ADAS crash reporting is structured context, but is not a legal-fault dataset or project-trial evidence. | Use NHTSA only as cited scenario/background material; keep its records separate from deterministic project findings. |
| [OpenAI Structured Outputs](https://developers.openai.com/api/docs/guides/structured-outputs) and [Function Calling](https://developers.openai.com/api/docs/guides/function-calling) | Structured response schemas and strict function schemas support application-controlled tool integration. | Use typed schemas, strict validation, and allow-listed tools; the model proposes calls but the application enforces policy and confirmation. |
| [OpenAI GPT-6 Luna model page](https://developers.openai.com/api/docs/models/gpt-6-luna) and [pricing](https://developers.openai.com/api/docs/pricing) | Luna is positioned for focused, high-volume work; current Standard short-context prices are USD 0.10 input and USD 0.50 output per million tokens. | Retain Luna as the routine default, but require route-level evaluation and budgeting before production agent/tool use. |
| [Gemini 2.5 Flash pricing](https://ai.google.dev/gemini-api/docs/pricing) | Current paid-tier text/image/video pricing is USD 0.30 input and USD 2.50 output per million tokens, with separate thinking/caching terms. | Keep Gemini 2.5 Flash as a controlled fallback and baseline using the same evidence bundle; do not silently mix providers. |

### 14.2 Why this plan uses deterministic artifacts plus a constrained LLM

1. **Safety and scientific validity:** capability, collision timing, and physical constraints are claims that need reproducible equations and sources, not fluent text. The capability card makes uncertainty inspectable.
2. **Human–AI collaboration:** research and production systems both support scoped, evidence-aware assistance. The plan therefore adds suggestion and explanation before autonomous action, with visible approvals for every state-changing or costly operation.
3. **Faithful visualization semantics:** the dashboard already has rich interactive state. Passing a versioned semantic-state object is more reliable and auditable than asking a VLM to infer hidden filter, unit, or selection meaning from pixels.
4. **Scalable ODD analysis:** ASAM OpenODD supports machine-readable context. Native parameter spaces plus canonical comparison features preserve the meaning of different actor counts instead of flattening them into a misleading universal boundary.
5. **Cost and evaluation discipline:** Luna is economical for frequent structured turns, while Gemini remains a concrete fallback/baseline. Neither model decides physics or responsibility; both must pass the same grounded evaluation before use on a route.
