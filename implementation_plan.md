# Master Implementation Plan (Living Document)

**Scope:** this file is the only living plan for future work. All planning stays
under `gpl-odd-project/`. Do not write or depend on plans in sibling folders.

**How this file is used:** the user will ask questions and describe future work.
Each time: scan the relevant code in this repo, think through failure modes, then
update this document. Implementation starts only when a phase below is explicitly
approved.

**Related notes (not living plans):**
- `app/llm_pipeline/README.md` — current products, gates, what the LLM sees
- `app/llm_pipeline/docs/chatgpt_suggestion_critique.md` — point-by-point verdict
  on the ChatGPT architecture note (repo-scanned; this plan follows that verdict)
- `app/llm_pipeline/docs/architecture_refactor_plan.md` — Gemini rubber-stamp of
  that note; **superseded**, do not execute its phases
- `app/llm_pipeline/docs/motive_schema_and_causal_locality.md` — why closed
  motives exist (keep; do not undo)

---

## 0. Operating rules

1. **One contract, many consumers.** YAML keys are read by CLI salvage, selection-eval,
   dashboard Analyze, Explore Replayer (`replayerCaption.ts`, EgoTimelineBox), and
   cluster-analysis-status APIs. A schema change that only updates prompts is a
   broken product.
2. **Deterministic facts are written by code, never by the model.** If the LLM is
   asked to copy `outcome` into `evidence.*`, that is still an LLM field with extra
   ceremony. Audit must **overwrite** evidence from on-disk GT, not “check the LLM
   copied it.”
3. **Additive first, then migrate.** Dual-read old + new keys. Stamp
   `schema_version`. Do not require re-running every historical `results/` folder
   to keep Explore/Analyze alive.
4. **Do not spend API budget to validate a plan.** Dry-run stubs and unit tests
   against checked-in YAML fixtures first; live LLM only after schema + readers
   agree.

---

## 1. Ground truth: what the repo actually does today

This section corrects v0 of this file (IC naming, “withhold pair_facts”, flat
motive-only medoid).

### Pipeline products (run order)

| Product | CLI | Output | LLM sees | LLM does not see |
| --- | --- | --- | --- | --- |
| Medoid | `--products medoid` | `clusterN/output/medoid_trial.yaml` | prompts + `processed/context_medoid.md` + BEV JPGs | cluster collision-rate header; `conflict_metrics` JSON pack |
| Parameter-space pairs | `--products parameter-space-pairs` | `parameter_space_pairs/cA-cB/output/contrast.yaml` | prompts + `process/context.md` + synced BEVs + compact **medoid YAML extracts** | `pair.json` / `pair_facts` / left-right `conflict_metrics` blocks (those are injected into **output** only) |
| Cluster summary | `--products summary` | `clusterN/output/cluster_summary.yaml` | medoid extract + `context_cluster.md` + touching contrast YAMLs | BEV |
| Selection-eval | `selection-eval` | `cluster_selection_eval.json` | none (deterministic) | — |
| Cross-eval | deferred | `cross_cluster_eval.json` | not in live product path | — |

Legacy folder names `ic_pairs/` / `boundary_pairs/` still resolve as **read**
fallbacks. New writes use `parameter_space_pairs/`. Trajectory-projection packs
exist on disk (`trajectory_projection_pairs/`) with **no LLM product**.

### Already-partial epistemic hygiene (do not re-invent)

- `collision_detail` is pipeline-injected; hallucinated salvage is dropped when
  the trial is not a collision (`split_analysis._write_yaml_doc`).
- Closed motive codes + causal locality are already in prompts
  (`common_sense.txt`, `medoid_trial_prompt.txt`).
- Summary already compares medoid vs parameter-space neighbors and already
  receives `context_cluster.md` (size / collision rate / param ranges).
- Pair LLM is already **not** fed `pair_facts`. It **is** fed medoid extracts on
  purpose (README: near-identical motion can still flip outcome; extracts are a
  consistency check, not boundary evidence).
