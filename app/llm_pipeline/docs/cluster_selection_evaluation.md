# Cluster-selection evaluation: is this clustering a good behavioral decomposition?

**Status:** implemented (deterministic half + LLM prompt + UI). Applied 2026-08-08.
**Scope:** new product `cross-eval`, new file `cluster_selection_eval.json`, Analyze page
restructured into three tabs. No change to clustering, MFPCA, packs, or the medoid /
summary / parameter-space-pairs prompts.

---

## 1. The question this answers

Everything upstream evaluates *trials*. `medoid_trial.yaml` explains one trajectory,
`contrast.yaml` explains one pair. Nothing evaluated **the clustering itself** except
silhouette, which is a geometric statistic on FPC scores and knows nothing about driving
behavior.

That gap is not hypothetical. In Case Study 3 the highest-silhouette k=6 candidate
(`s=0.6113`) merges the two collision-free passing groups into one 886-trial cluster, so it
cannot express the contrast the paper draws in Fig. 15 ("Braking after passing occurs in
braking-rear-end (C4) and pass-slowdown (C6), but not in smooth-pass (C1)"). The candidate
that does match the paper's structure has a **lower** silhouette (`s=0.5947`). Silhouette
ranked them backwards.

So the evaluation has to ask behavioral questions:

1. Is each cluster one behavior, or a bag of unrelated ones?
2. Do two clusters tell the same story (over-split)?
3. Does crossing a boundary actually change what happens (decision-relevant)?
4. Is any pair straightforwardly mergeable?

---

## 2. Design: hybrid, deterministic-first

```text
                     ┌──────────────────────────┐
cluster.json ───────►│ cluster_selection_eval.py│──► cluster_selection_eval.json
medoid_trial.yaml ──►│  (no LLM, no API key)    │     score + components + findings
pair.json ──────────►└──────────────────────────┘              │
                                                               │ {deterministic_checks}
medoid_trial.yaml ── {medoid_cards} ──┐                        │
contrast.yaml ────── {parameter_space_pair_cards} ─┴──► cross_cluster_prompt.txt
                                                     │
                                                     ▼
                                          cross_cluster_eval.json
                                    selection_verdict / recommended_action
```

Two deliberate properties:

- **Deterministic first, always.** `run_cross_cluster_eval` writes
  `cluster_selection_eval.json` *before* it builds the prompt, so the numbers exist even if
  the LLM call is never made, fails, or is skipped for cost. The UI shows them on their own.
- **The LLM never recomputes the numbers.** It receives them as `{deterministic_checks}`
  and is asked to reconcile them against the medoid and Parameter-space pair narratives, name the
  behavior of each cluster, and issue `selection_verdict` + `recommended_action`
  (`keep` / `merge` / `split` / `try_other_k`). Anything countable stays in Python.

This split is what makes the verdict auditable: if the LLM says "keep" while the
deterministic report lists a merge candidate, the disagreement is visible on the same panel.

---

## 3. The four deterministic components

All in `python/llm_pipeline/cluster_selection_eval.py`. Each returns a value in `[0,1]`, or
`None` when its inputs are missing; `selection_score` is the weighted mean over the
available ones, renormalized, ×100.

### 3.1 `outcome_purity` (weight 0.30)

Fraction of clusters whose collision rate sits at either extreme (`≤5%` or `≥95%`). Reads
`collision_rate` from `cluster.json`.

*Why:* a cluster that is 50/50 collision has no single caption — the medoid card is then
representative of at most half its members, which quietly invalidates every downstream
claim about that cluster. This is the same reason the paper's Case Study 3 patterns are
each purely one outcome.

*Threshold choice:* 5 pp of impurity tolerates a handful of edge trials (batch8 cluster0 at
1.99 % collisions) without accepting a genuine mixture.

### 3.2 `motive_distinctness` (weight 0.30)

`len(distinct primary_motive) / len(clusters with a usable primary_motive)`. Reads
`primary_motive` from each `medoid_trial.yaml`, ignoring `unclear`.

*Why:* this is the check that the closed motive set bought us. Before typed motives, two
clusters described as "aggressive gap acceptance" and "assertive gap acceptance" were two
strings; now they are one code, and repeated codes are a countable over-split signal.

*Known weakness:* it compares only **medoids**, one trial per cluster, and the motive field
carries LLM variance (documented in
[`motive_schema_and_causal_locality.md`](motive_schema_and_causal_locality.md) §5.3 — the
same trial was labelled `yield_to_partner` in one run and `assertive_gap_acceptance` in
another). Treat a low value as "look here", not as a verdict. It is weighted equally with
purity because over-splitting is the failure mode we are actually choosing between k for,
but it is the component most in need of Phase 2 (code-emitted features).

### 3.3 `parameter_space_pair_decisiveness` (weight 0.25)

Fraction of `parameter_space_match` pairs (z-scored IC `param_dist ≤ 0.1`) whose two trials have
different collision outcomes. Reads `pair.json`.

*Why:* this is the strongest evidence available, because it is a near-controlled
comparison. Two trials that started under near-identical initial conditions but landed in
different clusters *with different outcomes* prove the boundary tracks something causal
rather than sampling noise. If near-identical ICs never flip outcome across a boundary, the
boundary is separating trials that behave alike.

*Why 0.25 and not more:* the sample is small (1–9 pairs per run) and depends on how many
pairs survived the τ gate, so it is informative but noisy.

### 3.4 `no_merge_candidates` (weight 0.15)

Binary: 1.0 unless some cluster pair is simultaneously same `primary_motive`, collision
rates within 10 pp, and mean per-parameter range Jaccard overlap ≥ 0.8.

*Why:* the conjunction is deliberately strict — it fires only when a pair is
indistinguishable on *all three* axes, which makes it a concrete, actionable
recommendation ("merge cluster2 and cluster4") rather than a soft score. Low weight because
it rarely fires and is subsumed by the previous components when it does.

### 3.5 The renormalization caveat

`evaluated_components` records which components existed. A run with no Parameter-space pair packs scores
over three components, and its number is **not** comparable to a four-component run — the
report emits an explicit finding saying so. This matters immediately: batch8 k=3 scores
86.67 over three components while k=6 scores 76.67 over four, and that is not a ranking.

---

## 4. What it says about the packs we have

Run without any LLM call (`selection-eval`), on cards produced by earlier runs:

| pack | k | silhouette | score | purity | motive distinct | IC decisive | merge |
|---|---|---|---|---|---|---|---|
| `batch9/4_cluster_s=0.7482` | 4 | 0.7482 | **86.25** | 1.0 | 0.75 | 0.75 (3/4) | none |
| `batch8/3_cluster_s=0.8032` | 3 | 0.8032 | 86.67\* | 1.0 | 0.667 | n/a (0 pairs) | none |
| `batch8/6_cluster_s=0.5947` | 6 | 0.5947 | **76.67** | 1.0 | 0.5 | 0.667 (6/9) | none |
| `batch8/6_cluster_s=0.6113` | 6 | 0.6113 | **60.00** | 1.0 | 0.5 | 0.0 (0/1) | none |

\* three components only — not comparable to the k=6 rows.

The load-bearing result is the last two rows. The two k=6 candidates are the *same* data
and the same component set, so they are directly comparable:

- **Silhouette prefers `s=0.6113`** (0.6113 > 0.5947).
- **The deterministic selection score prefers `s=0.5947`** (76.67 > 60.00), driven entirely
  by `parameter_space_pair_decisiveness`: 6 of 9 near-identical-Parameter-space pairs flip outcome across a boundary,
  versus 0 of 1.

`s=0.5947` is the candidate that structurally matches the paper's Fig. 11 (3 collision-free
+ 3 collision clusters). The evaluator picks it for reasons independent of that mapping,
which is the first quantitative corroboration we have that the paper's choice of the
six-cluster solution is behaviorally motivated rather than geometric.

