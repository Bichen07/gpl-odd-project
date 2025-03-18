from collections import OrderedDict

import numpy as np
import rospy
from geometry_msgs.msg import Pose, Point, Quaternion
from rss_msgs.msg import CheckResult, CheckResultObjectState
from itri_msgs.msg import DetectedObject, DetectedObjectArray

from vehicle_data import VehicleData

class EgoData(VehicleData):
    def __init__(self):
        super(EgoData, self).__init__()

    def append(self, t, car_state):
        super(EgoData, self).append(t, car_state.pose.pose)

    def check_distance(self, t, pose):
        ego_pose = self.find(t)
        return (
            (ego_pose.position.x - pose.position.x) ** 2 + 
            (ego_pose.position.y - pose.position.y) ** 2
        ) ** 0.5

class AgentDataHandler():
    def __init__(self, object_id_filter):
        self.agents = {}
        self.object_id_filter = object_id_filter

    def add_agent(self, detected_object_id):
        self.agents[detected_object_id] = AgentData(detected_object_id)

    def append_detected_objects(self, t, detected_object_array):
        for obj in detected_object_array.objects:
            if not self.object_id_filter(obj.id): continue
            if not obj.id in self.agents.keys():
                self.add_agent(obj.id)
            self.agents[obj.id].append(t, obj)

    def append_rss_check_result(self, t, rss_check_result):
        for state in rss_check_result.object_states:
            if not self.object_id_filter(state.detected_object_id): continue
            if not state.detected_object_id in self.agents.keys():
                self.add_agent(state.detected_object_id)
            self.agents[state.detected_object_id].append_rss(t, state)

    def run_rss_matching(self):
        for agent in self.agents.values():
            agent.run_rss_matching()

    def get_agent(self):
        for _id, agent in self.agents.items():
            yield _id, agent


class AgentData(VehicleData):
    def __init__(self, detected_object_id):
        super(AgentData, self).__init__()
        self.id = detected_object_id
        self.timed_rss_data = OrderedDict()
        self.rss_result = []

    def append(self, t, obj):
        assert not self.done
        super(AgentData, self).append(t, obj.pose)

    def append_rss(self, t, checkResultObjectState):
        assert not self.done
        self.timed_rss_data[t.to_sec()] = checkResultObjectState

    def run_rss_matching(self):
        # assert self.done
        for t, state in self.timed_rss_data.items():
            is_structured = state.situation_type != 6
            if is_structured:
                safety_status = state.structured_safety.status
            else:
                safety_status = state.unstructured_safety.status
            pose = self.find(t)
            self.rss_result.append({
                "t": t,
                "is_structured": is_structured,
                "status": safety_status,
                "pose": pose,
                "distance": self.get_distance(t),
                "x": abs(pose.position.x),
                "y": abs(pose.position.y),
            })

    def get_size(self):
        return len(self.rss_result)

    def get_rss_result(self):
        return self.rss_result

    def get_distance(self, t):
        pose = self.find(t)
        return (pose.position.x ** 2 + pose.position.y ** 2) ** 0.5
