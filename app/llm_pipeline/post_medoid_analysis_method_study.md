# Post-medoid analysis method study

Parameter-space pairs → cluster summary → label-review → cross-cluster (plus how this sits next to ODD). Companion to [`medoid_analysis_method_study.md`](medoid_analysis_method_study.md).

Internal sources:

- [`README.md`](README.md) §§1, 4.2–4.5, 6
- [`prompt_templates/parameter_space_pair_prompt.txt`](prompt_templates/parameter_space_pair_prompt.txt)
- [`prompt_templates/cluster_summary_prompt.txt`](prompt_templates/cluster_summary_prompt.txt)
- [`prompt_templates/cluster_reviewer_prompt.txt`](prompt_templates/cluster_reviewer_prompt.txt)
- [`prompt_templates/cross_cluster_prompt.txt`](prompt_templates/cross_cluster_prompt.txt)
- [`docs/cluster_selection_evaluation.md`](docs/cluster_selection_evaluation.md)
- Examples: [`results/batch8/6_cluster_s=0.6113/parameter_space_pairs/c0-c4/output/contrast.yaml`](../../results/batch8/6_cluster_s=0.6113/parameter_space_pairs/c0-c4/output/contrast.yaml), [`results/batch8/6_cluster_s=0.6113/cluster1/output/cluster_summary.yaml`](../../results/batch8/6_cluster_s=0.6113/cluster1/output/cluster_summary.yaml)

---

## 1. Intended data flow (after one medoid exists)

```text
clusterN/output/medoid_trial.yaml          # archetype of cluster N
        │
        ▼
parameter_space_pairs/cA-cB/
  process/context.md + synced_bev/         # IC-matched sides, shared clock
  + both medoid extracts (backdrop only)
        │  LLM
        ▼
  output/contrast.yaml                     # separation_call: justified | over_fine | inconclusive
        │
        ▼  (every touching contrast must exist)
clusterN/output/cluster_summary.yaml       # independent per cluster
        │  label-review (one call / run)
        ▼
  label rewritten if chained / duplicated
        │
        ├─ rule  → cross_cluster/input/cluster_selection_eval.json
        └─ LLM   → cross_cluster/output/cross_cluster_eval.json
                    (keep | merge | split | try_other_k)

ODD S2 / S3 / S5 is AFTER this stack (parameter kNN / CART). It is not this prompt chain.
```

**Why this order exists (and it is logically sound):**

| Stage | Question | Unit of evidence |
|-------|----------|------------------|
| Medoid | What is the interior archetype? | One trial + BEV |
| Parameter-space pair | If **initial conditions match**, is the cluster cut **behavior** or **over-fine geometry**? | Two boundary trials, shared clock |
| Summary | Can we **name** this cluster and say how it sits vs IC-neighbors? | Medoid + *this* cluster’s pair cards |
| Label-review | Are names comparable on a heatmap legend? | Labels + caption excerpts only |
| Selection-eval (rule) | Countable purity / motive distinctness / pair flips | `cluster.json` + YAML fields |
| Cross-eval (LLM) | Is the **whole partition** usable? | All of the above, no raw `cluster.json` |

This is the right scientific stack: **point → matched contrast → local name → global verdict**. Silhouette stays geometric; behavior is judged later. That split is documented in `cluster_selection_evaluation.md` and matches why k=6 vs a lower-silhouette k can disagree with the paper.

**What is *not* in this LLM chain (gap):** `trajectory_projection_pairs/` (MFPCA-near, different params) has packs but **no LLM product**. IC pairs test “same input, different cluster.” Embedding pairs would test “same shape, maybe different input.” PEGASUS-style work uses **both** (see §4).

---

## 2. Stage-by-stage: logic, prompt precision, example faults

### 2.1 Parameter-space pairs

**Logic — good.** Closest-parameter trials from two clusters are a **counterfactual / matched-IC** test. Prompt correctly says:

