# Analysis nouns

Check this list after a prompt, dashboard, or README wording change. One field keeps one name. The screen uses the words in the Shown as column. Do not add a second name for the same call.

Pipeline order is the order below. Later stages copy earlier words.

Saved model output is not part of this list. If a saved card uses a different word, inspect the prompt that asked for the field. Do not add a second reader for that word.

## How to check

1. Find the field in the table.
2. Search the prompt, the Python files, and the dashboard files named for that field.
3. If a screen says the same thing with a different word, change the screen to the Shown as words.

Paths below are under `app/`.

## 1. Clustering score

The ranking number. No language model is involved.

| Field | Shown as | Values | Prompt | Python | Dashboard |
| --- | --- | --- | --- | --- | --- |
| `score` | geometry | 0–100 | none. The scorer computes it. | `score_run_dir` in `llm_pipeline/python/llm_pipeline/clustering_quality_scorer.py` writes `cluster_analysis/clustering_quality.json` | score block on `analyze/panels/ClusterAnalysis/index.tsx`; report chip in `analyze/panels/Report/index.tsx`; tab score in `explore/.../PerEgoSelection/index.tsx`; rank in `dashboard/src/app/api/cluster-evaluate/route.ts` |

Geometry pieces, each weight 0.25, live in `_WEIGHTS` in `clustering_quality_scorer.py` and in the geometry rows of `ClusteringScore/index.tsx` (shown on the Cluster analysis page): `silhouette_score`, `collision_spread_score`, `ttc_spread_score`, `intra_consistency_score`. Silhouette in the file is `silhouette_raw` on −1 to 1. The piece score shifts that onto 0–1.

## 2. Medoid card

One trial. Prompt: `llm_pipeline/prompt_templates/medoid_trial_prompt.txt`. Writer: `llm_pipeline/python/llm_pipeline/split_analysis.py`.

| Field | Values | Meaning | Also used in |
| --- | --- | --- | --- |
| `resolution` | `pass_first`, `yield`, `unresolved` | How Ego met the named vehicle on this trial. | pair prompt, summary prompt, pair panel `analyze/components/IcPairPanel.tsx` |
| `agent` | display name (`Oncoming`, `CuttingIn`, `Parking`) | One row per vehicle. A filename token `Opposite` is the same vehicle as `Oncoming`. | `analyzer/src/agent_labels.py`; dashboard twin `dashboard/src/app/api/_lib/agentNames.ts` |
| `motive_summary` | 2–4 sentences, one paragraph | Why, in prose. | summary prompt; `cluster-analysis-status/route.ts` |

## 3. Pair: two boundary trials

Behavioral similarity is the behavior of these two boundary trials. The trials already sit in different clusters because MFPCA and HDBSCAN separated whole trajectories. This call does not compare those whole-cluster trajectories, and it does not change the clustering.

| Value | Rule |
| --- | --- |
| `distinct` | The two trials differ in resolution family (yield versus pass-first), or they share a family and the outcomes differ, or they share a family and an outcome and one stays ahead while the other overlaps. |
| `similar` | Same resolution family and the same outcome. The remaining difference is a small late clearance or a whole-trajectory detail. Name that difference in the separation reason. |
| `inconclusive` | The cards do not name the difference. |

Same family and a different collision is `distinct`. Collision is an outcome.

