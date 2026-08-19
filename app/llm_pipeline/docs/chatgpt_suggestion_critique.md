# Critique: ChatGPT architecture notes vs this repo

ChatGPT never saw `gpl-odd-project`. Gemini’s
[`architecture_refactor_plan.md`](architecture_refactor_plan.md) mostly agreed
with ChatGPT and did **not** check the live pipeline. This file is the
repo-grounded verdict.

Living execution plan: [`../../../implementation_plan.md`](../../../implementation_plan.md).

Legend: **keep** / **already done** / **adapt** / **reject** / **radar**.

---

## What ChatGPT got right (and Gemini under-specified)

The dangerous pattern is real:

```text
Medoid LLM motive  →  Pair LLM (sees medoid extracts)  →  Summary (sees both)
                   →  selection-eval.motive_distinctness
```

That is **LLM interpretation reused as if it were evidence**. It matters if the
thesis claims independent LLM judgments at each stage.

What ChatGPT did **not** notice (because it never opened the code):

| Claim | Reality in this repo |
| --- | --- |
| Pair is fed `pair_facts` / `left_block` / `right_block` | **Already withheld.** `split_analysis.py` only fills `pair_context` + medoid extracts + BEV. |
| Medoid product “interprets the cluster” | **Already a single trial.** Prompt: “ONE medoid trial … not the whole cluster.” Cluster stats go to **summary** via `context_cluster.md`. |
| Taxonomy is invented by the LLM | **Already closed** in `common_sense.txt` (resolution class + label building blocks). |
| Cross-eval should wait | **Already deferred.** |
| `selection_score` is branded as clustering correctness | **Docstring already says** “behavioral decomposition.” JSON key is still `selection_score`. |
| Pair decisiveness is an LLM score | **False.** `parameter_space_pair_decisiveness` uses `pair.json` `collided_a`/`collided_b` only. No `contrast.yaml`. |
| RoadId dual-store would be new | **Partial overwrite already exists** in `sim_labeller.py` (`resolve_road_lane` when Payload id is 0). Dual columns are **not** stored. |

Gemini’s “EXCELLENT CATCH” on circularity is fair. Gemini’s proposed **LLM-authored
`evidence.deterministic_facts`** is the opposite of a fix. If the model writes
`outcome: collision` and a validator “checks it,” you still treated the model as
the evidence author.

---

## Point-by-point

### 1. Four-stage structure — **keep**

Medoid / parameter-space pair / summary / selection-eval is already the product
order in `app/llm_pipeline/README.md`. Do not add products.

### 2. Self-reinforcing loop — **keep (this is the main risk)**

Confirmed leak path:

1. Pair prompt placeholders `{left_medoid_trial}` / `{right_medoid_trial}` from
   `medoid_card_block()` (`primary_motive`, timeline motives). Gate: both
   medoids must exist before pair LLM.
2. Prompt says extracts are a “final consistency check,” but they are in the
   **same** call as `separation_call`. The model can still copy YIELD vs PASS.
3. Summary `neighbor_cards_for_cluster()` then feeds `separation_call`, pair
   left/right `primary_motive`, **and** the neighbor medoid card again.
4. `cluster_selection_eval.py` `motive_distinctness` and `no_merge_candidates`
   read medoid `primary_motive`. That component is **not** an independent
   clustering metric; it is an LLM-agreement metric.

**Not** in the loop: pair outcome flips (deterministic), silhouette, collision
spread, `context.md` geometry block (`interaction_resolution` from
`conflict_frame_selector.py`).

**What to do:** schema provenance + stop feeding interpretation downstream
**as unlabeled text**. Optional later: two-pass pair (observed first, medoid
extracts second). Gemini recommended withholding “deterministic reasons for
outcome divergence”; those are already withheld. The leftover leak is
**medoid C → pair C**, not `pair_facts`.

### 3. Three provenances — **adapt (ChatGPT’s YAML is too thin)**

ChatGPT’s A/B/C split is the right idea. The sketch only has two YAML buckets
(`evidence` + `llm_interpretation`) and puts TTC/collision under a block the
model would emit.

Need **four writers**, not three labels:

| Provenance | Who writes | Examples in this repo |
| --- | --- | --- |
| A. Raw / GT | Payload, esmini CSV, XOSC params | collision flag, x/y/yaw, sampled speeds, `simulator roadId` |
| B. Derived deterministic | Analyzer / builder | `collision_rate`, `param_dist`, pair geometry block, `interaction_resolution` from FRONT→BEHIND, map-matched road when id=0 |
| C. LLM observation | LLM, audited vs A/B | “Ego decelerates severely at t=…” |
| D. LLM inference / hypothesis | LLM | `primary_motive`, `separation_call`, mechanism prose |

