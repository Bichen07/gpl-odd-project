# Plan v5: medoid = kinematic time sections; cluster label stays at cluster summary

**Status:** proposal — **not implement-ready** (see §9–10 self-review).  
**Does not change:** clustering, BEV crop rules, Python inventing causes.

**Hard vocabulary split**

| Layer | What it is | Where it lives |
| --- | --- | --- |
| Medoid stamp / phase | Ego **maneuver** tied to Labeller kinematics | `decision_timeline`, `behavior_summary` |
| Named-vehicle interaction | pass vs give-way (thin) | one field on medoid — not a motive codebook |
| Cluster name | Paper heatmap **cluster label** | `cluster_summary.label` only |

Do **not** put Proactive Yield / Late Yield / Pass-Slowdown / … on the medoid card.

---

## 0. What cluster1 proves

Timeline already narrates Ego by time (accel → brake → pass → decelerate for Parking). That is medoid analysis.

`agent_interactions` then crushed it into invented motive codes (`late_reaction`, `gap_acceptance_creep`) plus overlapping `resolution`/`control_response`. Wrong layer.

Also wrong: treating paper cluster labels as if they were per-stamp motives.

---

## 1. Medoid flow (Labeller kinematics + LLM phases)

```text
action.yaml (Labeller) ──Python map──► stamp.longitudinal / stamp.lateral
context + BEV          ──► toward agent, pass_state, v/a quotes
LLM                    ──► description + phase paragraphs
                       + named_vehicle_interaction: pass_first|yield|unresolved
→ behavior_summary

NO paper cluster label on medoid YAML.
NO LLM inventing accelerate/hard_brake when Labeller did not emit them.
```

Cluster summary (separate product) invents paper `label` from **phases + thin interaction + outcome**. That step is **not** medoid analysis.

---

## 2. Stamp taxonomy: refer literature, do not invent a v×a name grid

### Why not “8 labels = high/low speed × +/0/− accel (+ lateral)”?

That grid **invents compound words** (`high_speed_high_accel`, …). Published maneuver catalogs do **not** do that. They keep axes **orthogonal and simultaneous**:

- At every time, Ego has **one longitudinal state** and **one lateral state**.
- Speed level (high/low) is a **quantity to quote**, not a separate enum axis that multiplies the label set.

So: quote `v` and `a` in the description; pick the maneuver from a small closed set grounded in papers.

### Literature to follow

