# Implementation Plan (Living)

**Scope:** `gpl-odd-project/` only.  
**Mode:** plan + checklist. Implement only after a checklist item is approved.  
**Thesis goal:** help engineers **find → explain → aggregate → discuss** candidate
safety / behavior frontiers in scenario-parameter space (ODD-*related* evidence,
not a full SAE ODD certificate).

---

## 1. Rules (do not break)

### Do not change (frozen)

- [x] Medoid product (prompts, `context_medoid.md` flow, BEV, `medoid_trial.yaml`)
- [x] Parameter-space pair product (prompts, `process/context.md`, synced BEV, `contrast.yaml`)
- [x] Closed motive vocabulary in `common_sense.txt`
- [x] Explore Replayer / Analyze readers of existing YAML keys
- [x] Dataset builder layout under `results/batch*/…` for medoid + pairs



### Do change / build (only these)

- [x] **S0** Trust cluster summaries on thesis runs
- [x] **S1** Run report tab (assemble artifacts; no new trajectory LLM)
- [x] **S2** ODD boundary export from Explore filters (+ Python CLI twin)
- [x] **S3** Parameter rules (shallow CART on scenario params)
- [x] **S4** Join boundary ↔ parameter-space pairs
- [x] **S5** ODD Q&A over a compact briefing (CLI shipped; browser chat UI not built — see §9 S5)



### Hard engineering rules

1. New work **reads** medoid / pair / summary YAML — it does not rewrite their prompts.
2. Numeric ODD limits come from **code**. LLM may paraphrase, never invent thresholds.
3. Chat answers only from on-disk briefing; missing data → unknown + which product to run.
4. Prefer deterministic exports before any new LLM call.
5. Auth for LLM = **API key** (same as Analyze today), not a browser Google/OpenAI login.
6. No plans or artifacts outside `gpl-odd-project/`.

---



## 2. Validation procedure (check first, then judge the plan)



### 2.1 What to check / search (master list)

Do these **before** writing production code. Status updated 2026-08-21.

#### A. Repo facts (must match the plan)


| #   | Check                                                          | Status   | Finding                                                                                                                                                                                                                                                       |
| --- | -------------------------------------------------------------- | -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| A1  | Does Explore boundary kNN use scenario parameters or MFPCA?    | **Done** | Scenario parameters only (`trial.parameters` → KD-tree in `batch.ts`). Not embedding coords.                                                                                                                                                                  |
| A2  | Is Explore distance the same as parameter-space pair distance? | **Done** | **No.** Explore: L2 after **min–max normalize** by each param’s `[min,max]`. Pairs: L2 on **z-scored** matrix in `dataset_builder.compute_parameter_space_boundaries`. Same *features*, different *metric*. S4 join must not pretend distances are identical. |
| A3  | What is “collision boundary” label?                            | **Done** | KPI `passed` from `boundaryMetric` / `criticalityMetrics` — not necessarily identical string to `cluster.json` collision_rate. **Must document which KPI** in export JSON.                                                                                    |
| A4  | Can we rebuild filter offline without React?                   | **Done** | `app/llm_pipeline/python/llm_pipeline/odd_export.py` (CLI: `odd-export`) is a verified Python twin — see §9 S2 "Python twin" note for the parity check.                                                                                                       |
| A5  | Auth path for chat                                             | **Done** | Analyze already uses pasted API key / env (`GOOGLE_API_KEY`, `OPENAI_API_KEY`). No OAuth.                                                                                                                                                                     |
| A6  | Thesis sample run has medoid/pair/summary?                     | **Done** | `results/batch8/3_cluster_s=0.8032/` has all three + quality/selection JSON.                                                                                                                                                                                  |
| A7  | Cross-eval required?                                           | **Done** | Dropped; Q&A replaces whole-run LLM questions.                                                                                                                                                                                                                |




#### B. Literature (read what the paper *actually* claims)


| #   | Source                                                     | Status      | Simple “what it says”                                                                                                                                                                                                                                       | Supports us?                                                                                                  | Overclaim risk                                                                                                                                                                                                |
| --- | ---------------------------------------------------------- | ----------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| B1  | **SAE J3016** ODD                                          | **Done**    | ODD = conditions under which the driving automation feature is *designed* to function (geo, road, weather, traffic, speed, time, …).                                                                                                                        | Motivation: engineers need to name operating limits.                                                          | Calling our collision frontier “the ODD” is too strong. Ours is an **empirical fail envelope in sampled scenario parameters** for one logical scenario — a *piece* of ODD-related evidence, not the full ODD. |
| B2  | **Koopman J3016 user guide**                               | **Done**    | Distinguishes ODD (design intent) vs real operational domain; exiting ODD ⇒ system outside design.                                                                                                                                                          | Thesis should say we help *discover candidate limits* to put into an ODD discussion, not certify ODD exit.    | Same as B1.                                                                                                                                                                                                   |
| B3  | **Song et al., Softw. Qual. J. 2023** critical scenario ID | **Done**    | Real traffic testing does not scale; prioritize **critical** scenarios (params that likely expose failure). Workflow: specs → params + objective (e.g. TTC) → simulate → **optimize** to find critical concrete scenarios. Validated on industry functions. | Supports: search/analyze **parameter space** for fail-inducing concrete scenarios; use measurable objectives. | They **search/optimize** for new critical points. We only **label frontier trials already sampled**. Do not claim we “identify critical scenarios” the same way.                                              |
| B4  | **Lewis et al., NeurIPS 2020 RAG**                         | **Done**    | LLMs alone hallucinate / can’t update knowledge; RAG retrieves documents from an external index and generates conditioned on them; more factual than parametric-only on knowledge tasks.                                                                    | Supports: **ground answers on an external run corpus** (our briefing) instead of free chat.                   | Their system uses dense retrieval + fine-tuning over Wikipedia. Ours is **prompt-grounding / light RAG** (fixed JSON + router). Say “RAG-*style* grounding,” not “we implement RAG.”                          |
| B5  | **RAG hallucination reviews** (2025+)                      | **Done**    | RAG reduces but does **not** remove hallucination; bad retrieval still yields wrong answers; need faithfulness checks.                                                                                                                                      | Supports: citations, refuse if missing, gold Q/A eval.                                                        | Do not sell chat as “truth.”                                                                                                                                                                                  |
| B6  | **Atakishiyev et al., XAI for safe AD review**             | **Done**    | Black-box AD models hurt trust/safety argumentation; XAI paradigms include **interpretable-by-design** (trees, rules) and surrogates; interpretability = user can follow input→output causality. Also notes L3 ODD handovers need agency/explanations.      | Supports: shallow CART/rules for auditable fail regions; chat as explanation medium for engineers.            | Trees for **scenario-param → collision** are not the same as explaining the AV neural planner. Be clear: we explain **test outcomes**, not the controller weights.                                            |
| B7  | **Tree XAI in AD** (e.g. GRIT, ICCT)                       | **Skimmed** | Decision trees used so humans can read and sometimes verify policies.                                                                                                                                                                                       | Supports preference for shallow trees over DL for *stated* limits.                                            | Those papers learn **driving policies**; we learn **outcome classifiers** on test params. Analogy only.                                                                                                       |
| B8  | **ISO 21448 SOTIF**                                        | **Todo**    | (To confirm in thesis write-up) Known unsafe scenarios / triggering conditions beyond random hardware faults.                                                                                                                                               | Likely supports “find triggering parameter conditions.”                                                       | Read official text before citing chapter numbers.                                                                                                                                                             |
| B9  | **Warwick ODD+behavior scenario papers**                   | **Todo**    | ODD alone misses behavior; scenarios need ODD elements + maneuvers.                                                                                                                                                                                         | Supports pairing parameter envelope with **behavioral** medoid/pair cards.                                    | Don’t treat parameter rules as complete scenario coverage.                                                                                                                                                    |




