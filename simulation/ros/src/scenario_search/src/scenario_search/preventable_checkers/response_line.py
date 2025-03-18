from __future__ import print_function
from copy import deepcopy
from itri_msgs.msg import CarState
from scenario_classification.msg import ClassificationObjectArray, ClassificationObject
from scenario_msgs.msg import AgentData, AgentDataArray
from simulation_utils.converter import QuaternionToVector3
from scenario_search.scoring.third_party.TwoDimTTC import getpoints
from geometry_msgs.msg import Vector3
from std_msgs.msg import Bool
from shapely.geometry import LineString, Polygon, Point
from cython_simulation_utils import cy_coord_transform as transform
from scenario_search.utils import get_simulator_name
from simulation_msgs.msg import CollisionProfile
from scenario_search.preventable_checkers.preventable_base import PreventableCheckerBase
import rospy
import math
import numpy as np
import pandas as pd
from pprint import pprint
import time


class ResponseLinePreventableChecker(PreventableCheckerBase):
    def __init__(self, preventable_condition):
        self.ego_trace = []
        self.ego_top_left_trace = []
        self.ego_top_right_trace = []
        self.agent_top_left_trace = []
        self.agent_top_right_trace = []
        self.car_state = CarState()
        self.collision_profile = None
        self.should_start_response_time = None
        self.should_start_braking_info = None
        self.last_sample = None
        self.ego_stuck_message = None

        self.trace_min_interval = 1

        self.preventable_condition = preventable_condition
        line_points = self.preventable_condition["agent_triggered_response_line"]
        self.should_start_response_line = LineString(
            [line_points["start"], line_points["end"]]
        )

        self._car_state_subscriber = rospy.Subscriber(
            "/car_state", CarState, self._car_state_callback
        )
        self._agent_data_array_subscriber = rospy.Subscriber(
            "/agent_data_array/global", AgentDataArray, self._agent_data_array_callback
        )
        self._collision_profile_subscriber = rospy.Subscriber(
            "/simulation/collision_profile",
            CollisionProfile,
            self._collision_callback,
        )
        self.ego_stuck_subscriber = rospy.Subscriber(
            "/ego_stuck", Bool, self._ego_stuck_callback
        )
        # self._classification_objects_subscriber = rospy.Subscriber(
        #     "classification_objects",
        #     ClassificationObjectArray,
        #     self._classification_objects_callback,
        # )

    def _ego_stuck_callback(self, msg):
        self.ego_stuck_message = msg

    def reset(self):
        self.ego_trace = []
        self.ego_top_left_trace = []
        self.ego_top_right_trace = []
        self.agent_top_left_trace = []
        self.agent_top_right_trace = []
        self.car_state = CarState()
        self.collision_profile = None
        self.should_start_response_time = None
        self.should_start_braking_info = None
        self.last_sample = None
        self.ego_stuck_message = None

    def is_preventable(self):
        if self.should_start_braking_info is None:
            return 0

        try:
            self._extend_traces()

            ego_trace_linestring = LineString(self.ego_trace)

            # print("agent_trace original points")
            # # print(self.agent_top_left_trace)
            # for point in self.agent_top_left_trace:
            #     print((point[0], point[1]), end=",")
            # print()
            # for point in self.agent_top_right_trace:
            #     print((point[0], point[1]), end=",")
            # print()

            self.ego_top_right_trace.reverse()
            self.agent_top_right_trace.reverse()
            ego_trace_polygon = Polygon(
                self.ego_top_left_trace + self.ego_top_right_trace
            ).buffer(0.1)
            agent_trace_polygon = Polygon(
                self.agent_top_left_trace + self.agent_top_right_trace
            ).buffer(0.1)
            overlap_polygon = ego_trace_polygon.intersection(
                agent_trace_polygon
            )  # type: Polygon

            # print("ego_trace_polygon")
            # for coord in ego_trace_polygon.exterior.coords:
            #     print((coord[0], coord[1]), end=",")
            # print()
            #
            # print("agent_trace_polygon")
            # for coord in agent_trace_polygon.exterior.coords:
            #     print((coord[0], coord[1]), end=",")
            # print()
            #
            # print("overlap_polygon")
            # for coord in overlap_polygon.exterior.coords:
            #     print((coord[0], coord[1]), end=",")
            # print()
            #
            # print("ego_trace_linestring")
            # for coord in ego_trace_linestring.coords:
            #     print((coord[0], coord[1]), end=",")
            # print()

            # Find the intersection points
            intersection = ego_trace_linestring.intersection(overlap_polygon)

            print("intersection geom type")
            print(intersection.geom_type)

            # Check if there are intersection points
            if intersection.is_empty:
                raise RuntimeError("Intersection is empty")

            elif intersection.geom_type == "Point":
                raise RuntimeError("Intersection should be MultiPoint")

            elif (
                intersection.geom_type == "MultiPoint"
                or intersection.geom_type == "LineString"
            ):
                intersected_points = list(intersection.coords)
                print("intersected_points")
                print(intersected_points)
                cloest_intersected_point = None
                min_distance = float("inf")
                for point in intersected_points:
                    distance = np.linalg.norm(point - self.ego_trace[0])
                    if distance < min_distance:
                        cloest_intersected_point = point
                        min_distance = distance

                point1 = Point(cloest_intersected_point)
                point2 = Point(self.should_start_braking_info["position"])

                # print("point1")
                # print(point1)
                # print("point2")
                # print(point2)

                distance1 = ego_trace_linestring.project(point1)
                distance2 = ego_trace_linestring.project(point2)

                # print("distance1")
                # print(distance1)
                # print("distance2")
                # print(distance2)

                distance_along_line = distance1 - distance2

                preventable_braking_distance = self.should_start_braking_info[
                    "speed"
                ] ** 2 / (2 * self.preventable_condition["braking"])

                # print("distance_along_line")
                # print(distance_along_line)
                # print("preventable_braking_distance")
                # print(preventable_braking_distance)

                return int(distance_along_line > preventable_braking_distance)
            else:
                raise RuntimeError("There is no intersection")
        except Exception as e:
            return -1

    def _collision_profile_callback(self, msg):
        self.collision_profile = msg

    def _extend_traces(self):
        if self.last_sample is None:
            return

        agent_heading = np.array(
            [self.last_sample["hx_j"][0], self.last_sample["hy_j"][0]]
        )
        agent_position = np.array(
            [self.last_sample["x_j"][0], self.last_sample["y_j"][0]]
        )
        agent_extend_position = (
            agent_position + 2 * self.last_sample["length_j"][0] * agent_heading
        )

        ego_heading = np.array(
            [self.last_sample["hx_i"][0], self.last_sample["hy_i"][0]]
        )
        ego_position = np.array(
            [self.last_sample["x_i"][0], self.last_sample["y_i"][0]]
        )
        ego_extend_position = (
            ego_position + 2 * self.last_sample["length_i"][0] * ego_heading
        )

        sample = deepcopy(self.last_sample)
        sample["x_j"] = agent_extend_position[0]
        sample["y_j"] = agent_extend_position[1]
        sample["x_i"] = ego_extend_position[0]
        sample["y_i"] = ego_extend_position[1]

        (
            point_i1,
            point_i2,
            point_i3,
            point_i4,
            point_j1,
            point_j2,
            point_j3,
            point_j4,
        ) = getpoints(sample)
        ego_points = [point_i1, point_i2, point_i4, point_i3]
        agent_points = [point_j1, point_j2, point_j4, point_j3]
        self._append_trace(self.ego_top_left_trace, ego_points[0].flatten())
        self._append_trace(self.ego_top_right_trace, ego_points[1].flatten())
        self._append_trace(self.agent_top_left_trace, agent_points[0].flatten())
        self._append_trace(self.agent_top_right_trace, agent_points[1].flatten())
        self._append_trace(self.ego_trace, ego_extend_position.flatten())

    def _append_trace(self, trace, point):
        if (
            len(trace) == 0
            or np.linalg.norm(point - trace[-1]) > self.trace_min_interval
        ):
            trace.append(point)

    def _car_state_callback(self, msg):
        # type: (CarState) -> None
        self.car_state = msg

    def _collision_callback(self, msg):
        frame_id = msg.header.frame_id
        if frame_id == "esmini_collision":
            self.collision_profile = msg

    def _agent_data_array_callback(self, msg):
        # type: (AgentDataArray) -> None
        if msg.data is None or len(msg.data) == 0:
            return
        agent_data = msg.data[0]  # type: AgentData

        agent_position = agent_data.pose.position
        agent_velocity = agent_data.linear_velocity
        agent_yaw = QuaternionToVector3(agent_data.pose.orientation).z
        agent_heading = self.heading_vector_from_yaw(agent_yaw)
        agent_size = agent_data.size

        ego_position = self.car_state.pose.pose.position
        ego_velocity = self.car_state.twist.twist.linear
        ego_yaw = self.car_state.pose.pose.orientation.z
        ego_heading = self.heading_vector_from_yaw(ego_yaw)

        sample = pd.DataFrame(
            {
                "x_i": [ego_position.x],
                "y_i": [ego_position.y],
                "vx_i": [ego_velocity.x],
                "vy_i": [ego_velocity.y],
                "hx_i": [ego_heading[0]],
                "hy_i": [ego_heading[1]],
                "length_i": [5.17],
                "width_i": [2.2],
                "x_j": [agent_position.x],
                "y_j": [agent_position.y],
                "vx_j": [agent_velocity.x],
                "vy_j": [agent_velocity.y],
                "hx_j": [agent_heading[0]],
                "hy_j": [agent_heading[1]],
                "length_j": [agent_size.x],
                "width_j": [agent_size.y],
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
        ) = getpoints(sample)

        ego_points = [point_i1, point_i2, point_i4, point_i3]
        agent_points = [point_j1, point_j2, point_j4, point_j3]

        found_nan_in_points = False
        for i in range(len(ego_points)):
            ego_points[i] = ego_points[i].flatten()
            if np.any(np.isnan(ego_points[i])):
                found_nan_in_points = True
                break
        for i in range(len(agent_points)):
            agent_points[i] = agent_points[i].flatten()
            if np.any(np.isnan(agent_points[i])):
                found_nan_in_points = True
                break
        if found_nan_in_points:
            return

        if (
            self.collision_profile is not None or self.ego_stuck_message is not None
        ) and self.last_sample is None:
            self.last_sample = sample

        if self.last_sample is None:
            self._append_trace(self.ego_top_left_trace, ego_points[0].flatten())
            self._append_trace(self.ego_top_right_trace, ego_points[1].flatten())
            self._append_trace(self.agent_top_left_trace, agent_points[0].flatten())
            self._append_trace(self.agent_top_right_trace, agent_points[1].flatten())
            self._append_trace(
                self.ego_trace, np.array([ego_position.x, ego_position.y])
            )

        agent_polygon = Polygon(agent_points)
        intersection = agent_polygon.intersection(self.should_start_response_line)
        if intersection and self.should_start_response_time is None:
            self.should_start_response_time = time.time()
            print("SHOULD START RESPOND...")
        now_time = time.time()

        if (
            self.should_start_response_time is not None
            and self.should_start_braking_info is None
            and now_time - self.should_start_response_time
            >= self.preventable_condition["response_time"]
        ):
            ego_speed = np.linalg.norm(
                np.array(
                    [
                        self.car_state.twist.twist.linear.x,
                        self.car_state.twist.twist.linear.y,
                    ]
                )
            )
            print("SHOULD START BRAKING...")
            self.should_start_braking_info = {
                "position": np.array(
                    [
                        (ego_points[0][0] + ego_points[1][0]) / 2,
                        (ego_points[0][1] + ego_points[1][1]) / 2,
                    ]
                ),
                "speed": ego_speed,
            }
            pprint(self.should_start_braking_info)

    def heading_vector_from_yaw(self, yaw):
        # type: (float) -> tuple[float ,float]
        x_component = math.cos(yaw)
        y_component = math.sin(yaw)
        return (x_component, y_component)
