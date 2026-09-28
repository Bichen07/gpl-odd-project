# References in the senior paper — what to read

Source: `_IEEE_ITS_2026__Behavior_Centric_Visual_Analytics_for_Scenario_Based_Safety_Evaluation_of_Autonomous_Vehicles.txt`, references [1]–[38].

The senior paper (Chiu, Lin, Wang, Hu, Wang) is a visual analytics system. It samples a scenario parameter grid, embeds trajectories with MFPCA, clusters them with HDBSCAN, and links clusters to a 2D parameter plot, heatmaps, and a replayer. This repository is that system plus a later reading layer (resolution, pair cards, cluster labels).

These notes are from the senior paper’s own citations, abstracts, and the papers whose full text is public (arxiv for [7], [8], [11], [12], [37]). ISO and UN texts [1]–[3] were not read page by page. Vendor posts [18] and [19] are blogs, not research papers.

## Which papers to read

Read **high** if you need to check whether our clustering, criticality, or parameter view is doing what the senior paper claims. Read **medium** if you want the surrounding idea and can stop after the abstract and one figure. **Low** will not change the current pipeline.

| Priority | Papers | Why this rank |
| --- | --- | --- |
| High | [4], [5], [26], [31], [32], [35], [37] | These are the definitions and algorithms the system actually uses, or the closest published version of “cluster behaviors, then look at them in parameter space.” |
| Medium | [1], [2], [3], [6], [8], [9], [11], [12], [22], [23], [24], [27], [30], [33], [34], [36] | Useful context. Do not implement them. [3], [8], [9], [11], [12] search for failures. We already have a full grid and then explain behavior on it. |
| Low | [7], [10], [13], [14], [15], [16], [17], [18], [19], [20], [21], [25], [28], [29], [38] | Surveys, storage formats, replay tools, or a method we already rejected. Skim the senior paper’s one-sentence use of them. |

## How the senior paper uses them

| Group | Numbers | Role in the senior paper |
| --- | --- | --- |
| Standards and vocabulary | [1]–[4] | ODD, scenario-based testing, functional / logical / concrete scenarios. |
| Criticality | [5], [35] | TTC and SPrET as the safety numbers painted on the parameter plot. |
| Finding dangerous scenarios | [6]–[12], [22] | Other people’s search methods. The senior paper says they find *where* failures are and do not explain *how* the vehicle behaved. |
| Visualization motivation | [13]–[17], [23]–[25] | Traffic and single-scenario visual analytics. Cited as the gap: they do not sweep a parameter space. |
| Replay tools | [18]–[21] | One run at a time. Cited as the workflow that does not scale. |
| Our clustering stack | [26]–[34] | MFPCA, padding, why not DTW, HDBSCAN, silhouette, heatmap row order. |
| More than two parameters | [36]–[38] | Future work only. The parameter view is still two axes. |

## Standards and scenario language

### [1] ISO 21448 SOTIF (2022) — low-medium, listed medium

**Said.** Safety of the intended function is not only “the software did what it was coded to do.” The vehicle can still be unsafe when the function is working as specified but the situation was not in the design domain, or the specification itself was incomplete.

**Did.** Defines the ODD and the four-way split of scenarios: known safe, known unsafe, unknown safe, unknown unsafe. The work of SOTIF is to shrink the unknown-unsafe set.

**How.** Hazard identification, scenario specification, and evidence that the residual risk in the ODD is acceptable. It does not prescribe a clustering algorithm.

**Here.** Our parameter axes (OncomingSpeed, OncomingStartDelay) are a tiny slice of an ODD, not an ODD specification. Do not write an ODD sentence about weather or occlusion from this batch. Those factors are not sampled. Read the definitions of ODD and unknown unsafe if you need the vocabulary. Do not read the standard as an implementation guide.

### [2] ISO 34502 (2022) — medium

**Said.** Scenario-based safety evaluation is a framework: derive scenarios from the ODD and from the system’s intended behavior, then evaluate them.

**Did.** Standardizes the evaluation process around scenarios rather than only around mileage.

**How.** A process standard. It points at functional, logical, and concrete scenarios (the same stack as [4]) and at criticality as the evaluation language.

**Here.** We sit at the *concrete* end: one point in parameter space is one simulation. The standard does not tell us how to cluster those runs.

### [3] UN Regulation No. 157, ALKS (2020) — medium

**Said.** An automated lane-keeping system has to pass defined tests, including disturbance scenarios (cut-in, lead-vehicle brake).

