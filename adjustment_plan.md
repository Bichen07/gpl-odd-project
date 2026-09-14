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

### Bug found + fixed: Parking evidence was present in text but never usable

Root cause had three independent parts (cluster3 medoid, `results/batch8/
6_cluster_s=0.6113`, was the reproduction case — Ego severely brakes to
~2 m/s while `CuttingIn` opens away behind but `Parking` closes to ~10 m
ahead-right):

1. **BEV crop.** Medoid BEV half-extent is keyed only to the *primary*
   vehicle's distance (`+2 m`). When the primary vehicle is close (as it is
   right when Ego is braking hard), a secondary agent like `Parking` can sit
   outside the drawn frame even though it is the real cause — confirmed on
   `t_11.60_...jpg` / `t_13.10_...jpg`: only Ego + CuttingIn are drawn.
   **Not fixed (by design — text is ground truth); now documented in
   `common_sense.txt`'s BEV reading guide so the LLM is told not to treat a
   missing secondary box as "agent is irrelevant".**
2. **Silent clearance bug (root cause of the missing text signal).**
   `collision_vehicle._dims_for_name` / `_ego_name` indexed `df["name"]`
   unconditionally; this dataset's `raw/trajectory.csv` only has `trackId`
   (no `name` column), so every secondary-agent boundary-clearance lookup
   raised `KeyError`, was swallowed by a broad `except Exception: return
   None` in `minimum_vehicle_boundary_distance_m`, and silently produced
   `clearance_m=None` for **every** secondary agent in **every** run using
   this trajectory format — no `context_medoid.md` anywhere in the repo ever
   showed "minimum distance between vehicle boundaries" on a secondary line.
   **Fixed:** both helpers now fall back to default vehicle dimensions when
   `name` isn't a column, instead of raising.
3. **Dead deterministic hint.** `secondary_context.candidate_control_reason`
   (the A1 "Hybrid" `candidate_control_reason` decision below) was
   implemented but only reachable from `format_secondary_obstacles_section`,
   which no medoid/pair context builder ever calls — `conflict_frame_selector.py`
   and `parameter_space_pair_packs.py` call `secondary_inline_clauses`
   directly, which never invoked it. Its brake-onset gate (±0.15 s of a
   discrete decel-onset sample) was also too narrow to fire during a
   *sustained* slow approach to an obstacle well after the last onset.
   **Fixed:** `secondary_inline_clauses` now computes `candidate_control_reason`
   per stamp and appends `candidate_control_reason=braking_near_stationary_obstacle
   (<name>, clearance=…m)` inline when it fires; the gate was widened to also
   fire when Ego is still slow (`≤3 m/s`) within 5 s of any earlier decel
   onset, not only exactly at an onset sample.

`common_sense.txt` (motive-code table + precedence rules) and
`medoid_trial_prompt.txt` (situation-clause instructions) were updated to
require checking secondary-agent clauses / `candidate_control_reason` for
`post_clear_adjustment` / `post_clear_hard_brake` before crediting the brake to
the primary named vehicle only. `context_medoid.md` for the whole batch8 run
was regenerated via `--rebuild-context-texts` to pick up the fix.

### Proposed deterministic inclusion rule

Build a compact secondary-agent evidence block for each medoid and pair
context. **Implementation:** secondary agents are inlined on the same timeline
line as the primary conflict vehicle (same metric vocabulary), shown only when
within 40 m at that timestamp — not a separate timeline section.

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

- [x] `context_medoid.md` includes relevant Parking evidence when the rule
      selects Parking (inline on the main timeline when within 40 m).
- [x] Pair context includes secondary-object evidence on a shared clock
      (inline on Layer 1 lines when within 40 m).
- [x] The LLM cannot attribute braking to a vehicle whose evidence is absent
      (omitted when beyond 40 m at that timestamp).
- [x] Primary and secondary interactions are clearly labeled (`CuttingIn` primary;
      `Parking (secondary, …)` inline).
- [x] Post-conflict continuation is preserved but not confused with paired
      geometry evidence (pair Layer 2).
- [x] Existing context, medoid, pair, and dashboard readers remain compatible.
- [ ] Re-run the cluster-1 and `c2-c5` examples and compare the LLM-invented
      labels/captions with the paper's smooth-pass, pass-slowdown, and
      braking-rear-end definitions.