| Field | Shown as | Meaning | Prompt | Python | Dashboard |
| --- | --- | --- | --- | --- | --- |
| `behavior_similarity` | Behavioral similarity | `distinct`, `similar`, or `inconclusive` | `prompt_templates/parameter_space_pair_prompt.txt` | `split_analysis.py` writes and checks it. `cluster_cards.py` puts it in the neighbor cards. `odd_briefing.py` and `odd_chat.py` copy the key. Context lines: `analyzer/src/parameter_space_pair_packs.py`, `analyzer/src/secondary_context.py` | `IcPairPanel.tsx` chip “Behavioral similarity”. Report column in `analyze/panels/Report/index.tsx`. API: `api/cluster-run-report/route.ts` (`behaviorSimilarity`), `api/cluster-analysis-status/route.ts`. Types: `analyze/types.ts`, `explore/redux/slices/batch.ts` |
| `behavior_similarity_reason` | Separation reason | One line for the Behavioral similarity call: how these two boundary trials differ | same pair prompt | `split_analysis.py` | `IcPairPanel.tsx`; report column; `replayerCaption.ts` uses it when the longer explanation is empty |
| `critical_divergence` | critical_divergence | Earliest shared-clock time the two trajectories start to differ and stay apart: a brake, the body gap, who is ahead, the position, or the speed. `at` is that time. A single sample that returns to the same path is noise. | same pair prompt | `split_analysis.py` | `IcPairPanel.tsx`, with an explain button |
| `contrast_explanation` | contrast_explanation | The longer pair story | same pair prompt | `split_analysis.py` | `IcPairPanel.tsx`; report column; `replayerCaption.ts` |
| `resolution` + `evidence` | same words as the medoid card | Each side of the pair | same pair prompt | `split_analysis.py` | `IcPairPanel.tsx` |

Python copies this same `behavior_similarity` onto each neighbor of the cluster summary. See §4.

## 4. Cluster summary

Prompt: `llm_pipeline/prompt_templates/cluster_summary_prompt.txt`. Writer: `split_analysis.py`.

| Field | Values | Meaning | Python | Dashboard |
| --- | --- | --- | --- | --- |
| `label` | 2–4 words | Outcome name for this cluster. `Late Yield` belongs only here. | `split_analysis.py` does not overwrite `label`. `cluster_label_reviewer.py` may rename duplicates. | summary card `analyze/components/SplitCardsPanel.tsx` |
| `caption` | prose | Why, for the whole cluster. | `split_analysis.py` | `SplitCardsPanel.tsx` |
| `behavior_similarity` | `distinct`, `similar`, `inconclusive`, `ambiguous` | On each neighbor. Copies the pair field. `ambiguous` means that pair card is missing. | `neighbor_comparison_from_contrasts` in `split_analysis.py` | `SplitCardsPanel.tsx` neighbor chips |
| `neighbor_behavior` | `distinct`, `similar`, `mixed`, `ambiguous` | Count of the copied pair calls. Not a grade of the clustering. | `neighbor_behavior_from_comparison` in `split_analysis.py`. | `SplitCardsPanel.tsx`. Report API field `neighborBehavior` in `cluster-run-report/route.ts` |

`neighbor_behavior` values, counted in `split_analysis.py`:

| Value | When |
| --- | --- |
| `distinct` | Every pair call is `distinct`. |
| `similar` | Every pair call is `similar`. |
| `mixed` | The list has at least one `distinct` and one `similar`, or an `inconclusive` call beside them. |
| `ambiguous` | No pairs, or a pair card is missing. |

## 5. Label review

Prompt: `llm_pipeline/prompt_templates/cluster_reviewer_prompt.txt`. Reader and writer: `llm_pipeline/python/llm_pipeline/cluster_label_reviewer.py`.

One call over every cluster. It reads each summary card and medoid card, and renames only when two or more labels are the same or near-same and the cards show different behavior. It adds one word. It does not grade the clustering and it does not recommend a merge or a split.

| Field | Meaning | Where |
| --- | --- | --- |
| `context_label_review.md` | The exact text the model reads. | `cluster_analysis/context_label_review.md` |
| `cluster_label_review.json` rows: `cluster_id`, `original_label`, `new_label`, `changed`, `reason` | One row per cluster. | `cluster_analysis/cluster_label_review.json` |
| `label_review: {previous_label, reason, reviewed_at}` | Audit block on a renamed `cluster_summary.yaml`. | `clusterN/output/cluster_summary.yaml` |

Chat context uses the pair and summary keys: `odd_chat.py`, `prompt_templates/odd_chat_system_prompt.txt`.
