# GPL-ODD LLM Pipeline

Split LLM / deterministic cards over analyzer results
(`results/batch<id>/<k>_cluster_s=<sil>/`). Dashboard **Analyze → Split cards**
is the report viewer; Explore Replayer reads the medoid timeline via the status API.

Example run used below:

```text
results/batch2/3_cluster_s=0.7036/
```

## How prompts are fed to the LLM (verified in code)

Every medoid / summary / ic-pairs call builds LangChain messages as:

```text
SystemMessage  ← prompt_templates/system_prompt.txt
                   (via split_analysis._system_prompt → complete_yaml_prompt)

HumanMessage   ← common_sense.txt
               + task template (medoid_trial | cluster_summary | ic_pair)
               + filled placeholders
               + [optional] BEV images as image_url parts
```

Code path:

1. `split_analysis._with_common_sense(task)` prepends `common_sense.txt`
2. `ClusterInterpreter.complete_yaml_prompt(..., system_prompt=_system_prompt())`
   → `SystemMessage` + `HumanMessage(text [+ images])`

| Prompt file | Role | When |
|-------------|------|------|
| [`system_prompt.txt`](prompt_templates/system_prompt.txt) | SystemMessage | all three products |
| [`common_sense.txt`](prompt_templates/common_sense.txt) | Prefix of HumanMessage | all three products |
| [`medoid_trial_prompt.txt`](prompt_templates/medoid_trial_prompt.txt) | Task body | `--products medoid` |
| [`cluster_summary_prompt.txt`](prompt_templates/cluster_summary_prompt.txt) | Task body | `--products summary` |
| [`ic_pair_prompt.txt`](prompt_templates/ic_pair_prompt.txt) | Task body | `--products ic-pairs` |
| [`cross_cluster_prompt.txt`](prompt_templates/cross_cluster_prompt.txt) | Eval only | `cross-cluster-eval` |

## Products (dataflow)

### 0) Shared deterministic prep (always before / with LLM cards)

```text
Payload (ttc_min KPI + collision + IC params) + clustering assignments
  → cluster_aggregates.build_enriched_cluster_aggregate
  → clusterN/cluster_aggregate.json  (+ inject into cluster.json)
```

| Artifact | Example path | What to inspect |
|----------|--------------|-----------------|
| Aggregate digests | `results/batch2/3_cluster_s=0.7036/cluster0/cluster_aggregate.json` | `ttc`, `ttc_collide`/`ttc_survive`, `ic.OncomingSpeed`, collision_rate |

`ttc_min` in aggregates = **Payload KPI** from `scenario_sampler.py` (polygon look-ahead), not BEV closing-rate.

---

### 1) Medoid trial (`--products medoid`)

**One medoid trial** — motives / decisions, not a cluster travelogue.

#### LLM message assembly

```text
SystemMessage:  system_prompt.txt

HumanMessage text:
  common_sense.txt
  + medoid_trial_prompt.txt with placeholders filled:
       {conflict_metrics}  ← conflict_metrics JSON (below)
       {trial_context}     ← truncated action/description context (below)
  + dual-panel BEV JPGs (up to --max-llm-snapshots, evenly spaced)

→ clusterN/output/medoid_trial.yaml  (single file; optional ``llm_meta.token_usage``)
```

#### Inputs you can open and check

| Slot in prompt | Built from | Example path |
|----------------|------------|--------------|
| **conflict_metrics JSON** | Runtime dict from `extract_conflict_pack(cluster_dir)` — **not** a saved file by itself. Built from `llm_snapshots.json` + ego brake times in `action.yaml`. Echoed again inside output YAML as `conflict_metrics:`. | Sources: `cluster0/processed/snapshots/llm_snapshots.json`, `cluster0/processed/action.yaml`. Output echo: `cluster0/output/medoid_trial.yaml` → `conflict_metrics` |
| **truncated trial_context** | `action_log_from_description(cluster_dir)`: prefer `context.md`, else `description.txt`, else compact render of `action.yaml`. If longer than **6000 chars**, truncated with `…[truncated]`. | Prefer: `cluster0/processed/context.md` (sentence timeline only; glossary is in `common_sense.txt`). Fallback: `cluster0/processed/description.txt`, `cluster0/processed/action.yaml` |
| **BEV images** | `clusterN/processed/snapshots/*.jpg` via `collect_bev_snapshot_paths` | e.g. `cluster0/processed/snapshots/trial_1067_t_17.20_NEAR_MISS_Opposite.jpg` |
| Snapshot index / frame metrics | Same pack source | `cluster0/processed/snapshots/llm_snapshots.json` (`peak_t`, per-frame `d_m`/`ttc_s`) |
| Medoid identity | `cluster.json` / `manifest.json` | `cluster0/raw/cluster.json` → `medoid.trial_id` |

**What `conflict_metrics` contains (typical keys):**

```json
{
  "trial_dir": "…/cluster0",
  "peak_t": 33.2,
  "relevance_t": 30.025,
  "brake_t": 27.66,
  "d_min": 2.75,
  "ttc_min": 0.39,
  "partner": "Opposite",
  "outcome_hint": "survive_or_near_miss",
  "snapshot_count": 15,
  "trial_id": "3269",
  "collided": false
}
```

- `peak_t` / `relevance_t` / partner ← `llm_snapshots.json`
- `d_min` / `ttc_min` ← min over snapshot frames (or interaction rows in `action.yaml`)
- `brake_t` ← earliest ego `EMERGENCY_BRAKE` / hard brake / else first `DECELERATE` in `action.yaml`

