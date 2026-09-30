# GPL-ODD LLM Pipeline

Split LLM / deterministic analysis over a clustering **run directory**:

```text
results/batch<id>/<k>_cluster_s=<sil>/
```

```bash
RUN=results/batch8/3_cluster_s=0.8032   # example used throughout
```

| Concept | Folder under `$RUN/` | CLI |
| --- | --- | --- |
| Near-identical **scenario parameters** (z-scored L2 ≤ τ) across clusters | `parameter_space_pairs/cA-cB/` | `--products parameter-space-pairs` |
| Near-identical **MFPCA / trajectory projection** across clusters | `trajectory_projection_pairs/cA-cB/` | `dataset_builder` only (no LLM product yet) |

Legacy folders `ic_pairs/` and `boundary_pairs/` still resolve as read fallbacks.

Dashboard **Analyze** tabs: Model setup → Medoid → Parameter-space pairs → Cluster analysis → Cross-cluster analysis → Report → ODD Q&A. Explore Replayer reads medoid / pair cards via `/api/cluster-analysis-status`. Visualization review (gaps, graph+text linking, paper notes): [`app/dashboard/VISUALIZATION_REVIEW.md`](../dashboard/VISUALIZATION_REVIEW.md).

Design deep-dives: [`docs/analysis_nouns.md`](docs/analysis_nouns.md) (the noun list to check after a wording change), [`docs/cluster_selection_evaluation.md`](docs/cluster_selection_evaluation.md), [`docs/motive_schema_and_causal_locality.md`](docs/motive_schema_and_causal_locality.md), root [`README.md`](../../README.md). The August implementation plan and the superseded architecture-refactor plan were removed; the current score formulas are in §4.5.

---

## 1. End-to-end dataflow

```text
Payload batch  +  analysis zip (MFPCA / HDBSCAN)
        │
        ▼
dataset_builder.py   ← DETERMINISTIC (packs, BEVs, context)
        │
        ▼
$RUN/
        ├─ clusterN/{raw,processed,output}/
        └─ parameter_space_pairs/cA-cB/…
        │
        ▼
llm_pipeline.cli cluster-interpret
        ├─ Pass 1: cluster_aggregate.json (always)
        ├─ medoid → medoid_trial.yaml
        ├─ parameter-space-pairs → contrast.yaml
        ├─ summary → cluster_summary.yaml            (each cluster independent)
        ├─ label-review (optional LLM, once) → renames + cluster_label_review.json
        ├─ selection-eval (always, rule) → cluster_selection_eval.json
        └─ cross-eval (optional LLM) → cross_cluster_eval.json + rescore quality
        │
        ▼
odd-export → odd-rules → odd-briefing → odd-chat   (S2, S3, S5)
```

`cluster-interpret` is the umbrella CLI. Products are selected with `--products`
(default **`medoid` only**). Order when combined: **medoid → parameter-space-pairs → summary**.

| `--products` / CLI | Needs first | Writes |
| --- | --- | --- |
| `medoid` | `$RUN/clusterN/processed/` | `clusterN/output/medoid_trial.yaml` |
| `parameter-space-pairs` | both medoids + pack `process/context.md` + `synced_bev/` | `parameter_space_pairs/cA-cB/output/contrast.yaml` |
| `summary` | medoid + every touching `contrast.yaml`; **each cluster run independently** (no cross-cluster read) | `clusterN/output/cluster_summary.yaml` (`label` = LLM) |
| `label-review` | every requested cluster's `cluster_summary.yaml` on disk; API key unless `--dry-run` | may rename `label` in place + `analysis/quality/cluster_label_review.json` |
| `selection-eval` *(not a product flag)* | `clusterN/raw/cluster.json` min.; richer with medoids + `pair.json` | `cross_cluster/input/cluster_selection_eval.json` (also auto at end of every `cluster-interpret`) |
| `cross-eval` | medoids (+ summaries preferred) + pair packs; API key unless `--dry-run` | `cross_cluster/output/cross_cluster_eval.json` + rescored `analysis/quality/clustering_quality.json` |
| `all` | — | all five products above |

