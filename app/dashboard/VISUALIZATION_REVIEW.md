# Dashboard visualization review

**Scope:** GPL-ODD Analyze UI under `app/dashboard/src/app/batch/[id]/analyze/`, plus how it should connect to Explore (parameter space, projection, Replayer).  
**Date:** 2026-09-14  
**Stance:** research memo only — no UI code changes in this document’s authoring pass.

Related product docs:

- [`app/llm_pipeline/README.md`](../llm_pipeline/README.md)
- [`app/llm_pipeline/prompt_templates/TAXONOMY.md`](../llm_pipeline/prompt_templates/TAXONOMY.md)
- [`results/README.md`](../../results/README.md)
- Root [`README.md`](../../README.md)

---

## 1. Product snapshot

GPL-ODD helps AV engineers **find → explain → aggregate → discuss** behavioral frontiers in scenario-parameter space (ODD-*related* evidence, not a full SAE certificate):

1. Cluster whole trajectories (MFPCA / HDBSCAN).
2. Interpret each cluster medoid with a closed behavior taxonomy (who passed/yielded, how Ego controlled speed, why via motive codes) plus BEV evidence.
3. Contrast **near-identical parameter-space pairs** across clusters (`contrast.yaml`, synced dual BEV).
4. Summarize clusters and judge **neighborhood separation**.
5. Score the partition (selection-eval / cross-eval / clustering-quality) and export ODD boundaries / rules / Q&A.

Visualization must keep **evidence cards**, **geometry**, and **parameter context** linked — not replace them with a single dump or with free-form prose alone.

---

## 2. Current Analyze visualization inventory

Route: `app/dashboard/src/app/batch/[id]/analyze/`  
Orchestrator: `AnalyzeClient.tsx` → seven tabs.

| Tab | Panel | Visual patterns | Primary data |
|-----|--------|-----------------|--------------|
| Model setup | `ModelSetup` | Form, temperature slider | Model / key / dry-run |
| Medoid analysis | `MedoidAnalysis` + `MedoidPanel` + `ResultCard` | Cluster chips; BEV scrubber / grid; decision-timeline scrub; YAML / prose cards | `context_medoid.md`, snapshots, `medoid_trial.yaml` |
| Parameter-space pairs | `ParameterSpacePairs` + `IcPairPanel` | Pair chips; facts table; synced dual BEV scrub; contrast chips + narrative; phase boxes | `process/context.md`, `synced_bev/`, `contrast.yaml` |
| Cluster analysis | `ClusterAnalysis` + `SplitCardsPanel` | Summary cards; neighbor verdict chips; caption prose | `cluster_summary.yaml`, `context_cluster.md` |
| Cross-cluster analysis | `CrossClusterAnalysis` | Ranked config table; selection-quality panel; boundary text compare | `cross_cluster_eval.json`, `cluster_selection_eval.json`, `clustering_quality.json` |
| Report | `Report` | Risk table; motive histogram **CSS bars**; pair evidence table; ODD panels | `GET /api/cluster-run-report` (disk only) |
| ODD Q&A | `OddQA` | Chat + citations | `odd_chat_briefing.json` |

**Present:** chips, tables, BEV image scrubbers, markdown/YAML accordions, linear progress consoles, simple CSS bars.  
**Absent in Analyze:** chart libraries, parameter/embedding scatter, linked brushing across views, BEV↔timeline time sync, multi-cluster compare canvas.

Explore (outside Analyze) already owns parameter-space / projection scatters, heatmaps, and the **video Replayer**.

---

## 3. Strengths

1. **Evidence-backed cards** — closed motive / resolution / separation fields sit next to BEV and context timelines (matches TAXONOMY causal locality).
2. **Synced dual BEV for pairs** — shared-clock left|right panels are the right visual for “matched IC, different cluster.”
3. **Staged artifacts** — medoid → pairs → summary gates prevent orphan judgments.
4. **Partition scores surfaced** — selection-eval and clustering-quality give a non-silhouette behavioral layer.
5. **Report + ODD Q&A** — read-only aggregation path for thesis / operator handoff without re-calling LLMs.

---

## 4. Gaps for AV engineers

1. **Text-heavy judgment** — engineers scrub BEV, then read long YAML narratives; chips help, but prose still dominates the decision moment.
2. **Weak cross-tab linking** — Report / pair chips often jump to a tab, not to a *specific* cluster or pair focus.
3. **BEV scrub ≠ decision timeline scrub** — two independent time controls; easy to look at the wrong frame for a motive stamp.
4. **No Analyze-side parameter / embedding scatter** — coverage and “where is this failure in ODD space?” lives in Explore; Analyze does not brush into cards.
5. **Sequential gates feel like stalls** — blocked summary/pair chips need clearer “what to run next” and deep links.
6. **Duplicate score surfaces** — quality / selection / cross-eval appear in Cross-cluster, SelectionQualityPanel, and Report with overlapping meaning.
7. **One-at-a-time browsing** — chip-indexed viewers; no persistent dual-cluster or cluster-vs-boundary compare layout.
8. **ODD exports often offline** — Report boundary/rules empty until CLI odd-export → rules → join → briefing.