**Did.** Publishes concrete test cases and, in the annexes, pictures of collision versus no-collision over a two-parameter sweep.

**How.** A regulation, not an algorithm. The pictures are grids: vary two scenario numbers, mark pass or collision.

**Here.** That grid is the ancestor of our parameter-space plot. The senior paper’s point is that a collision grid does not say whether the vehicle passed first, yielded late, or braked after it had already passed. Our heatmaps and resolution cards are the part R157 does not have. You do not need to read the regulation unless you are checking a claim about certification pictures.

### [4] Menzel, Bagschik, Maurer, IV 2018 — high

**Said.** A scenario has three levels. Functional: a prose story (“a vehicle cuts in”). Logical: parameters and ranges (“cut-in gap 10–40 m”). Concrete: one fully specified run.

**Did.** Gave the field the vocabulary almost every later scenario paper uses.

**How.** A conceptual paper. No clustering, no metric formula.

**Here.** OncomingSpeed × OncomingStartDelay is a logical scenario. Each of the 3869 trials is a concrete scenario. Cluster labels such as Late Yield are a description of many concrete runs, not a new scenario level. Read this before arguing about what “a scenario” means.

## Criticality

### [5] Westhofen et al., criticality metrics review — high

**Said.** “Critical” is not one number. Metrics answer different questions: how close in time (TTC), how close in space, how inevitable a collision is if nobody changes behavior.

**Did.** Reviews the metric catalog and asks which metrics are suitable for which situation. SPrET (scaled predictive encroachment time) is one of the time-to-encroachment family: it scales the time until occupied spaces would overlap.

**How.** A review. The formulas live in the cited original papers. The review tells you what each family assumes (constant velocity, constant acceleration, and so on).

**Here.** The parameter-space view can color trials by minimum TTC and minimum SPrET. Those are outcome-side numbers. They are not the resolution (`pass_first` / `yield` / `unresolved`). A low TTC can sit inside either a pass or a yield. Read the sections on TTC and predictive encroachment so you do not treat the color scale as a behavior label.

### [35] Neurohr et al., IEEE Access 2021, criticality analysis for V&V — high

**Said.** Criticality analysis is a method for verification: find the phenomena that make a situation critical, then attach a metric, then use that to steer which scenarios you analyze.

**Did.** Connects the metric catalog in [5] to an analysis procedure for automated-vehicle assurance. Same research group.

**How.** Phenomenon → criticality property → metric → scenario. Still not a trajectory clustering method.

**Here.** This is why the senior paper puts TTC and SPrET on the parameter plot. Our later work asks a different question after the metric is painted: among the trials near the collision boundary, did Ego go through or give way? Read [35] with [5], not instead of the clustering papers.

## Finding failures (we do not do this step)

These papers try to *choose which simulations to run*. Our batches are already a full grid. They are useful so you can see what the senior paper is refusing to copy.

### [6] Zhang et al., IEEE Access 2024 — medium

**Said.** Generate tests from the system’s claimed ODD plus its behavior competencies, not from a generic scenario catalog.

**Did.** A workflow: ODD and behavior keywords → construction rules → logical scenarios → concrete scenarios. A follow-on paper (not in this reference list) measures coverage of that set.

**How.** Rule sets that say which ODD attributes and behaviors can be combined (road layout, other actors, environment). Then sample concrete values.

**Here.** Upstream of us. We do not generate scenarios from an ODD document. If someone asks “does this batch cover the ODD?”, [6] is the paper that defines that question. It will not help you read a cluster.

### [7] Zhong et al., arXiv 2021, survey of scenario testing in high-fidelity simulation — low

**Said.** High-fidelity scenario testing has many incompatible setups. A generic formulation is: scenario space, system under test, objective, search algorithm.

**Did.** Reviews existing systems and lists open problems (scenario specification, oracle, scalability).

**How.** A survey. No new algorithm.

**Here.** A map of other people’s test harnesses. Skip unless you are writing a related-work paragraph.

### [8] Feng et al., IEEE T-ITS 2022, adaptive scenario library — medium

**Said.** A library built from a surrogate driver is wrong for the vehicle you actually want to test, because that vehicle does not match the surrogate.

**Did.** Adaptive testing scenario library generation. Each new test updates a model of how this vehicle differs from the surrogate, and the next test is chosen to be informative.

**How.** Bayesian optimization. A classification Gaussian process models the performance gap. An acquisition function picks the next cut-in parameters. Case study is a cut-in. They report roughly 10–100× fewer tests than a fixed library.

