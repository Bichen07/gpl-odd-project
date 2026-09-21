# Medoid analysis method study

How we analyze one cluster medoid today, why `resolution` / `control_response` / `motive` still collide, and what 2024–2025 top-venue LLM papers do instead.

Internal companions (not duplicated here):

- [`prompt_templates/medoid_trial_prompt.txt`](prompt_templates/medoid_trial_prompt.txt)
- [`prompt_templates/common_sense.txt`](prompt_templates/common_sense.txt)
- [`prompt_templates/TAXONOMY.md`](prompt_templates/TAXONOMY.md)
- [`docs/motive_schema_and_causal_locality.md`](docs/motive_schema_and_causal_locality.md)
- [`README.md`](README.md) §4.1

---

## 1. Our current medoid method

Pipeline: deterministic pack → one LLM call → YAML.

```text
clusterN/processed/context_medoid.md   (metric timeline, agents, peak_t)
clusterN/processed/snapshots/*.jpg     (Ego-centered BEV)
        │
        ▼
SystemMessage  ← system_prompt.txt
HumanMessage   ← common_sense.txt + medoid_trial_prompt.txt + context + BEV
        │
        ▼
clusterN/output/medoid_trial.yaml
```

**What the model is asked to do**

1. Extract 6–12 notable stamps from context/BEV (do not invent).
2. Walk Ego vs each agent chronologically (CoT). Each stamp: action + quoted geometry + one **closed** motive code toward a named agent.
3. Fill **`agent_interactions`**: one row per agent Ego actually responded to (named conflict vehicle first).
4. Write `decision_timeline`, `motive_summary` (phase paragraphs), optional `collision_detail.narrative`.

Pipeline (not the LLM) attaches `trial_id`, `outcome`, `conflict_metrics`, and structured collision fields.

This is **single-trial explanation**, not cluster labeling. Cluster `label` is a later product (`summary`).

---

## 2. What was deleted — and what was not

The memory “`resolution` / `control_response` / `motive` already deleted” is **half right**.

| Layer | Status | Notes |
|-------|--------|--------|
| **Top-level** `interaction_resolution`, `control_response`, `primary_motive`, `secondary_motives` | **Removed** from the medoid YAML schema | Prompt says do not author them; pipeline **strips** them if the model still emits them (`README.md` §4.1). |
| **Per-agent** `agent_interactions[].resolution` / `.control_response` / `.motive` | **Still required** | This is the current schema. See `medoid_trial_prompt.txt` YAML fence and `batch8/.../cluster1/output/medoid_trial.yaml` lines 1–9. |

Example still on disk:

```yaml
agent_interactions:
- agent: CuttingIn
  resolution: pass_first
  control_response: late
  motive: late_reaction
- agent: Parking
  resolution: yield
  control_response: slowdown
  motive: gap_acceptance_creep
```

So we did **not** drop the three concepts. We **moved** them from one trial-level triple to N per-agent triples, then added a pairing table so they “must agree.” Overlap is still in the prompt.

---

## 3. Why the three fields overlap

Intended factorization (`common_sense.txt` / `TAXONOMY.md`):

| Field | Supposed meaning | Closed set (abbrev.) |
|-------|------------------|----------------------|
| `resolution` | Who goes first vs **that agent** | `pass_first` / `yield` / `unresolved` |
| `control_response` | Speed **manner** on that agent’s arc | `smooth`/`maintain` / `slowdown` / `proactive` / `late` / `stop` / `brake` / `none` |
| `motive` | Named **pattern** on the same arc | `assertive_gap_acceptance`, `late_reaction`, `early_brake`, `yield_to_vehicle`, … |

In practice they encode the **same** paper archetypes twice or three times:

