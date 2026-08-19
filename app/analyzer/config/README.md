# Analysis clip config

Single source of truth for **analysis-stage** Replayer / LLM timeline start.

File: [`clip_conditions.yaml`](./clip_conditions.yaml)

## Switch profile

Edit `active:` (comment/uncomment):

```yaml
active: current_startvalid
# active: analysis_adjustable
```

| Profile | Drive-out (batch2, 7–9) | batch1 | batch3 |
|---------|-------------------------|--------|--------|
| `current_startvalid` | road 92 / ~(300,58) | ~(-14,7) | ~(535,220) |
| `analysis_adjustable` | **far** ~(420,142) | **far** ~(-2.5,-30) | **far** ~(628,118) |

Batch1/3 never hit road 92 (different routes). Their points live under `batch_overrides`.

## Consumers

- Python: `app/analyzer/src/clip_conditions.py` → `parameter_space_pair_packs.py`, `cluster_aggregates.py`
- Dashboard: `app/dashboard/src/app/api/_lib/clipConditions.ts` → `/api/esmini-trajectory`
- Replayer: `USE_ANALYSIS_CLIP_CSV` toggle in `Replayer/index.tsx`

## Heatmap sync

Baked heatmap PNGs stay on the Payload / `current_startvalid` clock (fixed in
code). Switch only `active` in the YAML — the Heatmap playhead offset is
derived automatically. Reload (or refocus) the dashboard after editing.

## Without re-simulation

1. Change `active` (or edit x/y under `analysis_adjustable` / `batch_overrides`)  
2. Reload dashboard  
3. Open Explore Replayer and check Ego at t=0 (Heatmap playhead should shift with it)  
4. Rebuild LLM packs if you need updated narrative times  

Simulation upload / Payload observations are **not** modified.

## Keep in sync with OpenSCENARIO (Phase D)

When you change the **simulation** StartValidCondition geometry in the `.xosc`, update this YAML (and the matching `batch_overrides`) so analysis and future sims stay aligned.