#### C. Critical experiments (before locking S3/S5)


| #   | Check                                                                          | Status                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| --- | ------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| C1  | On one batch: export boundary trial ids; manually spot-check 10 vs Explore UI  | **Done (superseded)** — instead of manual eyeballing, built an independent Python re-implementation (`odd_export.py`) of the exact same kNN/min-max-L2 algorithm from a completely separate code path (Payload saved-analysis zip via `dataset_builder._fetch_payload_analysis`, not browser Redux state) and ran it on `batch8/3_cluster_s=0.8032`. Result: **byte-for-byte identical counts** (n_trials_considered=3869, n_trials_without_cluster_label=869, collision_boundary=650, cluster_boundary=628) and identical per-trial parameter values/neighbor sets. Two independent implementations agreeing is stronger evidence than 10 manual spot-checks. |
| C2  | CART depth 1–3: report support/precision; stop if depth>3 needed for tiny gain | **Done** — swept depth 1–4 on `batch8/3_cluster_s=0.8032`: cv_acc 0.656 (d1) → 0.806 (d2) → 0.842 (d3) → 0.879 (d4), rule count 2→4→8→16. Depth 2→3 gain (+0.036) still worth the extra split; depth 3→4 gain shrinks (+0.037) while rule count doubles again and per-leaf support gets thin (as low as 13 trials) — readability collapses faster than accuracy improves. **Kept** `max_depth=3` **as the shipped default**, matches the plan's original XAI-interpretability rationale, not just an unvalidated guess.                                                                                                                                        |
| C3  | Write 15 gold Q/A from files; score chat faithfulness                          | **Partially done** — ran the plan's 5 gold-question categories for real (not dry-run) against `batch8/3_cluster_s=0.8032` and `batch9/4_cluster_s=0.7482` via `odd-chat`; answers correctly cited cluster/pair/rule ids, kept deterministic-vs-LLM language separate ("the LLM-authored summary describes…"), and never invented a number outside the briefing. Full 15-question scored rubric across all runs still **Todo** — do before the thesis write-up, this was a smoke test, not the formal eval.                                                                                                                                                     |
| C4  | Confirm KPI used for boundary vs collision_rate in cluster.json                | **Done** — boundary KPI is `keyPerformanceIndicator.id=1, name="collision", rule="lessThan"` read directly from each trial's own `testObjectives.criticalityMetrics[].passed` (Payload-computed, not re-derived). `cluster.json`'s `collision_rate` is a separate deterministic aggregate computed by `dataset_builder` over the same underlying collision flag — both trace back to the same KPI, confirmed by cross-checking cluster0's cluster.json `collision_rate: 1.99` against `odd_all_trials.json`'s per-trial `passed` field restricted to cluster 0 (18/904 ≈ 1.99%, matches `cluster.json`'s `collision_count: 18`).                               |


---



### 2.2 Critical review of *this* plan (honest)

**What is solid**

1. Freezing medoid/pair — correct; they already answer *why* under matched params.
2. Exporting the existing filter — low risk, high thesis value (reproducibility).
3. Run report as assemble-only — classic engineering UI; little science risk.
4. Grounded Q&A instead of cross-eval — better UX; same evidence base.
5. Preferring shallow rules over DL for stated limits — aligns with XAI “interpretable by design.”

**What was overstated in earlier drafts (corrected here)**


| Earlier claim                                     | Critical correction                                                                                                                                                |
| ------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| “Discover the ODD boundary”                       | Discover an **empirical pass/fail frontier in sampled scenario parameters** for one case study. Full ODD (J3016) includes weather, map, traffic, … we do not have. |
| “Same as critical scenario identification papers” | Those papers often **optimize** new critical points. We **post-process** an existing sample + optional rules. Related goal, different method.                      |
| “We use RAG”                                      | We use **grounded prompting** on a run briefing. Full RAG = learned retriever + doc index (Lewis). Ours is weaker but enough if citations + refusal work.          |
| “Explore distance = pair distance”                | **False** (min–max vs z-score). S4 must join on **trial ids**, not distance equality.                                                                              |
| “CART defines the ODD”                            | CART gives **auditable hypotheses** about fail regions. Thesis must report precision/support and sampling bias.                                                    |
| “Chat replaces analysis”                          | Chat **discusses** frozen analysis. Without S0–S3 artifacts it invents.                                                                                            |


**Remaining design tensions**

1. **Collision-boundary vs cluster-boundary** answer different questions; report/chat must not merge them into one “ODD” sentence.
2. **Medoid extracts in pair prompts** still create LLM self-reuse; we freeze pairs anyway — thesis must admit pair `separation_call` is medoid-informed.
3. **Q&A memory**: session history helps UX but can launder earlier hallucinations; keep K small and re-inject briefing every turn.

**2026-08-21 re-review, before continuing implementation**

A prior pass (credited "antigravity" in `ai_thinking_blueprint.md`) had already built S0/S1
against this plan. Re-checked against the live repo before trusting it or continuing:


| Claim in blueprint                                                                          | Checked                           | Verdict                                                                                                                                                         |
| ------------------------------------------------------------------------------------------- | --------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `GET /api/cluster-run-report` aggregates header/clusters/pairs/merge candidates, reads only | Read `route.ts` in full           | **True.** Read-only, uses existing `resolveClusterArtifact` / `readYamlDoc`, no LLM call, no writes.                                                            |
| 4th "Run report" tab in `AnalyzeClient.tsx`, additive                                       | `git diff --stat` on the file     | **True.** 495 insertions, 0 deletions — existing Summary/Medoid/Pairs tabs untouched.                                                                           |
| No lint/type errors                                                                         | `ReadLints` + `tsc --noEmit`      | Clean (one pre-existing unrelated error in `cluster-evaluate/run/route.ts`, not from this work).                                                                |
| S0 "validated"                                                                              | No script/artifact added for this | **Weak claim** — no automated check exists; treated as "spot-checked one sample run," not a repeatable gate. Left as a manual checklist item, not re-litigated. |


Verdict: **kept as-is**, no rework. This is exactly the kind of thing rule 1 in §1 exists for
("New work reads medoid/pair/summary YAML — it does not rewrite their prompts") — S1 only reads
already-existing YAML/JSON, so accepting it does not violate the freeze.

Continued from S2 in this pass. One deviation from the original §6.2 target schema, kept
deliberately:

- The "target" schema in §6.2 sketched a single flat `boundary_trials[]` / `edges[]` list with
a `kind` tag. The **actual** implementation keeps two separate sections,
`collision_boundary` and `cluster_boundary`, each with its own `boundary_trials[]` / `edges[]`.
Reason: a trial can be a collision-boundary case, a cluster-boundary case, both, or neither —
a single flat list with a `kind` field per *edge* (not per trial) made "which trials belong to
which set" harder to read back out. Two named sections is simpler for both the Run report UI
and a future S4 join. `implementation_plan.md` §6.2/§9 schemas below are updated to match what
was actually shipped.



### 2.3 Method verdict (after validation)


| Feature                       | Verdict                | Why                                             |
| ----------------------------- | ---------------------- | ----------------------------------------------- |
| Freeze medoid + pairs         | **Keep**               | Core contribution already built                 |
| Drop cross-eval → Q&A         | **Keep**               | Avoid duplicate whole-run LLM product           |
| S1 Run report                 | **Keep**               | Necessary engineer view                         |
| S2 Boundary export            | **Keep**               | Makes UI scientific                             |
| S3 Shallow rules              | **Keep with humility** | Good XAI fit; not full ODD; train on all trials |
| S4 Join on trial id           | **Keep**               | Do not equate distance metrics                  |
| S5 Grounded Q&A               | **Keep as light RAG**  | Cite briefing; evaluate faithfulness            |
| Deep learning ODD             | **Out**                | Weak for auditable limits                       |
| Claiming “full ODD discovery” | **Out**                | Violates J3016 scope                            |


---



### 2.4 Paper support (simple claims → how we use them)


| Paper / standard                      | What it says (plain)                                                                                                      | How our plan uses it                                                                                       | What we must *not* claim                                |
| ------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------- | ------------------------------------------------------- |
| SAE J3016                             | ODD = design operating conditions for the automation feature.                                                             | Frame thesis as helping engineers reason about **operating limits** of the tested AV in a scenario family. | That our heatmap frontier *is* the complete ODD.        |
| Song et al. 2023 (critical scenarios) | Infinite real-world tests don’t scale; find **parameterized** scenarios that expose failures using objectives + search.   | Justify focusing on **parameter space** + collision/KPI outcomes; “what to test next” from frontier/rules. | That kNN export equals their optimization CSI pipeline. |
| Lewis et al. 2020 (RAG)               | External documents + generation beats parametric-only on knowledge tasks; knowledge can be updated by changing the index. | Briefing JSON = non-parametric memory for this run; update briefing when YAMLs change; cite sources.       | That we trained DPR/BART or retrieve Wikipedia.         |
| RAG hallucination reviews             | Grounding helps; retrieval/generation errors remain.                                                                      | Gold Q/A, citations, unknown-if-missing.                                                                   | “Chat cannot hallucinate.”                              |
| XAI for trustworthy AD review         | Need interpretable designs (trees/rules) for safety argumentation; explanations support agency when ODD is limited.       | CART/rules + report + chat as explanation stack for **test results**.                                      | That we explain the AV’s internal NN.                   |
| Interpretable tree AD papers          | Trees can be read/verified better than deep policies.                                                                     | Prefer shallow trees for fail-region statements.                                                           | That our tree is a driving policy.                      |


**Thesis claim (revised, honest):**  
For sampled logical scenarios, deterministic clustering and parameter-space pairs locate and explain candidate **behavioral / safety frontiers** in scenario-parameter space; exporting Explore boundary filters and fitting shallow rules scales beyond 1:1 pairs; a run report and grounded Q&A let engineers discuss those limits — without treating LLM text as numeric ODD ground truth, and without claiming a full SAE ODD certificate.

---



## 3. Decisions: selection-eval & cross-eval


| Product            | Build phase?    | Verdict                                                            |
| ------------------ | --------------- | ------------------------------------------------------------------ |
| **Cross-eval**     | **No**          | User questions → **ODD Q&A**. Do not activate/redesign cross-eval. |
| **Selection-eval** | **No new work** | Keep existing JSON as optional report/chat input.                  |


---



## 4. What already exists (reachable)

Sample: `results/batch8/3_cluster_s=0.8032/`.


| Piece                                  | Reachable?       | Gap                                               |
| -------------------------------------- | ---------------- | ------------------------------------------------- |
| Collision / cluster boundary filter UI | Yes              | —                                                 |
| `odd_boundary_export.json`             | Yes (S2 shipped) | Only written on demand, per folder, via UI button |
| Medoid / pair / summary YAML           | Yes on sample    | Trust all thesis folders                          |
| Quality / selection JSON               | Yes              | Optional                                          |
| Run report tab                         | Yes (S1 shipped) | Section E rules half still placeholder (S3)       |
| Parameter rules / Q&A                  | **No**           | To build (S3–S5)                                  |


Auth already in project: Analyze passes `apiKey` + `model` (default `gemini-2.5-flash`) into the pipeline; Gemini → `GOOGLE_API_KEY`, GPT → `OPENAI_API_KEY` (`llm_factory.py`, `cluster-analyze/run/route.ts`). **No Google/ChatGPT account login in-browser.**

---



## 5. Deliverables overview

```text
Explore filter (existing)
        │ S2 export
        ▼
odd_boundary_export.json ──► S3 odd_parameter_rules.json
        │                           │
        └────────────┬──────────────┘
                     ▼
              S1 Run report  ← medoid/pair/summary (frozen)
                     │
                     ▼
         S5 odd_chat_briefing.json → ODD Q&A UI
```

---



## 6. Detailed design — S2/S3 Boundary filters → rules → reply



### 6.1 What the filter is today

File: `app/dashboard/.../Controls/Filtering/index.tsx` + tree build in
`redux/slices/batch.ts`.

- Points live in a KD-tree over **scenario parameter values** (`trial.parameters`),
not MFPCA coordinates.
- Distance: L2 after **min–max normalizing** each param by scenario `[min,max]`
(see `calculateDistance` in `batch.ts`). **Not** the z-scored L2 used by
`compute_parameter_space_boundaries`.
- **On Collision Boundary:** trial kept if a kNN neighbor has opposite KPI
`passed` (`boundaryMetric`) and both cluster labels are checked.
- **On Cluster Boundary:** trial kept if a kNN neighbor has a different cluster
label.

This is a **local neighborhood test** in sampled parameter space: “near me, the
label flips.” Parameter-space **pairs** are the 1:1 microscope on the same
*feature family*, with a **different distance**.


| Tool                      | Scale       | Question                                          |
| ------------------------- | ----------- | ------------------------------------------------- |
| Collision-boundary filter | Many trials | Where does pass↔fail flip (under Explore metric)? |
| Cluster-boundary filter   | Many trials | Where do cluster labels meet?                     |
| Parameter-space pair LLM  | Two trials  | Why did near-z-score-matched params diverge?      |




### 6.2 Processing pipeline (deterministic)

```text
Payload trials + clustering labels + KPI pass/fail
        │
        ▼
kNN boundary detection  (same semantics as Filtering UI)
        │
        ▼
odd_boundary_export.json
        │
        ├─► (optional) join to parameter_space_pairs/pair.json     [S4]
        │
        ▼
Train shallow classifier on ALL trials
  X = scenario params (OncomingSpeed, OncomingStartDelay, …)
  y = collision / KPI fail
        │
        ▼
odd_parameter_rules.json
  rules with support, precision, boundary_hit_count
        │
        ▼
Human-readable “reply” on Run report / chat
  = rules + counts + optional pair contrast citations
  (LLM only paraphrases; numbers come from JSON)
```

**Export schema (as shipped — see** `boundaryExport.ts` **/** `odd-boundary-export/route.ts`**)**

```text
$RUN/odd_boundary_export.json
  generated_at: iso timestamp
  batch_id, folder
  kNN: int
  kpi: { id, name }
  clusters_included: [...]              # excludes label "-1" (noise)
  n_trials_considered: int
  distance_note: "min-max normalized L2 ... not comparable to pair z-score"
  collision_boundary:
    boundary_trials: [ { trial_id, parameters, passed, cluster_label, neighbor_ids[] } ]
    edges: [ { trial_a, trial_b, param_dist } ]   # param_dist = tree metric distance
  cluster_boundary:
    boundary_trials: [ ... same shape ... ]
    edges: [ ... same shape ... ]
```

Built by: `explore/lib/boundaryExport.ts` (`computeBoundaries`, pure function reusing the
already-built kd-tree from `state.batch.tree` / `treePoints` — identical metric to Filtering's
checkboxes) → Filtering panel "Export ODD boundary" button → `POST /api/odd-boundary-export`
(write) → `GET /api/odd-boundary-export` (read) and `GET /api/cluster-run-report` (summarized
counts only, for the Run report tab).

Deliberately computed over **all** trials, ignoring the panel's current cluster/pass-fail
checkbox subset — otherwise the export would depend on transient UI state and not be
reproducible from the file alone.

**Rules schema (target)**

```text
$RUN/odd_parameter_rules.json
  model: "cart"
  max_depth: 3
  features: ["OncomingSpeed", "OncomingStartDelay", ...]
  rules: [
    {
      id: "R1",
      predicate: "OncomingSpeed > 12.4 AND OncomingStartDelay < 0.8",
      predicted: "collision",
      support: 41,
      precision: 0.87,
      boundary_trial_hits: 18
    }
  ]
  metrics: { train_acc, cv_acc }
```



### 6.3 What a “reasonable reply” looks like (no LLM required)

Example engineer-facing text built by **templates** from JSON:

> Under the current collision-boundary export (kNN=25), **N=142** trials sit on
> a pass↔fail frontier. Rule **R1** (`OncomingSpeed > 12.4 ∧ OncomingStartDelay < 0.8`)
> predicts collision with precision 0.87 (support 41) and covers 18 boundary
> trials. Pair pack `c0-c2` sits in this region with `separation_call=justified`
> and an outcome flip — see contrast.yaml for the behavioral explanation.

Chat (S5) may polish this wording but **must cite R1 / N / pair folder**.

### 6.4 Is this method good? Paper support (plain language)


| Source           | What it says                                                                                                  | We use it for                                                                 | We do **not** claim                                 |
| ---------------- | ------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------- | --------------------------------------------------- |
| SAE J3016        | ODD = design operating conditions (geo, road, weather, speed, …).                                             | Thesis motivation: engineers care about operating limits.                     | Our frontier = full ODD.                            |
| Song et al. 2023 | Critical scenarios = param sets that expose failures; industry needs systematic ID beyond endless road miles. | Justify analyzing fail/pass in **parameter space** and suggesting next tests. | That kNN export = their optimization CSI toolchain. |
| XAI AD review    | Interpretable trees/rules help safety argumentation vs black boxes.                                           | Prefer shallow CART for stated fail regions.                                  | That the tree explains the AV planner NN.           |
| Tree AD papers   | Readable trees beat opaque policies for inspection.                                                           | Prefer depth≤3 rules for engineer-facing predicates.                          | That our classifier is a driving policy.            |


**Limitations (state in thesis)**

- Sampled 2–3 scenario parameters ≠ full real-world ODD.
- Frontier is empirical on the sample, not a continuous proof.
- Collision-boundary ≠ cluster-boundary.
- Explore vs pair **distance mismatch** — join on trial id only.

---



## 7. Detailed design — S5 ODD Q&A system



### 7.1 What it should feel like (UX)

- Lives on the **Run report** page (drawer or right panel), not a separate site.
- Chat bubbles: User / Assistant.
- Each assistant answer shows **citation chips**: `cluster0/summary`, `pair c0-c2`,
`rule R1`, `boundary export kNN=25`.
- Clicking a chip opens the existing Analyze / Explore view.
- Empty state: “Run summaries / export boundary first” with checklist of missing
files.
- Same **model + API key** controls as Medoid/Pair tabs (reuse Analyze state).



### 7.2 Auth / model (important)


| Question                             | Answer for this project                                                                              |
| ------------------------------------ | ---------------------------------------------------------------------------------------------------- |
| Google/ChatGPT **login** in browser? | **No.**                                                                                              |
| How does the LLM run?                | Server-side call via existing `llm_factory` / Analyze run path                                       |
| Credentials?                         | User pastes **API key** in Analyze (ephemeral) **or** server env `GOOGLE_API_KEY` / `OPENAI_API_KEY` |
| Default model?                       | `gemini-2.5-flash` (same as today)                                                                   |
| Can use GPT?                         | Yes if `gpt-*` + `OPENAI_API_KEY`                                                                    |


Do **not** build OAuth “Sign in with Google” for chat v1.

### 7.3 Does the conversation have memory?

**Yes — short session memory, with limits.**


| Layer                | What it remembers                            | Scope                                                |
| -------------------- | -------------------------------------------- | ---------------------------------------------------- |
| **A. Run briefing**  | Fixed analysis corpus for this `$RUN`        | Regenerated when YAMLs/rules change; hashed          |
| **B. Chat turns**    | Last K user/assistant messages (e.g. K=6–10) | Browser session or server log; cleared on “New chat” |
| **C. Model weights** | General language ability                     | Not used as source of ODD numbers                    |


Rules:

1. Every request sends: `system` + **selected briefing sections** + last K turns + new question.
2. Briefing is the **only** allowed source for numbers and cluster/pair claims.
3. If user says “that cluster”, resolve from prior turn’s cited cluster id; if
  ambiguous → ask which cluster.
4. Persist optional `odd_chat_log.jsonl` for thesis (question, answer, citations,
  briefing_hash, model, temperature).

This is **dialog memory**, not “the model remembers all past runs.”

### 7.4 What is fed to the LLM each turn (besides the user question)

**Always**

1. **System prompt** — role “ODD analysis consultant”; cite sources; never invent
  thresholds; say unknown if missing; distinguish deterministic vs LLM cards.
2. **Run identity** — batch id, folder, k, silhouette.
3. **Retrieved briefing slices** (not the entire dump if large) — see router below.
4. **Recent chat history** (last K turns).
5. **User question**.

**Never (v1)**

- Raw trajectories / full Payload dumps  
- Full BEV image sets  
- Full `context_medoid.md` / pair `process/context.md` timelines  
- Live “browse the internet”

**Optional (v2, user-triggered)**

- Attach one pair’s short contrast + one BEV — only if user clicks “Include pair visuals”



### 7.5 Briefing file (the knowledge base)

Built by API; cached as `$RUN/odd_chat_briefing.json`.

```text
run: { folder, k, silhouette, quality_scores?, selection_score? }
clusters: [
  { id, label, n, collision_rate, neighborhood_separation,
    medoid_motive, medoid_outcome, summary_caption_short }
]
pairs: [
  { folder, param_dist, outcome_flip, separation_call, explanation_short }
]
rules: [ ... from odd_parameter_rules.json ... ]
boundary: { n_collision, n_cluster, kNN, top_edges_short }
findings: [ optional selection-eval strings ]
open_questions: [ harvested from medoid/pair open_questions ]
missing: [ "no odd_boundary_export.json", ... ]
```

Size target: **~8–15k tokens** after truncation.

### 7.6 Intent router (what sections to attach)


| User intent (examples)         | Attach sections                                                       |
| ------------------------------ | --------------------------------------------------------------------- |
| Weakness / failure modes       | clusters (high collision), motives, top pairs                         |
| Fail conditions / ODD limits   | rules, boundary stats, param ranges                                   |
| What to test next              | boundary regions w/o pairs, inconclusive separations, high-fail boxes |
| Why this clustering / merge?   | neighborhood_separation, pair separation_call, quality scores         |
| Explain cluster N / pair cA-cB | that cluster + touching pairs only                                    |
| Other                          | run header + missing[] + ask clarifying question                      |


v1 can use **keyword / regex routing**; embeddings optional later.

### 7.7 Example request payload (conceptual)

```json
{
  "batchId": 8,
  "folder": "3_cluster_s=0.8032",
  "model": "gemini-2.5-flash",
  "apiKey": "<optional override>",
  "messages": [
    { "role": "user", "content": "Which conditions collide most?" },
    { "role": "assistant", "content": "..." },
    { "role": "user", "content": "So what should we test next?" }
  ]
}
```

Server builds prompt = system + retrieved slices + messages; calls same LLM stack
as Analyze; returns `{ answer, citations[], briefing_hash }`.

### 7.8 Is Q&A a good method? Paper support (plain language)


| Source                    | What it says                                                                          | We use it for                                                              | We do **not** claim                                                                |
| ------------------------- | ------------------------------------------------------------------------------------- | -------------------------------------------------------------------------- | ---------------------------------------------------------------------------------- |
| Lewis et al. 2020 RAG     | External docs + generation beats parametric-only; knowledge is inspectable/updatable. | Briefing = external memory; regenerate when run files change; cite slices. | Full RAG (DPR + Wikipedia + fine-tune). Ours = **grounded prompting / light RAG**. |
| RAG hallucination surveys | Grounding helps; wrong retrieval still wrong answers.                                 | Citations, unknown-if-missing, gold Q/A faithfulness tests.                | Hallucination-free chat.                                                           |
| XAI AD review             | Explanations matter for trust and agency under limited ODD.                           | Chat as engineer-facing medium over frozen analysis.                       | Chat replaces medoid/pair analysis.                                                |


**Why this beats activating cross-eval**

- Cross-eval = one more offline LLM card to debug.  
- Q&A = interactive discussion on the **same** frozen evidence.  
- No medoid/pair prompt changes.

**Risks & mitigations**


| Risk                             | Mitigation                                            |
| -------------------------------- | ----------------------------------------------------- |
| Invented rates / thresholds      | Quote only briefing/rules numbers                     |
| Calling light RAG “RAG” in paper | Say grounded Q&A / retrieval-over-briefing            |
| Session drift                    | Small K; re-attach briefing every turn                |
| Weak briefing                    | Block chat until S0 summaries exist; show `missing[]` |


---



## 8. Detailed design — S1 Run report (brief)

Fourth Analyze tab. **No LLM in v1.** Assemble:


| Section            | Source                                   |
| ------------------ | ---------------------------------------- |
| A Header           | folder, k, silhouette, quality JSON      |
| B Risk table       | cluster.json + cluster_summary.yaml      |
| C Motives          | medoid_trial.yaml primary_motive         |
| D Pair evidence    | pair.json + contrast.yaml                |
| E Rules / boundary | S2–S3 when present; else placeholder     |
| F Merge/split      | neighborhood_separation ± selection-eval |
| G Next tests       | deterministic priority list              |


Links into existing Medoid / Pair / Cluster tabs.

---



## 9. Build checklist (implementation order)



### S0 — Cluster summary ready

- [x] Spot-checked `results/batch8/3_cluster_s=0.8032/` has all three products + quality/selection JSON
- [x] Analyze `readyForSummary` works (pre-existing, unchanged)
- [x] No medoid/pair prompt edits made
- [x] Also spot-checked `results/batch8/6_cluster_s=0.6113/` and `results/batch9/4_cluster_s=0.7482/`
  ```
  (2026-08-21, while running the S2–S5 CLI end-to-end) — both have complete
  medoid/summary/pair/quality/selection artifacts.
  ```
- [ ] Not yet checked: **every remaining** thesis `$RUN` beyond these 3 — do before writing up
  ```
  final results, not before building more of S2–S5.
  ```

**Done when:** all thesis clusters show saved summary cards. *(sample run only so far)*

### S1 — Run report

- [x] Tab + `GET /api/cluster-run-report` — `src/app/api/cluster-run-report/route.ts`
- [x] Sections A–G (E now shows S2 boundary export summary, S3 rules table, and S4 pairs-touching-boundary chip — all read-only, all written by the Python CLI)
- [x] Section H — ODD Q&A panel (S5b UI, see §9.3) — `GET`/`POST /api/odd-chat` + `OddChatPanel`
- [x] Deep links to existing tabs (`onNavigateTab`)

**Done when:** one page answers “what’s risky?” — **done**, additive-only diff, verified with
`tsc --noEmit` + lints.

### S2 — Boundary export

- [x] Shared kNN helper matching Filtering semantics — `explore/lib/boundaryExport.ts`
  ```
  (reuses the live kd-tree/treePoints, so the metric is guaranteed identical, not just
  "matching")
  ```
- [x] Write `odd_boundary_export.json` — `POST /api/odd-boundary-export`
- [x] Export button — Filtering panel, next to the kNN slider
- [x] **Python CLI twin** — `app/llm_pipeline/python/llm_pipeline/odd_export.py`
  ```
  (`python -m llm_pipeline.cli odd-export --run-dir results/batch<id>/<folder>`). Closes the
  A4 gap: trial parameters + KPI pass/fail are **not** obtainable from Payload's live REST
  `Trial` collection for this dataset (`GET /api/trials?where[batch][equals]=<id>` returns
  `totalDocs: 0` — these paper-casestudy trials only ever exist inside the saved Dashboard
  analysis zip, never as live `Trial` documents). The twin therefore reuses
  `dataset_builder._fetch_payload_analysis` (same zip-download helper the medoid/pair builder
  already uses) instead of inventing a new Payload access path, then ports
  `boundaryExport.ts::computeBoundaries` line-for-line (min-max L2 kd-tree via
  `scipy.spatial.cKDTree`). Parameter names are resolved from each trial's own **embedded**
  `trial.batch.scenario.parameters` (baked into the zip at simulation time) rather than a
  live `GET /api/batches/<id>` call — confirmed the live batch-8 document and the trials'
  embedded scenario are genuinely different Payload documents with different ObjectId epochs
  (batch 8 today: `6a5f0d82...`; trials' embedded scenario: `68b78058...`), so this sidesteps
  the id-mismatch bug entirely instead of relying on the TS side's positional-matching
  workaround.
  ```

**Done when:** Explore highlights == JSON trial ids. **Verified** — ran the Python twin on
`batch8/3_cluster_s=0.8032` (already exported from the browser) and got **identical counts and
per-trial data** (n_trials_considered=3869, n_trials_without_cluster_label=869,
collision_boundary=650, cluster_boundary=628, same parameter values/neighbor ids for the first
boundary trial). This satisfies C1 more rigorously than a manual 10-trial spot-check would have
(two independent implementations agreeing beats eyeballing). Also exported+verified on
`batch8/6_cluster_s=0.6113` and `batch9/4_cluster_s=0.7482` (different batch, different scenario
instance, different save doc) — see §9.1 below.

### S3 — Parameter rules

- [x] Train on **all** trials; features = scenario params — `odd_rules.py::train_rules`
- [x] `max_depth≤3` (default); write `odd_parameter_rules.json` (CLI: `odd-rules`)
- [x] Show on report section E — `cluster-run-report/route.ts` + `AnalyzeClient.tsx` render the
  ```
  rules table (predicate / predicted / support / precision / boundary hits)
  ```

Implementation notes (deviations from §6.2's sketch, reasoned):

- Used a plain **sklearn** `DecisionTreeClassifier` (analyzer conda env already has scikit-learn
1.5.2 — same env `dataset_builder.py` runs in) rather than hand-rolling CART. `min_samples_leaf`
defaults to 10 to avoid single-digit-support "rules" that would look precise but be noise.
- `boundary_trial_hits` per rule = count of that leaf's training trials that also appear in S2's
`collision_boundary.boundary_trials` (join by trial id, computed inline, not via S4's join file
— S4 joins *pairs*, not CART leaves).
- Ran the C2 depth ablation (1–4) — see §2.1 C2 above — and kept `max_depth=3` as the default:
best readability/accuracy trade-off, not an arbitrary choice.

**Done when:** auditable predicates with support/precision. **Done** — e.g. for
`batch8/3_cluster_s=0.8032`: rule R4 `OncomingStartDelay <= 4.388 AND OncomingStartDelay > 3.855 AND OncomingSpeed > 2.374` → predicts `collision`, support 1688, precision 0.8193, 339 boundary
trial hits.

### S4 — Boundary ↔ pairs join

- [x] Mark which boundary trials appear in pair packs (**join on trial id only** — Explore
  ```
  min–max distance ≠ pair z-score distance) — `odd_join.py::join_run_dir` (CLI: `odd-join`)
  ```
- [x] Table on report; include in briefing — surfaced as a chip
  ```
  ("N/M pairs touch the boundary") in section E, and as `pairs_touching_boundary` in
  `odd_chat_briefing.json`
  ```

Every parameter-space pair pack in the three test runs touched at least one boundary trial (2/2,
9/9, 4/4) — expected, since pairs are explicitly chosen as *closest cross-cluster* trials, which
is almost definitionally where the kNN boundary filter also fires. This is a sanity check that
the two products agree qualitatively, not a novel finding.

### S5 — ODD Q&A

- [x] Build/cache `odd_chat_briefing.json` — `odd_briefing.py::build_briefing` (CLI:
  ```
  `odd-briefing`), no LLM call, ~1.7-2.7k tokens on the three test runs (well under the
  8-15k budget in §7.5)
  ```
- [x] Intent router — `odd_chat.py::route` / `classify_intent`, keyword/regex v1 exactly as
  ```
  scoped in §7.6 (embeddings deliberately not built — v1 said optional)
  ```
- [x] Grounded answer + citations — `odd_chat.py::answer`, reuses `llm_factory.py` (same
  ```
  `GOOGLE_API_KEY`/`OPENAI_API_KEY` env-var contract as Analyze, no new auth path)
  ```
- [x] Session memory (last K turns, default 8, re-attaches briefing every turn per §7.3) —
  ```
  `build_messages(..., max_history_turns=8)`
  ```
- [x] Log Q/A for thesis — appends to `odd_chat_log.jsonl` (question, answer, citations, model,
  ```
  dry_run, briefing hash timestamp)
  ```
- [x] Do **not** use cross-eval backend — confirmed, `odd_chat.py` has zero imports from
  ```
  `cross_cluster_evaluator.py`
  ```
- [x] **Browser chat UI +** `/api/odd-chat` **route — built.** Originally deferred (the
  ```
  "operate through code, no need [for the] web/dashboard" instruction), now built on
  explicit request. `app/dashboard/.../api/odd-chat/route.ts` GET/POST wraps
  `scripts/run_odd_chat.sh` (new — mirrors `scripts/run_cluster_analyze.sh`'s conda-env
  pattern) which `exec`s the *exact same* `python -m llm_pipeline.cli odd-chat` used from a
  terminal — one LLM-calling implementation, two entry points. A new "ODD Q&A" section
  (§H) was added to the bottom of the Run Report tab (`OddChatPanel` in `AnalyzeClient.tsx`):
  message log, model select, ephemeral API-key field, question box. See §9.2 for exactly how
  it works (API key / login / memory / persistence) and the live browser test.
  ```

**Gold questions (must work)** — all four asked for real against `batch8/3_cluster_s=0.8032`
(and the "weakness" question also against `batch9/4_cluster_s=0.7482`) via
`gemini-2.5-flash`, transcripts logged in each run's `odd_chat_log.jsonl`:

- [x] Weakness of this AV on this batch? — correctly named the 100%-collision cluster,
  ```
  cited its motive/caption, and flagged the two outcome-flip pairs as evidence of
  sensitivity, without inventing numbers.
  ```
- [x] High-probability fail conditions? — quoted R4/R5 verbatim (predicate, precision), did not
  ```
  invent a threshold.
  ```
- [x] What to test next? — proposed the low-precision "safe" rules (R6/R2/R3/R7, i.e. where
  ```
  "safe" predictions still hide a real collision rate) plus the closest boundary-edge trial
  pairs — a genuinely useful, evidence-grounded suggestion, not a generic answer.
  ```
- [x] Why keep/merge clusters? — correctly reproduced the `separation_call: over_fine` nuance
  ```
  from `contrast.yaml` *and* still explained why the clusters are kept separate (100%
  vs 1.99% collision rate), keeping the LLM-authored/deterministic distinction explicit in
  its own wording ("the LLM-authored explanation indicates…").
  ```
- [x] Why is this clustering useful? — covered by the same "why keep/merge" answer path
  ```
  (`why_clustering` intent); not asked as a separate literal phrasing in this pass.
  ```



### 9.1 — Code version (CLI), no browser required

Per the user's request ("write a code version… operate through code, no need [for the]
web/dashboard"), every S2–S5 step is now a standalone Python module + `cli.py` subcommand, runnable
end-to-end from a terminal with no Explore/Analyze browser interaction:

```bash
source ~/miniconda3/etc/profile.d/conda.sh && conda activate analyzer   # existing env; has
                                                                          # pandas/numpy/scipy/
                                                                          # sklearn/langchain
cd gpl-odd-project
export PYTHONPATH="app/llm_pipeline/python:app/analyzer/src"

RUN="results/batch8/3_cluster_s=0.8032"
python -m llm_pipeline.cli odd-export   --run-dir "$RUN" --kNN 10   # S2 (needs Payload reachable,
                                                                      # or --analysis-zip <path>)
python -m llm_pipeline.cli odd-rules    --run-dir "$RUN"            # S3, deterministic, offline
python -m llm_pipeline.cli odd-join     --run-dir "$RUN"            # S4, deterministic, offline
python -m llm_pipeline.cli odd-briefing --run-dir "$RUN"            # S5a, deterministic, offline
python -m llm_pipeline.cli odd-chat --run-dir "$RUN" \
  --question "What is the weakness of this AV system?"              # S5b, needs GOOGLE_API_KEY/
                                                                      # OPENAI_API_KEY (or --dry-run)
```

Why the `analyzer` **conda env**, not plain `python3`: this repo already has a dedicated env
(`conda env list` → `analyzer`, Python 3.9.20) that `dataset_builder.py` / the whole medoid+pair
pipeline runs in, with pandas/numpy/scipy/scikit-learn/langchain pre-installed. The system
`python3.12` is an externally-managed Debian install (`pip install` refuses without
`--break-system-packages`) and is missing scikit-learn/pandas/langchain entirely — reusing the
existing env avoids adding a second, redundant dependency surface for the same pipeline.

**All three requested test folders were run through the full S2→S5(briefing) pipeline** and, for
S5, real (non-dry-run) chat questions:


| Run                         | n trials | n clusters | collision-boundary | cluster-boundary | CART cv_acc | pairs touching boundary |
| --------------------------- | -------- | ---------- | ------------------ | ---------------- | ----------- | ----------------------- |
| `batch8/3_cluster_s=0.8032` | 3869     | 3          | 650                | 628              | 0.8418      | 2/2                     |
| `batch8/6_cluster_s=0.6113` | 3869     | 6          | 650                | 741              | 0.8418      | 9/9                     |
| `batch9/4_cluster_s=0.7482` | 2980     | 4          | 839                | 1043             | 0.6966      | 4/4                     |


(`batch8`'s two runs share the same 3869-trial pool + CART result because both clustering results
were fit on the same saved analysis zip — clustering label doesn't feed CART's *features*, only
the S2 boundary export's cluster-label field, which does differ between the two folders as shown.)

Note `batch9`'s lower CART accuracy (0.70 vs 0.84): this is informative, not a bug — it means
`OncomingStartDelay`/`OncomingSpeed` alone predict pass/fail less cleanly for that scenario
(`Overtake with Cut In From Left`, per its embedded scenario name) than for batch 8's. Worth
citing in the thesis as an example of the rules module correctly reporting when 2D parameter
space is *not* sufficient to explain outcomes for a given scenario.

The three Next.js API routes that changed to read (never write) these files are additive-only —
verified with `tsc --noEmit` (only the pre-existing unrelated `NODE_ENV` error remains) and
`ReadLints` — and the Run Report tab was re-screenshotted after the change to confirm the S3 rules
table renders real CART output (see chat for the screenshot), closing the "S3 rules on the report"
half of §9's S3 checklist without any further browser-side computation: the Python CLI wrote the
file, the browser only ever reads JSON off disk.

### 9.2 — Full pipeline run + gap found in parameter-space pairs (2026-08-21, later session)

Re-ran the full chain "dataset build → medoid → parameter-space pair → cluster summary →
boundary filter → rules → join → briefing → chat" for all three requested folders, as a genuine
end-to-end check rather than assuming prior work was complete. First, per **§1 "do not
change (frozen)"**, `dataset_builder.py`'s raw build + the LLM `medoid_trial.yaml` /
`cluster_summary.yaml` outputs were **not** regenerated — re-running `cluster-interpret
--products medoid` would call the LLM again and silently overwrite the tuned, already-good
frozen YAMLs with a different (LLM is not deterministic at temperature 0.1) result, for zero
benefit and real API cost. Verified completeness by reading the on-disk layout instead of
rebuilding it:

| Run | manifest run_id | clusters (medoid + summary present) | pairs total | pairs with `contrast.yaml` **before this session** |
| --- | --- | --- | --- | --- |
| `batch8/3_cluster_s=0.8032` | `20260817_142709` | 3/3 | 2 | 2/2 |
| `batch8/6_cluster_s=0.6113` | `20260810_163648` | 6/6 | 9 | **2/9** |
| `batch9/4_cluster_s=0.7482` | `20260804_095214` | 4/4 | 4 | **0/4** |

This surfaced a genuine, previously-unnoticed gap: the parameter-space **pair** LLM step
(Product 2 — the pipeline's most novel product per §2.2/ChatGPT-critique item 5) had never
actually been run to completion for two of the three requested folders, even though medoid +
cluster-summary had. This is exactly what the user asked to "check" — not frozen good output,
but an incomplete step. Filling it in is additive (writes files that did not exist; never
touches the 11 pairs/clusters that were already done), so it does **not** violate the freeze
rule:

1. `batch9/4_cluster_s=0.7482`'s pair packs had synced BEV + `pair.json` but no
   `process/context.md` at all (that pair-level context file didn't exist yet when this run was
   originally built — an older `dataset_builder.py`). Backfilled with the explicitly
   no-LLM/no-BEV flag: `dataset_builder.py --rebuild-context-texts "$RUN"` → wrote
   `process/context.md` for all 4 pairs.
2. Ran `python -m llm_pipeline.cli cluster-interpret --products parameter-space-pairs --pairs
   <missing-only>` — first as `--dry-run` on one pair to confirm the write path/prereqs
   (produced an explicit `stub: true` placeholder, safe since nothing existed there yet), then
   for real: 4 pairs for `batch9/4_cluster_s=0.7482`, 7 pairs for `batch8/6_cluster_s=0.6113`
   (`c1-c2, c1-c3, c1-c5, c2-c3, c2-c5, c3-c5, c4-c5`). The `--pairs` flag scopes the run to
   *only* the named packs — the 2 already-complete `batch8/6_cluster` pairs (`c0-c4`, `c0-c5`)
   and both `batch8/3_cluster` pairs were never touched.
3. Re-ran `odd-join` (S4) and `odd-briefing` (S5a) for both changed folders to pick up the new
   `contrast.yaml` files. Result: `odd_chat_briefing.json`'s `missing: []` for **all three**
   folders now (previously it implicitly under-represented pair evidence for 2 of 3 — the
   briefing builder doesn't require contrast.yaml to run, it just silently has less "contrast"
   coverage per pair, so this wasn't flagged as `missing` before either; the fix is a genuine
   coverage improvement, not a bugfix to `odd_briefing.py`).

| Run | pairs with `contrast.yaml` **after** | `odd-join` pairs_touching_boundary | briefing `missing` |
| --- | --- | --- | --- |
| `batch8/3_cluster_s=0.8032` | 2/2 (unchanged) | 2/2 | `[]` |
| `batch8/6_cluster_s=0.6113` | **9/9** | 9/9 | `[]` |
| `batch9/4_cluster_s=0.7482` | **4/4** | 4/4 | `[]` |

Confirmed via the Run Report tab (§S1) for each folder that section D (Parameter-space pairs)
now shows a real `separation_call` / `contrast_explanation` for every pair, and section H (ODD
Q&A, new — see below) answers questions using all pairs, not just the previously-available
subset.

### 9.3 — ODD Q&A browser UI: how it actually works (answers to the specific questions asked)

| Question | Answer |
| --- | --- |
| Does it use an API key? | Yes — same as Analyze's Medoid/Pair tabs. Either paste a key into the panel's "API key (ephemeral)" field (sent to the server for that one request only, in the `GOOGLE_API_KEY`/`OPENAI_API_KEY` env var of the spawned Python process — never written to disk, never echoed back), or leave it blank and the server falls back to its own `GOOGLE_API_KEY`/`OPENAI_API_KEY` env var if the dashboard process was started with one set. |
| Do I need to log in to a ChatGPT/Gemini account? | **No.** There is no OAuth/browser login anywhere in this pipeline (matches §7.2's original "no login" decision) — only a server-side API call authenticated by the API key above, via `llm_factory.py` (the same factory Analyze/medoid/pair/summary already use — Gemini via `langchain_google_genai`, GPT via `langchain_openai`). |
| Can the conversation history be saved? | **Yes**, automatically. Every turn (question, answer, citations, model, timestamp) is appended by `odd_chat.py::_append_log` to `<run_dir>/odd_chat_log.jsonl` — a plain file on disk in the results folder, not browser `localStorage`. |
| If I reopen the dashboard later, do I see the same history? | **Yes.** `GET /api/odd-chat?batchId=&folder=` reads `odd_chat_log.jsonl` back on every page load and the panel renders it as the initial message log — verified live (see below): asked a question, reloaded the whole page, the question+answer were still shown. History is also shared with anyone asking from a terminal (`odd-chat` CLI) against the same run folder, since both read/write the same file. |
| What exactly does the LLM see each turn? | System prompt (role + hard rules, §SYSTEM_PROMPT in `odd_chat.py`) + a **routed slice** of `odd_chat_briefing.json` (not the whole file — `route()` picks clusters/pairs/rules/boundary sections based on keyword intent classification, §7.6) + the last 8 dialog turns + the new question. It never sees raw trajectories, full BEV images, or the full `context_medoid.md`/pair `process/context.md` timelines (§7.4 "Never (v1)" list, unchanged). |
| Full BEV / all context, or just analysis results? | Just analysis results (the deterministic + LLM-authored *products* — collision rates, medoid motives, pair separation calls, CART rules, boundary counts) — never the raw per-frame BEV/trajectory data. This is the "light RAG / grounded prompting" scope decided in §2.4, explicitly not full RAG over raw sensor data. |

**Deviation from §7.1 "same model + API key controls as Medoid/Pair tabs (reuse Analyze
state)":** built with its **own** independent model/API-key fields inside `OddChatPanel`,
rather than reading `AnalyzeClient`'s `model`/`apiKey` state. Reason: `RunReportTab` (and thus
`OddChatPanel`) does not currently receive those two pieces of parent state as props, and a
user may reasonably want to ask a Q&A question with a different model (e.g. `gemini-2.5-pro`
for a harder synthesis question) than whatever they last used for medoid/pair analysis. Sharing
state would need threading two more props through `RunReportTab`; kept independent to avoid
that churn for a genuinely small UX cost (one extra dropdown + field).

**End-to-end verification (two independent passes, both real LLM calls):**

1. `curl POST http://localhost:3000/api/odd-chat` with `{batchId: 9, folder:
   "4_cluster_s=0.7482", question: "Which scenario should we test next?", model:
   "gemini-2.5-flash"}` (no key — used the dashboard server's own `GOOGLE_API_KEY` env var)
   returned a real grounded answer citing `boundary export` + `rule R4` in ~11.5s; the follow-up
   `curl GET .../api/odd-chat?batchId=9&folder=...` immediately showed **both** that new turn
   **and** an earlier turn asked from a plain terminal `odd-chat` CLI call in a previous session
   — direct proof the browser route and the CLI read/write the exact same `odd_chat_log.jsonl`.
2. Browser automation on `batch8/3_cluster_s=0.8032`: panel rendered with model dropdown +
   ephemeral API-key field + question box; found **4 pre-existing Q&As already there** on first
   load (from earlier CLI gold-question testing — same cross-interface persistence as above),
   asked a new 5th question ("How can we improve the AV system's safety?"), got a real
   4-point cited answer (~15s), then hit F5 and confirmed **all 5** Q&As — the 4 old + the 1 new
   — were still rendered after the reload, with no console/network errors. This directly
   confirms "next time open the dashboard can see the conversation history" already works.

### Out of scope

- [x] Cross-eval activation
- [x] New selection-eval phase
- [x] Medoid/pair redesign
- [x] Nested YAML / audit layer (deferred)
- [x] Two-pass pair / traj-projection LLM / DL ODD / roadId dual-store

---



## 10. Thesis claim (honest)

For sampled logical scenarios, deterministic clustering and parameter-space pairs
locate and explain candidate **behavioral / safety frontiers** in
scenario-parameter space; exporting Explore boundary filters and fitting shallow
rules scales beyond 1:1 pairs; a run report and grounded Q&A let engineers
discuss those limits — without treating LLM text as numeric ground truth, and
without claiming a full SAE J3016 ODD certificate.

---



## 11. Decision log


| Date       | Decision                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| 2026-08-20 | Freeze medoid + pairs; build report + boundary + rules + chat.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| 2026-08-21 | Drop cross-eval; no new selection-eval phase.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| 2026-08-21 | Expand Q&A / boundary designs + paper links.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| 2026-08-21 | **Validation pass:** checked repo (Explore = scenario params, min–max distance ≠ pair z-score); read Lewis RAG, Song CSI, J3016/Koopman, XAI AD review. Corrected overclaims (full ODD, full RAG, CSI-equivalence). Remaining todos: ISO 21448 skim, Warwick skim, C1–C4 experiments.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| 2026-08-21 | S0/S1 built (Run report tab + `cluster-run-report` API), verified additive/read-only via `git diff --stat` + `tsc --noEmit` + lints.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| 2026-08-21 | S2 built: `boundaryExport.ts` helper + `odd-boundary-export` route + Filtering export button + Run report section E wiring. Export schema changed from one flat list to two named sections (`collision_boundary`, `cluster_boundary`) — see §2.4/§6.2 note. C1 (spot-check vs Explore UI) still open before trusting it for S3/S4.                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| 2026-08-21 | S2 bugfix pass (user-reported on live export): raw Mongo-hash parameter keys → human names (positional match, TS side); `cluster_label: null` for unclustered trials → gated collision-boundary on non-null labels both sides + added `n_trials_without_cluster_label`; single filename regardless of kNN/filter type → added `.kNN{k}` snapshot + separate `odd_all_trials.json`; default kNN 25→10 (boundary-detection literature uses small k for local precision).                                                                                                                                                                                                                                                                                                                           |
| 2026-08-21 | **S2 Python CLI twin built** (`odd_export.py`, closes A4): discovered Payload's live `Trial` REST collection has zero docs for this dataset — trial parameters/KPIs only exist inside the saved Dashboard analysis zip, so the twin reuses `dataset_builder._fetch_payload_analysis` (not a new GraphQL/REST path) and resolves parameter names from each trial's own embedded `batch.scenario.parameters` (self-consistent, sidesteps the ObjectId-epoch mismatch entirely rather than working around it positionally). Verified byte-for-byte identical output vs the browser-produced export on `batch8/3_cluster_s=0.8032` — this supersedes/satisfies C1. Ran on all 3 user-requested test folders (`batch8/3_cluster_s=0.8032`, `batch8/6_cluster_s=0.6113`, `batch9/4_cluster_s=0.7482`). |
| 2026-08-21 | **S3 built** (`odd_rules.py`, sklearn `DecisionTreeClassifier`, analyzer conda env). Ran C2 depth ablation (1–4) on `batch8/3_cluster_s=0.8032`: kept `max_depth=3` default (best readability/accuracy trade-off — see §9 S3). Wired into `cluster-run-report` route + `AnalyzeClient.tsx` Run Report section E (rules table with predicate/predicted/support/precision/boundary-hits), verified with a live screenshot showing real CART output rendered from the CLI-written JSON.                                                                                                                                                                                                                                                                                                             |
| 2026-08-21 | **S4 built** (`odd_join.py`) — joins S2 boundary trial ids with `parameter_space_pairs/*/pair.json` by trial id only (never compares min-max vs z-score distances directly, per §2.1 A2). Wired into Run Report as a chip + into the S5 briefing as `pairs_touching_boundary`.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| 2026-08-21 | **S5 built** (`odd_briefing.py` + `odd_chat.py`): deterministic briefing assembly (no LLM) + keyword-router grounded chat (reuses `llm_factory.py`, same API-key contract as Analyze; last-8-turn memory; logs to `odd_chat_log.jsonl`). Ran all 4 practical gold-question categories for real against `gemini-2.5-flash` on 2 of the 3 test runs — answers cited real cluster/pair/rule ids and kept LLM-authored vs deterministic language separate. **Deliberately did not build the browser** `/api/odd-chat` **route + chat UI this pass** — user explicitly asked for a working code/CLI version first; `odd-chat` CLI is the verified, working S5 interface today, and a thin route that shells out to it is the natural (undone) follow-up.                                              |
| 2026-08-21 | All 5 new CLI subcommands (`odd-export`, `odd-rules`, `odd-join`, `odd-briefing`, `odd-chat`) added to `llm_pipeline/cli.py`, run end-to-end on all 3 user-requested test folders. Dashboard changes (`cluster-run-report/route.ts`, `AnalyzeClient.tsx`) are additive reads of the new JSON files only — verified via `tsc --noEmit` (no new errors) + `ReadLints` (clean) + a live screenshot.                                                                                                                                                                                                                                                                                                                                                                                                 |
| 2026-08-21 | **Full-pipeline verification pass** (later session, on explicit request): did **not** re-run `dataset_builder.py` / `cluster-interpret --products medoid` on the 3 test folders (frozen, non-deterministic LLM re-run would risk changing tuned output for no benefit) — verified completeness by reading the on-disk layout instead. This found a genuine gap: parameter-space **pair** contrasts were only 2/9 done for `batch8/6_cluster_s=0.6113` and 0/4 for `batch9/4_cluster_s=0.7482` (medoid + summary were 100% done for all 3). Filled the gap additively (`--rebuild-context-texts` for batch9's missing `process/context.md`, then `cluster-interpret --products parameter-space-pairs --pairs <missing-only>` — never touched the 11 already-complete pairs/clusters), then re-ran `odd-join`/`odd-briefing` for the 2 changed folders. All 3 folders now show `odd_chat_briefing.json` → `missing: []`. See §9.2. |
| 2026-08-21 | **Built the browser Q&A UI** (previously deferred): `app/dashboard/.../api/odd-chat/route.ts` (GET history / POST ask) + `scripts/run_odd_chat.sh` (new, mirrors `run_cluster_analyze.sh`'s conda-env pattern) + `OddChatPanel` component appended to the bottom of the Run Report tab in `AnalyzeClient.tsx`. Both the CLI and the browser route call the exact same `python -m llm_pipeline.cli odd-chat` — one LLM-calling implementation. Deviated from §7.1's "reuse Analyze model/API-key state": gave the panel its own independent model+key fields instead, since `RunReportTab` doesn't currently receive those two as props (see §9.3 for the full reasoning). Verified with `tsc --noEmit` + `ReadLints` (clean) and a live browser test: asked a real question, got a grounded answer with citations, reloaded the page, confirmed the history persisted (read back from `odd_chat_log.jsonl`, not browser storage). See §9.3 for the full answer to "does it need an API key / login / does history persist" written out explicitly. |