- Clustering was **whole-trajectory** MFPCA+HDBSCAN, so shape ≠ one intent.
- Params are **OpenSCENARIO inputs**, not peak-conflict speed.
- Medoids are a **backdrop**, never copied onto a side; medoid mismatch must not force `inconclusive`.
- Judge **persistent geometry** (longitudinal relationship, min boundary distance), not a 0.3 s brake-onset.
- `separation_call` last; rubric `{justified, over_fine, inconclusive}` is closed.

**Prompt — too long and not exclusive.** ~240 lines restates glossary, family definitions, and the same `resolution / control_response / primary_motive` triple that medoid **retired at trial level**. Pair sides still use **top-level** `interaction_resolution` / `control_response` / `primary_motive` (not `agent_interactions`). Schema drift vs medoid.

**Example `c0-c4/contrast.yaml` (batch8 k=6):**

- Left: `yield` + `stop` + `yield_to_vehicle`, outcome safe.
- Right: `yield` + `late` + `late_reaction`, outcome collision.
- `motive_contrast: **same**` — **false** (`yield_to_vehicle` ≠ `late_reaction`). Prompt allowed a same/different bit that the model ignored.
- `separation_call: justified` under rubric **2b** (same family, different outcome, persistent clearance) is reasonable.
- `critical_divergence.at: 10.3` vs BEV token `t_09.80_…` — clock vs filename not aligned.
- `control_response: late` vs `stop` re-opens the medoid overlap (`late` ≈ `late_reaction`).

**Verdict:** Keep the **stage**. Tighten the **schema**: one family bit + one closed motive (or compile the triple in code). Make `motive_contrast` pipeline-computed (`left.primary_motive == right.primary_motive`). Do not ask the LLM for a field it already emitted twice.

### 2.2 Cluster summary

**Logic — good, with one leak.** Independent per-cluster calls avoid “copy the neighbor’s name.” Pair `separation_call` is **mapped** to `verdict` (`justified→distinct`, `over_fine→similar`). `neighborhood_separation` roll-up (`well_separated` / `merge_candidates` / `needs_finer_split` / `ambiguous`) is the right local product. `distinct_from_neighbors` is already **pipeline**. `risk_level` is pipeline from collision rate.

**Prompt — precise on mapping, imprecise on medoid fields.** Step 1 still says “restate **primary_motive**” after medoid moved motives onto `agent_interactions`. Caption still invites mechanism chaining (“late_reaction + pass_first”), then label-review has to undo it.

**Example `cluster1/cluster_summary.yaml`:**

- After review: `label: Late Pass-First` (was `Late Reaction Pass-First (Safe)` — Rule 1 fired; **label-review works**).
- Caption still leads with “Late Reaction Pass-First (Safe) archetype” and `assertive_gap_acceptance` → `late_reaction`.
- `motive_consistency_note` cites **secondary_motives** / `post_clear_recovery` (retired).
- All three neighbors `distinct` → `well_separated`. Internally consistent with the mapping. Whether those three pairs are enough to **prove** the whole cluster is one behavior is a coverage question (not a prompt bug).

**Verdict:** Keep independent summaries. **Compute `neighborhood_separation` in Python** from `neighbor_comparison` (same as `distinct_from_neighbors`) so the LLM cannot invent `well_separated` while listing mixed verdicts. Feed `agent_interactions[0]` not deleted `primary_motive`.

### 2.3 Label-review

**Logic — necessary.** Independent naming produces duplicates and chained titles. One run-level pass with **no BEV / no YAML re-read** is the right cheap critic.

**Prompt — precise enough.** Two rules only; JSON array; do not invent evidence. The batch8 c1 audit block shows it did what it should.

**Improve:** Ban leftover tokens (`Safe`, `Collision` when `risk_level` already encodes outcome) if the style set is heatmap-legend only. Optional closed list of allowed labels (paper CS3 set) as few-shot, not free 2–4 words.

### 2.4 Cross-cluster + selection-eval

**Logic — good as a hybrid.** Rule file always exists; LLM must not recompute rates; silhouette ≠ behavior. Scores 1–10 + `recommended_action` ∈ `{keep, merge, split, try_other_k}` is an analyst-facing product.