`$RUN/clusterN/raw/cluster.json` comes from clustering / `dataset_builder`, not the LLM pipeline. **Rule-only** — never pasted into an LLM prompt. Holds size, `collision_rate`, TTC/SPRET, `parameter_ranges`, medoid id, `intra_variance`.

---

## 2. Run directory layout

```text
$RUN/
├── manifest.json
├── clusterN/
│   ├── raw/cluster.json, trajectory.csv
│   ├── processed/          # deterministic medoid inputs
│   │   ├── action.yaml, context_medoid.md, context_cluster.md
│   │   ├── cluster_aggregate.json
│   │   └── snapshots/…jpg
│   └── output/
│       ├── medoid_trial.yaml
│       └── cluster_summary.yaml
├── trajectory_projection_pairs/cA-cB/   # MFPCA-near; no LLM product yet
├── parameter_space_pairs/cA-cB/
│   ├── pair.json            # rule/UI metadata — not fed to pair LLM
│   ├── process/context.md
│   ├── synced_bev/
│   ├── output/contrast.yaml
│   └── c*_trial_*/…         # thin sides
├── cross_cluster/
│   ├── input/cluster_selection_eval.json
│   └── output/cross_cluster_eval.json
└── analysis/
    ├── quality/{clustering_quality.json, cluster_label_review.json}
    ├── odd/
    │   ├── input/odd_all_trials.json
    │   ├── output/{odd_boundary_export,odd_parameter_rules,odd_chat_briefing}.json
    │   └── snapshots/odd_boundary_export.kNN<k>.json
    ├── metadata/PAPER_SOURCE.json
    └── logs/{split_analysis_summary.json, odd_chat_log.jsonl, *.log}
```

No `llm_inputs/` dump — prompts read artifacts on disk at call time.

---

## 3. How every LLM call is assembled

```text
SystemMessage  ← prompt_templates/system_prompt.txt
HumanMessage   ← common_sense.txt + task template + on-disk placeholders [+ optional BEV]
```

| Prompt file | Product |
|-------------|---------|
| [`system_prompt.txt`](prompt_templates/system_prompt.txt) | all |
| [`common_sense.txt`](prompt_templates/common_sense.txt) | all |
| [`medoid_trial_prompt.txt`](prompt_templates/medoid_trial_prompt.txt) | `medoid` |
| [`parameter_space_pair_prompt.txt`](prompt_templates/parameter_space_pair_prompt.txt) | `parameter-space-pairs` |
| [`cluster_summary_prompt.txt`](prompt_templates/cluster_summary_prompt.txt) | `summary` |
| [`cluster_reviewer_prompt.txt`](prompt_templates/cluster_reviewer_prompt.txt) | `label-review` |
| [`cross_cluster_prompt.txt`](prompt_templates/cross_cluster_prompt.txt) | `cross-eval` |
| [`odd_chat_system_prompt.txt`](prompt_templates/odd_chat_system_prompt.txt) | `odd-chat` |

| Product | Fed to LLM |
|---------|------------|
| **medoid** | prompts + `clusterN/processed/context_medoid.md` + BEV JPGs |
| **parameter-space-pairs** | prompts + `parameter_space_pairs/cA-cB/process/context.md` + `synced_bev/` + extracts from both clusters’ `medoid_trial.yaml` |
| **cluster summary** | prompts + this cluster’s `medoid_trial.yaml` extract + `context_cluster.md` + touching `contrast.yaml` + the neighbor cluster’s `medoid_trial.yaml` extract. **No** other clusters’ labels/captions — each cluster is summarized independently, one call at a time |
| **cluster label-review** | every cluster’s `label` + first 400-char `caption` excerpt + `risk_level`, already written to `cluster_summary.yaml` — **no** `medoid_trial.yaml` / `contrast.yaml` re-read |
| **cross-eval** | text built from existing `cluster_summary.yaml` / `medoid_trial.yaml` / `contrast.yaml` (+ optional boundary `description.txt`) **and** a short selection-eval digest (`selection_score`, components, findings, merge_candidates from `cluster_selection_eval.json`) — **not** raw `cluster.json` rows |

