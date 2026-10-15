# Analysis flow — presentation

Run: batch 8, k = 3, silhouette 0.8032. LLM: gemini-2.5-flash, temperature 0.1.
Clustering (MFPCA + HDBSCAN, whole trajectory) is already done. These pages start after it.
k = 6 check (same batch, silhouette 0.5947 and 0.6113, rebuilt 2026-10-02): pages 23–24. Q&A on s = 0.5947: page 20. Questions for review: page 26.

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
Not a new clustering method. A reading layer on top. Standards comparison: page 25.

===

page 2
title: Analysis flow
ppt:


| Layer               | Step                    | Question                                            | Prompt                                   |
| ------------------- | ----------------------- | --------------------------------------------------- | ---------------------------------------- |
| Deterministic       | 1. Preprocess           | What happened, and when?                            | none                                     |
| LLM                 | 2. Medoid               | What does this trial do, and why?                   | medoid_trial + system + glossary         |
| LLM                 | 3. Parameter pair       | similar inputs, different trajectory: what differs? | parameter_space_pair + system + glossary |
| LLM                 | 4. Summary, then rename | What is each cluster called?                        | cluster_summary, then input_context_label_rename |
| No LLM              | 5. Report               | Show the saved cards                                | none                                     |
| LLM                 | 6. Q&A                  | Answer from the briefing, or one requested file     | odd_chat_system_prompt                   |


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
| Accelerate / decelerate | \|a\| > 0.05 m/s², ≥ 0.5 s, \|Δv\| > 0.2 m/s                                 |
| Emergency brake         | mean a ≤ −4 m/s²                                                           |
| Stopped                 | v < 0.3 m/s, ≥ 1 s                                                         |
| Lane change             | lane ID changes on same road; 1–3 s                                        |
| Turn (same lane)        | \|Δheading\| ≥ 15° for ≥ 1.5 s, same road and lane                         |
| Enter / exit junction   | Ego enters or leaves a junction road. Left or right if \|Δheading\| > 40°, else straight |


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
| F1  | Junction enter or exit while Ego goes straight | \|Δheading\| < 25°      |
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
Both files are attached to the medoid, pair, and summary calls. The rename call and Q&A do not load them.

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
| Workflow       | List 6–12 facts from the file. Write pass first, yield, or unresolved. Then the action, a quote, one reason.                                                                                                     |
| Word list      | slow down, speed up, hard brake, or maintain speed. Quote the speed from the line.                                                                                                                               |
| Output         | Five fields only: who Ego responded to, the timeline, the collision sentence, the short summary, open questions.                                                                                                 |
| Motive summary | 2–4 sentences. Not a second timeline.                                                                                                                                                                            |
| Medoid context | The file from page 7, pasted at the end.                                                                                                                                                                         |


Each row is one vehicle plus pass first, yield, or unresolved. Parking gets a row when Ego reacts to it. The model writes the impact type, the two vehicle names, and the collision sentence. The pipeline adds `trial_id`, `outcome`, `conflict_metrics`, and `bearing_sector`.

notes:
Intensity follows the speed change: about 2 m/s, 2–5 m/s, above 5 m/s. A resume with nobody ahead has no why. Evidence for a why is at or before that stamp. A cluster name such as Late Yield is written by the summary, not here.

===

page 12
title: Medoid — the result
ppt:
File: `clusterN/output/medoid_trial.yaml`.


| Field                         | What it tells                                                      |
| ----------------------------- | ------------------------------------------------------------------ |
| `agent_interactions`          | One row per vehicle Ego responded to: pass_first / yield / unresolved |
| `decision_timeline`           | Each stamp: the action, the quoted numbers, and one why            |
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

page 13
title: Parameter pair — the prompt
ppt:
Goal: similar parameter inputs, different clusters from the whole-trajectory embedding. Find the trajectory difference.

File: `parameter_space_pair_prompt.txt`, plus page 10.
Pair selection (z-score, closest pair, distance ≤ 0.1, align clocks) is done before this prompt.


