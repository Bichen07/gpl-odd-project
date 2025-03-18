#!/usr/bin/env python
import rospy
import yaml
import json
from math import atan2, radians
import pandas as pd
from scipy.spatial import cKDTree
from itri_msgs.msg import CarState, steer_cmd
from scenario_classification.msg import TagLateralActivity
from scenario_classification.msg import ClassificationObjectArray


class IdentifierLateralActivity:
    def __init__(self, configs):
        self.configs = configs
        self._ego_steer_angle = 0.0
        self._ego_state = CarState()
        self._yaw_rate_history_tracked = {} # type: dict[int, list[float]]
        self._classification_objects_subscriber = rospy.Subscriber(
            "classification_objects", ClassificationObjectArray,
            self._classification_objects_callback)
        self._steer_cmd_subscriber = rospy.Subscriber(
            "steer_cmd", steer_cmd, self._steer_cmd_callback)
        self._car_state_subscriber = rospy.Subscriber(
            "car_state", CarState, self._car_state_callback)

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

        self.waypoints = pd.DataFrame(waypoints) # type: pd.DataFrame
        self.waypoints_pos = [(x, y) for x, y in zip(
            self.waypoints['x'], self.waypoints['y'])]
        self.waypoints_pos_kdtree = cKDTree(self.waypoints_pos)

        lanes = []
        with open(data_dir + '/lanes_info.json'.format(route), 'r') as f:
            data = json.load(f)
            lanes = data['lanes']

        is_next_counter = {}
        for lane in lanes:
            if not lane['next_clane']:
                continue
            for next_lane_id in lane['next_clane']:
                next_lane_id = next_lane_id
                is_next_counter.setdefault(next_lane_id, 0)
                is_next_counter[next_lane_id] += 1
        is_junction = set()
        for lane in lanes:
            if not lane['next_clane']:
                continue
            if len(lane['next_clane']) > 1:
                for next_lane_id in lane['next_clane']:
                    is_junction.add(next_lane_id)
            for next_lane_id in lane['next_clane']:
                if is_next_counter[next_lane_id] > 1:
                    is_junction.add(lane['id'])

        self.junctions = {}
        for lane_id in is_junction:
            lane_wps = self.waypoints[self.waypoints['lane_id'] == lane_id]
            start_1 = lane_wps['point_index'].nsmallest(2).values[0]
            start_2 = lane_wps['point_index'].nsmallest(2).values[1]
            end_1 = lane_wps['point_index'].nlargest(2).values[1]
            end_2 = lane_wps['point_index'].nlargest(2).values[0]
            a = {
                'x': lane_wps.iloc[end_2]['x'] - lane_wps.iloc[end_1]['x'],
                'y': lane_wps.iloc[end_2]['y'] - lane_wps.iloc[end_1]['y'],
            }
            b = {
                'x': lane_wps.iloc[start_2]['x'] - lane_wps.iloc[start_1]['x'],
                'y': lane_wps.iloc[start_2]['y'] - lane_wps.iloc[start_1]['y'],
            }
            angle = atan2(a['x']*b['y'] - a['y']*b['x'],
                          a['x']*b['x'] + a['y']*b['y'])
            self.junctions[lane_id] = 'straight'
            if abs(angle) > radians(45):
                self.junctions[lane_id] = 'right' if angle > 0 else 'left'

    def IdentifyTag(self, c_obj):
        obj_x = 0
        obj_y = 0
        ego_pos = self._ego_state.pose.pose.position
        if c_obj.label == "ego":
            obj_x = ego_pos.x
            obj_y = ego_pos.y
        else:
            rel_pos = c_obj.relative_poses[-1].pose.position
            obj_x = ego_pos.x + rel_pos.x
            obj_y = ego_pos.y + rel_pos.y

        _, nearest_idx = self.waypoints_pos_kdtree.query((obj_x, obj_y), k=1)
        curr_lane_id = int(self.waypoints.iloc[nearest_idx]['lane_id'])

        tag = TagLateralActivity()
        tag.primary_category = TagLateralActivity.PRIMARY_GOING_STRAIGHT
        if curr_lane_id in self.junctions:
            if c_obj.label == "ego":
                tag = self._identify_ego_tag(c_obj, self._ego_steer_angle,
                                             curr_lane_id)
            else:
                tag = self._identify_agent_tag(c_obj,
                                               self._yaw_rate_history_tracked)
        return tag

    def _identify_ego_tag(self, c_obj, ego_steer_angle, curr_lane_id):
        tag = TagLateralActivity()
        tag.primary_category = TagLateralActivity.PRIMARY_GOING_STRAIGHT
        if ego_steer_angle == None:
            return tag
        if abs(ego_steer_angle) > self.configs['EGO_MIN_STEER_ANGLE'] \
                and self.junctions[curr_lane_id] != "straight":
            if ego_steer_angle < 0 and self.junctions[curr_lane_id] == "left":
                tag.primary_category = TagLateralActivity.PRIMARY_TURNING
                tag.secondary_category = TagLateralActivity.SECONDARY_LEFT
            elif ego_steer_angle > 0 \
                    and self.junctions[curr_lane_id] == "right":
                tag.primary_category = TagLateralActivity.PRIMARY_TURNING
                tag.secondary_category = TagLateralActivity.SECONDARY_RIGHT
        return tag

    def _identify_agent_tag(self, c_obj, yaw_rate_history_tracked):
        tag = TagLateralActivity()
        if not c_obj.id in yaw_rate_history_tracked:
            return tag
        sampling_width = self.configs['YAWRATE_SAMPLING_WIDTH']
        min_turning_yaw_rate = self.configs['MIN_TURNING_YAW_RATE']
        moving_average = sum(yaw_rate_history_tracked[c_obj.id]) \
                         / sampling_width
        if abs(moving_average) <= min_turning_yaw_rate:
            tag.primary_category = TagLateralActivity.PRIMARY_GOING_STRAIGHT
        else:
            tag.primary_category = TagLateralActivity.PRIMARY_SWERVING \
                if self._is_swerving(c_obj) \
                else TagLateralActivity.PRIMARY_TURNING
            tag.secondary_category = TagLateralActivity.SECONDARY_LEFT \
                if moving_average > 0 \
                else TagLateralActivity.SECONDARY_RIGHT
        return tag

    def _is_swerving(self, c_obj):
        vx = c_obj.velocities[-1].twist.linear.x
        vy = c_obj.velocities[-1].twist.linear.y
        velocity_length_square = vx * vx + vy * vy
        return velocity_length_square \
            > pow(self.configs['MIN_SWERVING_SPEED'], 2)

    def _steer_cmd_callback(self, msg):
        # type: (IdentifierLateralActivity, steer_cmd) -> None
        self._ego_steer_angle = msg.angle

    def _car_state_callback(self, msg):
        # type: (IdentifierLateralActivity, CarState) -> None
        self._ego_state = msg

    def _classification_objects_callback(self, msg):
        # type: (IdentifierLateralActivity, ClassificationObjectArray) -> None
        if msg.objects and len(msg.objects) > 0:
            detected_ids = set()
            for c_obj in msg.objects:
                detected_ids.add(c_obj.id)
                vx = c_obj.velocities[-1].twist.linear.x
                vy = c_obj.velocities[-1].twist.linear.y
                velocity_length_square = vx * vx + vy * vy
                yaw_rate = c_obj.velocities[-1].twist.angular.z
                if abs(yaw_rate) > self.configs['MAX_POSSIBLE_YAW_RATE'] \
                        or velocity_length_square < \
                            self.configs['ASSUME_MOVING_SPEED'] ** 2:
                    yaw_rate = 0
                self._yaw_rate_history_tracked.setdefault(c_obj.id, [])
                self._yaw_rate_history_tracked[c_obj.id].append(yaw_rate)
            delete_keys = set(self._yaw_rate_history_tracked.keys()) \
                          - detected_ids
            for key, yaw_rates in self._yaw_rate_history_tracked.items():
                if len(yaw_rates) > self.configs['YAWRATE_SAMPLING_WIDTH']:
                    yaw_rates.pop(0)
            for key in delete_keys:
                if key in self._yaw_rate_history_tracked:
                    del self._yaw_rate_history_tracked[key]