**1. Hartjen, Sonntag, Schuldt, Fahrenkrog (IV 2020 / TUM) — *Classification of Driving Maneuvers in Urban Traffic***  
[PDF](https://mediatum.ub.tum.de/doc/1535131/document.pdf)

Three **parallel** layers (not one 8-cell grid):

| Layer | Closed set (basic) |
| --- | --- |
| Vehicle state (longitudinal) | `Accelerate` · `KeepVelocity` · `Decelerate` · `Reversing` (+ specials `Driveaway`, `Halt`, `Standstill`) |
| Infrastructure (lateral / road) | `FollowLane` · `LaneChange{L,R}` · `Turn{L,R,U}` · junction/crosswalk/park variants |
| Object-related | `FollowObject` · `ApproachObject` · `FallBehind` · `Passing` |

This matches the user’s axes without inventing compounds: **v / a → Layer 1**; **lateral velocity / heading → Layer 2**; interaction with CuttingIn/Parking → Layer 3 (**required** on conflict stamps — see §9E).

**2. Torstensson et al. — *Defining Fundamental Vehicle Actions…***  
[PDF](https://www.diva-portal.org/smash/get/diva2:1454057/FULLTEXT01.pdf)

Same idea: always one longitudinal + one lateral action; accel/decel defined by significant Δv, not by inventing “high-speed-brake” as a new word.

**3. This project’s action log (already in `common_sense`)**  
`ACCELERATE` / `DECELERATE` / `EMERGENCY_BRAKE` / `STOPPED` / `TURN_LEFT|RIGHT` / `LANE_CHANGE_*` — already Hartjen-compatible. Prefer these verbs over project neologisms (`assertive_gap_acceptance`, `maintain_through`, `late_reaction`).

**4. Lefèvre, Vasquez, Laugier (2014)** — [survey](https://doi.org/10.1186/s40648-014-0001-z)  
Separates physics (kinematics) vs maneuver intention vs interaction. Medoid stamp layer = physics/maneuver. Pass vs yield vs cluster heatmap names = higher layers (resolution / cluster summary), not stamp motives.

### Stamp closed set = Labeller actions only (Python maps; LLM does not invent)

**Longitudinal (exactly one per Labeller stamp; omit if no action at that t):**

| Code | Maps from `action.yaml` only |
| --- | --- |
| `accelerate` | ACCELERATE |
| `decelerate` | DECELERATE |
| `hard_brake` | EMERGENCY_BRAKE only (Labeller threshold −4 m/s²) |
| `standstill` / halt | STOPPED (and related stop events Labeller emits) |

Do **not** invent `keep_velocity` stamps in Labeller gaps unless Labeller later emits KEEP.  
Do **not** put `brake_release` in this enum — that is interaction narrative, not Layer 1.

**Lateral (exactly one):**

| Code | Maps from |
| --- | --- |
| `follow_lane` | no TURN_*, no LANE_CHANGE_* on that stamp |
| `turn_left` / `turn_right` | TURN_* |
| `lane_change_left` / `lane_change_right` | LANE_CHANGE_* |

**Not stamp codes:** paper cluster labels; project motives (`late_reaction`, `assertive_gap_acceptance`, …); `brake_release` as a longitudinal code.

Intensity stays in numbers: quote `v`, Δv, Δheading in the description.

**Object / interaction (required on conflict stamps, not optional):**

- toward named agent + quote pass_state / clearance from context  
- medoid-level thin field: `named_vehicle_interaction: pass_first | yield | unresolved`  
- no `control_response` / motive codebook

---

## 3. Cluster labels (cluster_summary only — not medoid)

Paper names stay **only** here:

`Smooth Pass` · `Pass-Slowdown` · `Yield` · `Proactive Yield` · `Late Yield` · `Cut-in Collision` · `Yield-Stop Collision` · `Brake Rear-end` · `Side Collision` · `Stationary Collision`

Cluster summary invents `label` from medoid **phase story + outcome**, using that menu. Medoid YAML does **not** author these strings.

---

## 4. Suggested medoid YAML

```yaml
# longitudinal/lateral prefilled from action.yaml (or LLM must copy action lines only)
decision_timeline:
  - timestamp: 4.7
    phase: approach          # gated: before named-vehicle conflict window
    longitudinal: accelerate # ← ACCELERATE in action.yaml
    lateral: follow_lane
    toward: CuttingIn
    description: "Ego accelerating at 5.65 m/s; CuttingIn ahead 18.2 m …"
  - timestamp: 9.2
    phase: conflict          # until named vehicle first behind-bin
    longitudinal: decelerate
    lateral: follow_lane
    toward: CuttingIn
    description: "Ego decelerating at 7.21 m/s; CuttingIn 4.8 m LEFT; Parking 30.8 m ahead …"
  - timestamp: 11.0
    phase: post_pass         # after CuttingIn behind-bin; may decelerate for Parking
    longitudinal: decelerate
    lateral: follow_lane
    toward: Parking
    description: "CuttingIn behind; Ego decelerating; Parking 19.0 m ahead …"
  - timestamp: 19.0
    phase: resume
    longitudinal: accelerate # only if Labeller stamped ACCELERATE
    lateral: turn_right
    description: "Right turn same lane at 3.29 m/s …"

named_vehicle_interaction: pass_first   # thin; vs named vehicle only
# optional extra agents: short notes in phases, not a motive triple table

behavior_summary: |
  Approach: …
  Conflict: … (quote brake_t vs peak_t; behind-bin)
  Post-pass: decelerate with Parking ahead …
  Resume: …
```

No medoid `label: Pass-Slowdown`. No `agent_interactions` resolution/control/motive triple.

---

## 5. CoT order (medoid)

1. Use stamps ⊆ `action.yaml` / context action lines; tag phase with behind-bin gate (§9G).  
2. Copy Labeller longitudinal + lateral; quote v / a / Δheading; name toward agent.  
3. Set `named_vehicle_interaction` from geometry + control arc vs named vehicle only.  
4. Write phase paragraphs.  
5. Stop. Do **not** assign paper cluster labels here.

---

## 6. Cluster summary + label-review handoff

| Medoid | Downstream |
| --- | --- |
| timeline + phases + `named_vehicle_interaction` | summary invents paper `label` from §3 menu |
| same structured fields in caption / review pack | label-review must see interaction + phase evidence, not label+caption only |

Also migrate: pair contrast, selection-eval, cross-eval, ODD briefing, dashboard chips, shared `common_sense` (§9F).

---

## 7. Delete from medoid authoring

- Paper cluster labels as stamp/row “motives”  
- `control_response` + long project motive codebook  
- Agent-row resolution/control/motive triple as the main product  
- Invented 8-cell names like `high_speed_zero_accel`  
- LLM inventing Labeller kinematics (`keep_velocity` / `hard_brake` without EMERGENCY)

## Keep

- Time sections with behind-bin phase gate  
- Longitudinal ⊕ lateral **from Labeller** (+ numbers)  
- Thin `named_vehicle_interaction`  
- Paper cluster label menu **only** on cluster summary  

---

## 8. Implementation order (when §9–10 accepted)

1. Python: map `action.yaml` → stamp long/lat; define phase gate from `pass_state`.  
2. Rewrite medoid prompt: phases + narrative + thin interaction; ban paper labels + motive triple.  
3. Stage adapters or migrate: pairs, summary, label-review inputs, evals, dashboard, `common_sense`.  
4. Re-run medoids → summary labels → label-review on one paper batch before full rollout.

---

## 9. Critical review vs real pipeline (self-check)

Plan v5 is **not** ready to implement as written. Issues found by reading
`app/analyzer/README.md`, `app/llm_pipeline/README.md`, `action.yaml`, and
`labeller`/`taxonomy` — not by waiting for review.

### Mistake A — LLM would re-invent what Labeller already owns

Analyzer Path A:

```text
esmini CSV → labeller → action.yaml  [single source of truth]
  → conflict_frame_selector (timestamps ⊆ action.yaml only)
  → BEV + context_medoid.md
```

Hard rule in analyzer README: **do not invent kinematic labels Labeller never
emitted.** `EMERGENCY_BRAKE` only when mean accel ≤ −4 m/s².

v5 asks the LLM to author `longitudinal: accelerate|decelerate|hard_brake|…`
from context. That **duplicates** `action.yaml` and can disagree with it (e.g.
LLM says `hard_brake` when Labeller only emitted `DECELERATE`). That violates
the Path A contract.

**Fix direction:** stamp longitudinal/lateral codes should be **copied or
mapped from `action.yaml` in Python** (or quoted from context lines that already
come from Labeller). LLM writes interpretation (toward whom, phase story), not
a second kinematics classifier.

### Mistake B — `brake_release` is not a Hartjen vehicle-state

Hartjen Layer 1 is Accelerate / KeepVelocity / Decelerate / ….  
`brake_release` is a **project interaction event** (end of decelerate while
still near conflict). Putting it in the same enum as `accelerate` mixes layers
and breaks the “refer literature, don’t invent” claim.

**Fix:** longitudinal = Labeller actions only. `brake_release` stays a rare
**interpretation** note in description, or a separate optional flag — not a
Hartjen code.

### Mistake C — `keep_velocity` often has no Labeller stamp

Labeller emits ACCELERATE / DECELERATE segments; gaps between them are not
always labelled KEEP. Asking the LLM to fill `keep_velocity` invents stamps
where Path A has silence.

**Fix:** only emit longitudinal codes on stamps that exist in `action.yaml` /
context action lines. Between actions: no fake keep stamp, or Python inserts
KEEP if we add that to Labeller later.

### Mistake D — interaction layer (pass/yield) was dropped too hard

Lefèvre: physics ≠ maneuver ≠ interaction.  
Markkula/Sarkar: space-sharing / ROW is not kinematics.

v5 leaves pass vs give-way as “optional / caption.” Then cluster summary must
invent `Late Yield` vs `Smooth Pass` from accel paragraphs alone — weaker than
today’s (flawed) `resolution`, and worse for pair contrast (`separation_call`
needs pass vs yield families).

**Fix:** keep a thin **interaction** field vs named vehicle (`pass_first` |
`yield` | `unresolved`) — geometry + control arc — **separate** from kinematic
stamp codes. Not three overlapping motive fields; one interaction outcome +
Labeller kinematics.

### Mistake E — Hartjen Layer 3 made “optional” but that is the product

Object-related (approach / pass / follow CuttingIn or Parking) is why we run
medoid analysis. Making it optional leaves only ego kinematics, which
`action.yaml` already provides without an LLM.

**Fix:** require “toward agent” + pass_state / clearance quotes on conflict
stamps; that is Layer 3 evidence, not a new invented motive codebook.

### Mistake F — whole LLM product chain ignored

`llm_pipeline/README.md` order: medoid → pairs → summary → label-review →
selection-eval → cross-eval → ODD.

v5 only sketches medoid + summary. Broken if unchanged:

| Downstream | Still expects |
| --- | --- |
| Pair `contrast.yaml` | per-side interaction / motive-like fields from medoid extract |
| Selection-eval `motive_distinctness` | `primary_motive` / row motive |
| Cross-eval / odd briefing | medoid motive fields |
| Dashboard ResultCard / IcPairPanel | resolution / control / motive chips |
| `common_sense.txt` | shared by **all** products — Hartjen-only rewrite without pair/summary updates breaks pairs |

**Fix:** plan must include pair + eval + dashboard + shared `common_sense`
migration, or explicitly stage “medoid-only first” with temporary adapters.

### Mistake G — phase tags are underspecified

`post_pass` needs a definition: first time named vehicle enters behind-bin
(`pass_state` already computed in context). If LLM invents phases without that
gate, Parking decelerate could be mis-tagged or CuttingIn conflict extended.

**Fix:** Python or prompt rule — `conflict` until behind-bin; then `post_pass`
until resume; don’t free-form invent.

### Mistake H — cluster label handoff too weak

Removing structured medoid rollup then asking summary LLM to invent paper
labels from prose-only phases recreates the old failure mode (label drifts from
evidence). Label-review only sees label+caption excerpt — **no** medoid re-read
(`llm_pipeline/README` §4.4). Bad medoid prose → bad labels → weak review.

**Fix:** either (1) keep a small structured medoid interaction outcome for the
named vehicle, or (2) feed phase summary + interaction outcome into summary
**and** strengthen label-review inputs. Do not rely on kinematics-only prose.

### Mistake I — “does not change context metrics” understates work

If stamps must track `action.yaml`, dataset_builder / context sentence formatter
may need to expose Labeller actions more cleanly for mapping — not only prompt
edits.

---

## 10. Revised verdict

| Claim in v5 | Verdict |
| --- | --- |
| Split cluster labels off medoid | **Keep** |
| Time sections as primary medoid story | **Keep** |
| Hartjen long ⊕ lat as stamp taxonomy | **Keep direction**, but codes must come from **Labeller**, not LLM invention |
| Delete resolution/control/motive triple | **Keep delete of control+motive overlap**; **keep thin interaction outcome** |
| LLM authors accelerate/hard_brake/keep_velocity | **Reject** — Path A violation |
| Paper labels only on cluster summary | **Keep** |
| Plan complete for implement | **No** — fix A–I first |

### Corrected target shape (sketch)

```text
action.yaml (Labeller) ──map──► stamp.longitudinal / stamp.lateral   [Python]
context geometry        ──► stamp.toward agent, pass_state quotes   [already in context]
LLM                     ──► description narrative + phase paragraphs
                         + named_vehicle_interaction: pass_first|yield|unresolved
cluster summary         ──► paper label from interaction + phases + outcome
```

Not: LLM re-labelling kinematics. Not: paper labels on medoid. Not: ignore pairs/eval.

