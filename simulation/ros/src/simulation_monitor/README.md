# simulation_monitor

## Modules

### Navigation Path Runner [under scenario package]
#### Description
* Run map/src/map_navigation_path.cpp as an independant module.
* Holds a service server to look up road_type and route information by passing an ego_pose (geometry_msgs/Pose2D) request.
    * Check road type from waypoint. 
    * Subscribed from topic navigation_path, forms nearby forward path and nearby opposite path.
    * Subscribed from topic waypoints, forms nearby waypoints.

### Accident Identify Node
#### Description
* Take simulation_msgs/CollisionProfile.msg for input and identify accident type.

##### File Structure
* accident_identify
    * accident_type
        * \_\_init\_\_.py
        * nlia_forward_accident.py
        * accident_base.py
    * \_\_init\_\_.py
    * accident_identify_node.py

#### Connections
##### Services
###### Server 
* simulation_monitor/identify_accident [simulation_monitor/IdentifyAccident.srv]
    * request: [simulation_msgs/CollisionProfile.msg]
    * response: 
        * string brief
        * list of [simulation_monitor/AccidentTypeMatchingResult.msg]
            * which is sorted from most responsibility to least responsibility if there are multiple possibily matched accident types matched.

#### Usage
##### As a rosservice
* $ rosrun simulation_monitor nila_accident_identify_node.py


### Accident Recorder(ARcd)

#### Description
* ARcd holds messages from topics listed in [sumo_cosimulation]/config/recorded_data.json for a certain time horizon by a deque and do popleft if the left-most message is older than this time horizon. 
* If a collision is detected at t_0, ARcd will stop popping messages and keep waiting until there is no further collision detected for 5 seconds after last detecting contact at t_1. [t_0, t_1] time horizon is the contact time between ego and opponent agent.  At time (t_1+5), ARcd start a writer thread to write messages from time (t_0-10) to (t_1+5) to a new rosbag with name collision_run-id-[run_id]\_seq-[# Accident]-horizon_[t_1-t_0].bag.
* ARcd runs a finite state machine with following states:
    0. NOTHING: Starts with this state, only state 5 can transit to this state.  Only in this state, message recorder will keep removing messages that are older than certain time horizon (10 seconds for now).
    1. FIRST_COLLIDE: Transits from state 0 after detecting a new collision.  It will transit to state 2 immediately.
    2. STILL_COLLIDE: Transits from either state 1 or state 3. This state lasts for 1 second after last detected collision.  ( A collision may lasts more than 1 timestep. )  If collision is not detected for 1 whole second, transits to state 3.
    3. AFTER_COLLIDE: Transits from state 2.  ARcd will hold in this state for 4 seconds before transitting to state 4 if no further collision is detected.  If another collision is detected during this state, transits to state 2.
    4. SAVING_RECORDS: Transits from state 3.   This state is held when bag file writer (from a new thread) starts to copy meta data about time range to write into a bag file. Note that this is the only state that DO NOT detect any collision.  After done copying meta data, transits to state 5.
    5. KEEP_EYE_ON_NEW_COLLIDE: Transits from state 4.  This state is the state when the writer thread start copying recorded messages and writing into a new bag file. In this state, collision detection is enabled again.  f new collision is detected, transit to state 1 no matter if the thread is done writing file or not.  If the thread is done writing messages to the bag file and no further collision detected during this time horizon, transits to state 0.


#### Connections
##### Params
* `timeStep`
* `/accident_recorder/topics`: [string] Where to find topic list that includes topics that have to be recorded in bag.
    * For requirement of the file, please refer to [simulation_monitor]/config/recorded_data.json
* `accident_recorder/save_path`: [string] Where to save accident data.
* `accodent_recorder/enable`: [dict] Whether to enable the three items to be recorded.
    * `info`: [bool] Accident log like CollisionProfile or AccidentTypeMatchingResult (NLIA not fully implemented yet).
    * `image`: [bool] Accident image for trajectories of ego and agents before collision.
    * `bag`: [bool] Accident full record before collision. Recorded topics was listed in another param `/accident_recorder/topics`.


##### Topics
###### Subscriptions
* simulation/collision_profile [simulation_msgs/CollisionProfile.msg]
    * Collision engine uses either Box2D or overlapping model.
        * For Box2D, this topic is published by simulation/customized_box2d.cpp
        * For overlapping model, it is not implemented yet.

##### Services
###### Server
* simulation/request_accident_overview [sumo_cosimulation/RequestAccidentOverview.srv]



### AutoRestartHandler

#### Description
* Wait for 10 second after reaching DestinationWaypoints or DestinationGlobalPath, then call the service to reload route by route_id.

#### Connections
##### Topics
###### Subscriptions
* behavior_state [itri_msgs/BehaviorState]

##### Services
###### Client
* route_mission_handler/load_route_by_id [route_mission_handler/LoadRouteByIdSrv]




