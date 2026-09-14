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

Design deep-dives: [`docs/cluster_selection_evaluation.md`](docs/cluster_selection_evaluation.md), [`docs/motive_schema_and_causal_locality.md`](docs/motive_schema_and_causal_locality.md), root [`README.md`](../../README.md), [`implementation_plan.md`](../../implementation_plan.md).

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
odd-export → odd-rules → odd-join → odd-briefing → odd-chat   (S2–S5)
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
    │   ├── output/{odd_boundary_export,odd_parameter_rules,odd_boundary_pairs_join,odd_chat_briefing}.json
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

**Output:** `output/medoid_trial.yaml` — `agent_interactions` (per-agent
resolution / control / motive on **that agent's conflict arc**; pipeline **strips** leftover top-level
`interaction_resolution` / `control_response` / `primary_motive` /
`secondary_motives` if the model still emits them; eval/dashboard may back-fill
a missing named-vehicle row from those old keys when reading legacy files),
`decision_timeline`, `collision_detail` (pipeline may inject GT), `motive_summary`, …

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

**Output:** `output/contrast.yaml` — `contrast_timeline`, `critical_divergence`,
`motive_contrast`, `contrast_explanation`, `separation_call` ∈
`{justified, over_fine, inconclusive}`, …

Whole-trajectory MFPCA+HDBSCAN can group similar shapes with different interaction
intents; pair separation uses the shared conflict window. Dashboard rejects packs
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

**Output:** `output/cluster_summary.yaml` — **`label` is LLM-authored**, target
2–4 words / one outcome archetype (closed style set in `common_sense.txt`;
motive codes and mechanism chaining must stay in `caption`, not `label`).
Pipeline does **not** overwrite `label`. Still rule-sets `risk_level` from
collision rate and `distinct_from_neighbors` from neighbor verdicts.

Also: `caption`, `neighbor_comparison[]` (`verdict` mapped from pair
`separation_call`: justified→distinct, over_fine→similar, …),
`neighborhood_separation` ∈
`{well_separated, merge_candidates, needs_finer_split, ambiguous}`.

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
(“All Clustering Configurations”).

```text
cluster.json + medoid YAML + pair.json  ──rule──►  cluster_selection_eval.json
                                                      │ digest
medoid / summary / contrast / boundary text  ──LLM──► cross_cluster_eval.json
                                                      │
cluster.json + optional LLM scores  ──rule──►  clustering_quality.json
                                              (0.6×rule + 0.4×llm when both LLM scores exist)
```

| Artifact | Kind | When |
|----------|------|------|
| `cross_cluster/input/cluster_selection_eval.json` | Rule | End of every `cluster-interpret`; CLI `selection-eval` |
| `cross_cluster/output/cross_cluster_eval.json` | LLM (stub if dry-run) | `--products cross-eval`; CLI `cross-cluster-eval`; dashboard button |
| `analysis/quality/clustering_quality.json` | Rule (+ optional blend) | After dataset build; after cross-eval; CLI |

**selection-eval components** (weights renormalize if missing):
`outcome_purity` 0.30 · `motive_distinctness` 0.30 ·
`parameter_space_pair_decisiveness` 0.25 · `no_merge_candidates` 0.15.
Reads `cluster.json`, medoid `primary_motive`, `pair.json` flips — **never** sends
raw `cluster.json` to the LLM (only `digest_for_prompt()`).

**cross-eval prompt slots:** `{cluster_summaries}`, `{medoid_cards}`,
`{parameter_space_pair_cards}`, `{neighbor_rollup}`, `{boundary_trial_pairs}`,
`{deterministic_checks}`. Outputs `behavioral_separation_score`,
`boundary_clarity_score` (1–10), `inter_notes`, merge/split lists,
`recommended_action`, `selection_verdict`.

**clustering_quality `rule_score` weights:** silhouette 0.25 · collision_spread 0.20 ·
ttc_spread 0.15 · param_nonoverlap 0.15 · intra_consistency 0.25.
`final_score = 0.6×rule + 0.4×llm` when non-stub cross-eval has both scores;
else rule-only. `rank` filled by `GET /api/cluster-evaluate`.

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
| **F Clustering Trust** | `cross_cluster/input/cluster_selection_eval.json` | `merge_candidates`, `findings`; link jumps to Cross-cluster tab |
| **G Recommended Next Tests** | client heuristics on report DTO | inconclusive `separation_call` packs; high-collision clusters missing contrast |
| **E ODD boundary / rules** | S2/S3/S4 JSON under `analysis/odd/output/` | chips + CART rules table; min–max kNN ≠ pair z-score distance |

