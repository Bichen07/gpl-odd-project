# Analysis flow — PPT pages

Worked example: `results/batch8/3_cluster_s=0.8032` (batch 8, 3 clusters, silhouette 0.8032).
Re-run 2026-09-30, gemini-2.5-flash, temperature 0.1.

Clustering (MFPCA + HDBSCAN on the whole trajectory) already exists. These pages start after that partition.

===

page 1
title: What this project does
context:
The clustering decides the groups. The language model names the driving behavior in each group and what still differs between groups. It does not choose the number of clusters.

One sentence for the room: a high silhouette is not the whole score, and a clear written difference is not a request to merge.

Suggest: one arrow diagram.
MFPCA + HDBSCAN → packs (action, BEV, context) → four model steps → report → Q&A.

===

page 2
title: Analysis flow
context:
Deterministic steps first. Model steps only read those files.

1. Data preprocess — action extractor and filter, BEV, context.
2. Medoid — one representative trial.
3. Parameter pair — two trials with almost the same scenario inputs.
4. Cluster summary, then label review.
5. Cross-cluster reading. Geometry score is computed here and is the ranking number.
6. One-page report — no new model call.
7. Q&A — briefing is deterministic; each question is one model call.

Suggest: the same arrow as page 1, with the file name under each box (`action.yaml`, `medoid_trial.yaml`, `contrast.yaml`, `cluster_summary.yaml`, `cross_cluster_eval.json`, report, `odd_chat_briefing.json`).

===

page 3
title: Data preprocess
context:
No language model. Orchestrator: `app/analyzer/src/dataset_builder.py`.

| Step | Input | Python | Output | Dashboard |
| --- | --- | --- | --- | --- |
| Action extractor | trajectory CSV, map, collision record | `labeller.py` | `action.yaml` — full event log | not shown as a card |
| Filter | `action.yaml` + trajectory | `conflict_frame_selector.py` | stamp times. Drops junction filler, idle NPC, stopped NPC, mirrored collision | not shown |
| BEV | those stamps, trajectory, map | `tier2_renderer.py` | `snapshots/*.jpg`, ego-centered | frame strip on the medoid and pair panels |
| Context | stamps + `action.yaml` | timeline sentences in the builder | `context_medoid.md`, `context_cluster.md`, pair `process/context.md` | not shown as prose; the model cites it |

`description.txt` is the full log for a human. The medoid model reads `context_medoid.md`, not that file.

Pair packs add a shared clock and synced BEV. A pair is kept only when the z-scored parameter distance is at most 0.1.

This run: 904 / 753 / 1343 trials. Collision rates 1.99%, 0%, 100%. Pairs kept: `c0-c2` (0.0072), `c1-c2` (0.0104). `c0-c1` skipped (0.63).

Suggest: three screenshots in a row — one action line, one BEV frame, one context timeline line for the same timestamp.

===

page 4
title: Medoid
context:
One trial that stands for the cluster. Not a summary of every member.

Input: `context_medoid.md` + BEV frames.
Prompt: `system_prompt.txt` + `common_sense.txt` + `medoid_trial_prompt.txt`.
Python: `split_analysis.py` sends that pack, writes `clusterN/output/medoid_trial.yaml`, and fills outcome and collision fields from the trial record.

Dashboard (Cluster analysis → Medoid):

| On screen | File field | Meaning |
| --- | --- | --- |
| agent + resolution | `agent_interactions` | One row per vehicle Ego responded to. `pass_first`, `yield`, or `unresolved`. |
| motive_summary | `motive_summary` | 2–4 sentences, one paragraph. Why Ego moved that way. |
| timeline | `decision_timeline` | timestamp + one description. |
| outcome | `outcome` | `safe` or `collision`. Pipeline writes this. |

`yield` means Ego slows or stops to give way and that vehicle is not yet behind, including a crash while still braking. `pass_first` means the other vehicle ends up behind, or Ego holds speed into the gap.

This run: c0 CuttingIn `pass_first` (safe). c1 CuttingIn `yield` (safe). c2 CuttingIn `yield` (collision).

Suggest: the c1 medoid card beside two BEV frames (approach, then the near-miss).

===

page 5
title: Parameter pair
context:
Two trials from different clusters whose scenario inputs almost match (`OncomingSpeed`, `OncomingStartDelay`). The question is the behavior of those two boundary trials. Whole-trajectory similarity is already what MFPCA + HDBSCAN used. This step does not re-cluster.

Input: pair `process/context.md` + synced BEV. Both medoid cards are a consistency check only, not the evidence for these two trials.
Prompt: `parameter_space_pair_prompt.txt`.
Python: `parameter_space_pair_packs.py` builds the pack. `split_analysis.py` calls the model and writes `parameter_space_pairs/cA-cB/output/contrast.yaml`.

Dashboard (Parameter-space pairs, and the report pair table):

