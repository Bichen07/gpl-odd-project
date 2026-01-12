import json
import threading
import pandas as pd
import numpy as np
from typing import Any, Optional, Tuple
import time
import requests
from pprint import pprint
import os
import csv
import math
import fcntl
import rospy
import rostopic
from threading import Thread
from collections import OrderedDict, deque
from cython_simulation_utils import cy_converter as converter
from cython_simulation_utils import cy_coord_transform as transform
from itri_msgs.msg import CarState, steer_cmd, speed_cmd
from scenario.msg import AgentStates, AgentState
from simulation_msgs.msg import CollisionProfile
from scenario_classification.msg import ClassificationObjectArray, TagTrees
from std_msgs.msg import Bool, String
from scenario_msgs.msg import AgentDataArray, AgentData
from geometry_msgs.msg import Point, Vector3, Pose, Quaternion, Twist
from scoring.scoring import Scoring
from pathlib import Path
import numpy as np
from shapely.ops import nearest_points, split
from shapely.prepared import prep
from shapely.geometry import Polygon, LineString, Point as SPoint
from scenario_search.scoring.third_party.TwoDimTTC import getpoints, mygetpoints


def predict_position(x, y, v, theta, t):
    return [x + v * math.cos(theta) * t, y + v * math.sin(theta) * t]


def heading_vector_from_yaw(yaw):
    # type: (float) -> Tuple[float ,float]
    x_component = math.cos(yaw)
    y_component = math.sin(yaw)
    return (x_component, y_component)


def are_lines_parallel(p1, p2, q1, q2):
    """
    Check if the lines formed by points (p1, p2) and (q1, q2) are parallel.

    Parameters:
        p1, p2, q1, q2: Tuples representing the points (x, y).

    Returns:
        True if the lines are parallel, False otherwise.
    """
    # Create LineString objects
    line1 = LineString([p1, p2])
    line2 = LineString([q1, q2])

    # Calculate direction vectors
    dx1, dy1 = p2[0] - p1[0], p2[1] - p1[1]
    dx2, dy2 = q2[0] - q1[0], q2[1] - q1[1]

    # Use cross product to check parallelism
    cross_product = dx1 * dy2 - dy1 * dx2
    return cross_product < 0.001


def extract_points(geom):
    points = []
    if geom.is_empty:
        return points
    # Single point
    if geom.geom_type == "Point":
        points.append([geom.x, geom.y])
    # Multiple points
    elif geom.geom_type == "MultiPoint":
        points = [[pt.x, pt.y] for pt in geom.geoms]
    # A line segment (or several) - here we take the endpoints
    elif geom.geom_type == "LineString":
        coords = list(geom.coords)
        points.extend([[coords[0][0], coords[0][1]], [coords[-1][0], coords[-1][1]]])
    # If there are multiple line segments
    elif geom.geom_type == "MultiLineString":
        for line in geom.geoms:
            coords = list(line.coords)
            points.extend(
                [[coords[0][0], coords[0][1]], [coords[-1][0], coords[-1][1]]]
            )
    # If a GeometryCollection, iterate through each part
    else:
        for part in geom.geoms:
            points.extend(extract_points(part))
    return points


def predict_trajectory(pos, heading, speed, duration, dt):
    """Predicts positions using constant velocity model."""
    times = np.arange(0, duration, dt)
    traj = np.array(
        [
            pos + speed * t * np.array([math.cos(heading), math.sin(heading)])
            for t in times
        ]
    )
    return times, traj


def compute_SPrET(
    p1,
    h1,
    v1,
    p2,
    h2,
    v2,
    w1,
    l1,
    w2,
    l2,
    polygon_points=None,
    epsilon=0.01,
    duration=5.0,
    dt=0.1,
):
    """Computes Predictive Encroachment Time (PrET)."""
    times1, traj1 = predict_trajectory(np.array(p1), h1, v1, duration, dt)
    times2, traj2 = predict_trajectory(np.array(p2), h2, v2, duration, dt)

    # Optional polygon gating
    prepared_poly = None
    if polygon_points is not None:
        roi_poly = Polygon(polygon_points)
        if not roi_poly.is_valid or roi_poly.is_empty:
            raise ValueError("polygon_points define an invalid/empty polygon.")
        prepared_poly = prep(roi_poly)

    min_time_diff = float("inf")

    found = False
    for i, t1 in enumerate(times1):

        ego_pos = traj1[i]
        # If polygon provided, ensure ego sample is inside
        if prepared_poly is not None and not prepared_poly.contains(
            SPoint([float(ego_pos[0]), float(ego_pos[1])])
        ):
            continue

        for j, t2 in enumerate(times2):
            agent_pos = traj2[j]
            # If polygon provided, ensure agent sample is inside
            if prepared_poly is not None and not prepared_poly.contains(
                SPoint([float(agent_pos[0]), float(agent_pos[1])])
            ):
                continue

            dist = np.linalg.norm(traj1[i] - traj2[j])

            # Optional fast rejection
            if dist > max(w1 / 2, l1 / 2) + max(w2 / 2, l2 / 2) + 2 * epsilon:
                continue

            ego_heading = heading_vector_from_yaw(h1)
            agent_heading = heading_vector_from_yaw(h2)

            pair_sample = {
                "x_i": np.array([ego_pos[0]]),
                "y_i": np.array([ego_pos[1]]),
                "vx_i": np.array([v1 * ego_heading[0]]),
                "vy_i": np.array([v1 * ego_heading[1]]),
                "hx_i": np.array([ego_heading[0]]),
                "hy_i": np.array([ego_heading[1]]),
                "length_i": np.array([l1]),
                "width_i": np.array([w1]),
                "x_j": np.array([agent_pos[0]]),
                "y_j": np.array([agent_pos[1]]),
                "vx_j": np.array([v2 * agent_heading[0]]),
                "vy_j": np.array([v2 * agent_heading[1]]),
                "hx_j": np.array([agent_heading[0]]),
                "hy_j": np.array([agent_heading[1]]),
                "length_j": np.array([l2]),
                "width_j": np.array([w2]),
            }

            (
                point_i1,
                point_i2,
                point_i3,
                point_i4,
                point_j1,
                point_j2,
                point_j3,
                point_j4,
            ) = mygetpoints(pair_sample)

            point_i1 = point_i1.flatten()
            point_i2 = point_i2.flatten()
            point_i3 = point_i3.flatten()
            point_i4 = point_i4.flatten()
            point_j1 = point_j1.flatten()
            point_j2 = point_j2.flatten()
            point_j3 = point_j3.flatten()
            point_j4 = point_j4.flatten()

            ego_box = Polygon([point_i1, point_i2, point_i4, point_i3])
            agent_box = Polygon([point_j1, point_j2, point_j4, point_j3])
            dist = ego_box.distance(agent_box)

            if dist < epsilon:
                time_diff = abs(t1**2 - t2**2)
                if time_diff < min_time_diff:
                    min_time_diff = time_diff
                    found = True
                    break
        if found:
            break

    return min_time_diff if min_time_diff != float("inf") else None


