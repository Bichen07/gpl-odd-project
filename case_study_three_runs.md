# Case study — three runs, one LLM reading

Run date 2026-10-03. Model gemini-2.5-flash, temperature 0.1. Previous output (2026-10-02) is kept under `analysis/_prev_2026-10-02/` inside each run, so every "old → new" below is a file comparison.

| Run | Dataset | Clusters | Pairs | Agents in the medoids |
| --- | --- | --- | --- | --- |
| `batch8/6_cluster_s=0.5947` | dataset3 | 6 (+56 noise trials) | 9 | Ego, CuttingIn, Parking |
| `batch8/6_cluster_s=0.6113` | dataset3 | 6 (+17 noise trials) | 9 | Ego, CuttingIn, Parking |
| `batch9/4_cluster_s=0.7482` | dataset2 | 4 | 4 | Ego, Oncoming, Parking |

The first two runs and the earlier `3_cluster_s=0.8032` are three partitions of the same 3000 trials (same trial IDs). `batch9` is a different scenario (an Oncoming vehicle, not a CuttingIn vehicle). It is read on its own.

What was run: context text rebuilt (no images re-rendered), then medoid → pair → summary → label review → cross-cluster reading → selection-eval for all three. S2/S3 (`odd-export`, `odd-rules`, `odd-briefing`) for the two batch8 runs only; `batch9` has no analysis zip on disk. No call failed and no stub file was written.

---

## 1. What the results show

### 1.1 Run 0.5947 (k = 6, geometry 70.54)

| Cluster | Trials | Collision | Medoid (CuttingIn row; Parking row) | Label (old → new) | Review |
| --- | --- | --- | --- | --- | --- |
| c0 | 753 | 0% | yield; pass_first, safe | Proactive Yield | kept |
| c1 | 73 | 100% | pass_first; yield, collision | Rear-end Collision | kept |
| c2 | 1237 | 100% | yield, collision | Yield Collision | kept |
| c3 | 40 | 100% | yield, collision | Yield Collision → Yield-Stop Collision | kept |
| c4 | 751 | 0% | pass_first; pass_first, safe | Pass-Slowdown | kept |
| c5 | 90 | 0% | pass_first; yield, safe | Safe Pass → Pass-Slowdown | kept |

Pairs: 8 distinct, 1 similar. Verdict changes against the old run: c1–c2 distinct → similar, c4–c5 similar → distinct. Cross-cluster ratings 7 / 7 (unchanged).

### 1.2 Run 0.6113 (k = 6, geometry 68.02)

| Cluster | Trials | Collision | Medoid | Label | Review |
| --- | --- | --- | --- | --- | --- |
| c0 | 753 | 0% | yield; pass_first, safe | Proactive Yield | kept |
| c1 | 886 | 0% | pass_first; yield, safe | Pass-Slowdown | kept |
| c2 | 13 | 100% | pass_first; yield, collision | Rear-end Collision | kept |
| c3 | 55 | 100% | pass_first; yield, collision | Rear-end Collision | kept |
| c4 | 41 | 100% | yield, collision | Late Yield Collision | kept |
| c5 | 1235 | 100% | pass_first, collision | Cut-in Collision | kept |

Pairs: 6 distinct, 3 similar. No verdict changed against the old run. Cross-cluster ratings 7 / 8 (old 7 / 7). LLM reading 75 (old 70). Geometry unchanged.

### 1.3 Run batch9 0.7482 (k = 4, geometry 69.42)

| Cluster | Trials | Collision | Medoid | Label (old → new) |
| --- | --- | --- | --- | --- |
| c0 | 640 | 0% | Oncoming yield; Parking pass_first, safe | Yield → Proactive Yield |
| c1 | 1105 | 0% | Oncoming pass_first; Parking pass_first, safe | Smooth Pass → Pass-Slowdown |
| c2 | 117 | 100% | Parking yield, collision | Yield-Stop Collision |
| c3 | 1117 | 100% | Oncoming yield; Parking yield, collision | Yield-Collision → Yield Collision |

Pairs: 4 distinct. Cross-cluster ratings 7 / 8 (old 9 / 9). LLM reading 75 (old 90). Medoid cards gained a Parking row on three clusters because the pair-format context now prints Parking clauses.

### 1.4 What the new context did to the output

