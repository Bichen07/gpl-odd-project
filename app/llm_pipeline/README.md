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
        └─ 4) selection-eval (always, deterministic) → cross-eval (optional LLM product)
        │
        ▼
llm_pipeline.cli odd-export / odd-rules / odd-join / odd-briefing / odd-chat   ← S2-S5, see below
        └─ boundary export, auditable parameter rules, boundary↔pair join, grounded Q&A briefing + chat
```

| Want | Need first |
|------|------------|
| `medoid` | `clusterN/processed/` from `dataset_builder` |
| `parameter-space-pairs` | both `cluster{A,B}/output/medoid_trial.yaml` + pack `process/context.md` + `synced_bev/` |
| `summary` | this cluster’s medoid **and** `parameter_space_pairs/*/output/contrast.yaml` for every pack that touches the cluster (hard skip / API 400 if missing) |
| `selection-eval` | `cluster.json` at minimum; richer with medoids ± parameter-space packs (no API key) |
| `cross-eval` | medoids (+ summaries preferred) + pair packs; API key unless `--dry-run` |

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
├── parameter_space_pairs/c0-c2/
    ├── pair.json                  # optional metadata for deterministic tools/UI; not fed to LLM
    ├── process/
    │   └── context.md             # ONE shared-clock pair context
    ├── synced_bev/                # dual-panel BEVs + synced_bev_index.json
    ├── output/
    │   └── contrast.yaml          # LLM parameter-space pair analysis
    ├── c0_trial_*/raw/ + processed/action.yaml   # thin sides
    └── c2_trial_*/raw/ + processed/action.yaml
├── cross_cluster/
│   ├── input/cluster_selection_eval.json
│   └── output/cross_cluster_eval.json
└── analysis/
    ├── quality/clustering_quality.json
    ├── odd/{input,output,snapshots}/
    ├── metadata/PAPER_SOURCE.json
    └── logs/{split_analysis_summary.json, odd_chat_log.jsonl, *.log}
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
and keeps `separation_call` grounded. The upstream MFPCA+HDBSCAN clusters use the **whole
trajectory**, so similar trajectory shape does not guarantee the same interaction intent:
matched boundary trials may contain a pass attempt that collides and a yield attempt that
also collides. Pair separation uses the shared conflict window; any unpaired tail is only
an optional boundary-side-versus-medoid consistency check. A two-pass variant (first
pair-only, then medoid-backed separation verdict) is possible, but is not the current
product flow.

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

### 4) Selection / cross-eval / clustering-quality

Three related artifacts answer different questions about **the clustering itself**
(not one trial). Silhouette alone is geometric; these layers judge *behavioral*
partition quality. Design notes:
[`docs/cluster_selection_evaluation.md`](docs/cluster_selection_evaluation.md).

#### What “Cross-cluster analysis” actually does

**One run folder = one clustering result** (one partition of the batch’s trials), e.g.

```text
results/batch8/6_cluster_s=0.6113/     ← this is ONE clustering config
  cluster0/ … cluster5/                ← clusters *inside* that partition
```

**Cross-cluster analysis** is **inter-cluster analysis inside that one folder**.
It does **not** compare `6_cluster_s=0.6113` vs `3_cluster_s=0.8032`.
It asks: *given this partition, are cluster0…cluster5 behaviorally distinct?*
(merge / split / keep / try another *k*). Output:
`$RUN/cross_cluster/output/cross_cluster_eval.json`.

| Concept | Scope | Example |
|---------|--------|---------|
| **Cross-cluster eval** (this button) | **Same** clustering result; compare its clusters to each other | Inside `6_cluster_s=0.6113`, judge C0 vs C1 vs … C5 |
| **“All Clustering Configurations (ranked)”** table | **Different** clustering results for the same batch | Rows = `6_cluster_s=0.5947`, `6_cluster_s=0.6113`, `3_cluster_s=0.8032` |

So the table is a **leaderboard of candidate partitions** (different `k` / silhouette /
HDBSCAN settings → different trial groupings). Each row’s `final_score` comes from
that folder’s `analysis/quality/clustering_quality.json`. If you ran Cross-Cluster Eval on a folder,
its LLM scores are blended into that row (`LLM Eval? = Yes`); other rows stay
“Rule only” until you run eval there too.

Example reading of the dashboard table:

| Rank | Config | Meaning |
|------|--------|---------|
| #1 `6_cluster_s=0.5947` | Different partition than #2 (same *k*=6, different silhouette cut → different grouping). Rule-only so far. |
| #2 `6_cluster_s=0.6113` | The folder you evaluated: rule 58.4 + LLM 50 → final 55. Cross-eval judged *its* six clusters (often “over-split collisions”). |
| #3 `3_cluster_s=0.8032` | Yet another partition (*k*=3). Highest silhouette here ≠ automatically best behavioral score. |

**Not the same as:** per-cluster summary (one cluster’s story) or Parameter-space pair
contrast (one boundary pack). Cross-eval is the **whole-partition** verdict for the
open `$RUN`.

#### Cross-cluster analysis flow, step by step

1. **Select one candidate partition.** The open `$RUN` is one complete clustering
   configuration. Cross-eval does not compare k=3 with k=6 inside one LLM call;
   the ranked configuration table compares those candidate folders afterward.
2. **Build deterministic checks first.** `cluster_selection_eval.py` reads rule-side
   cluster artifacts, medoid motives, and matched-pair metadata without sending
   `cluster.json` to the LLM. It measures outcome purity, medoid motive
   distinctness, parameter-space outcome flips, and merge candidates.
3. **Inspect matched boundaries.** Parameter-space metadata tests whether nearly
   identical initial conditions produce different outcomes, while the saved
   contrast cards explain the behavior and separation call for each pair. A
   medoid is one representative point; boundary evidence is reviewed directly.
4. **Summarize each cluster locally.** The summary product reads the cluster medoid,
   touching parameter-space contrasts, and cluster context. It produces local
   `neighbor_comparison` verdicts and `neighborhood_separation`, including
   `needs_finer_split` for mixed boundary families.
5. **Assemble the global LLM input.** `cross_cluster_evaluator.py` combines narrative
   cluster cards, medoid cards, trajectory-boundary descriptions, parameter-space
   contrast cards, the local neighbor rollup, and the deterministic-check digest.
   Raw cluster tables remain rule-side.