| Section         | What it tells the model                                                                                                              |
| --------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| Your Task       | Similar inputs. Different trajectory. Find that trajectory difference.                                                               |
| How to read     | The pair file is the only timeline. A medoid card is a later comment. Do not copy its pass or yield onto a side.                      |
| Workflow        | Name the first time the two trajectories start to differ and stay apart. Then pass first, yield, or unresolved for each side. Write the verdict last. |
| Behavior call   | distinct, similar, or inconclusive. Distinct: different family, or same family with different outcome, or a lasting ahead-versus-overlap split. Similar: same family and same outcome. |
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
| Your Task       | Name the cluster in 2–4 words, one mechanism, no degree word. A collision name is the impact and the two vehicles, striking first. |
| Workflow        | Read the medoid, then each pair. Do not re-judge a pair. A boundary trial may differ from the medoid. |
| Caption guide   | First the medoid. Then each pair: what is shared, and what differs.        |
| Output          | The name, the caption, and the two consistency notes. Python writes the neighbor list and distinct, similar, mixed, or ambiguous. |


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
title: Label rename — the input
ppt:
Goal: two clusters with the same name get one added adjective, taken from how their behavior differs.

Input: `cluster_rename/input_context_label_rename.md`.
Task text: `cluster_rename_prompt.txt`. It does not load page 10.

The input file is organized from each cluster's `cluster_summary.yaml` and `medoid_trial.yaml`. The call reads that file.


| Section       | What it tells the model                                                                                                 |
| ------------- | ----------------------------------------------------------------------------------------------------------------------- |
| Your Task     | Rename only when two names are the same or near-same and the behavior differs. Add one adjective. Do not add new evidence. |
| Workflow      | Mark shared names. Compare their cards. Same behavior: no change. Different: add one adjective you can quote from the cards. |
| Cluster cards | The text of `input_context_label_rename.md`.                                                                            |
| Output        | One row per cluster, same order.                                                                                        |


The added word is an adjective, not an adverb and not a new noun. Example: the longer gap between the brake and the conflict peak (peak_t minus brake_t) is `Proactive`, the shorter is `Late`.

===

page 18
title: Label rename — the output
ppt:
Output: `cluster_rename/output_cluster_label_review.json`.
One call returns one row per cluster. Python writes that array. It is the model's reply, not a rule score.
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
The rename call did not re-read the images or the pair cards. It read `input_context_label_rename.md`.

===

page 19
title: Report
ppt:
No prompt. No model. The page reads the saved files and draws them.


| Shown | File |
| ----- | ---- |
| Cluster name, caption, risk | `clusterN/output/cluster_summary.yaml` |
| Medoid resolution and outcome | `clusterN/output/medoid_trial.yaml` |
| Pair verdict | `parameter_space_pairs/cA-cB/output/contrast.yaml` |
| Collision rate, trial count | `clusterN/cluster.json` |
| Rule table and boxes | `odd/output/odd_parameter_rules.json` |
| Points on the plot | `odd/input/odd_all_trials.json` |
| Boundary counts | `odd/output/odd_boundary_export.json` |


A rule is a hypothesis on the sampled trials. This run's collision rule: start delay in (3.855, 4.388] and speed above 2.374, support 1688, precision 0.82.

===

page 20
title: Q&A — what the model receives
ppt:
Two calls. The first call always gets `analysis/odd/output/odd_chat_briefing.json`. There is no index file. If that briefing is enough, the model answers. If a fact is only in another file, the first reply is one JSON object, Python reads that file, and the second call answers.


