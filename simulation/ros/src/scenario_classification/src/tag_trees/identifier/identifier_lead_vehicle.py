#!/usr/bin/env python
from scenario_classification.msg import TagLeadVehicle
from scenario_classification.msg import ClassificationObject
import numpy as np

class IdentifierLeadVehicle:
    def __init__(self, configs):
        self.configs = configs

    def IdentifyTag(self, c_obj, ego_size):
        """
        Args:
            msg: scenario_classification/ClassificationObject
        Returns:
            scenario_classification/TagLeadVehicle
        """
        tag = TagLeadVehicle()
        ego_width = ego_size.y
        vx_loc_is_zero = abs(c_obj.local_velocities[-1].twist.linear.x) < self.configs["SPEED_DIFFERENCE_TOLERANCE"]
        vy_loc_is_zero = abs(c_obj.local_velocities[-1].twist.linear.y) < self.configs["SPEED_DIFFERENCE_TOLERANCE"]
        if self._check_cut_in(c_obj, ego_size, vx_loc_is_zero, vy_loc_is_zero):
            tag.primary_category = TagLeadVehicle.PRIMARY_APPEARING
            tag.secondary_category = TagLeadVehicle.SECONDARY_CUTTING_IN
        elif self._is_leader(c_obj, ego_width):
            if self._check_cut_out(c_obj, ego_width, vx_loc_is_zero, vy_loc_is_zero):
                tag.primary_category = TagLeadVehicle.PRIMARY_DISAPPEARING
                tag.secondary_category = TagLeadVehicle.SECONDARY_CUTTING_OUT
            else:
                if vx_loc_is_zero and vy_loc_is_zero:
                    if c_obj.relative_velocities[-1].twist.linear.x < self.configs["SPEED_DIFFERENCE_TOLERANCE"]:
                        tag.primary_category = TagLeadVehicle.PRIMARY_APPEARING
                        tag.secondary_category = TagLeadVehicle.SECONDARY_GAP_CLOSING
                    elif c_obj.relative_velocities[-1].twist.linear.x > self.configs["SPEED_DIFFERENCE_TOLERANCE"]:
                        tag.primary_category = TagLeadVehicle.PRIMARY_DISAPPEARING
                        tag.secondary_category = TagLeadVehicle.SECONDARY_GAP_OPENING
                else:
                    if c_obj.relative_velocities[-1].twist.linear.x < - self.configs["ASSUME_APPEAR_OR_DISAPPEAR"]:
                        tag.primary_category = TagLeadVehicle.PRIMARY_APPEARING
                        tag.secondary_category = TagLeadVehicle.SECONDARY_GAP_CLOSING
                    elif c_obj.relative_velocities[-1].twist.linear.x > self.configs["ASSUME_APPEAR_OR_DISAPPEAR"]:
                        tag.primary_category = TagLeadVehicle.PRIMARY_DISAPPEARING
                        tag.secondary_category = TagLeadVehicle.SECONDARY_GAP_OPENING
            if tag.primary_category == TagLeadVehicle.PRIMARY_UNKNOWN:
                tag.primary_category = TagLeadVehicle.PRIMARY_FOLLOWING
        else:
            tag.primary_category = TagLeadVehicle.PRIMARY_IRRELEVANT
        return tag

    def _check_cut_in(self, agent, ego_size, vx_loc_is_zero, vy_loc_is_zero):
        if vx_loc_is_zero or vy_loc_is_zero:
            return False

        ego_height = ego_size.x
        agent_height = agent.size.x
        agent_x = agent.relative_poses[-1].pose.position.x
        in_longitudinal = agent_x + agent_height / 2 > -ego_height / 2
        if not in_longitudinal:
            return False

        ego_width = ego_size.y
        dy = agent.relative_poses[-1].pose.position.y
        vy_rel = agent.local_velocities[-1].twist.linear.y
        aw = ego_width / 2. * self.configs["ASSUME_CUT_IN_RATIO"]
        bw = ego_width / 2. * self.configs["ASSUME_CENTER_RATIO"]
        vel_thresh = self.configs["SPEED_DIFFERENCE_TOLERANCE"]
        if abs(dy) < bw or abs(dy) > aw:
            return False
        else:
            if dy > 0 and vy_rel < vel_thresh:
                return True
            elif dy < 0 and vy_rel > vel_thresh:
                return True
            else:
                return False

    def _check_cut_out(self, agent, ego_width, vx_loc_is_zero, vy_loc_is_zero):
        if vx_loc_is_zero or vy_loc_is_zero:
            return False
        dy = agent.relative_poses[-1].pose.position.y
        vy_rel = agent.local_velocities[-1].twist.linear.y
        aw = ego_width / 2. * self.configs["PSYCHOLOGICALLY_STAGGERED_RATIO"]
        bw = ego_width / 2. * self.configs["ASSUME_CENTER_RATIO"]
        vel_thresh = self.configs["SPEED_DIFFERENCE_TOLERANCE"]
        if abs(dy) < bw or abs(dy) > aw:
            return False
        else:
            if dy > 0 and vy_rel > vel_thresh:
                return True
            elif dy < 0 and vy_rel < vel_thresh:
                return True
            else:
                return False

    def _is_leader(self, c_obj, ego_width):
        obj_x = c_obj.relative_poses[-1].pose.position.x
        obj_y = c_obj.relative_poses[-1].pose.position.y
        longitudinal = self._check_longitudinal_can_be_leader(obj_x)
        lateral = self._check_lateral_can_be_leader(obj_y, ego_width)
        vx_loc = c_obj.local_velocities[-1].twist.linear.x
        is_reversing = vx_loc < self.configs["SPEED_DIFFERENCE_TOLERANCE"]
        return lateral and longitudinal and not is_reversing

    def _check_lateral_can_be_leader(self, obj_y, ego_width):
        aw = ego_width / 2. * self.configs["PSYCHOLOGICALLY_STAGGERED_RATIO"]
        return abs(obj_y) < aw

    def _check_longitudinal_can_be_leader(self, obj_x):
        return obj_x > 0