**What “truncated action/description context” is:** the Labeller **sentence
timeline** in `processed/context.md` (conflict bursts + accelerate/decelerate +
same-lane TURN_* with Δheading / heading-vs-travel-direction notes). Open that
file to see exactly what the medoid LLM prefers. Human tables live in
`processed/description.txt` (fallback only).

Canonical output keys (LLM narrative): `trial_id`, `outcome`, `motive_summary`,
`decision_timeline[{timestamp, description}]`, optional `open_questions`.
`conflict_metrics` is **injected from GT** by `split_analysis` after the call —
do not ask the model to copy it (wastes tokens; pipeline overwrites anyway).

Example output: `results/batch9/4_cluster_s=0.7482/cluster0/output/medoid_trial.yaml`

**Nested pack layout (writers):**

```text
clusterN/
  raw/         trajectory.csv, cluster.json
  processed/   action.yaml, description.txt, context.md, snapshots/, map_overview.jpg
  output/      medoid_trial.yaml, cluster_summary.yaml, …
```

---

### 2) Cluster summary (`--products summary`)

**Cluster-wide** caption over numbers (no medoid journey).

```text
SystemMessage:  system_prompt.txt

HumanMessage text:
  common_sense.txt
  + cluster_summary_prompt.txt with:
       {numeric_digest} ← format_aggregate_for_prompt(cluster_aggregate.json)
  (text only — no BEV)

→ clusterN/output/cluster_summary.yaml  (single file; optional ``llm_meta.token_usage``)
```

| Slot | Source file to inspect |
|------|------------------------|
| `{numeric_digest}` | `cluster1/cluster_aggregate.json` (formatted into the prompt string) |
| Output | `cluster1/cluster_summary.yaml` |

Canonical keys: `cluster_id`, `label`, `risk_level`, `caption`, `consistency_note`.

---

### 3) IC closest pairs (`--products ic-pairs`)

Only pairs with **z-scored IC `param_dist ≤ 0.1`** are packed/LLM'd.

```text
SystemMessage:  system_prompt.txt

HumanMessage text:
  common_sense.txt
  + ic_pair_prompt.txt with:
       {pair_facts} / {left_block} / {right_block}
       {left_context} / {right_context}  ← truncated context.md
  + synced pair-zoom|pair-zoom BEVs (peak-relative t′)

→ ic_pairs/c{A}-c{B}/
     pair.json, synced_bev/, cA_trial_*/ + cB_trial_*/
     contrast.yaml   ← one comparison LLM output
```

| Slot | Source |
|------|--------|
| Gate | `manifest.param_boundary_pairs` with `ic_match` / `card_role` |
| Packs | `ic_pairs/c0-c3/` (rebuild: `scripts/rebuild_ic_pairs.py`) |
| Synced BEV | `ic_pairs/c0-c3/synced_bev/tprime_*.jpg` |
| Output | `ic_pairs/c0-c3/contrast.yaml` |

`card_role=primary` → outcome mismatch; `secondary` → same outcome (over-split probe).
Far pairs (`ic_match=false`) are skipped for LLM.

---

## Suggested check order (before re-running LLM)

1. `cluster0/snapshots/llm_snapshots.json` — timings / per-frame d,TTC  
2. `cluster0/action.yaml` — ego brake actions  
3. `cluster0/context.md` — full trial_context source (note 6k truncate)  
4. `cluster0/cluster_aggregate.json` — summary digest input  
5. `manifest.json` → `param_boundary_pairs` + one `highlight_trials/param_boundary_c*/trial_*/` folder  
6. Prompt files under `app/llm_pipeline/prompt_templates/`  
7. Then run interpret (see CLI)

## CLI

```bash
conda activate analyzer
export PYTHONPATH="app/llm_pipeline/python:app/analyzer/src"
export GOOGLE_API_KEY="…"   # or OPENAI_API_KEY

python -m llm_pipeline.cli cluster-interpret \
  --results-dir results/batch2/3_cluster_s=0.7036 --batch-id 2 \
  --products medoid
```

Default product is **`medoid`** only (one YAML: `output/medoid_trial.yaml`).
Pass `--products medoid,summary,ic-pairs` or `--products all` when you also want
cluster captions / IC pair cards. Each product writes **one YAML** (no
`*_meta.json` sidecars); token usage lives under `llm_meta:` inside that file.

Explore Replayer timeline + motive come from `medoid_trial.yaml` via
`/api/cluster-analysis-status`.

## Package map

| Module | Role |
|--------|------|
| `cli.py` | `cluster-interpret`, `cross-cluster-eval` |
| `split_analysis.py` | Product orchestration; `_with_common_sense` / `_system_prompt` |
| `cluster_aggregates.py` | Digests + `extract_conflict_pack` |
| `cluster_interpreter.py` | `complete_yaml_prompt` (SystemMessage + HumanMessage + images) |
| `cluster_interpretation_pipeline.py` | `action_log_from_description`, `collect_bev_snapshot_paths` |
| `cross_cluster_evaluator.py` | Evaluation-tab LLM |
| `clustering_quality_scorer.py` | Rank configs after eval |

## TTC note (for `cluster_aggregate.json`)

1. **Payload KPI `ttc_min`** (aggregates) — `scenario_sampler.py` polygon look-ahead (cap ~5 s).  
2. **BEV closing-rate TTC** — `labeller.py` / snapshot chips: `TTC = d/closing`; not approaching → ∞.

See also the root [`README.md`](../../README.md) §5.