- Cluster file is the collision count only. The consistency note quotes the count or rate in 16 of 16 clusters (old: 12 of 16: 4/6, 6/6, 2/4). The caption itself quotes it in 0 of 16.
- `risk_level` is set from the count: 0% clusters low, 100% clusters high. This was already true.
- Medoid cards carry `agent_interactions`, `decision_timeline`, `motive_summary`, `open_questions`, `conflict_metrics`. No file contains `control_response` or `late_reaction`.
- Ranking number is geometry. Selection-eval scores: 91.67 for both k = 6 runs, 100 for `batch9`.

---

## 2. How it helps

1. **A person reads a cluster in one paragraph.** For c3 of run 0.6113: "Ego passes CuttingIn at minimal clearance, brakes for Parking, CuttingIn then rear-ends Ego." That is a cluster of 55 trials, all collisions, explained without opening a trajectory.
2. **The k = 3 label hid a minority. k = 6 shows it** (section 4). The 55 trials of "Yield-Stop Collision" that are really pass-then-rear-ended exist only in the finer runs.
3. **Boundary cards give a reason, with numbers.** Run 0.6113, c1–c5: both sides pass first; clearance 0.2 m vs 0.0 m at t = 10.271 s; safe vs collision. The same pair is in `parameter_space_pairs/c1-c5/process/context.md`, so a person can check it.
4. **Labels now reflect more than the medoid.** The summary sees the collision count and the pair verdicts. The label revisions (Yield Collision → Yield-Stop Collision, Smooth Pass → Pass-Slowdown) came with those inputs, not from a prompt that asked for them. This is a hypothesis; one run each cannot separate "new input" from "model noise".
5. **The CART rules tell where in the parameter box.** R4: `OncomingStartDelay` in (3.855, 4.388] and `OncomingSpeed` > 2.374 → collision, support 1688, precision 0.82. Cross-validated accuracy 0.84 on 3869 trials. The rules are identical for both batch8 partitions, because they are fit on outcome and not on cluster.

---

## 3. What still needs improvement

Each item is a file that can be opened.

| # | Finding | Where | Effect |
| --- | --- | --- | --- |
| 1 | **A card contradicts itself.** Reason says "context names no lasting geometric split"; `critical_divergence` is t = 2.1 s, 27.3 vs 27.1 m, with a frame. | 0.5947 `c1-c5/output/contrast.yaml` | The verdict (distinct, outcome differs) is defensible; the divergence field is not. |
| 2 | **The deterministic "first persistent divergence" fires on noise.** 27.3 vs 27.1 m at 2.1 s; 254.9 vs 254.4 m at 2.8 s (batch9 c0–c3). No tolerance. | pair `process/context.md`, writer in `parameter_space_pair_packs.py` | The model quotes a split that is 0.2–0.5 m inside a 27–255 m gap. |
| 3 | **A chained label survived review.** `Late Yield Collision` is the example the reviewer prompt gives of a chained label. The reviewer wrote "consistent with target examples (rule 1)". | 0.6113 `output_cluster_label_review.json` row 4 | The reviewer does not apply its own rule 1. |
| 4 | **A duplicate label appeared.** c5 changed Safe Pass → Pass-Slowdown and now matches c4. The captions differ on the Parking row (c4 passes it, c5 yields to it). Reviewer: "same behavior family". Selection-eval flags it. | 0.5947 | The review cannot separate two clusters that differ on the secondary agent. |
| 5 | **The verdict flips with a clearance of 1.9 m.** c4–c5 similar → distinct on 5.7 vs 3.8 m, both safe. No threshold in the prompt for how large a lasting clearance gap must be. | 0.5947 `c4-c5` | A different small gap gives the other verdict. |
| 6 | **A pair compares different named vehicles.** c2 collides with Parking, c3 with Oncoming. "Distinct" comes from the vehicle, not from a behavior difference at one conflict. | batch9 `c2-c3` | Verdict is true and uninformative. |
| 7 | **Scenario parameters do not reach any prompt.** Medoid header is map, agents, outcome. The cluster file no longer carries parameter ranges (they stay in `cluster_aggregate.json`). | `context_medoid.md`, `context_cluster.md` | The model cannot say "this cluster sits at start delay 4.3–4.7". |
| 8 | **One medoid per cluster.** 886 trials in 0.6113 c1, `min_ttc` 0.05 s inside a 0% collision cluster. | `cluster_aggregate.json` | The caption describes one trial. |
| 9 | **Pair context still prints both ego speed and the 1-second average, azimuth, TTC up to 60 s.** The pair prompt still names the 1-second average. | `process/context.md`, `parameter_space_pair_prompt.txt` | Long lines; same quantity twice. |
| 10 | **Cross-cluster ratings are unstable between runs.** `batch9`: 9 / 9 → 7 / 8; LLM reading 90 → 75 with the same clusters. | `cross_cluster_eval.json` | An LLM rating is not a measurement. The ranking number ignores it. |
| 11 | **No faithfulness test.** No human label, no check that a why is right. Finding 1 was found by reading, not by a test. | — | A fluent card is not a verified card. |