`context_medoid.md` is **B**, not A. Auditing the LLM against context.md audits
against derived text. That is still useful; it is not “ground truth.”

**Reject:** asking the LLM to copy A/B into `evidence.*`.
**Keep:** pipeline merge of A/B after parse; discard model `evidence`.

### 4. Redefine medoid — **adapt, do not strip motives**

ChatGPT: describe one trajectory; “possible motive: yield.”

Already one trajectory. Gemini said “HIGHLY RECOMMENDED” to stop asking why it
slowed. That fights `motive_schema_and_causal_locality.md`: closed codes exist
so we can count and audit. Removing motives collapses `motive_distinctness`
and summary `label`.

**Keep:** closed `primary_motive` under `llm_interpretation`.
**Adapt:** split timeline `description` (observed verbs) vs `motive` (code).
**Reject:** treating yield as mere hypothesis with no closed code.

Also: the medoid prompt still asks the model to emit `outcome` and
`collision_detail`. Pipeline already overwrites `collision_detail` / drops
hallucinated collisions. `outcome` in the prompt is redundant with GT inject —
remove from **prompt** when Phase 1 evidence merge lands.

### 5. Parameter-space pair as the research core — **keep**

Agree. Build the contract around making **this** experiment auditable, not
around more LLM products.

### 6. Don’t feed pair_facts / blocks — **already done**

Keep. Do not re-open. ChatGPT “would keep” medoid extracts; that **is** the
loop in §2. Decision: keep extracts for now (README rationale: near-identical
motion, outcome flip), but mark them `llm_interpretation` of **other trials**,
never as pair evidence. Two-pass is Phase 6, not day one.

### 7. Pair observed vs hypothesis fields — **adapt**

Good scientific distinction. ChatGPT’s example is sloppy:

- “Ego decelerates 2.1 s earlier” — if both brake times are in `process/context.md`,
  that delta is **B (derived)**, not an LLM observation.
- “Earlier braking creates additional clearance” — if min-distance is in the
  geometry block, also **B**.
- Only the **gap-acceptance threshold** claim is D.

If we add five free-text lists (`observed_differences`, `behavioral_difference`,
`likely_mechanism`, `hypotheses`, `uncertainties`) with no closed codes, we
cannot audit them and Explore still needs `contrast_timeline`.

**Adapt:** nest existing fields (`contrast_timeline` = C observed phases;
`separation_call` = D; `hypothesis` = D). Optionally add closed
`divergence_type` (see §18). Do not replace the current keys.

### 8. Closed cluster labels — **already done / keep**

### 9. Taxonomy defined outside the LLM — **already done; optional strengthen**

Vocabulary lives in `common_sense.txt`, not in the model weights. ChatGPT’s
modifier list (`First`, `Smooth`, `Creep`, …) is a **second** taxonomy. Do not
fork it; keep the existing table.

Stronger than ChatGPT: **compose `label` in Python** from
`interaction_resolution` + `control_response` + cluster collision-rate, and
let the LLM only pick the closed atoms. That removes one more C→label loop.
Radar, not blocking.

### 10. Rename selection-eval conceptually — **keep wording, reject key rename**

ChatGPT and Gemini are right that this is **behavioral usefulness**, not
silhouette correctness. `cluster_selection_eval.py` already says that.

**Reject:** renaming `cluster_selection_eval.json` or dropping
`selection_score` (Analyze chip + notebooks).
**Keep:** alias `behavioral_clustering_quality` = same number; paper text
uses the alias.

Caveat ChatGPT missed: **30% of the score (`motive_distinctness`) is LLM
output.** A paper must say so. After provenance, either:

- split the JSON into `deterministic_components` vs `llm_informed_components`, or
- drop motives from the default composite when claiming “no LLM.”

### 11. LLM interpretation stability — **radar**

ChatGPT mixed two files:

- `cluster_selection_eval.json` — purity, motives, pair flips, merge
- `clustering_quality.json` — silhouette, collision/TTC spread, param
  non-overlap, intra-consistency

Stability (medoid swap, prompt, model, temperature) is a real thesis question.
It needs N re-runs and a defined agreement metric (same closed code, not
embedding cosine on captions). Placeholder `null` only until budgeted.
**Do not** invent `evidence_consistency: 0.83` without a formula (ChatGPT §15).

### 12. Medoid ≠ cluster — **already partly handled / adapt summary field**

Medoid LLM correctly does **not** get `cluster_aggregate.json`. Summary
already gets `context_cluster.md` and a “medoid vs boundary” CoT step.