6. **Ask the global LLM judge.** `cross_cluster_prompt.txt` rates behavioral
   separation and boundary clarity, names each archetype, identifies merge/split
   candidates, and recommends `keep`, `merge`, `split`, or `try_other_k`.
   The LLM can recommend a split when one cluster mixes behaviors even if its
   outcome purity is 100%; the medoid is only one representative point.
7. **Blend and rank.** The result is written to
   `cross_cluster/output/cross_cluster_eval.json`.
   `analysis/quality/clustering_quality.json` blends the deterministic score with the LLM
   separation/clarity scores, and `/api/cluster-evaluate` ranks all candidate
   configuration folders. Recompute all candidate folders with the same checks
   before comparing their scores.

#### Dashboard cross-cluster sections

The dashboard’s **Cross-cluster analysis** section is a reader for these
artifacts; it does not re-run clustering:

- **Run Cross-Cluster Eval (LLM)** starts a three-stage job for the currently
  open `$RUN`: (1) write the rule-based
  `cross_cluster/input/cluster_selection_eval.json`, (2)
  make one text-only cross-cluster LLM call, and (3) rescore
  `$RUN/analysis/quality/clustering_quality.json`. The button is wired to
  `POST /api/cluster-evaluate/run`; the Stop button cancels that job, while
  `AnalyzeRunConsole` displays its streamed progress, logs, errors, and
  completion. The global LLM receives narrative text cards only; no new BEV
  images are sent in this stage.
- **All Clustering Configurations (ranked)** lists separate candidate folders,
  not clusters inside one folder. `k` is the number of clusters and
  Silhouette is trajectory/FPC geometry. `Rule Score` is
  `$RUN/analysis/quality/clustering_quality.json.rule_score`, calculated by
  `clustering_quality_scorer.py` from silhouette, collision-rate spread, TTC
  spread, parameter non-overlap, and intra-cluster consistency. It is *not*
  the `selection_score` shown in the Selection Quality panel. `LLM Score` is
  the average of the final LLM’s separation and clarity scores on a 0–100
  scale. `Final Score` is `0.6 × Rule Score + 0.4 × LLM Score` when a complete
  LLM result exists; otherwise it remains rule-only. `LLM Eval?` says whether
  valid separation and clarity values were found.
- **Per-Cluster Intra Variance** shows rule-side spread from
  `cluster.json`/`intra_variance`: mean, standard deviation, maximum distance to
  the cluster medoid, member count, and outlier trial IDs. It describes
  trajectory spread, not behavioral purity by itself.
- **Inter-Cluster Analysis (LLM)** displays fields from
  `$RUN/cross_cluster/output/cross_cluster_eval.json`. `behavioral_separation_score` and
  `boundary_clarity_score` are integer ratings produced by the final
  cross-cluster LLM. `inter_notes` is that same LLM’s overall explanation.
  `merge_candidates` and `split_candidates` are also generated by that final
  LLM after it reads the supplied cluster cards, pair cards, neighbor rollup,
  and deterministic findings. They are not copied directly from a rule
  function, although rule findings can support or contradict them. The LLM
  also produces each cluster’s `archetype`, recommendation, and
  `selection_verdict`. The pipeline attaches `intra_score` afterward from
  rule-side artifacts; that one field is not LLM-generated.
- **Where the Inter-Cluster fields come from:** the dashboard does not
  calculate these values. `cross_cluster_evaluator.py` loads
  `cross_cluster_prompt.txt`, builds the prompt, and calls the configured LLM.
  Its inputs are:
  `cluster_summary.yaml` (earlier per-cluster LLM summaries, with medoid
  fallback), `medoid_trial.yaml` (earlier medoid LLM cards),
  `contrast.yaml` (earlier Parameter-space pair LLM cards),
  `neighbor_comparison` values from earlier cluster summaries,
  deterministic boundary-trial descriptions, and the derived
  `cluster_selection_eval` findings digest. The final response is parsed and
  written to `$RUN/cross_cluster/output/cross_cluster_eval.json`.
- **Boundary Trial Comparison** displays the closest trajectory-embedding pair
  for each cluster boundary. `embedding_dist` is calculated in
  `dataset_builder.py` as the Euclidean distance
  `||X_a - X_b||₂` between the two MFPCA/FPC trajectory vectors. It is a
  shape-similarity distance, not meters, parameter distance, or risk.
  Its deterministic side descriptions come from boundary `description.txt`
  files. The displayed “LLM Boundary Analysis” / “Whole-partition LLM note”
  is `$RUN/cross_cluster/output/cross_cluster_eval.json.inter_notes`; it is the final global LLM
  paragraph, not a new analysis of the selected pair and not the pair’s
  `contrast.yaml`.
- **Selection quality** reads three artifacts with different roles:
  `$RUN/cross_cluster/input/cluster_selection_eval.json` supplies the deterministic component scores,
  `findings`, and `selection_score`; `$RUN/cross_cluster/output/cross_cluster_eval.json` supplies the
  final LLM separation, clarity, verdict, and recommendation; and
  `$RUN/analysis/quality/clustering_quality.json` supplies the rule score, optional LLM score, and
  blended `final_score`. The panel puts these side by side so an analyst can
  see when the rule evidence and the final LLM judgment disagree. Neither
  silhouette nor one medoid alone decides behavioral quality.

#### Selection Quality panel: field-by-field reading

The panel title **“Is this cluster selection good?”** does not mean that one
number proves the partition is correct. It puts three different assessments
next to each other:

- **`deterministic 81.11`** is
  `cross_cluster/input/cluster_selection_eval.json.selection_score`, a 0–100 rule-side
  selection score. In the current implementation it is a weighted,
  renormalized mean of four components:
  `outcome_purity` (0.30), `motive_distinctness` (0.30),
  `parameter_space_pair_decisiveness` (0.25), and
  `no_merge_candidates` (0.15). It is computed without making a new LLM
  request, although it reads some artifacts created by earlier analysis
  stages, such as medoid motives. Thus “independent” in the dashboard means
  “a separate computation with no new LLM call,” not “independent of every
  earlier LLM-produced artifact.” Because the screenshot also contains the
  experimental `boundary_behavior_consistency` row, the displayed 81.11 is
  from a mixed-version saved report and should not be recomputed using only
  the current four-component implementation until `selection-eval` is run
  again.