---

## 4. Products

### 4.0 Cluster aggregate (always, no LLM)

Every `cluster-interpret` call rebuilds `$RUN/clusterN/processed/cluster_aggregate.json`
via `cluster_aggregates.build_enriched_cluster_aggregate` (TTC/SPRET/IC digests,
collision rate, parameter ranges). Dashboard-facing; **not** fed to LLM prompts.
Also patches soft fields on `cluster.json`.

### 4.1 Medoid — `--products medoid`

| Input | Path |
|-------|------|
| templates | `{system,common_sense,medoid_trial}_prompt` |
| `{trial_context}` | `processed/context_medoid.md` |
| BEV | `processed/snapshots/*.jpg` (all frames by default; dashboard **Select frames** can thin) |

**Output:** `output/medoid_trial.yaml`. Each `agent_interactions` row is
`agent` + `resolution` (`pass_first` / `yield` / `unresolved`). The timeline
is `timestamp` + `description`. `motive_summary` is 2–4 sentences of why.
`ensure_named_vehicle_agent_interaction` strips leftover `control_response`,
row `motive`, and top-level `interaction_resolution` / `primary_motive` /
`secondary_motives` if a model still emits them. `conflict_metrics` stays
(pipeline numbers). A name such as Late Yield is not written here.

```bash
python -m llm_pipeline.cli cluster-interpret \
  --results-dir "$RUN" --batch-id 8 --products medoid --clusters 0
```

### 4.2 Parameter-space pairs — `--products parameter-space-pairs`

**Gate:** both medoids + `process/context.md` + `synced_bev/`.

| Input | Path |
|-------|------|
| `{pair_context}` | `parameter_space_pairs/cA-cB/process/context.md` |
| medoid extracts | both `cluster{A,B}/output/medoid_trial.yaml` |
| BEV | `synced_bev/*.jpg` (≤8) |

**Output:** `output/contrast.yaml`. Each side is `resolution` + one
`evidence` sentence. Also `contrast_timeline`, `critical_divergence`,
`contrast_explanation`, and `behavior_similarity` ∈
`{distinct, similar, inconclusive}`. Behavioral similarity is the behavior of
the two boundary trials in that pack. The report column uses the same words.
`behavior_similarity_reason` is the one-line reason. The writer drops
`motive_contrast` and the old side triple (`interaction_resolution` /
`control_response` / `primary_motive`) on a new write.

Whole-trajectory MFPCA+HDBSCAN can group similar shapes with different interaction
intents; `behavior_similarity` uses the shared conflict window. Dashboard rejects packs
that are not `readyForLlm` (see §9).

```bash
python -m llm_pipeline.cli cluster-interpret \
  --results-dir "$RUN" --batch-id 8 --products parameter-space-pairs --pairs c0-c2
```

### 4.3 Cluster summary — `--products summary`

**Gate:** medoid + every touching `contrast.yaml`.

| Input | Path |
|-------|------|
| this cluster’s medoid | `clusterN/output/medoid_trial.yaml` extract |
| cluster context | `processed/context_cluster.md` |
| touching pairs | each touching `parameter_space_pairs/cA-cB/output/contrast.yaml` **and** the other side’s `clusterM/output/medoid_trial.yaml` extract |

**Output:** `output/cluster_summary.yaml`. **`label` is LLM-authored**,
2–4 words, one outcome archetype (`Late Yield` lives only here). The why is
`caption`. `motive_consistency_note` compares the caption to the medoid
`resolution` and `motive_summary`. The pipeline does **not** overwrite
`label`. It still sets `risk_level` from the collision rate and
`distinct_from_neighbors` from the neighbor verdicts.