### Open design questions — resolved

| Question | Decision | Rationale |
|---|---|---|
| Should 40 m be measured at the first selected frame, conflict peak, or both? | **Both, plus decel frames.** Evaluate the 40 m gate at (1) first conflict-window frame, (2) `peak_t`, and (3) any frame where ego deceleration exceeds a fixed threshold (e.g. \|Δv\| > 0.5 m/s over 0.5 s). Union the agent sets. | Peak captures tight geometry; first frame captures approach setup; decel frames capture what actually triggered braking. |
| Should a stationary object in Ego's lane always be included even when initially farther than 40 m? | **No** (user confirmed). Include only via the path-corridor rule: if deterministic lane projection shows the object in Ego's forward corridor within **60 m along-route** during the selected window. | Avoids flooding every context with distant parked cars; still catches lane-blocking obstacles that matter. |
| How many secondary objects before context becomes noisy? | **At most 2 secondary objects** in the timeline body, ranked by: (1) actual collision partner if not primary, (2) minimum boundary clearance during ego-decel intervals, (3) minimum distance in post-peak window. Others listed in one line: `also present: … (not shown)`. Per secondary object: **≤ 5 stamps** (enter range, min clearance, brake onset, collision if any). | Keeps context readable; prioritizes causally relevant obstacles. |
| Should causal attribution remain LLM-only, or should the builder emit a candidate reason? | **Hybrid.** Deterministic builder emits `candidate_control_reason` when evidence is strong (e.g. `braking_near_stationary_obstacle`, `braking_for_primary_conflict`, `post_collision_recovery`), with a pointer to the stamp. LLM may adopt it or override with explicit justification. | Reduces misattribution (Parking vs CuttingIn) while keeping nuanced interpretation for ambiguous cases. |

## A2 — Analyze the full trajectory after one pair side ends

### Motivation

Parameter-space pairs are selected because two trials share similar initial
parameters but land in **different clusters**. Clustering itself (MFPCA +
HDBSCAN) operates on the **whole trajectory shape**, not only the synchronized
conflict window. That means the cluster split is often driven by:

1. A **critical divergence** while both trials are still active, or
2. **Different continuation and termination** after one trial ends earlier,
   including secondary obstacles, recovery, and later collisions.

Stopping pair analysis when the first side ends therefore contradicts the
clustering evidence: Layer 1 may look nearly identical even though the full
trajectories—and therefore the cluster assignment—clearly differ.

In `c2-c5`, for example, `[c5]` collides with `CuttingIn` around `t=10.7`,
while `[c2]` continues, brakes in response to the `Parking` vehicle, and
later collides with `CuttingIn` at `t=18.86`. The synchronized interval
supports an `over_fine` geometry call, but the **whole-trial shape difference**
is exactly why these trials belong to different clusters.

### Alignment with MFPCA + HDBSCAN

| What clustering uses | What pair analysis must explain |
|---|---|
| Full trajectory embedding (shape + timing + termination) | Why two same-parameter trials split clusters |
| Similar early geometry is common at boundaries | Early similarity does **not** mean behavioral identity |
| Tail behavior and trial end time affect the embedding | Post-conflict continuation is primary evidence, not a footnote |

Pair analysis should therefore answer two linked questions:

1. **Where** did the synchronized boundary diverge (if at all)?
2. **How** do the complete trials differ in shape, outcome, and failure
   mechanism—the same dimensions MFPCA used to separate them?

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

#### Layer 2 — Full-trial continuation analysis (cluster-split evidence)

After Layer 1 ends, continue reading each side independently until that
trial's own trajectory/action timeline ends. This layer is **required**, not
optional: it carries the trajectory-shape evidence that MFPCA+HDBSCAN already
used to place the two trials in different clusters.

- Mark every line explicitly as `[cA] continuation` or `[cB] continuation`.
- Do not align or compare a continuation frame with an ended side.
- Preserve relevant control actions, secondary obstacles, collision partners,
  collision times, trial end time, and recovery behavior.
- Include deterministic events from `action.yaml` and the available trajectory
  evidence; do not infer an obstacle or collision partner that is absent.