- **`LLM separation 5/10`** is
  `cross_cluster/output/cross_cluster_eval.json.behavioral_separation_score`. It is produced by
  the final cross-cluster LLM after it reads the cluster narratives, medoid
  cards, Parameter-space contrast cards, neighbor rollup, boundary
  descriptions, and deterministic findings.
- **`LLM boundary clarity 5/10`** is
  `cross_cluster/output/cross_cluster_eval.json.boundary_clarity_score`. It is produced by the
  same final cross-cluster LLM and means how clearly a domain expert could
  distinguish the cluster boundaries from the supplied evidence. It is not
  the numerical `embedding_dist`.
- **`composite 55.03`** is
  `analysis/quality/clustering_quality.json.final_score`. For a complete LLM result, the
  scorer first computes `rule_score` from silhouette, collision-rate spread,
  TTC spread, parameter non-overlap, and intra-cluster consistency. It then
  converts the two LLM ratings to a 0–100 `llm_score` and calculates
  `0.6 × rule_score + 0.4 × llm_score`. With rule score 58.39 and LLM score
  50.0, the result is 55.03. It does not use the deterministic
  `selection_score` directly, so 55.03 cannot be calculated from 81.11.

The component rows explain the deterministic selection score:

- **`outcome_purity = 1.000`** means every cluster has an extreme collision
  rate (near-safe or near-collision). It does not mean every cluster contains
  one behavioral motive.
- **`motive_distinctness = 0.667`** means the usable medoid
  `primary_motive` values contain four distinct codes across six clusters.
  Repeated motives are an over-splitting signal, not automatic proof that
  clusters must merge.
- **`parameter_space_pair_decisiveness = 0.556`** means 5 of 9
  near-identical-input pairs flip collision outcome across a cluster
  boundary. The numerator and denominator come from `pair.json`; the LLM
  contrast explanation is separate evidence.
- **`no_merge_candidates = 1.000`** means the strict rule found no pair that
  simultaneously shared a motive, had collision rates within 10 percentage
  points, and had highly overlapping parameter ranges.

If an existing dashboard shows a
**`boundary_behavior_consistency = 0.833`** row with an empty explanation,
that row is from an older experimental `cluster_selection_eval.json`. The
current `cluster_selection_eval.py` does not define that component, and
`SelectionQualityPanel` renders component keys generically, so it displays
the stale key but has no current help text for it. The 0.833 value should not
be treated as part of the current supported selection score until that check
is intentionally reintroduced and documented. The related finding about
“medoid/boundary behavior-family mismatches” is likewise from that older
artifact, not from the current four-component rule evaluator.

Finally, **Cross-cluster verdict (LLM)** is not another deterministic score.
`selection_verdict`, `recommended_action`, `merge_candidates`, and
`split_candidates` are fields generated by the final cross-cluster LLM. For
example, a recommendation to merge C2 and C3 is an LLM recommendation
supported by the supplied `over_fine` pair evidence; it is not an automatic
merge operation. An analyst should inspect the referenced pair contrast and
cluster summaries before changing the partition.

**Hard rule:** `cluster*/raw/cluster.json` is **rule-only**. It is never pasted into
an LLM prompt. Rule code may *read* it to compute scores; the LLM only sees
**narrative cards** (medoid / summary / contrast) plus **derived** selection-eval
findings (score, components, findings text) — not the raw JSON fields.

```text
                    RULE-ONLY (no tokens)              LLM (needs API key / tokens)
                    ─────────────────────              ────────────────────────────
cluster.json ──┐
medoid YAML ───┼─► selection-eval ──► cluster_selection_eval.json
pair.json ─────┘         │                    │
                         │ findings digest ───┼──► {deterministic_checks}
medoid / summary /       │                    ├──► {medoid_cards}
  contrast / neighbor ───┼────────────────────┼──► {cluster_summaries} (narrative only)
  rollup / boundary ─────┘                    ├──► {parameter_space_pair_cards}
                                              ├──► {neighbor_rollup}
                                              └──► {boundary_trial_pairs}
                                                         │
                                                         ▼
                                              cross_cluster_eval.json  (LLM)
                                                         │
cluster.json (again, rule) + optional LLM scores ──► clustering_quality.json
                                                         │
                         GET /api/cluster-evaluate       ▼
              ranks ALL batch*/<k>_cluster_s=*/ folders by final_score
              (dashboard “All Clustering Configurations”)
```

**What those two prompt slots mean**

| Slot | Meaning |
|------|---------|
| `{deterministic_checks}` | Text digest from `digest_for_prompt()` over **already-computed** `cross_cluster/input/cluster_selection_eval.json`: `selection_score`, component scores, `primary_motives`, `merge_candidates`, and `findings[]`. Rule numbers the LLM may cite — **not** a dump of `cluster.json` rows. |
| `{neighbor_rollup}` | Text from `neighbor_rollup_digest()`: for every cluster that has `cluster_summary.yaml`, copy that summary’s local `neighbor_comparison[]` / `distinct_from_neighbors` / `motive_consistency_note`. Those verdicts were written earlier by the **summary** LLM product (Stage B); cross-eval cites them instead of re-judging every neighbor from scratch. Empty until summaries exist. |

**All paths / context used in this stage** (under `$RUN/`, e.g. `results/batch8/6_cluster_s=0.6113/`):

