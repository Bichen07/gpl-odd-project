# Closed motive codes + causal locality in medoid analysis

**Status:** implemented (prompt-level, Phase 0 + Phase 1). Applied 2026-08-08.
**Scope:** `medoid_trial.yaml` production only. No change to clustering, BEV packs,
`context.md`, `v_lat` thresholds, or the Explore/Analyze contracts.

---

## 1. What changed

| File | Change | Kind |
| ---- | ------ | ---- |
| `prompt_templates/common_sense.txt` | Free-text motive list → **closed 9-code table**; added **causal-locality** rule | prompt |
| `prompt_templates/medoid_trial_prompt.txt` | Added **Step 0 notable-feature extraction**; motive step must emit one closed code + its evidence; YAML gains `primary_motive`, `secondary_motives`, `motive_evidence`; task text generalised from "oncoming" to oncoming/cut-in/crossing | prompt |
| `prompt_templates/system_prompt.txt` | Closed-code + causal-locality instruction | prompt |
| `python/llm_pipeline/split_analysis.py` | New fields survive YAML salvage; dry-run stub gets `primary_motive: unclear` | 4 lines |
| `python/llm_pipeline/llm_factory.py` | `max_tokens` 8192 → 12288 (the longer CoT truncated one card before its closing fence) | 1 line |

Total: 84 insertions across 6 files, of which only 5 lines are Python. Old YAMLs stay
readable — the new keys are additive.

### The closed motive set

`yield_to_partner` · `early_brake` · `late_reaction` · `gap_acceptance_creep` ·
`assertive_gap_acceptance` · `maintain_through` · `post_clear_recovery` ·
`partner_driven_swerve` · `unclear`

Each code carries a gating condition in `common_sense.txt` (e.g. `late_reaction` =
first strong decelerate only near `peak_t` or `ttc_min` < 1.5 s), and every code used
must cite a metric (`peak_t` / `d_min` / `ttc_min` / `brake_t`) or a context/BEV stamp.

`assertive_gap_acceptance` was **not** in the original design. It was added after the
first live run: batch9 cluster1 (ego accelerates into a closing gap, `ttc_min` = 0.36 s)
had no legal code and correctly fell back to `unclear`. That is the enum doing its job —
an unnamed behavior became visible instead of being buried in prose.

### The causal-locality rule

> An ego action at time `t_a` may be explained only by evidence at `t ≤ t_a`, plus
> global ground truth (`peak_t`, `d_min`, `ttc_min`, outcome). Post-peak accelerate /
> same-lane turn ⇒ `post_clear_recovery` only; never the motive for a pre-peak brake.
> Stamps where the partner is still far (d ≳ 100 m) are scene setup, not motives.

---

## 2. Why — the three failure modes we were actually hitting

Evidence below is the **same medoid trial** (batch9 cluster0, `trial_9072`, ego yields
to `Opposite`, near-miss) before and after. The pre-change cards are kept at
`results/batch9/4_cluster_s=0.7482/_baseline_pre_motive_schema/batch9_c*_BEFORE.yaml`.

One caveat on this comparison: the batch9 conflict pack was rebuilt between the two runs
(snapshot count 11 → 27, so `brake_t` moved 10.1 → 4.9 s and `peak_t` 17.2 → 17.1 s). The
schema differences below are prompt-driven, but the metric values are not a pure A/B.

### (a) Invented events

Old card, `decision_timeline`:

```yaml
- timestamp: 9.3
  description: Ego initiates an early, anticipatory hard brake while Opposite is still distant.
```

There is no hard-brake stamp at t=9.3 s in `context.md`; the rule-based log has
`DECELERATE` onsets at 5.00 s and 9.50 s and no `EMERGENCY_BRAKE`. The old prompt asked
for motives without forcing a citation, so a plausible-sounding event was minted.

New card cites the deterministic value instead:

```yaml
- motive: early_brake
  at: 4.9
  evidence: brake_t=4.9s; Opposite d=209.2m at t=5.00s
```