- YAML salvage already has an allow-list of narrative fields. Nested keys will
  **silently drop** unless that list and dashboard readers are updated together.

### Hard couplings that will break if keys move

- Explore: `decision_timeline` / `contrast_timeline` / `motive_summary` /
  `contrast_explanation` (`replayerCaption.ts`, status API).
- Analyze: `AnalyzeClient.tsx` tables for medoid timeline, left/right
  `primary_motive`, contrast phases; chip `selection_score`.
- Selection-eval: `medoid_card_block()` reads `primary_motive` +
  `decision_timeline[].motive` (with leftover `motive_evidence` dual-read).
- `rebase_decision_timeline()` in `cluster_aggregates.py` assumes the old
  timeline shape.

---

## 2. Goal: epistemic hierarchy (kept, but tightened)

Prevent circular reasoning by making **who wrote each field** mechanical.

ChatGPT’s A/B/C split is the right idea but too thin (it omitted derived
analyzer facts, and sketched `evidence` as something the LLM would emit).
Use four provenances:

| Layer | Who writes it | Examples in this repo | Downstream use |
| --- | --- | --- | --- |
| A `evidence.raw` | Payload / esmini / XOSC | collision flag, trajectory x/y, simulator `roadId` | Always trusted |
| B `evidence.derived` | Analyzer / builder **only** | `collision_rate`, `param_dist`, pair geometry `interaction_resolution`, snapshot `peak_t`/`ttc`/`d` | Always trusted; **not** “LLM found” |
| C `observed_behavior` | LLM, audited against A/B + context stamps | lexicon verbs + times | Timeline UI |
| D `llm_interpretation` / `hypothesis` | LLM | closed motives, `separation_call`, mechanism prose | Aggregation **only if labeled as D** |

`context_medoid.md` / pair `process/context.md` are **B**, not A.

**Rejected (ChatGPT sketch + Gemini Phase 1):** putting `outcome` in an
LLM-emitted `evidence.deterministic_facts` block and “verifying the copy.”
Prompt YAML omits evidence; code merges A/B after parse; any model `evidence`
key is discarded.

**The actual self-reinforcement path (not `pair_facts`):** medoid D → pair
prompt extracts → pair `separation_call` → summary neighbor cards →
`selection-eval.motive_distinctness`. Pair outcome-flip scoring is
**not** in that loop (`pair.json` only).

---

## 3. Adversarial review (disadvantages we accept or design around)

### 3.1 Nested YAML without dual-read = silent Explore/Analyze outage

Dashboard and salvage look up **flat** keys. If prompts nest
`llm_interpretation.primary_motive` and readers still look at top-level
`primary_motive`, every existing run looks empty and every new run looks empty
in the UI.

**Mitigation:** accessors (`get_primary_motive(doc)`, `get_decision_timeline(doc)`)
used by Python **and** mirrored in TS. Write **both** nested canonical fields and
flat aliases for one schema generation, then deprecate aliases.

### 3.2 “Medoid must not infer intent” fights the paper product

Closed motives exist because free-text “proactive yielding” could not be counted
(`motive_schema_and_causal_locality.md`). Stripping motives from the medoid card
and leaving only physical verbs would:

- collapse selection-eval `motive_distinctness`
- collapse summary `label` building blocks (they map
  `interaction_resolution` / `primary_motive`)
- force the pair/summary models to re-infer the same intent with less structure

**Mitigation:** keep closed codes. Move them under `llm_interpretation`. Timeline
rows split `action` (observed) vs `motive` (interpretation). Do **not** delete
the motive vocabulary.

### 3.3 Pair “evidence vs hypothesis” can recreate circularity

v0 said: withhold deterministic conclusions so the pair LLM invents the
explanation. The repo already tried the opposite lesson: without authoritative
`process/context.md` numbers, the model **invents events and times**.

The real leak is not `pair_facts`. The leak is:

1. Pair prompt still receives **medoid extracts** (interpretation of *other*
   trials) before it writes `separation_call`.