| Path | What it is | Used by | How used |
|------|------------|---------|----------|
| `clusterN/raw/cluster.json` | Analyzer cluster stats (size, `collision_rate`, TTC, param ranges, silhouette-related fields) | **Rule only:** selection-eval, clustering-quality; cross-eval loads it only to attach post-parse `intra_score` | **Never** pasted into the LLM prompt |
| `clusterN/output/medoid_trial.yaml` | Medoid LLM card (motives, outcome, conflict metrics, timeline) | **Rule:** selection-eval (`primary_motive`); **LLM:** `{medoid_cards}`, and fallback narrative for `{cluster_summaries}` | Digest / narrative fields only |
| `clusterN/output/cluster_summary.yaml` | Per-cluster summary LLM card (`label`, `caption`, `risk_level`, `neighbor_comparison[]`, …) | **LLM:** `{cluster_summaries}` narrative; `{neighbor_rollup}` | Narrative / neighbor verdicts only |
| `parameter_space_pairs/cA-cB/pair.json` | Pack metadata (matched ICs, `collided_a`/`collided_b`, trial ids) | **Rule only:** selection-eval (pair flip / merge heuristics) | **Not** in cross-eval prompt |
| `parameter_space_pairs/cA-cB/output/contrast.yaml` | Pair contrast LLM card (`separation_call`, motives, explanation) | **LLM:** `{parameter_space_pair_cards}` | Contrast fields only (no `pair.json` dump) |
| `manifest.json` → `trajectory_projection_pairs` (legacy: `boundary_pairs`) | Index of MFPCA-near pairs across clusters | **LLM:** discovers which `{boundary_trial_pairs}` to load | Metadata + pointers |
| `trajectory_projection_pairs/cA-cB/…/description.txt` (or legacy `clusterN/.../boundary_c*/…/description.txt`) | Deterministic text description of each boundary-side trial | **LLM:** `{boundary_trial_pairs}` body (+ collided flags from manifest) | Description text only |
| `$RUN/cross_cluster/input/cluster_selection_eval.json` | Rule output of selection-eval | Written by rule; **LLM** sees only its digest as `{deterministic_checks}` | Derived findings, not raw inputs |
| `$RUN/cross_cluster/output/cross_cluster_eval.json` | Cross-eval LLM (or stub) output | Written by LLM path; **Rule** clustering-quality may blend its scores | Output of this stage |
| `$RUN/analysis/quality/clustering_quality.json` | Rule ranking score (`rule_score` ± blend) | Written by `score_run_dir()` | Ranking / dashboard; not an LLM input |

| Artifact | Kind | Tokens? | When it runs |
|----------|------|---------|----------------|
| `cross_cluster/input/cluster_selection_eval.json` | **Rule** | no | End of every `cluster-interpret`; first step of `cross-eval` / CLI `selection-eval` |
| `cross_cluster/output/cross_cluster_eval.json` | **LLM** (stub if dry-run / no key) | **yes** (text-only; no images) | Product `cross-eval`; CLI `cross-cluster-eval`; dashboard **Run Cross-Cluster Eval** |
| `analysis/quality/clustering_quality.json` | **Rule** (+ optional blend of LLM scores already on disk) | no new LLM call | After dataset build; after `cross-eval` rescore; CLI `cross-cluster-eval` |

None of these three files are fed into medoid / pair / summary prompts.

```bash
# Rule only — no API key
python -m llm_pipeline.cli selection-eval --run-dir "$RUN"

# LLM cross-eval (writes selection-eval first, then rescores clustering_quality.json)
python -m llm_pipeline.cli cross-cluster-eval --run-dir "$RUN" --model gemini-2.5-flash

python -m llm_pipeline.cli cluster-interpret \
  --results-dir "$RUN" --batch-id 8 --products cross-eval
```

### `cross_cluster/input/cluster_selection_eval.json` — **rule-based** behavioral check

**Purpose:** countable “is this a good *behavioral* decomposition?”
**No LLM, no API key, no images.**

**Reads (rule-side only):**

- `cluster*/raw/cluster.json` — `collision_rate`, `parameter_ranges`, sizes
- `cluster*/output/medoid_trial.yaml` — `primary_motive` (ignores `unclear`)
- `parameter_space_pairs/*/pair.json` — matched pairs + `collided_a` / `collided_b`

**Components** (each in `[0,1]`, weighted → `selection_score` 0–100; missing → renormalize):

| Component | Weight | Formula / rule |
|-----------|--------|----------------|
| `outcome_purity` | 0.30 | Fraction of clusters with `collision_rate ≤ 5%` or `≥ 95%` |
| `motive_distinctness` | 0.30 | `#distinct primary_motive / #clusters with a usable motive` |
| `parameter_space_pair_decisiveness` | 0.25 | Fraction of matched pairs whose collision outcomes **flip** |
| `no_merge_candidates` | 0.15 | `1.0` unless same motive + rates within 10 pp + param Jaccard ≥ 0.8 |

**Main fields:** `selection_score`, `components`, `weights`, `evaluated_components`,
`primary_motives`, `mixed_outcome_clusters`, `merge_candidates`, `parameter_space_pairs`,
`mean_param_overlap`, `findings`.

**What the LLM may see later:** only `digest_for_prompt()` — score, components,
findings, merge_candidates, primary_motives. **Not** a dump of `cluster.json`.

### `cross_cluster/output/cross_cluster_eval.json` — **LLM** partition verdict

**Scope:** one `$RUN` only — **inter-cluster** (are *these* clusters distinct?),
not a comparison across different `k_cluster_s=…` folders.

**Implemented.** Product `cross-eval` (aliases `cross_eval`, `selection`).
**Needs tokens** unless `--dry-run` / missing key (then stub with `stub: true`).

**Always runs selection-eval first (rule), then one text-only LLM call.**

| Prompt slot | Source (see path table above) | Raw `cluster.json`? |
|-------------|--------------------------------|---------------------|
| `{cluster_summaries}` | Narrative from `cluster_summary.yaml` (fallback medoid caption/label) | **no** |
| `{medoid_cards}` | `medoid_digest` ← `medoid_trial.yaml` | no |
| `{parameter_space_pair_cards}` | `contrast.yaml` digests | no |
| `{neighbor_rollup}` | Per-cluster `neighbor_comparison` / `distinct_from_neighbors` from summaries | no |
| `{boundary_trial_pairs}` | `manifest` pairs + side `description.txt` (+ collided flag) | no |
| `{deterministic_checks}` | selection-eval findings digest (`selection_score`, components, findings, merges) | no (derived only) |

**LLM output:** `behavioral_separation_score`, `boundary_clarity_score` (1–10),
`inter_notes`, archetypes, merge/split lists, `recommended_action` ∈
{`keep`,`merge`,`split`,`try_other_k`}, `selection_verdict`.
Pipeline may attach rule-based `intra_score` **after** parse (from artifacts; not LLM).

**Dashboard:** Cluster analysis → Cross-cluster analysis → Run Cross-Cluster Eval (LLM)
on the **currently open** folder. The ranked table below that button is a separate
view: all batch folders scored for picking *which* partition to use.

