#!/usr/bin/env python
from scenario_classification.msg import TagInitialState
from scenario_classification.msg import ClassificationObject
import numpy as np

from cython_simulation_utils import cy_converter as converter
from utils import get_speed_square

class IdentifierInitialState:
    def __init__(self, config):
        self.config = config

    def IdentifyTag(self, c_obj, ego_size):
        """
        Args:
            msg: scenario_classification/ClassificationObject
        Returns:
            scenario_classification/TagInitialState
        """
        tag = TagInitialState()

        lateral_position = self._get_lateral_position(c_obj, ego_size.y)

        tag.irrelevant, tag.direction = self._get_direction(c_obj, lateral_position)
        if tag.irrelevant == TagInitialState.IRRELEVANT_FALSE:
            tag.lateral_position = lateral_position
            tag.dynamics = self._get_dynamics(c_obj)
            tag.longitudinal_position = self._get_longitudinal_position(c_obj, ego_size.x)

        return tag

    def _get_direction(self, c_obj, lateral_tag):
        heading = converter.QuaternionToVector3(c_obj.relative_poses[-1].pose.orientation).z
        while heading > np.pi: heading -= 2*np.pi
        while heading < -np.pi: heading += 2*np.pi
        if abs(heading) <= self.config['MAX_RELEVANT_SAME_DIRECTION_ANGLE']:
            return TagInitialState.IRRELEVANT_FALSE, \
                   TagInitialState.DIRECTION_SAME_AS_EGO
        elif abs(heading) >= self.config['MIN_RELEVANT_ON_COMING_ANGLE']:
            return TagInitialState.IRRELEVANT_FALSE, \
                   TagInitialState.DIRECTION_ON_COMING
        else:
            vel_to_left = c_obj.local_velocities[-1].twist.linear.y > 0
            pos_at_left = lateral_tag == TagInitialState.LATERAL_POSITION_LEFT_OF_EGO
            if vel_to_left and pos_at_left:
                return TagInitialState.IRRELEVANT_TRUE, \
                       TagInitialState.DIRECTION_UNKNOWN
            elif not vel_to_left and not pos_at_left:
                return TagInitialState.IRRELEVANT_TRUE, \
                       TagInitialState.DIRECTION_UNKNOWN
            else:
                return TagInitialState.IRRELEVANT_FALSE, \
                       TagInitialState.DIRECTION_CROSSING

    def _get_dynamics(self, c_obj):
        if get_speed_square(c_obj.local_velocities[-1]) \
                < self.config["SPEED_DIFFERENCE_TOLERANCE"] ** 2:
            return TagInitialState.DYNAMICS_STANDING_STILL
        else:
            return TagInitialState.DYNAMICS_MOVING

    def _get_lateral_position(self, c_obj, ego_width):
        lat_assume_same_ratio = self.config["LATERAL_ASSUME_SAME_LANE_RATIO"]
        if abs(c_obj.relative_poses[-1].pose.position.y) < (c_obj.size.y + ego_width) / 2.0 * lat_assume_same_ratio:
            return TagInitialState.LATERAL_POSITION_SAME_LANE
        elif c_obj.relative_poses[-1].pose.position.y > 0:
            return TagInitialState.LATERAL_POSITION_LEFT_OF_EGO
        else:
            return TagInitialState.LATERAL_POSITION_RIGHT_OF_EGO

    def _get_longitudinal_position(self, c_obj, ego_length):
        long_assume_side_ratio = self.config["LONGITUDINAL_ASSUME_SIDE_RATIO"]
        assume_side_length = (c_obj.size.x + ego_length) / 2.0 * long_assume_side_ratio
        if abs(c_obj.relative_poses[-1].pose.position.x) < assume_side_length:
            return TagInitialState.LONGITUDINAL_POSITION_SIDE_OF_EGO
        elif c_obj.relative_poses[-1].pose.position.x > 0:
            return TagInitialState.LONGITUDINAL_POSITION_IN_FRONT_OF_EGO
        else:
            return TagInitialState.LONGITUDINAL_POSITION_REAR_OF_EGO