2. Summary then reads that `separation_call` as if it were independent of those
   medoids.
3. Selection-eval then scores clusters using those motives.

**Mitigation (choose explicitly, do not do both blindly):**

- **A (current, cheaper):** keep one pass; document that `separation_call` is
  *medoid-informed*. Audit only numeric claims against pair context.
- **B (research-cleaner, 2× cost):** pass 1 = pair context + BEV only →
  `observed_differences`; pass 2 = freeze those fields and add medoid extracts →
  `separation_call`. Store both in one YAML. README already notes this as a
  possible variant.

Default in this plan: **implement B only after A’s schema + validator exist**,
because B doubles API spend and complicates gates (`readyForLlm`).

### 3.4 Validator false confidence

A schema/vocab/timestamp checker cannot prove the interpretation is *correct*.
It can only reject:

- illegal motive codes
- times outside the context window
- outcome / collision_detail that contradict GT
- `yield_to_partner` when context geometry says `pass_first` (if that geometry
  is already deterministic in context)

If we **reject** (no file written) on every vocab miss, dashboard “Run” looks
like a hang and operators re-fire expensive calls. If we **accept with
`llm_meta.audit`**, bad cards still poison summary.

**Mitigation:** write the YAML always; set `llm_meta.audit.status =
pass|warn|fail`. Summary / selection-eval **skip fail** cards the way they
already skip missing contrasts. UI shows a banner. Never block the HTTP handler
on a long retry loop.

### 3.5 Context.md is not ground truth

`context_medoid.md` / pair `process/context.md` are derived (stamps, sectors,
Δheading phrases). Auditing the LLM against a buggy context just locks the bug
in. RoadId already had a real GT bug in analyzer `replayerTrajectories`
(`CHANGELOG.md`).

**Mitigation:** validator compares LLM claims to **the same files the prompt
used**, plus Payload/outcome flags where available. Map-matching / roadId work
is a **separate analyzer phase**, not an LLM-schema phase.

### 3.6 Renaming `selection_score` is a paper win and an engineering foot-gun

`AnalyzeClient` and `cluster_selection_eval.json` already use `selection_score`.
Renaming the file or the key without an alias breaks the Analyze chip and any
notebook that reads the JSON.

**Mitigation:** add `behavioral_clustering_quality` as an **alias of the same
number**. Keep `selection_score`. Change paper wording first; change keys last.

### 3.7 Summary “defer taxonomy” vs closed `label`

v0 wanted to defer definitive taxonomy. Today `cluster_summary.label` is
**closed vocabulary by design** so names match the paper. Deferring labels
reopens freehand names.

**Mitigation:** keep closed `label`. Add a separate
`llm_interpretation.heterogeneity_note` (medoid story vs cluster collision rate).
Do not make `label` free text.

### 3.8 Historical results and cost

Nested prompts change every card. Re-running batch8/batch9 is expensive and
will not be bit-identical (temperature, snapshot rebuilds). Plan must keep old
YAML readable.

---

## 4. Target contracts (canonical, after migration)

`schema_version: 2` on every LLM YAML. Version 1 = today’s flat files.

### 4.1 Medoid (`medoid_trial.yaml`)

Pipeline merge after LLM parse:

```yaml
schema_version: 2
evidence:                 # PIPELINE — LLM output for this key is discarded
  outcome: collision|safe|...
  trial_id: "..."
  # peak_t, brake_t, ttc, d, impact — from existing extract_conflict_pack / context
observed_behavior:
  timeline:
    - timestamp: 12.4
      action: "Ego decelerates severely"   # lexicon; no motive code here
      situation: "..."                     # optional; must cite context stamps
llm_interpretation:
  interaction_resolution: pass_first|yield|unresolved
  primary_motive: <closed code>
  secondary_motives: [...]
  control_response: ...
  timeline_motives:          # aligned by timestamp to observed_behavior.timeline
    - timestamp: 12.4
      motive: late_reaction
hypothesis:
  open_questions: [...]
  motive_summary: "..."      # narrative; not evidence
llm_meta:
  audit: {status, violations[]}
```