**Is this enough without raw rates in the prompt?** Yes for a *behavioral* verdict:
medoid motives/outcomes + summary captions + pair separation calls + neighbor rollup +
selection-eval findings already encode purity/flips/merge signals. Raw silhouette /
param ranges / TTC digests stay in rule scoring (`clustering_quality` /
`selection-eval`), which the LLM is told not to recompute.

### `analysis/quality/clustering_quality.json` — **rule-based** ranking score (per folder)

**Purpose:** one number **per** `$RUN` so the dashboard can rank **different**
`k_cluster_s=…` candidates under the same batch (not inter-cluster labels).
**No LLM call** here; may *read* that folder’s existing
`cross_cluster/output/cross_cluster_eval.json` to blend.

**`rule_score` (0–100)** from `cluster.json` (weights sum to 1.0):

| Sub-score | Weight | Idea |
|-----------|--------|------|
| `silhouette_score` | 0.25 | `(sil + 1) / 2` clipped to `[0,1]` |
| `collision_spread_score` | 0.20 | std of cluster collision rates / 50 pp |
| `ttc_spread_score` | 0.15 | std of mean TTC / 3 s |
| `param_nonoverlap_score` | 0.15 | fraction of params with fully non-overlapping ranges |
| `intra_consistency_score` | 0.25 | mean intra consistency (YAML if present, else `std_dist_to_medoid`) |

**Optional blend** (only if non-stub cross-eval has both scores):

```text
llm_score   = mean(separation, clarity) * 10     # → 0–100  (from prior LLM file)
final_score = 0.6 * rule_score + 0.4 * llm_score
```

Otherwise `final_score = rule_score`, `llm_score = null`, `has_llm_eval = false`.
`rank` is filled by `GET /api/cluster-evaluate` when listing all folders for a batch
(“All Clustering Configurations (ranked)”).

---

## Dashboard Report — panels E / F / G

Analyze → **Report** tab (`panels/Report`) loads one read-only DTO from
`GET /api/cluster-run-report?batchId=…&folder=…` (`app/dashboard/.../api/cluster-run-report/route.ts`).
No LLM call in that request — it only aggregates files already on disk under `$RUN`.

```text
$RUN/
├── cluster_selection_eval.json     → panel F (Clustering Trust)
├── parameter_space_pairs/*/        → panels D + G (pair evidence + next tests)
│     pair.json + output/contrast.yaml
├── odd_boundary_export.json        → panel E chips (S2)
├── odd_parameter_rules.json        → panel E rules table (S3)
└── odd_boundary_pairs_join.json    → panel E “pairs touch the boundary” chip (S4)
```

### F — Clustering Trust

**UI title:** “Clustering Trust” (comment in code still says “Merge / Split Advice”).

**Data source:** `$RUN/cross_cluster/input/cluster_selection_eval.json` (written by `selection-eval` /
`cluster_selection_eval.write_eval` — see §4 above). The API maps:

| API field | JSON field |
|-----------|------------|
| `mergeCandidates` | `merge_candidates` |
| `selectionFindings` | `findings` |

**What each line means** (matches your example):

1. **“No merge candidates — all clusters appear sufficiently distinct.”**
   `merge_candidates` is empty. A merge candidate is only emitted when two clusters share
   the same medoid `primary_motive`, collision rates within 10 pp, **and** mean parameter-range
   Jaccard overlap ≥ 0.8. Empty list → green success alert. Non-empty → warning listing each pair.

2. **Bullet list (`selectionFindings`)** — verbatim `findings[]` strings from the deterministic
   evaluator, e.g.:
   - *“All 6 clusters are outcome-pure…”* → every cluster’s `collision_rate` is ≤5% or ≥95%
     (`outcome_purity`).
   - *“Repeated primary motives: assertive_gap_acceptance in clusters 1, 2, 5…”* →
     `motive_distinctness` found the same medoid motive on multiple clusters (over-split signal,
     not proof — medoid-only / LLM-noisy).
   - *“5 of 9 near-identical-Parameter-space pairs flip outcome…”* →
     `parameter_space_pair_decisiveness` counted outcome flips on matched packs.

The button “View detailed cluster analysis →” jumps to the Cluster analysis tab (selection /
cross-eval UI), not to a different file.

### G — Recommended Next Tests

**Pure client-side heuristics** on the report DTO — nothing new is written to disk. Computed in
`Report` panel after fetch:

```ts
highFailNoContrast = clusters with collisionRate > 10%
  AND no parameter_space_pairs pack that both touches this cluster AND has contrast.yaml

inconclusivePairs = pairs where
  contrast.separation_call === "inconclusive"
  OR (hasContrast && separation_call is missing)
```

**What each line means** (matches your example):

| Line | Meaning |
|------|---------|
| “Deterministic priorities based on current analysis gaps.” | Static subtitle — these rules are not LLM advice. |
| **Inconclusive pair separations: c1-c5, c2-c5, …** | Folder names of packs whose `contrast.yaml` set `separation_call: inconclusive` (or has a contrast but no call). LLM could not decide justified vs over_fine. |
| “Re-examine these pairs…” | Fixed caption under that alert — action hint for Parameter-space pair analysis. |
| **High-collision clusters without pair contrast: …** (if shown) | Cluster collision rate &gt; 10% and no touching pack has a saved `contrast.yaml` yet. |
| Green “All high-collision…” | Both lists empty. |

`separation_call` itself comes from the pair LLM product (`contrast.yaml`), not from
selection-eval. Re-run Parameter-space pair analysis (or edit/re-prompt) to change these rows.

### E — ODD Boundary Export & Parameter Rules

Surfaces **S2 + S3 + S4** artifacts (details in the next section). Still read-only via
`cluster-run-report`.

| UI element | Source file / field |
|------------|---------------------|
| `kNN = …` | `analysis/odd/output/odd_boundary_export.json` → `kNN` |
| `KPI: …` | `kpi.name` (usually collision) |
| `N on collision boundary` | `len(collision_boundary.boundary_trials)` — neighbors differ in pass/fail |
| `N on cluster boundary` | `len(cluster_boundary.boundary_trials)` — neighbors differ in cluster label |
| `n=… trials considered` | `n_trials_considered` |
| `… trials outside clustering fit` | `n_trials_without_cluster_label` |
| `X/Y pairs touch the boundary` | `analysis/odd/output/odd_boundary_pairs_join.json` → `n_pairs_touching_boundary` / `n_pairs` (S4) |
| Rules table (predicate, predicts, support, precision, boundary hits) | `analysis/odd/output/odd_parameter_rules.json` (S3 CART leaves) |