Gap: no required field “medoid story vs cluster collision_rate.” That is
implementation_plan Phase 4. Agree with ChatGPT here.

### 13. Summary questions 1–6 — **adapt**

1–3 and 6 are already the summary prompt (`caption`, heterogeneity via
neighbors, `neighborhood_separation`).
4–5 (deterministic vs hypothesis differences) are **new** and only work after
pair YAML marks provenance. Do that after Phase 2, not as extra LLM products.

### 14. Defer cross-eval — **already done / keep**

### 15. LLM audit layer — **adapt (mandatory, but not ChatGPT’s sketch)**

**Keep:** vocab, timestamps vs context stamps, collision claim vs GT.
**Reject:** refuse to write YAML; retry loops; NLP “unsupported_claims”
scanner; a unitless 0.83 score.
**Keep our design:** always write; `llm_meta.audit.status = pass|warn|fail`;
summary/selection skip `fail`.

Gemini’s “compare `evidence.deterministic_facts.outcome` in the YAML to
context” assumes the LLM filled evidence. Wrong. Compare **pipeline**
evidence to any leftover LLM `outcome` / collision prose.

### 16. RoadId dual-store — **radar, analyzer, not YAML schema**

ChatGPT is right that overwriting raw id=0 with a matched id is
indefensible in a paper. `sim_labeller.py` already does spatial fallback and
writes a **single** `road_id`. That is the bug to fix later:

```text
simulator_id / inferred_id / confidence / source
```

This does **not** fall out of an LLM epistemic hierarchy. Do not block pair
rigor on map-matching. Do not put OpenDRIVE matching inside the LLM.

### 17. “Redesign data flow” diagram — **reject as a rewrite**

We already have: Payload + analysis zip → `dataset_builder` → `$RUN` artifacts
→ LLM reads **context + BEV**, not raw XOSC/XODR. ChatGPT’s diagram implies
each LLM product reinterprets raw data. It does not. Tightening YAML
provenance is enough; do not rebuild the builder around this cartoon.

### 18. Four explanation types for pairs — **adapt as closed enum later**

Useful mapping onto **existing** `separation_call`:

| ChatGPT type | Closest existing | Needs |
| --- | --- | --- |
| 1 Genuine boundary | `justified` + outcome flip in pair.json | geometry block already in context |
| 2 Same motive, intensity | not named | new closed code, or `motive_contrast` |
| 3 Contextual / trajectory | not named | easy for the model to hallucinate |
| 4 Clustering artifact | `over_fine` | already allowed |

**Do not** add Type 3 until there is a deterministic handle (e.g. trajectory
vs parameter disagreement — which is `trajectory_projection_pairs`, no LLM
today). Adding a 4-way enum before provenance is more prompt surface, more
circularity.

### 19. ChatGPT / Gemini scorecard — **too green**

Repo-adjusted:

| Component | Verdict |
| --- | --- |
| Deterministic builder | Strong |
| Medoid LLM | Good; still emits GT-shaped fields; motives must stay closed |
| Parameter-space pair | Strongest research lever; **medoid-extract leak** |
| Summary | Good; needs medoid-vs-stats field |
| Closed vocabulary | Excellent, already shipped |
| Selection-eval | Good concept; **hybrid LLM+deterministic**; rename key = no |
| Cross-eval | Wait |
| Provenance in YAML | Missing (flat mix) |
| Self-reinforcement | Real; pair+summary+motive_distinctness |
| Evidence vs hypothesis | Needed; **not** LLM-filled evidence |
| Validator | Should add; Gemini’s check-the-copy design is wrong |
| Map-matching | Analyzer dual-store later |
| BEV | Useful |
| trajectory_projection_pairs | Packs exist; no LLM; keep radar |

### 20. Trajectory-projection pairs — **radar / keep**

Agree they can become as interesting as parameter-space pairs (param-similar
vs behavior-similar). Do **not** copy the parameter-space prompt. Different
question. No LLM product until the pair contract is stable.

### “Biggest recommendation” — **keep**

No new LLM products. Tighten:

```text
A/B deterministic  →  C observation  →  D inference  →  D hypothesis
```

Center the thesis on: **can the model explain outcome flips under matched
parameters without laundering its own medoid labels as evidence?**

---

## Gemini file: what to ignore

[`architecture_refactor_plan.md`](architecture_refactor_plan.md) is a
rubber-stamp of ChatGPT with an execution sketch that would:

- Put `outcome` inside LLM-emitted `evidence`
- Strip medoid motives into “hypothesis”
- Rename selection output files
- Treat pair as “blind” while the live prompt still injects medoid cards

Use **this critique + `implementation_plan.md`**, not Gemini’s phases, as the
source of truth.