def getprojpoints(samples, time):
    ## vehicle i
    heading_i = samples[["hx_i", "hy_i"]].values
    perp_heading_i = np.array([-heading_i[:, 1], heading_i[:, 0]]).T
    heading_scale_i = np.tile(
        np.sqrt(heading_i[:, 0] ** 2 + heading_i[:, 1] ** 2), (2, 1)
    ).T
    length_i = np.tile(samples.length_i.values, (2, 1)).T
    width_i = np.tile(samples.width_i.values, (2, 1)).T
    speed_i = np.tile(samples.speed_i.values, (2, 1)).T

    point_up = samples[["x_i", "y_i"]].values + heading_i / heading_scale_i * (
        length_i / 2 + speed_i * time
    )
    point_down = (
        samples[["x_i", "y_i"]].values - heading_i / heading_scale_i * length_i / 2
    )
    point_i1 = (point_up + perp_heading_i / heading_scale_i * width_i / 2).T
    point_i2 = (point_up - perp_heading_i / heading_scale_i * width_i / 2).T
    point_i3 = (point_down + perp_heading_i / heading_scale_i * width_i / 2).T
    point_i4 = (point_down - perp_heading_i / heading_scale_i * width_i / 2).T

    ## vehicle j
    heading_j = samples[["hx_j", "hy_j"]].values
    perp_heading_j = np.array([-heading_j[:, 1], heading_j[:, 0]]).T
    heading_scale_j = np.tile(
        np.sqrt(heading_j[:, 0] ** 2 + heading_j[:, 1] ** 2), (2, 1)
    ).T
    length_j = np.tile(samples.length_j.values, (2, 1)).T
    width_j = np.tile(samples.width_j.values, (2, 1)).T
    speed_j = np.tile(samples.speed_j.values, (2, 1)).T

    point_up = samples[["x_j", "y_j"]].values + heading_j / heading_scale_j * (
        length_j / 2 + speed_j * time
    )
    point_down = (
        samples[["x_j", "y_j"]].values - heading_j / heading_scale_j * length_j / 2
    )
    point_j1 = (point_up + perp_heading_j / heading_scale_j * width_j / 2).T
    point_j2 = (point_up - perp_heading_j / heading_scale_j * width_j / 2).T
    point_j3 = (point_down + perp_heading_j / heading_scale_j * width_j / 2).T
    point_j4 = (point_down - perp_heading_j / heading_scale_j * width_j / 2).T

    return (
        point_i1,
        point_i2,
        point_i3,
        point_i4,
        point_j1,
        point_j2,
        point_j3,
        point_j4,
    )