**How to produce the files** (panel shows “Not yet exported” / “Parameter rules not yet
available” until these exist):

```bash
python -m llm_pipeline.cli odd-export --run-dir "$RUN"   # or Explore → Filtering → Export ODD boundary
python -m llm_pipeline.cli odd-rules  --run-dir "$RUN"   # needs odd_all_trials.json from S2
python -m llm_pipeline.cli odd-join   --run-dir "$RUN"   # optional chip: pairs ∩ boundary trials
```

**Important metric note (also shown under the chips):** S2 distances use Explore’s
**min–max normalized** kd-tree metric. Parameter-space pairs use **z-scored** L2. Do not
compare those distance numbers to each other. S4 joins by **trial id**, never by distance.

---

## S2–S5 — ODD boundary export, rules, join & Q&A

These four steps run **after** medoid + parameter-space-pairs + summary (above) are done for a
run. They never re-touch `medoid_trial.yaml` / `contrast.yaml` / `cluster_summary.yaml` — S2-S5
only *read* those plus the raw clustering result, and write new files under `analysis/`. Full
design rationale: `implementation_plan.md` §6 (S2/S3), §7 (S5), §9 (build checklist).

### Output locations

All paths below are relative to `$RUN`:

```text
$RUN/
├── clusterN/output/
│   ├── medoid_trial.yaml                  # existing S1 medoid LLM output
│   └── cluster_summary.yaml               # existing S1 summary LLM output
├── parameter_space_pairs/cA-cB/output/
│   └── contrast.yaml                      # existing S1 pair LLM output
├── cross_cluster/
│   ├── input/cluster_selection_eval.json  # deterministic selection input
│   └── output/cross_cluster_eval.json     # optional whole-partition LLM output
└── analysis/
    ├── quality/clustering_quality.json    # composite quality score
    ├── odd/
    │   ├── input/odd_all_trials.json      # S2 all-trial input for S3
    │   ├── output/
    │   │   ├── odd_boundary_export.json
    │   │   ├── odd_parameter_rules.json
    │   │   ├── odd_boundary_pairs_join.json
    │   │   └── odd_chat_briefing.json
    │   └── snapshots/odd_boundary_export.kNN<k>.json
    ├── metadata/PAPER_SOURCE.json
    └── logs/
        ├── split_analysis_summary.json
        ├── odd_chat_log.jsonl
        └── *.log
```

`cross_cluster/` is kept at the run root because it is a primary analysis
stage. `analysis/` groups derived quality, ODD, provenance, and log artifacts.

```text
$RUN/clusterN/output/{medoid_trial.yaml, cluster_summary.yaml}   ← already exist (Products 1/3)
$RUN/parameter_space_pairs/cA-cB/output/contrast.yaml             ← already exist (Product 2)
        │
        ▼
S2  odd-export     (deterministic, needs the saved Payload analysis zip)
        │            → $RUN/analysis/odd/output/odd_boundary_export.json
        │              $RUN/analysis/odd/input/odd_all_trials.json
        │              $RUN/analysis/odd/snapshots/odd_boundary_export.kNN<k>.json
        ▼
S3  odd-rules      (deterministic, sklearn CART, offline)
        │            → $RUN/analysis/odd/output/odd_parameter_rules.json
        ▼
S4  odd-join       (deterministic, offline — trial-id join only, never a distance-metric join)
        │            → $RUN/analysis/odd/output/odd_boundary_pairs_join.json
        ▼
S5a odd-briefing   (deterministic, offline — assembles the fixed knowledge base)
        │            → $RUN/analysis/odd/output/odd_chat_briefing.json
        ▼
S5b odd-chat       (ONE LLM call per question — the only step here that calls an LLM)
        │            → prints {answer, citations, model, dry_run}; appends a line to
        └─           $RUN/analysis/logs/odd_chat_log.jsonl
```

Run all five for one folder:

```bash
conda activate analyzer
export PYTHONPATH="app/llm_pipeline/python:app/analyzer/src"
RUN=results/batch8/3_cluster_s=0.8032

python -m llm_pipeline.cli odd-export   --run-dir "$RUN" --kNN 10   # needs network (Payload zip) or --analysis-zip
python -m llm_pipeline.cli odd-rules    --run-dir "$RUN"
python -m llm_pipeline.cli odd-join     --run-dir "$RUN"
python -m llm_pipeline.cli odd-briefing --run-dir "$RUN"
python -m llm_pipeline.cli odd-chat --run-dir "$RUN" \
  --question "What is the weakness of this AV system?"   # needs GOOGLE_API_KEY/OPENAI_API_KEY, or --dry-run
```

### S2 — `odd_export.py` (ODD boundary export)

Python twin of the Explore "Filtering" panel's **Export ODD boundary** button
(`app/dashboard/.../explore/lib/boundaryExport.ts`) — same algorithm, callable from a terminal
with no browser. Builds a kd-tree over min-max-normalized scenario parameters (same metric as
Explore's Filtering distance; **not** the z-scored L2 used by `parameter_space_pairs` — see
`implementation_plan.md` §2.2 A2/A4) and finds each trial's `kNN` nearest neighbors.

Writes:

- `$RUN/analysis/odd/output/odd_boundary_export.json` — latest boundary export.
- `$RUN/analysis/odd/input/odd_all_trials.json` — complete trial table for S3.
- `$RUN/analysis/odd/snapshots/odd_boundary_export.kNN<k>.json` — kNN-specific snapshot.

| Output | Meaning |
| --- | --- |
| `collision_boundary` | trial pairs whose KPI (`collision`) pass/fail differs, both trials clustered |
| `cluster_boundary` | trial pairs whose cluster label differs, both trials clustered |
| `n_trials_without_cluster_label` | trials in the saved analysis that never got a cluster label from HDBSCAN/MFPCA (e.g. below min trajectory-duration cutoff) |
| `analysis/odd/input/odd_all_trials.json` | every trial's scenario parameters + pass/fail + cluster label — the S3 CART training table |
| `analysis/odd/snapshots/odd_boundary_export.kNN<k>.json` | dated snapshot, so re-exporting with a different `--kNN` doesn't destroy the previous sweep point |