Also: `caption`, `neighbor_comparison[]` (`behavior_similarity` copied from
the pair: `distinct`, `similar`, `inconclusive`, or `ambiguous` when the pair
card is missing), `neighbor_behavior` ∈
`{distinct, similar, mixed, ambiguous}`.

```bash
python -m llm_pipeline.cli cluster-interpret \
  --results-dir "$RUN" --batch-id 8 --products summary --clusters 0
```

### 4.4 Cluster label review — `--products label-review`

Because `summary` labels each cluster independently, duplicate/near-duplicate names on
clusters whose behavior actually differs. `label-review` is one LLM call
per run that fixes both.

**Gate:** at least 2 clusters with a (non-stub) `cluster_summary.yaml` on
disk — checks every `cluster*` folder in `$RUN`, not just clusters touched by
this invocation.

**Input:** for every cluster — `label`, `risk_level`, and first 400-char
`caption` excerpt. **No** BEV, no `medoid_trial.yaml` / `contrast.yaml`
re-read.

**Output:** may rewrite `label` on any `clusterN/output/cluster_summary.yaml`
(adds a `label_review: {previous_label, reason, reviewed_at}` audit block on
that file) and always writes `analysis/quality/cluster_label_review.json`
— one row per cluster (`cluster_id`, `original_label`, `new_label`, `changed`,
`reason`), whether or not it changed.

```bash
python -m llm_pipeline.cli cluster-interpret \
  --results-dir "$RUN" --batch-id 8 --products summary,label-review

# or, standalone rerun over labels already on disk:
python -m llm_pipeline.cli label-review --run-dir "$RUN" --model gemini-2.5-flash
```

### 4.5 Selection-eval / cross-eval / clustering-quality

Three related artifacts judge **the partition**, not one trial. Silhouette is
geometric; these layers are behavioral. Detail / dashboard field tutorial:
[`docs/cluster_selection_evaluation.md`](docs/cluster_selection_evaluation.md).

**Scope:** cross-eval = inter-cluster verdict **inside one `$RUN`**. Ranking
different `k_cluster_s=…` folders uses each folder’s `clustering_quality.json`
(“Other clusterings of this batch” on the cross-cluster tab). Silhouette is a
geometry piece, not a separate ranking column.

```text
cluster.json + medoid YAML + pair.json  ──rule──►  cluster_selection_eval.json
                                                      │ digest
medoid / summary / contrast / boundary text  ──LLM──► cross_cluster_eval.json
                                                      │
cluster.json + optional LLM scores  ──rule──►  clustering_quality.json
                                              (final_score is the geometry score; LLM ratings are stored beside it)
```

| Artifact | Kind | When |
|----------|------|------|
| `cross_cluster/input/cluster_selection_eval.json` | Rule | End of every `cluster-interpret`; CLI `selection-eval` |
| `cross_cluster/output/cross_cluster_eval.json` | LLM (stub if dry-run) | `--products cross-eval`; CLI `cross-cluster-eval`; dashboard button |
| `analysis/quality/clustering_quality.json` | Rule (+ optional blend) | After dataset build; after cross-eval; CLI |

**Selection checks** (`cluster_selection_eval.json`). Outcome purity and title
distinctness are still computed, with equal weight, into `selection_score`.
That number is a digest for the language-model prompt. The dashboard does not
show it. The JSON key is still `motive_distinctness`. It counts summary titles,
and uses the medoid resolution only when a cluster has no title. Pair outcome
flips and the merge-candidate list are written for inspection. The digest sent
to the language model is `digest_for_prompt()` — never raw `cluster.json`.

