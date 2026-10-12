# Analysis flow — presentation

Run: batch 8, k = 3, silhouette 0.8032. LLM: gemini-2.5-flash, temperature 0.1.
Clustering (MFPCA + HDBSCAN, whole trajectory) is already done. These pages start after it.
k = 6 check (same batch, silhouette 0.5947 and 0.6113, rebuilt 2026-10-02): pages 24–25.

- `ppt:` slide text.
- `notes:` speaker only.

Method pages: Goal → Method → Why sound → Limits.

===

page 1
title: What this project does
ppt:


|           |                                                                          |
| --------- | ------------------------------------------------------------------------ |
| Input     | MFPCA + HDBSCAN clusters of simulated trials                             |
| Gap       | A cluster is only trial IDs. Its meaning needs manual inspection.        |
| This work | Explain each cluster and each cluster boundary, with evidence            |
| Output    | Medoid card · boundary-pair card · cluster label                         |


Principle: geometry decides, the LLM explains. The LLM never changes clusters or ranking.

notes:
Not a new clustering method. A reading layer on top. Standards comparison: page 26.

===

page 2
title: Analysis flow
ppt:


| Layer               | Step                    | Question                                            | Prompt                                   |
| ------------------- | ----------------------- | --------------------------------------------------- | ---------------------------------------- |
| Deterministic       | 1. Preprocess           | What happened, and when?                            | none                                     |
| LLM                 | 2. Medoid               | What does this trial do, and why?                   | medoid_trial + system + glossary         |
| LLM                 | 3. Parameter pair       | similar inputs, different trajectory: what differs? | parameter_space_pair + system + glossary |
| LLM                 | 4. Summary, then review | What is each cluster called?                        | cluster_summary, then cluster_reviewer   |
| No new judgment     | 5. Report and Q&A       | Show the cards; answer from them                    | odd_chat for the question only           |


Pages 7–9 are the context files. From page 11, each stage is two pages: the prompt, then the result.

Rules:

1. LLM sees computed numbers and images, never raw trajectories.
2. Outcome, collision rate, risk: copied from data.
3. Ranking: geometry only.

===

page 3
title: Preprocess — overview
ppt:
Goal: one trial (36 s, 361 frames, 3 vehicles) → small evidence pack, readable by LLM, checkable by a person.


| Step               | Output                  |
| ------------------ | ----------------------- |
| 1 Event extraction | full event log          |
| 2 Filter           | timestamp list (stamps) |
| 3 BEV images       | one image per stamp     |
| 4 Text context     | one sentence per stamp  |


- No LLM. Same trial → same pack.
- Image k and sentence k = same stamp.

notes:
Example on pages 4–7: c1 medoid. CuttingIn pulls out ahead of Ego; near-miss at 10.0 s; no collision. Parking stands further ahead.

===

page 4
title: Step 1 — Action extractor
ppt:
Goal: 361 frames → timed events.


| Action                  | Rule                                                                       |
| ----------------------- | -------------------------------------------------------------------------- |
| Accelerate / decelerate |                                                                            |
| Emergency brake         | mean a ≤ −4 m/s²                                                           |
| Stopped                 | v < 0.3 m/s, ≥ 1 s                                                         |
| Lane change             | lane ID changes on same road; 1–3 s                                        |
| Turn (same lane)        |                                                                            |
| Enter / exit junction   | Ego enters or leaves a junction road. Left or right when the path says so. |


Constant speed is not an event: it is the baseline between actions.


| Interaction (Ego vs vehicle) | Rule                                                 | Time         |
| ---------------------------- | ---------------------------------------------------- | ------------ |
| Collision                    | simulator collision record                           | contact      |
| Near-miss                    | TTC < 2.5 s while closing; min center distance ≤ 5 m | min distance |
| Closest approach             | min body gap < 5 m; max 2 vehicles                   | min gap      |


Body gap = shortest distance between vehicle rectangles.

c1: near-miss with CuttingIn at 10.0 s; 4.51 m; min TTC 1.88 s.

Why sound:

- Explicit rules; any event can be recomputed.
- Collision from the simulator, never inferred.

Limits:

- Thresholds hand-set, not validated against human labels.
- TTC: constant speed, center distance.

notes:
TTC 2.5 s sits between the common 1.5 s and 3 s conflict thresholds. If the simulator records a collision without the partner, the vehicle within 0.5 m body gap is taken.

===

page 5
title: Step 2 — Filter
ppt:
Goal: keep only the stamps that explain Ego's decision.
Stamp = one time → one image + one sentence. Event log unchanged.

Stamps:


