# Plan v3: one closed `archetype` field per agent (paper vocabulary), not resolution+control_response+motive

**Status:** proposal — implement only after this file is approved. **Supersedes** the "delete motive, keep only resolution+prose" version of this file — that version overcorrected and is wrong (see §0).  
**Does not change:** clustering, BEV, `context_medoid.md` metrics, Python inventing causes.

---

## 0. Where the previous version of this plan was wrong

Appendix D of the paper (`_IEEE_ITS_2026...txt` lines 1694–1791) says `pass-slowdown` (C6) and `braking-rear-end` (C4) are caused by **the parked vehicle** — a real second agent, matching this project's `Parking`. But the paper still gives the **whole trajectory one archetype name**. It does not split the trial into a CuttingIn row and a Parking row with independent codes. The distinguishing fact between C4 and C6 is **timing**: braking that starts early/gently after the pass (C6) vs abrupt braking right at/after the pass (C4) — the *same* early-vs-late logic the paper already uses for `proactive-yield` vs `late-yield` (C3 vs C4, Case Study 1), just applied to a different reference event (the pass, not the approach).

Previous version of this plan deleted the closed field entirely and pushed everything into free prose + a separate `cluster_summary` re-invention step. That throws away exactly the structure the paper uses to name its own clusters, and makes cluster-summary re-derive from prose what the medoid model already had better evidence to decide. Wrong call — retracted.

---

## 1. The fix: one closed field, paper vocabulary, per agent row

Delete `control_response` (whole field) and the long `motive` codebook (`early_brake`, `late_reaction`, `assertive_gap_acceptance`, `gap_acceptance_creep`, `yield_to_vehicle`, `post_clear_hard_brake`, `post_clear_adjustment`, `post_clear_recovery`, …). Replace with **one field: `archetype`**, using the same vocabulary already reserved for `cluster_summary.label`:

`smooth_pass` · `pass_slowdown` · `brake_rear_end` · `proactive_yield` · `late_yield` · `yield` · `yield_stop_collision` · `cut_in_collision` · `side_collision` · `stationary_collision` · `swerve` · `unclear`

This is not a new vocabulary. It is the paper's cluster-name list, applied one level down (per agent row instead of per whole medoid-implies-cluster). `control_response` and `motive` overlapped because they were two independent guesses at the same fact (`proactive` ≈ `early_brake`, `brake` ≈ `post_clear_hard_brake`, …). One list removes the possibility of disagreeing with itself — there is nothing left to pair against.

### Why this differs from a second copy of `resolution`

It doesn't just re-say pass/yield: it also encodes the **timing decision** (early vs late, gentle vs abrupt) that used to require `control_response` + a pairing table. `resolution` becomes **derived**, not authored:

| `archetype` | derived `resolution` |
| --- | --- |
| `smooth_pass`, `pass_slowdown`, `brake_rear_end` | `pass_first` |
| `proactive_yield`, `late_yield`, `yield`, `yield_stop_collision` | `yield` |
| `cut_in_collision`, `side_collision`, `stationary_collision` | depends on anatomy (pipeline fills from collision ground truth, same as today) |
| `swerve`, `unclear` | `unresolved` (or keep last known pass/yield if the swerve happens on top of one) |

That table lives in **Python**, not as a second LLM opinion. No pairing table in the prompt anymore — there is nothing to keep consistent because only one thing was said.

---

## 2. Structured decision order (replaces the freeform-only motive_summary)

The CoT in `medoid_trial_prompt.txt` must follow this order, per agent row, before writing `archetype`:

1. **Resolve vs the named vehicle** using the existing evidence hierarchy (ground truth → longitudinal relationship/azimuth → speed trend → instantaneous speed). Get pass / yield / collision-during-approach.
2. **If pass:** look for a **post-pass brake phase** — any DECELERATE after that vehicle is in the behind-bin, before the trial ends. If none → `smooth_pass`. If present, classify its **onset timing relative to the pass moment**, same style as step 3:
   - starts soon after the pass, gentle (moderate decelerate, following-distance style) → `pass_slowdown`
   - starts abrupt / at-or-right-after the pass, severe (EMERGENCY_BRAKE or |Δv| ≳ 5 m/s) → `brake_rear_end`
   Quote whatever is on that stamp as the cause (Parking clearance, a boundary note, anything in context) in the timeline description. This does **not** require a separate `agent_interactions` row just to hold the cause.
3. **If yield:** classify the give-way brake's **onset timing relative to the conflict** (same idea as today's `early_brake`/`late_reaction` gate, but now it feeds one label instead of two fields):
   - sustained decelerate begins while still far / TTC high → `proactive_yield`
   - first strong decelerate/EMERGENCY_BRAKE only near peak / TTC low → `late_yield`
   - give-way happened but timing is not a clean early/late story (e.g. low steady creep, or a stop with no useful onset signal) → plain `yield`
4. **If collision:** pick from the collision family using the anatomy paragraph already required (unchanged from today).
5. **If a same-lane turn is the dominant effect** (moderate+ lateral speed) and no clean speed-family code fits → `swerve`.
6. **Only if none of the above fit and evidence genuinely conflicts** → `unclear`.
7. Write the **one** resulting code as that row's `archetype`.
8. **Then** decide whether another agent needs its **own row**: only when that agent has its own materially separate conflict (its own clearance/peak minima, its own near-miss), not merely because it was cited as evidence in step 2/3. Give that row the same 7-step treatment independently, on its own arc.