### (b) Future leak / wrong attribution

Old card, again in the timeline:

```yaml
- timestamp: 17.4
  description: Opposite clears Ego's path, and Ego begins a slight, cautious re-acceleration.
```

Acceleration actually starts at t=20.40 s (`ego_start_ACCELERATE`). The old output
compressed a post-peak recovery into the conflict moment, which then reads as if the
recovery were part of the yield decision.

New card separates them and states the peak relation explicitly:

```yaml
- motive: post_clear_recovery
  at: 17.7
  evidence: Ego begins TURN_LEFT at t=17.70s, after peak_t=17.1s, Opposite is behind Ego
- motive: post_clear_recovery
  at: 20.4
  evidence: Ego begins ACCELERATE at t=20.40s, after peak_t=17.1s, Opposite is behind Ego
```

### (c) Motives that cannot be aggregated or checked

Old output stored behavior only as prose (`motive_summary`), so "aggressive gap
acceptance", "proactive yielding behavior" and "lack of yielding behavior" are three
different strings for two behaviors. You cannot count them, compare them across k, or
test them. New output has `primary_motive` + `motive_evidence`, which a 30-line script
can validate (see §5).

---

## 3. Paper support, with the sentences we relied on

### 3.1 Closed decision set + no free-form narrative — Alpamayo-R1 / Chain of Causation
NVIDIA research report, Oct 2025 · [arXiv:2511.00088](https://arxiv.org/abs/2511.00088) ·
[project page](https://research.nvidia.com/publication/2025-10_alpamayo-r1) ·
[autolabeler code](https://github.com/NVlabs/alpamayo-coc-autolabeler)

> **Abstract:** "(1) the Chain of Causation (CoC) dataset, built through a hybrid
> auto-labeling and human-in-the-loop pipeline producing **decision-grounded, causally
> linked reasoning traces aligned with driving behaviors**"

> **§1 Introduction:** "We argue that effective reasoning for autonomous driving must be
> causally grounded and structurally aligned with the task of driving. **Instead of
> generating verbose, unstructured narratives, reasoning traces should explicitly link
> observed scene evidence to concrete driving decisions through causal chains**"

> **§2.2 Related work:** "most existing approaches rely on **free-form reasoning that
> lacks explicit causal grounding**"

**What we took:** "concrete driving decisions" → our closed motive codes;
"link observed scene evidence" → the mandatory `motive_evidence` citation.
Our failure mode (c) is exactly the free-form reasoning they criticise.

### 3.2 Causal locality (history-only evidence) — same paper
> **§3 Building a Reasoning VLA Architecture:** "driving decisions must be grounded in
> causally structured reasoning … rather than free-form narratives; **the model must
> explain why a maneuver is safe and legal based on observable evidence in the history
> window.**"

**What we took:** the phrase *history window* is the whole rule. Our prompt version:
evidence for an action at `t_a` must satisfy `t ≤ t_a`. This is what kills failure mode
(b) — the t=17.4 s "re-acceleration" used to justify a brake that started 12 s earlier.

**Not taken:** their VLA architecture, Cosmos-Reason backbone, diffusion trajectory
decoder, SFT + RL stages. Those are future-development items, not needed for this change.

### 3.3 Notable features before behavior, programmatically labelled — LC-LLM
*Communications in Transportation Research* 2025 ·
[arXiv:2403.18344](https://arxiv.org/abs/2403.18344) ·
[doi:10.1016/j.commtr.2025.100170](https://doi.org/10.1016/j.commtr.2025.100170)

> **§III-B Prompting:** "The expected output includes predictions of lane change
> intentions and trajectory points …, as well as includes **thought reasoning which
> consists of notable features and potential behavior**."

> **§III-C Reasoning:** "Our CoT reasoning consists of **notable features and potential
> behaviors**."

> **§III-C1 Labeling of Notable feature:** "we labeled notable features include
> significant lateral movement when lateral velocity exceeds 1.5 km/h, and high
> longitudinal acceleration when it surpasses 0.4 m/s²."

> **§III-C2 Labeling of Potential behavior:** "**Potential behaviors are classified into
> eight categories** …"

> **§III-C:** "we also consider domain knowledge in driving, traffic rules, and
> traditional lane change model rules … for labeling CoT reasoning. In this way, our
> LC-LLM model can learn this knowledge and rules to **provide more reliable and accurate
> predictions and explanations**."

**What we took:** the two-stage CoT shape — *features first, behavior second* — became
Step 0 + step 3 of our workflow, and their "eight categories" is the precedent for a
closed behavior set rather than free labels. Their features are emitted by code; ours are
still extracted by the model from deterministic text (that is the Phase 1 / Phase 2 line,
§6).

> **§III-B:** the system message "maintains consistency across diverse driving scenarios.
> It delineates the designated role of the LLM … and outlines the information and format
> for the LLM's output."

This is why the enum and locality rule live in `system_prompt.txt` +
`common_sense.txt` (shared, stable) rather than being repeated per product.

**Not taken:** LoRA fine-tuning of Llama-2-13b, highway lane-change taxonomy, and their
numeric thresholds. We deliberately **did not** move our `v_lat` band from 0.3 to their
0.42 m/s equivalent in this change.

### 3.4 Staged reasoning: partner → ego action → behavior — DriveLM
ECCV 2024 **Oral** · [arXiv:2312.14150](https://arxiv.org/abs/2312.14150)

> **Abstract:** "While recent approaches adapt VLMs to driving via single-round visual
> question answering (VQA), **human drivers reason about decisions in multiple steps.
> Starting from the localization of key objects, humans estimate object interactions
> before taking actions.**"

> **Abstract:** "with our proposed task, Graph VQA, where we **model graph-structured
> reasoning through perception, prediction and planning question-answer pairs**, we obtain
> a suitable proxy task to mimic the human reasoning process"

**What we took:** the ordering discipline. Our Action → BEV → Motive chain already
matched it; the change makes the final stage a typed decision instead of a sentence, and
Step 0 plays the role of "localization of key objects" (which stamps matter at all).

**Not taken:** Graph-VQA datasets, DriveLM-Agent training, CARLA end-to-end evaluation.

### 3.5 Separating *what happened* from *why* — RAG-Driver
RSS 2024 · [arXiv:2402.10828](https://arxiv.org/abs/2402.10828) ·
[proceedings PDF](https://www.roboticsproceedings.org/rss20/p075.pdf)

> **§I:** "it outputs natural language texts corresponding to **(1) the driving action and
> (2) justification of that driving action** along with (3) numerical control signals"

> **§III:** "(1) **Action Explanation**, providing a human-understandable driving action
> description; (2) **Action Justification**, elucidating the rationale behind specific
> driving actions"

**What we took:** validation that `decision_timeline` (action) and
`motive_summary`/`motive_evidence` (justification) must stay separate fields. Failure
mode (b) was precisely a justification statement leaking into the action timeline.

> **§II-C:** "there are still several issues associated with their output, such as
> hallucination … **In-context Learning (ICL) has emerged as a promising approach in LLM
> inference, potentially addressing several of these issues.**"

**Deferred:** their retrieval-augmented ICL maps naturally onto our `parameter_space_pairs/` and
`trajectory_projection_pairs/` packs (feed a matched peer trial as a demonstration). Not in this change.

### 3.6 Keep kinematics in the evidence — Tracking Meets LMM
BMVC 2025 · [arXiv:2503.14498](https://arxiv.org/abs/2503.14498)

> **Abstract:** "many of these methods **underutilize 3D spatial and temporal elements,
> relying mainly on image data. As a result, their effectiveness in dynamic driving
> environments is limited.** We propose to integrate tracking information as an additional
> input to recover 3D spatial and temporal details that are not effectively captured in
> the images."

**What we took:** a reason **not** to change anything. Our `context.md` already carries
per-stamp distance, azimuth, TTC, `v_ego` and `v_lat`, so the prompt should keep leaning
on that text rather than on BEV appearance. This paper is cited as justification for the
existing design, not as a driver of new work.

### 3.7 Structure first, then prose; text-LLM as judge — CODA-LM
[arXiv:2404.10595](https://arxiv.org/abs/2404.10595) (arXiv record notes acceptance at
WACV 2025; the same benchmark underpins the ECCV 2024
[W-CODA](https://coda-dataset.github.io/w-coda2024/) workshop challenge)

> **Abstract:** "We adopt a **hierarchical data structure and prompt powerful LVLMs to
> analyze complex driving scenes and generate high-quality pre-annotations** …, while for
> LVLM evaluation, we show that **using the text-only large language models (LLMs) as
> judges reveals even better alignment with human preferences than the LVLM judges.**"

**What we took:** the "fill typed slots, then write prose" order (Step 0 → codes →
`motive_summary`), and the finding that a text-only judge is adequate for QA — which is
why the planned Phase 3 checker is a script/text judge over the YAML, not a vision model.

---

## 4. How this changes our analysis

| Analysis need | Before | After |
| ------------- | ------ | ----- |
| Single-trajectory explanation | Prose motive, uncited, could invent stamps | One typed decision + `at` + evidence per action |
| Auditability | Manual reading | Script checks enum membership, evidence presence, `at ≤ peak` semantics |
| Cluster cards | Motives not comparable | `primary_motive` countable per cluster |
| Cross-k comparison (3 vs 6 clusters) | Compare captions by eye | Compare motive distributions |
| Reliability / LLM variance | Invisible | Measurable — see §5.3 |

### 4.1 Cross-k comparison actually works now (batch8, paper Case Study 3)

The paper selects the six-cluster solution and names the patterns
(`_IEEE_ITS_2026_…` §IV-C): "smooth-pass (C1), cut-in-collision (C2), yield (C3),
braking-rear-end (C4), yield-stop-collision (C5), and pass-slowdown (C6)".

Our two builds, with `primary_motive` from the new schema:

| k=3 (`s=0.8032`) | n | collision | primary_motive |
|---|---|---|---|
| cluster0 | 904 | 1.99 % | `yield_to_partner` |
| cluster1 | 753 | 0 % | `yield_to_partner` |
| cluster2 | 1343 | 100 % | `assertive_gap_acceptance` |

| k=6 (`s=0.6113`, paper) | n | collision | primary_motive |
|---|---|---|---|
| cluster0 | 753 | 0 % | `assertive_gap_acceptance` |
| cluster1 | 886 | 0 % | `assertive_gap_acceptance` |
| cluster2 | 13 | 100 % | `assertive_gap_acceptance` |
| cluster3 | 55 | 100 % | `late_reaction` |
| cluster4 | 41 | 100 % | `assertive_gap_acceptance` |
| cluster5 | 1235 | 100 % | `gap_acceptance_creep` |

Reading: k=3 has the **higher silhouette** (0.8032 vs 0.6113) but collapses every
collision into one 1343-trial cluster with a single motive. k=6 splits that same
collision population (13 + 55 + 41 + 1235 = 1344) into distinct behaviors — a
`late_reaction` sub-mode (cluster3, brake at `brake_t`=8.4 s with `peak_t`=9.8 s, collides
at 13.72 s) and a `gap_acceptance_creep` mode (cluster5). This supports the paper's choice
of the six-cluster solution on **behavioral** grounds even though its silhouette is lower.
That argument is only available because the motive is a typed field.

Caveat: the `clusterN` indices in the `s=0.6113` pack above are **not** the paper's C1–C6. See
§4.2 — that candidate turns out to be structurally incompatible with Fig. 11, and a third pack
(`s=0.5947`) was built to match it.

### 4.2 Which k=6 candidate is actually the paper's

Selecting the highest-silhouette k=6 candidate (`clustering_index=3`, s=0.6113) was the wrong
call for reproducing Case Study 3. The paper's six patterns split three-and-three by outcome —
C1 smooth-pass, C3 yield and C6 pass-slowdown are collision-free; C2, C4 and C5 collide — but
index 3 gives 2 collision-free and 4 collision clusters. It merges the two collision-free passing
groups into one 886-trial cluster, so it cannot express the contrast the paper draws in Fig. 15
("Braking after passing occurs in braking-rear-end (C4) and pass-slowdown (C6), but not in
smooth-pass (C1)").

Six of the eight distinct k=6 candidates do have the 3-safe / 3-collision shape. The
highest-silhouette one among them is `clustering_index=48` (s=0.5947, `minClusterSize=10,
minSamples=7`), now built as `results/batch8/6_cluster_s=0.5947`. All eight candidates agree
closely (ARI 0.934–0.999 against index 3) and the 753-trial yield cluster is the identical trial
set in every one of them, so only the C1/C6 split is sensitive to this choice.

Mapping that pack onto the paper's labels, using the paper's own discriminators measured from the
esmini trajectories of every cluster member (100 % coverage):

| pack cluster | n | collision | passes cut-in | stops | post-pass braking | paper cluster |
|---|---|---|---|---|---|---|
| cluster4 | 751 | 0 % | 100 % | 0.1 % | 100 %, drop 2.69 m/s | C1 smooth-pass |
| cluster2 | 1237 | 100 % | 66 % | 0.2 % | 7 %, drop 0.41 m/s | C2 cut-in-collision |
| cluster0 | 753 | 0 % | 0.1 % | 55 % | — | C3 yield |
| cluster1 | 73 | 100 % | 100 % | 0 % | 100 %, drop 5.27 m/s | C4 braking-rear-end |
| cluster3 | 40 | 100 % | 0 % | 88 % | — | C5 yield-stop-collision |
| cluster5 | 90 | 0 % | 100 % | 1.1 % | 100 %, drop 4.49 m/s | C6 pass-slowdown |

Four of the six follow from categorical criteria: cluster0 is the only collision-free cluster that
does not pass, cluster3 the only one that stops *and* collides, cluster2 the only collision without
any stop or deceleration, cluster1 the only collision that passes first and then brakes. C1 vs C6
(cluster4 vs cluster5) is separated only by magnitude — retained speed after the pass and region
size — so that pair is "likely" rather than confirmed.

Reaching 100 % coverage required fixing the trial→CSV mapping: Payload appends `-N` to colliding
upload filenames, so 1764 of the 3869 trials could not be resolved by filename and the batch had
only 1258 usable CSVs. The materializer now allocates unique CSV indices and records them in a
sidecar map that `dataset_builder` prefers over filename parsing, bringing the batch to 3000 CSVs.
That fix is also what unblocked the nine Parameter-space pair packs in this run.

One important limit: this is a structural match, not a bit-exact reproduction. The saved analysis
zip reports `explainedVarianceRatio` of FPC0 53.7 % / FPC1 34.4 %, while the paper's Fig. 11 axes
read 58.8 % / 34.6 %. The FPC0/FPC1 ratio differs (1.563 vs 1.699), so the paper's figure came from
a different MFPCA fit, and HDBSCAN clusters those scores. Full derivation in
[`results/batch8/6_cluster_s=0.5947/PAPER_CASESTUDY3_MAPPING.md`](../../../results/batch8/6_cluster_s%3D0.5947/PAPER_CASESTUDY3_MAPPING.md).

### 4.3 The motive field now drives a selection verdict

`primary_motive` being typed is what makes a programmatic cluster-selection check possible:
repeated codes across clusters are a countable over-split signal. That check, its three
companions, and the hybrid LLM verdict built on top of it are described in
[`cluster_selection_evaluation.md`](cluster_selection_evaluation.md). Its headline result —
that the deterministic score prefers the paper-structure k=6 candidate (76.67) over the
higher-silhouette one (60.00) — is independent corroboration of §4.2.

### 4.4 Downstream

`primary_motive` is additive, so `cluster-analysis-status`, the Explore Replayer timeline,
and Analyze split cards keep working unchanged. Later they can display or group by it.

---

## 5. Evidence from the live runs

Four packs rebuilt and re-interpreted with the new prompts (gemini-2.5-flash, temp 0.1):

- `results/batch9/4_cluster_s=0.7482` (Case Study 2, oncoming) — 4 clusters
- `results/batch8/6_cluster_s=0.5947` (Case Study 3, cut-in, **paper-structure solution**, index 48) — 6 clusters
- `results/batch8/6_cluster_s=0.6113` (Case Study 3, highest-silhouette k=6, index 3 — see §4.2) — 6 clusters
- `results/batch8/3_cluster_s=0.8032` (Case Study 3 comparison) — 3 clusters

The audit numbers in §5.1–§5.4 below cover the first three-pack run (13 medoid cards); the
`s=0.5947` pack was added afterwards and its six cards passed the same checks.

### 5.1 Schema audit (13 medoid cards)

| Check | Result |
| ----- | ------ |
| Cards produced | 13 / 13 |
| `parse_failed` or truncated timeline | **0** |
| `primary_motive` + `secondary_motives` inside the closed set | **13 / 13** |
| Cards with non-empty `motive_evidence` | **13 / 13** |
| Post-peak evidence attached to a non-recovery code | **2 / 13** (see 5.2) |
| Completion tokens | max 7458, mean 5470 (cap 12288) |

Observed motive distribution: `assertive_gap_acceptance` 6, `yield_to_partner` 4,
`gap_acceptance_creep` 2, `late_reaction` 1.

### 5.2 The checker earns its keep

Two cards attach evidence slightly after `peak_t` to a non-recovery code:
`4_cluster/cluster2` (`gap_acceptance_creep` at 14.08 s vs `peak_t`=13.98 s) and
`3_cluster/cluster0` (`yield_to_partner` at 10.8 s vs `peak_t`=9.7 s). The first is 0.1 s
and benign; the second is a real 1.1 s post-peak attribution. Neither was detectable in
the old free-text format. This is the intended outcome: violations become findable.

### 5.3 A reliability measurement we could not make before

Trial `7300` is the medoid of **both** `3_cluster/cluster1` and `6_cluster/cluster0`
(identical `peak_t`=10.0, `brake_t`=7.8, `d_min`=4.51, `ttc_min`=1.93, 23 snapshots). Two
independent runs anchored on the **same three times** (7.5, 7.8, 11.0 s) but labelled them
differently:

| run | primary | secondary |
| --- | ------- | --------- |
| `3_cluster/cluster1` | `yield_to_partner` | `assertive_gap_acceptance`, `post_clear_recovery` |
| `6_cluster/cluster0` | `assertive_gap_acceptance` | `late_reaction`, `post_clear_recovery` |

The disagreement is narrow and legible: is braking at 7.8 s (TTC ≈ 2.18 s, `ttc_min` 1.93 s)
a `yield_to_partner` or a `late_reaction`, and which code is primary. Both are defensible
under the current gating conditions, which means the **gate wording is under-specified**,
not that the model is wrong. Under the old prose format this variance existed too but was
invisible. It is the strongest argument for Phase 2 (code-emitted features) and for
tightening the `late_reaction` threshold.

### 5.4 Regression found and fixed during the run

The added CoT pushed one response to exactly 8187 completion tokens against the old
8192 cap, truncating `batch8/6_cluster/cluster3` before its YAML fence
(`motive_summary: parse_failed`), and silently cutting a `decision_timeline` short in
`batch9/cluster1` (one entry with a timestamp and no description). Fixes: terse-CoT
instruction (≤15-word bullets, 3–5 motions) plus `max_tokens` 12288. After the fix, peak
usage is 7458 tokens and 13/13 cards are complete. Anyone porting this change to a model
with a tighter output budget must re-check this.

---

## 6. What was deliberately not done

| Deferred | Why |
| -------- | --- |
| `v_lat` 0.3 → 0.4 m/s (LC-LLM parity) | Explicitly skipped; would change `conflict_frame_selector.py` output and all existing `context.md` wording |
| Code-emitted `{notable_features}` block (Phase 2) | Wait until the prompt-only result is judged better; §5.3 is the trigger to do it |
| LLM-as-judge / rubric check (Phase 3) | The 30-line audit in §5.1 covers the current need |
| Retrieval ICL from `parameter_space_pairs` / `trajectory_projection_pairs` (RAG-Driver) | Larger change to prompt assembly |
| Any fine-tuning / VLA work (DriveLM-Agent, Alpamayo, CODA-VLM, LC-LLM LoRA) | Future development, unrelated to card quality |

---

## 7. Reproduce

```bash
conda activate analyzer
cd /path/to/gpl-odd-project
export PYTHONPATH="app/analyzer/src:app/llm_pipeline/python"
export GOOGLE_API_KEY=…

# batch8 needs esmini CSVs from the paper mirror (Case Study 3 maps to esmini_9_*)
python3 scripts/paper_casestudies/materialize_esmini_csv_from_trajectories.py \
  --analysis-zip data/paper_casestudies/case3/casestudy3.zip \
  --trajectories-zip data/paper_casestudies/case3/trajectories-249.zip \
  --ego-name ITRI

# Case Study 3 — paper-structure six-cluster solution (index 48; see §4.2)
python3 app/analyzer/src/dataset_builder.py --source payload-save --batch-id 8 \
  --clustering-index 48 --dataset dataset3 --ego-name ITRI \
  --analysis-zip data/paper_casestudies/case3/casestudy3.zip \
  --xodr results/map/hct_6_no_930.xodr --param-boundaries all --emb-boundaries all

# Case Study 3 — highest-silhouette six-cluster candidate (index 3; skeleton already exported)
python3 app/analyzer/src/dataset_builder.py --source payload-save --batch-id 8 --k 6 \
  --silhouette 0.6113 --dataset dataset3 --ego-name ITRI \
  --analysis-zip data/paper_casestudies/case3/casestudy3.zip \
  --from-run "results/batch8/6_cluster_s=0.6113" \
  --xodr results/map/hct_6_no_930.xodr --param-boundaries all --emb-boundaries all

# Case Study 3 — three-cluster comparison (created fresh; k=3 best silhouette 0.8032)
python3 app/analyzer/src/dataset_builder.py --source payload-save --batch-id 8 --k 3 \
  --dataset dataset3 --ego-name ITRI \
  --analysis-zip data/paper_casestudies/case3/casestudy3.zip \
  --xodr results/map/hct_6_no_930.xodr --param-boundaries all --emb-boundaries all

# LLM cards with the new schema
for rd in "results/batch9/4_cluster_s=0.7482:9" \
          "results/batch8/6_cluster_s=0.5947:8" \
          "results/batch8/6_cluster_s=0.6113:8" \
          "results/batch8/3_cluster_s=0.8032:8"; do
  python3 -m llm_pipeline.cli cluster-interpret \
    --results-dir "${rd%:*}" --batch-id "${rd##*:}" --products medoid,summary
done
```

Known build warnings on batch8: several emb/IC boundary pairs are skipped with
`missing from index map` because those trial ids are absent from the Case Study 3
trial→esmini mapping (2105 of 3000 trials are mapped, and 847 of those lack raw
trajectories). Medoid packs are unaffected; k=3 therefore produced 0 pair packs, the index-3 k=6
pack produced 2 emb pairs + 1 Parameter-space pair, and the index-48 k=6 pack produced 6 emb pairs.

Those warnings were traced to the Payload `-N` filename collisions described in §4.2. After the
sidecar fix the batch has 3000 CSVs instead of 1258, and the index-48 pack gained all 9 eligible
Parameter-space pair packs (the other 6 candidate pairs are correctly skipped as `param_dist > τ=0.1`).

## 8. Rollback

`git checkout -- app/llm_pipeline/prompt_templates/` restores the previous prompts;
the two Python edits are backward compatible and can stay. Existing YAMLs are not
migrated either way.

---

## 9. Phase 1.1 — two more closed codes + tighter `unclear` (2026-08-13)

**Status:** implemented (prompt-level). **Scope:** `common_sense.txt` +
`medoid_trial_prompt.txt` only, same as Phase 0/1. Not yet re-run against live cards.

Reviewing the three `batch8/3_cluster_s=0.8032` medoid cards side by side showed
`unclear` doing two different jobs:

| card | stamp | what actually happened | tagged |
| --- | --- | --- | --- |
| `cluster2` (collision) | t=9.7 s | Ego ENDS its yield_to_partner decelerate, holds 5.56 m/s, while CuttingIn is still very close (d=4.1 m, ttc=2.32 s) — 1 s before impact | `unclear` |
| `cluster1` (near_miss) | t=12.3 s | after `post_clear_recovery` accelerate, Ego takes a light decelerate while CuttingIn is near-ahead but not re-closing (d=6.6 m) | `unclear` |
| `cluster0` (near_miss) | t=10.8 s | context log literally states "Ego ends deceleration; Ego begins decelerating" at the same stamp | `unclear` |

Only the third is genuine evidence ambiguity. The first two are the **same
recurring, well-understood pattern** each time (brake released too early / minor
post-peak follow adjustment) with no code to name it — exactly what Phase 0's
`assertive_gap_acceptance` addition already fixed once for a different gap (§1,
"that is the enum doing its job").

**Two codes added to `common_sense.txt`:**

- `unresolved_brake_release` — ego ends/eases an active evasive decelerate
  **before** `peak_t`/outcome while the partner is still near/very-close (d ≲ 8 m)
  or `ttc` ≲ 3 s. This is the direct precursor to a collision in cases like
  `cluster2` above — naming it instead of `unclear` makes "why did the collision
  happen" answerable from the typed field, not just the prose.
- `post_clear_adjustment` — light/moderate decelerate (or a second short
  accelerate) strictly after `peak_t` while trailing a partner that is NOT
  re-closing. Distinguishes ordinary follow-distance correction from
  `post_clear_recovery` (which specifically means resuming speed/heading) and
  from a new conflict.

A precedence list was added directly above `unclear` in the table: check
`unresolved_brake_release`, then `post_clear_adjustment`, then
`post_clear_recovery`, and only fall through to `unclear` when the evidence
itself is contradictory or missing (the `cluster0` t=10.8 s case). `unclear`'s
gating condition was reworded to say this explicitly, so it can't be used just
because an action "doesn't feel assertive or recovery."

**Secondary fix (same review): `motive_summary` verbosity.** All three cards
independently restate every `decision_timeline` row's numbers inside
`motive_summary`, because the old guide required WHEN/WHAT/SITUATION/WHY/LINK
*per paragraph* with no rule to merge same-motive runs (e.g. `cluster2`'s four
consecutive `assertive_gap_acceptance` entries became one bloated paragraph
re-quoting all four stamps). The near-miss outcome paragraphs were the opposite
problem — thin one-liners with no terminal numbers, because only the
collision-outcome path had a density requirement. `medoid_trial_prompt.txt`'s
`<Motive summary guide>` now defines **one phase (= a maximal same-motive run)
per paragraph**, citing only the phase's first/last anchor values, and requires
the outcome paragraph (collision OR near-miss) to always quote terminal
numbers. Net effect: fewer, denser paragraphs that read as a causal story
instead of a second copy of the timeline.

Not yet done: re-running `--products medoid` against `batch8/3_cluster_s=0.8032`
to confirm the three `unclear` stamps above resolve to the new codes and the
summaries shrink — deferred per explicit request, prompt-only change for now.