**Here.** We already simulated the grid. Do not replace HDBSCAN with this search. The useful idea is only: the interesting region depends on the planner under test. That is why case studies compare planners rather than assuming one failure surface.

### [9] Wang et al., IEEE T-ITS 2022, safety performance boundary — medium

**Said.** The ODD edge can be drawn as a safety performance boundary in parameter space, and you should not have to simulate every cell to draw it.

**Did.** Fit a surrogate of collision/no-collision, then walk the boundary with gradient descent. Three-vehicle following. Intelligent Driver Model versus Wiedemann 99.

**How.** About 4% of the grid trains the surrogate. The search recovered about 97% of collision cases and false-alarmed about 0.3% of safe cases. They also define a “safety tolerance” for points near the boundary.

**Here.** Our collision boundary is the set of neighboring trials whose outcomes differ (the S2 kNN edges), not a fitted surface. [9] explains the picture the senior paper says is incomplete: a boundary with no behavior. Read it if you need to explain why a boundary point can be a pass on one side and a yield on the other.

### [10] Winkelmann et al., IEEE T-ITS 2022, probabilistic metamodels — low

**Said.** Complex driving scenarios are too expensive to simulate densely. A probabilistic metamodel can stand in for the simulator.

**Did.** Builds a metamodel so that characterization of a scenario family needs fewer runs.

**How.** Statistical surrogate of simulator outputs over scenario inputs.

**Here.** We have the runs. A metamodel would hide the trajectories we cluster. Skip.

### [11] Tu et al., CoRL 2023, GUARD — medium

**Said.** Binning a parameter space does not scale, and hunting only for failures does not tell you the safe region.

**Did.** GUARD models the probability of passing everywhere with a Gaussian process, then picks the next test near the pass/fail level set.

**How.** No grid. Online kernel learning. The output is three regions: pass, fail, uncertain. Evaluated on higher-dimensional scenarios than a 2D sweep.

**Here.** Same product as a collision field, with a better sampler. It still does not say *how* the vehicle moved. Our 2D grid is the special case they say does not scale. Read [11] together with [36]–[37] only if the parameter view has to leave two axes.

### [12] Chu et al., arXiv 2025, DiCriTest — medium

**Said.** Critical-scenario search gets stuck in one corner of a high-dimensional space. You should search parameters and behaviors together.

**Did.** Two spaces. Parameter space: reduce dimensions, score subspaces, mix local perturbation and global exploration. Behavior space: score the agent’s interaction trace for criticality and diversity, and use that score to switch search mode.

**How.** Closed loop. Generate a scenario, run the agent, measure the trace, update where to search. They report about 56% more critical scenarios than baselines, on five decision-making agents.

**Here.** This is the closest outside paper to “parameters and behavior are different.” Their behavior space is a search signal. Ours is a reading of trajectories we already have (resolution, label, heatmap). Do not add their search loop. Do use their distinction when someone treats a cluster as “the” behavior of a parameter cell: one parameter neighborhood can contain more than one behavior, which is exactly what our pair cards test.

### [22] Zhao et al., IEEE T-ITS 2017, importance sampling for lane change — medium

**Said.** Rare crashes in lane change cannot be estimated by sampling the natural distribution. You will almost never see them.

**Did.** Accelerated evaluation: change the distribution of lead-vehicle behavior so crashes are common, then reweight to estimate the real crash probability.

**How.** Importance sampling on lane-change parameters. The estimate is a probability, not a set of behavior clusters.

**Here.** We do not estimate a crash probability. The grid is uniform in two parameters. Read only if someone asks why a uniform grid is a poor crash-rate estimator. It is a poor estimator. It is a good map of behavior.

## Visualization that is not our system

### [13] Routray, IEEE CG&A 2024 — low

**Said.** Visual analytics can help people trust autonomous driving by showing behavior, anomalies, and safety, with a human in the loop.

**Did.** A short survey / position piece.

**How.** No system you can reimplement from this paper.

**Here.** The senior paper cites it for the sentence “keep the human in the loop.” Our replayer and heatmap are that idea made concrete. The survey itself is optional.

### [14] Chen, Guo, Wang, IEEE T-ITS 2015 — low

**Said.** Traffic data visualization is mostly about flows, densities, and networks at city scale.

**Did.** A survey of traffic visualization.

**How.** Taxonomy of visual forms (maps, space–time cubes, heatmaps of counts).

