# GPL-ODD LLM Pipeline

Split LLM / deterministic analysis cards over a clustering **run directory**:

```text
results/batch<id>/<k>_cluster_s=<sil>/
```

**Pair naming (folders + CLI products):**

| Concept | Folder under `$RUN/` | CLI product |
| --- | --- | --- |
| Near-identical **scenario parameters** (z-scored L2 ≤ τ) across clusters | `parameter_space_pairs/cA-cB/` | `--products parameter-space-pairs` |
| Near-identical **MFPCA / trajectory projection** across clusters | `trajectory_projection_pairs/cA-cB/` | (dataset_builder only; not an LLM product today) |

Legacy folder names `ic_pairs/` and `boundary_pairs/` still resolve as read fallbacks.

Dashboard **Analyze** tabs (Medoid → Parameter-space pair → Cluster summary) are the operator UI.
Explore Replayer reads medoid `decision_timeline` / `motive_summary`, and Parameter-space pair
`contrast_timeline` / `contrast_explanation`, via `/api/cluster-analysis-status`.

Example run used throughout:

```bash
RUN=results/batch8/3_cluster_s=0.8032
```

---

## End-to-end dataflow

```text
Payload batch  +  analysis zip (MFPCA / HDBSCAN)
        │
        ▼
dataset_builder.py   ← DETERMINISTIC (medoid packs, parameter-space + trajectory-projection pairs, BEVs, context)
        │
        ▼
$RUN/   (e.g. results/batch8/3_cluster_s=0.8032/)
        │
        ├─ clusterN/{raw,processed,output}/
        └─ parameter_space_pairs/cA-cB/{process/,synced_bev/,output/} [+ optional pair.json metadata]
        │
        ▼
llm_pipeline.cli cluster-interpret   ← product order below
        │
        ├─ 1) medoid   → clusterN/output/medoid_trial.yaml
        ├─ 2) parameter-space-pairs → parameter_space_pairs/cA-cB/output/contrast.yaml   (needs both medoids)
        ├─ 3) summary  → clusterN/output/cluster_summary.yaml  (needs medoid + all touching parameter-space contrasts)
        └─ 4) cross-eval / selection-eval  (cross-eval deferred; selection-eval is deterministic)
```

| Want | Need first |
|------|------------|
| `medoid` | `clusterN/processed/` from `dataset_builder` |
| `parameter-space-pairs` | both `cluster{A,B}/output/medoid_trial.yaml` + pack `process/context.md` + `synced_bev/` |
| `summary` | this cluster’s medoid **and** `parameter_space_pairs/*/output/contrast.yaml` for every pack that touches the cluster (hard skip / API 400 if missing) |
| `selection-eval` | medoids ± parameter-space packs (no API key) |

Default CLI product is **`medoid` only**.

When combining products in one invocation (`--products medoid,parameter-space-pairs,summary`),
the pipeline runs them in order: **medoid → parameter-space-pairs → summary** so summaries see
fresh `contrast.yaml` files from the same run.

---

## Run directory layout

```text
$RUN/   # results/batch8/3_cluster_s=0.8032/
├── manifest.json
├── cluster0/
│   ├── raw/cluster.json, trajectory.csv
│   ├── processed/                 # DETERMINISTIC medoid inputs
│   │   ├── action.yaml, context_medoid.md, context_cluster.md, description.txt
│   │   ├── cluster_aggregate.json
│   │   └── snapshots/llm_snapshots.json + *.jpg
│   └── output/
│       ├── medoid_trial.yaml
│       └── cluster_summary.yaml
│
├── trajectory_projection_pairs/c0-c1/   # MFPCA closest pairs (no LLM product yet)
└── parameter_space_pairs/c0-c2/
    ├── pair.json                  # optional metadata for deterministic tools/UI; not fed to LLM
    ├── process/
    │   └── context.md             # ONE shared-clock pair context
    ├── synced_bev/                # dual-panel BEVs + synced_bev_index.json
    ├── output/
    │   └── contrast.yaml          # LLM parameter-space pair analysis
    ├── c0_trial_*/raw/ + processed/action.yaml   # thin sides
    └── c2_trial_*/raw/ + processed/action.yaml
```

There is **no** `llm_inputs/` dump folder. The pipeline reads on-disk artifacts directly
into the prompt at call time.

---

## How every LLM call is assembled

```text
SystemMessage  ← prompt_templates/system_prompt.txt
HumanMessage   ← common_sense.txt + task template + on-disk placeholders [+ optional BEV]
```