- Make the continuation a first-class section of the pair context and LLM
  prompt, with equal weight to Layer 1.
- When Layer 1 geometry is similar but clusters differ, Layer 2 should be the
  default explanation target (`trajectory_shape_difference`), not an afterthought.

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
- `trajectory_shape_difference`: deterministic summary of how the complete
  trials differ in termination, tail behavior, collision timing, and secondary
  interactions—the dimensions most likely to explain the MFPCA cluster split
  when Layer 1 is similar.

The existing `separation_call` remains the synchronized boundary judgment.
The pair card must additionally report `trajectory_shape_difference` and
`downstream_behavior_difference`. A synchronized `over_fine` call must not
silently imply that the complete trials are behaviorally identical; in many
boundary pairs, `over_fine` plus a strong `trajectory_shape_difference` is
the **expected** pattern, not a contradiction.

### Expected `c2-c5` interpretation

The revised analysis should be able to state:

- Layer 1: both sides are pass-first and move similarly before `[c5]` ends;
  this supports an `over_fine` synchronized geometry judgment.
- Layer 2: `[c5]` has an early `CuttingIn` collision and ends; `[c2]`
  continues, reacts to `Parking`, and later has a `CuttingIn` collision.
- `trajectory_shape_difference`: different trial length, collision timing,
  secondary-obstacle response, and final outcome despite similar early geometry.
- Overall: `over_fine` + strong `trajectory_shape_difference` is consistent
  with MFPCA+HDBSCAN placing these trials in different clusters. The pair card
  should explain the cluster split via the full trajectory, not apologize for
  Layer 1 similarity.

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

- [x] Pair context stops synchronized evidence at the first ended side.
- [x] Pair context continues each surviving side independently to trial end.
- [x] Parking and other relevant secondary obstacles are shown with
      deterministic evidence (inline in Layer 1 when within 40 m).
- [x] Primary-interaction and whole-trial outcomes are separate
      (`trajectory_shape_summary.json`).
- [x] Collision partner and collision time are preserved for downstream events.
- [ ] `separation_call` remains based on synchronized evidence (LLM not re-run).
- [ ] Downstream behavior differences are visible in YAML, summaries,
      dashboard, and ODD Q&A (context + JSON done; YAML/dashboard pending).
- [x] `c2-c5` no longer appears behaviorally identical merely because its
      synchronized section is `over_fine`.
- [x] `over_fine` + `trajectory_shape_difference` is documented as a normal
      boundary pattern aligned with whole-trajectory clustering.
- [x] Pair cards explicitly link cluster split to full-trajectory evidence,
      not only to synchronized geometry (in `process/context.md`).

### Open design questions — resolved

| Question | Decision | Rationale |
|---|---|---|
| What goes into `trajectory_shape_difference`? | **Deterministic summary block** before the LLM call: `trial_end_t` per side, `collision_t` + partner per side, `tail_length_s` (trial end − Layer 1 end), `post_primary_decel_max` per side, `secondary_obstacle_encountered` per side, `whole_trial_outcome` per side. LLM interprets `failure_mechanism` from this block. | Aligns with MFPCA whole-trajectory clustering without asking the LLM to invent timing facts. |
| Both sides survive past Layer 1 — still do Layer 2? | **Yes.** Continue each side independently to its own trial end. Compare only in the summary fields (`trajectory_shape_difference`, `downstream_behavior_difference`), never frame-by-frame after Layer 1. | Tail divergence can exist even when neither side "ended early." |
| Layer 2 BEV images? | **Phase 1: text only** from `action.yaml` + sparse trajectory samples at key events (collision, max decel, trial end). **Phase 2 (optional):** single-panel BEV at those key stamps only. | Avoids doubling BEV cost; text is enough for most continuation evidence. |
| How do `separation_call` and `downstream_behavior_difference` interact? | **Independent dimensions.** `separation_call` = synchronized geometry only (`justified` / `over_fine` / `inconclusive`). `downstream_behavior_difference` = `material` / `immaterial` / `not_applicable`. `over_fine` + `material` is the **expected** MFPCA-boundary pattern. | Prevents conflating "similar early geometry" with "same behavior." |
| Does the medoid context also need full trajectory? | **Yes.** Extend `context_medoid.md` to trial end, not only the conflict burst. Apply A1 secondary-object rules in the post-peak section. | Medoid labels (Smooth Pass vs Pass-Slowdown vs Brake Rear-end) depend on post-pass evidence. |

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
2. **Geometry / kinematics (name-agnostic)**
   - Lateral / side impact → `Side Collision` (partner name stays in
     `collision_partner` / caption, not the label).
   - Partner nearly stationary at contact → `Stationary Collision`.
