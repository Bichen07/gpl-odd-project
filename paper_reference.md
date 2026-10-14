# Paper reference

File: `gpl-odd-project/paper_reference.md`

This note is for the thesis bibliography. The project stands on two senior works, in this order. Papers below are grouped by the function they support. Each card says how it connects, where it entered, what that method does not cover, and what was actually built.

---

## The two senior works

### 1. Lin Wei-Yu — Interaction-centric traffic scenario extraction (NYCU Master’s thesis, January 2026)

PDF: `xosc_gen/312553015_Thesis__Copy_ (1).pdf`  
Advisor: Wen-Chieh Lin.

Real intersection trajectories and an OpenDRIVE map become an executable OpenSCENARIO file. Four stages, in order:

1. **Action extraction.** Rule-based, not an LLM. Longitudinal actions from the speed trace (acceleration sign, a deviation threshold, drop segments shorter than 0.5 s or slower than 0.2 m/s). Lateral and route actions from OpenDRIVE lane coordinates `(road, lane, s, t)`.
2. **BEV.** Top-down frames of the agents on the map, with speed and heading arrows. The model looks at frames before, during, and after each action.
3. **MLLM analysis.** Chain-of-thought on the action log plus the frames. Closed interaction types (yield, proceed, distance-keeping, and the crossing-path variants). Output is YAML: an ego caption and one row per interaction.
4. **Reviewer, then scenario construction.** A second MLLM checks the first YAML. Python writes OpenSCENARIO 1.2: actions, triggers, and parameters. The caption is the functional scenario. The parameter assignment is the concrete scenario.

**What this thesis does not do.** It does not cluster thousands of simulated trials, and it does not draw a collision boundary in parameter space.

### 2. Chiu, Lin, Wang, Hu, Wang — Behavior-centric visual analytics (IEEE T-ITS, 2026, submitted)

PDF: `gpl-odd-project/_IEEE_ITS_2026__Behavior_Centric_Visual_Analytics_for_Scenario_Based_Safety_Evaluation_of_Autonomous_Vehicles.pdf`

One logical scenario is sampled on a few parameters (oncoming speed, start delay). Each sample is one concrete simulation. The paper then:

1. Embeds whole interaction trajectories with **MFPCA** (components kept to about 95% of variance). Early ends, such as a collision, are padded with the trial’s own mean plus small noise.
2. Clusters the FPC scores with **HDBSCAN**. Several settings are kept and ranked by **silhouette**. The analyst picks one. There is no single automatic *k*.
3. Shows the chosen clusters in **parameter space**, in the FPC projection, in a synced **replayer**, and in **trajectory heatmaps**.
4. Uses that view to find collision boundaries and places where the behavior changes with the parameters.

**What this paper does not do.** It does not ask a language model to name a cluster, and it does not emit a readable AND-rule for the collision band. The analyst still reads the pictures.

### 3. This layer

`gpl-odd-project` starts after a clustering result has been saved. It reads the medoid and the matched-parameter pairs, writes a short cluster name, draws the CART boxes on the same parameter plane, and answers questions from a frozen briefing. It does not re-cluster, and it does not generate a new OpenSCENARIO.

| Stage | Whose work | Output this repo still uses |
|---|---|---|
| Real trace → actions, BEV, interaction YAML, OpenSCENARIO | Lin | The scenario family that is later simulated |
| Simulate the logical box → MFPCA + HDBSCAN → parameter-space view | Chiu | `clustering/selectedClusteringResult.json`, the Explore views |
| Name the medoid and the boundary pairs; CART sentences; Q&A | This layer | `clusterN/`, `parameter_space_pairs/`, `odd/output/` |

---

## 1. Scenario language

Shared by both seniors. A cluster name is not a new scenario class.

### Ulbrich, Menzel, Reschka, Schuldt, Maurer — Scene, situation, and scenario (IEEE ITSC 2015)

