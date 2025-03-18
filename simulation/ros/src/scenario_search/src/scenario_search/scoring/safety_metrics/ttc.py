import time
from typing import Tuple, Optional
from shapely.ops import nearest_points, split
from shapely.geometry import Polygon, LineString
from pprint import pprint
import math
import rospy
import numpy as np
import pandas as pd
from collections import OrderedDict, deque
from geometry_msgs.msg import Vector3
from scenario_classification.msg import ClassificationObjectArray, ClassificationObject
from itri_msgs.msg import CarState
from scenario_msgs.msg import AgentDataArray, AgentData
from scenario_search.scoring.third_party.TwoDimTTC import TTC, CurrentD
from safety_metric_base import MetricBase
from simulation_utils.converter import QuaternionToVector3
from simulation_msgs.msg import CollisionProfile
from std_msgs.msg import Bool, Float32, Header, Int32, String
from cython_simulation_utils import cy_converter as converter
from scenario.msg import AgentStates, AgentState
from scenario_search.scoring.third_party.TwoDimTTC import getpoints

def predict_position(x, y, v, theta, t):
    return {
        "x": x + v * math.cos(theta) * t,
        "y": y + v * math.sin(theta) * t
    }

def heading_vector_from_yaw(yaw):
    # type: (float) -> Tuple[float ,float]
    x_component = math.cos(yaw)
    y_component = math.sin(yaw)
    return (x_component, y_component)