| #   | Rule                                                                    |
| --- | ----------------------------------------------------------------------- |
| 1   | Conflict: collision / near-miss / closest-approach time                 |
| 2   | Burst (collision, near-miss only): −2, −1, −0.5, −0.2, +0.2, +0.5, +1 s |
| 3   | Actions: start + end of every event that passes F1–F3                   |
| 4   | Merge: stamps < 0.1 s apart → one                                       |


Filters:


| ID  | Drops                                          | Why                     |
| --- | ---------------------------------------------- | ----------------------- |
| F1  | Junction enter or exit while Ego goes straight | Heading does not change |
| F2  | other vehicle: stopped                         | no decision             |
| F3  | other vehicle's copy of a collision            | duplicate of Ego's      |


c1:


| Event                                  | Kept | Why        |
| -------------------------------------- | ---- | ---------- |
| near-miss, 10.0 s                      | yes  | 1 conflict |
| 8.0, 9.0, 9.5, 9.8, 10.2, 10.5, 11.0 s | yes  | 2 burst    |
| Ego decelerates 7.8–9.5 s              | yes  | 3 actions  |
| Ego enters junction straight, 0 s      | no   | F1         |
| CuttingIn, Parking stopped             | no   | F2         |


Why sound:

- Nothing invented: event times or fixed offsets.
- All Ego actions kept.
- Burst −2 s before, +1 s after: cause precedes conflict.

Limits:

- No image between stamps.
- Fixed offsets, not speed-scaled.

notes:
Closest approach gets no burst, unless the trial has no collision or near-miss.

===

page 6
title: Step 3 — BEV images
ppt:
Goal: show layout and motion that numbers do not.


| Camera   | Rule                                                       |
| -------- | ---------------------------------------------------------- |
| Center   | Ego                                                        |
| Zoom     | half-width = distance to conflict vehicle + margin, 8–40 m |
| Rotation | fixed: Ego's initial heading up                            |



| Mark       | Meaning                                   |
| ---------- | ----------------------------------------- |
| orange box | Ego, true size                            |
| blue boxes | other vehicles, numbered                  |
| arrow      | heading, length ∝ speed                   |
| trail      | path so far                               |
| corners    | time + event · distance + TTC · scale bar |




c1: 1.9 s → 34.9 m → view ±37.5 m. 10.0 s → 4.5 m → view ±8 m.
Pairs: two panels, shared clock, same scale.

Why sound:

- Both vehicles always in view.
- Fixed rotation: frames comparable in sequence.

Limits:

- Zoom varies → box size is no distance cue; use the text numbers.
- Zoom follows the conflict vehicle; a second vehicle can be off-frame (covered in text, page 7).

===

page 7
title: Step 4 — Context builder
ppt:
Goal: one measured sentence per stamp. The model reads geometry. It does not estimate it.

This file: `cluster0/processed/context_medoid.md`. Header, then 20 stamps.

Header of this medoid: cluster [c0], outcome safe, map hct_6, 20.96 s, 211 frames. Agents: Ego, CuttingIn, Parking. The header says to infer pass or yield from how “who is ahead” changes. It does not write the verdict.

CuttingIn is on every line. Parking is added on that same line only when it is within 40 m at that stamp. No extra stamp. No image removed.

Rebuilt line, c0 at t=6.90 s. The pieces agree with each other.


| On the line                    | This stamp                                                                     |
| ------------------------------ | ------------------------------------------------------------------------------ |
| Event                          | Ego ends acceleration (started at t=2.40 s)                                    |
| Center distance                | center-to-center distance=11.5 m                                               |
| Azimuth                        | CuttingIn azimuth relative to Ego heading=FRONT (27.1°)                        |
| Position                       | CuttingIn position in Ego coordinates=(10.3 m ahead of ego, 5.2 m left of ego) |
| Who is ahead                   | longitudinal relationship=CuttingIn ahead of Ego                               |
| Body gap                       | minimum distance between vehicle boundaries=6.0 m                              |
| Ego speed                      | ego speed=6.9 m/s                                                              |
| Lateral speed, heading vs road | lateral_speed=-0.44 m/s, heading_vs_road=-176.4°                               |
| Time to collision              | estimated time to collision≈3.41 s                                             |
| CuttingIn speed                | CuttingIn speed=3.25 m/s                                                       |
| Closing rate                   | center-to-center distance closing at 3.4 m/s                                   |
| Image                          | frame: `t_06.90_ego_end_ACCELERATE.jpg`                                        |


Limits:

- Position, azimuth, and “who is ahead” are three different facts on one line. At this stamp they agree. At t = 9.50 s they do not: the position is 0.5 m behind, and “who is ahead” still says overlap.
- `heading_vs_road` is near ±180° on almost every stamp of this pass. Read the sideways speed.
- Parking’s clause does not repeat Ego’s speed. The speed on the line is the one next to CuttingIn.

