# Scenario

## Usage

### Nodes
#### navigation_path_runner
* Command:
    * rosrun scenario navigation_path_runner_node
* Usage:
    * Run map/src/map_navigation_path.cpp as an independant module.
    * Holds a service server to look up road_type and route information by passing a ego_pose (geometry_msgs/Pose2D) request.
        * Check road type from waypoint.
            * 0: Unknown
            * 1: Straight Route (curvature < 0.25)
            * 2: Curve ROute (curvature >= 0.25)
            * 3: Intersection
        * Subscribed from topic navigation_path, forms nearby forward path and nearby opposite path.
        * Subscribed from topic waypoints, forms nearby waypoints.
* Required rosparams
    * route_mission_handler/route (e.g. III_itri)
    * route_mission_handler/fileName (e.g. operation)
* Service
    * request_navigation_path (scenario/srv/RequestNavigationPath.srv)
* Subscription
    * /waypoints: to check current waypoints
    * /navigation_path: to locate forward path and opposite path.

#### Offline RSS Visualization
* Usage:
    * rosrun scenario_visualization offline_rss_visualization.py <bag_path> [-s]
        * arguments:
            * position argument "bag": to specify full path of a bag file.
            * "-s", "--label_shaded_area": to label rss status or not.
                * If set to true, font size of is_stuctured label will be smaller.
* Requirements:
    * 3 topics must be included in the rosbag file. The script won't check, please check it manually.
        * /car_status
        * /detected_objects
        * /rss/check_result

### ViL
* [!] For documentation of vehicle-in-the-loop related usage, please refer to [simulation]/ros/src/vil/README.md

### Running scenario with simulation_adv
1. roslaunch simulation_adv run.launch
    * arguments:
        * publish_scenario_visualization: set to false in this usage
        * velocity_in_ego_coord: for release/highway branch of sdc
2. roslaunch scenario scenario_updater.launch
    * Make sure `scenario_id`, `route_id`, `config_file`, `ego_init_pose_config_file` are set correctly.  They should be able to found in `scenario/data/`.
3. roslaunch sdc run.launch simulation:=true

### Running scenario with simulation
1. roslaunch simulation simulation.launch
2. roslaunch scenario sil_testing.launch
    * Make sure `scenario_id`, `route_id`, `config_file`, `ego_init_pose_config_file` are set correctly.  They should be able to found in `scenario/data/`.
3. roslaunch sdc run.launch simulation:=true

## Implementation

### To Add a New Field
* It is recommended to copy existed field's setting files and modify it to adapt to a new field. Files that needs to be configured:
    1. **scenario/include/scenario/scenario_[field].json**
    2. scenario/data/ego_init_pose_config_[field].json
    3. scenario/data/scenario_config_[field].json
    4. scenario/include/[field]/[field]\_[scenario_simulator_name].h
    5. scenario/src/[field]/[field]\_[scenario_simulator_name].cpp
* The bold part is the only thing that is different from [To Add a New Scenario under Existed Field](#to-add-a-new-scenario-under-existed-field)

### To Add a New Scenario under Existed Field
1. Add scenario configuration under scenario/data/scenario_config_[field].json
    * "[scenario_id]": "[scenario_simulator_fullname]""
    * "[scenario_simulator_fullname]": {Scenario Definitions}
2. Add ego init pose under scenario/data/ego_init_pose_config_[field].json
    * "[scenario_id]": { "[route_id]": {"position": {"x": [x], 'y":[y]}, "orientaion": [yaw_in_radian] } }
2. Add scenario simulator in
    * scenario/include/[field]/[scenario_simulator_name].h
        * Used unit_model should be included
    * scenario/src/[field]/[scenario_simulator_name].cpp
    * Note
        * Note that [scenario_simulator_name] is not fully equal to [scenario_simulator_fullname]
        * It is recommended to just duplicate another scenario simulator's .h and .cpp files and modify class name and used unit model if there's any differences.
3. Add scenario config in scenario/include/scenario/scenario_[field].h which includes
    * header
    * `static constexpr const char *[scenario_full_name]_id() {return "[scenario_full_name]";}`
    * Add [scenario_id] into `static const std::vector<std::string> [Field]ScenarioIds`
    * Add `{[scenario_full_name]_id(), boost::bind(boost::factory<[field]::[ScenarioSimulatorName] *>())}` into `std::map<IdType, boost::function<Simulator *()>> simulatorRegisterMap`

### Trouble Shooting
* `undefined reference to '[field]::[ScnearioSimulatorName]::[ScnearioSimulatorName]()'`
    * Quick fix: Add `src/[field]/[field]_[scenario_simulator_name].cpp` into `add_library(${PROJECT_NAME} STATIC` in CMakeLists.txt
    * Complete fix: remove build/ and devel/ and rebuild simulation

### To Add a New Unit Simulator

TBI
