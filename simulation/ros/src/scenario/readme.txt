1. The ego-vehicle has different initial positions for different scenarios in different maps, and the default poses are available in /scenario/data/ego_init_pose_config_action.json
2. The configurations for the scenarios are available in /scenario/data/scenario_config_action.json
3. The program will check the map and route files and throw exception if any files are incorrect
   This configuration could also be found in /scenario/data/scenario_config_action.json,
   for example, the following map and route files are correct for scenarios action_01 in taichung_new map:
       "map": "taichung_new",
       "route": "zhongke_right_turn_dapeng_road",
4. Add the topic /scenario_visualization in rviz to show markers or add the following configuration in /src/sdc/data/sdc.rviz
    - Class: rviz/MarkerArray
      Enabled: true
      Marker Topic: /scenario_visualization
      Name: scenario visualization
      Namespaces:
        {}
      Queue Size: 100
      Value: true
5. Choose scenario by the command line argument scenario_id when launch scenario package in step 7.2
6. The valid scenario ids are
    * action
        * action_01
    * Shuinan
        * shuinan_01, shuinan_02, shuinan_03, shuinan_04, shuinan_05, shuinan_06, shuinan_07, shuinan_08, shuinan_09, shuinan_10, shuinan_11, shuinan_12
    * Adas
        * adas_acc_target_discrimination, adas_acc_curve_capability, adas_fvcws_longitudinal_discrimination, adas_lkas_straight_lane_keeping, adas_lcdas_overtaking_subject, adas_lcdas_overtaking_target, adas_lcdas_lateral_moving, adas_lsf_automatic_deceleration, adas_lsf_retargeting_capability

7. Execute the following commands to run, for example, the scenario action_01
    7.1 roslaunch sdc visualization.launch
    7.2 roslaunch scenario scenario.launch scenario_id:=action_01
    7.3 roslaunch sdc run.launch simulation:=true

## To Add a New Scenario under Existed Field
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