**cross-eval prompt slots:** `{cluster_summaries}`, `{medoid_cards}`,
`{parameter_space_pair_cards}`, `{neighbor_rollup}`, `{boundary_trial_pairs}`,
`{deterministic_checks}`. Outputs `behavioral_separation_score`,
`boundary_clarity_score` (1–10), `inter_notes`, `cluster_differences`, and
`selection_verdict`. The reading names what clusters share and what trajectory,
collision, or timing difference still separates them. It does not recommend a
merge, a split, or a different number of clusters.

**clustering_quality `rule_score` weights:** silhouette 0.25 · collision_spread 0.25 ·
ttc_spread 0.25 · intra_consistency 0.25.
`final_score` equals `rule_score`. The dashboard calls that number **geometry**.
The language-model rating is the average of separation and boundary clarity,
times 10, and is stored as `llm_score`. It does not move `final_score`.
`rank` is filled by `GET /api/cluster-evaluate` from `final_score`, so the rank
follows geometry. If the model omits a rating, the parser stores 5; that 5 is
shown on the reading and does not change the geometry score.

**`analysis/logs/split_analysis_summary.json`:** write-only receipt of the latest
`cluster-interpret` call (paths written/skipped). Nothing reads it back.

```bash
python -m llm_pipeline.cli selection-eval --run-dir "$RUN"
python -m llm_pipeline.cli cross-cluster-eval --run-dir "$RUN" --model gemini-2.5-flash
# or:  … cluster-interpret --products cross-eval …
```

---

## 5. Dashboard Report (read-only)

Analyze → **Report** loads `GET /api/cluster-run-report` (no LLM) from files on disk.

| Panel | Source | Notes |
|-------|--------|-------|
| Header chips | `clustering_quality.json` | **geometry** is `final_score`, which equals the geometry score. |
| **Recommended Next Tests** | client heuristics on report DTO | Missing pair contrasts and inconclusive calls. A `similar` pair shares a behavior family and the same outcome; the contrast names the remaining trajectory difference. |
| **ODD boundary / rules** | S2/S3 JSON under `analysis/odd/output/` | CART rules table; min–max kNN ≠ pair z-score distance |

Produce E’s files:

```bash
python -m llm_pipeline.cli odd-export --run-dir "$RUN"
python -m llm_pipeline.cli odd-rules  --run-dir "$RUN"
```

---

## 6. S2, S3, S5 — ODD boundary, rules, Q&A

Run **after** medoid / pairs / summary as needed. S2, S3, and S5 do **not** rewrite those
YAMLs. They answer a different question from the cluster stack: *where in the
sampled scenario-parameter box do pass/fail (and cluster labels) change, and
can an engineer read that as a few predicates?* That is **ODD-related evidence
for one logical scenario**, not a SAE J3016 certificate (weather, map, road
class, … are not in the trial table). See
[`post_medoid_analysis_method_study.md`](post_medoid_analysis_method_study.md)
§2.5 / §7.

Paths: §2 layout under `analysis/odd/`. Numbers below are the shipped
`results/batch8/6_cluster_s=0.6113` artifacts (kNN=10, 2 params:
`OncomingSpeed`, `OncomingStartDelay`).

```text
S2 odd-export    → odd_all_trials.json + odd_boundary_export.json (+ kNN snapshot)
S3 odd-rules     → odd_parameter_rules.json          (CART depth ≤ 3)
S5a odd-briefing → odd_chat_briefing.json            (deterministic KB, no LLM)
S5b odd-chat     → one LLM call per question + odd_chat_log.jsonl
```

```bash
conda activate analyzer
export PYTHONPATH="app/llm_pipeline/python:app/analyzer/src"
python -m llm_pipeline.cli odd-export   --run-dir "$RUN" --kNN 10
python -m llm_pipeline.cli odd-rules    --run-dir "$RUN"
python -m llm_pipeline.cli odd-briefing --run-dir "$RUN"
python -m llm_pipeline.cli odd-chat --run-dir "$RUN" \
  --question "What is the weakness of this AV system?"
```