3. **Open partner fallback**
   - Any other verified partner → `{display_partner} Collision` (actor names
     are scenario-specific; do **not** maintain a CuttingIn/Parking/Oncoming
     lookup table).
4. **Safe or non-collision behavior arc**
   - pass-first with no meaningful post-pass braking → `Smooth Pass`;
   - pass-first with meaningful post-pass slowdown but no rear-end contact →
     `Pass-Slowdown`;
   - proactive or late yield variants → `Proactive Yield` or `Late Yield`.
5. **Fallback**
   - Closest mechanism/resolution label only when partner and geometry evidence
     are both missing.

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

For maximum scalability across many scenarios / actor names, **`label` is
invented by the summary LLM** from medoid + cluster context + neighbor
evidence. Soft style examples in prompts are non-binding. The pipeline does
**not** overwrite YAML `label`. Sibling labels already on disk are soft
guidance only (avoid pointless duplicates when behaviors differ).

### LLM-owned labels (current)

| Piece | Role |
|---|---|
| **Evidence in** | `medoid_trial.yaml`, `context_cluster.md`, neighbor contrast cards |
| **Soft siblings** | `{sibling_labels_brief}` from other `cluster_summary.yaml` on disk |
| **LLM** | Invents short descriptive `label` + caption / neighbor verdicts |
| **Pipeline** | Keeps parsed `label`; sets `risk_level` from collision rate only |

Abandoned: deterministic Pass A / Pass B `label_resolver.py` (closed mechanism
names + forced overwrite). That approach does not scale to 1000+ scenarios.

### Expected labels for the current Case Study 3 run

Paper-oriented expectations (for human comparison after re-running summary) —
not forced by code:

- Current C5: side / cut-in style collision naming is plausible.
- Current C2 / C3: rear-end / post-pass brake collision naming is plausible;
  identical short labels across C2 and C3 are acceptable if captions differ.
- Current C4: yield-stop collision naming is plausible.

### Validation checklist

- [x] No hardcoded CuttingIn / Parking / Oncoming → label map in code.
- [x] Summary prompt + common_sense: LLM invents `label`; open vocabulary.
- [x] Pipeline does **not** overwrite `parsed["label"]`.
- [x] `label_resolver.py` / Pass A/B / `label_facts.json` writer removed.
- [ ] Re-run Case Study 3 cluster-summary and compare captions/labels with the
      paper by hand. Do not write labels into `context_medoid.md`.

### Open design questions — resolved

| Question | Decision | Rationale |
|---|---|---|
| Fixed car names in labels? | **No.** LLM may use any actor name when useful; no code lookup table. | Scales to many scenarios / actor names. |
| Who invents `label`? | **Summary LLM.** Soft style examples only; sibling labels soft guidance. | Evidence-in / name-out; rules do not scale. |
| Mixed clusters (collision_rate 20–80%)? | Dominant archetype in `label`; state mixture in `caption`; use `confidence`. | Honesty about heterogeneity lives in caption. |
| C2 and C3 similar rear-end? | Same or different short labels OK; differentiate in caption. | Detail belongs outside the short label when needed. |

## Cross-cutting implementation order

Implement in this sequence because each step depends on the previous:

1. **A1** — secondary-agent evidence in medoid + pair Layer 1 context.
2. **A2** — full-trial continuation + `trajectory_shape_difference` block.
3. **A3** — LLM-owned cluster `label` from enriched medoid/context evidence
   (deterministic name resolver abandoned).
4. Re-run cluster-1 medoid, `c2-c5` pair, then all three thesis runs.
5. Update dashboard, cross-cluster briefing, and ODD Q&A to surface new fields.

**Dependency note:** post-pass Parking / secondary evidence (A1) and whole-trial
continuation (A2) still improve *caption* quality even though names are LLM-authored.
