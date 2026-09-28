# Medoid analysis method study

How we analyze one cluster medoid today, why `resolution` / `control_response` / `motive` still collide, and what 2024–2025 top-venue LLM papers do instead.

Internal companions (not duplicated here):

- `[prompt_templates/medoid_trial_prompt.txt](prompt_templates/medoid_trial_prompt.txt)`
- `[prompt_templates/common_sense.txt](prompt_templates/common_sense.txt)`
- `[prompt_templates/TAXONOMY.md](prompt_templates/TAXONOMY.md)`
- `[docs/motive_schema_and_causal_locality.md](docs/motive_schema_and_causal_locality.md)`
- `[README.md](README.md)` §4.1

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
3. Fill `agent_interactions`: one row per agent Ego actually responded to (named conflict vehicle first).
4. Write `decision_timeline` as per-stamp \(Q_a\) (Labeller action + quotes) + \(Q_j\) (one why clause), then `motive_summary` as trial-level \(Q_j\) only (2–4 sentences, **no** closed codes).

Pipeline (not the LLM) attaches `trial_id`, `outcome`, `conflict_metrics`, and structured collision fields.

This is **single-trial explanation**, not cluster labeling. Cluster `label` is a later product (`summary`).

---



## 2. What was deleted — and what was not

The memory “`resolution` / `control_response` / `motive` already deleted” is **half right**.


| Layer                                                                                             | Status                                  | Notes                                                                                                                              |
| ------------------------------------------------------------------------------------------------- | --------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| **Top-level** `interaction_resolution`, `control_response`, `primary_motive`, `secondary_motives` | **Removed** from the medoid YAML schema | Prompt says do not author them; pipeline **strips** them if the model still emits them (`README.md` §4.1).                         |
| **Per-agent** `agent_interactions[].resolution` / `.control_response` / `.motive`                 | **Still required**                      | This is the current schema. See `medoid_trial_prompt.txt` YAML fence and `batch8/.../cluster1/output/medoid_trial.yaml` lines 1–9. |


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


| Field              | Supposed meaning                     | Closed set (abbrev.)                                                                |
| ------------------ | ------------------------------------ | ----------------------------------------------------------------------------------- |
| `resolution`       | Who goes first vs **that agent**     | `pass_first` / `yield` / `unresolved`                                               |
| `control_response` | Speed **manner** on that agent’s arc | `smooth`/`maintain` / `slowdown` / `proactive` / `late` / `stop` / `brake` / `none` |
| `motive`           | Named **pattern** on the same arc    | `assertive_gap_acceptance`, `late_reaction`, `early_brake`, `yield_to_vehicle`, …   |


In practice they encode the **same** paper archetypes twice or three times:

- Paper **late-yield** ≈ `resolution=yield` + `control_response=late` + `motive=late_reaction`.
- Paper **pass-first** ≈ `resolution=pass_first` + `smooth`/`maintain` + `assertive_gap_acceptance`/`maintain_through`.
- `late_reaction` is defined as both a **timing** modifier and a **row motive**; `common_sense` even says “timing modifier only — combine with resolution.”
- The pairing table (`proactive`↔`early_brake` only, `late`↔`late_reaction`/`brake_release`) is a symptom: if the axes were orthogonal, you would not need a Cartesian product ban list.

That is the issue to solve: **three correlated enums**, not “we forgot to delete YAML keys.”

---



## 4. Papers worth reading — LLM × driving trial / scenario analysis

Focus: **how they analyze a trial or scene with an LLM**, and **how they design prompts / output spaces**. Generation papers only if the prompt recipe is directly useful. Weak venues, workshops, and unreviewed preprints were removed (list at the end of this section).

**How to read the numbers (as of 2025 Scholar Metrics / 2024 JCR unless noted):**


| Index                   | What it is                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | Use it for                                                                 |
| ----------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------- |
| **JIF**                 | Clarivate Journal Impact Factor (citations in year *Y* to citable items from *Y−1* and *Y−2*). **Journals only** — conferences have no JIF.                                                                                                                                                                                                                                                                                                                                                                                                                                 | Compare RA-L vs T-ITS vs Access.                                           |
| **h5-index**            | Google Scholar: largest *h* such that *h* papers from the last 5 complete years have ≥ *h* citations each (2020–2024 snapshot, July 2025). **h5 core**: refers to the core papers included in the h5 calculation (in the example above, these are the four articles cited 80, 55, 42, and 40 times respectively). **h5 median**: refers to the median number of citations of all articles in the h5 core. For the four core articles mentioned above, the median is (55+42) ÷ 2 = 48.5 citations. This metric measures the "intensity" of popular articles in this journal. | Compare **conferences** (CVPR, ECCV, ICLR, CoRL, ASE).                     |
| **h-index** (SCImago)   | Lifetime: *h* articles with ≥ *h* citations.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | Journal career impact (T-ITS, RA-L, Access). Inflated by volume on Access. |
| **i10-index / g-index** | Google Scholar **author** metrics (i10 = papers with ≥10 cites; g = citation concentration). **Not published for venues.**                                                                                                                                                                                                                                                                                                                                                                                                                                                  | Do not use as a conference/journal rank.                                   |


A high Access h-index does **not** mean Access is prestigious: it publishes thousands of papers/year (JCR 2024 **JIF 3.6, Q2**). Prefer T-ITS / ECCV / CVPR / ICLR.

**Read in this order (~4 hours):** DriveLM → DriveVLM → **DriveGPT4** → DiLu → SoVAR → ChatScene. Reason2Drive only if you still have time (same factorization as DriveLM; skip).

Each card is from the **PDF**, not the abstract. **Helps us** = a change in this repo. If the method does not transfer, that is stated.

### 4.1 Scene / trial analysis



#### DriveLM — Graph visual QA for driving

