#!/usr/bin/python
# -*- coding: utf-8 -*-
import os
import csv
import math
import numpy as np
import pandas as pd
import pickle
import rospy
import time
import yaml
import json
from scipy.spatial import cKDTree
from cython_simulation_utils import cy_converter as converter
from collections import OrderedDict
from itri_msgs.msg import CarState
from scenario_classification.msg import ClassificationObjectArray
from constants import *
import timeit


class FeatureMatcher:

    def __init__(self):
        self._car_state_subscriber = rospy.Subscriber('car_state',
                                                      CarState, self._car_state_callback)
        self._ego_speed = 0
        self._ego_acc = 0
        self._ego_pose = 0
        self._features = {}
        self._metrics = OrderedDict()
        self._record = OrderedDict()
        self._scene_id = 0
        self._threshold = 0
        self._unsafe_history = []
        self._unsafe_profile = {}
        self._model = self._load_file(FOLDER_PATH, MODEL_NAME)
        self._scaler = self._load_file(FOLDER_PATH, SCALER_NAME)
        self.value = {}
        self.safety_metrics = {}
        self._reset_features()
        self._reset_safety_metrics()

        route = ''
        with open('/repository/vehicle-configuration/'
                  'pacifica-1/parameters.yaml', 'r') as f:
            params = yaml.safe_load(f)
            route = params['route_mission_handler']['route']

        data_dir = '/data/semantic-maps/data/{}'.format(route)

        data = {}
        with open(data_dir + '/waypoints.json', 'r') as f:
            data = json.load(f)
        waypoints = {
            'x': [],
            'y': [],
            'width': [],
            'lane_id': [],
            'point_index': []
        }
        for info in data['waypoints']:
            i = 0
            for index, point in enumerate(info['points']):
                if index % 3 == 0:
                    waypoints['x'].append(point['x'])
                    waypoints['y'].append(point['y'])
                    waypoints['width'].append(point['width'])
                    waypoints['lane_id'].append(info['lane_id'])
                    waypoints['point_index'].append(i)
                    i += 1

        self.waypoints = pd.DataFrame(waypoints)  # type: pd.DataFrame
        self.waypoints_pos = [(x, y) for x, y in zip(
            self.waypoints['x'], self.waypoints['y'])]
        self.waypoints_pos_kdtree = cKDTree(self.waypoints_pos)

        self.intersections = {}
        with open(data_dir + '/intersections.json', 'r') as f:
            self.intersections = json.load(f)

    def _reset_features(self):
        self._record = OrderedDict([
            ('ego_position_x', float('nan')),
            ('ego_position_y', float('nan')),
            ('ego_speed', float('nan')),
            ('ego_acceleration', float('nan')),
            ('agent_relative_orientation', float('nan')),
            ('agent_relative_angular_velocity', float('nan')),
            ('agent_relative_velocity_x', float('nan')),
            ('agent_relative_velocity_y', float('nan')),
            ('agent_relative_position_x', float('nan')),
            ('agent_relative_position_y', float('nan')),
            ('agent_relative_position_x_next_1', float('nan')),
            ('agent_relative_position_y_next_1', float('nan')),
            ('agent_relative_position_x_next_2', float('nan')),
            ('agent_relative_position_y_next_2', float('nan')),
        ])

    def _reset_safety_metrics(self):
        self._metrics = OrderedDict([
            ('ttc', float('nan')),
            ('ttc_result', float('nan')),
            ('time_gap', float('nan')),
            ('time_gap_result', float('nan')),
            ('safe_longitudinal_dist', float('nan')),
            ('longitudinal_result', float('nan')),
            ('safe_lateral_dist', float('nan')),
            ('lateral_result', float('nan')),
            ('rss_result', float('nan')),
        ])

    def _load_file(self, folder_path, file_name):
        file_path = os.path.join(folder_path, file_name)
        file = pickle.load(open(file_path, 'rb'))
        return file

    def _get_features(self, c_obj):

        self._record['ego_position_x'] = self._ego_pose.x
        self._record['ego_position_y'] = self._ego_pose.y
        self._record['ego_speed'] = self._ego_speed
        self._record['ego_acceleration'] = self._ego_acc
        yaw = \
            converter.QuaternionToVector3(
                c_obj.relative_poses[-1].pose.orientation).z
        relative_yaw_rate = c_obj.velocities[-1].twist.angular.z
        self._record['agent_relative_orientation'] = yaw
        self._record['agent_relative_angular_velocity'] = \
            relative_yaw_rate

        relative_position = c_obj.relative_poses[-1].pose.position
        relative_velocity = c_obj.relative_velocities[-1].twist.linear
        self._record['agent_relative_velocity_x'] = relative_velocity.x
        self._record['agent_relative_velocity_y'] = relative_velocity.y
        self._record['agent_relative_position_x'] = relative_position.x
        self._record['agent_relative_position_y'] = relative_position.y

        self._record['agent_relative_position_x_next_1'] = \
            relative_position.x + relative_velocity.x * DELTATIME
        self._record['agent_relative_position_y_next_1'] = \
            relative_position.y + relative_velocity.y * DELTATIME

        self._record['agent_relative_position_x_next_2'] = \
            relative_position.x + relative_velocity.x * DELTATIME * 2
        self._record['agent_relative_position_y_next_2'] = \
            relative_position.y + relative_velocity.y * DELTATIME * 2

        return self._record

    def _get_safety_metrics(self, c_obj):
        time_gap = float('nan')
        ttc = float('nan')
        safe_longitudinal_dist = float('nan')
        longitudinal_result = float('nan')
        safe_lateral_dist = float('nan')
        lateral_result = float('nan')
        intersect_point = {
            'x': float('nan'),
            'y': float('nan'),
            'z': float('nan')
        }

        agent_velocity_on_ego = c_obj.velocities[-1].twist.linear
        relative_position = c_obj.relative_poses[-1].pose.position
        relative_velocity = c_obj.relative_velocities[-1].twist.linear
        agent_position_x = self._ego_pose.x - relative_position.y
        agent_position_y = self._ego_pose.y + relative_position.x
        ego_speed_x = abs(self._ego_velocity.x)
        ego_speed_y = abs(self._ego_velocity.y)
        same_direction = True if self._ego_velocity.x * \
            agent_velocity_on_ego.x > 0 else False

        _, nearest_idx = self.waypoints_pos_kdtree.query(
            (self._ego_pose.x, self._ego_pose.y), k=1)
        ego_lane_id = int(self.waypoints.iloc[nearest_idx]['lane_id'])
        _, nearest_idx = self.waypoints_pos_kdtree.query(
            (agent_position_x, agent_position_y), k=1)
        agent_lane_id = int(self.waypoints.iloc[nearest_idx]['lane_id'])

        ego_lane_wps = self.waypoints[self.waypoints['lane_id'] == ego_lane_id]
        lane_width = ego_lane_wps['width'].nsmallest(2).values[0]
        same_lane = True if ego_lane_id == agent_lane_id else False
        at_intersection = False
        for intersection in self.intersections['intersections']:
            if not same_lane and agent_lane_id in intersection['lanes'] and ego_lane_id in intersection['lanes']:
                intersect_point = intersection['center_point']
                at_intersection = True

        if at_intersection:
            ego_dist_to_intersect_x = abs(
                self._ego_pose.x - intersect_point['x'])

            safe_longitudinal_dist = abs(ego_speed_x * RESPONSE_TIME +
                                         (0.5 * MAX_ACC * RESPONSE_TIME ** 2) + ((ego_speed_x +
                                                                                  RESPONSE_TIME * MAX_ACC) ** 2 / (2.0 * MIN_BRAKE)))

            longitudinal_result = (-1 if ego_dist_to_intersect_x
                                   < safe_longitudinal_dist else 0)

            v1 = ego_speed_y if relative_position.y < 0 else agent_velocity_on_ego.y
            v1_rho = v1 - RESPONSE_TIME * LAT_MAX_ACC
            v2 = agent_velocity_on_ego.y if v1 == ego_speed_y else ego_speed_y
            v2_rho = v2 + RESPONSE_TIME * LAT_MAX_ACC
            x1_min = (v1 + v1_rho) * RESPONSE_TIME / 2.0 + \
                (v1_rho ** 2 / (2.0 * LAT_MIN_BRAKE))
            x1_max = (v1 + v1_rho) * RESPONSE_TIME / 2.0 - \
                (v1_rho ** 2 / (2.0 * LAT_MIN_BRAKE))
            x2_min = (v2 + v2_rho) * RESPONSE_TIME / 2.0
            - (v2_rho ** 2 / (2.0 * LAT_MIN_BRAKE))
            x2_max = (v2 + v2_rho) * RESPONSE_TIME / 2.0
            + (v2_rho ** 2 / (2.0 * LAT_MIN_BRAKE))
            safe_lateral_dist = lane_width
            lateral_result = (-1 if abs(min(x1_min, x1_max) -
                              max(x2_min, x2_max)) < safe_lateral_dist else 0)
        elif same_lane:
            if same_direction:
                safe_longitudinal_dist = max(ego_speed_x * RESPONSE_TIME
                                             + (0.5 * MAX_ACC *
                                                RESPONSE_TIME ** 2)
                                             + (ego_speed_x +
                                                 RESPONSE_TIME * MAX_ACC) ** 2
                                             / (2.0 * MIN_BRAKE) - (agent_velocity_on_ego.x ** 2 / (2.0 * MAX_BRAKE)), 0)
                if relative_position.x > 0 and relative_velocity.x < 0:
                    time_gap = relative_position.x / ego_speed_x
                    ttc = math.sqrt(relative_position.x ** 2
                                    + relative_position.y ** 2) / math.sqrt(relative_velocity.x ** 2 + relative_velocity.y ** 2)
            else:
                v1 = self._ego_velocity.x if self._ego_velocity.x >= 0 else agent_velocity_on_ego.x
                v1_rho = v1 + RESPONSE_TIME * MAX_ACC
                v2 = agent_velocity_on_ego.x if v1 == self._ego_velocity.x else ego_speed_x
                v2_rho = abs(v2) + RESPONSE_TIME * MAX_ACC
                safe_longitudinal_dist = abs((v1 + v1_rho)*RESPONSE_TIME/2.0 + v1_rho**2/(
                    2.0*MIN_BRAKE_CORRECT) + (abs(v2) + v2_rho)*RESPONSE_TIME/2.0 + v2_rho**2/(2.0*MIN_BRAKE))

                if relative_position.x > 0:
                    time_gap = relative_position.x / ego_speed_x
                    if (relative_velocity.x != 0 or relative_velocity.y != 0):
                        ttc = math.sqrt(relative_position.x ** 2
                                        + relative_position.y ** 2) \
                            / math.sqrt(relative_velocity.x ** 2
                                        + relative_velocity.y ** 2)
            v1 = ego_speed_y if relative_position.y < 0 else abs(
                agent_velocity_on_ego.y)
            v1_rho = v1 + RESPONSE_TIME * LAT_MAX_ACC
            v2 = abs(agent_velocity_on_ego.y) if v1 == ego_speed_y else ego_speed_y
            v2_rho = v2 - RESPONSE_TIME * LAT_MAX_ACC
            safe_lateral_dist = lane_width + max((v1 + v1_rho) * RESPONSE_TIME / 2.0
                                                 + (v1_rho ** 2 /
                                                    (2.0 * LAT_MIN_BRAKE))
                                                 - ((v2 + v2_rho) * RESPONSE_TIME / 2.0
                                                    - (v2_rho ** 2 / (2.0 * LAT_MIN_BRAKE))),
                                                 0)
            longitudinal_result = (-1 if abs(relative_position.x)
                                   < safe_longitudinal_dist else 0)
            lateral_result = (-1 if abs(relative_position.y)
                              < safe_lateral_dist else 0)

        self._metrics['ttc'] = ttc
        if not math.isnan(ttc):
            self._metrics['ttc_result'] = -1 if ttc < TTC_THRESHOLD else 0
        self._metrics['time_gap'] = time_gap
        if not math.isnan(time_gap):
            self._metrics['time_gap_result'] = - \
                1 if time_gap < TIME_GAP_THRESHOLD else 0
        self._metrics['safe_longitudinal_dist'] = safe_longitudinal_dist
        self._metrics['safe_lateral_dist'] = safe_lateral_dist
        self._metrics['longitudinal_result'] = longitudinal_result
        self._metrics['lateral_result'] = lateral_result
        self._metrics['rss_result'] = (-1 if longitudinal_result == -1
                                       and lateral_result == -1 else 0)
        return self._metrics

    def run(self, classification_objects, matched_category_indices):
        try:
            self._unsafe_profile.clear()
            self.value.clear()

            if len(matched_category_indices.keys()) > 0:
                self._scene_id += 1
                self._start_time = time.time()
                print '[Feature Matcher] Start loading matched objects...'
                for c_id, indices in matched_category_indices.items():
                    c_obj = classification_objects[c_id]
                    test_df = self._get_features(c_obj)
                    self.safety_metrics[c_id] = self._get_safety_metrics(c_obj)
                    X_test = pd.DataFrame(test_df, index=[0])
                    X_test = self._scaler.transform(X_test)
                    y_test = float(self._model.predict(X_test)[0])
                    print "[Feature Matcher] Object {}'s value: {}".format(c_id,
                                                                           y_test)
                    self._value_check(y_test)
                    if y_test < self._threshold:
                        self._unsafe_profile[c_id] = y_test
                    self._features[c_id] = test_df
                    self.value[c_id] = y_test
                    self._reset_features()
                    self._reset_safety_metrics()
                total_unsafe_count = len(self._unsafe_profile)
                if total_unsafe_count > 0:
                    self._update_unsafe_history()
                print '[Feature Matcher] Unsafe objects: {}'.format(total_unsafe_count)
                feature_duration = time.time() - self._start_time
                print '[Feature Matcher] Time: {}\n'.format(feature_duration)
        except EOFError:
            pass

    def _value_check(self, value):
        assert value <= 0 and value >= -1, \
            '[Feature Matcher] value between -1 and 0 expected, got: {}'.format(
                value)

    def _update_unsafe_history(self):
        history = {}
        history['scene_id'] = self._scene_id
        history['record_time'] = self._start_time
        history['data'] = self._unsafe_profile
        self._unsafe_history.append(history)

    def _car_state_callback(self, msg):
        vx = msg.twist.twist.linear.x
        vy = msg.twist.twist.linear.y
        self._ego_velocity = msg.twist.twist.linear
        self._ego_speed = math.sqrt(vx ** 2 + vy ** 2)
        self._ego_acc = msg.acceleration
        self._ego_pose = msg.pose.pose.position