**Flat aliases (v2 writes these too):** `primary_motive`, `decision_timeline`
(merge action + motive per row so Replayer keeps working).

### 4.2 Parameter-space pair (`contrast.yaml`)

```yaml
schema_version: 2
evidence:                  # PIPELINE from pair.json + process/context.md geometry block
  clusters: [0, 2]
  param_dist: ...
  left: {trial, outcome, params}
  right: {trial, outcome, params}
observed_behavior:
  differences: [...]       # persistent geometry / d_min / pass-yield, not 0.3s token gaps
  contrast_timeline:       # keep t_start/t_end/bev_frame; interpretation = observed only
llm_interpretation:
  critical_divergence: ...
  motive_contrast: ...
  left: {primary_motive, interaction_resolution}
  right: {primary_motive, interaction_resolution}
  separation_call: justified|over_fine|inconclusive
  separation_reason: ...
hypothesis:
  contrast_explanation: ...
  hypothesis: ...
  uncertainties: [...]
```

Flat aliases: today’s top-level `contrast_timeline`, `left.primary_motive`, etc.

### 4.3 Cluster summary

Keep `caption`, `neighbor_comparison`, `neighborhood_separation`, closed `label`.
Add pipeline-injected `evidence.cluster_stats` from `context_cluster.md` /
`cluster_aggregate.json` (collision rate, n). LLM must **cite** those numbers in
`llm_interpretation.medoid_vs_cluster`; it must not invent a different rate.

---

## 5. Phased implementation

Each phase has an exit gate. Do not start the next phase until the gate is green.

### Phase 0 — Inventory freeze (no LLM)

- List every reader of medoid / contrast / summary keys (Python + TS).
- Add `schema_version: 1` on **new** writes only (old files remain unversioned = v1).
- Add shared accessors in Python; TS helpers next to `replayerCaption.ts`.
- Unit tests: load one checked-in v1 `medoid_trial.yaml` and one `contrast.yaml`.

**Exit:** grep shows no remaining raw `doc["primary_motive"]` in pipeline Python
except inside accessors.

### Phase 1 — Pipeline-authored `evidence` (no prompt redesign)

- After parse, merge `evidence` from the same sources used today
  (`extract_conflict_pack`, outcome flags, pair.json).
- Discard any LLM-produced `evidence` key.
- Extend `_write_yaml_doc` salvage allow-list only after accessors exist.

**Exit:** new YAMLs contain `evidence.outcome` matching Payload/context; LLM
cannot persist a contradictory outcome in `evidence`.

### Phase 2 — Prompt nested interpretation + flat aliases

- Update `medoid_trial_prompt.txt`, `parameter_space_pair_prompt.txt`,
  `cluster_summary_prompt.txt`, `system_prompt.txt` together.
- Keep closed motive table and causal locality.
- Writer emits nested + flat aliases.
- Dashboard can stay on flat keys for this phase.

**Exit:** dry-run stubs validate; one live medoid + one pair + one summary on a
small run (single cluster / single pair) still render in Analyze + Explore.

### Phase 3 — `llm_audit.py` (name TBD; live under `app/llm_pipeline/python/`)

Checks (fail vs warn):

| Check | Severity |
| --- | --- |
| Closed vocab (`primary_motive`, `separation_call`, `neighborhood_separation`) | fail |
| Timeline timestamps ⊆ context stamp set (tolerance e.g. 0.05s) | fail if >0.25s off |
| `evidence.outcome` (pipeline) vs any LLM `collision_detail` / prose “collided” | fail if contradicted |
| `yield_to_partner` vs deterministic `interaction_resolution` in context when present | warn (geometry heuristics are imperfect) |
| Required keys present | fail |

Wire into `complete_yaml_prompt` **after** parse, **before** summary/selection
consume. Store `llm_meta.audit`. Do not retry the model in a loop.

