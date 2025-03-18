# Trajectory Analysis

## Description
* The package is aimed to record trajectories of simulation ego and real world ego, save to a json file and analyze the difference between the two trajectories.

## Usage
1. Record Trajectory
    * Simply run scenario_tools/replay.launch with argument `record_traj` set to true
    * This will launch trajectory_analysis/record_traj.py automatically.
    * After the replay is completed, a file name `record-traj-[BAG NAME].json` will be saved under `trajectory_analysis/`
    * Modifiable options:
        * ORIENTATION_TYPE: "yaw" or "orientation"    

2. Trajectory Analysis
    * Prerequisition: [traj-dist](https://github.com/bguillouet/traj-dist)
        * `pip2 install traj-dist`
    * `$ roscd scenario_tools/src/trajectory_analysis/`
    * `$ python evaluate.py`
    * A txt file will be generated that records the result of trajectory analysis.
    * Modifiable options:
        * PRINT_TO_CHECK_DATA: both trajectories will be printed in the terminal
        * data_name: json file include of 2 trajectories and other informations that was generated earlier by record_traj.py
        * distances_criteria: Criteria supported by traj-dist. All criteria listed here will be used in analysis.
        * dimensions: An ordered dictionary that allow user to select features to use in analysis.
        * Criteria related params [(document)](https://github.com/bguillouet/traj-dist/blob/master/traj_dist/distance.py#L422):
            * PARAM_TYPE_D: Available options: ["euclidean", "spherical"]
            * PARAM_EPS: Required by criteria "edr" and "lcss
            * PARMA_G: Required by "erp"