| On screen | File field | Meaning |
| --- | --- | --- |
| left / right resolution | `left.resolution`, `right.resolution` | Same three words as the medoid, plus one `evidence` sentence from this pair’s context. |
| contrast_timeline | `contrast_timeline` | Shared-clock phases: start, end, optional BEV name, and what differs in that phase. |
| critical_divergence | `critical_divergence` | Earliest shared-clock time a geometry difference lasts (who is ahead, clearance, or longitudinal relationship). `at` is that time. A one-sample speed blip is not enough. |
| contrast_explanation | `contrast_explanation` | The longer story. The report column uses this same name. |
| Behavioral similarity | `behavior_similarity` | `distinct`, `similar`, or `inconclusive`. See the rule below. |
| Separation reason | `behavior_similarity_reason` | One line for Behavioral similarity: how these two boundary trials differ. |

Behavioral similarity rule:

- `distinct` — different resolution family, or the same family with different outcomes, or the same family and outcome but one stays ahead while the other overlaps.
- `similar` — same family and same outcome. A small late clearance or a whole-trajectory detail can remain. The separation reason must name it.
- `inconclusive` — the cards do not name the difference.

Same family and a different collision is `distinct`. Collision is an outcome.

This run: both pairs are `distinct`. `c0-c2` is 0.2 m clearance versus contact at t=10.271 s. `c1-c2` is the same yield family, safe versus collision.

Suggest: a two-column table for `c0-c2` — left trial, right trial, then one row for Behavioral similarity and one row for critical_divergence.

===

page 6
title: Cluster summary and label review
context:
Summary is one cluster at a time. It does not read the other clusters’ labels.

Input: this cluster’s medoid card, `context_cluster.md`, and every touching `contrast.yaml`.
Prompt: `cluster_summary_prompt.txt`.
Python: `split_analysis.py` writes `cluster_summary.yaml`. It sets `risk_level` from the collision rate. It sets `distinct_from_neighbors` to true only when every neighbor is `distinct`. The model does not set that flag.

Dashboard (Cluster analysis → Summary):

| On screen | File field | Meaning |
| --- | --- | --- |
| title chip | `label` | 2–4 words. `Late Yield` belongs only here. |
| caption | `caption` | Why, for the cluster. |
| risk, collision rate | `risk_level`, aggregate rate | Rate is measured. Risk is derived from it. |
| neighbor chip | neighbor `behavior_similarity` | Same call as the pair. `ambiguous` means that pair card is missing. |
| neighbor_behavior | `neighbor_behavior` | Rollup: `distinct`, `similar`, `mixed`, or `ambiguous`. Describes the neighbors. Does not change the clustering. |
| distinct from all neighbors | `distinct_from_neighbors` | Pipeline flag. |

Label review is a second call, `cluster_reviewer_prompt.txt`. Input is only the labels, a short caption excerpt, and the risk. It renames a label when the name chains two mechanisms, or when two clusters share a name but the captions differ. Python: `cluster_label_reviewer.py`.

This run: Pass-Slowdown, Yield, Yield-Stop Collision. Zero renames. All three `neighbor_behavior` values are `distinct`.

Suggest: three label chips, and under c2 the two neighbor chips `c0-c2: distinct` and `c1-c2: distinct`.

===

page 7
title: Cross-cluster reading and the geometry score
context:
The reading explains the partition that already exists. It does not recommend a merge, a split, or a different k.

Input: summaries, medoid cards, pair cards, and the selection-eval digest (purity and title checks). No raw `cluster.json`, no BEV.
Prompt: `cross_cluster_prompt.txt`.
Python: `cross_cluster_evaluator.py` writes `cross_cluster/output/cross_cluster_eval.json`. `clustering_quality_scorer.py` writes the geometry score.

Dashboard (Cross-cluster analysis):

| On screen | File field | Meaning |
| --- | --- | --- |
| geometry | `final_score`, equal to `rule_score` | The ranking number, 0–100. |
| Silhouette | `silhouette_score` | Trajectory separation. Weight 0.25. File raw value is −1 to 1. |
| Collision-rate spread | `collision_spread_score` | How uneven the clusters’ collision rates are. Weight 0.25. |
| Time-to-collision spread | `ttc_spread_score` | How uneven mean TTC is. Weight 0.25. |
| Tightness | `intra_consistency_score` | How close trials sit to the cluster center in the projection. Weight 0.25. |
| Language model | `llm_score` | Average of the two 1–10 ratings, times 10. Beside geometry. Does not move it. |
| Behavior difference | `behavioral_separation_score` | 1–10. How clearly the behavior stories differ. Not Behavioral similarity. |
| Boundary clarity | `boundary_clarity_score` | 1–10. How clearly that difference can be stated from the cards. |
| Language-model reading | `inter_notes` | The paragraph. |
| short reading | `selection_verdict` | The same explanation in 2–3 sentences. |
| What still differs | `cluster_differences` | One row: which clusters, what is shared, what still differs. |
| Same-title clusters | selection-eval `merge_candidates` | Clusters that share a title. A check, not a behavior label. |

This run: geometry 60.7. Pieces: silhouette 0.90, collision spread 0.93, TTC spread 0.54, tightness 0.06. Behavior difference 7/10, boundary clarity 10/10, language-model number 85.