class ScenarioSampler:
    def __init__(self, period, payload_api, scoring=None):
        self._HZ_WINDOW_SIZE = 10

        self.USER_API_KEY = os.environ.get("USER_API_KEY")
        self.headers = {
            "Authorization": "users API-Key {}".format(self.USER_API_KEY),
        }

        self.payload_api = payload_api
        self.period = period
        self._record_index = 0
        self._scenario = 0
        self._sample_num = 0
        self._start_time = rospy.Time.now()

        self._timer = None  # type: Optional[rospy.Timer]
        self._writer_workers = []  # type: list[Thread]

        self.scoring = scoring  # type: Optional[Scoring]
        self.data = []

        self._car_state_subscriber = rospy.Subscriber(
            "/car_state",
            CarState,
            self._car_state_callback,
        )
        self._speed_cmd = rospy.Subscriber(
            "/speed_cmd",
            speed_cmd,
            self._speed_cmd_callback,
        )
        self._steer_cmd = rospy.Subscriber(
            "/steer_cmd",
            steer_cmd,
            self._steer_cmd_callback,
        )
        self._agent_states_subscriber = rospy.Subscriber(
            "/esmini_simulator/agent_states",
            AgentStates,
            self._agent_states_callback,
        )
        self._can_start_sampling_subscriber = rospy.Subscriber(
            "can_start_observation_sampling", Bool, self._can_start_sampling_callback
        )
        self.end_scenario_subscriber = rospy.Subscriber(
            "/end_scenario", Bool, self._end_scenario_callback
        )
        self.esmini_event_subscriber = rospy.Subscriber(
            "/esmini_event", String, self._esmini_event_callback
        )
        self.collision_profile_subscriber = rospy.Subscriber(
            "/simulation/collision_profile", CollisionProfile, self._collision_callback
        )

        self.end_scenario_message = None
        self.can_start_observation_sampling = False
        self.start_sampling_esmini_seconds = 0
        self.current_trial_index = -1

        self.current_agent_states = None
        self.current_car_state = None
        self.current_speed_cmd = None
        self.current_steer_cmd = None
        self.current_observation = {}

        self.latest_observations = {}

        self.xosc_events = []
        self.ego_events = []
        self.caution_events = []
        self.events = []
        self.ego_is_braking = False
        self.ego_is_accelerating = False
        self.ego_acceleration_queue = []
        self.ego_steering_away_queue = []
        self.ego_current_steering_away_condition = None
        self.ego_current_acceleration_condition = None
        self.collided = False
        self.collided_agent = None
        self.collided_observation_recorded = False

        self.ttce_max = 5
        self.ttc_max = 5
        self.spret_max = 10000
        self.dce_max = 10
        self.pret_max = 7
        self.score = {}
        self.agent_size = {}

        self._reset()

    def preprocess_saved_data(self):
        closest_snapshot = {}
        closest_distance = {}
        for index, snapshot in enumerate(self.data):
            for agent in snapshot["agents"]:
                if agent["name"] not in closest_distance.keys():
                    closest_distance[agent["name"]] = float("inf")
                agent_distance = agent["relativeDistance"]
                if (
                    agent_distance is not None
                    and agent_distance < closest_distance[agent["name"]]
                ):
                    closest_snapshot[agent["name"]] = snapshot
                    closest_distance[agent["name"]] = agent_distance

        ttc_min = self.ttc_max
        pret_min = self.pret_max
        ttce_dce_min = self.dce_max + self.ttce_max
        rss_dce = 5
        dce_min = self.dce_max
        ttce_min = self.ttce_max
        spret_min = self.spret_max
        acc_req_max = 0
        collision_risk_max = 0
        print("PREPROCESSING...")
        for index, snapshot in enumerate(self.data):
            # print("esminiSeconds")
            # print(snapshot["esminiSeconds"])
            is_last_snapshot = index == len(self.data) - 2

            next_snapshot = None
            if index + 1 < len(self.data):
                next_snapshot = self.data[index + 1]
            if next_snapshot is not None:
                ego_heading = snapshot["egoYaw"]
                ego_next_heading = next_snapshot["egoYaw"]
                theta = ego_next_heading - ego_heading
                ego_velocity_long = snapshot["egoSpeed"] * math.cos(theta)
                ego_velocity_lat = snapshot["egoSpeed"] * math.sin(theta)
                snapshot["egoVelocityLong"] = ego_velocity_long
                snapshot["egoVelocityLat"] = ego_velocity_lat
            else:
                last_snapshot = self.data[index - 1]
                snapshot["egoVelocityLong"] = last_snapshot["egoVelocityLong"]
                snapshot["egoVelocityLat"] = last_snapshot["egoVelocityLat"]

            for agent in snapshot["agents"]:
                if "Temp" in agent["name"]:
                    continue

                agent["dce"] = self.dce_max

                # temp
                agent["relativeAccelerationY"] = int(agent["pathIntersected"])

                if not agent["isRssSafe"]:
                    rss_dce = min(rss_dce, agent["relativeDistance"])
                if agent["pathIntersected"]:
                    dce_min = min(dce_min, agent["relativeDistance"])
                    # print(dce_min)
                    # print("DCEMIN" * 20)

                agent_closest_snapshot = closest_snapshot[agent["name"]]
                agent_ttce = agent_closest_snapshot["time"] - snapshot["time"]
                # ego_ce_pos = [agent_closest_snapshot["egoX"], agent_closest_snapshot["egoY"]]
                # ego_current_pos = [snapshot["egoX"], snapshot["egoY"]]
                agent_dce = closest_distance[agent["name"]]
                if agent_ttce < 0:
                    agent_ttce = self.ttce_max
                    agent_dce = self.dce_max
                agent["ttce"] = agent_ttce
                # agent["dce"] = agent_dce
                agent["collisionRisk"] = math.exp(-1 * (agent_ttce + agent_dce))
                ttce_dce_min = min(ttce_dce_min, agent_ttce + agent_dce)
                collision_risk_max = max(collision_risk_max, agent["collisionRisk"])
                # # if (agent["name"] != "Parking") or (self.collided and agent["name"] == self.collided_agent):
                # if agent["pathIntersected"]:
                #     # dce_min = min(dce_min, agent_dce)
                #     dce_min = min(dce_min, agent["relativeDistance"])
                ttce_min = min(ttce_min, agent_ttce)
                # acc_req_max = max(acc_req_max, agent["accReq"])
                # spret_min = min(spret_min, agent["spret"])

                if next_snapshot is not None:
                    agent_next_snapshot = [
                        next_frame_agent
                        for next_frame_agent in next_snapshot["agents"]
                        if next_frame_agent["name"] == agent["name"]
                    ][0]
                    agent_heading = agent["yaw"]
                    agent_next_heading = agent_next_snapshot["yaw"]
                    theta = agent_next_heading - agent_heading
                    agent_velocity_long = agent["speed"] * math.cos(theta)
                    agent_velocity_lat = agent["speed"] * math.sin(theta)
                    agent["velocityLong"] = agent_velocity_long
                    agent["velocityLat"] = agent_velocity_lat
                else:
                    last_snapshot = self.data[index - 1]
                    agent_last_snapshot = [
                        last_frame_agent
                        for last_frame_agent in last_snapshot["agents"]
                        if last_frame_agent["name"] == agent["name"]
                    ][0]
                    agent["velocityLong"] = agent_last_snapshot["velocityLong"]
                    agent["velocityLat"] = agent_last_snapshot["velocityLat"]

                # if agent["situationType"] == 2:
                #     prediction_time = 0
                #     time_step = 0.025
                #     ego_lon_dist = 0
                #     object_lon_dist = 0
                #     collided = False
                #     while prediction_time <= self.ttc_max:
                #         prediction_time += time_step
                #         ego_lon_dist += snapshot["egoSpeedLon"] * prediction_time
                #         object_lon_dist += agent["speedLon"] * prediction_time
                #         if ego_lon_dist + object_lon_dist > agent["distLon"]:
                #             collided = True
                #             break
                #
                #     acc_lon_req = 0
                #     if collided:
                #         agent["accReq"] = snapshot["egoSpeed"] ** 2 / 2 / dist
                #         acc_req = min(10, agent["accReq"])
                #         acc_req_max = max(acc_req_max, acc_req)
                #
                # elif agent["situationType"] == 1:
                #     pass

                # ttc = prediction_time
                ttc = None
                time_step = 0.025
                collided = False

                ego_heading = heading_vector_from_yaw(snapshot["egoYaw"])
                agent_heading = heading_vector_from_yaw(agent["yaw"])

                pair_sample = pd.DataFrame(
                    {
                        "x_i": [snapshot["egoX"]],
                        "y_i": [snapshot["egoY"]],
                        "vx_i": [snapshot["egoSpeed"] * ego_heading[0]],
                        "vy_i": [snapshot["egoSpeed"] * ego_heading[1]],
                        "hx_i": [ego_heading[0]],
                        "hy_i": [ego_heading[1]],
                        "length_i": [snapshot["egoLength"]],
                        "width_i": [snapshot["egoWidth"]],
                        "x_j": [agent["x"]],
                        "y_j": [agent["y"]],
                        "vx_j": [agent["speed"] * agent_heading[0]],
                        "vy_j": [agent["speed"] * agent_heading[1]],
                        "hx_j": [agent_heading[0]],
                        "hy_j": [agent_heading[1]],
                        "length_j": [agent["length"]],
                        "width_j": [agent["width"]],
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

                ppi1 = predict_position(
                    point_i1[0],
                    point_i1[1],
                    snapshot["egoSpeed"],
                    snapshot["egoYaw"],
                    self.ttc_max,
                )
                ppi2 = predict_position(
                    point_i2[0],
                    point_i2[1],
                    snapshot["egoSpeed"],
                    snapshot["egoYaw"],
                    self.ttc_max,
                )
                ppi3 = predict_position(
                    point_i3[0],
                    point_i3[1],
                    snapshot["egoSpeed"],
                    snapshot["egoYaw"],
                    self.ttc_max,
                )
                ppi4 = predict_position(
                    point_i4[0],
                    point_i4[1],
                    snapshot["egoSpeed"],
                    snapshot["egoYaw"],
                    self.ttc_max,
                )
                ppj1 = predict_position(
                    point_j1[0],
                    point_j1[1],
                    agent["speed"],
                    agent["yaw"],
                    self.ttc_max,
                )
                ppj2 = predict_position(
                    point_j2[0],
                    point_j2[1],
                    agent["speed"],
                    agent["yaw"],
                    self.ttc_max,
                )
                ppj3 = predict_position(
                    point_j3[0],
                    point_j3[1],
                    agent["speed"],
                    agent["yaw"],
                    self.ttc_max,
                )
                ppj4 = predict_position(
                    point_j4[0],
                    point_j4[1],
                    agent["speed"],
                    agent["yaw"],
                    self.ttc_max,
                )
                ego_path_box = Polygon([ppi1, ppi2, point_i4, point_i3])
                agent_path_box = Polygon([ppj1, ppj2, point_j4, point_j3])

                ego_box = Polygon([point_i1, point_i2, point_i4, point_i3])
                agent_box = Polygon([point_j1, point_j2, point_j4, point_j3])

                pret = self.pret_max
                spret = self.spret_max

                # if ego_path_box.intersects(agent_path_box):
                #     intersection = ego_path_box.boundary.intersection(
                #         agent_path_box.boundary
                #     )
                #     intersected_points = extract_points(intersection)
                #
                #     min_p = None
                #     min_dist = 1000
                #     for p in intersected_points:
                #         dist = math.sqrt(
                #             (point_i1[0] - p[0]) ** 2 + (point_i1[1] - p[1]) ** 2
                #         )
                #         if dist < min_dist:
                #             min_p = p
                #         min_dist = dist if dist < min_dist else min_dist
                #
                #     # is_inside = False
                #     # is_on_border = False
                #     # if min_p is not None:
                #     #     is_inside = Point(min_p).within(ego_box)               # strictly inside
                #     #     is_on_border = Point(min_p).touches(ego_box)           # on the border (edge or vertex)
                #
                #     min_agent_p = None
                #     min_dist_agent = 1000
                #     for p in intersected_points:
                #         dist = math.sqrt(
                #             (point_j1[0] - p[0]) ** 2 + (point_j1[1] - p[1]) ** 2
                #         )
                #         if dist < min_dist_agent:
                #             min_agent_p = p
                #         min_dist_agent = (
                #             dist if dist < min_dist_agent else min_dist_agent
                #         )
                #
                #     # is_agent_inside = None
                #     # is_agent_on_border = None
                #     # if min_agent_p is not None:
                #     #     is_agent_inside = Point(min_agent_p).within(agent_box)               # strictly inside
                #     #     is_agent_on_border = Point(min_agent_p).touches(agent_box)           # on the border (edge or vertex)
                #
                #     t_ego = (
                #         min_dist / 0.001
                #         if snapshot["egoSpeed"] == 0
                #         else min_dist / snapshot["egoSpeed"]
                #     )
                #     if ego_box.intersects(intersection):
                #         t_ego = 0
                #     t_agent = (
                #         min_dist_agent / 0.001
                #         if agent["speed"] == 0
                #         else min_dist_agent / agent["speed"]
                #     )
                #     if agent_box.intersects(intersection):
                #         t_agent = 0
                #     pret = abs(t_ego - t_agent)
                #     spret = abs(t_ego**2 - t_agent**2)
                #     if t_ego > 3 and t_agent > 3:
                #         spret = self.spret_max
                #
                #     print("agent_name")
                #     print(agent["name"])
                #     print("t_ego")
                #     print(t_ego)
                #     print("t_agent")
                #     print(t_agent)
                #     print("min_dist")
                #     print(min_dist)
                #     print("min_dist_agent")
                #     print(min_dist_agent)
                #     print("ego_speed")
                #     print(snapshot["egoSpeed"])
                #     print("agent_speed")
                #     print(agent["speed"])
                #     pprint([
                #         (ppi1[0], ppi1[1]),
                #         (ppi2[0], ppi2[1]),
                #         (point_i4[0], point_i4[1]),
                #         (point_i3[0], point_i3[1]),
                #     ])
                #     pprint([
                #         (ppj1[0], ppj1[1]),
                #         (ppj2[0], ppj2[1]),
                #         (point_j4[0], point_j4[1]),
                #         (point_j3[0], point_j3[1]),
                #     ])
                #     pprint([
                #         (point_i1[0], point_i1[1]),
                #         (point_i2[0], point_i2[1]),
                #         (point_i4[0], point_i4[1]),
                #         (point_i3[0], point_i3[1]),
                #     ])
                #     pprint([
                #         (point_j1[0], point_j1[1]),
                #         (point_j2[0], point_j2[1]),
                #         (point_j4[0], point_j4[1]),
                #         (point_j3[0], point_j3[1]),
                #     ])
                # print("spret")
                # print(spret)
                # print("index")
                # print(index)
                # print("\n")

                # Agent 1: position, heading (radians), speed
                p1 = (snapshot["egoX"], snapshot["egoY"])
                h1 = snapshot["egoYaw"]
                v1 = snapshot["egoSpeed"]  # m/s
                w1 = snapshot["egoWidth"]
                l1 = snapshot["egoLength"]

                # Agent 2: position, heading (radians), speed
                p2 = (agent["x"], agent["y"])
                h2 = agent["yaw"]
                v2 = agent["speed"]  # m/s
                w2 = agent["width"]
                l2 = agent["length"]

                polygon_points = [
                    (-47, -16),
                    (13.7, -27.8),
                    (31.8, 52.0),
                    (-63, 69),
                ]
                # polygon_points = [
                #     (-31.8, -31),
                #     (12, -40),
                #     (28, 29),
                #     (-22, 30),
                # ]
                polygon_points = None
                spret = compute_SPrET(
                    p1, h1, v1, p2, h2, v2, w1, l1, w2, l2, polygon_points
                )
                # print("---------------------")
                # print("ego pos")
                # print(p1)
                # print("ego yaw")
                # print(h1)
                # print("ego speed")
                # print(v1)
                # print("ego width")
                # print(w1)
                # print("ego length")
                # print(l1)
                # print("")
                #
                # print("agent pos")
                # print(p2)
                # print("agent yaw")
                # print(h2)
                # print("agent speed")
                # print(v2)
                # print("agent width")
                # print(w2)
                # print("agent length")
                # print(l2)
                # print("")
                #
                # print("spret")
                # print(spret)
                # print("---------------------")
                # print("\n")
                if spret is None:
                    spret = self.spret_max

                agent["pret"] = spret
                pret_min = min(spret, pret_min)
                agent["spret"] = spret

                if spret_min > spret:
                    print("agent")
                    print(agent["name"])
                    print("spret")
                    print(spret)
                    print(p1)
                    print(p2)
                    print(v1)
                    print(v2)

                spret_min = min(spret, spret_min)

                ppi1 = predict_position(
                    point_i1[0],
                    point_i1[1],
                    snapshot["egoSpeed"],
                    snapshot["egoYaw"],
                    self.ttc_max,
                )
                ppi2 = predict_position(
                    point_i2[0],
                    point_i2[1],
                    snapshot["egoSpeed"],
                    snapshot["egoYaw"],
                    self.ttc_max,
                )
                ppi3 = predict_position(
                    point_i3[0],
                    point_i3[1],
                    snapshot["egoSpeed"],
                    snapshot["egoYaw"],
                    self.ttc_max,
                )
                ppi4 = predict_position(
                    point_i4[0],
                    point_i4[1],
                    snapshot["egoSpeed"],
                    snapshot["egoYaw"],
                    self.ttc_max,
                )
                ppj1 = predict_position(
                    point_j1[0], point_j1[1], agent["speed"], agent["yaw"], self.ttc_max
                )
                ppj2 = predict_position(
                    point_j2[0], point_j2[1], agent["speed"], agent["yaw"], self.ttc_max
                )
                ppj3 = predict_position(
                    point_j3[0], point_j3[1], agent["speed"], agent["yaw"], self.ttc_max
                )
                ppj4 = predict_position(
                    point_j4[0], point_j4[1], agent["speed"], agent["yaw"], self.ttc_max
                )

                ego_path_box = Polygon([ppi1, ppi2, point_i4, point_i3])
                agent_path_box = Polygon([ppj1, ppj2, point_j3, point_j4])

                found_smaller_ttc = False
                if ego_path_box.intersects(agent_path_box):
                    agent["dce"] = min(agent["relativeDistance"], self.dce_max)

                    # Compute the intersection of their boundaries
                    # intersection = ego_path_box.boundary.intersection(
                    #     agent_path_box.boundary
                    # )
                    # intersected_points = extract_points(intersection)
                    #
                    # min_dist = 1000
                    # for p in intersected_points:
                    #     dist = math.sqrt(
                    #         (point_i1[0] - p[0]) ** 2 + (point_i1[1] - p[1]) ** 2
                    #     )
                    #     min_dist = dist if dist < min_dist else min_dist
                    #
                    # min_dist_agent = 1000
                    # for p in intersected_points:
                    #     dist = math.sqrt(
                    #         (point_j1[0] - p[0]) ** 2 + (point_j1[1] - p[1]) ** 2
                    #     )
                    #     min_dist_agent = (
                    #         dist if dist < min_dist_agent else min_dist_agent
                    #     )

                    # if snapshot["egoSpeed"] > 1:
                    #     ttc = min_dist / snapshot["egoSpeed"]
                    #
                    # print("Ego" * 5)
                    # print("dist")
                    # print(min_dist)
                    # print("speed")
                    # print(snapshot["egoSpeed"])
                    # print("ttc")
                    # print(ttc)
                    # print("Ego" * 5)
                    #
                    # if agent["speed"] > 1:
                    #     print("AGENT" * 2)
                    #     ttc = max(ttc if ttc is not None else 0, min_dist_agent / agent["speed"])
                    #     print(agent["name"])
                    #     print("dist")
                    #     print(min_dist_agent)
                    #     print("speed")
                    #     print(agent["speed"])
                    #     print("ttc")
                    #     print(min_dist_agent/ agent["speed"])
                    #     print("AGENT" * 2)
                    #
                    # if ttc is None:
                    #     ttc = self.ttc_max
                    #
                    # if ttc < ttc_min:
                    #     found_smaller_ttc = True
                    #     print("smaller ttc occur")
                    #     print(snapshot["time"])
                    #     print(agent["name"])
                    #     print("ttc")
                    #     print(ttc)
                    #     print("ttc_min")
                    #     print(ttc_min)
                    #
                    # ttc_min = min(ttc_min, ttc)

                    # pprint("COLLISION, dist: {}".format(min_dist))
                    # pprint("COLLISION, egoSpeed: {}".format(snapshot["egoSpeed"]))
                    # pprint("COLLISION, dist_agent: {}".format(min_dist_agent))
                    # pprint("COLLISION, agentSpaeed: {}".format(agent["speed"]))
                    # pprint("COLLISION, TTC: {}".format(ttc))
                    # pprint("TTC MIN: {}".format(ttc_min))

                # agent["ttc"] = min(ttc, self.ttc_max)
                # if found_smaller_ttc:
                #     print(agent["name"])
                #     print(agent["ttc"])

                # print("CALCULATE SNAPSHOT TTC AND ACC_REQ...")
                prediction_time = 0
                ego_predicted_position = None
                while prediction_time <= self.ttc_max:
                    ego_predicted_position = predict_position(
                        snapshot["egoX"],
                        snapshot["egoY"],
                        snapshot["egoSpeed"],
                        snapshot["egoYaw"],
                        prediction_time,
                    )

                    ppi1 = predict_position(
                        point_i1[0],
                        point_i1[1],
                        snapshot["egoSpeed"],
                        snapshot["egoYaw"],
                        prediction_time,
                    )
                    ppi2 = predict_position(
                        point_i2[0],
                        point_i2[1],
                        snapshot["egoSpeed"],
                        snapshot["egoYaw"],
                        prediction_time,
                    )
                    ppi3 = predict_position(
                        point_i3[0],
                        point_i3[1],
                        snapshot["egoSpeed"],
                        snapshot["egoYaw"],
                        prediction_time,
                    )
                    ppi4 = predict_position(
                        point_i4[0],
                        point_i4[1],
                        snapshot["egoSpeed"],
                        snapshot["egoYaw"],
                        prediction_time,
                    )
                    ppj1 = predict_position(
                        point_j1[0],
                        point_j1[1],
                        agent["speed"],
                        agent["yaw"],
                        prediction_time,
                    )
                    ppj2 = predict_position(
                        point_j2[0],
                        point_j2[1],
                        agent["speed"],
                        agent["yaw"],
                        prediction_time,
                    )
                    ppj3 = predict_position(
                        point_j3[0],
                        point_j3[1],
                        agent["speed"],
                        agent["yaw"],
                        prediction_time,
                    )
                    ppj4 = predict_position(
                        point_j4[0],
                        point_j4[1],
                        agent["speed"],
                        agent["yaw"],
                        prediction_time,
                    )

                    ego_polygon = Polygon([ppi1, ppi2, ppi4, ppi3])
                    agent_polygon = Polygon([ppj1, ppj2, ppj4, ppj3])

                    if is_last_snapshot:
                        # print("Ego")
                        ego_polygon_debug = (
                            (ppi1[0], ppi1[1]),
                            (ppi2[0], ppi2[1]),
                            (ppi3[0], ppi3[1]),
                            (ppi4[0], ppi4[1]),
                        )
                        # pprint(ego_polygon_debug)
                        # print("Agent")
                        agent_polygon_debug = (
                            (ppj1[0], ppj1[1]),
                            (ppj2[0], ppj2[1]),
                            (ppj3[0], ppj3[1]),
                            (ppj4[0], ppj4[1]),
                        )
                        # pprint(agent_polygon_debug)

                    if ego_polygon.intersects(agent_polygon):
                        collided = True
                        ttc = prediction_time
                        ttc_min = min(ttc_min, prediction_time)
                        # pprint("COLLISION, TTC: {}".format(prediction_time))
                        # pprint("TTC MIN: {}".format(ttc_min))
                        # pprint(agent["name"])
                        # print("\n")
                        break

                    prediction_time += time_step

                if collided and ego_predicted_position is not None:
                    agent["ttc"] = ttc
                    dist = math.sqrt(
                        (ego_predicted_position[0] - snapshot["egoX"]) ** 2
                        + (ego_predicted_position[1] - snapshot["egoY"]) ** 2
                    )
                    if dist == 0:
                        dist = 0.001
                    # if agent["situationType"] > 2:
                    agent["accReq"] = snapshot["egoSpeed"] ** 2 / 2 / dist
                    acc_req = min(10, agent["accReq"])
                    acc_req_max = max(acc_req_max, acc_req)
                    # print(agent["name"])
                    # print("dist")
                    # print(dist)
                    # print("egoSpeed")
                    # print(snapshot["egoSpeed"])
                    # print(collided)
                    # print("ttc")
                    # print(agent["ttc"])
                    # print('accReq')
                    # print(agent["accReq"])
                else:
                    # agent["ttc"] = self.ttc_max
                    agent["accReq"] = 0

        self.score = {
            "ttce+dce_min": ttce_dce_min,
            "collision_risk": collision_risk_max,
            "ttce_min": ttce_min,
            "ttc_min": ttc_min,
            "pret_min": pret_min,
            "dce_min": dce_min,
            "acc_req_max": acc_req_max,
            "spret_min": spret_min,
            "rss_dce": rss_dce,
        }
        print("SAMPLER PREPROCESS" * 100)
        pprint(self.score)
        print("SAMPLER PREPROCESS" * 100)

    def store_to_db(self, trial_id, ego_id):
        print("Trial ID")
        print(trial_id)

        # def uploadEvents(events, slug):
        #     # for index, event in enumerate(events):
        #     #     event["observation"]["trial"] = trial_id
        #     try:
        #         # response = requests.post(
        #         #     url=self.payload_api + "/observations/batch",
        #         #     headers=self.headers,
        #         #     json=[event["observation"] for event in events],
        #         #     verify=False,
        #         # )
        #         # rospy.logerr(response.raise_for_status())
        #         observation_ids = [observation["id"] for observation in response.json()]
        #         try:
        #             patchData = {
        #                 slug: [
        #                     {
        #                         "name": events[index]["name"],
        #                         "time": events[index]["time"],
        #                         "esminiSeconds": events[index]["esminiSeconds"],
        #                         "observation": observation_ids[index],
        #                     }
        #                     for index in range(len(observation_ids))
        #                 ]
        #             }
        #             response = requests.patch(
        #                 url=self.payload_api + "/trials/{}".format(trial_id),
        #                 json=patchData,
        #                 verify=False,
        #                 headers=self.headers,
        #             )
        #             response.raise_for_status()
        #             print("successfully patch events to trials")
        #         except Exception as e:
        #             print(
        #                 "Patch Events to Trials, Error:",
        #                 str(e),
        #             )
        #     except Exception:
        #         rospy.logerr("Failed to register new observations to database")

        for index, observation in enumerate(self.data):
            observation["trial"] = trial_id
            observation["ego"] = ego_id

        # worst_ttc = {}
        # worst_ttc_index = {}
        # for index, observation in enumerate(self.data):
        #     if "agents" not in observation:
        #         continue
        #     for agent in observation["agents"]:
        #         worst_ttc.setdefault(agent["name"], float("inf"))
        #         if worst_ttc[agent["name"]] > agent["ttc"]:
        #             worst_ttc[agent["name"]] = agent["ttc"]
        #             worst_ttc_index[agent["name"]] = index
        # for agent_name in worst_ttc.keys():
        #     if worst_ttc[agent_name] < 10:
        #         self.events.append(
        #             {
        #                 "name": "worstTtcWith{}".format(agent_name),
        #                 "time": self.data[worst_ttc_index[agent_name]]["time"],
        #                 "esminiSeconds": self.data[worst_ttc_index[agent_name]][
        #                     "esminiSeconds"
        #                 ],
        #                 "observationIndex": worst_ttc_index[agent_name],
        #             }
        #         )

        score = self.scoring.get_score()
        if score and "stuck" in score and score["stuck"] == 1.0:

            def find_last_occurrence_with_speed():
                for i in range(len(self.data) - 1, -1, -1):
                    if self.data[i]["egoSpeed"] > 0.01:
                        return i
                return -1  # If the element is not found

            found_index = find_last_occurrence_with_speed()
            if found_index > -1:
                self.events.append(
                    {
                        "name": "egoStartStuck",
                        "time": self.data[found_index]["time"],
                        "esminiSeconds": self.data[found_index]["esminiSeconds"],
                        "observationIndex": found_index,
                    }
                )

        def clean_data(data):
            if isinstance(data, dict):
                return {k: clean_data(v) for k, v in data.items() if v != "-"}
            elif isinstance(data, list):
                return [clean_data(item) for item in data if item != "-"]
            elif isinstance(data, str):
                if data.strip() == "-":
                    return None
                return data
            elif isinstance(data, float) and (np.isnan(data) or np.isinf(data)):
                return None
            else:
                return data

        try:
            observations_response = requests.post(
                url=self.payload_api + "/observations/bulk",
                headers=self.headers,
                json=clean_data(self.data),
                verify=False,
            )
            observations_response.raise_for_status()
            print("successfully upload observations")
            # print("WATCH LAST OBSERVATION" * 100)
            # pprint(self.data[-1])
            # observations = observations_response.json()
            # if observations:
            #
            #     def patch_observations(url, data):
            #         try:
            #             response = requests.patch(
            #                 url=url,
            #                 json=data,
            #                 verify=False,
            #                 headers=self.headers,
            #             )
            #             response.raise_for_status()
            #             print("successfully patch observations to trials")
            #         except Exception as e:
            #             print(
            #                 "Patch Observations to Trials, Error:",
            #                 str(e),
            #             )
            #
            #     print("PATCH OBSERVATIONS TO TRIAL")
            #     observation_ids = [observation["id"] for observation in observations]
            #     print(len(observation_ids))
            #     patchData = {
            #         "observations": observation_ids,
            #     }
            #
            #     thread = threading.Thread(
            #         target=patch_observations,
            #         args=(self.payload_api + "/trials/{}".format(trial_id), patchData),
            #     )
            #     thread.start()
            #     time.sleep(10)
            #     print("SLEEP 10 SECS")
            #
            #     # pprint(patchData)
            #     # pprint(self.payload_api + "/trials/{}".format(trial_id))
            #     # try:
            #     #     response = requests.patch(
            #     #         url=self.payload_api + "/trials/{}".format(trial_id),
            #     #         json=patchData,
            #     #         verify=False,
            #     #         headers=self.headers,
            #     #     )
            #     #     response.raise_for_status()
            #     #     print("successfully patch observations to trials")
            #     # except Exception as e:
            #     #     print(
            #     #         "Patch Observations to Trials, Error:",
            #     #         str(e),
            #     #     )

        except Exception as e:
            print(
                "Failed to upload observations, Error:",
                str(e),
            )

        # try:
        #
        #     def patch_events(url, data):
        #         response = requests.patch(
        #             url=self.payload_api + "/trials/{}".format(trial_id),
        #             json=patchData,
        #             verify=False,
        #             headers=self.headers,
        #         )
        #         response.raise_for_status()
        #         print("successfully patch events to trials")
        #
        #     pprint(self.events)
        #
        #     print("PATCH EVENTS TO TRIAL")
        #     patchData = {"events": self.events}
        #     thread2 = threading.Thread(
        #         target=patch_events,
        #         args=(self.payload_api + "/trials/{}".format(trial_id), patchData),
        #     )
        #     thread2.start()
        #     time.sleep(3)
        #     print("SLEEP 3 SECS")
        #
        #     # patchData = {"events": self.events}
        #     # response = requests.patch(
        #     #     url=self.payload_api + "/trials/{}".format(trial_id),
        #     #     json=patchData,
        #     #     verify=False,
        #     #     headers=self.headers,
        #     # )
        #     # response.raise_for_status()
        #     # print("successfully patch events to trials")
        # except Exception as e:
        #     print(
        #         "Patch Events to Trials, Error:",
        #         str(e),
        #     )

        # return observations_response.json()

    def _reset(self):
        self.agent_size = {}
        self.data = []
        self.start_sampling_esmini_seconds = 0
        self._sample_num = 0
        self.end_scenario_message = None
        self.can_start_observation_sampling = False
        self.latest_observations = {}
        self.current_observation = {}
        self.ego_is_braking = False
        self.ego_is_accelerating = False
        self.ego_acceleration_queue = []
        self.xosc_events = []
        self.ego_events = []
        self.caution_events = []
        self.ego_current_steering_away_condition = None
        self.ego_current_acceleration_condition = None
        self.collided = False
        self.collided_observation_recorded = False
        self.events = []
        self.score = {}
        self.collided_agent = None

    def _can_start_sampling_callback(self, msg):
        # type: (Bool) -> None
        self.can_start_observation_sampling = msg.data

    def _end_scenario_callback(self, msg):
        self.end_scenario_message = msg

    def create_observations(self, df, agents):
        start_time = self.start_sampling_esmini_seconds
        print("start_time")
        print(start_time)
        self.data = []
        df = df[df["time"] > start_time - 0.01]
        times = df["time"].unique().tolist()
        sampling_period = 0.1
        period_start_time = start_time
        for i in range(1, len(times)):
            prevTime = float(times[i - 1])
            time = float(times[i])

            if i != len(times) - 1 and time - period_start_time < sampling_period:
                continue

            period_start_time = time

            row = df[df["time"] == time]
            prevRow = df[df["time"] == prevTime]

            egoRow = row[row["name"] == "Ego"]
            egoPrevRow = prevRow[prevRow["name"] == "Ego"]

            observation = {
                "egoSpeedLon": 0,
                "egoSpeedLat": 0,
                "time": float(time),
                "esminiSeconds": float(time),
                "egoX": float(egoRow["x"].values[0]),
                "egoY": float(egoRow["y"].values[0]),
                "egoYaw": float(egoRow["h"].values[0]),
                "egoYawRate": float(
                    (egoRow["h"].values[0] - egoPrevRow["h"].values[0])
                    / (float(time) - float(prevTime))
                ),
                "egoSpeed": float(egoRow["speed"].values[0]),
                "egoAcceleration": float(
                    (egoRow["speed"].values[0] - egoPrevRow["speed"].values[0])
                    / (float(time) - float(prevTime))
                ),
                "egoWidth": 2.2,
                "egoLength": 5.17,
                "egoRoadId": int(egoRow["roadId"].values[0]),
                "egoS": float(egoRow["s"].values[0]),
                "egoT": float(egoRow["t"].values[0]),
                "egoJunctionId": 0,
                "egoLaneId": int(egoRow["laneId"].values[0]),
                "egoLaneOffset": float(egoRow["offset"].values[0]),
                "egoLaneHeading": 0,
                "egoCurvature": 0,
                "egoSpeedCmd": 0,
                "egoSteerCmd": 0,
                "egoVelocityLong": None,
                "egoVelocityLat": None,
                "agents": [],
            }

            ego_pose = Pose()
            ego_pose.position.x = observation["egoX"]
            ego_pose.position.y = observation["egoY"]
            ego_pose.position.z = 0
            ego_pose.orientation = converter.EulerAngleToQuaternion(
                [0.0, 0.0, observation["egoSpeed"]]
            )
            ego_velocity = Vector3()
            ego_velocity.x = observation["egoSpeed"] * math.cos(observation["egoYaw"])
            ego_velocity.y = observation["egoSpeed"] * math.sin(observation["egoYaw"])
            ego_local_velocity = transform.global_velocity_to_local_velocity(
                ego_pose, ego_velocity
            )

            for agent_name in agents:
                if agent_name == "Ego":
                    continue

                agentRow = row[row["name"] == agent_name]
                agentPrevRow = prevRow[prevRow["name"] == agent_name]

                agent_observation = {
                    "name": agent_name,
                    "time": time,
                    "x": float(agentRow["x"].values[0]),
                    "y": float(agentRow["y"].values[0]),
                    "speed": float(agentRow["speed"].values[0]),
                    "acceleration": float(
                        (agentRow["speed"].values[0] - agentPrevRow["speed"].values[0])
                        / (float(time) - float(prevTime))
                    ),
                    "yaw": float(agentRow["h"].values[0]),
                    "yawRate": float(
                        (agentRow["h"].values[0] - agentPrevRow["h"].values[0])
                        / (float(time) - float(prevTime))
                    ),
                    "relativeDistance": None,
                    "width": self.agent_size[agent_name]["width"],
                    "length": self.agent_size[agent_name]["length"],
                    "height": 1.0,
                    "ttc": None,
                    "dce": None,
                    "collisionRisk": None,
                    "ttce": None,
                    "pathIntersected": 0,
                    "spret": 0,
                    "accReq": 0,
                    "roadId": 0,
                    "s": 0,
                    "t": 0,
                    "junctionId": 0,
                    "laneId": 0,
                    "laneOffset": 0,
                    "laneHeading": 0,
                    "curvature": 0,
                    "velocityLong": None,
                    "velocityLat": None,
                    "distLon": 0,
                    "distRightLat": 0,
                    "distLeftLat": 0,
                    "speedLat": 0,
                    "speedLon": 0,
                    "situationType": 0,
                    "rssRatio": None,
                    "isRssSafe": None,
                    "ttc1D": None,
                }

                ego_heading = heading_vector_from_yaw(observation["egoYaw"])
                agent_heading = heading_vector_from_yaw(agent_observation["yaw"])
                pair_sample = pd.DataFrame(
                    {
                        "x_i": [observation["egoX"]],
                        "y_i": [observation["egoY"]],
                        "vx_i": [observation["egoSpeed"] * ego_heading[0]],
                        "vy_i": [observation["egoSpeed"] * ego_heading[1]],
                        "hx_i": [ego_heading[0]],
                        "hy_i": [ego_heading[1]],
                        "speed_i": [observation["egoSpeed"]],
                        "length_i": [observation["egoLength"]],
                        "width_i": [observation["egoWidth"]],
                        "x_j": [agent_observation["x"]],
                        "y_j": [agent_observation["y"]],
                        "vx_j": [agent_observation["speed"] * agent_heading[0]],
                        "vy_j": [agent_observation["speed"] * agent_heading[1]],
                        "hx_j": [agent_heading[0]],
                        "hy_j": [agent_heading[1]],
                        "length_j": [agent_observation["length"]],
                        "width_j": [agent_observation["width"]],
                        "speed_j": [agent_observation["speed"]],
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

                nearest_point_on_ego, nearest_point_on_agent = nearest_points(
                    ego_polygon, agent_polygon
                )
                nearest_distance = nearest_point_on_ego.distance(nearest_point_on_agent)
                agent_observation["relativeDistance"] = nearest_distance

                agent_pose = Pose()
                agent_pose.position.x = agent_observation["x"]
                agent_pose.position.y = agent_observation["y"]
                agent_pose.position.z = 0
                agent_pose.orientation = converter.EulerAngleToQuaternion(
                    [0.0, 0.0, agent_observation["yaw"]]
                )
                local_pose = transform.global_pose_to_local_pose(
                    ego_pose, agent_pose
                )  # type: Pose

                agent_velocity = Vector3()
                agent_velocity.x = agent_observation["speed"] * math.cos(
                    agent_observation["yaw"]
                )
                agent_velocity.y = agent_observation["speed"] * math.sin(
                    agent_observation["yaw"]
                )
                agent_local_velocity = transform.global_velocity_to_local_velocity(
                    ego_pose, agent_velocity
                )

                agent_observation["localX"] = local_pose.position.x
                agent_observation["localY"] = local_pose.position.y
                agent_observation["localYaw"] = converter.QuaternionToVector3(
                    local_pose.orientation
                ).z
                agent_observation["relativeYawRate"] = (
                    agent_observation["yawRate"] - observation["egoYawRate"]
                )

                agent_observation["relativeVelocityX"] = (
                    agent_local_velocity.x - ego_local_velocity.x
                )
                agent_observation["relativeVelocityY"] = (
                    agent_local_velocity.y - ego_local_velocity.y
                )

                (
                    ego_front_i1,
                    ego_front_i2,
                    ego_back_i3,
                    ego_back_i4,
                    agent_front_j1,
                    agent_front_j2,
                    agent_back_j3,
                    agent_back_j4,
                ) = getpoints(pair_sample)

                ego_front_i1 = ego_front_i1.flatten()
                ego_front_i2 = ego_front_i2.flatten()
                ego_back_i3 = ego_back_i3.flatten()
                ego_back_i4 = ego_back_i4.flatten()

                agent_front_j1 = agent_front_j1.flatten()
                agent_front_j2 = agent_front_j2.flatten()
                agent_back_j3 = agent_back_j3.flatten()
                agent_back_j4 = agent_back_j4.flatten()

                ego_vehicle_polygon = Polygon(
                    [ego_front_i1, ego_front_i2, ego_back_i4, ego_back_i3]
                )
                agent_vehicle_polygon = Polygon(
                    [agent_front_j1, agent_front_j2, agent_back_j4, agent_back_j3]
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
                ) = getprojpoints(pair_sample, self.ttc_max)

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

                # Find the intersection of the two polygons
                intersection = ego_polygon.intersection(agent_polygon)
                agent_observation["pathIntersected"] = int(not intersection.is_empty)

                observation["agents"].append(agent_observation)

            self.data.append(observation)

        # pprint(self.data[-5:])

    def _agent_states_callback(self, msg):
        # type: (AgentStates) -> None | str
        self.current_agent_states = msg

        if not self.can_start_observation_sampling:
            return

        if self.current_agent_states is None:
            print("msg is None")

        agent_states = self.current_agent_states  # type: AgentStates

        if agent_states.agents is None:
            print("agent states agents are None")

        seconds = 0
        ego_state = None  # type: Optional[AgentState]
        for agent in agent_states.agents:
            agent = agent  # type: AgentState
            seconds = agent.seconds
            if seconds != 0:
                break

        # print("seconds")
        # print(seconds)
        # print("start sampling seconds")
        # print(self.start_sampling_esmini_seconds)
        if (
            self.can_start_observation_sampling
            and self.start_sampling_esmini_seconds == 0
        ):
            print("SET START SAMPLING SECONDS" * 30)
            print(seconds)
            self.start_sampling_esmini_seconds = seconds
            for agent in agent_states.agents:
                self.agent_size[agent.name] = {
                    "width": agent.width,
                    "length": agent.length,
                }
            pprint(self.agent_size)
            print("SET START SAMPLING SECONDS" * 30)

    def _car_state_callback(self, msg):
        # type: (CarState) -> None
        self.current_car_state = msg

    def _speed_cmd_callback(self, msg):
        # type: (speed_cmd) -> None
        self.current_speed_cmd = msg

    def _steer_cmd_callback(self, msg):
        # type: (steer_cmd) -> None
        self.current_steer_cmd = msg

    def _esmini_event_callback(self, msg):
        # type: (String) -> None
        if not msg.data or "Teleport" in msg.data or not self.current_observation:
            return
        print("SIMULATION EVENT {}".format(msg.data))
        self.xosc_events.append(
            {
                "name": msg.data,
                "time": self.current_observation["time"],
                "esminiSeconds": self.current_observation["esminiSeconds"],
                "observation": self.current_observation,
            }
        )

    def _collision_callback(self, msg):
        # type: (CollisionProfile) -> None
        frame_id = msg.header.frame_id
        if "esmini_collision" in frame_id:

            self.collided = True

            agentName = frame_id.split("/")[1]
            self.collided_agent = agentName

            print("EGO COLLIDE WITH {}".format(agentName))

            # if self.current_agent_states:
            #     print("GET LATEST COLLISION OBSERVATION" * 100)
            #     print(self.latest_observations)
            #     msg = self._agent_states_callback(self.current_agent_states)
            #     print("GET LATEST COLLISION OBSERVATION MESSAGE" * 100)
            #     print(msg)
            #     print("LATEST COLLISION OBSERVATION")
            #     pprint(self.latest_observations)
            #     self.collided_observation_recorded = True

            self.events.append(
                {
                    "name": "collisionWith{}".format(agentName),
                    "observation": self.current_observation,
                    # "time": self.current_observation["time"],
                    # "esminiSeconds": self.current_observation["esminiSeconds"],
                    "time": 0,
                    "esminiSeconds": 0,
                    "observationIndex": len(self.data) - 1,
                }
            )
