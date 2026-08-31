# Adjustment Plan

This document records proposed changes discussed after the current
implementation plan. These items are discussion candidates only; implement
them after the relevant design is agreed.

## A1 — Include relevant secondary vehicles in LLM context

### Problem

`context_medoid.md` and parameter-space pair context currently focus on the
selected conflict vehicle, such as `CuttingIn`. The context may list other
agents in the scene header, such as `Parking`, but omit their position,
distance, lane, and boundary clearance from the timeline.

This can cause the LLM to assign the wrong cause to an ego control action. For
example, braking after passing `CuttingIn` may actually be a response to the
stationary `Parking` vehicle. Without Parking evidence, a pass-slowdown or
braking-rear-end behavior can be mislabeled as a late reaction to CuttingIn.

### Proposed deterministic inclusion rule

Build a compact secondary-agent evidence section for each medoid and pair
context:

1. Start with every non-ego vehicle or static obstacle within **40 m
   center-to-center distance** of Ego at the beginning of the conflict
   context.
2. Also include an agent that enters the 40 m range during the selected
   conflict window, even if it was farther away at the first frame.
3. Always include the actual collision partner and any object in Ego's
   projected lane/path conflict corridor, regardless of the 40 m gate.
4. Keep the selected conflict vehicle explicitly marked as the **primary
   interaction**. Mark other included objects as **secondary obstacles or
   interactions**.
5. Report only deterministic, relevant fields at selected timeline stamps:
   object name/role, stationary or moving state, road/lane, relative position,
   center-to-center distance, and minimum distance between vehicle boundaries.
   Do not dump every agent at every timestamp.

The 40 m value should be a named code constant/configuration value, not an LLM
decision. The context builder should explain which inclusion rule selected
each secondary object.

### Required output distinction

The context should allow the LLM to distinguish:

- `CuttingIn` interaction resolution and pass/yield behavior;
- braking caused by `Parking` or another downstream obstacle;
- later collision partner and collision time;
- post-conflict continuation after the primary interaction.

For parameter-space pairs, the secondary-object evidence must be synchronized
at the same shared timestamps for both sides while both sides are alive. If one
side ends, its unpaired tail remains separately marked as
`post-conflict continuation`; it must not be presented as synchronized
geometry evidence.

### Example acceptance case

For the cluster-1 medoid in
`results/batch8/6_cluster_s=0.6113`, the context should show Parking's
relationship to Ego around the braking interval. The LLM should then decide
whether the behavior is:

- smooth-pass, if no meaningful post-pass braking is present;
- pass-slowdown, if Ego gradually brakes after passing because of Parking; or
- braking-rear-end, if abrupt braking for Parking creates a following-vehicle
  collision risk.

For `parameter_space_pairs/c2-c5`, the context should preserve the shared
CuttingIn comparison and separately expose the survivor's later Parking-related
continuation and collision, without incorrectly treating that unpaired tail as
the original synchronized boundary divergence.

### Validation checklist

- [ ] `context_medoid.md` includes relevant Parking evidence when the rule
      selects Parking.
- [ ] Pair context includes secondary-object evidence on a shared clock.
- [ ] The LLM cannot attribute braking to a vehicle whose evidence is absent.
- [ ] Primary and secondary interactions are clearly labeled.
- [ ] Post-conflict continuation is preserved but not confused with paired
      geometry evidence.
- [ ] Existing context, medoid, pair, and dashboard readers remain compatible.
- [ ] Re-run the cluster-1 and `c2-c5` examples and compare the generated
      labels with the paper's smooth-pass, pass-slowdown, and
      braking-rear-end definitions.

### Open design questions

- Should 40 m be measured at the first selected frame, the conflict peak, or
  both?
- Should a stationary object in Ego's lane always be included even when it is
  initially farther than 40 m?
- How many secondary objects should be shown before context becomes noisy?
- Should causal attribution remain an LLM interpretation, or should the
  deterministic builder emit a candidate reason such as
  `braking_near_stationary_obstacle`?

## A2 — Analyze the full trajectory after one pair side ends

### Motivation

Parameter-space pair analysis serves two purposes:

1. Compare two matched trials while both are alive to understand the
   synchronized behavioral boundary.
2. Explain the complete behavior pattern and safety outcome of each trial.