Suggest: the four geometry bars, tightness called out, and the c1–c2 “what still differs” row beside them.

===

page 8
title: One-page report
context:
Analyze → Report. `GET /api/cluster-run-report` reads files already written. No model call.

The page shows the geometry chip, cluster labels and collision rates, and the pair table: Pack, Param Distance, Outcome Flip, Behavioral similarity, contrast_explanation, Separation reason. Those three pair columns are the same fields as the pair panel.

Inconclusive pairs and same-title clusters appear as alerts when they exist. This run has neither. Header chips: 2 distinct, 2 pairs.

Suggest: a screenshot of the report pair table for this run, with the geometry chip in the corner.

===

page 9
title: Q&A
context:
After the cards exist.

1. `odd-briefing` (`odd_briefing.py`) builds `odd_chat_briefing.json` with no model call. It copies labels, `neighbor_behavior`, Behavioral similarity, collision rates, and the S3 rules.
2. `odd-chat` (`odd_chat.py`, `odd_chat_system_prompt.txt`) answers one question from that briefing. Measured rates stay separate from the model’s captions.

S2 `odd-export` is the pass/fail boundary in the sampled parameter box. S3 `odd-rules` is a shallow CART (depth at most 3) over `OncomingSpeed` and `OncomingStartDelay`. Those two were already on disk for this run and were not regenerated. The briefing refresh reports 3 clusters, 2 pairs, 8 rules, nothing missing.

Suggest: one question on the left (“why is c2 a different cluster from c1?”) and the briefing fields the answer is allowed to cite on the right.

===

page 10
title: This run, in one table
context:

| | c0 | c1 | c2 |
| --- | --- | --- | --- |
| Trials | 904 | 753 | 1343 |
| Collision rate | 1.99% | 0% | 100% |
| Label | Pass-Slowdown | Yield | Yield-Stop Collision |
| Medoid vs CuttingIn | pass_first, safe | yield, safe | yield, collision |
| Neighbor call | c0–c2 distinct | c1–c2 distinct | both neighbors distinct |

Geometry 60.7. Language-model reading 85, not part of the rank. Selection checks (outcome purity and unique titles) score 100 and are not part of the rank either.

Suggest: this table, nothing else.

===

page 11
title: Contribution
context:
On this run, the method does what we asked.

- The number on the tab is the geometry score. The written reading explains differences and does not ask to change k.
- The three labels match the collision rates: almost no crashes, no crashes, all crashes.
- Matched inputs still leave a behavior difference: a safe pass versus a contact (`c0-c2`), and a safe yield versus a colliding yield (`c1-c2`).
- Far pairs are skipped. `c0` and `c1` are not compared as if their scenario inputs matched.

Suggest: two pair rows only, each with Behavioral similarity = distinct and one similarity-reason sentence.

===

page 12
title: Weakness
context:
Good enough to show the method. Not good enough to treat every sentence as measured.

- Tightness is 0.06. Silhouette is high, so the geometry score is 60.7 rather than a score near the silhouette piece. The reading at 85 does not repair the loose clusters.
- `c0-c2`: the context rule says both sides passed the named vehicle first. The split it measures is 0.2 m versus 0.0 m at t=10.271 s. The card calls them different families by citing the c2 medoid. `distinct` can stand on the outcome. The family sentence should not.
- `c1-c2`: both sides are yields, and the context says there is no sustained geometry split. The card still says `distinct` because one side is safe and the other collides, and it cannot name the split.
- c0 marks Parking as `pass_first`. The timeline shows Ego braking at about 0.9 m while Parking is still ahead. That brake is a yield under the resolution rule.
- The medoid clearance for c0 versus CuttingIn is about 1.4 m. The `c0-c2` boundary trial is 0.2 m. Different trials. A slide must say which trial the number comes from.

Suggest: tightness bar next to the `c1-c2` separation reason, so the room sees a clear sentence beside a weak geometry piece.

===

page 13
title: References
context:
Current method, safe to follow:

- `app/analyzer/README.md` — preprocess: action log, filters, BEV, context. `description.txt` is not the medoid model input.
- `app/llm_pipeline/README.md` — products, prompts, geometry score equals the ranking number, report, Q&A.
- `app/llm_pipeline/docs/analysis_nouns.md` — one name per field, and which prompt, Python file, and dashboard panel use it.

Earlier reviews. Useful as the argument that led here. Their schemas are not the live ones:

- `app/llm_pipeline/medoid_analysis_method_study.md` — medoid design notes. The live card is `agent` + `resolution` + `motive_summary`. The study still discusses older motive fields.
- `app/llm_pipeline/post_medoid_analysis_method_study.md` — pair, summary, and cross-cluster notes. It still says `separation_call: justified | over_fine` and a keep/merge/split action. Live words are Behavioral similarity (`distinct`, `similar`, `inconclusive`) and a reading that does not choose k.

If a saved card and a prompt disagree, inspect the prompt. Do not add a second word for the same field.

Suggest: two columns, “use these” and “do not present these schemas.”