| Prompt file | Product |
|-------------|---------|
| [`system_prompt.txt`](prompt_templates/system_prompt.txt) | all |
| [`common_sense.txt`](prompt_templates/common_sense.txt) | all (glossary, motives, BEV guide) |
| [`medoid_trial_prompt.txt`](prompt_templates/medoid_trial_prompt.txt) | `--products medoid` |
| [`parameter_space_pair_prompt.txt`](prompt_templates/parameter_space_pair_prompt.txt) | `--products parameter-space-pairs` |
| [`cluster_summary_prompt.txt`](prompt_templates/cluster_summary_prompt.txt) | `--products summary` |
| [`cross_cluster_prompt.txt`](prompt_templates/cross_cluster_prompt.txt) | deferred (will later read all cluster summaries) |

---

## Pre-flight checklist

```bash
RUN=results/batch8/3_cluster_s=0.8032
```

### A. Run index
- `$RUN/manifest.json` → `parameter_space_pairs` with `parameter_space_match: true`
- `$RUN/parameter_space_pairs/c*-c*/` packs exist

### B. Medoid pack (`$RUN/clusterN/processed/`)
- `context_medoid.md` (single-trial timeline — **fed to medoid LLM**)
- `context_cluster.md` (cluster size / collision rate / parameter ranges — **fed to summary**, not medoid)
- `action.yaml`, `snapshots/` BEVs
- `cluster_aggregate.json` (dashboard / selection-eval; **not** fed to medoid LLM)

### C. Parameter-space pack (`$RUN/parameter_space_pairs/cA-cB/`)
- `process/context.md`, `synced_bev/t_*.jpg`
- optional `pair.json` metadata for deterministic checks / UI (not LLM prompt input)
- Both `$RUN/cluster{A,B}/output/medoid_trial.yaml` before LLM
- After LLM: `$RUN/parameter_space_pairs/cA-cB/output/contrast.yaml`

### D. Prompts under `app/llm_pipeline/prompt_templates/`

---

## Products (order = recommended run order)

### What the LLM sees (and what it does **not**)

| Product | Fed to LLM | Not fed |
|---------|------------|---------|
| **medoid** | `prompt_templates/` + `$RUN/clusterN/processed/context_medoid.md` + `$RUN/clusterN/processed/snapshots/*.jpg` | No cluster collision-rate header; no `conflict_metrics` JSON |
| **parameter-space-pairs** | `prompt_templates/` + `$RUN/parameter_space_pairs/cA-cB/process/context.md` + `$RUN/parameter_space_pairs/cA-cB/synced_bev/*.jpg` + compact extracts from both `$RUN/cluster{A,B}/output/medoid_trial.yaml` | No `pair_facts` / `left_block` / `right_block` |
| **summary** | `prompt_templates/` + this cluster’s `output/medoid_trial.yaml` extract + `processed/context_cluster.md` + touching `parameter_space_pairs/*/output/contrast.yaml` | No BEV |

---

### 1) Medoid trial — `--products medoid`

| Input | Exact path |
|-------|------------|
| templates | `app/llm_pipeline/prompt_templates/{system_prompt,common_sense,medoid_trial_prompt}.txt` |
| `{trial_context}` | `$RUN/clusterN/processed/context_medoid.md` (fallback: `context.md`, then `description.txt` / compact `action.yaml`) |
| BEV images | `$RUN/clusterN/processed/snapshots/*.jpg` |

**Output:** `$RUN/clusterN/output/medoid_trial.yaml`

Keys: `primary_motive`, `secondary_motives`, `decision_timeline[{timestamp,description,motive}]`,
`collision_detail` (pipeline may inject GT after the call), `motive_summary`, `open_questions`.

```bash
python -m llm_pipeline.cli cluster-interpret \
  --results-dir "$RUN" --batch-id 8 --products medoid --clusters 0
```

---

### 2) Parameter-space closest pairs — `--products parameter-space-pairs`

**Gate (hard skip if missing):** both `$RUN/cluster{A,B}/output/medoid_trial.yaml`
+ `$RUN/parameter_space_pairs/cA-cB/process/context.md` + `$RUN/parameter_space_pairs/cA-cB/synced_bev/*.jpg`.

| Input | Exact path |
|-------|------------|
| templates | `app/llm_pipeline/prompt_templates/{system_prompt,common_sense,parameter_space_pair_prompt}.txt` |
| `{pair_context}` | `$RUN/parameter_space_pairs/cA-cB/process/context.md` |
| `{left_medoid_trial}` / `{right_medoid_trial}` | compact extract built at call time from `$RUN/cluster{A,B}/output/medoid_trial.yaml` |
| BEV images | `$RUN/parameter_space_pairs/cA-cB/synced_bev/*.jpg` (up to 8) |

**Output:** `$RUN/parameter_space_pairs/cA-cB/output/contrast.yaml`