Order of value: 2 (fix the writer), then 5 (state a clearance threshold), then 3 and 4 (reviewer), then 7.

---

## 4. Different clusterings of one dataset

Same 3000 trials, three partitions. Counts are trials.

**k = 3 (0.8032) against k = 6 (0.5947)**

| k = 3 \ k = 6 | noise | c0 | c1 | c2 | c3 | c4 | c5 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Pass-Slowdown (904) | 45 | 0 | 18 | 0 | 0 | 751 | 90 |
| Yield (753) | 0 | 753 | 0 | 0 | 0 | 0 | 0 |
| Yield-Stop Collision (1343) | 11 | 0 | 55 | 1237 | 40 | 0 | 0 |

**k = 3 (0.8032) against k = 6 (0.6113)**

| k = 3 \ k = 6 | noise | c0 | c1 | c2 | c3 | c4 | c5 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Pass-Slowdown (904) | 5 | 0 | 886 | 13 | 0 | 0 | 0 |
| Yield (753) | 0 | 753 | 0 | 0 | 0 | 0 | 0 |
| Yield-Stop Collision (1343) | 12 | 0 | 0 | 0 | 55 | 41 | 1235 |

What persists and what moves:

- **Yield (753 trials)** is the same set in all three. Safe, yield to CuttingIn. This is the most stable reading in the dataset.
- **Collision minority inside "Pass-Slowdown".** 18 of the 904 collide at k = 3. At k = 6 these 18 join 55 more in 0.5947 c1 (73 trials), and in 0.6113 they form c2 (13 trials) next to c3 (55). All are pass-then-rear-ended: the finer runs found one behavior (pass first, then brake for Parking, then be struck) that the k = 3 label could not show. This is the main benefit of a finer partition.
- **Collision minority inside "Yield-Stop Collision".** 55 of 1343 trials in the same pass-then-rear-ended group. Their k = 3 label was wrong for 4% of the cluster.
- **Late-yield collisions.** 40 trials (0.5947 c3) and 41 trials (0.6113 c4) are the same group at two silhouette values.
- **Large collision cluster.** 1237 (0.5947 c2) and 1235 (0.6113 c5) are the same group. Labelled "Yield Collision" in one run and "Cut-in Collision" in the other. The medoids differ (yield vs pass_first). One group, two readings from two medoids: **the label depends on which trial is the medoid.**
- **Safe pass group.** 0.5947 splits 841 trials into c4 (751) and c5 (90). 0.6113 keeps 886 as one cluster. The split is geometric: both are Pass-Slowdown with one secondary-agent difference.

Is the finer partition useful?

| Split | Behavior or geometry | Evidence | Useful |
| --- | --- | --- | --- |
| Pass-then-rear-ended minority leaves k = 3 clusters | **Behavior** | New label, different resolution row, outcome differs from its k = 3 parent | **Yes** |
| 0.6113 c2 / c3 (13 vs 55) | Geometry | Pair verdict `similar`; both rear-end; 2.7 vs 1.8 m after the pass | No, unless the 13 are a separate edge case. |
| 0.6113 c2 / c5 and c3 / c5 | Geometry for the pair | `similar`; Ego action differs at 8.2 s but clearance does not | No for behavior; c5 has a different medoid. |
| 0.5947 c4 / c5 | Weak | Same label, the verdict rests on 5.7 vs 3.8 m | Weak |
| Late-yield group (40 / 41) | Behavior | Medoid yield; stopped almost fully before the collision | Yes |

The geometry score ranks 0.5947 (70.54) above 0.6113 (68.02) even though 0.6113 has the higher silhouette part (0.806 vs 0.797). The difference comes from collision-rate spread (1.000 vs 0.943) and TTC spread (0.559 vs 0.492); tightness is 0.465 vs 0.481. The collision spread is a property of the cluster collision rates: 0.5947 has three clusters at 0% and three at 100% (SD 50 pp), 0.6113 has two at 0% and four at 100% (SD 47.1 pp). It does not measure behavior. The LLM reading prefers 0.6113 (75 vs 70). Neither reading says that one k = 6 run is better as a behavior partition.