---

## 5. Answers to design questions

### Combine graph and text?

**Yes — linked views, not graph-only and not text-only.**

| Keep as text / chips | Add / strengthen as graph |
|----------------------|---------------------------|
| Motive codes, separation_call, captions | Parameter-space / projection scatter with cluster color + brush → open card |
| Contrast explanation (short) | Coverage / instance-space style 2D of trial features (safe vs collision) |
| Decision timeline entries | Time-aligned BEV + metric sparklines (clearance, TTC, Ego speed) |

Narrative remains necessary for *why* (closed codes + cited stamps). Graphs answer *where / how often / how separated*.

### Video replayer?

**Prefer timed BEV + decision timeline + Explore Replayer sync — not a second full-video player inside Analyze.**

- Analyze already has ego-centered BEV frames at action/conflict stamps (the right fidelity for motive claims).
- Explore Replayer already plays trials; Analyze should **deep-link** (`trial` + `t`) rather than re-implement video.
- Full continuous video is secondary for taxonomy review; stamp-aligned frames are primary.

### How to make analysis smoother?

1. **Sync scrubbers** — selecting a `decision_timeline` / `contrast_timeline` stamp sets BEV frame (and vice versa when a nearest stamp exists).
2. **Deep links** — Report row → Medoid tab with cluster selected; pair row → Pairs tab with that `cA-cB` focused.
3. **Compare canvas** — one screen: two medoid cards *or* one pair dual-BEV + chips-first contrast summary.
4. **Chips before prose** — `motive_contrast`, `separation_call`, resolution, outcome always above long explanation.
5. **Collapse raw YAML** — default to parsed fields; accordion for raw dump.
6. **Single score legend** — one glossary for selection_score vs clustering_quality vs silhouette.

Target linked workflow:

```text
ParamOrProjectionScatter  --brushSelect-->  NarrativeCards
NarrativeCards            --focusStamp--->  SyncedBEVScrubber
NarrativeCards            --focusStamp--->  DecisionTimeline
DecisionTimeline          --syncTime----->  SyncedBEVScrubber
DecisionTimeline          --open--------->  ExploreReplayer
```

---

## 6. Prioritized recommendations

### P0 (highest leverage, small surface)

| ID | Change | Target |
|----|--------|--------|
| P0.1 | Link BEV frame index to timeline stamp (shared `t`) | `MedoidPanel`, `ResultCard`, `IcPairPanel` |
| P0.2 | Deep-link Report / Cross-cluster → focused cluster or pair | `Report`, `AnalyzeClient` tab state |
| P0.3 | Contrast card order: chips → `critical_divergence` → explanation → reason → timeline | `IcPairPanel` (partially done) |

### P1 (engineer compare workflow)

| ID | Change | Target |
|----|--------|--------|
| P1.1 | Dual-pane compare: two clusters or one pair always visible | new compare layout or `SplitCardsPanel` |
| P1.2 | Embed mini param-space / projection thumbnail with current selection brushed | Explore docks ↔ Analyze selection |
| P1.3 | Unify score explanation tooltip (selection vs quality vs silhouette) | `SelectionQualityPanel`, `CrossClusterAnalysis`, `Report` |

### P2 (coverage / ODD visual analytics)

| ID | Change | Target |
|----|--------|--------|
| P2.1 | Instance-space / feature 2D plot of trials (safe vs unsafe) for coverage holes | Report or Explore |
| P2.2 | ODD boundary overlay on parameter scatter when export exists | Explore ParameterSpace + Report panel F/G |
| P2.3 | Optional metric sparklines under pair phases (clearance / TTC / Ego speed) | `IcPairPanel` |

---

## 7. Related papers (2021–2025)

Curated for **scenario testing, ODD, clustering, and visual analytics**. Links are DOI / arXiv / publisher pages.

### Scenario testing & instance space (TOSEM)