Produce E’s files:

```bash
python -m llm_pipeline.cli odd-export --run-dir "$RUN"
python -m llm_pipeline.cli odd-rules  --run-dir "$RUN"
python -m llm_pipeline.cli odd-join   --run-dir "$RUN"
```

---

## 6. S2–S5 — ODD boundary, rules, join, Q&A

Run **after** medoid / pairs / summary as needed. S2–S5 do not rewrite those YAMLs.
Paths: see §2 layout under `analysis/odd/`.

```text
S2 odd-export  → boundary export + odd_all_trials.json   (needs Payload zip / --analysis-zip)
S3 odd-rules   → shallow CART (max_depth=3) odd_parameter_rules.json
S4 odd-join    → trial-id join of boundary ∩ parameter_space_pairs
S5a odd-briefing → odd_chat_briefing.json (deterministic KB)
S5b odd-chat   → one LLM call per question + odd_chat_log.jsonl
```

```bash
conda activate analyzer
export PYTHONPATH="app/llm_pipeline/python:app/analyzer/src"
python -m llm_pipeline.cli odd-export   --run-dir "$RUN" --kNN 10
python -m llm_pipeline.cli odd-rules    --run-dir "$RUN"
python -m llm_pipeline.cli odd-join     --run-dir "$RUN"
python -m llm_pipeline.cli odd-briefing --run-dir "$RUN"
python -m llm_pipeline.cli odd-chat --run-dir "$RUN" \
  --question "What is the weakness of this AV system?"
```

### S2 — `odd_export.py`

Python twin of Explore Filtering **Export ODD boundary** (min–max normalized
kd-tree kNN — **not** parameter-space z-score L2). Flags trials with any of k
neighbors differing in pass/fail (**collision boundary**) or cluster label
(**cluster boundary**). See `implementation_plan.md` §2.1 C1.

### S3 — `odd_rules.py`

`DecisionTreeClassifier` on `odd_all_trials.json` → auditable predicates
(support/precision/boundary hits). Hypothesis about sampled trials — **not** a
certified ODD. Default `max_depth=3` (C2 ablation).

### S4 — `odd_join.py`

Join by **trial id only** (never distance). Writes
`odd_boundary_pairs_join.json`.

### S5a — `odd_briefing.py`

Assembles one compact `odd_chat_briefing.json` from cluster/pair/ODD/selection
artifacts (long text truncated). Missing pieces listed in `missing[]` for honest
“unknown — run step X” answers.

### S5b — `odd_chat.py` (grounded Q&A)

**Not full RAG** — fixed briefing + keyword router (“light RAG” / grounded
prompting). API key via CLI `--api-key` / env / dashboard ephemeral field (same
pattern as other Analyze products); missing key → dry-run stub still logged.

Each turn: system prompt + **routed slice** of briefing + last 8 dialog turns +
question. Never raw trajectories / full BEV / full context timelines.

| Intent keywords | Sections attached |
| --- | --- |
| `cluster N` / `cA-cB` | that cluster + touching pairs |
| weak / failure / worst | top collision clusters + sample pairs |
| fail condition / odd / limit | rules + boundary |
| test next / coverage | boundary, rules, merge candidates, pairs∩boundary |
| merge / separat… | separation notes + pair calls + merge candidates |
| (else) | run header + cluster id/label/rates |

Persists `$RUN/analysis/logs/odd_chat_log.jsonl` (`conversation_id` partitions chats).
Dashboard: `GET/POST /api/odd-chat` → `scripts/run_odd_chat.sh`.

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

python -m llm_pipeline.cli odd-export|odd-rules|odd-join|odd-briefing --run-dir "$RUN"
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
| `cluster_selection_eval.py` | Rule selection score + digests |
| `cross_cluster_evaluator.py` | Whole-partition LLM verdict |
| `clustering_quality_scorer.py` | Rule (+ optional LLM blend) ranking score |
| Analyzer `dataset_builder.py` / `parameter_space_pair_packs.py` | Packs, BEV, context rebuild |
| `odd_export.py` / `odd_rules.py` / `odd_join.py` | S2–S4 |
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