**Here.** The senior paper cites it to say those pictures are the wrong scale. We draw one vehicle’s speed over time, not a city’s flow. Skip.

### [15] Clarinval and Dumas, IEEE T-ITS 2022 — low

**Said.** Intra-city traffic visualization has a large literature and still focuses on aggregate urban mobility.

**Did.** A systematic review.

**How.** Review protocol over published systems.

**Here.** Same use as [14]. Skip.

### [16] Liu et al., PacificVis 2024, dynamic scene graphs — low

**Said.** A dynamic scene graph can support visual understanding of a driving scene: who is related to whom over time.

**Did.** A visualization backed by a scene graph of one driving situation.

**How.** Graph of agents and relations, updated over time, plus views on that graph.

**Here.** We do not build a scene graph. Agent identity in our cards (CuttingIn, Parking) is a named actor in the scenario, not a learned graph. Skip unless you want a different representation than trajectories.

### [17] Chang et al., IEEE T-IV 2023, MetaScenario — low

**Said.** Driving scenario datasets need a common description, storage, and index, or you cannot query them.

**Did.** A framework for describing and indexing scenario data.

**How.** A data model and index, not an analysis of behavior inside one parameter sweep.

**Here.** Our runs already live in one results folder. Skip.

### [18] Applied Intuition blog, 2021, closed-loop log replay — low

**Said.** Take a real disengagement log and re-simulate it closed-loop to see if a new stack would have done better.

**Did.** A product blog, not a paper.

**How.** Replay a log with the stack in the loop so the vehicle can depart from the recorded path.

**Here.** We simulate from scenario parameters, not from a recorded disengagement. The senior paper groups this with [19]–[21] as “one run at a time.”

### [19] Foretellix blog, 2025, neural reconstruction — low

**Said.** Neural reconstruction can turn logged scenes into simulatable worlds at scale.

**Did.** A product blog.

**How.** Reconstruct a scene, then vary it. Marketing detail, not a method we can check.

**Here.** Not an input to this project. Skip.

### [20] Caesar et al., nuPlan, 2022 — low

**Said.** Open-loop prediction benchmarks do not test whether a planner’s actions change the future. You need closed-loop simulation.

**Did.** nuPlan: a closed-loop planning benchmark with logs, metrics, and a simulator.

**How.** Replay real logs, let the planner control the ego, score the result.

**Here.** Different task. We compare behaviors inside one designed scenario family. nuPlan compares planners across a log dataset. Skip unless the question is “should we switch to log replay?”

### [21] Bach et al., SAE 2017-01-1671, reactive replay — low

**Said.** Early validation of a closed-loop controller can replay a recorded scene but let other agents react, so the recording does not become invalid when the controller leaves the original path.

**Did.** A reactive-replay method for early controller tests.

**How.** Replay plus a reaction model for the surrounding traffic.

**Here.** Same bucket as [18] and [20]. One scenario, not a parameter grid. Skip.

### [23] Hou et al., IEEE TVCG 2022 — medium

**Said.** A single score for an autonomous-driving stack hides which module failed.

**Did.** A visual analytics system over one drive: perception, prediction, plan, control, comfort. An evaluation model with adjustable weights, animated over time. The user drills into the bad component.

**How.** Per-timestep scores and contributing factors, linked to the scene.

**Here.** This is single-scenario diagnosis. The senior paper cites it as what we do *not* scale up: there is no parameter sweep and no clustering of thousands of runs. Read the VIS abstract if you need to explain that difference. Do not add their module-score model. Our data is the motion planner’s trajectories, not a full perception stack.

### [24] Sun et al., PacificVis 2024, corner cases — medium

**Said.** Corner cases are hard to interpret from a log alone. A visual analytics workflow can help an analyst say what went wrong in a corner case.

**Did.** Views for interpreting individual autonomous-driving corner cases. Same visualization group as [23].

**How.** Analyst-driven inspection of one hard case, not a clustering of a parameter grid.

**Here.** Our pair card is the corner-case comparison they do not do: two trials, nearly the same parameters, different clusters. Read [24] only to see the single-case style we are trying to get past.

### [25] Shi et al., IEEE T-ITS 2025, attribution-guided visualization — low

**Said.** A driving model’s decision can flip because of a small change in the perception input, and that flip is not how a person would explain it.

**Did.** An attribution method (cumulative layer fusion) that marks which network parameters mattered, then a visualization that only changes those critical inputs so you can see why the decision shifted.