- Paper **late-yield** ≈ `resolution=yield` + `control_response=late` + `motive=late_reaction`.
- Paper **pass-first** ≈ `resolution=pass_first` + `smooth`/`maintain` + `assertive_gap_acceptance`/`maintain_through`.
- `late_reaction` is defined as both a **timing** modifier and a **row motive**; `common_sense` even says “timing modifier only — combine with resolution.”
- The pairing table (`proactive`↔`early_brake` only, `late`↔`late_reaction`/`brake_release`) is a symptom: if the axes were orthogonal, you would not need a Cartesian product ban list.

That is the issue to solve: **three correlated enums**, not “we forgot to delete YAML keys.”

---

## 4. Papers (clickable) — LLM × driving trial / scenario analysis

Focus: **how they analyze a trial or scene with an LLM**, and **how they design prompts / output spaces**. Generation-only papers are included only when their prompt design is directly useful. Prefer peer-reviewed 2024–2025 venues (CVPR, ECCV, CoRL, ICLR, ASE, RA-L) plus two surveys.

### 4.1 Scene / trial *analysis* and explanation

#### DriveLM — Graph visual QA for driving

- **Venue / year:** ECCV 2024 (Oral); also CVPR 2024 AD challenge track
- **Links:** [arXiv](https://arxiv.org/abs/2312.14150) · [CVF PDF](https://www.ecva.net/papers/eccv_2024/papers_ECCV/papers/02604.pdf) · [GitHub](https://github.com/OpenDriveLab/DriveLM/)
- **Key points:** Do not dump one free-form “why.” Factor reasoning as a **graph of QA**: perception → prediction → planning → discrete **behavior** → continuous **motion**. Object-level *and* task-level edges. Dataset on nuScenes + CARLA.
- **Prompt takeaway:** Split overlapping questions (what is there vs who yields vs how ego speeds) into **separate nodes**. Our three fields are trying to live in one node.

#### Reason2Drive — Chain-based reasoning benchmark

- **Venue / year:** ECCV 2024
- **Links:** [arXiv](https://arxiv.org/abs/2312.03661) · [Springer](https://link.springer.com/chapter/10.1007/978-3-031-73347-5_17) · [GitHub](https://github.com/fudan-zvg/Reason2Drive)
- **Key points:** 600k+ video–text pairs from nuScenes / Waymo / ONCE. Driving = sequential **perception → prediction → reasoning**. Object metadata → JSON → templates; GPT-4 + humans verify. BLEU/CIDEr are too ambiguous; they add an aggregated chain metric.
- **Prompt takeaway:** Force a **fixed chain** with typed JSON slots. Evaluate each slot, not the whole paragraph. Matches our CoT walk, but they do **not** emit three synonymous labels for the same slot.

#### DriveVLM — Scene description + analysis + hierarchical plan

- **Venue / year:** CoRL 2024 (PMLR 2025 proceedings)
- **Links:** [PMLR](https://proceedings.mlr.press/v270/tian25c.html) · [PDF](https://raw.githubusercontent.com/mlresearch/v270/main/assets/tian25c/tian25c.pdf) · [arXiv](https://arxiv.org/abs/2402.12289)
- **Key points:** Three **staged** modules: scene description, scene analysis (critical objects), hierarchical planning. Dual system (VLM + classical stack) because VLMs are weak at metric geometry.
- **Prompt takeaway:** Keep **geometry in a deterministic narrator** (we already have `context_medoid.md`). LLM should classify / explain, not re-estimate TTC. Analysis stage is separate from action stage — do not mix “who yielded” into the same enum as “how hard they braked.”

#### DriveGPT4 — Interpretable video QA + control

- **Venue / year:** IEEE RA-L 2024
- **Links:** [IEEE](https://ieeexplore.ieee.org/document/10629039) · [arXiv](https://arxiv.org/abs/2310.01412)
- **Key points:** Multi-frame video + text queries; answers **what the vehicle did and why**; also predicts controls. Instruction-tuned on BDD-X. Dual output: language explanation + control.
- **Prompt takeaway:** **Two channels** — human prose vs machine label. We already have `decision_timeline` (prose) vs enums. Enums must be **minimal and exclusive**; prose can carry timing nuance (`late` vs `proactive`) so it need not be a second enum.

#### DriveMLM — Align language to **disjoint** planner states

- **Venue / year:** Visual Intelligence / related MLLM planner line (2024–2025); conceptual source [arXiv:2312.09251](https://arxiv.org/abs/2312.09251) · [journal](https://doi.org/10.1007/s44267-025-00095-w)
- **Key points:** LLM linguistic decisions are mapped onto a **closed planner**: speed ∈ `{KEEP, ACCELERATE, DECELERATE, STOP}` and path ∈ `{FOLLOW, LEFT_CHANGE, …}`. **One speed and one path at a time**, mutually exclusive. System message binds phrases → states.
- **Prompt takeaway (directly on our overlap):** Put **orthogonal axes** in the system message (who-goes-first ⊥ speed-state). Never allow `late` and `late_reaction` as two names for the same axis.

#### Yang et al. — LLM predicts **driver yield** (binary)

- **Venue / year:** arXiv 2025 (preprint)
- **Links:** [HTML](https://arxiv.org/html/2509.19657v1) · [PDF](https://arxiv.org/pdf/2509.19657)
- **Key points:** Pedestrian / unsignalized intersection. Prompt = domain knowledge + **structured thinking guidance** + few-shot. Output is **yield vs not-yield** plus an explanation. They argue structured guidance beats unconstrained CoT for safety labels.
- **Prompt takeaway:** Collapse overlapping taxonomies to **one decision bit** (yield/not), then explain. Timing (early/late) belongs in the explanation or a **separate** optional field, not a third synonym.

#### DiLu — Knowledge-driven LLM driving

- **Venue / year:** ICLR 2024
- **Links:** [OpenReview PDF](https://proceedings.iclr.cc/paper_files/paper/2024/file/93c936b9e492def9c00782cab79dbc6d-Paper-Conference.pdf) · [arXiv](https://arxiv.org/abs/2309.16292)
- **Key points:** RAG-style **memory** of similar scenes + reasoning + reflection. Prompt is scene description + retrieved cases, not a huge overlapping codebook.
- **Prompt takeaway:** Prefer **few retrieved exemplars of the closed schema** over a 200-line pairing table. If two codes always co-occur, they should not both be in the codebook.

### 4.2 Crash-report / trial reconstruction (LLM extracts structure, solver does physics)

#### SoVAR — Accident reports → executable scenarios

- **Venue / year:** ASE 2024
- **Links:** [ACM](https://doi.org/10.1145/3691620.3695061) · [arXiv](https://arxiv.org/abs/2409.08081)
- **Key points:** Linguistic **prompt patterns** extract environment / road / actors from NHTSA text. **Constraint solver** builds trajectories (LLM does not invent kinematics). Replay on maps to test Apollo.
- **Prompt takeaway:** LLM fills a **flat extraction schema**; geometry is not a free-text motive. Our `context_medoid.md` already is that extraction — the LLM should not re-encode pass/yield **and** late **and** `late_reaction`.

#### SAFE — Multimodal crash → ADS tests

- **Venue / year:** arXiv 2025 (software-testing venue style; preprint)
- **Links:** [arXiv abs](https://arxiv.org/abs/2502.02025) · [HTML](https://arxiv.org/html/2502.02025)
- **Key points:** RAG + knowledge-grounded prompts + CoT + **self-validation** against a compact DSL (road / actors / environment). Hallucination is treated as the main failure mode.
- **Prompt takeaway:** After YAML emit, **validate** enums (we already strip illegal top-level keys). Extend the validator: reject rows where `resolution`/`control_response`/`motive` are logically duplicate rather than “agree.”

### 4.3 Scenario *generation* (prompt recipes we can steal)

#### ChatScene — Language → Scenic/CARLA

- **Venue / year:** CVPR 2024
- **Links:** [CVF HTML](https://openaccess.thecvf.com/content/CVPR2024/html/Zhang_ChatScene_Knowledge-Enabled_Safety-Critical_Scenario_Generation_for_Autonomous_Vehicles_CVPR_2024_paper.html) · [PDF](https://openaccess.thecvf.com/content/CVPR2024/papers/Zhang_ChatScene_Knowledge-Enabled_Safety-Critical_Scenario_Generation_for_Autonomous_Vehicles_CVPR_2024_paper.pdf) · [arXiv](https://arxiv.org/abs/2405.14062)
- **Key points:** Unstructured instruction → text scenario → **sub-descriptions** (behavior vs location) → retrieve DSL snippets. Retrieval reduces API hallucination.
- **Prompt takeaway:** Decompose the task **before** generation. Sub-description 1 = who yields; sub-description 2 = speed profile. Do not one-shot both into overlapping tags.

#### Text2Scenario — Hierarchical prompt stages

- **Venue / year:** arXiv 2025 (preprint)
- **Links:** [PDF](https://arxiv.org/pdf/2503.02911) · [project](https://caixxuan.github.io/Text2Scenario.GitHub.io/)
- **Key points:** Explicit stages: **Role setting, few-shot, CoT, syntax alignment check, self-consistency**. Hierarchical SOTIF-style repository; then compile to OpenSCENARIO.
- **Prompt takeaway:** Our medoid prompt already has role + CoT. We lack **syntax/self-consistency** over the three enums (sample twice, keep the row that does not contradict the timeline).

#### Talk2Traffic — Interactive multimodal scenario edit

- **Venue / year:** CVPR 2025 workshop (WDFM-AD)
- **Links:** [CVF PDF](https://openaccess.thecvf.com/content/CVPR2025W/WDFM-AD/papers/Sheng_Talk2Traffic_Interactive_and_Editable_Traffic_Scenario_Generation_for_Autonomous_Driving_CVPRW_2025_paper.pdf)
- **Key points:** MLLM interpreter → structured rep → RAG Scenic; human language edits. Hallucination called out as the default failure of “just prompt GPT-4o for Scenic.”
- **Prompt takeaway:** Structured intermediate representation **before** any closed labels.

#### OmniTester — Controllable MLLM testing

- **Venue / year:** Automotive Innovation 2025 (journal); preprint 2024
- **Links:** [arXiv](https://arxiv.org/abs/2409.06450) · [journal](https://doi.org/10.1007/s42154-025-00364-w)
- **Key points:** Prompt engineering + RAG + **self-improvement** loop; SUMO tools constrain generated code. Reconstructs crash-report scenes.
- **Prompt takeaway:** Self-improve = critic pass. We could add a cheap second prompt: “given timeline motives, delete redundant `agent_interactions` fields.”

### 4.4 Surveys (maps the field)

#### Foundation models: scenario generation **and** scenario analysis

- **Venue / year:** arXiv survey, 2025 (covers Oct 2022–May 2025)
- **Links:** [HTML](https://arxiv.org/html/2506.11526v4) · [abs](https://arxiv.org/abs/2506.11526)
- **Key points:** Analysis papers convert sensors → **text narrator** then CoT/RAG. Bottleneck: no large QA datasets for scenario analysis; prompts are handcrafted and token-heavy. Fine-tuning is proposed as a way off prompt sprawl — blocked by labeled data (exactly our closed-code problem).

#### Generative AI for ADS testing

- **Venue / year:** arXiv survey, 2025
- **Links:** [HTML](https://arxiv.org/html/2508.19882v1) · [abs](https://arxiv.org/abs/2508.19882)
- **Key points:** Venue histogram: CVPR, ICRA, IROS, NeurIPS, IV, ITSC, T-ITS. Table of **analysis** work uses ICL / CoT / RAG / contextual prompting. Text2Scenario’s five-stage prompt is cited as the recipe. Warns that LLM evaluation of scenes is still prompt-brittle.

---

## 5. Prompt-design patterns that recur (and what they imply for us)

| Pattern | Who uses it | Apply here |
|---------|-------------|------------|
| **Factor the task** (perception ≠ yield ≠ speed ≠ path) | DriveLM, DriveVLM, DriveMLM, ChatScene | Keep `decision_timeline` as the chain. Do not triple-label the same arc. |
| **Closed, mutually exclusive states** | DriveMLM (speed × path), Yang (yield bit) | One **resolution** bit; optional **timing** only if it is not already a motive name. |
| **Deterministic narrator + LLM classifier** | DriveVLM, SoVAR, SAFE, our `context_medoid.md` | LLM must quote context, not invent TTC. Already in our prompt — keep. |
| **Structured thinking / CoT then YAML** | Yang, Text2Scenario, our Step 0 | Keep CoT; add a **consistency check** step before the fence. |
| **Few-shot of the schema, not the whole codebook** | DiLu, Yang, Text2Scenario | 2–3 filled `agent_interactions` examples beat the pairing table. |
| **Self-validate / self-consistency** | SAFE, Text2Scenario, OmniTester | Pipeline already strips top-level keys; extend to overlap (e.g. drop `motive` if it is a rename of `resolution`+`control_response`). |
| **Dual channel: JSON + prose** | DriveGPT4, SemAlign-style planners | Prose = `description` / `motive_summary`. Machine = **one** closed field per agent. |

---

## 6. How to solve *our* overlap (design choice, not yet implemented)

**Do not** add a fourth enum. Pick one of:

### Option A — LLM writes only `resolution` (+ optional timing)

Per agent:

```yaml
agent: CuttingIn
resolution: pass_first | yield | unresolved
timing: early | on_time | late | n/a   # only when resolution=yield or a brake exists
```

Derive `control_response` / row `motive` in code from the **timeline’s** dominant stamp (already causal-local). Pairing table becomes a **compiler**, not a prompt.

Closest papers: Yang (binary yield + explanation), DriveMLM (disjoint states).

### Option B — LLM writes only closed `motive`; drop the other two from YAML

`pass_first`/`yield` become a **derived** class (we already have that table in `common_sense`). `late`/`proactive` become properties of `late_reaction`/`early_brake`. Matches “paper cluster names reconstruct from one code.”

Closest papers: Reason2Drive (one chain of typed steps), TAXONOMY.md original intent of a single closed set.

### Option C — Keep three fields but make them **orthogonal and non-renaming**

- `resolution` = geometry only (behind vs still ahead), **no** “hold speed ⇒ pass_first” shortcut.
- `control_response` = kinematic manner only (`accel` / `hold` / `decel` / `stop`), **no** `late`/`proactive`.
- `motive` = **why**, and **forbidden** to repeat either of the above (`late_reaction` dies or becomes a timeline-only event).

Closest papers: DriveLM graph (different nodes), DriveMLM (speed ⊥ path).

**Recommended:** **A or B**. C is theoretically clean but our paper labels (`late-yield`) *want* a compound; compiling the compound in code (A/B) is what SoVAR/SAFE do with solvers vs LLM.

Until one option is chosen, `agent_interactions` will keep emitting triples like `pass_first + late + late_reaction` — three names for one paper card.

---

## 7. One-paragraph status for collaborators

Medoid analysis is: BEV + metric context → CoT walk → YAML. Trial-level `interaction_resolution` / `control_response` / `primary_motive` **were deleted**; the same three ideas **remain** on each `agent_interactions` row, which is why overlap is still visible (e.g. batch8 cluster1 CuttingIn = `pass_first` / `late` / `late_reaction`). Recent ECCV/CVPR/CoRL/ASE LLM driving papers all **factor** perception, yield/order, and speed into separate questions or **one** closed decision plus prose — they do not stack synonymous enums. Next prompt change should drop two of the three names (or make them strictly orthogonal), and let the pipeline derive the paper-style compound label.