| Always sent | What it contains |
| ----------- | ---------------- |
| `odd_chat_system_prompt.txt` | Numbers only from the briefing or the one returned file. A leaf is a sampled rule, depth 1–5. End with Sources. |
| `odd_chat_briefing.json` | Cluster id, clustering name, size, collision rate, medoid trial id, resolution, outcome, parameter ranges. Pair folder. Rule id, predicate, support, precision. `missing`. |
| Cluster summaries | Every `clusterN/output/cluster_summary.yaml`, including the first turn of a new conversation. Label, caption, consistency note, risk, neighbor comparison. `llm_meta` and `label_review` are left out. |
| The question | Plus the last 8 turns of this conversation only. The file from the previous question is not kept. |
| A selection | Above 6 trials: 1 to 3 from each cluster that appears, by its share, including noise. Stored context first. This collision-boundary filter is 13 of 461. The conversation chip uses that same count. |


| One request | File Python reads | What comes back |
| ----------- | ----------------- | --------------- |
| `{"need":"medoid","cluster":0}` | `cluster0/output/medoid_trial.yaml` | `measurements`: trial id, brake time, time to collision, peak time, outcome. `medoid_model_sentences`: timeline, motive |
| `{"need":"pair","folder":"c0-c2"}` | `parameter_space_pairs/c0-c2/output/contrast.yaml` | `measurements`: parameter distance, divergence time, both outcomes. `model_label`: behavior similarity and the reason |
| `{"need":"trial","trial_id":"12198"}` | One row of `odd_all_trials.json` | OncomingSpeed, OncomingStartDelay, passed, cluster label |
| `{"need":"summary","clusters":[1,2,3]}` | `clusterN/output/cluster_summary.yaml` | Caption, consistency note, risk, neighbor comparison. If that cluster's collision rate is 100, also that medoid's collision end: brake time, peak time, time to collision, impact |
| `{"need":"bev","cluster":2}` | `cluster2/processed/snapshots/llm_snapshots.json` | Frame table: time, action label, distance, time to collision, ego speed. No image |


A time or a brake is the medoid file. Whether two medoids are similar is the pair file. A parameter value is the trial row. A caption, or how a collision ends, is the summary. A frame time is the BEV table. A sampled trial context is a timeline. The answer summarizes it and does not copy the action stamps. An id that is not in this run returns "not available", and the answer says it does not know.

Under every answer the panel shows two lines, and nothing else. An empty value is the word null.

```
asked: null
send: 13 of 461 filter trials
```

The next sample is the collision sampled rule with the largest support. The model does not write a new scenario file.

"What did the medoid do?" names no cluster. The model lists every cluster from the briefing and does not pick one timeline.

Fresh check, conversation `qa-check-current`. The earlier chat log, titles, and pins were cleared. Each question was asked with an empty history, model gemini-2.5-flash, temperature 0.1, run `results/batch8/6_cluster_s=0.5947`. A timeline answer is a short brief: what Ego did, how it ended, and at most one time and one distance. It does not paste `lateral_speed`, `heading_vs_road`, or an `At t=` line.

1. Question: How many trials are in cluster 2, and what is its collision rate?
   Asked: nothing.
   Sent: nothing. The briefing is enough.
   Reply: 1237 trials, collision rate 100. It also named the cluster "Ego Side-swipe CuttingIn".
   Verdict: the two numbers match the briefing. The name does not. The briefing label is "Yield Collision". "Ego Side-swipe CuttingIn" is the summary label, and that file was not sent. Incorrect.

2. Question: What is different between cluster 0 and cluster 2? Are their medoid behaviors similar?
   Asked: pair c0-c2.
   Sent: pair c0-c2 — measurements, model label.
   Reply: both are yield. Cluster 0 is safe, cluster 2 collides. The model's label is distinct. The divergence measurement is 10.2 s. Cluster 0 keeps CuttingIn ahead; cluster 2 is a side overlap. No kinematics dump.
   Verdict: the pair was the right file, and those facts match `contrast.yaml`. The reply also calls them "Yield Safe" and "Ego Side-swipe CuttingIn", which are summary labels, not the briefing labels "Proactive Yield" and "Yield Collision". Correct on the pair. The names are not from the sent file.

