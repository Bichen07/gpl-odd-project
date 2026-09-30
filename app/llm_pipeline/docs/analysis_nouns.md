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

The ranking number. The language-model reading does not move it.

| Field | Shown as | Values | Prompt | Python | Dashboard |
| --- | --- | --- | --- | --- | --- |
| `rule_score` | geometry | 0–100 | none. The scorer computes it. | `llm_pipeline/python/llm_pipeline/clustering_quality_scorer.py` | `dashboard/.../analyze/components/SelectionQualityPanel.tsx`; report chip in `analyze/panels/Report/index.tsx` |
| `final_score` | same number as geometry | equals `rule_score` | none | `compute_final_score` in `clustering_quality_scorer.py` | tab score in `explore/.../PerEgoSelection/index.tsx`; rank in `dashboard/src/app/api/cluster-evaluate/route.ts` |
| `llm_score` | language model | average of the two 1–10 ratings, times 10 | the two ratings are in `llm_pipeline/prompt_templates/cross_cluster_prompt.txt` | `clustering_quality_scorer.py` reads `behavioral_separation_score` and `boundary_clarity_score` | `SelectionQualityPanel.tsx`, beside geometry |

Geometry pieces, each weight 0.25, live in `_WEIGHTS` in `clustering_quality_scorer.py` and in the geometry rows of `SelectionQualityPanel.tsx`: `silhouette_score`, `collision_spread_score`, `ttc_spread_score`, `intra_consistency_score`. Silhouette in the file is `silhouette_raw` on −1 to 1. The piece score shifts that onto 0–1.

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
| `behavior_similarity` | Behavioral similarity | `distinct`, `similar`, or `inconclusive` | `prompt_templates/parameter_space_pair_prompt.txt` | `split_analysis.py` writes and checks it. `cluster_selection_eval.py` puts it in the digest. `odd_briefing.py` and `odd_chat.py` copy the key. Context lines: `analyzer/src/parameter_space_pair_packs.py`, `analyzer/src/secondary_context.py` | `IcPairPanel.tsx` chip “Behavioral similarity”. Report column in `analyze/panels/Report/index.tsx`. API: `api/cluster-run-report/route.ts` (`behaviorSimilarity`), `api/cluster-analysis-status/route.ts`. Types: `analyze/types.ts`, `explore/redux/slices/batch.ts` |
| `behavior_similarity_reason` | Separation reason | One line for the Behavioral similarity call: how these two boundary trials differ | same pair prompt | `split_analysis.py` | `IcPairPanel.tsx`; report column; `replayerCaption.ts` uses it when the longer explanation is empty |
| `critical_divergence` | critical_divergence | Earliest shared-clock time a geometry difference lasts: who is ahead, clearance, or longitudinal relationship. `at` is that time. A single speed sample is not enough unless the clearance also stays split. | same pair prompt | `split_analysis.py` | `IcPairPanel.tsx`, with an explain button |
| `contrast_explanation` | contrast_explanation | The longer pair story | same pair prompt | `split_analysis.py` | `IcPairPanel.tsx`; report column; `replayerCaption.ts` |
| `resolution` + `evidence` | same words as the medoid card | Each side of the pair | same pair prompt | `split_analysis.py` | `IcPairPanel.tsx` |

The summary prompt copies this same `behavior_similarity` onto each neighbor. See §4.

## 4. Cluster summary

Prompt: `llm_pipeline/prompt_templates/cluster_summary_prompt.txt`. Writer: `split_analysis.py`.

| Field | Values | Meaning | Python | Dashboard |
| --- | --- | --- | --- | --- |
| `label` | 2–4 words | Outcome name for this cluster. `Late Yield` belongs only here. | `split_analysis.py` does not overwrite `label`. `cluster_label_reviewer.py` may rename duplicates. | summary card `analyze/components/SplitCardsPanel.tsx` |
| `caption` | prose | Why, for the whole cluster. | `split_analysis.py` | `SplitCardsPanel.tsx` |
| `behavior_similarity` | `distinct`, `similar`, `inconclusive`, `ambiguous` | On each neighbor. Copies the pair field. `ambiguous` means that pair card is missing. | `cluster_selection_eval.py` `neighbor_rollup_digest` | `SplitCardsPanel.tsx` neighbor chips |
| `neighbor_behavior` | `distinct`, `similar`, `mixed`, `ambiguous` | Rollup of the neighbor list. Describes the behavior, and does not change the clustering. | stub value `ambiguous` in `split_analysis.py`. The model writes the rollup; the prompt defines the four values. | `SplitCardsPanel.tsx`. Report API field `neighborBehavior` in `cluster-run-report/route.ts` |
| `distinct_from_neighbors` | true or false | True only when every neighbor `behavior_similarity` is `distinct`. | `split_analysis.py` sets this. The prompt tells the model not to invent it. | `SplitCardsPanel.tsx` chip “distinct from all neighbors” |

`neighbor_behavior` values, defined in `cluster_summary_prompt.txt`:

| Value | When |
| --- | --- |
| `distinct` | Neighbors are mostly `distinct`, and those edges share one geometry family. |
| `similar` | Neighbors are mostly `similar`. |
| `mixed` | The neighbor list contains both `distinct` and `similar`, or the boundary sides mix yield-family and pass-family. |
| `ambiguous` | A medoid card or a pair card is missing. |

## 5. Cross-cluster reading

Prompt: `llm_pipeline/prompt_templates/cross_cluster_prompt.txt`. Parser: `llm_pipeline/python/llm_pipeline/cross_cluster_evaluator.py`.

The reading explains differences. It does not recommend a merge, a split, or a different number of clusters.

| Field | Shown as | Meaning | Dashboard |
| --- | --- | --- | --- |
| `inter_notes` | the reading paragraph | What the clusters share, and what still differs. | `SelectionQualityPanel.tsx` |
| `cluster_differences` | What still differs | One row per overlapping pair: `clusters`, `shared`, `difference`. | `SelectionQualityPanel.tsx` |
| `selection_verdict` | the short reading | The same explanation in 2–3 sentences. | `SelectionQualityPanel.tsx` |
| `behavioral_separation_score` | Behavior difference | 1–10. How clearly the behavior stories differ. | `SelectionQualityPanel.tsx`. Also the input to `llm_score` in `clustering_quality_scorer.py`. |
| `boundary_clarity_score` | Boundary clarity | 1–10. How clearly that difference can be stated from the cards. | `SelectionQualityPanel.tsx`. Also the input to `llm_score`. |

Behavior difference is a rating of the reading. It is not Behavioral similarity.

Chat context uses the pair and summary keys, not these ratings: `odd_chat.py`, `prompt_templates/odd_chat_system_prompt.txt`.

The selection-eval key `merge_candidates` is a list of clusters that share a title. It is computed in `cluster_selection_eval.py`. The dashboard title in `SelectionQualityPanel.tsx` is Same-title clusters. It is not a behavior label.
