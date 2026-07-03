# NYCU ODD Project Version Details

## Packages
### sdc-docker
* The wheel file was created from commit # e85339c9cefc79b9187c37fa7dc78e5e8320ac96 on master branch.

### sdc
* sdc built from commit # 63491986c4b3f96792c2e15875d92f926efb10de on release/hct branch.
* Build Command
```bash
catkin_make -DCMAKE_BUILD_TYPE=Release install --only-pkg-with-deps behavior behavior_gui exception_handler fake_traffic_light itri_msgs motion_planner ndt2veh object_path_prediction route_mission_handler rrt_planning sdc thirdparty trace waypoint_follower waypoint_follower_mpc web_gui dbw_pacifica_msgs qpoases kalman behaviortree_cpp_v3 steering_functions ifopt diagnostic
```

### simulation
* The whole files were imigrated from commit # 758c230a1da21fb342d10fc63c98d205f9990a49 on feature/RCS-3508-add-a-framework-for-python-cpp-binding-scenario-classification.
* Some packages that seem unlikely to be relevent (e.g. carla related packages) were removed.

### semantic-map
* Imigrated from commit # 33d3f69d65418e55e7a2cff680b1a3428a6ab643 on master branch.
* Only hct, III_itri and taichung_new were used.

## Installation Instruction
* Please refer to the document [doc/installation_instruction.md](doc/installation_instruction.md)