**How.** Neural attribution plus a regularized visualization. It explains a network, not a kinematic trajectory.

**Here.** We do not have a network decision to attribute. “Why” in our cards is a sentence about speed, gap, and who was ahead. Skip.

## The methods we actually run

### [26] Happ and Greven, JASA 2018, multivariate functional PCA — high

**Said.** Multivariate functional PCA extends classical PCA to curves that are observed on possibly different domains, and to several curves at once.

**Did.** The statistical estimator: mean function, covariance, eigenfunctions, and scores. This is the paper behind “MFPCA.”

**How.** Treat each trajectory channel (speed, acceleration, relative position) as a function of time. Estimate the covariance operator. Keep the leading eigenfunctions. Each trial becomes a vector of scores.

**Here.** This is the embedding. We keep components that explain most of the variance and cluster the scores. The paper does not know about collisions or padding. Read the estimator if you need to check what a score means. Do not expect it to define a behavior.

### [27] Middlehurst, Schäfer, Bagnall, Data Mining and Knowledge Discovery 2024, bake-off redux — medium

**Said.** A large bake-off of recent time-series classifiers. Several strong methods assume equal length or need a defined way to handle unequal length.

**Did.** An experimental review, not a new distance.

**How.** They compare classifiers on archives. Variable length is a known nuisance: pad, truncate, or use a method that accepts it.

**Here.** The senior paper cites [27]–[29] only for the padding idea: a short trial (a collision that ended early) is extended with its own mean plus a little noise, so MFPCA can see it. The noise is there so the pad is not a fake constant that looks like a real behavior. Read [27] only if you are about to change padding. The bake-off ranking is irrelevant.

### [28] Tan, Petitjean, Keogh, Webb, arXiv 2019, classification of varying-length series — medium, optional

**Said.** Many classifiers assume equal length. Varying length needs an explicit treatment, and naive resampling can distort the series.

**Did.** Studies how to classify series that are not the same length.

**How.** Compares treatments of length (including warping and resampling) rather than proposing our mean-plus-noise pad.

**Here.** Background for why we had to choose a pad. [27] is enough unless you are changing the pad.

### [29] Bier, Jastrzebska, Olszewski, IEEE Access 2022 — low

**Said.** ROCKET, a fast time-series classifier, can be used on variable-length multivariate series. Their case is incident detection.

**Did.** An application of ROCKET with a variable-length setup.

**How.** Random convolutional kernels, then a linear classifier. Not a functional PCA.

**Here.** We do not classify with ROCKET. The citation is only “other people also face unequal length.” Skip.

### [30] Petitjean, Ketterlin, Gançarski, Pattern Recognition 2011, DTW barycenter averaging — medium

**Said.** You can average time series under dynamic time warping by iterating alignments (DBA), and that average is a usable prototype for clustering.

**Did.** The DBA algorithm: align every series to a prototype with DTW, average the aligned values, repeat.

**How.** Pairwise warping. Cost grows with the number of pairs. The output is a prototype curve, not a vector of scores you can plot in two FPC axes.

**Here.** The senior paper cites this as the method they did *not* use. DTW would stretch a collision (short) onto a long safe trial and hide the fact that one ended early. MFPCA keeps a common time axis, which the heatmap needs. Read the first pages only if you want to defend that choice.

### [31] Campello, Moulavi, Sander, PAKDD 2013, HDBSCAN — high

**Said.** DBSCAN’s single distance threshold is brittle. Extract a hierarchy of density clusters and keep the stable ones.

**Did.** HDBSCAN: mutual-reachability distance, minimum spanning tree, condensed tree, stability.

**How.** Two parameters matter in practice: minimum cluster size, and (in the implementation we use) the cluster selection epsilon and the selection method (`eom`). Noise points are label −1. It does not ask you for the number of clusters.

**Here.** This is the clusterer. We sweep minimum cluster size and epsilon and keep many candidates. The silhouette ([32]) ranks them. It does not pick the analyzed folder by itself: several epsilons can share one silhouette and one partition. The analyzed run is the one whose task matches the saved folder. Read the condensed-tree idea so “number of clusters was not an input” is obvious.

### [32] Rousseeuw, 1987, silhouettes — high

**Said.** For each point, compare its average distance to its own cluster with its average distance to the nearest other cluster. The silhouette is that comparison, averaged.

**Did.** A number between −1 and 1, and a plot that shows which points sit in the wrong cluster.