Keys: `contrast_timeline[{t_start,t_end,bev_frame,interpretation}]`,
`critical_divergence`, `motive_contrast`, `contrast_explanation`,
`separation_call` / `separation_reason`, `hypothesis`, plus left/right motive fields
(pipeline re-injects trial refs + `conflict_metrics` into the **output** YAML only).

Design note: keep this as a **single pass** with medoid extracts included. For near-identical
pairs, tiny geometric deltas can still flip outcome; medoid context helps the model classify
`motive_contrast` correctly (`same` motive with different outcome vs truly different motive)
and keeps `separation_call` grounded. A two-pass variant (first pair-only, then medoid-backed
separation verdict) is possible, but is not the current product flow.

```bash
python -m llm_pipeline.cli cluster-interpret \
  --results-dir "$RUN" --batch-id 8 --products parameter-space-pairs --pairs c0-c2

python -m llm_pipeline.cli cluster-interpret \
  --results-dir "$RUN" --batch-id 8 --products parameter-space-pairs --pairs c0-c2,c1-c2

python -m llm_pipeline.cli cluster-interpret \
  --results-dir "$RUN" --batch-id 8 --products parameter-space-pairs --clusters 0,2
```

Dashboard: Parameter-space pair tab → select ready chips (multi-select) → Run. API rejects packs that are not `readyForLlm`.

Explore Replayer: selecting **Closest pair (parameter space)** without a medoid still shows the contrast card when present — timed `contrast_timeline` in the ego timeline box, and a **Contrast explanation** button (`contrast_explanation`).

---

### 3) Cluster summary — `--products summary`

**Gate (hard skip / dashboard API 400 if missing):** `$RUN/clusterN/output/medoid_trial.yaml`
**and** `$RUN/parameter_space_pairs/*/output/contrast.yaml` for every pack that touches the cluster.

| Input | Exact path |
|-------|------------|
| templates | `app/llm_pipeline/prompt_templates/{system_prompt,common_sense,cluster_summary_prompt}.txt` |
| `{medoid_trial}` | compact extract from `$RUN/clusterN/output/medoid_trial.yaml` |
| `{cluster_context}` | `$RUN/clusterN/processed/context_cluster.md` |
| `{neighbor_cards}` | touching `$RUN/parameter_space_pairs/cA-cB/output/contrast.yaml` + neighbor `medoid_trial.yaml` extracts |

**No BEV** for summary.

**Output:** `$RUN/clusterN/output/cluster_summary.yaml`

Keys include `caption`, `neighbor_comparison[]`, `distinct_from_neighbors`,
`neighborhood_separation`: `well_separated` | `merge_candidates` | `needs_finer_split` | `ambiguous`.

`label` is NOT freehand — it's composed from a closed vocabulary so cluster names
stay consistent across a run and read like the paper's cluster names (`smooth-pass`,
`yield`, `braking-rear-end`, `cut-in-collision`, …). The LLM maps the medoid's
`primary_motive` to a `PASS`/`YIELD`/`OTHER` resolution class, adds at most one style
modifier (`First`/`Smooth`/`Slowdown`/`Creep`/`Stop`/`Brake`), then appends
`Collision`/`Near-miss` only when the cluster's outcome is dominated by it. Full
mapping table + building blocks live in `common_sense.txt` under "Resolution class"
and "Cluster label building blocks"; the workflow step is in
`cluster_summary_prompt.txt` step 6.

```bash
python -m llm_pipeline.cli cluster-interpret \
  --results-dir "$RUN" --batch-id 8 --products summary --clusters 0
```

Dashboard Cluster analysis tab disables **Run cluster summaries** until each selected
cluster is `readyForSummary` (medoid + all touching contrasts).

---

### 4) Selection / cross-eval

**`selection-eval`** — deterministic only (no LLM, no images). Writes `$RUN/cluster_selection_eval.json`
from cluster stats, medoid motives, and parameter-space pair outcomes.

**`cross-eval`** / `cross_cluster_prompt.txt` — **deferred**. Intended later LLM inputs
(not wired in the live product path yet): `{cluster_summaries}`, `{medoid_trial}` extracts,
`{parameter_space_pair}` contrasts, plus deterministic rollups.

**`clustering-quality`** — composite run score writer. Produces `$RUN/clustering_quality.json`
for ranking/comparing clustering candidates. This file is **not** fed to medoid / pair / summary prompts.

```bash
python -m llm_pipeline.cli selection-eval --run-dir "$RUN"
```

### `cluster_selection_eval.json` meaning and usage