class TimeToCollisionMetric(MetricBase):
    def __init__(self):
        super(TimeToCollisionMetric, self).__init__()
        self.car_state = CarState()

        self.ttc_queue = deque()
        self.dce_queue = deque() # distance of cloesest encountered
        self.ttce_queue = deque() # distance of cloesest encountered
        self.collision_risk_queue = deque() # distance of cloesest encountered
        self.ttce_add_dce_queue = deque() # distance of cloesest encountered
        self.ttc_1D_queue = deque()

        self.dce_max = 10
        self.ttc_max = 5
        self.ttce_max = 5
        self.collision_profile = None

        self._car_state_subscriber = rospy.Subscriber(
            "/car_state", CarState, self._car_state_callback
        )
        self._agent_states_subscriber = rospy.Subscriber(
            "/esmini_simulator/agent_states",
            AgentStates,
            self._agent_states_callback,
        )
        self._collision_profile_subscriber = rospy.Subscriber(
            "/simulation/collision_profile",
            CollisionProfile,
            self._collision_callback,
        )
        self._ttc_publisher = rospy.Publisher(
            "scenario_monitor/ttc", Float32, queue_size=1
        )
        self._timer = rospy.Timer(rospy.Duration(0.015), self._sample)

        self.max_distance = 50

        self.current_relative_distance = {}
        self.current_dce = {}
        self.current_ttce = {}
        self.current_ttc_1D = {}
        self.current_collision_risk = {}
        self.current_nearest_point_pair = {}
        self.current_agent_states = None

    def reset(self):
        self.current_agent_states = None
        self.car_state = CarState()

        self.ttc_queue = deque()
        self.ttc_1D_queue = deque()
        self.dce_queue = deque() # distance of cloesest encountered
        self.ttce_queue = deque() # distance of cloesest encountered
        self.collision_risk_queue = deque() # distance of cloesest encountered
        self.ttce_add_dce_queue = deque() # distance of cloesest encountered

        self.current_relative_distance = {}
        self.current_dce = {}
        self.current_ttce = {}
        self.current_ttc_1D = {}
        self.current_collision_risk = {}
        self.current_nearest_point_pair = {}

        self._timer.shutdown()
        self._timer.join()
        self._timer = rospy.Timer(rospy.Duration(0.015), self._sample)

    def get_score(self):
        result = OrderedDict({
            "ttc_1D_min": (
                min(self.ttc_1D_queue)
                if len(self.ttc_1D_queue) > 0
                else float("nan")
            )
        })
        return result

    def get_record(self):
        result = OrderedDict(
            {
                "relativeDistance": self.current_relative_distance,
                # "ttc": self.current_ttc_1D,
                "ttc1D": self.current_ttc_1D,
            }
        )
        return result

    def _car_state_callback(self, msg):
        self.car_state = msg

    def _collision_callback(self, msg):
        frame_id = msg.header.frame_id
        if frame_id == "esmini_collision":
            self.collision_profile = msg

    def _agent_states_callback(self, msg):
        # type: (AgentStates) -> None
        self.current_agent_states = msg

    def _sample(self, event):
        # Function to compute positions

        agent_states = self.current_agent_states

        if agent_states is None or agent_states.agents is None:
            # print("agent states agents are None")
            return

        ego_state = None  # type: Optional[AgentState]
        for agent in agent_states.agents:
            agent = agent  # type: AgentState
            if agent.name == "Ego":
                ego_state = agent

        if ego_state is None:
            return

        ego_heading = heading_vector_from_yaw(ego_state.h)
        for agent in agent_states.agents:
            agent_state = agent  # type: AgentState
            if agent.name == "Ego":
                continue

            agent_heading = heading_vector_from_yaw(agent_state.h)

            pair_sample = pd.DataFrame(
                {
                    "x_i": [ego_state.x],
                    "y_i": [ego_state.y],
                    "vx_i": [ego_state.speed * ego_heading[0]],
                    "vy_i": [ego_state.speed * ego_heading[1]],
                    "hx_i": [ego_heading[0]],
                    "hy_i": [ego_heading[1]],
                    "length_i": [ego_state.length],
                    "width_i": [ego_state.width],
                    "x_j": [agent_state.x],
                    "y_j": [agent_state.y],
                    "vx_j": [agent_state.speed * agent_heading[0]],
                    "vy_j": [agent_state.speed * agent_heading[1]],
                    "hx_j": [agent_heading[0]],
                    "hy_j": [agent_heading[1]],
                    "length_j": [agent_state.length],
                    "width_j": [agent_state.width],
                }
            )

            (
                point_i1,
                point_i2,
                point_i3,
                point_i4,
                point_j1,
                point_j2,
                point_j3,
                point_j4,
            ) = getpoints(pair_sample)

            point_i1 = point_i1.flatten()
            point_i2 = point_i2.flatten()
            point_i3 = point_i3.flatten()
            point_i4 = point_i4.flatten()

            point_j1 = point_j1.flatten()
            point_j2 = point_j2.flatten()
            point_j3 = point_j3.flatten()
            point_j4 = point_j4.flatten()

            ego_polygon = Polygon([point_i1, point_i2, point_i4, point_i3])
            agent_polygon = Polygon([point_j1, point_j2, point_j4, point_j3])

            nearest_point_on_ego, nearest_point_on_agent = nearest_points(ego_polygon, agent_polygon)
            nearest_distance = nearest_point_on_ego.distance(nearest_point_on_agent)
            self.current_relative_distance[agent.name] = nearest_distance

            # ttc same direction 1D
            # -------------------------------------------------------------
            # ego_long_speed = ego_state.speed * math.cos(ego_state.h - ego_state.laneHeading)
            # agent_long_speed = agent_state.speed * math.cos(agent_state.h - ego_state.laneHeading)
            # nearest_distance_angle = math.atan2(nearest_point_on_agent.y - nearest_point_on_ego.y, nearest_point_on_agent.x - nearest_point_on_ego.x)
            # rel_speed = agent_long_speed - ego_long_speed
            # gap = abs(nearest_distance * math.cos(nearest_distance_angle - ego_state.laneHeading))

            ego_long_speed = ego_state.speed
            agent_long_speed = agent_state.speed * math.cos(agent_state.h - ego_state.h)
            nearest_distance_angle = math.atan2(nearest_point_on_agent.y - nearest_point_on_ego.y, nearest_point_on_agent.x - nearest_point_on_ego.x)
            rel_speed = agent_long_speed - ego_long_speed
            gap = abs(nearest_distance * math.cos(nearest_distance_angle - ego_state.h))

            ttc_1D = self.ttc_max
            if rel_speed < 0:
                ttc_1D = gap / abs(rel_speed)
            ttc_1D = min(self.ttc_max, ttc_1D)
            # print(agent_state.name)
            # print(ttc_1D)
            self.current_ttc_1D[agent.name] = ttc_1D
            self.ttc_1D_queue.append(ttc_1D)
            # -------------------------------------------------------------