Explore Filtering → **Export ODD boundary** writes the same S2 files as
`odd-export` (Python twin of `explore/lib/boundaryExport.ts`). S3 and S5 are CLI
(and Report / OddQA read them).

### S2 — `odd_export.py` (frontier **points**, not a sentence)

**Job.** Twin of Explore’s kNN filter. For each trial in the saved analysis zip,
build a min–max-normalized kd-tree over scenario parameters (same metric as
the heatmap, **not** pair z-score L2). Flag a trial if any of *k* neighbors
differs in KPI pass/fail (**collision boundary**) or in cluster label
(**cluster boundary**). Those two lists must stay separate: a trial can be
one, both, or neither.

**Writes** (under `$RUN/analysis/odd/`):

| File | Role |
|------|------|
| `input/odd_all_trials.json` | Training table for S3. Every considered trial: `trial_id`, `parameters{}`, `passed`, `cluster_label` (label may be `null` if the trial was not in the HDBSCAN fit). Example: **3869** trials, ~824 KB. |
| `output/odd_boundary_export.json` | Latest export. Header + `collision_boundary.{boundary_trials,edges}` + `cluster_boundary.{…}` + `distance_note`. Example: **650** collision-boundary trials / 996 edges, **741** cluster-boundary trials / 1333 edges; **869** trials have no cluster label (excluded from cluster-boundary matching). ~718 KB. |
| `snapshots/odd_boundary_export.kNN<k>.json` | Copy of that export so a later k=25 run does not erase k=10. |

A **boundary trial** record is `{trial_id, parameters, passed, cluster_label, neighbor_ids}`.
An **edge** is `{trial_a, trial_b, param_dist}` where `param_dist` is **min–max L2**
(do not compare to `pair.json`’s z-scored `param_dist`).

**How it helps an engineer (this is useful, not decoration):**

1. **Persists the heatmap filter.** Without S2, “the frontier” exists only as a
   live Explore checkbox. The Report panel E chips (`650 collision-boundary`,
   `741 cluster-boundary`) and S5 “what to test next” need a file.
2. **Scales past 1:1 pairs.** Parameter-space packs are ~9 closest
   inter-cluster trials. S2 lists **hundreds** of mixed-neighbor points — the
   rest of the fail envelope, including trials that never got a pair card.
3. **Separates two questions.** Collision-boundary = *where the KPI flips in
   sampled params*. Cluster-boundary = *where HDBSCAN labels flip*. Mixing them
   into one “ODD” sentence is the usual overclaim.
4. **CI / no-browser.** `odd-export --run-dir` rebuilds the same JSON the UI
   button writes, from the analysis zip (not live Payload Trial REST — those
   docs are empty for paper casestudies).

**What it is not.** Not SAE ODD, not a certified limit, not Song-style CSI
search. Sampling density is the scenario sampler, not real-world exposure.
Trials with `cluster_label: null` are in `odd_all_trials` (S3 trains on them)
but are **not** collision-boundary-matched the same way clustered trials are —
the export header `n_trials_without_cluster_label` is the honest count.

### S3 — `odd_rules.py` (frontier **sentences**)

**Job.** Fit a shallow CART (`sklearn.tree.DecisionTreeClassifier`, default
`max_depth=3`, `min_samples_leaf=10`) on `odd_all_trials.json`: `y = 1` iff
`passed` is false. Walk every root→leaf path to an AND-predicate. Count how
many of that leaf’s trials sit on the S2 **collision** boundary
(`boundary_trial_hits`).

**Writes:** `$RUN/analysis/odd/output/odd_parameter_rules.json` (~3 KB).

Example (batch8 k=6, 3869 trials, 1771 fail / 2098 pass, train acc 0.857,
5-fold cv 0.842):

