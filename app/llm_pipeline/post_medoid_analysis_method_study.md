# Post-medoid analysis method study

Parameter-space pairs → cluster summary → label-review → cross-cluster (plus how this sits next to ODD). Companion to `[medoid_analysis_method_study.md](medoid_analysis_method_study.md)`.

Internal sources:

- `[README.md](README.md)` §§1, 4.2–4.5, 6
- `[prompt_templates/parameter_space_pair_prompt.txt](prompt_templates/parameter_space_pair_prompt.txt)`
- `[prompt_templates/cluster_summary_prompt.txt](prompt_templates/cluster_summary_prompt.txt)`
- `[prompt_templates/cluster_reviewer_prompt.txt](prompt_templates/cluster_reviewer_prompt.txt)`
- `[prompt_templates/cross_cluster_prompt.txt](prompt_templates/cross_cluster_prompt.txt)`
- `[docs/cluster_selection_evaluation.md](docs/cluster_selection_evaluation.md)`
- Examples: `[results/batch8/6_cluster_s=0.6113/parameter_space_pairs/c0-c4/output/contrast.yaml](../../results/batch8/6_cluster_s=0.6113/parameter_space_pairs/c0-c4/output/contrast.yaml)`, `[results/batch8/6_cluster_s=0.6113/cluster1/output/cluster_summary.yaml](../../results/batch8/6_cluster_s=0.6113/cluster1/output/cluster_summary.yaml)`

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
```

ODD S2 / S3 / S5 is AFTER this stack (parameter kNN / CART). It is not this prompt chain.

**What this DAG is allowed to read if medoid becomes Option A rank 1** ([`medoid_analysis_method_study.md`](medoid_analysis_method_study.md) §6). Rank 1 does **not** reorder these stages. It changes the parent answer.

`timing` there is **not** `decision_timeline` (cluster1 t=9.7 near-miss text stays). It is a closed adjective `early|on_time|late` — the same slot as `control_response: late`. Rank 1 leaves that word to **this** summary’s `label`, or to a Python compare of `brake_t` vs `peak_t` (rank 2). The pair must not invent it.

| Stage | Parent answer it may prefix (DriveLM §4.5) | Breaks if medoid still emits the triple |
|-------|-----------------------------------------------|-----------------------------------------|
| Pair | Backdrop only: `resolution` + short \(Q_j\) per side | Copies `late_reaction` onto both sides; `motive_contrast: same` stays wrong |
| Summary | That backdrop + `contrast.yaml` `separation_call`. **Owns** `Late Yield` | Prompt restates named-vehicle `resolution` and `motive_summary`. On-disk batch8 summaries are the old run until §9. |
| Label-review | Labels + caption excerpt. No timeline. | Chained titles (`Late Reaction Pass-First`) come back |
| Cross-eval | Labels + rollup + selection-eval. Not a second pair walk | Re-derives a motive the medoid no longer has |

The rank-1 writer and the pair / summary / cross prompts were edited in the same pass ([`medoid_analysis_method_study.md`](medoid_analysis_method_study.md) §9). On-disk batch8 YAML is still the previous triple until the re-run in §9.

**Why this order exists (and it is logically sound):**


| Stage                 | Question                                                                                    | Unit of evidence                        |
| --------------------- | ------------------------------------------------------------------------------------------- | --------------------------------------- |
| Medoid                | What is the interior archetype?                                                             | One trial + BEV                         |
| Parameter-space pair  | If **initial conditions match**, is the cluster cut **behavior** or **over-fine geometry**? | Two boundary trials, shared clock       |
| Summary               | Can we **name** this cluster and say how it sits vs IC-neighbors?                           | Medoid + *this* cluster’s pair cards    |
| Label-review          | Are names comparable on a heatmap legend?                                                   | Labels + caption excerpts only          |
| Selection-eval (rule) | Countable purity / motive distinctness / pair flips                                         | `cluster.json` + YAML fields            |
| Cross-eval (LLM)      | Is the **whole partition** usable?                                                          | All of the above, no raw `cluster.json` |


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

**Example** `c0-c4/contrast.yaml` **(batch8 k=6):**

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

**Example** `cluster1/cluster_summary.yaml`**:**

- After review: `label: Late Pass-First` (was `Late Reaction Pass-First (Safe)` — Rule 1 fired; **label-review works**).
- Caption still leads with “Late Reaction Pass-First (Safe) archetype” and `assertive_gap_acceptance` → `late_reaction`.
- `motive_consistency_note` cites **secondary_motives** / `post_clear_recovery` (retired).
- All three neighbors `distinct` → `well_separated`. Internally consistent with the mapping. Whether those three pairs are enough to **prove** the whole cluster is one behavior is a coverage question (not a prompt bug).

**Verdict:** Keep independent summaries. **Compute** `neighborhood_separation` **in Python** from `neighbor_comparison` (same as `distinct_from_neighbors`) so the LLM cannot invent `well_separated` while listing mixed verdicts. Feed `agent_interactions[0]` not deleted `primary_motive`.

### 2.3 Label-review

**Logic — necessary.** Independent naming produces duplicates and chained titles. One run-level pass with **no BEV / no YAML re-read** is the right cheap critic.

**Prompt — precise enough.** Two rules only; JSON array; do not invent evidence. The batch8 c1 audit block shows it did what it should.

**Improve:** Ban leftover tokens (`Safe`, `Collision` when `risk_level` already encodes outcome) if the style set is heatmap-legend only. Optional closed list of allowed labels (paper CS3 set) as few-shot, not free 2–4 words.

### 2.4 Cross-cluster + selection-eval

**Logic — good as a hybrid.** Rule file always exists; LLM must not recompute rates; silhouette ≠ behavior. Scores 1–10 + `recommended_action` ∈ `{keep, merge, split, try_other_k}` is an analyst-facing product.

**Prompt — overlaps Stage B.** Steps 3–5 re-walk every pair and the neighbor rollup that summary already produced. Instruction says “cite the rollup rather than re-deriving,” but still asks for a full pair-by-pair CoT. That burns tokens and invites **contradicting** a local `justified` without new evidence.

**Improve:** Cross-eval input = (1) `cluster_selection_eval.json` digest, (2) labels + `neighborhood_separation`, (3) **only** pairs whose `separation_call` disagrees with the rollup or with purity. Question: “given these measurements, keep/merge/split/k?” Do not re-score each pair. That is DriveLM’s prefix rule (§4.5): the child sees the parent **answer**, it does not re-ask the parent question.

### 2.5 Relation to ODD (do not conflate)

`README.md` §6 S2 / S3 / S5 (`odd-export` kNN, CART rules, chat) is **ODD-ish coverage in parameter space**. It does **not** use these YAML prompts. Keep / slim of those products: **§7**.

Literature “ODD boundary” = claimed **operating envelope** (weather, road type, speed, actor classes) ± fuzzy membership — **not** an HDBSCAN cut in MFPCA space.

Our IC pair is a **behavior boundary under matched scenario parameters**. Our S2 kNN is an **ODD-style coverage / pass-fail boundary** in the sampled parameter box. Keep both; do not rename cluster `separation_call` as “ODD.”

---



## 3. Is the flow good enough?


| Question                                                        | Answer                                                                                                                                                     |
| --------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Is pair → summary → review → global eval a valid analysis flow? | **Yes.** Schütt supports the clustering split; Menzel names the logical class; SVCE does **not** justify the pair stage (§4).                              |
| Are prompts precise enough?                                     | **Rubrics are precise; schemas are not.** Too much synonymy (`justified/distinct`, `late/late_reaction`, deleted `primary_motive` still in later prompts). |
| Must we adjust the **order**?                                   | **No.** Adjust **contracts** (fields, who computes them) and add the missing embedding-pair LLM, not a new stage between summary and cross-eval.           |
| Is cross-eval redundant?                                        | **Partly.** Keep the rule score; slim the LLM to a global recommendation.                                                                                  |
| Is this ODD analysis?                                           | **Only S2 / S3 / S5** (see §7). This prompt chain is **cluster quality + behavior naming**.                                                                |


---



## 4. Papers worth reading — cluster / ODD / counterfactual

There is **no top-venue LLM+HDBSCAN pipeline** that matches ours. The closest SCITEPRESS paper (VEHITS 2025, GS proceedings SJR ~0.18) was dropped: INSTICC, not IEEE; retrieval GraphRAG, not frozen-run analysis. Cite IEEE ITSS / T-ITS / PEGASUS instead.

**How to read the numbers (2025 Scholar Metrics / 2024 JCR unless noted):**


| Index                   | What it is                                               | Use it for                                                                                                   |
| ----------------------- | -------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------ |
| **JIF**                 | Clarivate Journal Impact Factor. **Journals only.**      | T-ITS vs Access vs RA-L.                                                                                     |
| **h5-index**            | Google Scholar 5-year *h* (papers 2020–2024).            | Conferences (IV, CoRL, ECCV). ITSC is **not** in Scholar’s Transportation top-20 (those slots are journals). |
| **h-index** (SCImago)   | Lifetime journal/proceedings *h*.                        | Career volume. Access is high because it publishes a lot, not because it is selective.                       |
| **i10-index / g-index** | Google Scholar **author** metrics. **Not a venue rank.** | Ignore for “is this conference good?”                                                                        |


**Read in this order:** Menzel (hierarchy) → Schütt (behavior vs criticality clusters) → SVCE (why IC pairs). **Warwick skipped** (ODD chapter only — this file is the cluster DAG; S2/S3 vocabulary in §7 is enough). 6LM only if you need PEGASUS layer language. Prompt factoring: `[medoid_analysis_method_study.md](medoid_analysis_method_study.md)` §4 (DriveLM / DriveVLM / DiLu / SoVAR / ChatScene).

Each card is from the **PDF** (SVCE: IEEE abstract only — no free PDF). **Helps us** = a change in this repo or a claim we may write. If the method does not transfer, that is stated.

### 4.1 Scenario hierarchy and clustering (why medoid + pairs exist)



#### Menzel, Bagschik, Maurer — Functional / logical / concrete scenarios

- **Venue / year:** IEEE Intelligent Vehicles Symposium (**IV**) 2018 — IEEE ITSS premier IV forum
- **Venue metrics:** GS **h5 ≈ 59** (older Transportation snapshot); SCImago proceedings **h-index 101**. No JIF.
- **Links:** [IEEE](https://ieeexplore.ieee.org/document/8500406) · [open PDF](https://www.tu-braunschweig.de/fileadmin/Redaktionsgruppen/Institute_Fakultaet_5/IFR/Dateien_EFS/Publikationen/ScenariosForDevelopment_Test.pdf)

**What they actually do.** ISO 26262 V-model paper, **not** clustering and **not** LLM. They show that scenario *notation* requirements **contradict** across process steps (concept vs system vs test), so one representation cannot serve all phases. Three levels:

1. **Functional** — semantic, natural language, consistent vocabulary of entities and relations (their Fig. 3: “car follows truck on a two-lane curve”). For item definition and HARA. Experts must be able to write it (C1) and it must be semi-formal (C2).
2. **Logical** — same entities as **parameter ranges** in state space, optional distributions / correlations / numeric conditions (S1–S2). Their Fig. 4: lane width ∈ [2.5, 3.75] m, curve radius ∈ [300, 900] m, “follows” ⇒ truck s > car s.
3. **Concrete** — one value per parameter (T1–T3). Their Fig. 5: 3 m / 3 m / 500 m / 80 m / 60 m. Only this level is an executable test case. A logical class with continuous ranges yields **arbitrarily many** concretes.

They explicitly do **not** give a sampling algorithm (they point at Schuldt: equivalence classes, boundary values, combinatorial methods) and do not cluster concretes. PEGASUS / aFAS acknowledgements.

**What we can use.** **Thesis language, one sentence of scientific hygiene:** Payload / OpenSCENARIO family = **one logical** cut-in. Each `trial_id` = one **concrete**. An HDBSCAN cut, a pair `cA–cB`, and a cluster label (`Late Pass-First`) are **not** new logical or functional classes — they are **observed behaviors among concretes inside one logical class**. That is the citation for:

- `separation_call` is a **behavior** verdict at matched ICs, not “a new scenario type.”
- S2 kNN in parameter space is coverage of the **logical box**, not a new logical scenario.
- Do not rename a cluster “the ODD” (J3016 ODD is operating envelope; Menzel’s logical class is the sampled box).

**What we must not copy.** Their conversion pipeline (linguistic vocab → state-space ranges → ISO test cases). We **already have** concretes. We do not run HARA, we do not need a functional-scenario generator, and we should not invent a “functional YAML” above `cluster_summary`. Schuldt-style boundary sampling is closer to **S2** than to pair prompts.

**Verdict.** **Helps writing, not code.** If the thesis already says “one logical cut-in, many concretes,” skipping the PDF costs nothing in the pipeline. It does **not** justify a new LLM stage and does **not** tell us how to cluster.

#### Schütt, Otten, Sax — Behavior-based vs criticality-based clustering of concrete scenarios

- **Venue / year:** IEEE **ITSC 2023** (IEEE ITSS flagship). arXiv 2306.12738; published DOI below.
- **Venue metrics:** No GS Transportation top-20 h5 (ITSC is a conference). Below T-ITS (GS **h5 = 163**). Real IEEE ITS venue — not SCITEPRESS.
- **Links:** [IEEE](https://doi.org/10.1109/ITSC57777.2023.10422033) · [arXiv PDF](https://arxiv.org/pdf/2306.12738)

**What they actually do (from the PDF).** Inside **one logical** class (they cite Menzel Fig. 1), they (1) **explore** with Bayes opt + GPs instead of a grid, (2) cluster the resulting concretes two ways, (3) **reduce** the test set with archetypes.

- ~**400** CarMaker runs (X-intersection, ego right turn, pedestrian occluded) and ~**300** CARLA runs (T-intersection, sync points, three ego styles).
- Similarity is **not** Euclidean in parameter space — they say param distance “does not provide meaningful insights” because the optimizer, not a grid, chose the points. Distance = **DTW** on ego trajectories **or** on a criticality time series (WTTC, Euclidean/trajectory distance, traffic quality).
- Then Gaussian **RBF kernel PCA** + **DBSCAN** (no *k* a priori; two hyperparameters: minPts, ε).
- **Behavior clustering** = DTW on ego path. **Criticality clustering** = DTW on the metric course. These two partitions **disagree**. Scenario 1: behavior-cluster borders meet at the **highest-criticality** diagonal; trajectory-distance clustering ≈ high vs low criticality; WTTC clustering ≈ high / medium / low and tracks the WTTC gradient. Scenario 2: CARLA **stops on crash**, so DTW on ego traj **isolates accidents** as their own cluster — a simulator artifact they report honestly.
- **Archetypes:** principal hull vertices (extremes, “highest variability in behavior and criticality”) **plus** a prototypical point near the cluster center. Scenario 1: 15 hull vertices per cluster → **32** scenarios from ~400. They **could not** run hull analysis on Scenario 2 because the crash cluster is **non-convex**. Goal is **test-set reduction** (~10×), not naming a cloud for a paper figure.

**What we can use.** This is the **only** paper on the 4-hour path that is actually about clustering concretes.

1. **Cite the analogy, don’t reimplement it.** MFPCA+HDBSCAN ≈ their **behavior** clustering (whole-trajectory similarity inside one logical class). DTW+kernel PCA vs MFPCA is a methods footnote, not a rewrite.
2. **Behavior clustering ≠ criticality clustering** is an **empirical result**, not a prompt bug. Whole-trajectory clusters that mix pass-collide and yield-collide are **expected** (their Scenario 1 borders meet at the critical diagonal; our `risk_level` already measures that mixture). `cluster_summary` must report mixture, not only name the medoid.
3. **Medoid ≠ their archetype.** A medoid is the **typical** member (nearest the center). Their recommended test points are **hull extremes** + a center prototype. Naming the cluster after the medoid **hides the hull**. That is the real product gap: cheap **intra-cluster** cards (2–5 members: nearest-to-medoid **and/or** collision vs safe extremes) — §5 item 5. Do not wait for a second LLM stage between summary and cross-eval.
4. **IC pairs are complementary to Schütt, not copied from them.** They refuse param-space distance as similarity. We *use* param-space nearest neighbors **across clusters** as a **matched-IC contrast** (“same input, different trajectory cluster”). They never do that test. Keep IC pairs; do not claim Schütt invented them.

**What we must not copy.** Bayes-opt exploration (the sampler already filled the box). A second HDBSCAN on WTTC time series (S2 collision-boundary is already the criticality *slice*; a second partition would be a thesis figure, not a YAML product). Principal hull as a new pipeline — they themselves fail on non-convex clusters, which mixed collision clouds often are. CARLA-stop-on-crash as a clustering feature. VEHITS Langner (their related work, not ours).

**Verdict.** **Highest transfer of the three.** Helps: (a) thesis claim “trajectory clusters mix outcomes,” (b) intra-cluster members next to the medoid, (c) permission to keep silhouette ≠ behavior. Does **not** help pair-prompt wording, ODD chat, or swapping HDBSCAN for DBSCAN.

#### 6-Layer Model (PEGASUS environment description) — skim

- **Venue / year:** IEEE Access 2021 (Scholtes et al.). Standard PEGASUS cite (~200 Google Scholar citations) **despite** Access.
- **Venue metrics:** Access JCR 2024 **JIF 3.6, Q2**; GS **h5 = 288** (volume); SCImago **h-index 242**. High JIF/h5 here is **output volume**, not selectivity.
- **Links:** [IEEE](https://doi.org/10.1109/access.2021.3072739)
- **Key points:** Road / roadside / temporary / **dynamic objects** / weather / digital. Describe environment **without** baking in actor intent.
- **Vs us:** IC params sit on dynamic-object / behavior layers; MFPCA is layer-4 motion. Pair prompt’s “params ≠ measured speed” is PEGASUS-correct. Read figures, not the whole taxonomy appendix. **No code change.**



### 4.2 ODD language — Warwick **not read** (not an ODD chapter)

Warwick / WMG Access 2024 (Khastgir, Jennings; [IEEE](https://doi.org/10.1109/access.2024.3350512)) is the vocabulary paper for “ODD ≠ behavior competency.” **Do not spend an evening on it unless you write §7 as a thesis ODD chapter.** Enough for this stack: SAE J3016 ODD is the claimed operating envelope; our HDBSCAN cut is not that envelope; S3 CART is an **attribute-range hypothesis on the sample**, not an ODD statement. Existing one-liners in §2.5 / §7 stay; no further cards.

### 4.3 Counterfactual / contrastive test (why IC pairs)



#### SVCE — Shapley-guided counterfactuals for AV ML

- **Venue / year:** IEEE **T-ITS** 2024 — the ITS **journal** that counts. Li, Sun, Huang, Chen. *IEEE T-ITS* 25(10):14905–14916.
- **Venue metrics:** JCR 2024 **JIF 8.4, Q1** (IEEE ITSS site lists 9.1 in 2025 JCR); GS **h5 = 163** (#1 Scholar Transportation); SCImago **h-index 224**, SJR 2.59.
- **Links:** [IEEE](https://doi.org/10.1109/tits.2024.3393634) · [Xplore 10521560](https://ieeexplore.ieee.org/document/10521560/)
- **PDF status:** Paywalled. **No author preprint found** (arXiv search for this title/DOI empty). Card below is the **IEEE abstract + what that method class is**, not a line-by-line methods read. Do not fake a PDF read.

**What they actually do (abstract).** Explain a **trained ML model**: CE = **minimal alteration of the input that changes the model’s output**. Manual feature picking for the search is biased, so they **guide** the search with **Shapley** feature contributions (prioritize influential coordinates). Evaluated on (1) **DQN** driving decisions and (2) a **deep lane-change predictor**. User study: SVCE helps people **understand and diagnose the model**. This is **XAI for a black-box controller/classifier**, not scenario clustering.

**What we can use.** Almost nothing as an algorithm. Stretch that is still honest:

- **Vocabulary for** `critical_divergence`**:** prefer the **smallest persistent geometric/kinematic delta** that distinguishes the two sides, not a four-phase dump. That is Wachter-style CE hygiene, which SVCE assumes, not Shapley.
- **Do not call IC pairs “SVCE.”** A parameter-space pair is a **nearest observed neighbor** with a different cluster label. We **find** a flip in the sample; they **search** a flip of a **model**. HDBSCAN assignment is not a DQN policy. We cannot run their optimizer.

**What we must not copy.** Shapley-guided CE generation, synthetic inputs, a user study, SHAP on MFPCA scores as a new product (selection-eval already has numeric components; the ITSC 2023 SHAP driving-style paper was dropped for that reason). Implementing SVCE would require a model we do not have.

**Verdict.** **Prestige journal, weak transfer.** Cite only if a reviewer asks “why matched-IC pairs”; even then the honest sentence is “nearest neighbor in z-scored OpenSCENARIO params,” not “Shapley-guided CE.” **Do not implement.** Over-citing T-ITS here is borrowing the venue.

**Honest transfer (this 4-hour path).**


| Paper                | Helps this repo?                          | Concrete change                                                   | Do not do                                                |
| -------------------- | ----------------------------------------- | ----------------------------------------------------------------- | -------------------------------------------------------- |
| Menzel IV 2018       | Writing only                              | Say cA–cB ⊂ one logical cut-in                                    | Functional-scenario generator, ISO HARA YAML             |
| Schütt ITSC 2023     | **Yes — clustering analogue**             | Intra-cluster members; report mixture; keep silhouette ≠ behavior | Swap to DTW/DBSCAN; second WTTC clustering; PHA pipeline |
| 6LM Access 2021      | Optional vocab                            | Keep “params ≠ measured speed”                                    | Re-taxonomy the pack into six layers                     |
| Warwick Access 2024  | **Not read**                              | —                                                                 | Spend time here without an ODD chapter                   |
| SVCE T-ITS 2024      | Vocabulary, weakly                        | Short `critical_divergence`                                       | Shapley CE search, call IC pairs “SVCE”                  |
| You et al. ICRA 2025 | **No** — judges a driver, not a partition | —                                                                 | GPT-4o quality scores; interview RAG in S5               |




### 4.4 LLM-as-judge of a *driver* (not of a cluster partition)



#### You et al. — A Comprehensive LLM-powered Framework for Driving Intelligence Evaluation (ICRA 2025, **not** ITSC 2024)

- **Venue / year:** IEEE **ICRA 2025** (Atlanta), pp. 7028–7035. You, Luo, Liang, Yu, Zheng, Gong (Tsinghua AIR). arXiv 2503.05164 (Mar 2025).
- **Venue metrics:** ICRA is a flagship robotics conference (Scholar Robotics). **Not** ITSC. The similarly themed ITSC 2024 paper is a different work (Xu et al., LLM multimodal **warning** / ADAS — dropped below).
- **Links:** [arXiv](https://arxiv.org/abs/2503.05164) · [PDF](https://arxiv.org/pdf/2503.05164) · [IEEE ICRA 2025](https://researchr.org/publication/YouLLYZG25)

**What they actually do.** LLM-as-judge of **how well an agent drives**, not of how a sample was clustered.

1. Real-world interviews: 24 drivers + 48 passengers, 5.7 km urban, video + CAN. GPT-4 rewrites colloquial interview into 700 driver + 760 passenger **JSON knowledge units** (context / mindset / decision / action / evaluation).
2. CARLA Leaderboard 2.0: log scenario, weather, CAN, neighbors, signs → a **driving context** paragraph.
3. GPT-4o scores three dimensions: **Safety** (rules, collisions), **Intelligence** (Michon cascade: operational → tactical → strategic, RAG from the interview KG at each level), **Comfort** (passenger perception). Then one overall score.
4. Experiment: humans drove Cautious/Aggressive × Good/Bad. Style ID 30/32 (93.75%), performance ID 26/32 (81.25%), Spearman \rho=0.561 vs CARLA leaderboard score. Human raters agree ~7.28/10 with the write-up. Comfort is the weakest (6.86). Authors note safety-critical events are rare in the interview set.

**Why it sits in *this* file.** Closest LLM object to **cross-eval / selection-eval**: a judge over a run. It does **not** sit in the medoid file (no trial YAML, no pass/yield). It also does not sit in ODD S2/S3 (no parameter envelope).

**What we can use.** Almost nothing as a product.


| They judge                                | We already measure                                                             | If we copied them                                                   |
| ----------------------------------------- | ------------------------------------------------------------------------------ | ------------------------------------------------------------------- |
| Safety of a **live/manual CARLA driver**  | Pipeline `outcome` + collision anatomy                                         | LLM re-scores collisions we already computed                        |
| Intelligence (ops / tactical / strategic) | Timeline (ops) + `resolution` (tactical) + `cluster_summary.label` (strategic) | A second CoT that **re-asks** layers Option A is trying to un-merge |
| Comfort                                   | Not a paper axis                                                               | Hallucinated jerk scores from BEV                                   |
| RAG over interview KG                     | S5 briefing is **15 KB frozen** `$RUN`                                         | Full RAG — explicitly **out** in §7.2                               |


Michon operational / tactical / strategic is **older than this paper** (and already in Lefèvre 2014, which the unify plan cites). You do not need ICRA 2025 to keep those layers apart.

**What we must not copy.** GPT-4o as a replacement for `cluster_selection_eval.json`. Interview RAG in OddQA. Safety/intelligence/comfort as cluster quality. “LLM-as-judge” of **partition keep/merge/split** is already Stage B; their judge is a **different question** (is this driver human-like?).

**Verdict.** **Unused.** Real conference (ICRA, not ITSC). Wrong judge object. If a reviewer asks “why not LLM-as-judge of driving quality?”, answer: we evaluate **cluster partition + named behavior of a finished sample**, and we already have collision/rate from code. This paper’s RAG is a reason **not** to enlarge S5.

### 4.5 DriveLM “Context:” prefix vs medoid → pair → summary

PDF (appendix E.1, not the abstract): for each edge \(e=(v_p, v_c)\), **the child question is appended with the parent QA as context**. Figures write it as `Context: <parent answer>. Question: <child question>`. Training uses the **ground-truth** parent (teacher forcing). Inference runs **rounds**: P1, then P2, then P3, then B, then M — the child may not run until the parent answer exists. B is one node whose answer is the interface into M; M does not re-derive perception.

**Same wiring, different questions.** Our DAG already does this:

| DriveLM | This repo |
|---------|-----------|
| Parent QA prefixed onto the child question | Next prompt is given the previous YAML |
| P1 answer → P2/P3/B | `medoid_trial.yaml` is an input to **summary** (archetype) and a **backdrop** on the pair prompt |
| — | `contrast.yaml` is an input to **summary** |
| B answer → M, M does not re-score P1 | Cross-eval should read `separation_call` / rollup, **not** re-walk every pair (§2.4) |

So yes: question → answer → that answer is the next question’s context. That is why summary must not be called before its contrasts exist, and why label-review runs after every summary.

**Not the same graph.** DriveLM’s edges are stages of **one frame’s driving decision** (see the pedestrian → stop → “going straight, not moving”). Our edges are **different evidence**:

- Medoid question: what did **this one trial** do?
- Pair question: under **matched ICs**, are these two **boundary trials** the same behavior? The evidence is `context.md` + synced BEV, **not** the medoid. The prompt already says medoids are backdrop and must not force `inconclusive`. Prefixing the full medoid YAML as DriveLM `Context:` would make the pair **copy** `pass_first` / `late_reaction` onto both sides — the failure DriveLM accepts only because the parent is the right question. Here the parent answered a **different** question.
- Summary question: can we **name the cluster** given the medoid **and** the pair verdicts?

Copy the **prefix rule** (child sees parent **answer**, does not re-ask the parent **question**). Do not copy the **edge semantics** (pair is not “P2 of the medoid”).

**How tight the prefix should be.** DriveLM’s context is **one QA**, not the whole graph plus a glossary. Inference error **cascades**: a bad parent answer becomes the child’s premise. Our medoid YAML is a noisy parent (`motive_summary` restates stamps; three enums rename one arc). Pass a **short** prefix:

- Into summary: `resolution` + the 2–4 sentence \(Q_j\) + each touching `separation_call`. Not the full timeline and not snake_case motives.
- Into cross-eval: labels + `neighborhood_separation` + selection-eval. Not a second pair CoT.
- Into the pair call: metrics and BEV stay the question. Medoid prefix stays backdrop (one line per side), or the pair will inherit the medoid’s story.

Label-review **correctly** does not get full parent YAML (labels + caption excerpt only). That is a consistency critic, not a DriveLM child node. Do not “fix” it by stuffing medoid/contrast back in.

### 4.6 Prompt factoring on pair sides

Do not re-ask yield vs speed vs outcome as three overlapping enums on pair YAML. That argument lives in the medoid study’s **DriveLM / DriveVLM / DiLu / SoVAR / ChatScene** — not in a clustering paper.

### Dropped (checked, not worth an evening)


| Paper                                | Why dropped                                                                                                                                 |
| ------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------- |
| VEHITS 2025 Sohn et al. (SCITEPRESS) | INSTICC; proceedings SJR ~0.18. Retrieval GraphRAG, not our frozen `$RUN`. Do not cite as “closest LLM pipeline.”                           |
| Graz Access 2023 ODD coverage        | Access + redundant with Warwick.                                                                                                            |
| ITSC 2024 fuzzy ODD / time-to-exit   | Runtime **monitor**, not cluster analysis.                                                                                                  |
| SOTIF arXiv 2308.07025               | Unreviewed feature-model paper.                                                                                                             |
| IEEE ICUS 2022 counterfactual worlds | Regional IEEE. “Both collide ≠ motive” is already in the pair prompt.                                                                       |
| LC-LLM (CommTR 2025)                 | **Moved** to medoid study §4.3. Future highD LC **predictor** + LoRA; we explain finished cut-ins. Unrelated to pairs/clusters.             |
| Trajectory-LLM (ICLR 2025)           | **Moved** to medoid study §4.2. Text→behavior→waypoints **generator**. Inverse of our stack; ChatScene already covers “do not generate.”    |
| Xu et al. ITSC 2024 LLM-MW           | The actual **ITSC 2024** LLM paper: multimodal **ADAS warnings**. Not evaluation, not clustering. Do not confuse with You et al. ICRA 2025. |
| INTENT (arXiv 2025)                  | Unreviewed. “Shrink the label set” is already the medoid recommendation.                                                                    |
| ITSC 2023 SHAP driving-style         | Selection-eval already has numeric components. Schütt (same year, same conference) is the clustering paper to keep.                         |
| Two 2025 arXiv surveys               | Unreviewed.                                                                                                                                 |


---



## 5. How to improve (ordered)

**Keep (already aligned with papers):**

1. Medoid → IC pair → local summary → global eval.
2. Hybrid rule+LLM for partition quality.
3. Independent cluster labels + one critic pass.
4. IC matching as a **data-driven** contrast (nearest other-cluster trial). Schütt did **not** invent this; SVCE is a different object (model CE). Keep the stage anyway.
5. Honest `inconclusive` / `needs_finer_split` for mixed whole-trajectory clusters.

**Adjust (prompts / contracts, not the DAG):**


| #   | Change                                                                                                                                                                | Why                                                                                                                                           |
| --- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------- |
| 1   | Pair sides: `resolution` + one `evidence` sentence. No `motive_contrast`. Done in the rank-1 pass. Re-run is §9.                                                      | Same overlap as medoid; on-disk c0–c4 still has `motive_contrast: same` until re-run.                                                         |
| 2   | Summary restates named-vehicle `resolution` and `motive_summary`. Done in the rank-1 pass.                                                                            | Schema drift is closed in the prompt. On-disk summaries stay stale until §9.                                                                 |
| 3   | **Python** `neighborhood_separation` from verdicts.                                                                                                                   | LLM roll-up is a mapping table — do not pay tokens for it.                                                                                    |
| 4   | Cross-eval: consume rollup + selection-eval; **do not** re-judge every pair.                                                                                          | DriveLM / Reason2Drive: do not re-ask a slot already filled locally.                                                                          |
| 5   | New cheap product: **intra-cluster** nearest-to-medoid caption (2–5 trials).                                                                                          | Schütt: archetype ≠ the cluster; mixture hides behind the medoid.                                                                             |
| 6   | Optional LLM on `trajectory_projection_pairs` (same shape, different params).                                                                                         | Complements IC pairs. **Not** Schütt’s two clusterings (they re-cluster the same concretes; we would contrast a different neighbor relation). |
| 7   | Keep ODD language on **S2 / S3 / S5** only (details §7).                                                                                                              | J3016: ODD ≠ HDBSCAN cut. Warwick PDF **not** required for this DAG.                                                                          |
| 8   | Pair few-shot: one `justified` 2b (c0–c4 style) + one `over_fine` example.                                                                                            | DiLu / ChatScene: examples beat rubric length.                                                                                                |
| 9   | Validator: `motive_contrast` vs actual codes; `separation_call` vs family+outcome table as a **warning**, not a silent overwrite (unless you fully compile the call). | SoVAR: schema vs solver, not a second LLM.                                                                                                    |


**Good enough for now if:** you treat current YAMLs as **narrative plus a noisy enum**, trust `separation_call` + pair context more than `motive_contrast`, and run label-review. **Not good enough** to freeze the pair schema while medoid already deleted the same triple.

---



## 6. One-paragraph status

Post-medoid flow is **logically correct** and closer to published AV practice than the medoid triple was: IC-matched pairs are observed contrasts; summaries name clusters; a critic unifies labels; a hybrid eval judges the partition. Prompts now follow rank 1 (`resolution` + prose; summary owns `Late Yield`). On-disk batch8 YAML is still the previous triple until §9. Cross-eval still re-does pair work if the model ignores the “do not re-walk BEV” line. Papers, used honestly: **Schütt ITSC 2023** is the clustering analogue (behavior ≠ criticality; medoid hides mixture → intra-cluster members). **Menzel IV 2018** is vocabulary (cA–cB ⊂ one logical class) — no pipeline change. **SVCE T-ITS 2024** is model-CE XAI — do not implement; do not call IC pairs SVCE. Warwick was **not read** (no ODD chapter). Improve by shrinking pair labels, compiling roll-ups, adding intra-cluster members, and leaving ODD to S2 / S3 / S5 (**keep S2/S3; do not replace S5 with full RAG** — §7).

---



## 7. S2 / S3 / S5: keep, slim, or replace?

This section is **not** a new LLM stage in the pair→summary→cross DAG. S2, S3, and S5 sit **after** that stack (`README.md` §6). File layout, example numbers (batch8 k=6), and engineer-facing meaning of each JSON: that README. Here: whether the *products* earn their keep.

On-disk example (`results/batch8/6_cluster_s=0.6113/analysis/odd/`):


| Product     | File                               | Size / facts (this run)                                         |
| ----------- | ---------------------------------- | --------------------------------------------------------------- |
| S2 table    | `input/odd_all_trials.json`        | 3869 trials (~824 KB)                                           |
| S2 frontier | `output/odd_boundary_export.json`  | 650 collision-boundary / 741 cluster-boundary; kNN=10 (~718 KB) |
| S3 CART     | `output/odd_parameter_rules.json`  | 8 leaves, train acc 0.857, cv 0.842 (~3 KB)                     |
| S5a KB      | `output/odd_chat_briefing.json`    | ~15 KB, `missing: []`                                           |
| S5b log     | `analysis/logs/odd_chat_log.jsonl` | per-turn Q/A + citations                                        |




### 7.1 Do not delete S2 or S3

**S2 is the only persisted frontier.** Without it, Explore’s kNN filter is a session checkbox. Report panel E, S3’s `boundary_trial_hits`, and chat “test next” all read the file. 650 mixed-neighbor **points** is the scale that 9 IC pairs cannot cover. Collision-boundary vs cluster-boundary must stay two lists (plan already split them).

**Improve S2, do not replace it:** overlay boundary trial ids on the heatmap (Explore already has the filter; Report should deep-link). Optionally emit a compact `boundary_ids.json` (just the two id sets) so S3/S5a do not parse 718 KB. kNN ablation (plan C1: 5/10/25) belongs in `snapshots/`, which already exists. Do **not** merge collision and cluster boundaries into one “ODD” list.

**S3 is the only auditable sentence over that cloud.** R4 (`OncomingStartDelay ∈ (3.855, 4.388] ∧ OncomingSpeed > 2.374` → collision, support 1688, precision 0.82, 339 frontier hits) is what an engineer can write in a thesis without pointing at a screenshot. That matches XAI-for-AD-review (interpretable trees) and Warwick attribute-range coverage — a **hypothesis about the sample**, not J3016.

**Improve S3, do not replace it:** (1) draw CART boxes on the 2D heatmap (the 2-param case studies make this free); (2) keep depth 3 as default, report C2 if you ever ship depth 5 as an appendix, not as chat text; (3) do not swap CART for a boosted/NN “ODD model” (plan: deep learning ODD is **Out**). S3 trains on **all** trials including unclustered ones — that is correct for a KPI envelope and must stay documented so nobody treats rules as “cluster physics.”

### 7.2 S5: do not build full RAG

Lewis RAG (2020) = retrieve from a **large** external index, then generate. This run’s index is already `odd_chat_briefing.json` (~6 clusters, ~9 pairs, 8 rules, boundary counts). Our Q&A is over **one frozen** `$RUN`, not a trajectory search corpus.

Full RAG (chunk `context.md` / BEV / Payload / Wikipedia) would fight the hard rule: numbers come only from briefing fields; unknown if `missing[]`. Retrieval of long timelines is how chat starts quoting a 4.388 threshold that only CART should own.

**Keep:** S5a deterministic briefing + S5b keyword router + last-8 turns + citation chips. That **is** grounded prompting / “light RAG” (plan §2.4). Chat is a **reader** of Report, not a second cross-eval.

**Improve without a vector DB:**

1. Read `separation_call` from pair YAML in S5a.
2. If chat “test next” should name coverage holes, list S2 collision-boundary ids that are not pair endpoints (inside S5a).
3. Gold Q/A + faithfulness (cite rule id / cluster id or fail). Worth more than FAISS.
4. Optional v2: user-clicked “include this pair’s contrast + one BEV” (plan §7.4) — still not RAG.

**Delete chat only if** nobody uses OddQA and Report panel E is enough. Then keep S5a as the compact run digest (it is also a convenient JSON for thesis tables). Do not delete briefing just because chat is unused.

### 7.3 New section vs new *product*


| Idea                                               | Verdict                                                                                                                                |
| -------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------- |
| New YAML prompt between summary and cross-eval     | **No** (§3).                                                                                                                           |
| New ODD LLM that re-describes CART                 | **No** — S3 is the sentence; chat paraphrases.                                                                                         |
| Intra-cluster nearest-to-medoid LLM                | **Yes**, but that is Schütt “archetype ≠ cluster” on the **cluster** stack (§5 item 5), not S2/S3/S5.                                  |
| Embedding-pair LLM (`trajectory_projection_pairs`) | **Yes**, cluster stack (§5 item 6), not ODD.                                                                                           |
| Warwick-style **out-of-ODD** / out-of-sample tests | **New S2/S3 analysis**, not a prompt: sample params **outside** the CART safe boxes and re-simulate. Only if the sampler can go there. |
| Heatmap overlay of CART boxes + S2 points          | **Dashboard**, not a new JSON. Highest engineer value per hour.                                                                        |
| GraphRAG / full RAG                                | **Out** until the corpus is many runs or papers, not 15 KB.                                                                            |


**Ordered S2 / S3 / S5 work (if you touch this stack next):**

1. Draw S3 boxes + S2 points on Explore/Report.
2. Optional: unpaired S2 ids inside S5a for “test next.”
3. Gold Q/A for OddQA; leave regex router.

**Do not** rename any of this “the ODD.” SAE J3016 / Access 2024: ODD × behavior competency; our params are two axes of one logical cut-in.

---

## 8. Thesis-claim checklist — cluster meaning, ODD, collision

Trial-level inverse intent is scored in [`medoid_analysis_method_study.md`](medoid_analysis_method_study.md) §8. This section scores the rest of the pasted claim: name the cluster, find an ODD edge, find a collision boundary. “Have” means the product exists and answers that question. “Partial” means the stage exists and the prompt or the evidence still misses the question.

| # | Claim | Status | Where it actually lives |
|---|--------|--------|-------------------------|
| 1 | LLM interprets **this trial’s** behavior (sequence in, why out). | **Partial** | Medoid §8 rows 1 and 4. Sequence is in the prompt. The fence asks for `resolution` plus prose. The six medoid cards in `6_cluster_s=0.6113` match that fence. The why is still a caption of one trial. |
| 2 | That why becomes a **cluster meaning** (one name for the group). | **Partial** | `cluster_summary.label` is the name. The 2026-09-28 summaries are Proactive Yield, Pass-Slowdown, Rear-end Collision (clusters 2 and 3), and Late Yield Collision (clusters 4 and 5). Two pairs of clusters still share a name. |
| 3 | The name is the cluster, not only the medoid. | **Missing** | One medoid of 886. Intra-distance mean 2.66, max 8.54 (`context_cluster.md`). No product captions the other members (Schütt: archetype ≠ cluster). `min_ttc` 0.05 s inside a 0% collision cluster is mixture the label cannot see. |
| 4 | Matched parameters tell behavior apart from a geometry cut. | **Have** | Parameter-space pairs (same `OncomingSpeed` / `OncomingStartDelay`, different cluster) → `separation_call`. That is the behavior-vs-over-fine test. It is not an ODD sentence. |
| 5 | ODD edge = LLM reads ~100 collision texts and names shared weather / occlusion. | **Wrong tool for this sample** | Those factors are not sampled. The two axes are `OncomingSpeed` and `OncomingStartDelay`. S3 CART already writes the edge: `OncomingStartDelay ∈ (3.855, 4.388] ∧ OncomingSpeed > 2.374` → collision (support 1688, precision 0.82). An LLM paraphrase of that rule is forbidden in §7. |
| 6 | Collision boundary = LLM labels each second `Safe` / `Dangerous` / `Critical`. | **Have as numbers, missing as LLM states** | Per stamp: TTC, boundary distance, near-miss line in `context_medoid.md`. Across the box: S2 lists 650 collision-boundary trials and 741 cluster-boundary trials (kNN=10). Those lists are parameter-space neighbors that flip outcome or cluster, not a per-second semantic tag. Asking the model to re-label TTC repeats the rule system. |
| 7 | “Critical” = failed to brake within 0.5 s of the conflict. | **Missing as a product** | Cluster1 medoid: decelerate onset 9.1 s, near-miss 9.7 s (0.6 s). Rank 2 in the medoid study is the compiler that would emit that bit from `brake_t` vs `peak_t`. It is not built. The summary may still say “late” in prose after rank 1. |
| 8 | Parameters are enough to support rows 5–7. | **Enough for this scenario, not for the rain example** | Two numeric axes, full trial table in `odd_all_trials.json` (3869 trials). No precipitation, visibility, illumination, or occlusion column. A rain-and-truck ODD sentence cannot be computed from this batch. |

**Verdict.** Prompts and the writer now match rank 1 (§9). `results/batch8/6_cluster_s=0.6113` was re-run on 2026-09-28 through pairs, summaries, label-review, cross-eval, selection-eval, and the briefing. Medoid cards were left as the earlier rank-1 writes. The stack still will not prove the why, detect ghost braking, or discover weather ODD edges — those inputs are absent. ODD edge and collision frontier for **this** cut-in are S3 and S2. They stay parameter methods.

**Same-pass rule.** Satisfied for the prompt text. Intra-cluster captions (row 3) are a separate product. Without them the label remains a medoid caption.

---

## 9. How to implement — follow the rank-1 medoid

Parent contract: [`medoid_analysis_method_study.md`](medoid_analysis_method_study.md) §9. The writers already follow it. Do not put `control_response`, row `motive`, or a timing enum back. Do not re-run batch8 in the same edit as a schema change.

### 9.1 Card a new medoid writes

```yaml
agent_interactions:
  - agent: CuttingIn
    resolution: pass_first   # pass_first | yield | unresolved