**How.** Needs a distance in the same space you clustered. We compute it on the FPC scores.

**Here.** Silhouette is one piece of the geometry score. It is high when clusters are tight and separated in FPC space. It does not know pass versus yield. The behavior score is a different number: outcome purity and distinct summary titles. Pair outcome flips are not in that score. A high silhouette can merge two safe behaviors that a reader would keep apart. Read the definition once. Do not use it as the only reason to keep a clustering.

### [33] Murtagh and Legendre, 2014, Ward’s method — medium

**Said.** “Ward” is not one formula. The commonly implemented Ward criterion minimizes the increase in within-cluster variance, and implementations differ on whether distances are squared.

**Did.** Clarifies which algorithm is which.

**How.** Agglomerative clustering. Merge the two clusters whose merge increases the sum of squares the least.

**Here.** Used only to order heatmap rows, not to define the behavior clusters. Rows are the leaf order of Ward on the MFPCA scores, then [34] polishes that order. Read it only if heatmap neighbors look wrong.

### [34] Bar-Joseph, Gifford, Jaakkola, Bioinformatics 2001, optimal leaf ordering — medium

**Said.** A hierarchical clustering has many equally valid leaf orders. You can flip subtrees so that adjacent leaves are as similar as possible, in polynomial time.

**How.** Dynamic programming over the tree. The clustering does not change. Only the left-to-right order changes.

**Here.** After Ward, this is why similar trials sit next to each other in the heatmap. It is a display order, not a behavior. Read the one-paragraph claim. You do not need the recurrence unless you are debugging the order.

## If the parameter view grows past two axes

### [36] Tyagi, 2022, visualization of high-dimensional parameter spaces — medium

**Said.** A thesis on how to look at and optimize spaces with many parameters: projection, slicing, and coordinated views.

**Did.** A collection of techniques, not one algorithm for driving scenarios.

**How.** Standard high-dimensional visualization: project, slice, link views.

**Here.** The senior paper’s discussion cites [36]–[38] and then says the parameter view stays two-dimensional on purpose. Read [37] first. Open [36] only as a catalog if that view has to change.

### [37] Evers and Linsen, Computers & Graphics 2022 — high

**Said.** When each simulation is a spatio-temporal run and the inputs are many parameters, partition the parameter space into regions whose runs behave alike.

**Did.** The closest published cousin of our picture. Cluster the runs by similarity of their output. Those clusters become segments of the parameter space. Show the segments with a hyper-slicer (undistorted 2D slices) and a 2D embedding of the samples for navigation. An analyst can refine the partition.

**How.** Similarity of the simulation outputs → clusters → connected regions in parameter space → linked views.

**Here.** We already do a simpler version in two parameters: HDBSCAN on trajectories, then color the OncomingSpeed × OncomingStartDelay plane by cluster. [37] is what to read before adding a third parameter. Their hyper-slicer is the honest way to show a segment that is not a blob in one scatterplot. They do not interpret a driving action (pass or yield). That interpretation is ours.

### [38] Laa and Valencia, arXiv 2023 — low

**Said.** Clustering and visualization tools for a high-dimensional physics parameter space (B-physics anomalies), as a worked example.

**Did.** Applies general clustering and tour/projection tools to a particle-physics scan.

**How.** Not a driving method. The point of the citation is “other fields also cluster high-dimensional parameter scans.”

**Here.** If you read [37], you do not need [38].

## What is useful, in one page

Useful and already in the system:

- [4] tells you the grid is a set of concrete scenarios from one logical scenario.
- [5] and [35] tell you TTC and SPrET are criticality, not behavior.
- [26], [31], and [32] are the embedding, the clusterer, and the geometry score.
- [30] is the rejected alternative (DTW), worth one page so the padding choice is defensible.
- [33] and [34] only order heatmap rows.
- [37] is the paper to read before the parameter view leaves two dimensions.

Useful as a contrast, not as code:

- [3], [8], [9], [11], and [22] find or draw a failure region. They stop at collision.
- [12] is the outside paper that also separates parameter space from behavior space, but it uses behavior to *search*, and we use behavior to *read*.
- [23] and [24] explain one drive. We explain a family of drives.

Not useful for the current logic:

- [7], [10], [13]–[21], [25], [28], [29], [38].

Nothing in this list defines `pass_first`, `yield`, or `unresolved`. Those are this project’s reading of a trajectory, written after the senior paper’s clustering. The references explain the grid, the embedding, and the pictures. They do not explain the card.