**Prompt — overlaps Stage B.** Steps 3–5 re-walk every pair and the neighbor rollup that summary already produced. Instruction says “cite the rollup rather than re-deriving,” but still asks for a full pair-by-pair CoT. That burns tokens and invites **contradicting** a local `justified` without new evidence.

**Improve:** Cross-eval input = (1) `cluster_selection_eval.json` digest, (2) labels + `neighborhood_separation`, (3) **only** pairs whose `separation_call` disagrees with the rollup or with purity. Question: “given these measurements, keep/merge/split/k?” Do not re-score each pair.

### 2.5 Relation to ODD (do not conflate)

`README.md` §6 S2 / S3 / S5 (`odd-export` kNN, CART rules, chat) is **ODD-ish coverage in parameter space**. It does **not** use these YAML prompts. Keep / slim of those products: **§7**.

Literature “ODD boundary” = claimed **operating envelope** (weather, road type, speed, actor classes) ± fuzzy membership — **not** an HDBSCAN cut in MFPCA space.

Our IC pair is a **behavior boundary under matched scenario parameters**. Our S2 kNN is an **ODD-style coverage / pass-fail boundary** in the sampled parameter box. Keep both; do not rename cluster `separation_call` as “ODD.”

---

## 3. Is the flow good enough?

| Question | Answer |
|----------|--------|
| Is pair → summary → review → global eval a valid analysis flow? | **Yes.** Supported by scenario-testing hierarchy + recent LLM cluster-description pipelines (§4). |
| Are prompts precise enough? | **Rubrics are precise; schemas are not.** Too much synonymy (`justified/distinct`, `late/late_reaction`, deleted `primary_motive` still in later prompts). |
| Must we adjust the **order**? | **No.** Adjust **contracts** (fields, who computes them) and add the missing embedding-pair LLM, not a new stage between summary and cross-eval. |
| Is cross-eval redundant? | **Partly.** Keep the rule score; slim the LLM to a global recommendation. |
| Is this ODD analysis? | **Only S2 / S3 / S5** (see §7). This prompt chain is **cluster quality + behavior naming**. |

---

## 4. Papers (clickable) — cluster / ODD / behavior / LLM-on-trajectories

### 4.1 Closest LLM pipeline to ours (embed → cluster → describe → compare)

#### LLM-informed geometric trajectory embedding + HDBSCAN + GPT-4o