Same geometry words. Not the same rule as the pair file.


|                                    | Medoid, rebuilt                  | Pair `c0-c2`, not rebuilt                                             |
| ---------------------------------- | -------------------------------- | --------------------------------------------------------------------- |
| Ego speed                          | on, at the stamp                 | on, and the pair line still also prints the previous-1-second average |
| Average speed, previous 1 s        | off                              | on                                                                    |
| Time to collision                  | only under 5 s                   | on the stamp, including 9.4 s at 39 m                                 |
| Closing rate                       | only when centers are under 15 m | on every stamp                                                        |
| `lateral_speed`, `heading_vs_road` | on                               | absent                                                                |
| Pass or yield                      | not written                      | a rule line above the timeline                                        |
| Sides                              | one trial, plus the image name   | two trials, one shared clock                                          |


notes:
The words “near ahead” are gone from this file. The previous-1-second average is gone too. At t = 6.90 s the line says ego speed = 6.9 m/s. Azimuth is still on the line. The glossary tells the model to read the sector word and the degrees together.

===

page 8
title: Cluster summary inputs
ppt:
Three inputs. The cluster file is the collision count.


| Input                | This run                                                 |
| -------------------- | -------------------------------------------------------- |
| Medoid trial YAML    | The caption                                              |
| Pair contrast YAML   | The neighbor block                                       |
| `context_cluster.md` | c0: 18/904 (1.99%). c1: 0/753 (0%). c2: 1343/1343 (100%) |


The model writes the label, the caption, the consistency note, the motive note, and the neighbor block. The pipeline then sets `risk_level` from this same count.

notes:
`cluster0/processed/context_cluster.md` is now that one line. The summary prompt slot is the same file. The consistency note asks whether the count matches the medoid outcome.

===

page 9
title: Pair file
ppt:
This file: `parameter_space_pairs/c0-c2/process/context.md`. One shared clock. Two sides on every line.

Header: parameter distance 0.0072. Both sides CuttingIn. c0 safe, c2 collision. Both rules say Ego passed first. Body gap 0.2 m versus 0.0 m. First persistent divergence t = 10.271 s.

Line at t = 10.27 s. The same fields are written on every alive side.


| On the line                 | This stamp, [c0]                                                                   | This stamp, [c2]                                                            |
| --------------------------- | ---------------------------------------------------------------------------------- | --------------------------------------------------------------------------- |
| Ego speed                   | ego speed=6.6 m/s                                                                  | ego speed=6.2 m/s                                                           |
| CuttingIn speed             | CuttingIn speed=2.3 m/s                                                            | CuttingIn speed=2.3 m/s                                                     |
| Center distance             | center-to-center distance=5.7 m                                                    | center-to-center distance=5.4 m                                             |
| Azimuth                     | CuttingIn azimuth relative to Ego heading=BEHIND LEFT (145°)                       | CuttingIn azimuth relative to Ego heading=BEHIND LEFT (144°)                |
| Opening rate                | center-to-center distance opening at 3.0 m/s                                       | center-to-center distance opening at 2.6 m/s                                |
| Position                    | CuttingIn position in Ego coordinates=(4.6 m behind ego, 3.3 m left of ego)        | CuttingIn position in Ego coordinates=(4.4 m behind ego, 3.2 m left of ego) |
| Who is ahead                | longitudinal relationship=CuttingIn behind Ego (Ego has passed)                    | longitudinal relationship=CuttingIn behind Ego (Ego has passed)             |
| Body gap                    | minimum distance between vehicle boundaries=0.2 m                                  | minimum distance between vehicle boundaries=0.0 m                           |
| Average speed, previous 1 s | ego average speed during previous 1 second=6.5 m/s                                 | ego average speed during previous 1 second=6.6 m/s                          |
| Event                       | post-conflict phase with CuttingIn; Ego ends deceleration; Ego begins deceleration | collision with CuttingIn; post-conflict phase with CuttingIn                |




Parking is added on that same line when it is within 40 m. At this stamp it is about 24 m ahead on both sides. A side that has ended prints `ended (out of frame / clip)`. At t = 12.10 s, c2 has ended. Layer 2 then continues c0 alone: one collision, the other still alive.

notes:  
The pair line has no `lateral_speed` and no `heading_vs_road`. Time to collision is not limited to 5 s. The medoid line is.

===

page 10
title: Shared prompts — system and glossary
ppt:
Both files are attached to the medoid, pair, and summary calls. The reviewer and Q&A do not load them.

`system_prompt.txt` — how every answer is written.


