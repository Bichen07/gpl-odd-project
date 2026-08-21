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

## S2–S5 — ODD boundary export, rules, join & Q&A

These four steps run **after** medoid + parameter-space-pairs + summary (above) are done for a
run. They never re-touch `medoid_trial.yaml` / `contrast.yaml` / `cluster_summary.yaml` — S2-S5
only *read* those plus the raw clustering result, and write new files alongside them. Full
design rationale: `implementation_plan.md` §6 (S2/S3), §7 (S5), §9 (build checklist).

```text
$RUN/clusterN/output/{medoid_trial.yaml, cluster_summary.yaml}   ← already exist (Products 1/3)
$RUN/parameter_space_pairs/cA-cB/output/contrast.yaml             ← already exist (Product 2)
        │
        ▼
S2  odd-export     (deterministic, needs the saved Payload analysis zip)
        │            → $RUN/odd_boundary_export.json, odd_all_trials.json, odd_boundary_export.kNN<k>.json
        ▼
S3  odd-rules      (deterministic, sklearn CART, offline)
        │            → $RUN/odd_parameter_rules.json
        ▼
S4  odd-join       (deterministic, offline — trial-id join only, never a distance-metric join)
        │            → $RUN/odd_boundary_pairs_join.json
        ▼
S5a odd-briefing   (deterministic, offline — assembles the fixed knowledge base)
        │            → $RUN/odd_chat_briefing.json
        ▼
S5b odd-chat       (ONE LLM call per question — the only step here that calls an LLM)
        │            → prints {answer, citations, model, dry_run}; appends a line to
        └─           $RUN/odd_chat_log.jsonl
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

| Output | Meaning |
| --- | --- |
| `collision_boundary` | trial pairs whose KPI (`collision`) pass/fail differs, both trials clustered |
| `cluster_boundary` | trial pairs whose cluster label differs, both trials clustered |
| `n_trials_without_cluster_label` | trials in the saved analysis that never got a cluster label from HDBSCAN/MFPCA (e.g. below min trajectory-duration cutoff) |
| `odd_all_trials.json` | every trial's scenario parameters + pass/fail + cluster label — the S3 CART training table |
| `odd_boundary_export.kNN<k>.json` | dated snapshot, so re-exporting with a different `--kNN` doesn't destroy the previous sweep point |

Key functions (`llm_pipeline/odd_export.py`): `fetch_ego_data` (reuses
`dataset_builder._fetch_payload_analysis` — the live Payload `Trial` REST collection is empty
for this dataset; trial parameters/KPIs only exist inside the saved analysis zip), `build_trial_table`,
`compute_boundaries` (pure port of `boundaryExport.ts`), `export_run_dir` (writes all 3 files).

```bash
python -m llm_pipeline.cli odd-export --run-dir "$RUN" --kNN 10 [--analysis-zip path/to/x.zip]
```

### S3 — `odd_rules.py` (parameter rules)

Fits a **shallow** (`max_depth=3` by default) `sklearn.tree.DecisionTreeClassifier` on
`odd_all_trials.json` to predict `fail = not passed` from scenario parameters, then walks every
root→leaf path into a human-readable AND-predicate. Deliberately shallow: the goal is an
*auditable* rule an engineer can read, not maximum accuracy (XAI interpretable-by-design choice
— see `implementation_plan.md` §6.4). A depth ablation (1–4) on `batch8/3_cluster_s=0.8032`
confirmed depth 3 is the accuracy/readability sweet spot (§9 S3 "C2").

These rules are **hypotheses about the sampled trials**, never presented as a certified SAE
J3016 ODD boundary — every `odd_parameter_rules.json` carries an explicit `limitations` list
saying so, and the chat system prompt (below) is instructed never to call them "the ODD".

```bash
python -m llm_pipeline.cli odd-rules --run-dir "$RUN" [--max-depth 3] [--min-samples-leaf 10]
```

### S4 — `odd_join.py` (boundary ↔ pairs join)

Joins S2's boundary trial ids with `parameter_space_pairs/*/pair.json` **by trial id
membership only** — never by comparing `odd_boundary_export.json`'s min-max distance against
`pair.json`'s z-scored distance, which are different metrics over the same features (would be a
silent unit error). Output: which pair packs have at least one endpoint that is also a boundary
trial, and each pack's already-written `contrast.yaml` verdict if present.

```bash
python -m llm_pipeline.cli odd-join --run-dir "$RUN"
```

### S5a — `odd_briefing.py` (deterministic knowledge base)

No LLM call. Reads every artifact above (`cluster.json`, `medoid_trial.yaml`,
`cluster_summary.yaml`, `parameter_space_pairs/*/pair.json` + `contrast.yaml`,
`odd_boundary_export.json`, `odd_parameter_rules.json`, `odd_boundary_pairs_join.json`,
`cluster_selection_eval.json`) and assembles one compact JSON — `odd_chat_briefing.json` — that
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
`odd_chat_briefing.json`.

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
| Dashboard panel | Optional "API key (ephemeral)" text field in the ODD Q&A section of the Run Report tab — sent to the server for that one request only (as a spawned-process env var), never written to disk or logged; if left blank, the dashboard server's own `GOOGLE_API_KEY`/`OPENAI_API_KEY` env var is used |
| Neither set | `answer()` runs in **dry-run** mode automatically — no LLM call, returns a placeholder string naming which sources it *would* have cited, and still logs the turn (`dry_run: true`) |

Model choice follows the model name prefix — `gemini-*` → `GOOGLE_API_KEY`, `gpt-*`/`o*` →
`OPENAI_API_KEY` (same convention as `cluster-analyze/run`). Default model: `gemini-2.5-flash`.

**What is fed to the LLM on every turn** (`odd_chat.py::build_messages`):

1. `SYSTEM_PROMPT` — fixed role + hard rules: cite only the briefing, say "unknown" for
   anything in `missing`, keep deterministic facts (collision_rate, support, precision) and
   LLM-authored interpretation (motive, caption, separation_call) verbally distinguished, never
   call the S3 rules "the ODD", always end with a `Sources: …` line.
2. A **routed slice** of `odd_chat_briefing.json` — see router table below. Never the whole
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
  default) appends one JSON line to `$RUN/odd_chat_log.jsonl`:

  ```json
  {"timestamp": "2026-08-21T07:40:12Z", "question": "...", "answer": "...",
   "citations": ["cluster0/summary", "pair c0-c2"], "model": "gemini-2.5-flash",
   "dry_run": false, "briefing_generated_at": "2026-08-21T07:12:03Z"}
  ```

  This file is a plain artifact in the run folder — not browser `localStorage`, not a database.
  Opening the dashboard again later (even on a different machine that shares the same
  `results/` folder, or from a plain terminal `odd-chat` call) reads the *same* file, so the
  conversation is genuinely shared and persistent, not per-browser-tab.

**Function-by-function reference** (`llm_pipeline/odd_chat.py`):

| Function | Role |
| --- | --- |
| `load_briefing(run_dir)` | Reads `odd_chat_briefing.json`; raises with a clear "run S5a first" message if missing |
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

**Dashboard UI (Run Report tab → "ODD Q&A" section, bottom of the page):**

- `GET /api/odd-chat?batchId=&folder=` — reads `odd_chat_briefing.json`'s `missing` list plus
  `odd_chat_log.jsonl` back into a `history` array; the panel calls this on mount so previously
  asked questions are shown immediately, before the user asks anything new.
- `POST /api/odd-chat` — body `{batchId, folder, question, model?, apiKey?}`; the route
  reconstructs the last-8-turn history straight from `odd_chat_log.jsonl` (so the browser never
  has to manage conversation state itself), writes it to a temp file, then spawns
  `scripts/run_odd_chat.sh` (same analyzer-conda-env pattern as `scripts/run_cluster_analyze.sh`)
  → `python -m llm_pipeline.cli odd-chat`. The CLI process itself appends the new turn to
  `odd_chat_log.jsonl` — the Next.js route never writes conversation state directly, so the
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