Both k=6 candidates repeat `assertive_gap_acceptance` across four clusters
(`motive_distinctness` 0.5). Read against §4.2 of the motive doc, that is partly real
over-splitting and partly the medoid-only weakness of §3.2: cluster1 (C4 braking-rear-end)
and cluster2 (C2 cut-in-collision) are behaviorally distinct in the trajectory statistics
(100 % post-pass braking, 5.27 m/s drop vs 7 %, 0.41 m/s) yet share a medoid motive code.
Tightening the motive gates is the fix, not discarding the check.

---

## 5. Where it surfaces

The Analyze page was split from *Analysis / Evaluation / Split cards* into three tabs that
match the three products, each with its own prompt viewer and its own run button, so a tab
only ever runs its own artifact:

| Tab | Product | Prompts shown | Reads |
|---|---|---|---|
| Medoid analysis | `medoid` | system, common_sense, medoid | per-cluster BEV + `medoid_trial.yaml` |
| Parameter-space pair analysis | `parameter-space-pairs` | system, common_sense, parameter_space_pair | `parameter_space_pairs/*/` facts, synced BEV, `contrast.yaml` |
| Cluster analysis | `summary,cross-eval` | system, common_sense, summary, cross_eval | both of the above + `cluster_selection_eval.json` + `cross_cluster_eval.json` |

The third tab shows the deterministic component bars and findings **next to** the LLM
verdict, plus the existing cross-config ranking table. Deterministic values appear as soon
as the packs are built; the LLM column stays empty until `cross-eval` is run.

---

## 6. Paper support

### 6.1 Behavioral patterns, not geometric ones — the project's own paper
`_IEEE_ITS_2026__Behavior_Centric_Visual_Analytics_…`, §IV-C:

> "The heatmaps (Fig. 11) reveal six trajectory patterns: smooth-pass (C1),
> cut-in-collision (C2), yield (C3), braking-rear-end (C4), yield-stop-collision (C5), and
> pass slowdown (C6), fulfilling G1."

> Fig. 15: "Braking after passing occurs in braking-rear-end (C4) and pass-slowdown (C6),
> but not in smooth-pass (C1)."