| Rule                        | What it requires                                                                             |
| --------------------------- | -------------------------------------------------------------------------------------------- |
| Every claim has a source    | The number, or the image, must be in the input. Do not add a fact.                           |
| One fixed behavior word     | Pass first, yield, or unresolved. The rule for which one is in the glossary.                 |
| A short reason              | One or two sentences. Do not narrate every road and junction.                                |
| Using same names in a reply | Call a cluster `[c0]`. Call a vehicle by the name in the file: CuttingIn, Oncoming, Parking. |
| CoT reply                   | Think first, then one YAML block. Do not invent a collision rate.                            |


`common_sense.txt` — what the words on the context line mean, and the pass/yield gate. The model does not recompute a number.


| Section              | What it says                                                                                                                      |
| -------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| Distances and speeds | Center distance, body gap, time to collision, closing rate, and Ego speed at that moment                                          |
| The BEV              | The frame is cropped around the named vehicle. Parking can be missing from the image and still be in the text.                    |
| Who is ahead         | Ahead, overlap, or behind. The cut is 2.5 m.                                                                                      |
| Two angles           | Azimuth is where the other vehicle is. Heading versus road is where Ego's nose points.                                            |
| Pass or yield        | Yield: Ego brakes and the other vehicle is not behind. Pass first: Ego goes through. A later brake is a new row.                  |
| What to trust first  | The recorded outcome and the body gap, then who is ahead, then speed. A reason may use only what was already true at that moment. |


notes:
Ahead means the named vehicle's center is more than 2.5 m forward of Ego's center. Behind means more than 2.5 m back. The band between is overlap. Body gap is the distance between the vehicle rectangles, and it is a different length from the center distance. Time to collision is center distance divided by the closing rate, and it is not a prediction that a collision will happen.

===

page 11
title: Medoid — the prompt
ppt:
Goal: what this one trial does, and why.

File: `medoid_trial_prompt.txt`, plus page 10.
The model reads the sections in this order.


| Section        | What it tells the model                                                                                                                                                                                          |
| -------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Your Task      | Analyze the medoid trial. Read the context file, the images, and the recorded numbers. Then explain why.                                                                                                         |
| Collision      | If the outcome is collision: decide the impact type, the striking vehicle, and the struck vehicle at the collision stamp. A vehicle that is stopped is struck. Write one sentence that names the touching sides. |
| Workflow       | List 6–12 facts from the file. Write pass first or yield first. Then the action, a quote, one reason.                                                                                                            |
| Word list      | slow down, speed up, hard brake, or maintain speed. Quote the speed from the line.                                                                                                                               |
| Output         | Five fields only: who Ego responded to, the timeline, the collision sentence, the short summary, open questions.                                                                                                 |
| Motive summary | 2–4 sentences. Not a second timeline.                                                                                                                                                                            |
| Medoid context | The file from page 7, pasted at the end.                                                                                                                                                                         |


Each row is one vehicle plus pass first, yield, or unresolved. Parking gets a row when Ego reacts to it. The model writes the impact type, the two vehicle names, and the collision sentence. The pipeline adds only `bearing_sector`, the azimuth bin at the collision stamp.

notes:
Intensity follows the speed change: about 2 m/s, 2–5 m/s, above 5 m/s. A resume with nobody ahead has no why. Evidence for a why is at or before that stamp. A cluster name such as Late Yield is written by the summary, not here.

===

page 12
title: Medoid — the result
ppt:
File: `clusterN/output/medoid_trial.yaml`.


| Field                         | What it tells                                                      |
| ----------------------------- | ------------------------------------------------------------------ |
| `agent_interactions`          | Ego responded:pass_first / yield / unresolved                     |
| `decision_timeline`           | Each time stamp with the action description and reason intertrep   |
| `motive_summary`              | summarize the trial in 2–4 sentences                               |
| `collision_detail`            | Collision only: impact type, striking and struck vehicle, sentence |
| `open_questions`              | Empty unless the input information contradicts itself              |
| `outcome`, `conflict_metrics` | Copied by the deterministic rule                                   |


This run, c0. Safe. CuttingIn `pass_first`. Parking `pass_first`.

> Ego passes CuttingIn by accelerating and then braking late, resulting in a near-miss with 1.4 m minimum clearance before CuttingIn is behind. After passing CuttingIn, Ego encounters a stationary Parking vehicle … decelerates when very close (0.9 m) before passing it.

c1: yield, safe. c2: yield, collision.

notes:
The quote is `motive_summary` from `cluster0/output/medoid_trial.yaml`. The saved timeline still uses the older “near ahead” wording. The current context file does not.

===

page 13 title: 

Parameter pair — the prompt ppt: 