Reading for a person: k = 3 gives the three outcome families. k = 6 adds one real behavior (pass, brake for Parking, be rear-ended) and several splits of the same behavior. A reader who wants the real structure keeps k = 3 and the pass-then-rear-ended group, and treats `similar` pair verdicts as a sign the split is geometric.

---

## 5. Checklist scored

### 5.1 `medoid_analysis_method_study.md` section 8 (one trial)

| # | Claim | Before | Now | Evidence |
| --- | --- | --- | --- | --- |
| 1 | Feed a window of states, not one stamp | Have | **Have** | 0.6113 c1 medoid: 211 frames, 20.93 s, 26 stamps from t = 1.5 s to 19.0 s. Each stamp has distance, azimuth, ego speed, TTC (under 5 s), image file. |
| 2 | Environment context beside the sequence | Missing | **Missing** | Header: map `hct_6`, agents, outcome. No weather, light, occlusion field exists in the trial table. |
| 3 | Scenario parameters of this trial in the medoid prompt | Missing | **Missing, and the range input to the summary is gone** | No `OncomingSpeed`/`OncomingStartDelay` in any `context_medoid.md`. The cluster file is the collision line now. |
| 4 | Verb from the rules, LLM writes the why | Partial | **Have** | No `control_response`, `late`, or `late_reaction` in 16 of 16 medoid files. Rows are agent + resolution; the timeline is timestamp + description. |
| 5 | A brake with no supporting agent is allowed | Missing | **Missing** | No `anomalous` value; every decelerate is pushed onto a named agent. |
| 6 | Prove the explanation is right | Missing | **Missing** | No human label or faithfulness score. Finding 1 in section 3 shows the need. |

### 5.2 `post_medoid_analysis_method_study.md` section 8 (cluster, ODD, collision)

| # | Claim | Before | Now | Evidence |
| --- | --- | --- | --- | --- |
| 1 | LLM interprets this trial (sequence in, why out) | Partial | **Partial** | Fence has resolution rows plus prose. The why is one trial's caption. |
| 2 | The why becomes a cluster meaning | Partial | **Partial** | Labels exist for 16 clusters. 3 problems remain: findings 3 and 4, and the same group named two ways (section 4). |
| 3 | The name is the cluster, not only the medoid | Missing | **Missing** | One medoid per cluster. `min_ttc` 0.05 s in a 0% cluster. The only cluster-wide fact the model reads is the collision count, and the notes quote it 16 of 16 while the captions quote it 0 of 16. |
| 4 | Matched parameters separate behavior from a geometry cut | Have | **Have, with caveats** | 22 pairs: 18 distinct, 4 similar. Caveats: findings 2, 5, 6. |
| 5 | ODD edge = LLM reads collision texts and names shared weather | Wrong tool | **Wrong tool** | S3 rule R4 writes the edge. No weather is sampled. |
| 6 | Collision boundary = LLM labels each second | Numbers only | **Numbers only** | Per stamp TTC and clearance; S2 lists cluster-boundary trials (904 and 741 at kNN = 10). No per-second LLM label, by design. |
| 7 | "Critical" = failed to brake within 0.5 s | Missing | **Missing** | No compiler for brake-time vs conflict-time. |
| 8 | Parameters are enough for rows 5–7 | Enough for this scenario | **Same** | Two numeric axes; 3869 trials. No rain, visibility, light. |

Goal achieved? **Part of it.** Achieved: sequence in, why out (medoid row 1, 4); behavior-versus-geometry test for matched pairs (post row 4); an ODD parameter edge from S3. Not achieved: weather or occlusion context, the parameters inside the prompt, a name for the cluster rather than one medoid, a brake-timing flag, and proof that a why is correct. Two of these (weather, light) cannot be reached from this data.

---

## 6. Limits

- One medoid per cluster and one pair per boundary.
- One scenario family, two sampled parameters, one dataset for the cross-partition comparison.
- A pair `similar` or `distinct` call is one model call at temperature 0.1. The 0.5947 c4–c5 flip shows the call is not stable near a small gap.
- Collision rate is measured; every label, caption, and rating is a model reading.
- This is not an ODD specification, an ODD boundary, or a safety case. S3 rules are hypotheses on sampled trials. Geometry 68–71 does not assign a driving-automation level.
- Saved `cluster_summary.yaml` for `3_cluster_s=0.8032` is from the earlier run and was not regenerated here.
- Pair-writer speed fields, azimuth, and the pair prompt wording are as before. `analysis_flow_ppt.md` is not edited.