Lin [9]. [IEEE](https://ieeexplore.ieee.org/document/7313256)

**Connection.** The words for a test situation, before any model runs.

**How it entered.** Lin’s background chapter.

**Weakness.** Definitions only. No extractor and no clustering.

**What was built.** Lin’s caption is the functional description. The OpenSCENARIO parameters are the concrete case. Chiu then varies those parameters inside one logical class.

### Menzel, Bagschik, Maurer — Functional, logical, and concrete scenarios (IEEE IV 2018)

Lin [10]. Chiu [4]. [IEEE](https://ieeexplore.ieee.org/document/8500406)

**Connection.** One logical class has parameter ranges. One concrete trial has one value per parameter.

**How it entered.** Both seniors cite it. It is the sentence that joins the two theses.

**Weakness.** They do not sample the box and they do not cluster the concretes.

**What was built.** Lin writes one concrete file from a real trace. Chiu samples many concretes of one logical cut-in (speed × start delay) and clusters the resulting trajectories. A cluster label is an observed behavior inside that class, not a new logical scenario.

### Zhang, Khastgir, Tiele, Takenaka, Hayakawa, Jennings — ODD and behavior-based scenario generation (IEEE Access 2024)

Lin [3]. Chiu [6]. *IEEE Access*, vol. 12, pp. 10652–10663, 2024.

**Connection.** An ODD is the operating envelope. Behavior is a separate axis. Scenarios should be generated with both in view.

**How it entered.** Both bibliographies. The later method note did not re-read the PDF; the citation is enough for the claim below.

**Weakness.** A generation argument. It does not name clusters and it does not fit a tree.

**What was built.** Neither senior calls an HDBSCAN region “the ODD.” This layer’s CART leaves are attribute ranges on the sample. The Report and the Q&A prompt keep that wording.

### ISO 21448 (SOTIF), ISO 34502, UN Regulation 157, SAE J3016, BSI PAS 1883

Chiu [1]–[3]. Lin [1], [2].

**Connection.** What a safety case and an ODD specification are allowed to claim.

**Weakness.** They do not define pass / yield, and they do not score a clustering.

**What was built.** The thesis can say the run is evidence inside one logical scenario. It cannot say the eight tree leaves are an ODD certificate. ASAM OpenDRIVE 1.7 and OpenSCENARIO 1.2 (Lin [11], [12]) are the file formats Lin writes and the simulator later executes.

---

## 2. Action extraction

Lin, Chapter 4.2. No external maneuver paper is the implementation.

**What was built.** Three OpenSCENARIO-shaped classes: longitudinal (speed up, slow down), lateral (lane change), route (turn, go straight). Thresholds are in the thesis: acceleration sign past ±0.05 m/s², a 1.5 m/s² deviation to split a hard brake from a gentle one, then drop events under 0.5 s or under 0.2 m/s. Map matching uses `(road id, lane id, s, t)`.

**Weakness of the method.** A fixed threshold fragments a smooth trace if it is set too low, and it misses a small interactive speed change if it is set too high. Lin states that tradeoff and keeps the high threshold so the model sees fewer noise events.

**What this layer did.** The same idea, on esmini logs: `action.yaml` verbs (`ACCELERATE`, `DECELERATE`, `EMERGENCY_BRAKE`, `STOPPED`, `TURN_*`, `LANE_CHANGE_*`) are computed in Python. The medoid prompt must copy the executed verb. An action the vehicle only intended is not written.

**Later comparison, not Lin’s citation.** Hartjen, Philipp, Schuldt, Howar, and Friedrich, *Classification of Driving Maneuvers in Urban Traffic for Parametrization of Test Scenarios* ([PDF](https://mediatum.ub.tum.de/doc/1535131/1535131.pdf)), use three maneuver layers (vehicle state, infrastructure, object-related) and then turn them into logical-scenario parameters. Their layer 1–2 list is the same family as Lin’s verbs. Their object layer is not pass / yield. This layer did not import that catalog.

---

## 3. BEV

Lin, stage 2 of Figure 1. Rendered from the trajectory and the OpenDRIVE map. Not taken from a vision paper.

**What was built.** Each frame places agent boxes on the map. A moving agent has a speed and heading arrow. Ego has a distinct color. The prompt tells the model which frames to look at: before, during, and after the action.

**Weakness.** A crop can omit an agent that the text still names. The image is not a measuring tool for time-to-collision.

**What this layer did.** The same split. Medoid and pair calls receive a few rendered frames. Time-to-collision, speed, and impact type stay in the context file. The label-rename call does not attach images.

**Paper Lin cites and does not copy.** Choudhary et al., Talk2BEV (ICRA 2024), Lin [33]. That system lets a language model query a learned BEV map for driving. Lin’s frames are a deterministic plot of a recorded trace. Talk2BEV is a related-work neighbor, not the renderer.

---

## 4. LLM analysis and prompt design

Lin’s analysis module. This layer reused the shape (closed label, prose, a second pass) and changed the question.

### Wei et al. — Chain-of-thought prompting (NeurIPS 2022)

Lin [46].

**Connection.** Intermediate steps beat a single answer on a multi-part task.

**How it entered.** Lin §4.4.2, the prompt design section.

**Weakness.** The paper’s tasks are arithmetic and commonsense, not traffic. A long chain can still be fluent and wrong.

**What Lin built.** Four written steps per action: name the action, look at the frames, state how the gap changes, then pick one glossary type. The YAML comes after the chain, inside a fence.

**What this layer did.** The medoid prompt keeps “features, then conclude,” then a closed YAML. The chain may not invent a verb that `action.yaml` does not contain.

### Ji et al. — Self-reflection against hallucination (EMNLP Findings 2023)

Lin [47]. Renze and Guven, Lin [48], is the later agent version of the same idea.

**Connection.** A second look catches a wrong partner or a wrong type.

**Weakness.** The reviewer is another sample from the same model family. It can repeat the first error. It is not a geometric check.

**What Lin built.** An independent reviewer module. It confirms the YAML or returns a corrected interaction type and partner id.

**What this layer did.** Label rename is the later, smaller critic: one call over all cluster names, no images, no second reading of the medoid YAML. It adds one adjective only when two names match and the behaviors differ. It is not Lin’s per-action reviewer.

### Markkula et al. — Defining interactions (Theoretical Issues in Ergonomics Science 2020)

Lin [16]. [DOI](https://doi.org/10.1080/1463922X.2020.1736686)

**Connection.** An interaction is a space-sharing conflict, settled by who occupies the space.

**How it entered.** Lin’s interaction chapter, before the glossary.

**Weakness.** A framework, not a label set a model can emit.

**What Lin built.** A closed glossary: distance-keeping, yielding for merging or crossing, proceeding after the conflict is resolved. Abbreviations only (`DK`, `YMP`, `YCP`, `P`).

**What this layer did.** The medoid bit is coarser: `pass_first` | `yield` | `unresolved`. That is the same who-goes-first question, checked against the recorded order, not against Lin’s full intersection glossary.

### DriveLM (ECCV 2024), DriveGPT4 (RA-L 2024), Reason2Drive (ECCV 2024)

Lin [36], [37], [35]. [DriveLM](https://arxiv.org/abs/2312.14150) · [DriveGPT4](https://arxiv.org/abs/2310.01412) · [Reason2Drive](https://arxiv.org/abs/2312.03661)

**Connection.** A multimodal model can be asked structured questions about a driving scene, with a separate “what” and “why.”

**How it entered.** Lin’s related work for MLLM scene understanding. The architecture paragraph also points at Talk2BEV [33] and PlanAgent [44] as the style of multimodal reading, then says the output must be OpenSCENARIO rather than a driving action.

**Weakness.** All three train or evaluate a system that explains in order to drive or to score a caption. Their “what” is free prose. DriveLM’s behavior answer is binned future speed and steer. None of them writes a scenario file.

**What Lin built.** The model does not drive. It classifies a finished action into the glossary, then Python writes the file.

**What this layer did.** Same refusal. Geometry stays in Python (DriveVLM’s later statement of that split, CoRL 2024, [arXiv:2402.12289](https://arxiv.org/abs/2402.12289), is the citation added in the method note; Lin does not cite it). The closed bit is pass / yield. The why-clause is prose. Few-shot rows in the prompt, not a memory of older clusters, come from the DiLu note (ICLR 2024, [arXiv:2309.16292](https://arxiv.org/abs/2309.16292)): two filled examples, no retrieval of past YAML.

### ChatScene — Language to Scenic (CVPR 2024)

Lin [4]. [arXiv:2405.14062](https://arxiv.org/abs/2405.14062)

**Connection.** Generating a scenario from language. Lin cites it as the safety-critical generation line.

**Weakness.** One prompt that emits a whole Scenic program produces APIs the simulator cannot run. Their fix is a snippet database. The metric is collisions of an RL agent, not extraction accuracy on a real trace.

**What Lin built.** The model never writes the scenario file. It fills a YAML. Python assigns triggers. That avoids ChatScene’s failure mode.

**What this layer did.** No generator. The scenarios already exist. The prompt still splits who-yields from the speed profile from the OpenSCENARIO parameters, which is the same axis split.

### Chat2Scenario (IEEE IV 2024) and the trajectory generators

Lin [23], and Lin [26]–[31] (TrafficSim, SceneGen, TrafficGen, DiffScene, and the critical-scenario search papers).

**Connection.** Other ways to get a scenario from data or from a model.

**Weakness.** Chat2Scenario extracts from a dataset with an LLM, but not through an action log plus a reviewer. The generators sample new trajectories. They do not explain a finished one.

**What was built.** Lin extracts from a real trace and keeps the recorded motion. Chiu does not generate trials; the sampler fills the logical box. This layer does not add another generator.

---

## 5. Clustering

Chiu, Section III-C. This is not an LLM result.

### Happ and Greven — Multivariate functional principal component analysis (JASA 2018)

Chiu [26].

**Connection.** The trajectory embedding.

**How it entered.** Chiu’s method. Components are kept until they explain about 95% of the variance. The appendix writes the mean, the covariance, and the FPC scores.

**Weakness.** The embedding needs a shared time domain. A trial that ends at a collision is shorter. Two trials can share a shape and still differ in who yielded. MFPCA does not know pass / yield.

**What Chiu built.** Short trials are padded with their own mean plus small Gaussian noise (Middlehurst et al. [27], Tan et al. [28], Bier et al. [29] are the variable-length citations). Pairwise DTW (Petitjean, Ketterlin, and Gançarski [30]) was considered and not used, because it does not give an embedding that can be clustered at this scale.

**What this layer did.** No change to MFPCA. Pairs exist because a whole-trajectory cluster is not one intent.

### Campello, Moulavi, Sander — HDBSCAN (PAKDD 2013)

Chiu [31].

**Connection.** Clustering without a chosen *k*. Noise stays noise.

**Weakness.** Density in the FPC space is not a behavior name. Points the fit never labeled have no cluster.

**What Chiu built.** A grid over minimum cluster size, minimum samples, and selection epsilon. Candidates stay on screen, sorted by silhouette (Rousseeuw [32]). The user picks one. Ward linkage (Murtagh and Legendre [33]) is available when a hierarchy is wanted.

**What this layer did.** The chosen file is `clustering/selectedClusteringResult.json`. Trials with no label stay in `odd_all_trials.json` and are counted. The Report plot can color those points gray. The tree still trains on them if they have a pass/fail bit.

### Schütt, Otten, Sax — Behavior clustering versus criticality clustering (IEEE ITSC 2023)

Not in Chiu’s bibliography. Added in `post_medoid_analysis_method_study.md`. [arXiv:2306.12738](https://arxiv.org/abs/2306.12738)

**Connection.** The published experiment closest to “cluster the concretes of one logical class.”

**Weakness.** They search the box with Bayesian optimization, then use DTW, kernel PCA, and DBSCAN. They reject parameter-space distance because their sampler is not a grid. Their recommended test point is a convex-hull corner plus a center, and the hull fails on a non-convex crash cluster.

**What we did.** Cite the analogy. Do not replace MFPCA + HDBSCAN. Chiu’s silhouette is a geometry score; Schütt shows a tight cluster can still mix collision and safe. The medoid is the typical member, not their hull corner. Matched-parameter pairs are this layer: Chiu shows the parameter plane; Schütt never contrasts two clusters at nearly the same initial conditions.

**Still open.** A medoid name hides the extremes inside the cluster. A short card with the medoid, one collision member, and one safe member is the gap. `trajectory_projection_pairs/` (similar shape, different parameters) still has no language-model product.

---

## 6. Parameter space and the safety boundary

Chiu, Figure 1 and the filtering step. The analyst looks at collision outcomes on the parameter plane. This layer turns that picture into a sentence.

### Westhofen et al. — Criticality metrics review (Archives of Computational Methods in Engineering 2022)

Chiu [5]. Neurohr et al., IEEE Access 2021, is Chiu [35].

**Connection.** Which numbers count as “critical,” besides a boolean collision.

**Weakness.** A review. It does not draw the boundary of this cut-in.

**What Chiu built.** Collision is the main outcome on the parameter plane. Criticality metrics sit beside it so a region can be risky before it is a crash.

**What this layer did.** Time to collision stays a measured field (Hayward, 1972, is the older scale, cited in the taxonomy, not in Chiu). No threshold is called a certified safety limit.

### Wang et al. — Safety performance boundary by surrogate gradient search (IEEE T-ITS 2022)

Chiu [9]. Neighbors in the same related-work block: Winkelmann et al. [10] (probabilistic metamodels), Tu et al. [11] (coverage testing, CoRL 2023), Zhao et al. [22] (importance sampling).

**Connection.** The boundary can be searched and drawn as a curve in parameter space.

**Weakness.** A surrogate plus a search spends simulations on the frontier. The output is a region, not a sentence an engineer can quote. Gaussian-process classification (Batsch et al., [arXiv:1907.05364](https://arxiv.org/abs/1907.05364)) is the same family and was checked later for this Report: it draws a smooth contour and does not yield an AND-rule.

**What Chiu built.** The samples already fill the box. The view shows where collisions sit. There is no second search.

**What this layer did.** A shallow CART (Breiman, Friedman, Olshen, and Stone, 1984) on all trials with a known pass/fail bit. Each leaf is an AND of ranges. On the k=6 run the large collision leaf is `OncomingStartDelay` in (3.855, 4.388] and `OncomingSpeed` > 2.374. The Report draws those leaves as boxes on Chiu’s parameter plane. Depth 1–5 can be refit from the dashboard; a depth already fit is stored under `odd/output/cart_by_depth/` and reloaded. Atakishiyev, Salameh, Yao, and Goebel, IEEE Access 2024 ([DOI](https://doi.org/10.1109/access.2024.3431437)), are the reason the tree stays shallow: the predicate is the explanation. A boosted model would need a second explanation step.

**kNN boundary.** Separate from the tree. It is the Explore filter: a trial whose min–max-normalized neighbor has a different collision bit, or a different cluster label. That is Chiu’s “focus on the collision boundary” step, written to `odd_boundary_export.json`. It is not the pair z-score, and it is not the CART cut.

---

## 7. This layer after the clustering is saved

These papers are not in either senior bibliography. They were read while deciding what the language model is allowed to say about a saved run. Full cards are in `app/llm_pipeline/medoid_analysis_method_study.md` §4 and `post_medoid_analysis_method_study.md` §4.

| Paper | Use it for | Do not do |
|---|---|---|
| DriveVLM, CoRL 2024 | Numbers stay in Python; the model quotes them | A second perception model on the BEV |
| DiLu, ICLR 2024 | Two or three filled YAML examples in the prompt | A memory of older medoid files |
| SoVAR, ASE 2024 | Intended action ≠ executed action; Python owns impact type | Extract crash type from prose; build new trajectories |
| Schütt, ITSC 2023 | A cluster may mix outcomes; the medoid is not the hull | Swap MFPCA for DTW + DBSCAN |
| Li et al., SVCE, IEEE T-ITS 2024 | Vocabulary only, and the PDF was not available | Call a nearest parameter-space neighbor a Shapley counterfactual |
| You et al., ICRA 2025 | — | GPT-4o as a judge of driving quality, or interview retrieval in Q&A |

**What was built.**

- Medoid: one trial, its `action.yaml`, its metrics, and a few BEV frames → one YAML. Interaction bit, prose reason, Labeller verb.
- Parameter-space pairs: nearest neighbors in z-scored OpenSCENARIO parameters, different clusters. The question is whether the behavior matches. The medoid is backdrop, not the evidence.
- Cluster summary, then one rename pass if two names collide and the behaviors differ.
- Q&A sends a short index every turn. The model may ask once for a medoid YAML, one pair `contrast.yaml`, or one trial row. A missing file is named with the step that would build it. The answer ends with `Sources:`. The papers for that request are in §9.

---

## 8. Q&A order — not in the prompt yet

The chat rules already block invented numbers. They do not say which fact comes first. These papers were checked for that gap only, and that order is not in the prompt.

| Paper | Take | Leave |
|---|---|---|
| Segel and Heer, TVCG 2010, [PDF](https://homes.cs.washington.edu/~jheer/files/narrative.pdf) | One guided paragraph, then stop. The plot is what the reader explores. | News-graphic genres |
| Hullman et al., TVCG 2013, [PDF](http://cond.org/story_sequence.pdf) | Each sentence changes one thing: rate, then the pair, then the rule. | Their chart-transition optimizer |
| Shi et al., Calliope, TVCG 2020, [arXiv:2010.09975](https://arxiv.org/abs/2010.09975) | Fact types: a rate, a difference, a range. All three already exist in the briefing. | Searching a spreadsheet and writing new facts |
| Sun et al., Erato, TVCG 2022, [arXiv:2209.02529](https://arxiv.org/abs/2209.02529) | The question picks the key fact. Do not tour every cluster. | Invented intermediate facts |
| Dhamdhere et al., Analyza, IUI 2017 | One line that says which slice was used (collision rule, or cluster color) before `Sources:`. | Their SQL interface |

---

## 9. Q&A retrieval — the model asks for one file

Built in `odd_chat.py`. Every turn sends a short index from `odd_chat_briefing.json`: cluster id, name, size, collision rate, medoid trial id, pair folder, and the sampled rules. The caption and the pair explanation stay out, because both are cut at 320 characters. The model answers from the index, or it replies with one JSON object and Python reads one file:

- `{"need":"medoid","cluster":0}` → `clusterN/output/medoid_trial.yaml` (interactions, timeline, conflict metrics, motive).
- `{"need":"pair","folder":"c0-c2"}` → that pair’s `contrast.yaml` (divergence time, both outcomes, behavior, reason).
- `{"need":"trial","trial_id":"12198"}` → one row of `odd_all_trials.json`, the payload export already saved for the run (parameters, passed, cluster label). The other trials are not attached.

An id that is not in the run returns “not available”, and the second call says it does not know. “What did the medoid do?” with no cluster number lists the medoid trial ids and does not open one timeline. The check on `6_cluster_s=0.5947` is `qa_checks/s05947_questions.json`. It scored 7/7. The turns are conversation `qa-check-s05947` in the dashboard.

### Lewis et al. — Retrieval-augmented generation (NeurIPS 2020)

[arXiv:2005.11401](https://arxiv.org/abs/2005.11401). Cited in the comment at the top of `odd_chat.py`.

**Connection.** A retriever pastes passages into the prompt. The model answers from those passages and does not choose them.

**How it entered.** The Q&A design note. The index is this pattern: Python pastes a short catalog, and the model does not choose those lines.

**Weakness.** The retriever can omit the passage the question needs. Pasting every medoid, every pair, and every payload trial into one prompt is the same failure in the other direction: the model loses the fact in the middle of a long context.

**What was built.** The index, including `missing` for a file that was never written. The timeline is not on `missing`, because the file exists. The model asks for the medoid instead of being told the timeline was dropped.

### Yao et al. — ReAct (ICLR 2023)

[arXiv:2210.03629](https://arxiv.org/abs/2210.03629)

**Connection.** The model writes an action, reads the text that action returns, then answers. On HotpotQA the actions are `search` (a Wikipedia page) and `lookup` (a string inside that page), then `finish`.

**How it entered.** The question of whether the model should ask for the medoid, the pair, or one payload trial instead of receiving a guessed slice.

**Weakness.** Their action space searches the open web by entity name. A wrong search still returns fluent text, and the model can treat that text as evidence. An open tool list does not fit a saved run.

**What was built.** The three tools above, one request, then the answer. `Sources:` names the file, and the dashboard chip shows the same request. Trial `12198` is cluster 0’s medoid. The model asks for that id when it needs the parameter values. It does not receive the other 3,868 rows. A time is the medoid file, not the trial row.

### Asai et al. — Self-RAG (ICLR 2024)

[arXiv:2310.11511](https://arxiv.org/abs/2310.11511)

**Connection.** The model decides whether a retrieval is needed, then checks that the passage supports the sentence.

**How it entered.** Same design question, as the paper that says a fixed number of passages on every question hurts the answer.

**Weakness.** They train special reflection tokens. This layer calls Gemini and does not fine-tune.

**What was built.** The decision only. The prompted JSON line is the request. The reflection tokens were not trained. A checker, not a second model, scores the answer against the file.

### Jiang et al. — FLARE (EMNLP 2023)

[arXiv:2305.06983](https://arxiv.org/abs/2305.06983)

**Connection.** The model drafts the next sentence. If that sentence is uncertain, it retrieves and writes the sentence again.

**How it entered.** Captions in the briefing are cut mid-word (`Parking vehicl…`). A cut sentence invites the model to finish it.

**Weakness.** Their trigger is token probability, which a hosted chat API does not return. They also retrieve from a document corpus, not from a named YAML.

**What was built.** The index does not include the cut caption. A question about what the medoid did asks for the medoid file instead of finishing a sentence that ends in `…`. Token probability is not available from the hosted API, so the prompt names the file, and the model writes the request.

---

## 10. What is still worth doing

1. Keep Lin’s layer split on the medoid: executed verb, who-goes-first bit, prose reason. A timing word is a measured lead time, not a third code.
2. Keep Chiu’s clustering untouched. Add the intra-cluster extremes Schütt asks for, next to the medoid.
3. Give Q&A the four-line order in §8, still inside the current briefing rules.
4. Done. The one-file request in §9 is in the chat loop. The short index is on every turn. One request reads a medoid YAML, one pair `contrast.yaml`, or one trial row. The payload is not pasted.
5. Draw a curved boundary (Wang, or Batsch) only when a later parameter pair is not a band. This cut-in is a band, so the tree stays.
6. Do not add a scenario generator, a second clustering, Shapley search, or a judge of “how human the driver is.”

---

## 11. Do not cite these as the method

Checked while reading the two bibliographies and the method notes. They sit next to the real pipeline and answer a different question.

| Item | Why it stays out |
|---|---|
| TrafficSim, SceneGen, TrafficGen, DiffScene (Lin [26]–[29]) | They generate trajectories. Lin keeps the recorded ones. |
| Chat2Scenario (Lin [23]) | Extraction without the action log, the BEV steps, and the reviewer. |
| DriveLM / DriveGPT4 / Reason2Drive as a driver | Lin and this layer both use them as readers, not as planners. |
| DTW clustering (Chiu [30]) | Chiu rejected it. Schütt uses it. This repo stays with MFPCA. |
| Wang’s surrogate search (Chiu [9]) | The box is already sampled. The tree describes it. |
| VEHITS 2025 GraphRAG, LC-LLM, Trajectory-LLM | Wrong object: a corpus, a future lane-change predictor, or a text-to-trajectory generator. ReAct in §9 is a different claim: three named files on this run, not a graph over a corpus. |