The current pair card handles the first purpose, but stopping the analysis when
one side ends loses important evidence for the second purpose. In
`c2-c5`, for example, `[c5]` collides with `CuttingIn` around `t=10.7`,
while `[c2]` continues, brakes in response to the `Parking` vehicle, and
later collides with `CuttingIn` at `t=18.86`.

### Two-layer comparison design

#### Layer 1 — Synchronized boundary comparison

Keep the existing shared-clock comparison unchanged:

- Compare geometry only while both pair sides are alive.
- Use shared timestamps, synchronized BEVs, longitudinal relationship,
  vehicle position, and minimum boundary clearance.
- Derive `critical_divergence` only from this synchronized interval.
- Stop synchronized comparison when either side is ended or out of clip.

This prevents an unpaired survivor tail from being incorrectly treated as
direct geometric evidence.

#### Layer 2 — Full-trial continuation analysis

After Layer 1 ends, continue reading each side independently until that
trial's own trajectory/action timeline ends:

- Mark every line explicitly as `[cA] continuation` or `[cB] continuation`.
- Do not align or compare a continuation frame with an ended side.
- Preserve relevant control actions, secondary obstacles, collision partners,
  collision times, and recovery behavior.
- Include deterministic events from `action.yaml` and the available trajectory
  evidence; do not infer an obstacle or collision partner that is absent.
- Make the continuation a first-class section of the pair context and LLM
  prompt, rather than an optional footnote.

### Required outcome separation

Pair products should distinguish these concepts instead of using one generic
`outcome` field:

- `primary_interaction_outcome`: outcome with the selected conflict vehicle,
  such as `CuttingIn`.
- `whole_trial_outcome`: final trial-level safety outcome.
- `downstream_events`: later obstacles, control responses, collisions, and
  recovery after the primary interaction.
- `failure_mechanism`: an LLM interpretation grounded in the deterministic
  continuation evidence, such as post-pass braking for `Parking` followed by
  a rear-end collision.
- `downstream_behavior_difference`: whether the two full trials have
  materially different failure mechanisms or outcome timing.

The existing `separation_call` remains the synchronized boundary judgment.
The pair card must additionally report whether the full-trial continuation
reveals a behaviorally important difference. A synchronized `over_fine` call
must not silently imply that the complete trials are behaviorally identical.

### Expected `c2-c5` interpretation

The revised analysis should be able to state:

- Layer 1: both sides are pass-first and move similarly before `[c5]` ends;
  this supports an `over_fine` synchronized geometry judgment.
- Layer 2: `[c5]` has an early `CuttingIn` collision, whereas `[c2]`
  continues, reacts to `Parking`, and later has a `CuttingIn` collision.
- Overall: the pair has a meaningful downstream failure-mechanism and
  collision-timing difference, even if its synchronized geometry is similar.

### Implementation order

1. Extend the deterministic context builder to emit secondary-agent evidence
   and full-trial continuation sections.
2. Update the parameter-space pair prompt to read Layer 1 and Layer 2
   separately and require the new outcome distinctions.
3. Extend `contrast.yaml` with the continuation and downstream-difference
   fields while keeping existing fields readable.
4. Update cluster summaries, cross-cluster analysis, dashboard cards, and ODD
   briefing/Q&A routing to expose downstream behavior differences.
5. Rebuild and review the cluster-1 medoid and `c2-c5` pair before applying
   the change to all thesis runs.

### Validation checklist

- [ ] Pair context stops synchronized evidence at the first ended side.
- [ ] Pair context continues each surviving side independently to trial end.
- [ ] Parking and other relevant secondary obstacles are shown with
      deterministic evidence.
- [ ] Primary-interaction and whole-trial outcomes are separate.
- [ ] Collision partner and collision time are preserved for downstream events.
- [ ] `separation_call` remains based on synchronized evidence.
- [ ] Downstream behavior differences are visible in YAML, summaries,
      dashboard, and ODD Q&A.
- [ ] `c2-c5` no longer appears behaviorally identical merely because its
      synchronized section is `over_fine`.

## A3 — Make cluster labels paper-aligned and evidence-driven

### Problem

The current cluster label is generated from the medoid's
`interaction_resolution`, `control_response`, and collision dominance. This
can produce labels such as `Pass-First Late Collision`, even when the more
useful behavior name is `Cut-in Collision`, `Brake Rear-end`, or
`Yield-Stop Collision`.

The label should summarize the cluster's dominant behavior and failure
mechanism. It should not mechanically concatenate fields or rely on the
cluster number. Cluster IDs are assigned by HDBSCAN and are not paper
semantic IDs.