Goal: similar parameter inputs, different clusters from the whole-trajectory embedding. Find the trajectory difference.

File: `parameter_space_pair_prompt.txt`, plus page 10.
Pair selection (z-score, closest pair, distance ≤ 0.1, align clocks) is done before this prompt.


| Section         | What it tells the model                                                                                                              |
| --------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| Your Task       | Similar inputs. Different trajectory. Find that trajectory difference.                                                               |
| How to read     | Compare the information of pair. The cluster medoid output is a reference.                                                          |
| Workflow        | Name the first time the two trajectories start to differ. Then pass first or yield for each side. Write the verdict last.            |
| Behavior call   | distinct, similar, or inconclusive. Safe versus collision is enough for distinct.                                                    |
| Divergence hunt | Earliest time the trajectories start to differ and stay apart: a brake, the body gap, who is ahead, or the speed. Do not invent one. |
| Pair context    | The file from page 9.                                                                                                                |
| Medoid extracts | Each cluster's medoid card, pasted after. Comment only. Do not copy it onto a side.                                                  |
| Output          | The verdict is the last field.                                                                                                       |




notes:
The pair prompt still names “Ego average speed during the previous 1 second,” because the pair file still prints it.

===

page 14
title: Parameter pair — the result
ppt:
File: `parameter_space_pairs/cA-cB/output/contrast.yaml`.


| Field                        | What it tells                                                              |
| ---------------------------- | -------------------------------------------------------------------------- |
| `left` / `right`             | Each side: pass first, yield, or unresolved, plus one sentence of evidence |
| `critical_divergence`        | The time the trajectories start to differ, and what differs then           |
| `contrast_explanation`       | The story of the two trials                                                |
| `behavior_similarity`        | Distinct, similar, or inconclusive                                         |
| `behavior_similarity_reason` | The one line that justifies that call                                      |


This run, c0–c2. Distance 0.0072. Both CuttingIn.


|                  | [c0]       | [c2]      |
| ---------------- | ---------- | --------- |
| Saved resolution | pass_first | yield     |
| Outcome          | safe       | collision |
| Body gap         | 0.2 m      | 0.0 m     |


Verdict: distinct. Divergence at t = 10.271 s.

c1–c2: distinct, both yield, safe vs collision. c0–c1: distance 0.63, skipped.

Limits: one pair per boundary. 0.1 is relative to the sampled range.

notes:
The pair file's rule lines both say Ego passed first. The saved card calls [c2] a yield by copying the c2 medoid. That card predates the line that forbids copying a medoid motive.

===

page 15
title: Cluster summary — the prompt
ppt:
Goal: name the cluster, then summarize its behavior.

File: `cluster_summary_prompt.txt`, plus page 10.
One call per cluster. It does not see the other names.


| Section         | What it tells the model                                                    |
| --------------- | -------------------------------------------------------------------------- |
| Your Task       | Name the cluster. Compare the medoid and the pairs, then summarize the cluster behavior. |
| Workflow        | Read the medoid, then each pair.            |
| Caption guide   | First the medoid. Then each pair: what is shared, and what differs.        |
| Output          | The name and the caption. Python writes the neighbor list and distinct, similar, or mixed. |


The consistency note asks whether the collision count matches the medoid outcome.

notes:
`cluster.json` is not in the prompt. Risk level is set after the call, from the same count.

===

page 16
title: Cluster summary — the result
ppt:
File: `clusterN/output/cluster_summary.yaml`.


| Field                     | What it tells                                  |
| ------------------------- | ---------------------------------------------- |
| `label`                   | The name on the legend, 2–4 words              |
| `caption`                 | Why that name, including the neighbor          |
| `consistency_note`        | Whether the collision count matches the medoid |
| `motive_consistency_note` | Whether the caption matches the medoid         |
| `neighbor_comparison`     | Each neighbor's verdict, copied from the pair  |
| `neighbor_behavior`       | Python counts the pair calls: distinct, similar, mixed, or ambiguous |
| `risk_level`              | Set after the call, from the collision count   |


This run, c0. Label: Pass-Slowdown. Risk: low.

> Cluster [c0] is a Pass-Slowdown archetype. Ego passes CuttingIn … near-miss with 1.4 m … then … Parking … 0.9 m … Both interactions resolve as pass_first and the trial is safe. The pair c0–c2 is distinct.

The note quotes 1.99%. c1: Yield, 0%. c2: Yield-Stop Collision, 100%.

notes:
These three files are the previous model run. The cluster file they read still had more than the collision line.

===

page 17
title: Label review — the prompt
ppt:
Goal: two clusters with the same name get one added word, taken from how their behavior differs.