**Exit:** unit tests with fixture YAML: illegal motive → fail; good v1 card →
pass or warn only.

### Phase 4 — Summary heterogeneity (small prompt delta)

- Instruct summary to compare medoid `llm_interpretation` vs
  `evidence.cluster_stats.collision_rate`.
- Add `medoid_vs_cluster` field; keep closed `label`.

**Exit:** if medoid is safe-pass and cluster collision rate is high, the field
must say so (fixture test, not a live batch).

### Phase 5 — Selection-eval: say which components are LLM-informed

- Keep file `cluster_selection_eval.json` and key `selection_score` (Analyze).
- Add alias `behavioral_clustering_quality` = same number (paper wording).
- Split `components` into `deterministic` (`outcome_purity`,
  `parameter_space_pair_decisiveness`) vs `llm_informed`
  (`motive_distinctness`, `no_merge_candidates` uses medoid motives).
- Placeholder `interpretation_stability: null`; no temperature / medoid-swap
  sweep until budgeted. No fake `evidence_consistency: 0.83`.

**Exit:** Analyze chip still reads `selection_score`; JSON documents the split.

### Phase 6 — Optional two-pass pair (only if Phase 3 is in production)

- Pass 1 frozen `observed_behavior`; pass 2 `separation_call`.
- Skip if cost / latency is rejected. Not required for the hierarchy to be real.

---

## 6. Radar (not scheduled until asked)

1. **Map-matching / roadId dual-store:** `sim_labeller.py` already overwrites
   missing/0 Payload ids with OpenDRIVE nearest-lane inference into a **single**
   `road_id`. Paper-defensible fix is `simulator_id` + `inferred_id` +
   confidence — **analyzer work**, not an LLM YAML change. Do not block pair
   rigor on this.
2. **Trajectory-projection pair LLM:** packs already exist; product is not
   wired. Different question than parameter-space (behavior-similar vs
   param-similar). Same hierarchy if/when added. ChatGPT Type-3 “contextual
   effect” should wait until this product exists as a deterministic handle.
3. **Cross-eval:** still deferred.
4. **Python-composed `cluster_summary.label`:** stronger than prompt-only
   closed vocab — LLM picks atoms, code concatenates. Optional.
5. **Closed `divergence_type` on pairs** (genuine boundary / intensity /
   artifact): only after provenance; map onto existing `separation_call`; do
   not add five unauditable free-text lists.
6. **Explore Filtering / kNN / gradient:** orthogonal to LLM YAML.

---

## 7. Explicit non-goals

- Rewriting clustering (MFPCA / HDBSCAN) or BEV rendering as part of the
  hierarchy refactor.
- Deleting closed motive codes.
- Forcing a full re-LLM of all historical `results/` folders.
- Plans, scripts, or artifacts outside `gpl-odd-project/`.

---

## 8. Decision log

| Date | Decision |
| --- | --- |
| 2026-08-20 | v1 of this file rewritten after repo scan. v0 IC naming and “LLM-authored evidence” rejected. Dual-read + pipeline-authored evidence required. Two-pass pair deferred to Phase 6. |
| 2026-08-20 | ChatGPT 20-point note critiqued against the repo (`chatgpt_suggestion_critique.md`). **Accepted:** 4-stage structure; circularity risk; A/B vs C/D provenance; pair as research core; closed labels; defer cross-eval; audit layer; no new LLM products; stability as radar. **Already true (not a change):** pair_facts withheld; medoid is one trial; taxonomy in `common_sense.txt`; pair-flip eval is deterministic. **Rejected:** LLM-authored evidence YAML (ChatGPT+Gemini); stripping closed motives; renaming selection JSON/key; fake consistency floats; rebuilding builder around XOSC/XODR cartoon; forking a second label taxonomy. **Adapted:** four provenances not three; mark medoid extracts as D when fed to pair; split selection-eval components into deterministic vs llm_informed; roadId dual-store is analyzer radar. |