- **Venue / year:** ECCV 2024 (**Oral**). GS **h5 = 262**.
- **Links:** [arXiv](https://arxiv.org/abs/2312.14150) · [CVF PDF](https://www.ecva.net/papers/eccv_2024/papers_ECCV/papers/02604.pdf) · [GitHub](https://github.com/OpenDriveLab/DriveLM/)

**What they actually do.** Two layers in the PDF; do not mix them.

*Related work they criticize (p.3, the quote).* Prior AD-VQA is either **scene-level**: one behavior sentence + one or two reasons (“The car is moving into the right lane because it is safe to do so,” BDD-X / [41,42]), or **single object-level**: a “what–which–where–how–why” chain about Ego’s response to **one** object (“stops because a pedestrian in a white shirt is crossing…”). DriveLM’s claim: **neither is a suitable proxy** for human P1–3, because a driver considers **several** objects and several steps.

*Their task.* **Graph VQA (GVQA):** P1 perception → P2 prediction → P3 planning as **linked QA nodes**, then **B** = discrete ego behavior `(Bspeed, Bsteer)` binned from the **future** trajectory, then **M** = waypoints. They **train** DriveLM-Agent on DriveLM-nuScenes (~4.8k frames) + CARLA so the same VLM answers the graph **and drives**. Example B answers are kinematic: “going straight, not moving” / “driving slowly” — **not** pass/yield/motive. Ablation: more graph context on B improves M.

So: describing car behavior **is** in the paper, but (1) the one-reason / what-why chain is **prior work they reject as the training task**, and (2) their own B is a **control interface**, not an interaction label.

**What we can use.** Our medoid job **is** that prior VQA family, and that is fine: we explain a **finished** trial; we do not need a driving proxy.

| DriveLM (p.3) | Already in this repo | Gap |
|---------------|----------------------|-----|
| Scene-level: behavior + 1–2 reasons | `motive_summary` + last `decision_timeline` lines | One paragraph is what they call **too thin** if many agents matter |
| Object-level: what / where / how / why vs one object | CoT “action + quoted geometry + conclude toward agent” | We already do this **per stamp** |
| Graph: **several** objects, edges between them | `agent_interactions` rows (CuttingIn, then Parking) | Rows exist; we still **triple-label the same arc** on each row |
| B = `(Bspeed, Bsteer)` | closest: `control_response` | Their B is binned **future motion**. Ours mixes speed manner with `late`/`proactive` and with `resolution`/`motive` |

Concrete steal remains **factor the questions**: P1 is already `context_medoid.md` (do not add a perception LLM). CoT + timeline ≈ P2/P3 over observed stamps. Closed YAML should be **one field per agent** (§6 A or B), not three synonyms. If a second agent is in the clip, it gets its **own** row — we already require that; DriveLM is the citation for why.

**What we must not copy.** DriveLM-Data, DriveLM-Agent, GVQA training, cameras, waypoint bins, GPT scoring. Wrapping BEV in their graph template while keeping `pass_first`+`late`+`late_reaction` changes nothing. Copying their **B** answers (“going straight, not moving”) would **drop** pass/yield, which is the paper-card we actually need. Copying scene-level “one or two supporting reasons” as the *only* output would be a step **backward** (that is `motive_summary` without enums).

**Verdict.** **The quote matches our *task family* (describe Ego behavior with reasons). It is not DriveLM’s method, and they say that family is too coarse for driving.** For us it is the right family. Transfer is still **schema**: one closed field per agent, several agents as several nodes — not a VQA product, not RAG, not “graph of cluster QA.” Their B does **not** replace `resolution`.

#### DriveVLM — Scene description + analysis + hierarchical plan

- **Venue / year:** CoRL 2024 (PMLR v270). GS **h5 = 107**.
- **Links:** [PMLR](https://proceedings.mlr.press/v270/tian25c.html) · [arXiv](https://arxiv.org/abs/2402.12289)

**What they actually do.** VLM CoT in three **stages**: (1) scene description — weather/time/road/lane + critical-object boxes; (2) scene analysis — per object only the attributes that apply (`Cs` static / `Cm` motion / `Cb` behavior), then influence on ego; (3) hierarchical planning — 17 **meta-actions** → decision sentence (action, subject, duration) → **waypoints**. **DriveVLM-Dual** then attaches a classical 3D detector + planner because “VLMs have limitations in spatial grounding.” Deployed on a production vehicle. SUP-AD is in-house.

**What we can use.** Two mappings that are **already true** in our pack:

1. Dual system = our split. Geometry is Python (`context_medoid.md`, `conflict_metrics`). The LLM must **quote** those numbers, not re-estimate TTC from BEV. DriveVLM is the citation for why that split exists; we already built it.
2. Hierarchical plan = **do not mix layers**. Meta-action (`slow down`) ≠ waypoint list. Our `control_response: late` is trying to be a meta-action **and** a timing adjective **and** a motive. If a speed field stays, restrict it to kinematics (`accel` / `hold` / `decel` / `stop`) with **no** `late`/`proactive` — or drop it (§6).

They **do not require all three object attributes**. Our pairing table (`proactive`↔`early_brake` only) is the opposite: it forces a Cartesian product.

**What we must not copy.** Onboard Dual, 17-way meta-actions, waypoint tokens, SUP-AD, “find critical objects from RGB.” The labeller already names the conflict vehicle. A second “scene description” LLM on BEV would duplicate `context_medoid.md` and hallucinate geometry DriveVLM say VLMs are bad at.

**Verdict.** **Helps as a citation for a split we already have.** Remaining work is to stop YAML from violating that split. It does **not** say add a VLM planner.

#### DriveGPT4 — Interpretable video QA + control

- **Venue / year:** IEEE **RA-L** 2024 (accepted July 2024). Xu, Zhang, Xie et al.
- **Venue metrics:** JCR 2024 **JIF 5.3** (Q1); GS **h5 = 132**; SCImago **h-index 129**. No conference h5 (journal).
- **Links:** [IEEE](https://ieeexplore.ieee.org/document/10629039) · [arXiv](https://arxiv.org/abs/2310.01412) · [project](https://tonyxuqaq.github.io/projects/DriveGPT4)

**What they actually do (PDF).** Train a multimodal LLM (LLaVA/Valley-style CLIP projector + LLaMA) on **BDD-X** (~20k clips, 8 frames each) so one model both **explains** and **drives**. BDD-X already stores **three separate labels** per clip: action **description**, action **justification**, and numeric **control** (speed + turning angle). They turn those into **three question sets**, never one blob:

- \(Q_a\): “What is the current action of this vehicle?” → “The car slows down to a stop.”
- \(Q_j\): “Why does this vehicle behave in this way?” → “since the light ahead became red.”
- \(Q_c\): “Predict the speed / turning angle in the next frame.” → `2.09` / `0.00`

Control is **tokenized as text** (RT-2): same de-tokenizer as language, then parsed. They also expand BDD-X with ChatGPT instruction QAs because the original description/justification strings are “fixed and rigid.” Mix-finetune = 56k driving QAs + 223k general LLaVA/Valley data (otherwise they hallucinate traffic lights). Metrics: CIDEr / BLEU-4 / ROUGE-L + ChatGPT score vs ADAPT. This is **onboard explanation + next-step control**, not a YAML cluster card.

**What we can use.** Orthogonal **questions**, not “allow better enum words.” DriveGPT4 \(Q_a\) is **free prose** (“slows down to a stop”) because they have no Labeller. We do. Do not copy their open \(Q_a\) onto pass/yield.

| Layer | Closed? | Why |
|-------|---------|-----|
| Stamp **what** (\(Q_a\)) | **Yes — Labeller verbs** (`ACCELERATE` / `DECELERATE` / `EMERGENCY_BRAKE` / `TURN_*`) | `action.yaml` already decided. LLM synonyms (`assertive_gap_acceptance`) are the overlap bug. |
| Trial **interaction** | **Yes — 3 values** `pass_first` \| `yield` \| `unresolved` | Geometry-checkable; heatmap compounds compile from this. “Better word if you have one” **re-opens** the motive codebook. |
| Stamp / trial **why** (\(Q_j\)) | **No — short open prose** | BDD-X: “for the red light.” One reason, not a growing taxonomy. Suggested phrases as *examples*, not a closed list the model must paste. |
| Numbers (\(Q_c\)) | Not the LLM | Quote context; do not re-predict speed. |

Do **not** tell the LLM “if there is a better word, use it” for `resolution`. That instruction is how `pass_first` became `assertive_gap_acceptance`. Open language belongs only in \(Q_j\).

Per **time section** (each `decision_timeline` stamp), ask two questions like DriveGPT4, not one blob:

- \(Q_a\): What is Ego doing *now*? → Labeller verb + quoted \(v\) / Δheading + who is where.
- \(Q_j\): Why *this* action toward *this* agent? → **one short clause**. No snake_case codes.

Trial-level `motive_summary` is **only** \(Q_j\) for the whole clip (2–4 sentences). It is not a recap of stamps and not a dump of closed codes. Cluster1’s current summary failed because the prompt required WHEN/WHAT+WHY/SITUATION/LINK **and** named every motive code.

That is the citation behind **§6 Option A**: machine label = the 3-way bit; why = prose; kinematics = Labeller.

**What we must not copy.** BDD-X training, next-step speed/steer prediction, CLIP video tokenizer, ChatGPT-scored captions. Their \(Q_a\) answers are scene-level VQA (DriveLM’s *criticized* family: “stopped for the red light”). Copying that as the *only* medoid output would drop pass/yield. Their control channel is **future actuator commands**, not `control_response: late`.

**Verdict.** **Helps the dual-channel schema (prose ⊥ one closed label ⊥ numbers-in-Python).** It does not give us a motive taxonomy and does not replace `resolution`. Closest paper to Option A. Not a reason to train on BDD-X.

#### DiLu — Knowledge-driven LLM driving

- **Venue / year:** ICLR 2024. GS **h5 = 362**.
- **Links:** [OpenReview](https://proceedings.iclr.cc/paper_files/paper/2024/file/93c936b9e492def9c00782cab79dbc6d-Paper-Conference.pdf) · [arXiv](https://arxiv.org/abs/2309.16292)

**What they actually do.** A **closed-loop driver agent**: observe → **recall** similar memories (vector search on situation keys) → LLM **reason** a decision → act → **reflect** (LLM rewrites unsafe decisions) → store. Memory = (situation key, reasoning/decision value). Claim: **40** stored experiences ≈ RL on 600k episodes. Without few-shot, “out-of-the-box LLMs fail.” This is **online control**, not offline trial explanation.

**What we can use.** **2–3 filled** `agent_interactions` **examples beat a 200-line pairing table.** Put one `pass_first` row and one `yield` row **without** a third synonym into `[medoid_trial_prompt.txt](prompt_templates/medoid_trial_prompt.txt)` (or a tiny `fewshot_agent_interactions.yaml`). That is their “initialization = driving school.”

**What we must not copy.** A Memory Module that retrieves **previous medoid YAMLs** into the next cluster (that copies labels; we want independent medoids). Reflection that “revises unsafe decisions” would overwrite measured kinematics. Highway-env control is a different product. S5 OddQA is also not DiLu: DiLu retrieves experiences **to drive**; chat reads one frozen briefing.

**Verdict.** **Helps few-shot. Does not help RAG, chat, or a second critic on the same trial.** Retrieval of old cards would make the overlap **worse**.

#### Reason2Drive (optional; skip if DriveLM + DriveGPT4 were read)

- **Venue / year:** ECCV 2024. GS **h5 = 262**.
- **Links:** [arXiv](https://arxiv.org/abs/2312.03661) · [GitHub](https://github.com/fudan-zvg/Reason2Drive)
- **One line:** 600k video–text pairs; typed chain perception → prediction → reasoning; evaluate each JSON slot, not BLEU on a paragraph. Same factorization as DriveLM. Cite only if you need a second ECCV example of **typed slots**. Do not train on it.

### 4.2 Extraction / generation (LLM fills a schema; tools do physics)



#### SoVAR — Accident reports → executable scenarios

- **Venue / year:** ASE 2024. GS **h5 = 57**. Guo, Zhou, Tian, Fang et al.
- **Links:** [ACM](https://doi.org/10.1145/3691620.3695061) · [arXiv](https://arxiv.org/abs/2409.08081) · [GitHub](https://github.com/meng2180/SoVAR)

**What they actually do.** Three steps (Fig. 2): (1) GPT-4 + **linguistic prompt patterns** extract a **flat schema** from NHTSA crash **prose**; (2) **Z3-style constraints** turn those labels into waypoints that also fit a **new** map (LGSVL San Francisco — Fig. 1: same left-turn semantics on a wider road); (3) replay: ego = Apollo ADS, NPCs follow solved paths; check 5 violation types. Accuracy they report: environment 85%, road 96%, dynamic-object 87%. Arrow is **prose → structure → synthetic trajectories**. Ours is the opposite.

**§3.1 Information extraction (the quote).** PEGASUS-style three layers (cite [7] / 6LM), Table 1:

| Layer | Attributes | Already in this repo? |
|-------|------------|------------------------|
| Environment | `Weather`, `Lighting` | Not varying in the logical cut-in. Not a medoid field. |
| Road | `CollisionLocation` (T-junction / intersection), `LaneNum`, `SpeedLimit` | Map / OpenSCENARIO. Known before the LLM. |
| Dynamic objects | `ParticipantsNumber`, `CrashType`, `DrivingDirections`, `RunningLanes`, `DrivingActions` | See below. |

**Dynamic objects, field by field:**

- `ParticipantsNumber` / `RunningLanes` / `DrivingDirections` — initial IC. Labeller `Agents:` + Payload params. Do not re-extract from BEV.
- `CrashType` ∈ {rear-end, frontal, front-to-side} — **same object** as our `collision_detail.impact_type` (`rear-end` / `side/lateral`). SoVAR’s LLM **reads it from NHTSA English**. We **compute** it from geometry (`cluster_aggregates.py`) and **overwrite** the LLM. Copying their CrashType prompt would be a regression (DriveVLM: VLMs are weak at metric geometry).
- `DrivingActions` — closed **maneuver** list (their [35]): regular = U-turn, stop, drive into roads, vehicle cross, turn left/right, follow lane, change lane; abnormal = off-road, retrograde; pedestrians = cross / walk. This is **Hartjen Layer 1–2**, not pass/yield, not `late_reaction`. Our `action.yaml` already emits `ACCELERATE` / `DECELERATE` / `EMERGENCY_BRAKE` / `STOPPED` / `TURN_*` / `LANE_CHANGE_*`. SoVAR needs the LLM to recover those verbs from crash text because they have no Labeller.

**The one prompt rule in §3.1.2 that is actually useful.** Table 2, Dynamic Object pattern: *if the car **intends** an action but a collision happens first, do not put the intended action in `DrivingActions`.* That is causal locality for \(Q_a\): stamp what = **executed** Labeller verb, not “was going to turn.” We already say “do not invent actions absent from context.” Keep that; do not import their 10-way DrivingActions as a new YAML key.

**§3.2 Trajectory planning (rest of the method).** Per-action constraints: initial/goal pose, where the maneuver happens, waypoint speeds, plus a collision area \(CA\) so participants arrive together. Solver adapts lane count/width (ConvertInfo). This is ChatScene/Trajectory-LLM’s **generation** problem. We already have esmini trajectories. Do not Z3-reconstruct the medoid.

**What we can use.** Unchanged, plus one citation:

1. **LLM fills labels; Python owns numbers / compounds** (solver after extract) → §6 Option A compiler / stripper. Not a reason to add linguistic patterns: we need a **closed JSON fence**, which we have.
2. **`DrivingActions` supports stamp \(Q_a\) as a small closed maneuver set** — but the set to use is **Labeller**, not SoVAR’s NHTSA list. Same decision as unify-plan / Hartjen.
3. **Intended ≠ executed** → \(Q_a\) must copy `action.yaml`, not “Ego was about to yield.”

**What we must not copy.** NHTSA prompts, extracting Weather/CrashType/DrivingActions from `context_medoid.md` (re-extracting given metrics), LGSVL/Apollo, Z3 trajectories, using `DrivingActions` as `motive`. Layer-by-layer prompts are DriveLM factoring again — we already split pack (Python) vs labels (LLM).

**Verdict.** **§3.1 does not help more than the compiler + Labeller \(Q_a\).** The quoted schema looks like a better YAML because it is closed and per-actor. Mapped onto this repo it is **fields we already store**, extracted from **the wrong source** (prose instead of `action.yaml` / impact geometry). It does **not** justify an LLM DrivingActions codebook and does **not** replace `resolution`.

#### ChatScene — Language → Scenic/CARLA

- **Venue / year:** CVPR 2024. GS **h5 = 450**.
- **Links:** [CVF](https://openaccess.thecvf.com/content/CVPR2024/html/Zhang_ChatScene_Knowledge-Enabled_Safety-Critical_Scenario_Generation_for_Autonomous_Vehicles_CVPR_2024_paper.html) · [arXiv](https://arxiv.org/abs/2405.14062)

**What they actually do.** **Generate safety-critical tests** for RL ego vehicles: instruction → LLM scenario text → **split** into sub-descriptions (adversarial **behavior**, road **geometry**, relative **spawn**) → **retrieve** Scenic snippets from a hand-built DB → assemble → CARLA. They tried “just prompt GPT to write Scenic” and got non-executable APIs; retrieval is the fix. Scenic then **samples** params so one script yields many scenes. +15% collision vs baselines; fine-tune ego → −9% collision. This is **test generation**, not analysis of a finished sample.

**What we can use.** **Split before closed labels**: behavior ⊥ geometry ⊥ spawn. In our language: who-yields ⊥ speed profile ⊥ OpenSCENARIO params. Params are already Python. The LLM should not restate them as motives. Pair prompt: one behavior bit per side, not geometry retold as `primary_motive`. Their failure mode (one-shot whole Scenic) is ours (one-shot whole YAML). Mitigation we already have: YAML fence + stripper. The honest analogue of their DB is DiLu few-shot rows, **not** FAISS over `medoid_trial.yaml`.

**What we must not copy.** Scenic DB, CARLA adversarial NPCs, Safebench, generating new cut-ins. We sample from Payload. Collision-rate lift is a **testing** metric, not cluster quality.

**Verdict.** **Helps one prompt rule (decompose axes). Does not help clustering, ODD, or a new generator.** If the goal is “more critical trials,” that is the **sampler / S2**, not ChatScene.

#### Trajectory-LLM — Language → behavior → trajectory (data generator)

- **Venue / year:** ICLR 2025. Yang, Guo, Lin et al. GS **h5 = 362**.
- **Links:** [OpenReview PDF](https://proceedings.iclr.cc/paper_files/paper/2025/file/6bbefb73c0ede70635823a18426b9208-Paper-Conference.pdf) · [GitHub](https://github.com/TJU-IDVLab/Traj-LLM)
- **Name clash:** **Not** Traj-LLM (arXiv 2405.04909), which is a **predictor** (Mamba + Laplace decoder). This ICLR paper is a **generator**.

**What they actually do.** Problem: real interactive trajectories (overtake / yield / bypass) are expensive, so generate them from **short text**. Direct text→waypoints produces unsafe speeds and map-locked habits (narrow-road left-only bypass). Fix: two-stage **interaction → behavior (+ logic) → trajectory**.

1. Text like “Car A overtakes Car B” + map polylines + partial init traj → per-vehicle behavior with a reason (“Change Lane: ~5 m width on the left…”).
2. Behavior + map → waypoint tuples `(x, y, speed, yaw)`.

L2T dataset: **240k** scenarios, six topologies (straight, bend, roundabout, X/T/Y). Behaviors used: keep still / cruise / change lane / stop. Downstream: dump synthetic trajs to train Waymo / Argoverse **predictors**. Random locality attention + jitter for diversity. Inverse of Scenic drag-and-drop / code: language interface.

**Why this is the ChatScene family, not medoid analysis.** Direction of arrows:

```text
ChatScene / Trajectory-LLM:  text  →  (behavior)  →  trajectories  →  train a predictor / CARLA test
This repo:                   esmini trajectories already exist  →  labels (pass/yield, prose)
```

We do **not** lack trajectories. Payload/esmini already sampled the logical cut-in. Generating more cut-ins is the **sampler**, not `medoid_trial.yaml`.

**What we can use (thin).** The intermediate **behavior layer** (change lane / cruise / stop + one logic sentence) is Hartjen-style kinematics + a why-clause. We already decided that in [`post_medoid_analysis_method_study.md`](post_medoid_analysis_method_study.md) §9: Labeller maps ACCELERATE/DECELERATE; prose explains. Their “logic” string is `motive_summary`, not a third enum. ChatScene already gave “split before labels.” This paper is a higher-venue repeat of that split, **in the opposite direction**.

**What we must not copy.** L2T, random-locality attention, training Waymo predictors, a language generator of OpenSCENARIO. Do not cite it as “LLM explains our medoid.”

**Verdict.** **Unused for this pipeline.** Top venue, wrong arrow. If someone wants synthetic interactive trajs later, this is the cite — that is a **new product**, not Option A.

### 4.3 Extra (requested; not on the 4-hour path)

#### LC-LLM — Predict future lane-change + explain the prediction

- **Venue / year:** *Communications in Transportation Research* **2025** (Elsevier / Tsinghua), not IEEE T-ITS / T-IV. Peng, Guo, Chen, Zhu, Chen.
- **Links:** [arXiv](https://arxiv.org/abs/2403.18344) · [DOI](https://doi.org/10.1016/j.commtr.2025.100170) · [PDF](https://www.sciopen.com/local/article_pdf/10.1016/j.commtr.2025.100170.pdf)

**What they actually do.** **Forecast** a *surrounding* vehicle on **highD** German highways: next 4 s, intention \(I \in \{\)keep, left LC, right LC\(\}\) and waypoints, plus CoT. Llama-2-13B-chat + **LoRA**, 144k train / 24k test, **8×A800, 11 h**. Prompts serialize map + 2 s history + 8-neighbor relative states. CoT is **not** free explanation: notable features and 8 “potential behaviors” are **programmatically labeled** from rules ( \(v_{lat}>1.5\) km/h, \(a>0.4\) m/s², truck ahead, “change left to overtake”, …), then the LLM is SFT’d to **repeat** those labels. At inference they add “please explain.” Metrics: F1 vs LSTM/Transformer, RMSE of future \((x,y)\).

**Why it looks relevant and is not.** Surface: CoT + closed behavior set + “explain the car.” Logic:

| They | We |
|------|-----|
| Predict **future** LC of another car (ADAS planning input) | **Explain a finished** esmini trial (Ego vs CuttingIn already happened) |
| Intention = keep / left / right | Need pass / yield vs a named agent |
| 8 highway reasons (fast lane, truck-to-right, irregular LC) | Cut-in conflict, not highD lane-id change |
| Fine-tune 13B on 144k labeled futures | Frozen prompted YAML on one medoid pack |
| CoT targets are **rule outputs** (supervised) | CoT must quote `context_medoid.md` (we already have the numbers) |

If we copied LC-LLM we would (a) train a predictor we do not deploy, (b) import a highway LC codebook that is **not** our paper heatmap, (c) pretend rule-echo is “interpretability.” Step 0 “notable features then conclude” is already in `medoid_trial_prompt.txt`; that shape was taken from this paper earlier ([`motive_schema_and_causal_locality.md`](docs/motive_schema_and_causal_locality.md) §3.3). **No further steal.** Do not LoRA. Do not add their 8 categories to `motive`.

**Verdict.** **Useless as a method for this repo.** Keep the one-line history: features-then-behavior is already in the prompt. Do not put LC-LLM on the 4-hour path and do not cite it for Option A (DriveGPT4 / DriveLM cover that).

**Honest transfer (this 4-hour path).** None of these papers is a cluster-analysis pipeline. Steal factorization / few-shot / a post-YAML check. Do not steal their products.


| Paper     | Helps this repo?                      | Concrete change                             | Do not do                                     |
| --------- | ------------------------------------- | ------------------------------------------- | --------------------------------------------- |
| DriveLM   | Schema; p.3 VQA quote = **our task family**, not their method | One closed field per agent; several agents = several nodes | GVQA training; B (speed/steer) as pass/yield |
| DriveVLM  | Citation for a split we already built | Stop YAML from mixing layers                | Dual VLM planner, RGB “critical objects”      |
| DriveGPT4 | Dual channel: what ⊥ why ⊥ numbers | LLM: one closed bit + prose; Python: kinematics | BDD-X training; predict next speed/steer |
| DiLu      | Few-shot                              | 2–3 filled YAML rows in the prompt          | Memory of old medoid YAMLs, reflection critic |
| SoVAR     | Post-YAML compiler + Labeller \(Q_a\) (not NHTSA extract) | Intended ≠ executed; solver compiles compounds | DrivingActions/CrashType LLM extract; Z3 new maps |
| ChatScene | Decompose axes                        | Who-yields ⊥ speed ⊥ params                 | Scenic DB, CARLA generator                    |
| Trajectory-LLM (ICLR 2025) | **No** — inverse generator | — | L2T / text→waypoints; not a medoid explainer |
| LC-LLM (CommTR 2025) | **No** — future LC predictor | Already used: Step 0 features-then-conclude | LoRA, highD 8-way LC codebook, treat rule-echo as explanation |




### Dropped (checked, not worth an evening)


| Paper                                 | Why dropped                                                                                    |
| ------------------------------------- | ---------------------------------------------------------------------------------------------- |
| DriveMLM (*Visual Intelligence* 2025) | New CSIG journal, not CVPR/ICLR. Orthogonal speed×path idea is already in DriveLM / DriveGPT4. |
| Yang et al. yield bit (arXiv 2025)    | Unreviewed. “One bit + prose” is already Option A below.                                       |
| SAFE (arXiv 2025)                     | Unreviewed. Validator idea is already in SoVAR.                                                |
| Text2Scenario (arXiv 2025)            | Unreviewed. Role+CoT we already have; few-shot is DiLu.                                        |
| Talk2Traffic (CVPR 2025 **workshop**) | Workshop ≠ main track. Scenic generation.                                                      |
| OmniTester (*Automotive Innovation*)  | China SAE journal, not T-ITS. Generation loop.                                                 |
| Two 2025 arXiv surveys                | Unreviewed maps. The cards above already cover the prompt patterns.                     |


---



## 5. Prompt-design patterns that recur (and what they imply for us)


| Pattern                                                 | Who uses it                                            | Apply here                                                                                                                           |
| ------------------------------------------------------- | ------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------ |
| **Factor the task** (perception ≠ yield ≠ speed ≠ path) | DriveLM, DriveVLM, ChatScene                           | Keep `decision_timeline` as the chain. Do not triple-label the same arc.                                                             |
| **Closed, mutually exclusive states**                   | DriveGPT4 (prose ⊥ label), DriveLM (separate QA nodes) | One **resolution** bit; optional **timing** only if it is not already a motive name.                                                 |
| **Deterministic narrator + LLM classifier**             | DriveVLM, SoVAR, our `context_medoid.md`               | LLM must quote context, not invent TTC. Already in our prompt — keep.                                                                |
| **Structured thinking / CoT then YAML**                 | Reason2Drive, our Step 0                               | Keep CoT; add a **consistency check** step before the fence.                                                                         |
| **Few-shot of the schema, not the whole codebook**      | DiLu                                                   | 2–3 filled `agent_interactions` examples beat the pairing table.                                                                     |
| **Self-validate**                                       | SoVAR (solver vs LLM)                                  | Pipeline already strips top-level keys; extend to overlap (e.g. drop `motive` if it is a rename of `resolution`+`control_response`). |
| **Executed action ≠ intended action**                   | SoVAR Table 2 (`DrivingActions`)                       | Stamp \(Q_a\) copies Labeller only; do not write “was going to yield.” |
| **Dual channel: JSON + prose**                          | DriveGPT4                                              | Prose = `description` / `motive_summary`. Machine = **one** closed field per agent.                                                  |


---



## 6. How to solve *our* overlap (design choice, not yet implemented)

**Do not** add a fourth enum. The papers do not pick a codebook for us; they pick **how many machine slots the LLM is allowed to fill**. Three slots that rename each other is the failure mode we already have.

### Option A — LLM writes only `resolution`; Python compiles the rest

Per agent (LLM):

```yaml
agent: CuttingIn
resolution: pass_first | yield | unresolved
```

Prose stays: `decision_timeline` + `motive_summary`. **Do not** add `timing` as a second LLM enum (that recreates `late` ≈ `late_reaction`). If the heatmap needs `Late Yield`, compile timing in Python from the timeline (brake/decelerate onset vs peak conflict / TTC already in `context_medoid.md`). `control_response` / row `motive` become compiler outputs or are **dropped from medoid YAML** and only appear as `cluster_summary.label`.

**Why papers support A**

| Paper | What they actually separate | Why that is A, not B/C |
|-------|-----------------------------|-------------------------|
| **DriveGPT4** | Three **questions**: \(Q_a\) what / \(Q_j\) why / \(Q_c\) numbers. Control is parsed numbers, not a synonym of “why.” | Closest match. Our \(Q_a\) = `resolution`. Our \(Q_j\) = prose (`motive_summary`). Our \(Q_c\) = Labeller metrics (already Python). They never train one head that emits `stop` + `late` + `red_light` as three enums. |
| **DriveLM** | One QA **node** per question; B is a single interface into M | One closed field per agent. Their B is speed/steer bins — **do not copy B as `resolution`**. Copy the *one-node* rule. Several agents = several nodes (we already have rows). |
| **SoVAR** | LLM fills a flat schema; a **solver** owns kinematics / compounds | Pairing table belongs **after** the fence, as a compiler: `yield` + late-brake stamp + collision → paper `Late Yield`. That is their “LLM does not invent kinematics.” |
| **ChatScene** | Split behavior ⊥ geometry ⊥ spawn **before** closed labels | Geometry/params already Python. The LLM should not restate them as `motive`. |
| **DriveVLM** | Dual: VLM language, classical stack for metric geometry | Already our pack. Option A **stops YAML from violating** that split. |
| **DiLu** | Few-shot of the **schema you chose**, not a 200-line pairing table | After A: two example rows (`pass_first`, `yield`) with **no** third synonym. |

Same direction as [`post_medoid_analysis_method_study.md`](post_medoid_analysis_method_study.md) §9: thin named-vehicle interaction, **no** paper cluster label and **no** motive codebook on the medoid card.

**Risk of A.** `resolution` still has a prompt gate (behind-bin / hold-speed shortcuts). Keep the gate, or the bit becomes as mushy as `motive`. Optional `timing` in the LLM YAML is the main way A fails — leave it to the compiler.

### Option B — LLM writes only closed `motive`; derive pass/yield in code

Drop `resolution` and `control_response` from YAML. LLM picks one of `late_reaction` / `assertive_gap_acceptance` / `early_brake` / … . Python maps that code → pass/yield using the `common_sense` pairing table.

**Why papers look like they support B — and why they do not, for us.**

- **TAXONOMY.md** originally wanted **one** closed set for comparability (paper G1). That is B’s *intent*.
- **Reason2Drive** (optional ECCV): one typed chain of slots, evaluate each slot. One chain ≠ “put the largest overlapping codebook in that slot.”
- **DriveLM p.3 scene-level VQA**: one behavior + one or two reasons. That is **prose**, not a 12-way motive enum. DriveLM **rejects** it as a driving proxy; it is also too thin for heatmap labels.

**Why B is the wrong single slot.** `motive` is the field that already hallucinates (`assertive_gap_acceptance`, `gap_acceptance_creep`) and **renames** `resolution`/`late`. Deriving pass/yield from it inverts the dependency: pass/yield is the geometrically checkable bit (behind-bin, brake vs continue); motive is the story. SoVAR’s solver should own the **story compound**, not have the LLM invent the compound and Python reverse-engineer geometry.

### Option C — Keep three fields; force them orthogonal

- `resolution` = geometry only (ahead vs behind), no “hold speed ⇒ pass_first.”
- `control_response` = kinematics only (`accel` / `hold` / `decel` / `stop`) — **no** `late`/`proactive`.
- `motive` = why, **forbidden** to repeat the other two (`late_reaction` dies).

**Why papers look like C.** DriveLM graph (different nodes), DriveVLM (analysis ⊥ meta-action ⊥ waypoints), DriveGPT4 (\(Q_a\) ⊥ \(Q_j\) ⊥ \(Q_c\)). Those systems **do** use several channels — but each channel is a **different type** (what / why / numbers), not three names for one paper card.

**Why C fails here.** We already tried three fields. The pairing table exists *because* they are not orthogonal. Making them orthogonal means rewriting the motive codebook (Hartjen-style kinematics on the timeline, Lefèvre interaction as `resolution`, paper names only at `cluster_summary`) — that is **A plus a Labeller-mapped timeline**, which is the unify plan, not “keep `agent_interactions` with three cleaned enums.” Paying three LLM slots for that is extra error surface. SoVAR: do not let the LLM fill what Python can compile.

### Recommendation: **Option A (strict)** — ranks, and what “timing” is

**Timing is not the timeline.** `decision_timeline[].timestamp` and `description` (cluster1 t=9.7 near-miss, t=10.8 “CuttingIn behind, Parking 20.2 m ahead”) stay. That text is \(Q_a\) + \(Q_j\): what happened at that clock, in prose.

**Timing** in the rank table means a **second closed enum** on the agent row, the one sketched then rejected under Option A:

```yaml
timing: early | on_time | late | n/a
```

That token is the same idea as today’s `control_response: late` and `motive: late_reaction` / `brake_release`. Cluster1 t=10.8 already shows the failure: the description states the facts (deceleration ended, CuttingIn behind), then the model adds `⇒ brake_release`. Asking for `timing: late` would add a third name for that same fact. If a heatmap still needs the word “late”, Python compares `brake_t` to `peak_t` in `context_medoid.md` (here brake 9.1 s, peak 9.7 s). The LLM does not pick the adjective.

**A strict** = LLM writes only `resolution` per agent, plus the timeline and a short \(Q_j\) summary. No `timing`, no `control_response`, no `motive` from the model.

| Rank | What the LLM writes | What Python / the next stage adds | Why this rank |
|------|---------------------|-----------------------------------|---------------|
| **1 — do this** | Per agent: `resolution` only. Per stamp: description (\(Q_a\) + one why). Trial: 2–4 sentence \(Q_j\). | Nothing on the medoid card. `cluster_summary.label` may still say `Late Yield` from the prose + pair outcome + collision rate. | One checkable bit (`pass_first` / `yield` / `unresolved`). “Late” is a **cluster name**, not a medoid enum. Adding `timing` or `motive` on the same row recreates `pass_first + late + late_reaction`. |
| **2** | Same as rank 1. Still **no** LLM `timing` field. | A compiler writes `timing` from numbers already in the pack (brake onset vs peak / TTC), then summary may read that bit. | Use only if a machine token `early`/`late` is required **before** the summary LLM, and you refuse to let the model choose it. If the rule cannot see “late” in `brake_t` vs `peak_t`, fix the rule. Do not ask the LLM. |
| **3** | Three YAML keys again, but rewritten so they do not rename each other: geometry `resolution`, kinematic `control_response` (`accel`/`hold`/`decel`/`stop` only), why-prose that is forbidden to say `late_reaction`. | Pairing table deleted. Paper compounds still compiled, not prompted. | Only if a thesis figure must show three columns. Today’s names (`late`, `late_reaction`) make this rank fail immediately. It is more prompt surface than rank 1 for the same heatmap. |
| **Do not** | LLM writes only `motive` (`late_reaction`, `assertive_gap_acceptance`, …). Pass/yield derived backwards. | Pairing table becomes the source of truth. | Puts the noisiest field in the only slot. Cluster1 already invented codes the geometry does not need. |

**Dependency on the post-medoid DAG** ([`post_medoid_analysis_method_study.md`](post_medoid_analysis_method_study.md) §1, §4.5). Rank 1 changes the **parent answer** those stages are allowed to see. It does not change their order.

| Stage | Reads from the medoid today | Under rank 1 | Must not do |
|-------|-----------------------------|--------------|-------------|
| Pair | Full YAML as backdrop, including `motive` | One line per side: agent + `resolution` + the short \(Q_j\). Pair evidence stays the two boundary trials. | Copy `late_reaction` onto a side. Re-ask who-yields as three enums. |
| Summary | `primary_motive`, timeline codes, pair `separation_call` | `resolution` + \(Q_j\) + each `separation_call`. **This** stage invents `Late Yield`. | Paste medoid snake_case into `label`. |
| Label-review | Labels + caption excerpt | Unchanged. Still no full YAML. | Pull `motive` back in to “fix” a name. |
| Cross-eval | Re-walks pairs | Labels + rollup + selection-eval (DriveLM: child sees the parent answer). | Re-score pass/yield from BEV. |

Until rank 1 is implemented, pair and summary prompts still request the retired triple, so they will keep disagreeing with a future medoid that only emits `resolution`. Change those prompts in the same pass as the medoid schema. Details: post-medoid §5.

Until A is implemented, `agent_interactions` will keep emitting `pass_first + late + late_reaction` — three names for one paper card. File-by-file edit order: §9.

---

## 7. One-paragraph status for collaborators

Medoid analysis is: BEV + metric context → CoT walk → YAML. Trial-level `interaction_resolution` / `control_response` / `primary_motive` **were deleted**; the same three ideas **remain** on each `agent_interactions` row (e.g. batch8 cluster1 CuttingIn = `pass_first` / `late` / `late_reaction`). The 4-hour papers are **not** cluster-analysis pipelines. What transfers: one closed field per agent (DriveLM), dual channel what ⊥ why ⊥ numbers (DriveGPT4 — closest to §6 **Option A**), geometry in Python (DriveVLM — already true), 2–3 few-shot rows (DiLu), post-YAML compiler (SoVAR), decompose axes (ChatScene). **Recommended next change: Option A strict** — LLM writes only `resolution` + prose; compile or drop `control_response`/`motive`. What does **not** transfer: Graph-VQA training, BDD-X control prediction, Dual VLM planner, memory of old YAMLs, NHTSA→Scenic generation. Whether that change meets the inverse-intent claim is the checklist in §8; cluster naming and the two boundaries are post-medoid §8.

---

## 8. Thesis-claim checklist — one trial (inverse intent)

The claim this card is scored against: a **sequence** of rule-based states over a time window, plus the scene, goes into the LLM; the model returns the **why**; it must not re-guess the physical verb. Cluster naming, ODD, and the collision frontier are scored in [`post_medoid_analysis_method_study.md`](post_medoid_analysis_method_study.md) §8. Evidence is batch8 k=6 cluster1 (`context_medoid.md`, `action.yaml`, `context_cluster.md`).

| # | Claim | Status | What is on disk |
|---|--------|--------|-----------------|
| 1 | One stamp (`DECELERATE` + lane-keep) is too thin. Feed a **window**. | **Have** | `context_medoid.md` is t=1.5 s → 20.93 s: Labeller intervals (accelerate, decelerate, turn) plus distance, azimuth, speed, TTC, BEV filename on each line. `action.yaml` stores the same intervals with `acceleration` (cluster1: −0.59 m/s² then −1.25 m/s²). |
| 2 | Environmental context sits beside that sequence (rain, cones, visibility). | **Missing for this sample** | Medoid header is map `hct_6`, agents Ego / CuttingIn / Parking, outcome `safe`. No weather, illumination, occlusion, or cone field exists in the trial table (`README.md` §6). Inventing “heavy rain, 20 m visibility” would be a hallucination. |
| 3 | Scenario **parameters** of this trial are in the medoid prompt. | **Missing at this stage** | The two sampled axes are `OncomingSpeed` and `OncomingStartDelay`. Cluster1’s **ranges** are in `context_cluster.md` (speed [2.11, 4.00], delay [4.26, 4.70]) and are read by **summary**, not by the medoid call. The medoid prompt does not receive this trial’s two numbers. |
| 4 | Physical verb comes from the rule system. LLM writes the why. | **Partial** | Prompt step 3 is \(Q_a\) (Labeller verb + quotes) + \(Q_j\) (one clause). The YAML fence still also requires `control_response` and `motive`. Cluster1’s on-disk card is the old run: `late` / `late_reaction` and a long `motive_summary`. That second enum is the model renaming a deceleration the Labeller already stated. |
| 5 | A why with no supporting agent is allowed (`Unknown` / ghost brake). | **Missing** | `motive: null` is only for resume-driving with nobody ahead. A decelerate is pushed onto a named agent. There is no `anomalous` label and no rule `a < −4 m/s²`. Cluster1’s brakes are −0.59 and −1.25 m/s², so that example does not occur here anyway. |
| 6 | We can **prove** the explanation is right. | **Missing** | No human label, no faithfulness score on \(Q_j\). A fluent why is not a solved black box. |

**What rank 1 changes on this card.** Rows 1–3 stay. Row 4 becomes **have** only when the model emits `resolution` + \(Q_j\) and stops emitting `late` / `late_reaction`. Rows 5–6 stay missing: rank 1 explains a trial; it does not grade the explanation or detect ghost braking.

**Do not add** a rain/cone paragraph, a per-stamp `Safe|Dangerous|Critical` label, or an LLM copy of `acceleration`. TTC, min distance, and `acceleration` are already numbers. The medoid’s job is the why for the Labeller verb it was given.

---

## 9. Option A rank 1 — implement plan

This pass is **rank 1 only** (§6). The LLM writes `resolution` plus prose. Python does not add `timing`, `control_response`, or `motive`. Rank 2 (a `brake_t` vs `peak_t` compiler) and rank 3 (three rewritten keys) stay out. Do not re-run the historical batch in the same edit as the schema; old YAML must still load.

Target medoid card:

```yaml
agent_interactions:
  - agent: CuttingIn
    resolution: pass_first   # pass_first | yield | unresolved
decision_timeline:
  - timestamp: 10.8
    description: "<Q_a Labeller verb + quotes. Q_j one why. No snake_case.>"
motive_summary: |
  <2–4 sentences. No closed codes.>
```

`decision_timeline[].motive` goes away with the row `motive` key. The why stays inside `description`.

### 9.1 What still forces the triple

| File | What it does today | Adjustment for rank 1 |
|------|--------------------|------------------------|
| `prompt_templates/system_prompt.txt` lines 4–8 | “Factor interaction_resolution **before motive**” and “use the CLOSED motive codes.” | Keep the pass/yield gate. Delete the closed-motive sentence. One closed field is `resolution`. |
| `prompt_templates/medoid_trial_prompt.txt` | Task, CoT step, and the YAML fence require `resolution` → `control_response` → `motive` on each row and `motive` on each stamp. | Fence and task text: `agent` + `resolution` only. Drop the pairing-table sentence. Stamp line is `timestamp` + `description`. Keep the behind-bin / still-braking gate on `resolution`. |
| `prompt_templates/common_sense.txt` “Filling agent_interactions” and the `control_response`↔motive table | The model is told to repair `control_response` so it matches `motive`. | Remove that table from the text the model sees. Leave the resolution gate (who is ahead, overlap while still braking). A retired note in `TAXONOMY.md` is enough for humans. |
| `prompt_templates/TAXONOMY.md` §§3, 7–9 | Documents the triple and the pairing table as current. | Mark row `control_response` / `motive` retired. Do not add a new codebook. |
| `prompt_templates/parameter_space_pair_prompt.txt` | Each side is `interaction_resolution` + `control_response` + `primary_motive`. LLM also writes `motive_contrast`. | Each side: `resolution` + one evidence sentence. Delete `control_response`, `primary_motive`, and the pairing step. `motive_contrast` is not an LLM field (see Python below). |
| `prompt_templates/cluster_summary_prompt.txt` step 1 and the caption check | “Restate `primary_motive`.” | Restate named-vehicle `resolution`, outcome, and 1–2 sentences of `motive_summary`. `label` is the only place that may say `Late Yield`. |
| `prompt_templates/cross_cluster_prompt.txt` steps 1–2 | Group clusters by `primary_motive`. | Group by `cluster_summary.label` and the named-vehicle `resolution`. Do not re-walk BEV. |
| `python/llm_pipeline/split_analysis.py` `ensure_named_vehicle_agent_interaction` | Folds legacy top-level keys into a row, **copies** `resolution` / `control_response` / `motive` back to top-level, then **pops** the top-level keys. The row keeps `control_response` and `motive`. | After the legacy fold, delete `control_response` and `motive` on every row. Keep `resolution`. Do not derive `resolution` from a motive code (that is Option B). |
| `split_analysis.py` `_write_yaml_doc` | Salvaged raw wins for `primary_motive`, `control_response`, `interaction_resolution`, `motive_contrast`. A model that still emits them gets them written back. | Drop those four names from the “raw wins” list. Call `ensure_named_vehicle_agent_interaction` on the dict **after** the merge, so a fence that still contains the triple cannot survive the write. |
| `split_analysis.py` medoid / pair dry-run stubs (~735, ~1000, ~1060) | Stubs set `control_response: none` and `primary_motive: unclear`. Pair merge copies `llm_left.control_response` / `primary_motive`. | Stubs and the merge copy `resolution` only. |
| `python/llm_pipeline/cluster_selection_eval.py` `_primary_motive` | Distinctness reads `agent_interactions[].motive`, then legacy `primary_motive`. | Read named-vehicle `resolution`. If a `cluster_summary.yaml` `label` exists, distinctness uses the label (that is the paper card). Do not fall back to `motive`. |
| `cluster_selection_eval.py` `medoid_card_block` | Card text is `agent: resolution/control_response/motive` and stamp `motive@t`. | `agent: resolution` plus a trimmed `motive_summary`. Stamp line is `t` + description, no motive token. |
| `python/llm_pipeline/odd_briefing.py` | `medoid_motive` reads `primary_motive` (already popped, so it is usually empty). | `medoid_resolution` from the named-vehicle row, and `label` from the summary. Chat must not invent a motive the YAML no longer has. |
| `app/dashboard/.../analyze/utils.ts` `agentInteractionRows` | Back-fills a missing partner row from top-level `interaction_resolution` / `control_response` / `primary_motive`. | Back-fill `resolution` only. |
| `ResultCard.tsx`, `SplitCardsPanel.tsx` | Chips for `control_response` and `motive`. | Show `resolution`. Omit a chip when the key is absent. Do not render “—” as if the field were required. |
| `IcPairPanel.tsx` | Table row `primary_motive` from `contrast.left/right`. | Row label `resolution`. |
| `app/dashboard/src/app/api/cluster-run-report/route.ts` | `medoidMotive` reads `primary_motive`. | Named-vehicle `resolution`, else summary `label`. |
| `SelectionQualityPanel.tsx` copy | “Distinct primary_motive values…” | “Distinct resolution or summary label…” once the eval function changes. |

Readers that only display `motive_summary` (`cluster-analysis-status`, Replayer caption) stay. That field is the trial-level why.

### 9.2 Order

Do 1–4 before any LLM call. 5 is a re-run, not part of the schema edit.

1. **Medoid prompt surface** — `system_prompt.txt`, `medoid_trial_prompt.txt`, `common_sense.txt`, `TAXONOMY.md`. After this, a new medoid call cannot be asked for `late` or `late_reaction`.
2. **Writer** — `ensure_named_vehicle_agent_interaction` and `_write_yaml_doc`, plus the dry-run stubs. After this, a model that still emits the triple loses those keys on disk. Legacy files that already have the keys are unchanged until re-run.
3. **Pair and summary prompts, same pass** — `parameter_space_pair_prompt.txt`, `cluster_summary_prompt.txt`, `cross_cluster_prompt.txt`. A rank-1 medoid with today’s summary prompt still says “restate `primary_motive`.”
4. **Readers** — `cluster_selection_eval.py` (`_primary_motive`, `medoid_card_block`), `odd_briefing.py`, dashboard `utils.ts` / cards / pair panel / report route. Old YAML: show `resolution`, ignore `motive` for the distinctness score, still show `motive_summary`.
5. **Re-run one cluster, then its pairs.** Medoid on batch8 cluster1. Check `medoid_trial.yaml`: named row has `resolution` and no `control_response` / `motive`; timeline entries have no `motive` key; `motive_summary` has no snake_case. Then parameter-space pairs that touch cluster1, then that cluster’s summary. `label` may say `Late Yield`. `contrast.yaml` sides have `resolution` only.

### 9.3 Checklist

- [x] System prompt no longer says “closed motive codes.”
- [x] Medoid fence is `agent` + `resolution` + timeline description + `motive_summary`.
- [x] Pairing table is not in the model prompt.
- [x] Resolution gate (behind-bin, overlap while braking) is still in the medoid prompt.
- [x] Writer strips row `control_response` and `motive` after merge.
- [x] Pair prompt does not ask for `control_response`, `primary_motive`, or `motive_contrast`.
- [x] Summary prompt does not say `primary_motive`. `label` is the compound name.
- [x] Cross-eval groups by label / resolution, not by motive code.
- [x] Selection-eval distinctness uses `resolution` or summary `label`.
- [x] Dashboard still opens an old cluster1 YAML (triple present) without requiring those keys.
- [ ] New cluster1 YAML matches the target card above. (Step 5. Not this edit. On-disk batch8 cards are the previous run.)
- [x] No `timing` field, no rank-2 compiler, no S2/S3 change in this pass.

### 9.4 Leave alone

- `decision_timeline` timestamps and descriptions, BEV, `conflict_metrics`, `outcome`, `collision_detail` (pipeline-owned).
- Labeller `action.yaml` and `context_medoid.md`.
- On-disk batch8 YAML until step 5.
- Rank 2. `brake_t` / `peak_t` already sit in `conflict_metrics`. A later compiler can read them. This pass does not write `early|late`.
- S2 kNN and S3 CART. They do not read motive codes.
