# Mission Control run artifacts (on-disk layout)

Generated files live under **`simulation/ros/.cache/mission_control/`** on the lab PC (same tree is visible inside `sdc-bionic` as **`/project/mmsl_simulation/.cache/mission_control/`** because `simulation/ros` is bind-mounted).

> **Note:** That path is under `simulation/.gitignore` (`*.cache`). Only this documentation file is committed; run folders are local.

## Layout

```text
simulation/ros/.cache/mission_control/
  runs/
    mc_<8hex>/                    (one folder per Mission Control run_id)
      manifest.json               (batch, scenario, sampling URLs, path hints)
      trial_<N>_params.json       (sampling suggestion for that trial)
      trial_<N>_launch.sh         (generated; sources ROS + roslaunch)
      trial_<N>_roslaunch.log     (stdout/stderr from roslaunch)
```

`runs/` is listed in the repo root `.gitignore` so logs are not committed.

## Related paths

| Location (host, repo-relative) | In container |
|-------------------------------|--------------|
| `simulation/ros/.cache/scenario_search/records/` | `/project/mmsl_simulation/.cache/scenario_search/records/` |
| `simulation/ros/.cache/mission_control/` | `/project/mmsl_simulation/.cache/mission_control/` |

## How this relates to the Dashboard

The browser **does not read these folders directly**. It talks to **HTTP APIs**:

| Data | Typical source for the Dashboard | Folder role |
|------|----------------------------------|-------------|
| Trial metadata, scatter plots, clustering | **Payload** (`3020`) and **Analyzer** (`9010`) | `scenario_search/records/` CSVs are what the pipeline and Mission Control **validator** use on disk; the Explore UI loads processed data via APIs, not raw paths. |
| “Data quality” (CSV count vs Payload) | **Mission Control API** (`8282`) | Server-side code reads `scenario_search/records/` and compares to Payload. |
| Mission Control run logs / `roslaunch` output | **Mission Control panel** (log tail from API) and **disk** under `mission_control/runs/` | Operator debugging; not the same widgets as cluster plots. |

So both directories can be “in use” at the same time: one holds **simulation CSV outputs**, the other **Mission Control run artifacts**. The Dashboard shows **one coherent UI**; different panels call different backends. You do not switch modes—open Batch Explore for analysis and the Mission Control tab for runs.

## Environment

If Sampling is **not** reachable from the container as `http://localhost:9009` (e.g. Docker bridge network instead of `--network host`), set:

```bash
export SAMPLING_API_FOR_CONTAINER=http://<host-ip>:9009
```

before starting Mission Control (`litestar run --port 8282`).

## Debugging “ROS master did not start”

Open the latest `trial_<N>_roslaunch.log` under `runs/<run_id>/`. It contains the real `roslaunch` / `RLException` output.