Key functions (`llm_pipeline/odd_export.py`): `fetch_ego_data` (reuses
`dataset_builder._fetch_payload_analysis` — the live Payload `Trial` REST collection is empty
for this dataset; trial parameters/KPIs only exist inside the saved analysis zip), `build_trial_table`,
`compute_boundaries` (pure port of `boundaryExport.ts`), `export_run_dir` (writes all 3 files).

```bash
python -m llm_pipeline.cli odd-export --run-dir "$RUN" --kNN 10 [--analysis-zip path/to/x.zip]
```

### S3 — `odd_rules.py` (parameter rules)

Fits a **shallow** (`max_depth=3` by default) `sklearn.tree.DecisionTreeClassifier` on
`$RUN/analysis/odd/input/odd_all_trials.json` to predict `fail = not passed` from scenario parameters, then walks every
root→leaf path into a human-readable AND-predicate. Deliberately shallow: the goal is an
*auditable* rule an engineer can read, not maximum accuracy (XAI interpretable-by-design choice
— see `implementation_plan.md` §6.4). A depth ablation (1–4) on `batch8/3_cluster_s=0.8032`
confirmed depth 3 is the accuracy/readability sweet spot (§9 S3 "C2").

These rules are **hypotheses about the sampled trials**, never presented as a certified SAE
J3016 ODD boundary — `$RUN/analysis/odd/output/odd_parameter_rules.json` carries an explicit `limitations` list
saying so, and the chat system prompt (below) is instructed never to call them "the ODD".

```bash
python -m llm_pipeline.cli odd-rules --run-dir "$RUN" [--max-depth 3] [--min-samples-leaf 10]
```

### S4 — `odd_join.py` (boundary ↔ pairs join)

Joins S2's boundary trial ids with `parameter_space_pairs/*/pair.json` **by trial id
membership only** — never by comparing `odd_boundary_export.json`'s min-max distance against
`pair.json`'s z-scored distance, which are different metrics over the same features (would be a
silent unit error). Output: which pair packs have at least one endpoint that is also a boundary
trial, and each pack's already-written `contrast.yaml` verdict if present. It writes
`$RUN/analysis/odd/output/odd_boundary_pairs_join.json`.

```bash
python -m llm_pipeline.cli odd-join --run-dir "$RUN"
```

### S5a — `odd_briefing.py` (deterministic knowledge base)

No LLM call. Reads every artifact above (`cluster.json`, `medoid_trial.yaml`,
`cluster_summary.yaml`, `parameter_space_pairs/*/pair.json` + `contrast.yaml`,
`$RUN/analysis/odd/output/odd_boundary_export.json`,
`$RUN/analysis/odd/output/odd_parameter_rules.json`,
`$RUN/analysis/odd/output/odd_boundary_pairs_join.json`,
`$RUN/cross_cluster/input/cluster_selection_eval.json`) and assembles one compact JSON —
`$RUN/analysis/odd/output/odd_chat_briefing.json` — that
S5b's chat is only ever allowed to cite numbers/ids from. Long free-text fields (captions,
consistency notes, contrast explanations) are truncated to ~320 chars each to keep the whole
file in the ~8–15k token budget from `implementation_plan.md` §7.5 (measured 1.7–2.7k tokens on
the three reference runs). Anything the builder could not find is recorded verbatim in a
`missing: [...]` list (e.g. `"no odd_parameter_rules.json — run S3"`) — the chat system prompt
is instructed to say "unknown, run step X" for anything covered by that list instead of guessing.

```bash
python -m llm_pipeline.cli odd-briefing --run-dir "$RUN"
```

### S5b — `odd_chat.py` (the ODD Q&A system) — detailed

This is the part end users interact with (via the CLI above, or the dashboard panel described
below). It answers natural-language questions like *"What is the weakness of this AV system?"*,
*"Which condition leads to a high failure probability?"*, *"Which scenario should we test
next?"*, *"Why keep these clusters separate?"* — grounded **only** in one run's
`analysis/odd/output/odd_chat_briefing.json`.

**Is this full RAG?** No — it is *grounded prompting / "light RAG"*: one fixed, deterministically
built JSON document is attached (a subset chosen by keyword routing, not vector search), not a
retrieval index over a large corpus. See `implementation_plan.md` §2.4 for why this distinction
must stay explicit in the thesis.

**Do you need to log in to a ChatGPT / Gemini account?** **No.** There is no OAuth/browser login
anywhere. The system calls the provider's API server-side, the same way Medoid/Pair/Summary
analysis already does, via `llm_factory.py`. What it needs is an **API key**:

| Where the key comes from | How |
| --- | --- |
| CLI | `--api-key <key>` flag, or `GOOGLE_API_KEY` / `OPENAI_API_KEY` env var already exported in the shell |
| Dashboard panel | Optional "API key (ephemeral)" text field in the ODD Q&A tab — sent to the server for that one request only (as a spawned-process env var), never written to disk or logged; if left blank, the dashboard server's own `GOOGLE_API_KEY`/`OPENAI_API_KEY` env var is used |
| Neither set | `answer()` runs in **dry-run** mode automatically — no LLM call, returns a placeholder string naming which sources it *would* have cited, and still logs the turn (`dry_run: true`) |

Model choice follows the model name prefix — `gemini-*` → `GOOGLE_API_KEY`, `gpt-*`/`o*` →
`OPENAI_API_KEY` (same convention as `cluster-analyze/run`). Default model: `gemini-2.5-flash`.

**What is fed to the LLM on every turn** (`odd_chat.py::build_messages`):

1. `prompt_templates/odd_chat_system_prompt.txt` — loaded by `odd_chat.py` as `SYSTEM_PROMPT`;
   it defines the fixed role + hard rules: cite only the briefing, say "unknown" for
   anything in `missing`, keep deterministic facts (collision_rate, support, precision) and
   LLM-authored interpretation (motive, caption, separation_call) verbally distinguished, never
   call the S3 rules "the ODD", always end with a `Sources: …` line.
2. A **routed slice** of `analysis/odd/output/odd_chat_briefing.json` — see router table below. Never the whole
   file (keeps the prompt small and forces the router to actually pick relevant evidence).