- Purpose: deterministic behavioral quality check for one clustering run (no LLM call).
- Main fields:
  - `selection_score`: weighted aggregate (0-100)
  - `components`: `outcome_purity`, `motive_distinctness`, `parameter_space_pair_decisiveness`, `no_merge_candidates`
  - `primary_motives`: medoid primary motive by cluster id
  - `merge_candidates`: clusters that may be duplicates under deterministic criteria
  - `parameter_space_pairs`: per-pair outcome-flip summary
  - `findings`: human-readable explanations
- Output is consumed by dashboard analysis endpoints and by cross-eval deterministic rollups.
- Outcome purity threshold in this file is `collision_rate <= 5%` or `>= 95%` (not strict 0/100).

### `clustering_quality.json` meaning and usage

Composite run score for ranking/comparing clustering candidates (not fed to medoid/pair/summary LLM prompts).

- `rule_score`: deterministic score from cluster stats
- `llm_score`: from `cross_cluster_eval.json` (`null` when cross-eval not run)
- `final_score`: blended score (`rule_score` when no LLM layer)
- `sub_scores`:
  - `silhouette_score`: normalized silhouette
  - `collision_spread_score`: how separated cluster collision rates are
  - `ttc_spread_score`: spread of mean TTC across clusters
  - `param_nonoverlap_score`: how non-overlapping parameter ranges are
  - `intra_consistency_score`: compactness/consistency proxy (from intra-variance)
- `has_llm_eval`: whether LLM cross-eval contributed

Used by dashboard evaluation endpoints to rank candidate runs.

---

## Rebuild deterministic context texts (no BEV, no LLM)

Rewrites `context_medoid.md` / `context_cluster.md` and pair `process/context.md`
from existing `llm_snapshots.json` + `action.yaml` (does not re-render images):

```bash
export PYTHONPATH=app/analyzer/src
python app/analyzer/src/dataset_builder.py \
  --rebuild-context-texts results/batch8/3_cluster_s=0.8032
```

## Rebuild deterministic parameter-space packs (no LLM)

```bash
export PYTHONPATH=app/analyzer/src
python app/analyzer/src/dataset_builder.py \
  --from-run results/batch8/3_cluster_s=0.8032 \
  --analysis-zip data/paper_casestudies/case3/casestudy3.zip \
  --batch-id 8 --dataset dataset3 \
  --medoids none --emb-boundaries none --param-boundaries all --outliers none
```

Produces slim sides + `process/context.md` + `synced_bev/` + empty `output/`.

---

## CLI cheat sheet

```bash
conda activate analyzer
export PYTHONPATH="app/llm_pipeline/python:app/analyzer/src"
export GOOGLE_API_KEY="…"

python -m llm_pipeline.cli cluster-interpret \
  --results-dir results/batch8/3_cluster_s=0.8032 \
  --batch-id 8 \
  --products medoid|parameter-space-pairs|summary|all \
  [--clusters 0,2] [--pairs c0-c2] [--dry-run] [--max-llm-snapshots 10]
```

---

## Dashboard readiness fields (per Parameter-space pair)

| Field | Meaning |
|-------|---------|
| `medoidReady` | both endpoint `medoid_trial.yaml` exist |
| `hasProcessContext` | `process/context.md` |
| `hasSyncedBev` | synced JPG frames |
| `hasContrast` | `output/contrast.yaml` (or legacy root) |
| `readyForLlm` | medoidReady ∧ process ∧ BEV |
| `missing` | human-readable list of gaps |

---

## Package map

| Module | Role |
|--------|------|
| `split_analysis.py` | Products; medoid/IC gates; `--pairs`; writes `output/*.yaml` |
| `parameter_space_pair_timeline.py` | Prefers `process/context.md` |
| `cluster_selection_eval.py` | Selection score + neighbor digests |
| Analyzer `parameter_space_pair_packs.py` | Slim packs + `write_pair_process_context_md` |
| Analyzer `dataset_builder.py` | `thin_parameter_space_side` trial writer |

## TTC note

1. Payload KPI `ttc_min` in aggregates — polygon look-ahead.
2. BEV closing-rate TTC on medoid snapshots / pair context lines.

See root [`README.md`](../../README.md) §5. Design notes:
[`docs/motive_schema_and_causal_locality.md`](docs/motive_schema_and_causal_locality.md),
[`docs/cluster_selection_evaluation.md`](docs/cluster_selection_evaluation.md).

---

## Paper Case Study cluster names (reference only — not in LLM prompts)

These are the published cluster labels from the paper. The LLM composes its own
`label` from the closed resolution + modifier + outcome blocks in `common_sense.txt`.

- **CS1**: Pass-First, Collision, Proactive Yield, Late Yield
- **CS2**: Pass-First, Opposite Collision, Yield, Parked Collision
- **CS3**: Smooth Pass, Cut-in Collision, Yield, Brake Rear-end,
  Yield-Stop Collision, Pass-Slowdown
