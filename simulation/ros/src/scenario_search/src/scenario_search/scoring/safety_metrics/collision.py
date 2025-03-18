from typing import Optional
import rospy
from collections import OrderedDict

from shapely import affinity
import math
from shapely.ops import nearest_points, split
from scenario_search.scoring.third_party.TwoDimTTC import getpoints
import numpy as np
import pandas as pd
from scenario.msg import AgentStates, AgentState
from std_msgs.msg import Bool
from safety_metric_base import MetricBase
from simulation_msgs.msg import CollisionProfile, CollisionState
from shapely.geometry import Polygon, LineString


def calculate_point2_from_vector(point1, heading_vector, distance=1000):
    """
    Calculates a new point 1000 units away from point1 in the direction of heading_vector.

    Args:
        point1 (tuple or list): The starting point as (x, y).
        heading_vector (tuple or list): The heading vector as (dx, dy).
        distance (float): The distance to extend from point1.

    Returns:
        tuple: The new point2 as (x2, y2).
    """
    # Convert to NumPy arrays
    p1 = np.array(point1, dtype=float)
    hv = np.array(heading_vector, dtype=float)

    # Calculate the magnitude of the heading vector
    magnitude = np.linalg.norm(hv)
    if magnitude == 0:
        raise ValueError("Heading vector cannot be zero.")

    # Normalize the heading vector
    unit_vector = hv / magnitude

    # Calculate displacement
    displacement = unit_vector * distance

    # Calculate point2
    point2 = p1 + displacement

    return point2


def heading_vector_from_yaw(yaw):
    x_component = math.cos(yaw)
    y_component = math.sin(yaw)
    return (x_component, y_component)


class CollisionMetric(MetricBase):
    def __init__(self):
        super(CollisionMetric, self).__init__()
        self.collision_profile = None  # Optional[CollisionProfile]
        self.collision_profile_subscriber = rospy.Subscriber(
            "/simulation/collision_profile",
            CollisionProfile,
            self._collision_callback,
        )
        self.ego_stuck_subscriber = rospy.Subscriber(
            "/esmini_ego_stuck",
            Bool,
            self._esmini_ego_stuck_callback,
        )
        self._agent_states_subscriber = rospy.Subscriber(
            "/esmini_simulator/agent_states",
            AgentStates,
            self._agent_states_callback,
        )
        self.is_ego_stuck = False
        self.current_agent_states = None  # type: Optional[AgentStates]
        self.waymo_is_ego_fault = False

    def reset(self):
        self.collision_profile = None
        self.is_ego_stuck = False
        self.current_agent_states = None
        self.waymo_is_ego_fault = False

    def get_score(self):
        print("Collision get score")
        print(self.collision_profile)
        collided = self.collision_profile is not None
        waymo_collision = int(collided)
        if collided and not self.waymo_is_ego_fault:
            waymo_collision = 0.5
        result = OrderedDict(
            {
                "collision": int(collided),
                "stuck": int(self.is_ego_stuck and self.collision_profile is not None),
                "waymo_collision": waymo_collision,
            }
        )
        return result

    def get_record(self):
        return OrderedDict()

    def _esmini_ego_stuck_callback(self, msg):
        # type: (Bool) -> None
        self.is_ego_stuck = msg.data

    def _agent_states_callback(self, msg):
        # type: (AgentStates) -> None
        if self.collision_profile is not None:
            return
        self.current_agent_states = msg

    def _collision_callback(self, msg):
        # type: (CollisionProfile) -> None

        frame_id = msg.header.frame_id
        if "esmini_collision" in frame_id:
            self.collision_profile = msg

            if self.current_agent_states is None:
                return

            collided_agent_name = frame_id.split("/")[1]
            agent_states = self.current_agent_states  # type: Optional[AgentStates]
            print("collided_agent_name")
            print(collided_agent_name)

            if agent_states is None or agent_states.agents is None:
                print("agent states agents are None")
                return

            ego_state = None  # type: Optional[AgentState]
            for agent in agent_states.agents:
                agent = agent  # type: AgentState
                if agent.name == "Ego":
                    ego_state = agent

            if ego_state is None:
                print("ego_state is None")
                return

            collided_agent_state = None
            for agent in agent_states.agents:
                agent = agent  # type: AgentState
                if agent.name == collided_agent_name:
                    collided_agent_state = agent

            if collided_agent_state is None:
                print("collided agent state is None")
                return

            if collided_agent_state.speed < 0.1:
                print("agent does not have speed, is ego's fault")
                self.waymo_is_ego_fault = True
                return

            if ego_state.speed < 0.1:
                print("ego does not have speed, is not ego's fault")
                return

            ego_heading = heading_vector_from_yaw(ego_state.h)
            agent_heading = heading_vector_from_yaw(collided_agent_state.h)

            ego_width = 2.2
            ego_length = 5.17
            pair_sample = pd.DataFrame(
                {
                    "x_i": [ego_state.x],
                    "y_i": [ego_state.y],
                    "vx_i": [ego_state.speed * ego_heading[0]],
                    "vy_i": [ego_state.speed * ego_heading[1]],
                    "hx_i": [ego_heading[0]],
                    "hy_i": [ego_heading[1]],
                    "length_i": [ego_length],
                    "width_i": [ego_width],
                    "x_j": [collided_agent_state.x],
                    "y_j": [collided_agent_state.y],
                    "vx_j": [collided_agent_state.speed * agent_heading[0]],
                    "vy_j": [collided_agent_state.speed * agent_heading[1]],
                    "hx_j": [agent_heading[0]],
                    "hy_j": [agent_heading[1]],
                    "length_j": [collided_agent_state.length],
                    "width_j": [collided_agent_state.width],
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

            ego_left_edge = LineString([point_i1, point_i3])
            ego_right_edge = LineString([point_i2, point_i4])
            partition_length = ego_length * 1 / 3
            ego_partition_left_point = ego_left_edge.interpolate(partition_length)
            ego_partition_right_point = ego_right_edge.interpolate(partition_length)

            ego_front_polygon = Polygon(
                [
                    point_i1,
                    point_i2,
                    ego_partition_right_point,
                    ego_partition_left_point,
                ]
            )
            ego_polygon = Polygon([point_i1, point_i2, point_i4, point_i3])
            agent_polygon = Polygon([point_j1, point_j2, point_j4, point_j3])

            nearest_point_on_ego, nearest_point_on_agent = nearest_points(ego_polygon, agent_polygon)

            scale = 1.005
            scaled_ego_front = affinity.scale(
                ego_front_polygon, xfact=scale, yfact=scale, origin="centroid"
            )
            if scaled_ego_front.contains(nearest_point_on_ego):
                self.waymo_is_ego_fault = True
