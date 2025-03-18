#!/usr/bin/env python
import copy
from collections import deque, defaultdict
import time 
from timeit import default_timer as tmr
import threading

import numpy as np
import rospy
from rosgraph_msgs.msg import Clock
from geometry_msgs.msg import Pose, Vector3, Twist
from visualization_msgs.msg import Marker, MarkerArray
from std_msgs.msg import ColorRGBA, Header
from simulation_msgs.msg import AgentPose2DArray
from simulation_srvs.srv import SimulationCreateAgent, SimulationDeleteAgent, SimulationUpdateAgents
from route_mission_handler.srv import LoadRouteByIdSrv
from itri_msgs.msg import CarState, DetectedObjectArray, BehaviorState
from simulation_msgs.msg import CollisionProfile
from . import utils


class MmslSimulation:

    def __init__(self, sumo_dt=0.05):

        self.header_sequence = 0
        self.dt = rospy.get_param("timeStep", 0.01)
        self.sim_control = rospy.get_param("simulation_control", defaultdict(lambda: 0.0))
        self.sim_time = rospy.get_param("simulation_control/timing", defaultdict(lambda: 0.0))
        
        self.ReloadRouteSrv = rospy.ServiceProxy("route_mission_handler/load_route_by_id", LoadRouteByIdSrv)
        self.CreateAgentSrv = rospy.ServiceProxy("simulation/agent/create_service", SimulationCreateAgent)
        self.DeleteAgentSrv = rospy.ServiceProxy("simulation/agent/delete_service", SimulationDeleteAgent)
        self.UpdateAgentsSrv = rospy.ServiceProxy("simulation/agent/update_service", SimulationUpdateAgents)

        rospy.Subscriber("car_state", CarState, self.car_state_callback)
        rospy.Subscriber("detected_objects", DetectedObjectArray, self.detected_objects_callback)
        rospy.Subscriber("simulation/collision_profile", CollisionProfile, self.collision_callback)
        rospy.Subscriber("behavior_state", BehaviorState, self.behavior_state_callback)
        rospy.Subscriber("simulation/agent_pose2d", AgentPose2DArray, self.agent_pose2d_array_callback)
        self.scenario_visualization_publisher = rospy.Publisher("scenario_visualization", MarkerArray, queue_size=1)
        self.agent_id_publisher = rospy.Publisher("agent_marker", MarkerArray, queue_size=1)
        self.clock_publisher = rospy.Publisher("/clock", Clock, queue_size=1)  # for behavior time control

        self.ego_state_queue = deque(maxlen=1)
        self.ego_history_queue = deque(maxlen=1.0/self.dt*10.0)
        self.last_ego_state = CarState()
        self.agent_dict = {}
        self.sumo_dt = sumo_dt
        self.marker_id_count = 0
        self.ego_height = None
        self.ego_longitudinal_offset = -2. #rospy.get_param("")
        # ndt2veh: base_link_to_center: -1.0

        # For service execution thread
        self.kill_sig = False
        self.service_queue = deque()
        self.service_processing_thread = threading.Thread(target=self.process_service_demand)
        self.service_processing_thread.start()

        # Dict to record contacted agent from sumo. 
        self.contacted_agents = {}
        self.agents_to_remove = []
        self.agents_removed = []

        # To record agents from ROS to sumo
        self.ros_agents_deque = deque(maxlen=1)
        self.ros_agent_ids = set()

        # Behavior state monitoring
        self.behavior_state = {"last": None, "timestamp": None}

        # For CoSimulationOverview
        self.simulation_infromation = {
            "is_new_round": False
        }

        self.close_enough_distance = rospy.get_param("simulation/detected_objects_range", 5000)

        self.check_service()

    def process_service_demand(self):
        """
        An extra thread was created to request agent-related service since in synchronous.
        Reason:
            Simulation module iterates with ros rate, ros clock is published by MmslSimulation.tick
            which is called by SimulationSynchronization.RunOnce, SimulationSynchronization.RunOnce 
            also calls MmslSimulation for services to manipulate agents, 
            which is blocked by simulation module.

            SimulationSynchronization.RunOnce
                --> do MmslSimulation.tick to publish ros time
                --> Request Service with MmslSimulation's ServiceProxy
                    --> Service blocked by simulation module
                    --> Simulation requires ros time running to iterate with ros rate.

        """

        last_update = tmr()

        while not rospy.is_shutdown():

            if tmr() - last_update < 0.02:
                time.sleep(self.dt)

            if self.kill_sig:
                return

            while self.service_queue:
                service, demands = self.service_queue.popleft()
                try:
                    service(*demands)
                except rospy.service.ServiceException as e:
                    rospy.logwarn("{} - {} service failed with demands {}"\
                        "".format(e, service.__dict__["service_class"].__dict__["_type"], demand))

                last_update = tmr()

    def check_service(self):
        try:
            rospy.wait_for_service("simulation/agent/create_service", timeout=0.001)
            rospy.wait_for_service("simulation/agent/delete_service", timeout=0.001)
            rospy.wait_for_service("simulation/agent/update_service", timeout=0.001)
            return True
        except rospy.exceptions.ROSException as e:
            rospy.logwarn(e)
            return False

    def tick(self, t):
        """
        MmslSimulatino.tick publishes a msg to /clock
        """
        self.clock_publisher.publish(t)
        agents_to_remove_cp = copy.deepcopy(self.agents_to_remove)
        self.destroy_actors(agents_to_remove_cp)
        self.agents_to_remove = []

        mmsl_information = copy.deepcopy(self.simulation_infromation)
        self.simulation_infromation["is_new_round"] = False
        return agents_to_remove_cp, mmsl_information

    @staticmethod
    def _agent_init_state():
        state = CarState()
        state.pose.pose.position.x = 300
        state.pose.pose.position.y = 300
        return state

    def close_enough(self, state1, state2):
        def _square_distance(state1, state2):
            x1, y1 = state1.pose.pose.position.x, state1.pose.pose.position.y
            x2, y2 = state2.pose.pose.position.x, state2.pose.pose.position.y
            return (x1-x2)**2 + (y1-y2)**2
        return _square_distance(state1, state2) < self.close_enough_distance ** 2.

    def spawn_actor(self, actor_id, pose, size, object_class_id, color):
        if actor_id not in self.agent_dict.keys():
            carState = CarState()
            carState.pose.pose = copy.deepcopy(pose)
            if self.ego_height:
                carState.pose.pose.position.z = self.ego_height
            self.agent_dict[actor_id] = {
                "marker_id": self.marker_id_count,
                "state": carState,
                "size": size,
                "class": object_class_id,
                "color": color,
                "marker": self.make_marker(actor_id, self.marker_id_count, size, color),
                "spawned": False,
                "is_updating": False
            }
            self.marker_id_count += 1

        if self.close_enough(self.last_ego_state, carState):
            self._spawn_actor(actor_id)

    def _spawn_actor(self, actor_id):
        #, pose, size, object_class_id, color):
        object_class_id = self.agent_dict[actor_id]["class"]
        pose = self.agent_dict[actor_id]["state"].pose.pose
        size = self.agent_dict[actor_id]["size"]
        color = self.agent_dict[actor_id]["color"]
        demands = (actor_id, object_class_id, pose, size, color)
        self.agent_dict[actor_id]["marker"].action = 0
        self.agent_dict[actor_id]["is_updating"] = True
        self.agent_dict[actor_id]["spawned"] = True
        self.service_queue.append((self.CreateAgentSrv, demands))

    def update_vehicles(self, actor_ids, car_states):

        actors_to_update = []
        states_to_update = []

        for i, (id_, state) in enumerate(zip(actor_ids, car_states)):
            if id_ in self.ros_agents_deque or "ego" in id_:
                continue
            agent = self.agent_dict[id_]

            if self.close_enough(self.last_ego_state, state):

                if not agent["is_updating"]:
                    self.agent_dict[id_]["marker"].action = 0
                    self.agent_dict[id_]["is_updating"] = True

                if not agent["spawned"]:
                    self._update_actor_pose(id_, state)
                    self._spawn_actor(id_)
                else:
                    actors_to_update.append(id_)
                    states_to_update.append(self._update_actor_pose(id_, state))

            else:
                if agent["is_updating"]:
                    self.agent_dict[id_]["marker"].action = 2
                    self.agent_dict[id_]["is_updating"] = False
                    self._update_actor_pose(id_, self._agent_init_state())
                    actors_to_update.append(id_)
                    states_to_update.append(self.agent_dict[id_]["state"])

        demands = (actors_to_update, states_to_update, False, False, 0.1)
        self.service_queue.append((self.UpdateAgentsSrv, demands))
        # rospy.loginfo("Update agent {}: {}".format(actor_ids, response.isSuccess))

    def _update_actor_pose(self, actor_id, actor_state):
        assert actor_id in self.agent_dict.keys(), "id {} must be contained in {}"\
            "".format(actor_id, self.agent_dict.keys())

        if self.ego_height:
            actor_state.pose.pose.position.z = self.ego_height

        last_twist = self.agent_dict[actor_id]["state"].twist.twist
        last_pose = self.agent_dict[actor_id]["state"].pose.pose
        curr_pose = actor_state.pose.pose

        last_yaw = last_pose.orientation.z

        twist = Twist()
        twist.linear.x = (curr_pose.position.x-last_pose.position.x)/self.sumo_dt
        twist.linear.y = (curr_pose.position.y-last_pose.position.y)/self.sumo_dt
        twist.linear.z = 0.0

        # kph = (twist.linear.x**2+twist.linear.y**2)**0.5 * 3.6
        # rospy.loginfo("actor {}, vx: {}, vy: {}, kph: {}".format(actor_id, twist.linear.x, twist.linear.y, kph))

        heading = np.arctan2(twist.linear.y, twist.linear.x)

        
        if last_yaw - heading > np.pi:    # e.g. 359 deg ->   1 deg
            heading += 2 * np.pi
        elif heading - last_yaw > np.pi:  # e.g.   1 deg -> 359 deg
            heading -= 2 * np.pi
        else:
            if heading > 2 * np.pi: heading -= 2 * np.pi
            elif heading < 0: heading += 2 * np.pi

        heading = actor_state.pose.pose.orientation.z
        actor_state.pose.pose.orientation.z = heading
        actor_state.pose.pose.orientation.x = \
            actor_state.pose.pose.orientation.y = \
            actor_state.pose.pose.orientation.w = 0
        twist.angular.z = (last_yaw - heading) / self.sumo_dt
        actor_state.twist.twist = copy.deepcopy(twist)
        self.agent_dict[actor_id]["state"] = actor_state
        return actor_state

    def get_ego(self):

        # return CarState()

        if not len(self.ego_state_queue):
            dummyData = CarState()
            dummyData.pose.pose.position.z = 1000
            return dummyData
        else:
            return self.ego_state_queue.pop()

    def get_actors(self):
        if not self.ros_agents_deque:
            return None, None, None
        agent_states = self.ros_agents_deque[-1]
        agent_ids = agent_states.keys()

        agent_ids_to_spawn = set(agent_ids) - self.ros_agent_ids
        agent_ids_to_update = set(agent_ids) & self.ros_agent_ids
        agent_ids_to_remove = self.ros_agent_ids - set(agent_ids)

        agent_to_spawn = {"type_ids": [], "agent_ids": [], "car_states": []}
        agent_to_update = {"agent_ids": [], "car_states": []}

        for agent_id, car_state in agent_states.items():
            if agent_id in agent_ids_to_spawn:
                agent_to_spawn["type_ids"].append("vehicle.chrysler.pacifica")
                agent_to_spawn["agent_ids"].append(agent_id)
                agent_to_spawn["car_states"].append(car_state)
            elif agent_id in agent_ids_to_update:
                agent_to_update["agent_ids"].append(agent_id)
                agent_to_update["car_states"].append(car_state)

        self.ros_agent_ids = self.ros_agent_ids.union(agent_ids_to_spawn)
        self.ros_agent_ids = self.ros_agent_ids - agent_ids_to_remove
        return agent_to_spawn, agent_to_update, agent_ids_to_remove


    def _add_agent_to_remove_list(self, agent_id):
        if agent_id not in self.agents_removed:
            # will be removed at next tick()
            self.agents_to_remove.append(agent_id)  
            # Prevent from multiple remove that will 
            # crush the program
            self.agents_removed.append(agent_id)  

    def _remove_nearest(self):

        nearest_id = None
        nearest_value = 1e10

        try:
            agent_array = rospy.wait_for_message(
                "simulation/agent_pose2d", 
                AgentPose2DArray, 
                timeout=1.)

            for agent in agent_array.agents:

                if agent.id == "ego": continue

                dist = agent.distance

                if dist < nearest_value or nearest_id is None:
                    nearest_id = agent.id
                    nearest_value = agent.distance


        except rospy.ROSException as e:
            rospy.logwarn_throttle(5, "[MMSL Simulation]"\
                "topic simulation/agent_pose2d "\
                "unavailabel, use agent list instead.")

            for agent_id, info in self.agent_dict.items():
                actor_state = info["state"]
                actor_position = actor_state.pose.pose.position
                ax, ay = actor_position.x, actor_position.y

                if self.last_ego_state:
                    ego_position = self.last_ego_state.pose.pose.position
                ex, ey = ego_position.x, ego_position.y

                dist = ( ex - ax ) ** 2 + ( ey - ay ) ** 2
                if agent_id not in self.agents_removed:
                    if dist < nearest_value:
                        nearest_value = dist
                        nearest_id = agent_id

        rospy.loginfo("[MmslSimulation] Remove nearest agent {}".format(nearest_id))
        self._add_agent_to_remove_list(nearest_id)

    def car_state_callback(self, msg):
        self.ego_height = msg.pose.pose.position.z
        heading = msg.pose.pose.orientation.z
        msg.pose.pose.position.x -= self.ego_longitudinal_offset * np.cos(heading)
        msg.pose.pose.position.y -= self.ego_longitudinal_offset * np.sin(heading)
        self.ego_state_queue.append(msg)
        self.ego_history_queue.append(msg)
        self.last_ego_state = msg
        self.header_sequence += 1

    def detected_objects_callback(self, msg):
        marker_array = MmslSimulation.make_marker_array(
            self.agent_dict, self.header_sequence)
        try:
            self.scenario_visualization_publisher.publish(marker_array)
        except rospy.ROSException as e:
            rospy.logwarn(e)

    def collision_callback(self, msg):
        contact_id = msg.opponent_id
        if contact_id not in self.contacted_agents.keys():
            self.contacted_agents[contact_id] = rospy.Time.now()
        else:
            first_met = self.contacted_agents[contact_id]
            if (rospy.Time.now() - first_met).to_sec() > self.sim_time.get("kill_contact_agent") :
                self._add_agent_to_remove_list(contact_id)

    def _is_stopped(self, sec=-1):  # all
        
        if len(self.ego_history_queue) == 0:
            return True

        history = list(self.ego_history_queue)
        total_length = int(len(history) if sec == -1 else min(len(history), sec*(1.0/self.dt)))

        try:
            for ego in history[-total_length:][::-1]:
                if ego.twist.twist.linear.x > 1e-2 or ego.twist.twist.linear.y > 1e-2:
                    return False
            else:
                return True
        except TypeError as e:
            rospy.logfatal(e)
            rospy.loginfo(len(history))
            rospy.loginfo(total_length)
            rospy.loginfo(sec)
            raise TypeError(e)

    def behavior_state_callback(self, msg):
        if msg.behavior_state != self.behavior_state["last"]:
            self.behavior_state["last"] = msg.behavior_state
            self.behavior_state["timestamp"] = rospy.Time.now()
        else:
            lasting = (rospy.Time.now() - self.behavior_state["timestamp"]).to_sec()
            if msg.behavior_state == 1 and lasting > self.sim_time.get("kill_nearest_agent"):  # AEB
                self._remove_nearest()
                self.behavior_state["timestamp"] += rospy.Duration(self.sim_time.get("kill_next_nearest"))
            if msg.behavior_state == 9 and self._is_stopped(sec=5.) and lasting > self.sim_time.get("kill_nearest_agent") :  # ACC
                self._remove_nearest()
                self.behavior_state["timestamp"] += rospy.Duration(self.sim_time.get("kill_next_nearest"))
            if msg.behavior_state == 17 and lasting > self.sim_time.get("restart_chosen_route_after") :  # DestinationWaypoints
                rospy.loginfo("[MmslSimulation] Reset route_mission_handler")
                self.ReloadRouteSrv(self.sim_control["setting"]["route"])
                self.simulation_infromation["is_new_round"] = True
                self.behavior_state["last"] = None
            if msg.behavior_state == 18 and lasting > self.sim_time.get("restart_chosen_route_after") :  # DestinationGlobalPath
                rospy.loginfo("[MmslSimulation] Reset route_mission_handler")
                self.ReloadRouteSrv(self.sim_control["setting"]["route"])
                self.simulation_infromation["is_new_round"] = True
                self.behavior_state["last"] = None

    def agent_pose2d_array_callback(self, msg):
        agent_states = {}
        for agent in msg.agents:
            if "ego" in agent.id and agent.id != "ego":
                car_state = CarState()
                car_state.pose.pose.position.x = agent.pose2d.x
                car_state.pose.pose.position.y = agent.pose2d.y
                car_state.pose.pose.orientation.z = agent.pose2d.theta
                agent_states[agent.id] = car_state
        self.ros_agents_deque.append(agent_states)

    @staticmethod
    def make_marker(agent_id, marker_id, size, color):
        marker = Marker()
        marker.ns = "sumo_agents"
        marker.id = marker_id
        marker.type = 1
        marker.action = 2
        marker.text = agent_id
        marker.scale = size
        marker.color = color
        marker.lifetime = rospy.Duration(0.5)
        return marker

    @staticmethod
    def make_marker_array(agent_dict, sequence):
        marker_list = []
        timestamp = rospy.Time.now()
        for i, (agent_id, attribute) in enumerate(agent_dict.items()):
            marker = attribute["marker"]
            marker.header = Header(sequence, timestamp, "map")
            marker.pose = copy.deepcopy(attribute["state"].pose.pose)
            orientation = np.rad2deg(attribute["state"].pose.pose.orientation.z)
            orientation = utils.Conversion.euler_to_quaternion(
                utils.Rotation(0., 0., orientation)).get_msg()
            marker.pose.orientation = orientation
            marker_list.append(copy.deepcopy(marker))
        return MarkerArray(marker_list)

    @staticmethod
    def destroy_all_marker(publisher):
        marker = Marker()
        marker.action = 3
        publisher.publish(MarkerArray([marker]))

    def destroy_actors(self, actors=None):
        if actors is None:
            actors = self.agent_dict.keys()
        for actor in actors:
            self.destroy_actor(actor)
            time.sleep(self.dt)

    def destroy_actor(self, actor_id):
        try:
            if actor_id in self.agent_dict.keys():
                marker = self.agent_dict[actor_id]["marker"]
                marker.action = 2
                self.scenario_visualization_publisher.publish(MarkerArray([marker]))
                del self.agent_dict[actor_id]
                
            demands = (actor_id, )
            self.service_queue.append((self.DeleteAgentSrv, demands))

        except Exception as e:
            rospy.logwarn(e)
        # rospy.loginfo("Delete agent {}: {}".format(actor_id, response.isSuccess))

    def destroy(self, actors=None):
        self.kill_sig = True
        rospy.loginfo("[MmslSimulation] Start self destroying.")
        self.destroy_actors(actors)
        self.destroy_all_marker(self.scenario_visualization_publisher)
        rospy.loginfo("[MmslSimulation] Wait for service_processing_thread to join.")
        self.service_processing_thread.join()
        rospy.loginfo("[MmslSimulation] Destroyed.")