- **Venue / year:** VEHITS 2025
- **Links:** [PDF](https://www.scitepress.org/Papers/2025/132765/132765.pdf) · [HTML](https://www.scitepress.org/publishedPapers/2025/132765/pdf/index.html)
- **Key points:** VRAE trajectory embeddings → **HDBSCAN** → GPT-4o in **three prompt steps**: (1) describe **one** scenario, (2) describe the **cluster** via 5 nearest neighbors, (3) **compare to other clusters** (5 samples each). GraphRAG retrieval, 80.2% precision on behavioral queries.
- **Vs us:** Same ladder (point → cluster → inter-cluster). They compare **embedding neighbors**; we compare **parameter-matched** neighbors. We are stronger on IC contrast; they are stronger on “does this cluster look like one behavior internally?” We never LLM-describe **intra-cluster** members (only the medoid). That is the main missing prompt.

### 4.2 Scenario clustering (non-LLM, justifies *why* we cluster then pick archetypes)

#### Behavior-based vs criticality-based clustering of concrete scenarios

- **Venue / year:** arXiv 2023 (PEGASUS / scenario-reduction line)
- **Links:** [PDF](https://arxiv.org/pdf/2306.12738)
- **Key points:** Functional → logical → concrete (Menzel). Cluster concrete scenarios inside one logical class with DTW + **DBSCAN**, plus a **criticality** clustering. **Archetype** per cluster for set reduction.
- **Vs us:** MFPCA+HDBSCAN is our DTW/DBSCAN analogue. Medoid = archetype. They warn behavior clustering ≠ criticality clustering — same as our “whole-trajectory cluster can mix pass-collide and yield-collide.” Pair prompt already states this; summary should **measure mixture**, not only name the medoid.

#### 6-Layer Model (PEGASUS environment description)

- **Venue / year:** IEEE Access 2021
- **Links:** [IEEE](https://doi.org/10.1109/access.2021.3072739)
- **Key points:** Structured environment layers (road, roadside, temporary, **dynamic objects**, weather, digital). Scenarios are described **without** baking in actor intent.
- **Vs us:** IC params live on dynamic-object / behavior layers; MFPCA lives on trajectories (layer 4 motion). Pair prompt’s “params ≠ measured speed” is PEGASUS-correct.

### 4.3 ODD boundary / coverage (our S2 / S3 / S5, not the YAML chain)

#### ODD-driven coverage for safety argumentation

- **Venue / year:** IEEE Access 2023
- **Links:** [IEEE](https://ieeexplore.ieee.org/document/10036064/) · [Graz record](https://tugraz.elsevierpure.com/en/publications/operational-design-domain-driven-coverage-for-the-safety-argument/)
- **Key points:** Quantify ODD coverage across scenario levels; **k-means with boundary constraints** to sample with fewer concrete scenarios; intersection risk beyond TTC.
- **Vs us:** S2 kNN on pass/fail and cluster label is a **coverage / boundary hit** idea. They sample to cover; we **analyze a finished sample**. Do not use cluster `separation_call` as ODD coverage.

#### ODD and behavior-based scenario generation

- **Venue / year:** IEEE Access 2024
- **Links:** [IEEE](https://doi.org/10.1109/access.2024.3350512)
- **Key points:** ODD **does not include behavior**; ODD × **behavior competency** generates logical then concrete scenarios. Mentally an “ODD boundary,” tests inside / on / outside.
- **Vs us:** Paper CS params (OncomingSpeed, delay) are ODD+behavior **inputs**. Clusters are **observed competencies**. Pair = two competencies at almost the same ODD point — exactly their “on the boundary” thought experiment.

#### ODD and behavior-based **coverage** (Part II)

- **Venue / year:** IEEE Access 2024 / Warwick wrap
- **Links:** [PDF](https://wrap.warwick.ac.uk/id/eprint/198883/1/ODD_and_Behavior-Based_Approach_to_Scenario_Coverage_for_Automated_Driving_Systems_Testing.pdf)
- **Key points:** Four metrics: attribute range, ODD+behavior coverage, **out-of-ODD**, rules-of-the-road. ALKS case study.
- **Vs us:** S3 CART rules ≈ attribute-range predicates. We do not systematically test **out-of-ODD**. Improvement for S2/S3/S5, not for contrast.yaml.

#### ODD monitoring with fuzzy membership / time-to-exit

- **Venue / year:** IEEE ITSC 2024
- **Links:** [HAL PDF](https://hal.science/hal-04829701v1/document)
- **Key points:** Fuzzy ODD membership, time-to-exit. Boundaries are **graded**, not a hard cluster cut.
- **Vs us:** `inconclusive` / mixed `needs_finer_split` is our graded boundary. Do not force every pair to `justified`/`over_fine`.

#### SOTIF-compliant semi-concrete scenarios

- **Venue / year:** arXiv 2023
- **Links:** [arXiv](https://arxiv.org/abs/2308.07025)
- **Key points:** Logical / semi-concrete / concrete feature models aligned to 6LM. Equivalence classes on continuous params.
- **Vs us:** A parameter-space pair is two **concrete** points inside one **logical** cut-in. `param_dist ≤ τ` is a local equivalence class — good. Reporting **which logical class** (not only cA–cB) would match SOTIF language.

### 4.4 Counterfactual / contrastive explanation (why IC pairs are the right *test*)

#### SVCE — Shapley-guided counterfactuals for AV ML

- **Venue / year:** IEEE T-ITS 2024
- **Links:** [IEEE](https://doi.org/10.1109/tits.2024.3393634)
- **Key points:** Counterfactuals = **minimal input change** that flips the output. Shapley guides which features to change. User study on DQN driving + lane-change prediction.
- **Vs us:** Parameter-space pair ≈ a **data-driven counterfactual** (nearest other-cluster trial in z-scored params). We explain the **observed** flip; they **search** a flip. Our `critical_divergence` should stay a **minimal geometric delta**, not a full timeline dump (prompt already says this; c0–c4 still writes four phases before the 0.6 m clearance).

#### Perception-failure corner cases via counterfactual worlds

- **Venue / year:** IEEE ICUS 2022
- **Links:** [IEEE](https://doi.org/10.1109/icus55513.2022.9986744)
- **Key points:** Accident + perception fail ≠ perception **caused** the accident; test a counterfactual world.
- **Vs us:** “Both collide” is not a motive. Pair prompt already forbids stopping at both-collide. Keep it.

### 4.5 LLM on trajectories / intention (prompt shape, not partition eval)

#### LC-LLM — explainable lane-change + trajectory

- **Venue / year:** arXiv 2024 (OpenReview preprint; not confirmed T-IV)
- **Links:** [arXiv](https://arxiv.org/abs/2403.18344) · [HTML v2](https://arxiv.org/html/2403.18344v2) · [OpenReview PDF](https://openreview.net/pdf?id=UON2CeDe2I)
- **Key points:** Scene → natural-language prompt → LLM; CoT + **explicit explanation request** at inference; SFT on highD. Dual output: intention/trajectory **and** why.
- **Vs us:** Medoid/pair already dual-channel (YAML + prose). They **fine-tune**; we **prompt**. For pair/summary, few-shot of *good* `separation_call` rows would help more than another page of rubric.

#### INTENT — intention-guided contrastive clustering

- **Venue / year:** arXiv 2025
- **Links:** [HTML](https://arxiv.org/html/2503.04952)
- **Key points:** Contrastive clustering of trajectory encodings into **four** intentions (straight / left / right / static) to handle fuzzy multi-modality.
- **Vs us:** Closed **small** intention set. Our pair still has 3×7×~10 motive combinations. Shrink pair-side labels toward INTENT-scale (pass / yield / other).

#### Driving-style deep temporal clustering + SHAP

- **Venue / year:** IEEE ITSC 2023
- **Links:** [IEEE](https://doi.org/10.1109/itsc57777.2023.10421826)
- **Key points:** Unsupervised temporal clusters of driving style; **SHAP** for feature importance (explain cluster, not one LLM paragraph).
- **Vs us:** Selection-eval’s numeric components are our SHAP analogue. Cross-eval should **read** them, not replace them.

### 4.6 Scenario *analysis* surveys (prompt recipes)

See also [`medoid_analysis_method_study.md`](medoid_analysis_method_study.md) §4.4:

- [Foundation models: generation **and** analysis](https://arxiv.org/abs/2506.11526) (survey 2025) — analysis = narrator → CoT/RAG; no large labeled cluster-QA set.
- [Generative AI for ADS testing](https://arxiv.org/abs/2508.19882) (survey 2025) — Gao et al. safety-criticality with CP+CoT+ICL; You et al. driving-style RAG. Our pair is closer to **evaluation** than generation.

DriveLM / Reason2Drive / DriveVLM (ECCV/CoRL 2024) still apply: **factor** yield vs speed vs outcome; do not re-ask all three on pair sides.

---

## 5. How to improve (ordered)

**Keep (already aligned with papers):**

1. Medoid → IC pair → local summary → global eval.
2. Hybrid rule+LLM for partition quality.
3. Independent cluster labels + one critic pass.
4. IC matching as counterfactual test (Access 2024 ODD×behavior; T-ITS 2024 CE).
5. Honest `inconclusive` / `needs_finer_split` for mixed whole-trajectory clusters.

**Adjust (prompts / contracts, not the DAG):**

| # | Change | Why |
|---|--------|-----|
| 1 | Pair sides: **one** `resolution` **or** one `motive`, not the retired triple. Pipeline-set `motive_contrast`. | Same overlap as medoid; c0–c4 already emitted `motive_contrast: same` wrongly. |
| 2 | Point pair prompt at `agent_interactions`, or stop asking summary for `primary_motive`. | Schema drift. |
| 3 | **Python** `neighborhood_separation` from verdicts. | LLM roll-up is a mapping table — do not pay tokens for it. |
| 4 | Cross-eval: consume rollup + selection-eval; **do not** re-judge every pair. | VEHITS step 3 is global compare, not a second pair LLM. |
| 5 | New cheap product: **intra-cluster** “5 nearest to medoid” caption (VEHITS step 2). | Detects mixture the medoid hides. |
| 6 | Optional LLM on `trajectory_projection_pairs` (same shape, different params). | Complements IC pairs (PEGASUS behavior vs criticality views). |
| 7 | Keep ODD language on **S2 / S3 / S5** only (details §7). | ISO/Access ODD ≠ HDBSCAN cut. |
| 8 | Pair few-shot: one `justified` 2b (c0–c4 style) + one `over_fine` example. | LC-LLM / Text2Scenario: examples beat rubric length. |
| 9 | Validator: `motive_contrast` vs actual codes; `separation_call` vs family+outcome table as a **warning**, not a silent overwrite (unless you fully compile the call). | SAFE self-check. |

**Good enough for now if:** you treat current YAMLs as **narrative plus a noisy enum**, trust `separation_call` + pair context more than `motive_contrast`, and run label-review. **Not good enough** to freeze the pair schema while medoid already deleted the same triple.

---

## 6. One-paragraph status

Post-medoid flow is **logically correct** and closer to published AV practice than the medoid triple was: IC-matched pairs are counterfactuals; summaries name clusters; a critic unifies labels; a hybrid eval judges the partition. Prompts are **rubric-heavy and schema-stale** (pair still uses `interaction_resolution`/`control_response`/`primary_motive`; summary still asks for deleted medoid keys; `motive_contrast` can contradict the two motives; cross-eval re-does pair work). Papers that **support the flow**: VEHITS 2025 (HDBSCAN + GPT-4o scenario/cluster/inter-cluster), PEGASUS clustering+archetypes, IEEE Access 2024 ODD×behavior, T-ITS 2024 counterfactuals. Papers that **do not** say “call HDBSCAN an ODD boundary.” Improve by shrinking pair labels, compiling roll-ups, adding intra-cluster LLM, and leaving ODD to S2 / S3 / S5 (**keep S2/S3; do not replace S5 with full RAG** — §7).

---

## 7. S2 / S3 / S5: keep, slim, or replace?

This section is **not** a new LLM stage in the pair→summary→cross DAG. S2, S3, and S5 sit **after** that stack (`README.md` §6). File layout, example numbers (batch8 k=6), and engineer-facing meaning of each JSON: that README. Here: whether the *products* earn their keep.

On-disk example (`results/batch8/6_cluster_s=0.6113/analysis/odd/`):

| Product | File | Size / facts (this run) |
|---------|------|-------------------------|
| S2 table | `input/odd_all_trials.json` | 3869 trials (~824 KB) |
| S2 frontier | `output/odd_boundary_export.json` | 650 collision-boundary / 741 cluster-boundary; kNN=10 (~718 KB) |
| S3 CART | `output/odd_parameter_rules.json` | 8 leaves, train acc 0.857, cv 0.842 (~3 KB) |
| S5a KB | `output/odd_chat_briefing.json` | ~15 KB, `missing: []` |
| S5b log | `analysis/logs/odd_chat_log.jsonl` | per-turn Q/A + citations |

### 7.1 Do not delete S2 or S3

**S2 is the only persisted frontier.** Without it, Explore’s kNN filter is a session checkbox. Report panel E, S3’s `boundary_trial_hits`, and chat “test next” all read the file. 650 mixed-neighbor **points** is the scale that 9 IC pairs cannot cover. Collision-boundary vs cluster-boundary must stay two lists (plan already split them).

**Improve S2, do not replace it:** overlay boundary trial ids on the heatmap (Explore already has the filter; Report should deep-link). Optionally emit a compact `boundary_ids.json` (just the two id sets) so S3/S5a do not parse 718 KB. kNN ablation (plan C1: 5/10/25) belongs in `snapshots/`, which already exists. Do **not** merge collision and cluster boundaries into one “ODD” list.

**S3 is the only auditable sentence over that cloud.** R4 (`OncomingStartDelay ∈ (3.855, 4.388] ∧ OncomingSpeed > 2.374` → collision, support 1688, precision 0.82, 339 frontier hits) is what an engineer can write in a thesis without pointing at a screenshot. That matches XAI-for-AD-review (interpretable trees) and Warwick attribute-range coverage — a **hypothesis about the sample**, not J3016.

**Improve S3, do not replace it:** (1) draw CART boxes on the 2D heatmap (the 2-param case studies make this free); (2) keep depth 3 as default, report C2 if you ever ship depth 5 as an appendix, not as chat text; (3) do not swap CART for a boosted/NN “ODD model” (plan: deep learning ODD is **Out**). S3 trains on **all** trials including unclustered ones — that is correct for a KPI envelope and must stay documented so nobody treats rules as “cluster physics.”

### 7.2 S5: do not build full RAG

Lewis RAG (2020) = retrieve from a **large** external index, then generate. This run’s index is already `odd_chat_briefing.json` (~6 clusters, ~9 pairs, 8 rules, boundary counts). VEHITS 2025 GraphRAG was for behavioral queries over **many** scenarios after HDBSCAN; our Q&A is over **one frozen `$RUN`**.

Full RAG (chunk `context.md` / BEV / Payload / Wikipedia) would fight the hard rule: numbers come only from briefing fields; unknown if `missing[]`. Retrieval of long timelines is how chat starts quoting a 4.388 threshold that only CART should own.

**Keep:** S5a deterministic briefing + S5b keyword router + last-8 turns + citation chips. That **is** grounded prompting / “light RAG” (plan §2.4). Chat is a **reader** of Report, not a second cross-eval.

**Improve without a vector DB:**

1. Read `separation_call` from pair YAML in S5a.
2. If chat “test next” should name coverage holes, list S2 collision-boundary ids that are not pair endpoints (inside S5a).
3. Gold Q/A + faithfulness (cite rule id / cluster id or fail). Worth more than FAISS.
4. Optional v2: user-clicked “include this pair’s contrast + one BEV” (plan §7.4) — still not RAG.

**Delete chat only if** nobody uses OddQA and Report panel E is enough. Then keep S5a as the compact run digest (it is also a convenient JSON for thesis tables). Do not delete briefing just because chat is unused.

### 7.3 New section vs new *product*

| Idea | Verdict |
|------|---------|
| New YAML prompt between summary and cross-eval | **No** (§3). |
| New ODD LLM that re-describes CART | **No** — S3 is the sentence; chat paraphrases. |
| Intra-cluster “5 nearest to medoid” LLM | **Yes**, but that is VEHITS step 2 on the **cluster** stack (§5 item 5), not S2/S3/S5. |
| Embedding-pair LLM (`trajectory_projection_pairs`) | **Yes**, cluster stack (§5 item 6), not ODD. |
| Warwick-style **out-of-ODD** / out-of-sample tests | **New S2/S3 analysis**, not a prompt: sample params **outside** the CART safe boxes and re-simulate. Only if the sampler can go there. |
| Heatmap overlay of CART boxes + S2 points | **Dashboard**, not a new JSON. Highest engineer value per hour. |
| GraphRAG / full RAG | **Out** until the corpus is many runs or papers, not 15 KB. |

**Ordered S2 / S3 / S5 work (if you touch this stack next):**

1. Draw S3 boxes + S2 points on Explore/Report.
2. Optional: unpaired S2 ids inside S5a for “test next.”
3. Gold Q/A for OddQA; leave regex router.

**Do not** rename any of this “the ODD.” SAE J3016 / Access 2024: ODD × behavior competency; our params are two axes of one logical cut-in.
