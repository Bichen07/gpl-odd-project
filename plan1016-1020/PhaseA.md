# Phase A — trustworthy single-case evidence

**Status:** `complete — local scope accepted` (2026-11-07)
**Requirements:** R05–R10, R24
**Commit:** `29098fa`
**Deferred:** Phase-A A3 perception/control capture; the unrelated remote Payload run.

## Goal

Turn one archived collision case into a traceable engineering-evidence package. The
system may describe observed motion and derived collision facts, but must not claim
that the ADS detected an actor, made a particular decision, is legally responsible,
or is certified safe.

## Delivered

| Output | What it establishes | Current local case |
| --- | --- | --- |
| `action.yaml` | Rule-based actor actions and interaction/collision context. | `CuttingIn` collision is **derived** at 14.64 s. |
| `capability.yaml` | Collision source, kinematics, input status/provenance, capability verdict. | `insufficient_data`; Ego collision speed is **derived** as 2.419 m/s. |
| `visibility.yaml` | Separates detection, FOV/range opportunity, and line-of-sight opportunity. | All are **unavailable**. |
| Capability/visibility endpoints | Read-only retrieval of the Analyzer artifacts. | No analysis or state change occurs. |

### Why visibility is unavailable

- No timestamped sensor or tracker event exists, so `first_detected` cannot be inferred.
- No versioned FOV/range profile is attached, so FOV/range opportunity is unavailable.
- No complete map/occluder geometry is attached, so clear line of sight is unavailable.

This is the intended safe result. A trajectory can show what happened externally; it
cannot prove what the ADS perceived internally.

## Data-status rules

| Status | Meaning | Example in this case |
| --- | --- | --- |
| `recorded` | Directly stored by the producing system. | None for historical perception. |
| `derived` | Recomputed deterministically from identified inputs. | Polygon collision time; collision-speed sample. |
| `configured` | Bound to a run with a captured configuration/hash. | None for this archive. |
| `assumed` | Sourced, versioned sensitivity input; cannot change the main verdict. | RSS/UN-R152 braking sensitivity values. |
| `unavailable` | Not present in inspected evidence. | Detection, response delay, friction, grade, lane feasibility. |

Every later UI, LLM, agent, or paper export must retain these labels, sources,
units, rationales, and hashes.

## What was checked

| Check | Result |
| --- | --- |
| Scenario event recording | `3 passed` — positive timestamps, deduplication, observation mapping. |
| Analyzer capability/visibility/profile tests | `25 passed` — schema, provenance, unavailable handling, profile/geometry boundary, no verdict override. |
| Python compilation | Passed for modified Analyzer modules and archived-card builder. |
| Payload/PostgreSQL integration | Previously passed: Trial → observation-linked event → artifact path/hash round trip. |

Useful artifacts:

- [Capability card](../results/batch8/6_cluster_s=0.5947/cluster1/trial_12152/processed/capability.yaml) — SHA-256 `4c3ea2c4fe4b6c2acf035630a1547a28ad093264d9162d979dc4781a6898e0b5`
- [Visibility evidence](../results/batch8/6_cluster_s=0.5947/cluster1/trial_12152/processed/visibility.yaml) — SHA-256 `6e329a68132f0819ea9ab8189d9a5bc785123dd00170f48d7c764e6f56deda7f`
- [Action evidence](../results/batch8/6_cluster_s=0.5947/cluster1/trial_12152/processed/action.yaml)
- [Rebuild script](../scripts/build_phase_a_archived_card.py)

## User checks

1. Open the capability card: collision must show `derived`; primary verdict must be
   `insufficient_data`; assumptions must remain separate from primary inputs.
2. Open the visibility evidence: all three fields must show `unavailable` with a
   reason; none may say the vehicle detected `CuttingIn`.
3. Run the documented test suite in the implementation plan; expect 3 scenario tests
   and 25 Analyzer tests to pass.

## Explicit exclusions

- The remote Payload `Trial 12152` is a different simulator run. It is excluded,
  not missing evidence. Local artifacts must never be merged into or written to it.
- The failed remote DAT download is only relevant if the team later studies that
  independent remote run.
- Sensor/tracker, planner, control, actuator, road-friction, grade, and legal
  responsibility analysis require future recorded evidence and remain unavailable.

## Handoff to Phase B

Phase B may use `action.yaml`, `capability.yaml`, and `visibility.yaml` to create
actor-local Replayer labels and an Evidence Drawer. It must:

- show action/collision labels only when a structured interval supports them;
- show `derived`, `assumed`, or `unavailable` beside relevant evidence;
- never render “detected,” causal blame, legal responsibility, certification, or an
  avoidability conclusion from these archived artifacts.

Phase B is now permitted. Its detailed work/checklist is in
[PhaseB.md](PhaseB.md); Phase C remains blocked until Phase B is implemented,
verified, committed, and accepted.