**What we took:** the acceptance criterion. A good k is one where every cluster is namable
as a distinct pattern and neighbouring patterns differ in a checkable behavior. That is
`motive_distinctness` (namable and distinct) plus `outcome_purity` (namable at all).
Notably each of the six named patterns is outcome-pure, which is where the ≤5 %/≥95 % gate
comes from.

### 6.2 Near-identical ICs as the unit of comparison — RAG-Driver
RSS 2024 · [arXiv:2402.10828](https://arxiv.org/abs/2402.10828) ·
[proceedings PDF](https://www.roboticsproceedings.org/rss20/p075.pdf)

> **§II-C:** "there are still several issues associated with their output, such as
> hallucination … **In-context Learning (ICL) has emerged as a promising approach in LLM
> inference, potentially addressing several of these issues.**"

**What we took:** the retrieval intuition, applied to evaluation rather than generation.
Their retrieved *similar* driving experience is our `param_dist ≤ τ` pair; instead of
feeding it as a demonstration, we use the matched pair as a quasi-experiment on the
boundary. `parameter_space_pair_decisiveness` is that idea made countable.

**Not taken:** their retrieval engine and ICL prompt assembly.

### 6.3 Decision-grounded, not narrative — Alpamayo-R1 / Chain of Causation
NVIDIA research report, Oct 2025 · [arXiv:2511.00088](https://arxiv.org/abs/2511.00088)

> **§1 Introduction:** "**Instead of generating verbose, unstructured narratives, reasoning
> traces should explicitly link observed scene evidence to concrete driving decisions
> through causal chains**"

**What we took:** the reason `cross_cluster_eval.json` emits typed
`recommended_action` ∈ {keep, merge, split, try_other_k} with a `recommended_action_detail`
naming the clusters, rather than a paragraph of advice. The same argument that made motives
a closed set makes the selection verdict an enum.

### 6.4 Text-only LLM as judge, over structure — CODA-LM
[arXiv:2404.10595](https://arxiv.org/abs/2404.10595)

> **Abstract:** "We adopt a **hierarchical data structure and prompt powerful LVLMs to
> analyze complex driving scenes** …, while for LVLM evaluation, we show that **using the
> text-only large language models (LLMs) as judges reveals even better alignment with human
> preferences than the LVLM judges.**"

**What we took:** two things. The hierarchy — trial cards, then pair cards, then a
selection verdict that consumes both — and the licence to make the top-level judge
**text-only**: `cross-eval` sends no images, only the digests of the lower levels plus the
deterministic report. That keeps it cheap enough to run per candidate k.

### 6.5 Multi-step reasoning over a fixed order — DriveLM
ECCV 2024 Oral · [arXiv:2312.14150](https://arxiv.org/abs/2312.14150)

> **Abstract:** "**human drivers reason about decisions in multiple steps. Starting from
> the localization of key objects, humans estimate object interactions before taking
> actions.**"

**What we took:** the staging discipline one level up. Medoid → Parameter-space pair → selection is the
same "don't skip to the conclusion" ordering applied to clusters instead of objects, and it
is why the cluster tab reads the other two products' outputs rather than re-deriving them
from raw packs.

---

## 7. Limits

| Limit | Consequence |
|---|---|
| `motive_distinctness` looks at one medoid per cluster | Behaviorally distinct clusters can share a medoid code (batch8 cluster1 vs cluster2, §4) |
| `parameter_space_pair_decisiveness` has 1–9 samples | Noisy; `s=0.6113`'s 0.0 rests on a single pair |
| Weights are hand-set | Chosen so purity + distinctness dominate; not fitted to labelled data |
| Scores renormalize across component sets | Only compare runs with identical `evaluated_components` |
| Deterministic checks need medoid cards for 3 of 4 components | Purity alone is available on a fresh pack |
| No agreement metric between the two halves | The panel shows both; nobody scores the disagreement yet |

Not attempted: replacing silhouette in the candidate enumeration (this runs *after* a
candidate is built, and is far too expensive to sweep), and any automatic re-clustering
from `recommended_action`.

---

## 8. Reproduce

```bash
conda activate analyzer
cd /path/to/gpl-odd-project
export PYTHONPATH="app/analyzer/src:app/llm_pipeline/python"

# deterministic half only — no API key, no tokens
for rd in results/batch9/4_cluster_s=0.7482 \
          results/batch8/6_cluster_s=0.5947 \
          results/batch8/6_cluster_s=0.6113 \
          results/batch8/3_cluster_s=0.8032; do
  python3 -m llm_pipeline.cli selection-eval --run-dir "$rd"
done

# add the LLM verdict (needs GOOGLE_API_KEY / OPENAI_API_KEY)
python3 -m llm_pipeline.cli cluster-interpret \
  --results-dir results/batch8/6_cluster_s=0.5947 --batch-id 8 \
  --products cross-eval
```

`selection-eval` is idempotent and overwrites `cluster_selection_eval.json`. The numbers in
§4 come from the first command; the LLM column of §5 is unrun as of this writing.