3. Question: What makes Ego fail? Is it a collision? Which scenario do you recommend to simulate next?
   Asked: summary clusters 1, 2, 3.
   Sent: summary of cluster 1, 2, 3, plus each collision end.
   Reply: all three are collisions. Cluster 1 is a rear-end, brake 10.5 s. Cluster 2 is a side-swipe, brake 8.4 s. Cluster 3 is a corner contact, brake 8.1 s. Next sample is sampled rule R4, support 1688, delay in (3.855, 4.388] and speed above 2.374. It does not say the rule is not a certified boundary.
   Verdict: the summary was the right file. The brake times match the medoid collision ends. The missing boundary sentence is the miss. Incorrect on that sentence.

4. Question: Which clusters are in this collision-boundary selection, and which of the sent trials collide? Use only the trials that were sent.
   Asked: nothing.
   Sent: sent 13 of 461 filter trials. One to three trials from each cluster by share.
   Reply: clusters 0, 1, 2, 3, 4, 5, and -1. The written analysis then covers only the collisions: clusters 1, 2, 3, and noise trial 7146. Clusters 0, 4, and 5 were sent and every one of those trials passed, so they dropped out of the analysis.
   Verdict: the collision ids are right. The omission is the miss. The selection packet now carries one outcome line per cluster, and that question must stop after those lines.
   Retest, conversation `qa-check-selection`: cluster 0 passed 6997, 7025, 7032. Cluster 1 collided 7021, 12152. Cluster 2 collided 6995, 7003, 7027. Cluster 3 collided 7752. Cluster 4 passed 6993, 7026. Cluster 5 passed 12852. Cluster -1 collided 7146. Every sent cluster is named.

5. Question: For one colliding trial and one non-colliding trial in this selection, summarize what the stored context shows. Do not paste the timeline.
   Asked: nothing. The trial timelines were already in the selection.
   Sent: sent 13 of 461 filter trials.
   Reply: trial 6997 ends safe after CuttingIn starts a right turn. Trial 12152 brakes and collides with CuttingIn at 14.64 s. No `lateral_speed` and no pasted `At t=` sentence. It cites more than one time.
   Verdict: the two trials and the endings match the stored context. The one-time limit was not kept. Incorrect on that limit.

6. Question: What is the OncomingSpeed of trial 99999?
   Asked: trial 99999.
   Sent: not available.
   Reply: I don't know. 99999 is not in this run.
   Verdict: Correct.

Since that check, two rules changed. Cluster summaries go out with the briefing on every question, so a cluster is named from the summary label. A selection question names every cluster on the outcome list, including a cluster whose sent trials passed. The chip and the send line both use the sampler count, 13 of 461 for this filter.

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
Tightness is relative (page 24). The 50 percentage-point and 3 s divisors are chosen.

===

page 22
title: Contribution and weakness
ppt:


| Contribution | What it does |
| ------------ | ------------ |
| Behavior of the self-driving car | Says what Ego did in the encounter, and how that encounter ended. |
| Automation on the senior result | The clusters and the scenario stay theirs. This layer writes the cards without a person reading every trial. |
| Q&A for a deeper look | A question can open one medoid, one neighbor pair, or a sample of the boundary trials. The static card cannot. |


| Weakness | What is missing |
| -------- | --------------- |
| One scenario | No comparison across scenarios, and no separate analysis of each other agent. |
| Two input variables | OncomingSpeed and OncomingStartDelay only. An ODD boundary spans scenery, weather, road, and traffic. Two variables cannot locate it. |
| The automatic card is the medoid | Cluster 0 has 904 trials. 18 collide. The medoid does not, so the card never shows those 18. A boundary question reads 13 of 461 trials, not all of them. |


notes:
The senior pieces are Lin's scenario and Chiu's clustering. Page 25 is the standard comparison.

===

page 23
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

