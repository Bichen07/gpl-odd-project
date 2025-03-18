# build_and_run_sumo_cosimulation_for_highway_scenario

## 0. Tested on
#### Sep. 27, 2021
* sdc-docker: master commit # 4e935596de934ea64b5601ab247647dd6ee559ac
* sdc: release/highway commit # 8e1c7e46ddd3b3d82002147b9ff20a4bd2c10d4d
* semantic-map: master commit# ebdb10f51d268685831bbcd3224c0bcadcb27ce7
* simulation: commit # c3d103addb5b76311d64ce10b5f9d2274c69d34f
#### Aug. 31, 2021
* sdc: release/highway commit # e7a87581e10066a7f108072a46643686ecc2ecad
* semantic-map: RCS-3054-convert-itri_68_nanliao-mmsl-to-opendrive-format commit # 66eb6c96551c311b6197f3fa98fd7316a7bfa961
* simulation: commit # 3dbba59c30f190b9c67ef5520e4b1ff05fdc63a8

## 1. Build simulation package
1. Mounting simulation volume into the container
    * By adding an extra line to SDC_DOCKER_USER_VOLUMES: `[simulation]/ros:/project/mmsl_simulation:rw`
    * If `[sdc]/ros` is NOT mounted under `/repository/ros` in the container, please modify "OVERLAID_WORKSPACE" in CMakeLists.txt of `simulation` and `simulation_utils` accordingly.
2. `(container) $ source /repository/ros/devel/setup.bash`
3. `(container) $ cd /project/mmsl_simulation/`
4. `(container) $ catkin_make --only-pkg-with-deps sumo_cosimulation`
    * Switch back to build all package if needed later: `(container) $ catkin_make -DCATKIN_WHITELIST_PACKAGES=""`

## 2. Install SUMO
* There is no need to install SUMO after sdc-docker commit # 4e9335
* Export environment variables in the container environment (Run Time)
    * `(container) $ export SUMO_HOME="/path/to/sumo" (default: /usr/share/sumo)`
    * `(container) $ export PYTHONPATH="$SUMO_HOME/tools:$PYTHONPATH"`

## 3. Run predefined sumo scenario
1. Set the correct parameters (route/fileName) in vehicle-configuration/pacifica-1/parameters.yaml
2. Set use_autopilot to false in vehicle-configuration/pacifica-1/parameters.yaml
3. `(container) $ source /project/mmsl_simulation/devel/setup.bash`
4. Export environment variables
5. `(container) $ roscd sumo_cosimualtion/data/itri_68_nanliao`
6. `(container) $ sumo -c off_ramp.sumocfg --remote-port 9000 [--seed <INT>] [--random]`
7. (On terminal 2) `(container) $ source /project/mmsl_simulation/devel/setup.bash`
8. (On terminal 2) Export environment variables
9. (On terminal 2) `(container) $ roslaunch sumo_cosimulation run.launch`
10. (On terminal 3) `(container) $ source /repository/ros/devel/setup.bash`
11. (On terminal 3) `(container) $ roslaunch sdc run.launch simulation:=true`

## Note
### To check if the configuration is working as expected, run SUMO-GUI first
* replace 6. with `(container) $ sumo-gui -c off_ramp.sumocfg --remote-port 9000`
* This is useful to check if the configuration is working as expected without loading the whole self-driving program.
### To monitor the real time factor
* Real time factor (RTF) is the ratio of actual single iteration length of real time to simulation time
* In order to complete every iterations in SUMO. we have to slow down the simulation time so that the calculations can be done.
* Decrease RTF means that behavior module will take more time to load the waypoints.
* To increas the RTF, set less car allowed in .sumocfg file 
* To monitor the RTF, `(container) $ rostopic echo /simulation/real_time_factor`
### Modify traffic volume (either ways work)
* In off_ramp.rou.xml, modify value of period for more or less frequently added new vehicle in SUMO. (preferable)
* In off_ramp.sumocfg, modify value of scale to scale up or scale down total traffic volume.
* In off_ramp.rou.xml, replace period with probability.
### Modify vehicle speed 
* In vehicles.add.xml, modify value of `maxSpeed`. (preferable)
* In off_ramp.rou.xml, add an extra element under `flow` tag: `speedFactor` and set the value to  `norm(mean, dev)` or `normc(mean, dev, min, max)`, e.g. `speedFactor="normc(1,0.1,0.2,2)"`, this will allow random speed for vehicles in the simulation.
* In off_ramp.sumocfg, modify value of the tag `default.speeddev`, this will allow random speed for vehicles in the simulation.
* NOTE: maxSpeed = MIN(speedLimit * speedFactor, vTypeMaxSpeed);
* NOTE: The default value of maxSpeed is 55.55 (m/s) for vehicles.
### Modify car following distance
* In vehicles.add.xml, modify the value of `minGap`.
* Simply adjust the period in off_ramp.rou.xml.
* NOTE: If the speed of all vehicles are nearly the same, it is hard to decrease the nature car gap.  If a test of whether this option works is needed, try increase the value.
* NOTE: The default value of minGap is 2.5 (m).
### Using save and load SUMO state to skip SUMO prerun time (Useful)
* [SaveAndLoad](https://sumo.dlr.de/docs/Simulation/SaveAndLoad.html)
* `$ sumo -c [CONFIG_FILE] --save-state.times TIME1,TIME2,TIME3`
* `$ sumo -c [CONFIG_FILE] --load-state <SAVED_FILE>`
### References 
* [More settings that can applied to `vtype` tag under vehicles.add.xml](https://sumo.dlr.de/docs/Definition_of_Vehicles%2C_Vehicle_Types%2C_and_Routes.html#available_vtype_attributes)