# Scenario Search

## Single Parameterized Scenario Search

### Environment
* sdc-docker: 1f7ef4816420858f2648bb4c27d99a88f14c6aa8
* sdc: 589b97f88299435258ffc617aa0c9006eafcea3e
* simulation: 3eee85ac2172923dba48cbffbf028a840bc63a35

Run Single Parameterized Scenario Search
#### Configure
1. Choose a search iterator in scenario_search/single_parameterized_scenario_search.py
	* Currently, random search iterator and grid search iterator are supported.
	* Both iterator have been imported to single_parameterized_scenario_search.py
	* Assign one of them to the global variable SearchingIterator
2. Configure scenario search range, see [Configurations](#configurations) for more.
#### Through launch file
1. roslaunch scenario_search single_parameterized_scenario_search.launch
2. roslaunch sdc run.launch simulation:=true
#### Launch saparately
1. roslaunch simulation_adv run.launch
	* use_sim_time: false
	* by_tick: false
	* gbus: false
	* publish_scenario_visualization: false
	* velocity_in_ego_coord: false
	* detected_objects_topic: detected_objects
	* ego_position_seq: 3
	* run_once: true
	* disable_monitor: false
2. roslaunch scenario scenario_updater.launch
	* use_sim_time: false
	* enable_rss_check: false
	* scenario_id: itri_02
	* route_id: III_itri
	* config_file: scenario_config_itri.json
	* agent_size: carla_agent_size.json
	* ego_init_pose_config_file: ego_init_pose_config_itri.json
3. rosrun scenario_search single_parameterized_scenario_search.py
4. roslaunch sdc run.launch simulation:=true

### Details
#### Configurations
* Example
```json
"itri_03": {
        "vehicle": "pacifica",
        "route": "III_itri",
        "fileName": "operation",
        "default_pose_seq": 4,
        "default_pose_alias": "itri_03",
        "end_condition_and": {
            "after_frenet_s": 220.0,
            "after_agents_stopped": true
        },
        "grid_search": {
            "lane_roadside_moving_model": {
                "time_step": 0.01,
                "visualization_time_step": 0.01,
                "motion_configs": [
                    {
                        "begin_lateral_offset": [-3.2, -1.6, -1.0],
                        "begin_lateral_speed_kph": [1.6, 4.8, 2.4, 0.8],
                        "move_trigger_distance": [8.0, 12.0, 16.0, 20.0]
                    }
                ]
            }
        },
        "random_search": {
            "total_iters": 2048,
            "lane_roadside_moving_model": {
                "time_step": 0.01,
                "visualization_time_step": 0.01,
                "motion_configs": [
                    {
                        "begin_lateral_offset": [-0.8, -6.0],
                        "begin_lateral_speed_kph": [1.0, .0],
                        "move_trigger_distance": [6.0, 20.0]
                    }
                ]
            }
        }
    }
```
* motion_configs
	* Replace value with list "[]" to assign the searching config.
	* NOTE THAT the multi-layer config type in e.g. adaptive_overtaking_model might cause error. (To be solved.)
	* For random search, extra field "total_iters" needs to be assigned.
* End Conditions
	* end_condition_and
		* End condition met when all conditions must be satisfied
	* end_condition_or
		* End condition met when one of the condition is satisfied
	* Available conditions (More to be implemented)
		* after_frenet_s: After ego reach certain s pose on frenet
		* after_agents_stopped: After all agents have no speed.