3. The last **8** dialog turns (configurable via `max_history_turns`), reconstructed as
   alternating user/assistant messages.
4. The new user question.

It never sees raw trajectories, full BEV frames, or the full `context_medoid.md` / pair
`process/context.md` timelines — those are summarized once already, at S1/Product-3 (`caption`)
time; re-attaching raw text every chat turn would blow the token budget and reintroduce the
self-reinforcement risk the whole pipeline was designed to avoid (`implementation_plan.md` §2.2).

**Intent router** (`classify_intent` + `route`, keyword/regex v1 — embeddings intentionally not
built, v1 scope said optional in §7.6):

| Question mentions | Routed intent | Briefing sections attached |
| --- | --- | --- |
| `cluster N` / `cA-cB` | (direct reference) | that cluster + touching pairs only |
| "weak", "failure mode", "worst", "problem" | `weakness` | top-3 clusters by collision rate + first 5 pairs |
| "fail condition", "odd", "limit", "high probability" | `fail_conditions` | `rules` + `boundary` sections |
| "test next", "what to test", "coverage" | `what_next` | `boundary`, `rules`, `merge_candidates`, `pairs_touching_boundary` |
| "merge", "why cluster", "separat…" | `why_clustering` | cluster separation notes + pair `separation_call`s + `merge_candidates` |
| (none of the above) | `other` | run header + all cluster ids/labels/collision rates |

**Does the conversation have memory, and is it saved?**

Yes to both, but the two are different mechanisms:

- **Short-term dialog memory** (per the router above) — the last 8 turns are replayed to the LLM
  every time so it can resolve "that cluster" / follow-ups, but the fixed briefing is
  **re-attached fresh every turn** so an earlier hallucination can never silently become
  "remembered fact" in a later turn.
- **Persistent conversation log** — every call to `answer()` (CLI or dashboard, `log=True` by
  default) appends one JSON line to `$RUN/analysis/logs/odd_chat_log.jsonl`. Each line includes
  a `conversation_id`, so multiple independent conversations can share one run:

  ```json
  {"timestamp": "2026-08-21T07:40:12Z", "conversation_id": "default", "question": "...", "answer": "...",
   "citations": ["cluster0/summary", "pair c0-c2"], "model": "gemini-2.5-flash",
   "dry_run": false, "briefing_generated_at": "2026-08-21T07:12:03Z"}
  ```

  This file is a plain artifact in the run folder — not browser `localStorage`, not a database.
  The dashboard lists conversations derived from this file, and its **New conversation** button
  creates a new id. Existing entries without `conversation_id` are treated as the `default`
  conversation for backward compatibility.

**Function-by-function reference** (`llm_pipeline/odd_chat.py`):

| Function | Role |
| --- | --- |
| `load_briefing(run_dir)` | Reads `analysis/odd/output/odd_chat_briefing.json`; raises with a clear "run S5a first" message if missing |
| `classify_intent(question)` | Regex keyword match → one of `weakness` / `fail_conditions` / `what_next` / `why_clustering` / `other` |
| `_extract_cluster_ids` / `_extract_pair_folders` | Pulls literal `cluster N` / `cA-cB` mentions out of the question text |
| `route(question, briefing) -> RoutedContext` | Combines the above into the actual `{context, citations}` slice attached this turn |
| `build_messages(briefing, question, history, max_history_turns=8)` | Assembles the full `[system, briefing, ...history, question]` message list + citations, ready for the LLM client |
| `answer(run_dir, question, *, model, api_key, temperature, history, dry_run, log)` | Top-level entry point: loads briefing → builds messages → calls `llm_factory.create_interpretation_llm` (skipped if `dry_run` or no credentials) → optionally appends to the log → returns `{answer, citations, model, dry_run}` |
| `_append_log(run_dir, question, result, briefing)` | Writes the one persisted JSONL line described above |

**CLI:**

```bash
python -m llm_pipeline.cli odd-chat --run-dir "$RUN" \
  --question "Which scenario should we test next?" \
  --model gemini-2.5-flash \
  [--api-key ...] [--history-json /path/to/turns.json] [--dry-run] [--no-log]
```

**Dashboard UI (ODD Q&A tab):**

- `GET /api/odd-chat?batchId=&folder=` — reads `analysis/odd/output/odd_chat_briefing.json`'s `missing` list plus
  `analysis/logs/odd_chat_log.jsonl` back into a `history` array; the panel calls this on mount so previously
  asked questions are shown immediately, before the user asks anything new.
- `POST /api/odd-chat` — body `{batchId, folder, conversationId?, question, model?, apiKey?}`; the route
  reconstructs the last-8-turn history for the selected conversation straight from
  `analysis/logs/odd_chat_log.jsonl` (so the browser never has to manage conversation state itself),
  writes it to a temp file, then spawns
  `scripts/run_odd_chat.sh` (same analyzer-conda-env pattern as `scripts/run_cluster_analyze.sh`)
  → `python -m llm_pipeline.cli odd-chat`. The CLI process itself appends the new turn to
  `analysis/logs/odd_chat_log.jsonl` — the Next.js route never writes conversation state directly, so the
  terminal and the browser can never disagree about what was asked.
- `OddChatPanel` (in `AnalyzeClient.tsx`) — model dropdown, ephemeral API-key field, scrollable
  message log with citation chips per answer, question box. Independent of the Medoid/Pair tabs'
  model+key state (see `implementation_plan.md` §9.3 for why).

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
| `odd_export.py` | S2 — kd-tree kNN boundary export (Python twin of Explore's Filtering button) |
| `odd_rules.py` | S3 — shallow CART → auditable parameter rules |
| `odd_join.py` | S4 — boundary-trial ↔ parameter-space-pair join (by trial id only) |
| `odd_briefing.py` | S5a — deterministic `odd_chat_briefing.json` builder (no LLM) |
| `odd_chat.py` | S5b — grounded Q&A over the briefing (one LLM call per question) + `odd_chat_log.jsonl` |
| Dashboard `api/odd-chat/route.ts` | GET (history) / POST (ask) — thin wrapper around `scripts/run_odd_chat.sh` |
| `scripts/run_odd_chat.sh` | Activates the `analyzer` conda env, `exec`s `python -m llm_pipeline.cli odd-chat` |

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
