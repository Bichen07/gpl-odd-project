#!/usr/bin/env python
import copy
from collections import deque, defaultdict
import time 
import threading
from timeit import default_timer as tmr

import numpy as np
import rospy
from geometry_msgs.msg import Vector3
from rosgraph_msgs.msg import Clock
from scenario_msgs.msg import AgentData, AgentDataArray
from simulation_srvs.srv import SimulationCreateAgent, SimulationDeleteAgent
from simulation_srvs.srv import SimulationUpdateAgents, SimulationUpdateAgentsData
from simulation_adv.srv import Trigger
from itri_msgs.msg import CarState, DetectedObjectArray, BehaviorState
import utils


class MmslAdv:

    NEARBY_RANGE_OVERWRITE = None

    def __init__(
        self, sumo_dt, synchronize_mode, use_sim_time, sync_by_tick):
        rospy.Subscriber(
            "/simulation/agent_data_array",
            AgentDataArray,
            self._agent_callback)
        
        self.trigger_simulation_step = rospy.ServiceProxy(
            "/simulation/control/trigger", Trigger)
        self.agent_delete_proxy = rospy.ServiceProxy(
            "/simulation/agent_srv/delete", 
            SimulationDeleteAgent)
        self.agent_update_proxy = rospy.ServiceProxy(
            "/simulation/agent_srv/update_agent_data", 
            SimulationUpdateAgentsData)

        self._sumo_dt = sumo_dt
        self._synchronize_mode = synchronize_mode
        self._use_sim_time = use_sim_time
        self._sync_by_tick = sync_by_tick

        self._agents = deque([AgentDataArray()], maxlen=1)
        self._external_agents = {}
        self.reset()

        time.sleep(0.2)
    
    def _agent_update_thread_runner(self):

        while not rospy.is_shutdown():
            updated = False
            if self._agents_update_queue:
                agents_to_update = self._agents_update_queue.popleft()
                updated &= self._call_service_wrapper("update", agents_to_update, True, self._sumo_dt)
            if self._agents_delete_queue:
                agent_id = self._agents_delete_queue.popleft()
                updated &= self._call_service_wrapper("delete", agent_id)
            if not updated:
                time.sleep(0.001)


    def reset(self):
        rospy.loginfo("[MmslAdv] Reset.")
        self._destroy_all_sumo_agents()
        self._agents = deque([AgentDataArray()], maxlen=1)
        self._last_incoming = set()
        self._last_updated = set()
        self._updated = set()
        self._egos = {}  # {"id": {"ns": "", "nearby_range": range}}
        self._ego_id_set = set()


    def get_all(self):
        return self._agents[-1], ""

    def get_all_mmsl_id(self):
        return set([aid for aid in self._agents[-1].id_list \
            if not aid.startswith("sumo") and not aid.startswith("carla")])

    def _agent_nearby_one_of_egos(self, external_agents):

        def _is_near(ego, agent):
            if ego.agent_id in self._egos:
                nearby_range = self._egos[ego.agent_id]["nearby_range"]
                return \
                    (agent.pose.position.x - ego.pose.position.x) **2 \
                    + (agent.pose.position.y - ego.pose.position.y) ** 2 \
                    <= nearby_range ** 2
            else:
                rospy.logwarn("[MmslAdv] ego id {} not in self._egos."\
                    "".format(ego.agent_id))
                return False

        n_ego = 0
        agents = copy.deepcopy(self._agents[-1])
        mask = [False for i in range(len(external_agents))]
        for ego in agents.data:  # for AgentData in AgentDataArray
            if "ego" in ego.agent_id:
                n_ego += 1
                for i, agent in enumerate(external_agents):
                    # for AgentData in [AgentData, ]
                    mask[i] = mask[i] or _is_near(ego, agent)
        if n_ego == 0: 
            mask = [True for i in range(len(external_agents))]
        return mask


    def _call_service_wrapper(self, type_, *args, **kwargs):
        timeout = 0.01
        if type_ == "update":
            service = self.agent_update_proxy
            service_name = "/simulation/agent_srv/update_agent_data"
        elif type_ == "delete":
            service = self.agent_delete_proxy
            service_name = "/simulation/agent_srv/delete"
        else:
            raise ValueError, type_

        try:
            rospy.wait_for_service(service_name, timeout=timeout)
            service(*args, **kwargs)
            return True
        except rospy.service.ServiceException as error:
            rospy.logwarn("{} agent failed with error {}."\
                "".format(type_, error))
            return False

    def set_external_actors(self, actors):  # actors: [AgentData, ]
        
        def _calculate_velocity(pose_now, pose_last, dt):
            # return Vector3()
            return Vector3(
                (pose_now.position.x - pose_last.position.x) / dt,
                (pose_now.position.y - pose_last.position.y) / dt,
                (pose_now.position.z - pose_last.position.z) / dt)

        incoming_ids = set()
        agents_to_update = set()
        agent_ids_to_update = set()
        agent_ids_to_delete = set()
        near_ego_mask = self._agent_nearby_one_of_egos(actors)

        for agent, is_near in zip(actors, near_ego_mask):
            agent.agent_id = "sumo_{}".format(agent.agent_id.replace(".", "_"))
            incoming_ids.add(agent.agent_id)

            pose = agent.pose
            if agent.agent_id not in self._external_agents.keys():
                last_velocity = Vector3()
                # velocity = Vector3()
                velocity = agent.linear_velocity
            else:
                # last_pose = self._external_agents[agent.agent_id]["pose"]
                # last_velocity = \
                #     self._external_agents[agent.agent_id]["velocity"]
                # velocity = _calculate_velocity(
                #     pose, last_pose, self._sumo_dt)
                velocity = agent.linear_velocity

                # This is a bug that needs to dig in more,
                # it happens occationally, perhaps 0~5 times in a test run.
                # Here use a temporal solution that drop unreasonable value,
                # should come out with a better way.
                if velocity.x * velocity.x + velocity.y * velocity.y > 9999.:
                    velocity = Vector3()
                    last_velocity = Vector3()

            # coeff = 0.5
            # agent.linear_velocity = Vector3(
            #     velocity.x * coeff + last_velocity.x * (1-coeff),
            #     velocity.y * coeff + last_velocity.y * (1-coeff),
            #     velocity.z * coeff + last_velocity.z * (1-coeff))

            self._external_agents[agent.agent_id] = {
                "pose": pose, "velocity": agent.linear_velocity}

            # Filter out agents that are not near any ego.
            if is_near:
                agents_to_update.add(agent)
                agent_ids_to_update.add(agent.agent_id)
        
        curr_agents = set([
            aid for aid in self._agents[-1].id_list \
                if aid.startswith("sumo")])
        agent_ids_to_delete = curr_agents - agent_ids_to_update

        self._call_service_wrapper(
            "update", 
            agents_to_update, 
            True,   # spawnIfNotExist
            False,  # onlyPose
            False,  # onlyPoint
            self._sumo_dt
        )

        for agent_id in agent_ids_to_delete:
            self._call_service_wrapper("delete", agent_id)
            if agent_id in self._external_agents:
                del self._external_agents[agent_id]
            
    def tick(self):
        if self._sync_by_tick:
            try:
                rospy.wait_for_service("/simulation/control/trigger", timeout=0.01)
                self.trigger_simulation_step()
            except rospy.exceptions.ROSException as e:
                rospy.logwarn(e)

    def destroy(self):
        self._destroy_all_sumo_agents()

    def _destroy_all_sumo_agents(self):
        agents = copy.deepcopy(self._agents[-1])
        rospy.wait_for_service("/simulation/agent_srv/delete", timeout=5)
        for agent in agents.data:
            if agent.agent_id.startswith("sumo"):
                self._call_service_wrapper("delete", agent.agent_id)

    def _agent_callback(self, msg):
        self._agents.append(msg)
        
        agents = copy.deepcopy(self._agents[-1])
        current_ego_set = set()

        for aid, agentData in zip(agents.id_list, agents.data):
            if "ego" in aid:
                current_ego_set.add(aid)
                if not aid in self._ego_id_set:
                    self._ego_id_set.add(aid)
                    self._egos[aid] = {"ns": "", "nearby_range": 50.}
                    if len(aid.split("/")) < 2:
                        self._egos[aid]["ns"] = ""
                    else:
                        self._egos[aid]["ns"] = aid.split("/")[0]
                    nearby_range = rospy.get_param(
                        "/{}/ego_handler/detectRange", 60.) * 1.5
                    self._egos[aid]["nearby_range"] = \
                        self.NEARBY_RANGE_OVERWRITE or nearby_range
                    
        for aid in self._ego_id_set - current_ego_set:
            del self._egos[aid]
            self._ego_id_set.remove(aid)