File: `cluster_reviewer_prompt.txt`.
Its own system line asks for JSON. It does not load page 10.


| Section       | What it tells the model                                                                                                 |
| ------------- | ----------------------------------------------------------------------------------------------------------------------- |
| Your Task     | Rename only when two names are the same or near-same and the behavior differs. Add one word. Do not add new evidence.   |
| Workflow      | Mark shared names. Compare their cards. Same behavior: no change. Different: add one word you can quote from the cards. |
| Cluster cards | For every cluster, in one prompt: the full summary card and the medoid card.                                            |
| Output        | One row per cluster, same order.                                                                                        |


The text the model reads is saved: `cluster_analysis/context_label_review.md`.

The added word comes from the cards. Example: the longer gap between the brake and the conflict peak (peak_t minus brake_t) is `Proactive`, the shorter is `Late`.

===

page 18
title: Label review — the result
ppt:
File: `cluster_analysis/cluster_label_review.json`.
A changed name is also written back onto that cluster's summary.


| Field            | What it tells                                                      |
| ---------------- | ------------------------------------------------------------------ |
| `original_label` | The name the summary wrote                                         |
| `new_label`      | The same name, or the replacement                                  |
| `changed`        | Whether this row was rewritten                                     |
| `reason`         | The shared name and the numbers that differ, or “no change needed” |


This run: three rows, none changed.


| Cluster | Name                 | Reason           |
| ------- | -------------------- | ---------------- |
| c0      | Pass-Slowdown        | no change needed |
| c1      | Yield                | no change needed |
| c2      | Yield-Stop Collision | no change needed |


notes:
The reviewer did not re-read the images or the pair cards.

===

page 19
title: Report and Q&A — the prompt
ppt:
Goal: show the saved results, and answer a question from those results.


| Part   | Prompt                       | What the text requires                                            |
| ------ | ---------------------------- | ----------------------------------------------------------------- |
| Report | none                         | Assembled from the saved cards                                    |
| Q&A    | `odd_chat_system_prompt.txt` | The briefing is the only source. Do not add a number.             |
| Rules  | none in this call            | A tree of depth 3 or less, on speed and delay. This run: 8 rules. |


The Q&A prompt is six rules, in order:

1. Use only the briefing.
2. If it is missing, name the step that would produce it.
3. Keep a measured number separate from a model sentence.
4. Do not call the rules the ODD.
5. End with Sources.
6. Prefer numbers.

===

page 20
title: Report and Q&A — the result
ppt:
The report only shows the saved results. The answer to a question is one reply, and it ends with the sources it used.


| Shown                         | Where it comes from        |
| ----------------------------- | -------------------------- |
| Cluster name, caption, risk   | `cluster_summary.yaml`     |
| Medoid resolution and outcome | `medoid_trial.yaml`        |
| Pair verdict                  | `contrast.yaml`            |
| Collision rate, trial count   | `cluster.json`             |
| Rules                         | `odd_parameter_rules.json` |


A rule is a hypothesis on the sampled trials. This run's collision rule: start delay in (3.855, 4.388] and speed above 2.374, support 1688, precision 0.82.

notes:
The report does not draw parameter ranges, TTC, or the consistency note. The rule numbers are from the batch 8 tree, which is fit on outcome, so the same eight rules appear for every partition of this batch.

===

page 21
title: This run
ppt:


|                | c0               | c1             | c2                   |
| -------------- | ---------------- | -------------- | -------------------- |
| Trials         | 904              | 753            | 1343                 |
| Collision rate | 1.99%            | 0%             | 100%                 |
| Mean TTC       | 3.91 s           | 1.50 s         | 0.01 s               |
| Label          | Pass-Slowdown    | Yield          | Yield-Stop Collision |
| Medoid         | pass first, safe | yield, safe    | yield, collision     |
| Neighbor       | c0–c2 distinct   | c1–c2 distinct | both distinct        |


The ranking number is geometry.


| Part (× 0.25)          | This run |
| ---------------------- | -------- |
| Silhouette (s + 1) / 2 | 0.90     |
| Collision-rate spread  | 0.93     |
| TTC spread             | 0.54     |
| Tightness              | 0.06     |


Geometry 60.7 (rank).

notes:
Tightness is relative (page 23). The 50 percentage-point and 3 s divisors are chosen.

===

page 22
title: Contribution
ppt:


| Question                          | Answer                                                              |
| --------------------------------- | ------------------------------------------------------------------- |
| What stands for each cluster?     | medoid card, every claim tied to a stamp and image                  |
| What separates neighbors?         | 2 matched pairs, both distinct                                      |
| Which clusters are not neighbors? | c0–c1 (distance 0.63): no boundary claim                            |
| Is a finer split real?            | k = 6: pair card marks the non-behavioral split "similar" (page 25) |
| Does the LLM change clustering?   | no; rank = geometry (60.7)                                          |