`brake_release` (started a give-way brake, eased it before the conflict resolved) stays as a **timeline** event, described in prose on the stamp where it happens — it is evidence for how a row ended up `pass_first` (via "brake_release then continued"), not a separate archetype.

---

## 3. Worked examples

**Smooth pass, then Parking-caused slowdown (your original question):**

| Row | archetype | derived resolution |
| --- | --- | --- |
| CuttingIn | `pass_slowdown` (if the post-pass brake is gentle/early) or `brake_rear_end` (if abrupt/late) | `pass_first` |

No separate Parking row is required just to hold this — the timeline stamp says "decelerates moderately at t=…, Parking ahead at clearance … m ⇒ pass_slowdown toward CuttingIn's post-pass phase." Add a Parking row only if Parking's own clearance/near-miss numbers are worth analyzing as their own conflict.

**Case Study 1 style (proactive vs late yield vs collision), one named vehicle:**

| trial | archetype |
| --- | --- |
| brakes early, big gaps | `proactive_yield` |
| brakes late, small gaps | `late_yield` |
| still braking, collides in overlap | `yield_stop_collision` (or `cut_in_collision` if collision happens before any give-way state stabilizes) |

**Multi-agent, genuinely separate conflicts:**

| Row | archetype |
| --- | --- |
| CuttingIn | `late_yield` |
| Parking (own clearance minima, Ego reacts to it independently later) | `proactive_yield` or `smooth_pass`, on its own arc |

---

## 4. YAML after change

```yaml
agent_interactions:
  - agent: CuttingIn
    archetype: smooth_pass | pass_slowdown | brake_rear_end | proactive_yield | late_yield | yield | yield_stop_collision | cut_in_collision | side_collision | stationary_collision | swerve | unclear
  # extra rows only for agents with their own materially separate conflict
decision_timeline:
  - timestamp: <float>
    description: "<lexicon + numbers + toward <agent>; quote cause of any post-pass brake even if that cause is a different agent>"
motive_summary: |
  <explains WHY the archetype was assigned — quotes the timing evidence from step 2/3, not a re-guess>
```

No `control_response`. No `motive` per stamp (the row `archetype` already carries the pattern; `motive_summary` is prose explaining it, not a second code).

---

## 5. Cluster label becomes near-mechanical

`cluster_summary_prompt` reads the named-vehicle row's `archetype`, Title-Cases the same word (`pass_slowdown` → "Pass-Slowdown", `late_yield` → "Late Yield"), and uses that as the default `label`. The reviewer/label-review pass still runs across the whole run to catch two clusters landing on the same archetype (splits them using the two `motive_summary` timing stories) or to note when a cluster's medoid archetype doesn't represent its neighbors well. This is much cheaper than reconstructing a label from prose, and it can't drift from the medoid's own evidence-based decision.

`common_sense.txt`'s existing "Cluster label" closed style set (`Smooth Pass · Pass-Slowdown · Yield · Proactive Yield · Late Yield · Cut-in Collision · Yield-Stop Collision · Brake Rear-end · Side Collision · Stationary Collision`) is kept as-is — it is now literally the same enum as the row `archetype`, just Title-Cased. One vocabulary, two capitalizations, no separate invention step needed in the common case.

---

## 6. Pair contrast (`contrast.yaml`)

Each side gets `archetype` (same enum) instead of `interaction_resolution` + `control_response` + `primary_motive`. `contrast_timeline` / `critical_divergence` unchanged (geometry + speed evidence, not a code).

---

## 7. Implementation order

1. `common_sense.txt` — delete `control_response` block + pairing table + long motive codebook; add the single `archetype` decision tree (§2) with the paper vocabulary; keep `brake_release` as a timeline-only event description.
2. `medoid_trial_prompt.txt` — YAML fence: `archetype` per row, no `control_response`, no per-stamp `motive`; CoT restructured to the 7-step order in §2; examples updated to `pass_slowdown` / `brake_rear_end` etc.
3. Python (`split_analysis.py`): derive `resolution` from `archetype` via the §1 lookup table; strip any leftover `control_response` / old motive keys the model still emits; alias old YAML on read (`early_brake`+behind → `proactive_yield`, `late_reaction`+behind → `late_yield`, `assertive_gap_acceptance`/`maintain_through` → `smooth_pass`, `post_clear_hard_brake` → `brake_rear_end`, `post_clear_adjustment` → `pass_slowdown`, `yield_to_vehicle`/`gap_acceptance_creep` → `yield`, `vehicle_driven_swerve` → `swerve`).
4. `cluster_summary_prompt.txt` — default `label` = Title-Case of named-vehicle `archetype`; keep neighbor/pair verdict logic unchanged; drop "restate primary_motive."
5. Dashboard (`ResultCard.tsx`, `SplitCardsPanel.tsx`, `IcPairPanel.tsx`) — one chip per row: `archetype` (+ derived resolution shown alongside if useful, computed client-side or read from Python output).
6. `cluster_selection_eval.py` / `odd_briefing.py` — read `archetype` (or derived resolution) instead of `primary_motive`.
7. `TAXONOMY.md` — rewrite §3.1–3.3 as one section describing `archetype`; keep the paper-anchor citations (they already map almost 1:1); note the Appendix D correction from §0.

**Out of scope:** re-run all clusters until prompts are signed off. No Python-invented causes — Python only derives `resolution` from the LLM's own `archetype`, and only aliases old codes on read.