decision_timeline:
  - timestamp: 10.8
    description: "<verb + quoted numbers, then one why clause>"
motive_summary: |
  <2–4 sentences>
```

`Late Yield` is only `cluster_summary.label`. Rank 2 (`brake_t` vs `peak_t` → early / on time / late) is not built. A caption may say “late” in prose. That word is not a YAML enum.

### 9.2 Function review (2026-09-28)

Checked against the current functions. No writer change came out of this pass.

| Function | What it does now | Adjust? |
|----------|------------------|---------|
| `split_analysis.ensure_named_vehicle_agent_interaction` | After merge, folds a missing partner row from legacy `interaction_resolution`, then keeps only `agent` + `resolution`. Strips row `control_response` / `motive` and stamp `motive`. Pops top-level `interaction_resolution`, `control_response`, `primary_motive`, `secondary_motives`. | No |
| `split_analysis` pair write + `_write_yaml_doc` | New contrast sides are `resolution` + `evidence`. A written `contrast.yaml` drops `motive_contrast` and the old side triple. | No |
| `cluster_selection_eval._primary_motive` | Distinctness token is `cluster_summary.label`, else the named-vehicle `resolution`. The JSON key stays `primary_motives`. It does not read a motive code. | No. Keep the key so old reports still load. |
| `cluster_selection_eval.evaluate_run_dir` | Deterministic 0–100 score. Outcome purity: share of clusters with collision rate ≤ 5% or ≥ 95% (weight 0.50). Title distinctness: unique summary labels / captioned clusters (0.50); resolution is used only when a cluster has no label. Collision-flip share and the 0/1 merge flag are not in the score. Missing components are reweighted. | No |
| `cluster_selection_eval.medoid_card_block` | Prints `agent: resolution`, `t` + description, and `motive_summary`. If an old card has no description, it still prints a stamp motive token so that card remains readable. New writes do not create that token. | No |
| `clustering_quality_scorer.compute_final_score` | Geometry is four equal pieces at 0.25: silhouette, collision-rate spread, time-to-collision spread, and tightness. The ranking number equals that geometry score. Language-model ratings are stored beside it and do not move it. | No |
| `odd_briefing` | Writes `medoid_resolution` from the named-vehicle row. Does not invent `medoid_motive`. | No |
| `cluster_reviewer_prompt.txt` | Rewrites a label that chains two mechanisms, or that duplicates another cluster’s name. It does not see the timeline or BEV. | No |

### 9.3 What each later stage may add

| Stage | May write | Must not write |
|-------|-----------|----------------|
| Parameter-space pair | Side `resolution` + `evidence`; `contrast_timeline`; `critical_divergence`; `separation_call` | `control_response`, `primary_motive`, `motive_contrast`, a timing enum |
| Cluster summary | `label` (2–4 words; the only Late Yield), `caption`, `motive_consistency_note` against resolution and `motive_summary` | A snake_case token in `label` |
| Label-review | A shorter or distinct `label` | New evidence |
| Selection-eval | Outcome purity and title distinctness. Value is the summary label, or the resolution when there is no label | A collision-flip score, a 0/1 merge flag, a fallback to a motive code |
| Cross-eval | `keep` / `merge` / `split` / `try_other_k`, plus separation and boundary-clarity ratings | A second walk of BEV, or grouping by a motive code |
| ODD briefing | `medoid_resolution` | A `medoid_motive` invented from a removed key |

### 9.4 Status of `results/batch8/6_cluster_s=0.6113`

Re-run on 2026-09-28, products `parameter-space-pairs,summary,label-review,cross-eval`, then `odd-briefing`. Medoid YAML was not rewritten in that pass. Named-vehicle resolutions are unchanged: cluster0 yield, cluster1 pass_first, cluster2 pass_first, cluster3 pass_first, cluster4 yield, cluster5 yield.

What the new cards say:

| Cluster | Summary label | Medoid resolution |
|---------|---------------|-------------------|
| 0 | Proactive Yield | yield |
| 1 | Pass-Slowdown | pass_first |
| 2 | Rear-end Collision | pass_first |
| 3 | Rear-end Collision | pass_first |
| 4 | Late Yield Collision | yield |
| 5 | Late Yield Collision | yield |

- All nine `contrast.yaml` files are `resolution` + `evidence` plus `separation_call`. None still have `interaction_resolution`, `control_response`, `primary_motive`, or `motive_contrast`.
- Separation calls: justified on c0-c4, c0-c5, c1-c2, c1-c3, c1-c5, c4-c5. Over-fine on c2-c3, c2-c5, c3-c5.
- Label-review renamed nothing. It kept both “Rear-end Collision” and both “Late Yield Collision”, with the reason that the captions describe the same behavior family.
- Selection-eval score is outcome purity and title distinctness only, equal weight. On this run that is (1.0 + 4/6) / 2 = 83.33. Collision-flip share and the merge flag are recorded and not scored.
- Cross-eval on disk: separation 5, boundary clarity 5, and a merge suggestion for C2, C3, and C5 from the 2026-09-28 run. The prompt no longer asks for a merge, a split, or a different k. Geometry is 68.0 and is the ranking number. The language-model reading of 50 is stored beside it.
- Briefing `generated_at` 2026-09-28T14:58:51Z copies the new labels and `medoid_resolution`. `missing` is empty.

### 9.5 Checklist

- [x] Pair, summary, cross, and label-review prompts match §9.3.
- [x] Contrast writer drops the old side triple and `motive_contrast` on new writes.
- [x] `evaluate_run_dir` scores label or resolution, not a motive code.
- [x] Old YAML still displays.
- [x] Score help in the Analyze cross-cluster page explains outcome purity, resolution distinctness, matched-parameter decisiveness, merge candidates, the two LLM ratings, and why composite is a different number. It does not cite file paths.
- [x] `6_cluster_s=0.6113` medoids match §9.1. Briefing rebuilt with `medoid_resolution`.
- [x] Re-run that folder’s pairs, summaries, label-review, and cross-eval (§9.4). Selection-eval and the briefing were rebuilt after the new labels.
- [x] No rank-2 timing compiler, no S2/S3 change, no intra-cluster member captions in this pass.

### 9.6 Leave alone

- S2 kNN and S3 CART. They do not read these YAML keys.
- Intra-cluster nearest-to-medoid captions (§5 item 5). The label stays a medoid caption until that product exists.
- Python `neighborhood_separation` compiled from pair verdicts (§5 item 3). Still an LLM field today.
- Rank 2. `brake_t` and `peak_t` stay in `conflict_metrics` for a later compiler.
- The JSON keys `primary_motives`, `motive_distinctness`, and `shared_motive`. The values are labels or resolutions. Renaming the keys would break saved reports.