| id | predicate (abbrev.) | predicts | support | precision | boundary hits |
|----|---------------------|----------|---------|-----------|---------------|
| R4 | delay ∈ (3.855, 4.388] ∧ speed > 2.374 | collision | 1688 | 0.819 | 339 |
| R5 | delay ∈ (4.388, 4.643] ∧ speed ≤ 2.382 | collision | 189 | 0.873 | 35 |
| R8 | delay > 4.388 ∧ speed > 2.571 | safe | 867 | 0.986 | 55 |
| R1 | delay ≤ 3.855 ∧ speed ≤ 3.342 | safe | 397 | 0.990 | 22 |
| … | 4 more leaves | … | … | … | … |

**How it helps an engineer:** staring at 650 kNN points is not a thesis
sentence. R4 is: *in this sample, the large delay–speed box is ~82% collision
and eats 339 of the kNN frontier points.* R8 is a high-precision **safe** box.
Report panel E renders this as a table. Chat intent `fail condition / odd /
limit` attaches these rows. That is the XAI reason to keep CART (Atakishiyev
et al. — interpretable-by-design) instead of a boosted black box.

**What it is not.** Not “the ODD.” Depth 3 is a **readability** choice (plan
C2), not max accuracy. Axis-aligned splits ≠ the true curved frontier. Class
balance follows the sampler. `boundary_trial_hits` uses S2 min–max IDs, not
pair z-score. Do not quote a threshold the tree never emitted.

### S5a — `odd_briefing.py`

No LLM. Assembles one compact `odd_chat_briefing.json` (~15 KB, target 8–15k
tokens) from cluster summaries, pair folders, S2/S3, selection-eval
findings / merge candidates. Long captions truncated. `missing[]` lists absent
products so chat can say “unknown — run S3” instead of guessing.

### S5b — `odd_chat.py` (grounded Q&A — **not** full RAG)

**Why not RAG?** Lewis et al. 2020 RAG = *retrieve from a large, changing
document index* (dense retriever + generator), then generate. This run’s
knowledge is already **one structured JSON** (~6 clusters, ~9 pairs, ~8 rules,
boundary counts). There is nothing to index at Wikipedia scale. Full RAG
(chunk YAMLs / `context.md` / BEV, embeddings, a vector GraphRAG)
would (a) retrieve prose the system prompt forbids as a number source, (b)
make citations un-auditable, (c) burn tokens on timelines we deliberately
exclude. Plan §2.4: briefing JSON = non-parametric memory for **this** `$RUN`;
do not claim we trained DPR/BART.

**What we have (“light RAG” / grounded prompting):**

Each turn: system prompt + **keyword-routed slice** of the briefing + last 8
dialog turns + question. Numbers only from the briefing; `missing[]` → unknown.
Never raw trajectories / full BEV / full context timelines / live web.

| Intent keywords | Sections attached |
| --- | --- |
| `cluster N` / `cA-cB` | that cluster + touching pairs |
| weak / failure / worst | top collision clusters + sample pairs |
| fail condition / odd / limit | rules + boundary |
| test next / coverage | boundary, rules, merge candidates |
| merge / separat… | separation notes + pair calls + merge candidates |
| (else) | run header + cluster id/label/rates |

API key via CLI `--api-key` / env / dashboard ephemeral field (same pattern as
other Analyze products); missing key → dry-run stub still logged.

Persists `$RUN/analysis/logs/odd_chat_log.jsonl` (`conversation_id` partitions
chats). Dashboard: `GET/POST /api/odd-chat` → `scripts/run_odd_chat.sh`.

**Would RAG help later?** Only if the corpus grows (many runs, paper text,
intra-cluster members). Then: embed **briefing sections** (not raw traj),
replace the regex router, keep “cite or say unknown.” Do **not** retrieve
Payload dumps. Faithfulness eval (gold Q/A vs citations) is higher value than
a vector DB. See study §7.

---

## 7. Rebuild helpers (no LLM)