1. **Identifying and Explaining Safety-critical Scenarios for Autonomous Vehicles via Key Features**  
   Neelofar & Aleti — *ACM Transactions on Software Engineering and Methodology*, 2024.  
   - [ACM DOI](https://dl.acm.org/doi/10.1145/3640335)  
   - [arXiv](https://arxiv.org/abs/2212.07566)  
   - **Viz takeaway:** 2D instance space of scenario features; safe vs unsafe regions; coverage gaps for new tests.

2. **Instance Space Analysis of Testing of Autonomous Vehicles in Critical Scenarios**  
   — *ACM TOSEM*, 2025.  
   - [ACM DOI](https://dl.acm.org/doi/10.1145/3699596)  
   - **Viz takeaway:** Project test algorithms into the same 2D space; compare how thoroughly each explores critical features.

### Clustering & criticality

3. **Clustering-based Criticality Analysis for Testing of Automated Driving Systems**  
   — arXiv, 2023.  
   - [arXiv](https://arxiv.org/abs/2306.12738)  
   - **Viz takeaway:** Behavior-based vs criticality-based clusters; archetype / hull plots to reduce redundant concrete scenarios.

4. **LLM-informed Geometric Embedding for Behavioural Scenario Retrieval**  
   — *VEHITS 2025*.  
   - [SciTePress](https://www.scitepress.org/publishedPapers/2025/132765/)  
   - **Viz takeaway:** HDBSCAN on geometric+LLM embeddings; natural-language retrieval over unlabeled trajectories (GraphRAG).

### Visual analytics for driving scenarios (PacificVis / TVCG)

5. **Dynamic-Scene-Graph-Supported Visual Understanding of Autonomous Driving Scenarios**  
   — *IEEE PacificVis*, 2024.  
   - [DOI](https://doi.org/10.1109/pacificvis60374.2024.00018)  
   - **Viz takeaway:** Multi-level views (frame semantics → temporal summary → scenario distribution) + interactive subgraph compare for corner cases.

6. **Visual Evaluation for Autonomous Driving**  
   Hou et al. — *IEEE TVCG*, 2021.  
   - [DOI](https://doi.org/10.1109/tvcg.2021.3114777)  
   - **Viz takeaway:** Integrated visual evaluation of AD stacks; spatial-temporal comparison patterns transferable to medoid/pair review.

7. **When, Where and How Does it Fail? A Spatial-Temporal Visual Analytics Approach for Interpretable Object Detection in Autonomous Driving**  
   Wang et al. — *IEEE TVCG*, 2022.  
   - [DOI](https://doi.org/10.1109/tvcg.2022.3201101)  
   - **Viz takeaway:** Failure localization in space and time — same “when/where/how” triad as stamp-aligned BEV + timeline.

### ODD & scenario databases (ICRA / ITSC / Access)

8. **ODD-based Query-time Scenario Mutation Framework for Autonomous Driving Scenario Databases**  
   — *IEEE ICRA*, 2024.  
   - [DOI](https://doi.org/10.1109/icra57147.2024.10610412)  
   - **Viz takeaway:** ODD tags + mutation at query time to raise database utilization; coverage diversity metrics.

9. **Formalizing Vocabulary for Scenario-Based Testing of Automated Driving Systems: From Semantics to Mathematics**  
   — *IEEE ITSC*, 2024.  
   - [DOI](https://doi.org/10.1109/ITSC58415.2024.10919488)  
   - [TUE record](https://research.tue.nl/en/publications/formalizing-vocabulary-for-scenario-based-testing-of-automated-dr/)  
   - **Viz takeaway:** Precise concrete / logical / abstract scenario vocabulary — label UIs and ODD Q&A should reuse closed terms.

10. **Operational Design Domain Monitoring with Uncertain Measurements**  
    — *IEEE ITSC*, 2024.  
    - [HAL](https://hal.science/hal-04829701)  
    - [IEEE Xplore](https://ieeexplore.ieee.org/document/10919733)  
    - **Viz takeaway:** OD membership degree (0–1) and time-to-exit — useful visual for “inside / at / outside ODD boundary.”

11. **ODD and Behavior Based Scenario Generation for Automated Driving Systems**  
    — *IEEE Access*, 2024.  
    - [DOI](https://doi.org/10.1109/access.2024.3350512)  
    - **Viz takeaway:** ODD attributes × behavior competencies as the domain for generation and coverage analysis.

---

## 8. Mapping paper ideas → GPL-ODD

| Paper idea | GPL-ODD fit |
|------------|-------------|
| ISA 2D feature space + coverage % | Report / Explore: plot trials by key features (clearance, TTC, param); mark untested holes for odd-export follow-up |
| Criticality vs behavior clustering | Aligns with whole-trajectory MFPCA clusters vs interaction motives; surface `needs_finer_split` when shapes glue two intents |
| Scene-graph multi-level VA | Pair `contrast_timeline` phases as temporal summaries; keep frame BEV as leaf view |
| When / where / how failure VA | Sync stamp (`t`) across timeline, BEV, and Replayer |
| ODD membership / TTE | Report + ODD Q&A: membership chip when boundary export exists |
| ODD-tagged scenario DB mutation | Parameter-space pairs already mutate “same params, different cluster”; show utilization / diversity next to pair chips |
| Closed SBT vocabulary | Keep TAXONOMY / common_sense closed sets in UI chips; avoid free-form legend drift |
| LLM + HDBSCAN retrieval | ODD Q&A / future search over cluster captions + medoid motives (already narrative-card based) |

---

## 9. Bottom line

- **Do combine graph and text**, with brushing/linking as the design pattern.
- **Do not rebuild a full video player in Analyze**; deepen BEV↔timeline sync and hand off continuous play to Explore Replayer.
- **P0 wins** are time sync + deep links + chips-first contrast layout — they reduce cognitive load without a new chart stack.
- Recent TOSEM / PacificVis / TVCG / ICRA / ITSC work consistently argues for **linked multi-view VA** and **coverage in feature or ODD space**, which matches GPL-ODD’s staged cards better than a single dashboard dump.