### Proposed label architecture

Keep the detailed deterministic and LLM fields:

- `interaction_resolution`: pass-first, yield, or other;
- `primary_motive` and `secondary_motives`;
- `control_response`;
- `collision_partner`;
- `impact_type`, striking/struck vehicle, and collision time;
- whole-cluster collision rate and partner/mechanism consistency.

Add a concise canonical `label` selected from a closed vocabulary. The label
is chosen using the following precedence:

1. **Verified collision mechanism**
   - Ego brakes after passing and the following vehicle strikes Ego from
     behind → `Brake Rear-end`.
   - Ego yields/stops, remains behind or overlapping, and Ego strikes the
     conflict vehicle ahead at near-zero speed → `Yield-Stop Collision`.
2. **Verified collision partner**
   - Collision with `CuttingIn` and no more specific mechanism above →
     `Cut-in Collision`.
   - Collision with `Parking` → `Parking Collision`.
   - Collision with `Oncoming` → `Oncoming Collision`.
3. **Safe or non-collision behavior arc**
   - pass-first with no meaningful post-pass braking → `Smooth Pass`;
   - pass-first with meaningful post-pass slowdown but no rear-end contact →
     `Pass-Slowdown`;
   - proactive or late yield variants → `Proactive Yield` or `Late Yield`.
4. **Fallback**
   - Use the closest existing closed-vocabulary resolution/outcome label only
     when collision partner or mechanism evidence is missing or contradictory.

The collision-mechanism rules must use deterministic evidence. In particular,
`Brake Rear-end` requires a following vehicle as the striking vehicle and
post-pass braking evidence; a generic rear-end `impact_type` alone is not
enough to distinguish it from `Yield-Stop Collision`.

### LLM interaction

The LLM should not freehand the canonical label. Before the cluster-summary
call, deterministic code should produce a label-facts block containing:

- dominant interaction resolution;
- dominant collision outcome;
- collision-partner distribution and confidence;
- impact-type distribution;
- striking/struck direction;
- post-pass braking/slowdown evidence;
- whether the cluster is mixed or homogeneous.

The prompt should provide an allowed candidate list derived from those facts
and require the LLM to:

1. choose exactly one candidate label;
2. explain the choice in the caption using the medoid and neighbor evidence;
3. retain the detailed motive/control fields without putting every field into
   the label;
4. state when the cluster is mixed and the label is only the dominant
   archetype.

For maximum reproducibility, the final `label` may be assigned directly by
the deterministic label resolver, while the LLM supplies the caption and
`label_explanation`. This is preferred over asking multiple LLM calls to
invent equivalent names.

### Expected labels for the current Case Study 3 run

- Current C5: `Cut-in Collision` — CuttingIn is the verified collision
  partner and the impact is lateral; keep `pass_first`, `brake_release`, and
  `late` as detailed fields.
- Current C2: `Brake Rear-end` — CuttingIn strikes Ego from behind after Ego's
  post-pass hard braking.
- Current C3: `Brake Rear-end` — the slowdown is more gradual before the hard
  braking, but the medoid still ends in a following-vehicle rear-end
  collision.
- Current C4: `Yield-Stop Collision` — Ego remains in the yield interaction,
  reaches approximately stopped speed, and strikes CuttingIn ahead.

Identical canonical labels for C2 and C3 are acceptable. Their cluster IDs,
control-response timing, motives, and captions explain the difference between
the two rear-end variants.

### Validation checklist

- [ ] Canonical labels are selected from a closed, documented vocabulary.
- [ ] Collision partner is derived from deterministic collision evidence, not
      inferred only from proximity.
- [ ] `Cut-in Collision`, `Parking Collision`, and `Oncoming Collision` are
      available when the partner is verified.
- [ ] `Brake Rear-end` requires post-pass braking and a following-vehicle
      impact direction.
- [ ] `Yield-Stop Collision` requires yield-family behavior plus near-stop
      collision evidence.
- [ ] Safe `Smooth Pass` is not assigned when meaningful post-pass braking is
      present.
- [ ] Cluster labels are not derived from numeric cluster IDs.
- [ ] The dashboard and ODD Q&A expose both the concise label and its
      evidence-based explanation.
- [ ] Re-run Case Study 3 and compare C2, C3, C4, and C5 with the paper's
      C1–C6 descriptions.
