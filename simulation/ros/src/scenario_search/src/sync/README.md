# Synchronize Scenario Search Data Between Local and Remote Machines

This module is implemented for sharing scenario search records between developers via AWS s3 cloud storage.

## Dependency

boto3 is the offial AWS SDK for python to upload/download files, and it has to be installed before running `sync.py`.

```bash
python3 -m pip install -r requirements.txt
```

## Usage

To push data to cloud, just run:
```bash
python3 sync.py --push
```

Similarly, to pull data from cloud, run:
```bash
python3 sync.py --pull
``` 

And pull data with specific condition:
```bash
python3 sync.py --pull --filter scenario_id=itri_03
python3 sync.py --pull --filter sdc_version=63491986c4b3f96792c2e15875d92f926efb10de
```

If multiple conditions are given, AND operation will be applied.

You can use `--list` opetion to see the number of data **at local**.
```
python3 sync.py --list
python3 sync.py --list --filter scenario_id=itri_05
```

The following is the available keys for filter:

| key                  | description                                          | example value                                                                                                                         |
|----------------------|------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------|
| scenario_id          | the id recorded in `single_scenario_config0.json`    | `itri_03`, `itri_05`                                                                                                                  |
| scenario_desriptions | the simulator name in `single_scenario_config0.json` | `itri_03_lane_roadside_moving_simulator`, `itri_05_unsignalized_turning_coming_vehicle_simulator`                                     |
| sdc_version          | the sdc version in `version_details.md`              | `63491986c4b3f96792c2e15875d92f926efb10de`                                                                                            |
| result_headers       | the headers of csv                                   | `#,moving_speed_kph,begin_longitudinal_offset,waypoint_lateral_offset,move_trigger_distance,result_score,result_collide,result_decel` |

## Push

- If you have not run push before, the file `sync_config.json` will be created, which stores the timestamp.
- Everytime the data are pushed, the timestamps update.
- Currently, if we push a folder whose name is already exist on s3, the folder overrides the one on s3.
- Only files specified in `SHARING_FILES` from `push.py` will be pushed. 

## Pull

- If we pull a folder whose name is already exist on local, the program will not pull the folder (skip).
- After data were pulled, each folder got a new file `metadata.json`, which may be useful.
