# Pipeline Architecture Refactor Plan: Epistemic Hierarchy & LLM Robustness

> **Status: superseded as an execution plan.** This file is Gemini’s first-pass
> agreement with an external ChatGPT note. It did not inspect the live
> `split_analysis.py` / dashboard contracts. Several recommendations here are
> **wrong for this repo** (LLM-authored `evidence.deterministic_facts`; stripping
> closed motives; renaming `cluster_selection_eval.json`).
>
> Source of truth: [`../../../implementation_plan.md`](../../../implementation_plan.md)
> and the repo-grounded critique
> [`chatgpt_suggestion_critique.md`](chatgpt_suggestion_critique.md).

This document summarizes the critical analysis of the pipeline architecture suggestions and outlines the execution plan for implementing the "Epistemic Hierarchy" (separating deterministic evidence from LLM hypothesis).

## 1. Critical Analysis of Suggestions

I have reviewed the 20-point suggestion list against the current state of the `gpl-odd-project` (specifically the prompts and YAML schemas). Here is my critical verdict on the most important points:

### The Danger of Circular Reasoning (Mixing Evidence Types)
**Verdict: EXCELLENT CATCH.**
In your current `medoid_trial_prompt.txt` and `parameter_space_pair_prompt.txt`, the LLM generates a flat YAML structure. For example, `decision_timeline` interweaves timestamps (deterministic) with `motive` (LLM inference). If downstream systems or the Summary LLM read this flat file, they cannot distinguish between what actually happened and what the Medoid LLM *guessed* happened. This destroys the validity of any robustness claims.

### Redefining the Medoid Product
**Verdict: HIGHLY RECOMMENDED.**
Currently, the medoid prompt asks the LLM to deduce "why it slowed / sped up". We should restrict the Medoid LLM to describing *observable behavior* (e.g., "Ego decelerated") and place "yield" strictly under a `hypothesis` or `inferred_motive` block.

### Explicit "Evidence vs Hypothesis" in Parameter-Space Pairs
**Verdict: CRITICAL FOR RESEARCH VALUE.**
The pair contrast is the core of this research. The output must structurally isolate:
1. `observed_differences` (e.g., "C0 braked 1.2s earlier than C4")
2. `likely_mechanism` (e.g., "Earlier braking increased TTC by 0.5s")
3. `hypotheses` (e.g., "This earlier brake onset represents a fundamentally different gap acceptance threshold")

### The "LLM Audit" Layer
**Verdict: MANDATORY FOR A BENCHMARK PAPER.**
If you are evaluating LLM correctness, you must have a deterministic validator that audits the LLM's output against the ground truth before accepting it. For example, verifying that the LLM didn't hallucinate a collision when `context_medoid.md` clearly states `outcome: safe`.

### Selection-Eval Renaming
**Verdict: GOOD SEMANTICS.**
Renaming "clustering correctness" to "behavioral clustering quality" is scientifically more accurate. Silhouette scores measure geometric correctness; your pipeline measures behavioral usefulness.

---

## 2. Execution Plan

### Phase 1: Schema Redesign (The Epistemic Hierarchy)
We will rewrite the YAML definitions in all prompts to enforce a strict tree structure.

**Example Proposed Medoid Schema:**
```yaml
evidence:
  deterministic_facts:
    outcome: "collision"
    # (extracted directly from context, verified by audit layer)
  observed_behavior_timeline:
    - timestamp: 12.4
      action: "Ego brakes severely"
      context: "Partner is 10m ahead"

llm_interpretation:
  interaction_resolution: "yield"
  primary_motive: "late_reaction"
  confidence: "medium"

hypothesis:
  open_questions:
    - "Unclear if braking was intentional yield or panic response."
```

### Phase 2: Prompt Refactoring
- **Medoid Prompt:** Remove instructions to deduce unobservable intent. Focus entirely on accurately summarizing the timeline of physical actions, and placing motives strictly in the `llm_interpretation` block.
- **Pair Prompt:** Implement the `observed_differences` -> `behavioral_difference` -> `likely_mechanism` schema. Maintain the instruction that the pair LLM does *not* see the deterministic reasons for the outcome divergence (keeping the test blind).
- **Summary Prompt:** Add an instruction for the LLM to explicitly compare the Medoid's `llm_interpretation` against the `processed/context_cluster.md` statistics to flag heterogeneity (e.g., "Medoid is a safe pass, but the cluster has a 20% collision rate").

### Phase 3: The LLM Audit Layer (`llm_validator.py`)
We will build a new Python script that intercepts the YAML immediately after the LLM generates it.
It will perform checks such as:
1. **Schema Check:** Ensure `primary_motive` is in the allowed `common_sense.txt` vocabulary.
2. **Fact Verification:** Compare the `evidence.deterministic_facts.outcome` in the YAML against the actual `context_medoid.md`.
3. **Temporal Sanity:** Ensure timeline timestamps actually exist in the context window.

### Phase 4: Reframing Evaluation
Update `cluster_selection_eval.py` to output `behavioral_clustering_quality.json`. Add placeholder logic for `interpretation_stability` (to be used later when testing temperature variations).

## Conclusion
This refactor shifts the project from a "cool use of LLMs to label clusters" to a "rigorous, auditable framework for testing LLM behavioral reasoning in autonomous driving." We will proceed with these changes once the schemas are approved.