Automatic and auditable: deterministic evidence, then constrained LLM reading.

===

page 23
title: Weakness
ppt:


| Issue                         | Evidence                                                                                           | Consequence                                                        |
| ----------------------------- | -------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------ |
| Tightness is relative         | spreads 2.02 / 2.31 / 2.19 → 0.06                                                                  | geometry 60.7 understated; k = 6 outranks k = 3 by this part alone |
| Contact below resolution      | c1–c2: safe trial's body gap also 0.0 m                                                            | safe vs collision decided < 0.1 m                                  |
| One medoid                    | c0: 18/904 collided, medoid safe                                                                   | minority unseen at k = 3; k = 6 shows it (page 25)                 |
| LLM text ≠ measurement        | c0–c2: c2 side called yield, copied from the c2 medoid; same trial = pass first in both k = 6 runs | claims must come from the pair                                     |
| Resolution edge case          | c0: "pass first", but Ego brakes at 0.9 m                                                          | by the rule: yield                                                 |
| Stop at contact missed        | Ego 3.0 → 0.2 m/s in 1.3 s, then hit; "stopped" needs ≥ 1 s                                        | yield-stop collision read as late yield                            |
| Label review kept duplicates  | k = 6: two clusters both "Yield Collision" / "Rear-end Collision"                                  | that run's review saw captions only; it now reads full cards (not re-run) |
| Hand-set thresholds           | 2.5 s, 0.5 s, 15° / 40°, 0.1                                                                       | not validated                                                      |
| Scope                         | one scenario, 2 parameters, k = 3 (+ k = 6 check)                                                  | no claim beyond this box                                           |


notes:
Tightness: 1 − 2.02/2.31 = 0.12, 0, 1 − 2.19/2.31 = 0.05 → mean 0.06. c1–c2: gap rounded to 0.1 m; rectangle ≠ simulator collision shape. Present it as a sensitive boundary, not a behavioral one.

===

page 24
title: k = 6 check — two finer partitions
ppt:
Goal: same 3000 trials, k = 6. Does the reading still hold? Does it find anything new?
Full rebuild + LLM, same settings as k = 3.


|                              | k = 3 (s 0.80) | k = 6 (s 0.59) | k = 6 (s 0.61) |
| ---------------------------- | -------------- | -------------- | -------------- |
| Safe / collision clusters    | 2 / 1          | 3 / 3          | 2 / 4          |
| Paper's six patterns (3 / 3) | —              | yes            | no             |
| Pairs kept (≤ 0.1)           | 2              | 9              | 9              |
| Pairs "similar"              | 0              | 1              | 3              |
| Distinct labels              | 3 / 3          | 5 / 6          | 5 / 6          |
| Geometry score               | 60.7           | 70.5           | 68.0           |
| Geometry without tightness   | 79.1           | 78.5           | 74.7           |


s 0.59 against the paper's six patterns:


| Cluster | Trials | Collision | Paper pattern        | Medoid                 | LLM label          | Match   |
| ------- | ------ | --------- | -------------------- | ---------------------- | ------------------ | ------- |
| c0      | 753    | 0%        | yield                | yield, safe            | Proactive Yield    | yes     |
| c4      | 751    | 0%        | smooth pass          | pass first, safe       | Pass-Slowdown      | swapped |
| c5      | 90     | 0%        | pass-slowdown        | pass first, safe       | Safe Pass          | swapped |
| c2      | 1237   | 100%      | cut-in collision     | yield, collision       | Yield Collision    | partial |
| c1      | 73     | 100%      | braking rear-end     | pass first, rear-ended | Rear-end Collision | yes     |
| c3      | 40     | 100%      | yield-stop collision | yield, collision       | Yield Collision    | partial |


Pass vs not pass: 6 / 6. Names: 2 match, 2 partial, 2 swapped.

notes:
s 0.61 = same trials regrouped: c4 + c5 merged (886), c1 split 13 + 55. The 753-trial yield cluster is identical in all three runs.
Paper mapping is from all-member statistics (pass, stop, speed drop after passing), made before this LLM run; c4 / c5 assignment rated "likely".
Swapped: after passing, c4 members lose 2.69 m/s (median), c5 4.49 m/s; mean TTC 4.15 vs 3.30 s. So c4 is the smoother pass. The labels follow the medoids: c4's medoid brakes before passing, c5's after.
Without tightness = mean of silhouette, collision spread, TTC spread × 100.

===

page 25
title: Does k = 6 help?
ppt:

Helps:


