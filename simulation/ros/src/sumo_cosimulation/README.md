# sumo_cosimulation (Common)

## Prerequisition
* To build our own version of SUMO, libfox-1.6-dev needs to be installed for sumo-gui.

## Build SUMO
* Commands
    1. [SUMO_DIR] $ mkdir -p build/cmake-build && cd build/cmake-build
    2. [SUMO_DIR/build/cmake-build] cmake ../..
    3. [SUMO_DIR/build/cmake-build] make -j$(nproc)
* Notes:
    * The binary will be generated at [SUMO_DIR]/bin


## Installation (Deprecated. SUMO is now installed  in sdc-docker)
* Install In docker (Recommended)
    * [via apt](https://sumo.dlr.de/docs/Downloads.php#linux_binaries)
        * $ (docker) $ sudo add-get install software-properties-common 
        * $ (docker) $ sudo add-apt-repository ppa:sumo/stable
        * $ (docker) $ sudo apt-get update
        * $ (docker) $ sudo apt-get install sumo sumo-tools sumo-doc
    * Export environment variables in docker environment (Run Time)
        * (docker) $ export SUMO_HOME="/path/to/sumo" (default: /usr/share/sumo)
        * (docker) $ export PYTHONPATH="$SUMO_HOME/tools:$PYTHONPATH"
* Install On Host
    * [via apt](https://sumo.dlr.de/docs/Downloads.php#linux_binaries)
        * (host) $ sudo add-apt-repository ppa:sumo/stable
        * (host) $ sudo apt-get update
        * (host) $ sudo apt-get install sumo sumo-tools sumo-doc
    * Docker Settings:
        * Add [PATH_TO_SUMO]:/project/sumo:rw to SDC_CONTAINER_VOLUMES in host's .bashrc file
            * (default: /usr/share/sumo)
    * Export environment variables in docker environment (Run Time)
        * (docker) $ export SUMO_HOME="/project/sumo"
        * (docker) $ export PYTHONPATH="$SUMO_HOME/tools:$PYTHONPATH"



## SUMO Configuration
1. .xodr --> .net.xml
    * netconvert --opendrive [MAP_NAME].xodr -o [MAP_NAME].net.xml

2. Add flow file: flows.xml

3. Add taz file: taz.add.xml

4. generate route file
    * duarouter --route-files flows.xml --net-file [MAP_NAME].net.xml --taz-files taz.add.xml --output-file [OUTPUT_NAME].rou.xml

5. Prepare .sumocfg file with above files.

### Run with Carla 

#### NOTE THAT this method causes little pauses from time to time.
##### Tested under
- simulation: #04dbd8de7501b0731b8a774e30ee46c2b7db2ccb
- behavior: #4b076b4c209b33821ab000a7f8cbc38f1c279550

##### Procedure
1. Run Carla:  [CarlaDist/LinuxNoEditor/CarlaUE4/Binaries/Linux/]$ ./CarlaUE4-Linux-Shipping -carla-server
2. Run Cosimulation Code: [CarlaDist/LinuxNoEditor/Co-Simulation/Sumo]$ python2 run_synchronization.py [.sumocfg_file] --sumo-port 9000 --sumo-gui
3. Run carla_simulation_adv: $ roslaunch carla_simulataunch tick:=true
4. Run sdc $ roslaunch sdc run.launch simulation:=true

### Run Sumo-Gui alone
1. sumo-gui -c [CONFIG_FILE].sumocfg

# sumo_cosimulation_adv

## Usage

#### Using save and load SUMO state to skip SUMO prerun time
* [SaveAndLoad](https://sumo.dlr.de/docs/Simulation/SaveAndLoad.html)
* `$ sumo -c [CONFIG_FILE] --save-state.times TIME1,TIME2,TIME3`
* `$ sumo -c [CONFIG_FILE] --load-state <SAVED_FILE>`


#### Run with MMSL SimulationAdv

##### Launch with 1 ego (preferable way)
1. [docker] $ sumo -c [CONFIG_FILE].sumocfg --remote-port 9000
    * e.g. $ sumo -c /project/mmsl_simulation/src/sumo_cosimulation/data/III_itri_v6/final.sumocfg
2. [docker] roslaunch sumo_cosimulation run.launch 
    * argmunets:
        * velocity_in_ego_coord: if set to true, velocity of detected objects will be refer to ego's coordinate.  Also, if set to true, fake_lane_detection/fake_lane_detection will be launched in simulation_adv/run.launch as well.
        * headless: if set to true, RVIZ will not be launched.  Note: RVIZ is launched by rviz_config/visualization.launch rather than sdc/visualization.launch
        * publish_scenario_visualization: whether to publish scenario visualization to /simulation/scenario_visualization
        * sumo_gui: currently not able to use
        * sumo_with_debug_build: currently not able to use
3. [docker] roslaunch sdc run.launch simulation:=true

##### Launch with multi ego (preferable way)
1. [docker] $ sumo -c [CONFIG_FILE].sumocfg --remote-port 9000
    * e.g. $ sumo -c /project/mmsl_simulation/src/sumo_cosimulation/data/III_itri_v6/final.sumocfg
2. [docker] roslaunch sumo_cosimulation sumo_adv.launch use_sim_time:=true sync_by_tick:=true
    * use_sim_time 
        * with this set to True, the script will hold a clock publisher to publish ROS clock.
    * sync_by_tick 
        * use_sim_time must be True
        * options:
            * True: The simulation_adv will run with a service that listen to the request of "/simulation/control/trigger" for every simulation step. The script will wait for the service response before publishing next timestamp.
            * False: The scrpit to sync both side will publish timestamp anyway, hoping that simulation run with ros rate will keep following the speed. NOTE THAT the clock is published in 100hz wall time. The time scale of syncing between SUMO and Mmsl seems not stable. This is not solved yet. (SUMO vehicle seems faster than they should be in RVIZ.)
3. [docker] roslaunch simulation_adv ego.launch __ns:=ego1
4. [docker] roslaunch simulation_adv ego.launch __ns:=ego2 seq:=1
5. [docker] roslaunch sdc run.launch simulation:=true \__ns:=ego1
6. [docker] roslaunch sdc run.launch simulation:=true \__ns:=ego2

##### Launch saperately
1. [host/docker] $ sumo -c [CONFIG_FILE].sumocfg --remote-port 9000
2. [docker] roslaunch sumo_cosimulation sumo_adv.launch
    * which does the following things.
        * [docker] roslaunch sdc visualization.launch \__ns:=ego1
        * [docker] roslaunch simulation_adv run_by_tick.launch
        * [docker] rosrun sumo_cosimulation synchronization_adv.launch 
3. [docker] spawn ego with agentId "ego1/ego"
    * By simulation/SimulationCreateAgentByDefaultPose service. e.g. $ rosservice call /simulation/agent_srv/create_by_default_pose '{"agentId": "ego1/ego", "objectClassId": "", "model": "pacifica", "route": "III_itri", "fileName": "operation", "defaultPoseSequence": 0, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}'
    * By simulation/SimulationCreateAgent service. e.g. $ rosservice call /simulation/agent_srv/create '{"agentId": 'ego1/ego', "objectClassId": '', "pose": {"position": {"x": -109.923, "y": 69.962, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 2.45, "w": 0.0}}, "size": {"x": 5.17, "y": 2.2, "z": 0.0}, "color": {"r": 0.0, "g": 0.0, "b": 0.0, "a": 0.0}, "simWithExternalVehicle": false}'
4. [docker] spawn ego with agentId "ego2/ego"
5. [docker] roslaunch sdc run.launch simulation:=true \__ns:=ego1
6. [docker] roslaunch sdc run.launch simulation:=true \__ns:=ego2

## Notes
#### Sometimes warning  
* '[SumoAdv] Update actor "ego1/ego" failed. (Only critical if keep showing)' will show from time to time, it is because in sumo config, vehicles that collide with others will be removed. If one of the ego was collided with other vehicle, it will be removed from sumo simulation but added back at next tick.

#### To monitor the real time factor
* Real time factor (RTF) is the ratio of actual single iteration length of real time to simulation time
* In order to complete every iterations in SUMO. we have to slow down the simulation time so that the calculations can be done.
* To increas the RTF, set less car allowed in .sumocfg file 
* To monitor the RTF, `$ rostopic echo /simulation/real_time_factor`

---

# sumo_cosimulation (DEPRECATED BELOW)
## Usage
#### Run with MMSL Simulation

1. [host] sumo -c [CONFIG_FILE].sumocfg --remote-port 9000
2. [docker] export SUMO_HOME="/path/to/sumo"
3. [docker] export PYTHONPATH="$SUMO_HOME/tools:$PYTHONPATH"
4. [docker] roslaunch sumo_cosimulation cosim.launch
    * Note
        * Be sure $SUMO_HOME/tools was sourced
        * The above was installing sumo on host and link host:$SUMO_HOME to docker:$SUMO_HOME
    * Arguments
        * use_gdb: For simulation.launch [default: false]
        * headless: Don't launch sdc/visualization.launch if true [default: false]
        * run: Run sdc/run.launch or not [default: true]
    * Explanation:
        1. Load parameters from sumo_cosimulation/config/parameters.yaml
        2. Launch sdc/visualization.launch
        3. Launch simulation/simulation.lacunh
            * with argument publish_detected_objects:=true
        4. Run sumo_cosimulation/simulation_synchronization.py
        5. Run sumo_cosimulation/accident_recorder.py
        6. Launch sdc/run.launch
            * with argument simulation:=true

#### Run on remote server
1. (local) [Set ROS_MASTER_URI according to remote server]
    * $ export ROS_MASTER_URI=http://d400-ProLiant-DL380-Gen10:11311
    * $ alias roslaunch="roslaunch -p 11311"
    * $ alias roscore="roscore -p 11311"
2. (remote) $ roscore
3. (local) [Setup /etc/hosts in docker]
    * 140.96.39.235   d400-ProLiant-DL380-Gen10  # otherwise local node can not see remote master
4. (local) $ roslaunch sdc visualization.launch
5. (remote) [Run sumo with --remote-port 9000 argument]
6. (remote) $ roslaunch sumo_cosimulation cosim.launch
7. (local) $ roslaunch sdc run.launch simulation:=true

#### Run with multiple egos with different namespace (DEPRECATED)
* It's kind of not stable right now, for example, when setting ego on a specific pose with simulation/reset_car_state, the actual box2d object get wrong headings and sometimes even spinning.
* The idea is to run 2 ego vehicles with separated physic engines, run sumo on only ego1, bilaterally passes vehicle informations, both from ego and from sumo to the other.
1. $ roslaunch sdc visualization.launch \__ns:=ego1
2. $ roslaunch sumo_cosimulation cosim.launch disable_collision:=true headless:=true run:=false multisim:=true \__ns:=ego1
3. (in sumo config dir) $ sumo -c sumo_configuration.sumocfg --remote-port 9000
4. $ roslaunch simumlation simulation.launch publish_detected_objects:=true disable_collision:=true \__ns:=ego2
5. $ rosrun simulation multisim_helper.py
    * For some unknown reason, sumo will crash after running this script, just start over again running step 3.
6. (Optional) set ego1 to a proper place using /ego1/simulation/reset_car_state
7. (Optional) set ego2 to a proper place using /ego2/simulation/reset_car_state
8. $ roslaunch sdc run.launch simulation:=true \__ns:=ego1
8. $ roslaunch sdc run.launch simulation:=true \__ns:=ego2

## Notes
* Co-Simulation
    * Synchronous mode was used in MMSL-SUMO Co-Simulation.
    * Real Time Factor can't be assigned for now.
    * Real Time Factor is mostly related to SUMO calculation iteration.
    * The less vehicle allowed at once ( processing -> max-num-vehicles in .sumocfg), the faster SUMO runs.
    * Agents collide with ego near intersection from time to time.
    * If running Sumo with ViL is needed, 
        * the first step is to modify SimulationSynchronization.RunOnce to a service.
        * simulation module should be removed 
        * implement another function to convert scenario_visualization inside MmslSimulation to detected_objects then publish.
        * MmslSimulation.detected_objects_callback should be disabled.
        * Others
* Collision Detection
    * Body contact callback provided by Box2D.
* [Deprecated - Moved to simulation_monitor] Accident Recorder (ARcd)
    * ARcd holds messages from topics listed in [sumo_cosimulation]/config/recorded_data.json for a certain time horizon by a deque and do popleft if the left-most message is older than this time horizon. 
    * If a collision is detected at t_0, ARcd will stop popping messages and keep waiting until there is no further collision detected for 5 seconds after last detecting contact at t_1. [t_0, t_1] time horizon is the contact time between ego and opponent agent. At time (t_1+5), ARcd start a writer thread to write messages form time (t_0-10) to (t_1+5) to a new rosbag with name collision_run-id-[run_id]\_seq-[# Accident]-horizon_[t_1-t_0].bag.
    * ARcd runs a finite state machine with following states:
        0. NOTHING: Starts with this state, only state 5 can transit to this state. Only in this state, message recorder will keep removing messages that are older than certain time horizon (10 seconds for now).
        1. FIRST_COLLIDE: Transits from state 0 after detecting a new collision. Directly transits to state 2.
        2. STILL_COLLIDE: Transits from either state 1 or state 3. This state lasts for 1 second after last detected collision. ( A collision may lasts more than 1 timestep. ) If collision is not detected for 1 whole second, transits to state 3.
        3. AFTER_COLLIDE: Transits from state 2. ARcd will hold in this state for 4 seconds before transitting to state 4 if no further collision is detected. If another collision is detected during this state, transits to state 2.
        4. SAVING_RECORDS: Transits from state 3. This state is held when bag file writer (from a new thread) starts to copy meta data about time range to write into a bag file. Note that this is the only state that DO NOT detect any collision. After done copying meta data, transits to state 5.
        5. KEEP_EYE_ON_NEW_COLLIDE: Transits from state 4. This state is the state when the writer thread start copying recorded messages and writing into a new bag file. In this state, collision detection is enabled again. If new collision is detected, transit to state 1 no matter if the thread is done writing file or not. If the thread is done writing messages to the bag file and no further collision detected during this time horizon, transits to state 0.

## Future Work
### Short-Term
    1. Automatically remove agents that took parts in an accident after n seconds. ( done )
    2. Automatically restart for ego after reaching global destination path. ( done )
    3. Run parallel.
    4. Generate simulation report.
### Long-Term
    1. Classify if ego is responsible for given accidents.

## Bug List
1. Timestep of scenario visualization is a little different from detected objects list since after getting poses of agents from sumo, scenario visualization is first updated, then service of agent update is called, the service call might have some delay.
    * Note:
        * The less sumo dt is, the more distance it shown.
    * Possible Solution:
        * Possible solution 1: don't hold agents' information in simulation module. However, this will disable the collision detection and requires another function to make detected objects list messages. Also, this method best perform with sumo since the visualization msg is actually where the agents are.
        * Possible solution 2: Find out how long the delay time horizon is, use a queue to store positions of each agents, published scenario visualization from the head of the queue. This may be a fast workaround but the agent is actually timesteps behind its real pose in sumo.
2. Vehicle offsets are different between mmsl simulation and sumo, which make agents more easily to collide with ego vehicle.

## Error shooting
* Error: no line intersection ( shown in sumo log )
    * (Possible) Solution: some taz contains a short edge, just make them longer.