```bash
# Rewrite context_*.md / pair process/context.md from existing snapshots + action.yaml
export PYTHONPATH=app/analyzer/src
python app/analyzer/src/dataset_builder.py \
  --rebuild-context-texts "$RUN"

# Rebuild parameter-space packs (sides + context + BEV; empty output/)
python app/analyzer/src/dataset_builder.py \
  --from-run "$RUN" --analysis-zip data/paper_casestudies/case3/casestudy3.zip \
  --batch-id 8 --dataset dataset3 \
  --medoids none --emb-boundaries none --param-boundaries all --outliers none
```

---

## 8. CLI cheat sheet

```bash
conda activate analyzer
export PYTHONPATH="app/llm_pipeline/python:app/analyzer/src"
export GOOGLE_API_KEY="…"   # or OPENAI_API_KEY for gpt-*

python -m llm_pipeline.cli cluster-interpret \
  --results-dir "$RUN" --batch-id 8 \
  --products medoid|parameter-space-pairs|summary|label-review|cross-eval|all \
  [--clusters 0,2] [--pairs c0-c2] [--dry-run]

python -m llm_pipeline.cli selection-eval --run-dir "$RUN"
python -m llm_pipeline.cli label-review --run-dir "$RUN" --model gemini-2.5-flash
python -m llm_pipeline.cli cross-cluster-eval --run-dir "$RUN" --model gemini-2.5-flash

python -m llm_pipeline.cli odd-export|odd-rules|odd-briefing --run-dir "$RUN"
python -m llm_pipeline.cli odd-chat --run-dir "$RUN" --question "…" [--dry-run]
```

---

## 9. Parameter-space pair readiness (dashboard)

| Field | Meaning |
|-------|---------|
| `medoidReady` | both endpoint `medoid_trial.yaml` exist |
| `hasProcessContext` | `process/context.md` |
| `hasSyncedBev` | synced JPG frames |
| `hasContrast` | `output/contrast.yaml` |
| `readyForLlm` | medoidReady ∧ process ∧ BEV |
| `missing` | human-readable gaps |

---

## 10. Package map

| Module | Role |
|--------|------|
| `split_analysis.py` | Products; gates; summary LLM invents `label` per cluster, independently; `split_analysis_summary.json` |
| `cluster_aggregates.py` | Pass-1 aggregates → `cluster_aggregate.json` |
| `cluster_label_reviewer.py` | Cross-cluster label QA — one LLM call, renames mechanism-chained / duplicate labels |
| `cluster_selection_eval.py` | Purity and title-distinctness checks + digests |
| `cross_cluster_evaluator.py` | Whole-partition LLM verdict |
| `clustering_quality_scorer.py` | Rule (+ optional LLM blend) ranking score |
| Analyzer `dataset_builder.py` / `parameter_space_pair_packs.py` | Packs, BEV, context rebuild |
| `odd_export.py` / `odd_rules.py` | S2–S3 |
| `odd_briefing.py` / `odd_chat.py` | S5a–S5b |
| `scripts/run_odd_chat.sh` + dashboard `api/odd-chat` | ODD Q&A UI wrapper |

---

## 11. Notes

**TTC:** (1) Payload KPI `ttc_min` in aggregates — polygon look-ahead; (2) BEV
closing-rate TTC on medoid/pair context lines.

**Paper Case Study names** (historical only — not forced by code):

- CS1: Pass-First, Collision, Proactive Yield, Late Yield
- CS2: Pass-First, Opposite Collision, Yield, Parked Collision
- CS3: Smooth Pass, Cut-in Collision, Yield, Brake Rear-end, Yield-Stop Collision, Pass-Slowdown

Summary LLM invents each `label` independently, per cluster, from evidence
against the closed 2–4 word style set in `common_sense.txt` — resembling
these paper names is a side effect, not a target. `label-review` (§4.4) is
the only stage allowed to compare labels across clusters and rename one.