| Finding                      | Evidence                                                                                                                          |
| ---------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| Pass vs yield holds          | medoid resolution = paper's pass split, 6 / 6                                                                                     |
| Hidden minority explained    | k = 3 c0's 18 collisions + 55 of k = 3 c2 = one mechanism (s 0.59 c1): Ego passes, brakes for Parking, CuttingIn hits from behind |
| Second-vehicle rule pays off | that mechanism is explained only through Parking (page 7)                                                                         |
| Weak splits flagged          | s 0.59 c4–c5 "similar" = paper's open smooth-pass vs pass-slowdown question. s 0.61 c2–c3 "similar" = rear-end group cut 13 / 55  |
| Same input, same verdict     | 6 trial pairs appear in both k = 6 runs: verdict same 5 / 6, side resolution same 9 / 12                                          |


Exposes:


| Issue                   | Evidence                                                                                       | Fix                                        |
| ----------------------- | ---------------------------------------------------------------------------------------------- | ------------------------------------------ |
| Stop at contact missed  | s 0.59 c3 medoid: 3.0 → 0.2 m/s in 1.3 s, hit at 0.2 m/s                                       | event "stopping at contact"                |
| Label from one medoid   | c4 / c5 names opposite to member statistics                                                    | give summary the member speed drop         |
| Review keeps duplicates | s 0.59: c2 = c3 "Yield Collision" (members stop 0.2% vs 88%). s 0.61: c3 renamed to c2's label | review reads statistics, not captions only |
| Pass / yield unstable   | all 3 side flips in the cut-in collision cluster                                               | contact during overlap → unresolved        |
| Rank follows tightness  | k = 6 > k = 3 only via tightness (0.47 vs 0.06)                                                | absolute tightness scale                   |


Answer: yes, as a test. It confirms pass vs yield, finds the rear-end mechanism, and flags non-behavioral splits. Keep k = 3 as the main run until the stop event and the label review are fixed.

notes:
Same input = identical trial pair, different cluster IDs per run. The verdict flip (one pair, distinct ↔ similar) follows a side flip: the same collision trial read as yield in one run, pass first in the other.
Stop rule: v < 0.3 m/s for ≥ 1 s; this medoid is under 0.3 m/s for only 0.2 s before contact.
Pass split 6 / 6 is against the paper's text. By member statistics c2 is mixed (66% pass); its pair sides also mix yield, unresolved, pass first.
s 0.61 also marks c2–c5 and c3–c5 "similar" (all pass first + collision on the boundary).

===

page 26
title: Against current ODD standards
ppt:


| Standard                  | Requires                                        | This run                    |
| ------------------------- | ----------------------------------------------- | --------------------------- |
| ISO 34503:2023            | taxonomy + format of ADS operating conditions   | 2 parameters of 1 scenario  |
| ASAM OpenODD 1.0.0 (2025) | machine-readable ODD, inside/outside boundary   | 8 decision-tree rules       |
| ISO 21448:2022 (SOTIF)    | known hazards evaluated; residual-risk argument | c2 = known collision region |
| SAE J3016                 | ODD is a property of the feature design         | internal scores only        |


Position: evidence for an ODD analysis, not an ODD definition.

notes:
Checked 2026-10-01.

- ISO 34503:2023: [https://www.iso.org/standard/78952.html](https://www.iso.org/standard/78952.html)
- ASAM OpenODD 1.0.0: [https://publications.pages.asam.net/standards/ASAM_OpenODD/ASAM_OpenODD/latest/specification/03_terms_and_definitions/03_terms_and_definitions.html](https://publications.pages.asam.net/standards/ASAM_OpenODD/ASAM_OpenODD/latest/specification/03_terms_and_definitions/03_terms_and_definitions.html)
- ISO 21448:2022: [https://www.iso.org/standard/77490.html](https://www.iso.org/standard/77490.html)
- SAE J3016: cited via the ASAM page.

===

# References

- Happ, C., Greven, S. (2018). Multivariate functional principal component analysis for data observed on different (dimensional) domains. JASA, 113(522), 649–659.
- Campello, R. J. G. B., Moulavi, D., Sander, J. (2013). Density-based clustering based on hierarchical density estimates. PAKDD 2013, LNCS 7819, 160–172.
- Rousseeuw, P. J. (1987). Silhouettes: a graphical aid to the interpretation and validation of cluster analysis. J. Comput. Appl. Math., 20, 53–65.
- Hayward, J. C. (1972). Near-miss determination through use of a scale of danger. Highway Research Record, 384, 24–34.
- Breiman, L., Friedman, J., Olshen, R., Stone, C. (1984). Classification and Regression Trees. Wadsworth.