page 24
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
| Rename keeps duplicates | s 0.59: c2 = c3 "Yield Collision" (members stop 0.2% vs 88%). s 0.61: c3 renamed to c2's label | the input is now the full cards (page 17); this k = 6 run was not repeated |
| Pass / yield unstable   | all 3 side flips in the cut-in collision cluster                                               | contact during overlap → unresolved        |
| Rank follows tightness  | k = 6 > k = 3 only via tightness (0.47 vs 0.06)                                                | absolute tightness scale                   |


Answer: yes, as a test. It confirms pass vs yield, finds the rear-end mechanism, and flags non-behavioral splits. Keep k = 3 as the main run until the stop event and the label rename are fixed.

notes:
Same input = identical trial pair, different cluster IDs per run. The verdict flip (one pair, distinct ↔ similar) follows a side flip: the same collision trial read as yield in one run, pass first in the other.
Stop rule: v < 0.3 m/s for ≥ 1 s; this medoid is under 0.3 m/s for only 0.2 s before contact.
Pass split 6 / 6 is against the paper's text. By member statistics c2 is mixed (66% pass); its pair sides also mix yield, unresolved, pass first.
s 0.61 also marks c2–c5 and c3–c5 "similar" (all pass first + collision on the boundary).

===

page 25
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

page 26
title: Questions for an ODD engineer
ppt:
The code does not answer these. They are for a test engineer or a professor. Each one is a choice this run already forces.


| # | Question | What we would change |
| --- | --- | --- |
| 1 | The briefing calls cluster 2 "Yield Collision". The summary calls it "Ego Side-swipe CuttingIn". Which name belongs in the test report? | Use one name in both files, and stop sending the other. |
| 2 | The collision-boundary filter has 461 trials. The answer reads 13, one to three from each cluster by share. Is that enough to discuss the boundary? | Say the other 448 were not read, or raise the sample. |
| 3 | The offered next test is sampled rule R4: delay in (3.855, 4.388], speed above 2.374, support 1688, precision 0.82. Should the next batch be that leaf, or one of the three endings (rear-end, side-swipe, corner contact)? | Stop offering the largest leaf as the next scenario. |
| 4 | 461 is a kNN neighborhood on the parameter plot, not 461 crashes. Clusters 0, 4, and 5 in the sample all passed. How should the screen say this so it is not read as a crash count? | Rename the button and the chip. |
| 5 | This is one scenario and two parameters. Eight tree leaves are hypotheses, not an ODD boundary (page 25). What is the smallest addition that would let a reviewer treat a leaf as inside or outside the ODD? | Keep the leaf labeled as a sample, which is the rule now. |
| 6 | A timeline answer keeps one time and drops the brake time and the gap. For trial 12152, is "Ego brakes and still collides" enough for a safety review? | Put the brake time back into the brief. |
| 7 | Noise is 27 of the 461 and has no summary card. Trial 7146 collides. Should noise be explained, left out of the boundary talk, or clustered again? | Drop cluster −1 from the sample, or write it a card. |
| 8 | k = 3 scores 60.7 and is the main story. k = 6 scores 70.5 only because tightness is relative, and it is the run that separates the rear-end. Which partition should the ODD discussion use? | Freeze one run in the report and say why. |


notes:
Do not ask them to rerun clustering. Geometry already ranked the partitions. Ask which explanation is allowed to stand on top of it.

===

# References

- Happ, C., Greven, S. (2018). Multivariate functional principal component analysis for data observed on different (dimensional) domains. JASA, 113(522), 649–659.
- Campello, R. J. G. B., Moulavi, D., Sander, J. (2013). Density-based clustering based on hierarchical density estimates. PAKDD 2013, LNCS 7819, 160–172.
- Rousseeuw, P. J. (1987). Silhouettes: a graphical aid to the interpretation and validation of cluster analysis. J. Comput. Appl. Math., 20, 53–65.
- Hayward, J. C. (1972). Near-miss determination through use of a scale of danger. Highway Research Record, 384, 24–34.
- Breiman, L., Friedman, J., Olshen, R., Stone, C. (1984). Classification and Regression Trees. Wadsworth.

