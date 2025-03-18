#!/usr/bin/env python
from typing import Optional
import rospy
from copy import deepcopy
from geometry_msgs.msg import PoseStamped, Pose
from geometry_msgs.msg import TwistStamped, Twist
from geometry_msgs.msg import Vector3
from itri_msgs.msg import DetectedObject, DetectedObjectArray
from itri_msgs.msg import CarState
from scenario_classification.msg import ClassificationObject
from scenario_classification.msg import ClassificationObjectArray
from scenario_classification.msg import TagTrees
from scenario_classification.msg import TagCarriagewayUserType
from scenario_classification.msg import TagInitialState
from scenario_classification.msg import TagLateralActivity
from scenario_classification.msg import TagLongitudinalActivity
from scenario_classification.msg import TagLeadVehicle
from scenario_classification.msg import TagRoadLayout
from utils import to_cpp, from_cpp
from utils import to_ego_frame, get_velocity_by_stamped_poses
from utils import update_relative_velocities, check_relative_acceleration
from utils import get_configs
from simulation_utils.converter import EulerAngleToQuaternion

# c++ implementation example
from scenario_classification._identifier_carriageway_user_type_cpp import (
    IdentifierCarriagewayUserType,
)

# from identifier.identifier_carriageway_user_type import IdentifierCarriagewayUserType  # python implementation example
from scenario_classification._identifier_longitudinal_activity_cpp import (
    IdentifierLongitudinalActivity,
)
from identifier.identifier_lateral_activity import IdentifierLateralActivity
from identifier.identifier_lead_vehicle import IdentifierLeadVehicle
from identifier.identifier_initial_state import IdentifierInitialState
from visualizer import Visualizer

# from matcher import Matcher

import time


class TreeOfTagsRunner(object):
    def __init__(self):
        self.ego_state = None  # type: Optional[CarState]
        self._previous_ego_state = None  # type: Optional[CarState]
        self.ego_size = None  # type: Optional[Vector3]
        self.configs = get_configs(print_config=True)
        self.visualizer = Visualizer()
        self.matcher = None
        # if self.configs["ENABLE_TAG_TREES_MATCHING"]:
        #     self.matcher = Matcher()
        self.identify_carriageway_user_type = IdentifierCarriagewayUserType()
        self.identify_longitudinal_activity = IdentifierLongitudinalActivity()
        self.identify_lateral_activity = IdentifierLateralActivity(self.configs)
        self.identify_lead_vehicle = IdentifierLeadVehicle(self.configs)
        self.identify_initial_state = IdentifierInitialState(self.configs)

        self.tracked_period_horizon = self.configs["TRACKED_PERIOD_HORIZON"]
        self.tracked = {}
        self.detected_objects = None  # type: Optional[DetectedObjectArray]
        self.speed_square_tracked = {}

        self.detected_objects_subscriber = rospy.Subscriber(
            "/detected_objects", DetectedObjectArray, self._callback_detected_objects
        )
        self.ego_state_subscriber = rospy.Subscriber(
            "/car_state", CarState, self._callback_car_state
        )
        self.classification_objects_publisher = rospy.Publisher(
            "/classification_objects", ClassificationObjectArray, queue_size=1
        )

    def to_classification_object_msg(self):
        msg = ClassificationObjectArray()
        if self.detected_objects:
            msg.header = self.detected_objects.header
            detected_ids = set()
            new_tracked_ids = set()
            for d_obj in self.detected_objects.objects:
                detected_ids.add(d_obj.id)
                c_obj = to_ego_frame(
                    d_obj, self.ego_state, self.configs.get("VELOCITY_ON_EGO_FRAME")
                )
                vel = c_obj.velocities[-1].twist.linear
                self.speed_square_tracked.setdefault(c_obj.id, [])
                self.speed_square_tracked[c_obj.id].append(vel.x**2 + vel.y**2)
                rel_pos = c_obj.relative_poses[-1].pose.position
                distance_square = rel_pos.x**2 + rel_pos.y**2
                if not self.configs["IS_SIMULATION"]:
                    if (
                        not self._is_moving(c_obj.id)
                        or distance_square
                        > self.configs["EGO_CLASSIFICATION_RADIUS"] ** 2
                    ):
                        continue
                new_tracked_ids.add(c_obj.id)
                self.update_tracked(c_obj)
                self.update_tags(self.tracked[c_obj.id])
                msg.objects.append(self.tracked[c_obj.id])
            delete_keys = set(self.tracked.keys()) - new_tracked_ids
            for key in delete_keys:
                del self.tracked[key]
            delete_keys = set(self.speed_square_tracked.keys()) - detected_ids
            for key in delete_keys:
                del self.speed_square_tracked[key]
            for value in self.speed_square_tracked.values():
                if len(value) >= self.configs["MOVING_SPEED_SAMPLING_WIDTH"]:
                    value.pop(0)

        ego_classification = ClassificationObject()
        if self._previous_ego_state != None:
            ego_classification.id = 10000
            ego_classification.label = "ego"

            rel_pos = PoseStamped()
            rel_pos.pose = deepcopy(self.ego_state.pose.pose)
            rel_pos.header = deepcopy(self.ego_state.header)
            ego_classification.relative_poses.append(rel_pos)

            vel = TwistStamped()
            vel = deepcopy(self.ego_state.twist)
            vel.header = deepcopy(self.ego_state.header)
            ego_classification.velocities.append(vel)

            local_vel = TwistStamped()
            local_vel.header = deepcopy(self.ego_state.header)
            ego_classification.local_velocities.append(local_vel)

            delta_time = (
                self.ego_state.header.stamp - self._previous_ego_state.header.stamp
            ).to_sec()
            vx = self.ego_state.twist.twist.linear.x
            prev_vx = self._previous_ego_state.twist.twist.linear.x
            rel_acc = TwistStamped()
            rel_acc.header = deepcopy(self.ego_state.header)
            if delta_time != 0.0:
                rel_acc.twist.linear.x = (vx - prev_vx) / delta_time
            ego_classification.relative_accelerations.append(rel_acc)

            self.update_tags(ego_classification)
            msg.objects.append(deepcopy(ego_classification))
        self.classification_objects_publisher.publish(msg)
        self.visualizer.visualize_tag_trees(self.tracked, ego_classification)
        if self.matcher:
            self.visualizer.visuzalize_matches(self.tracked, self.matcher)

    def update_tracked(self, c_obj):
        """Update an object with the following:
            1. states will be recorded in self.tracked.
            2. tagTrees will be updated.
            3. relative accelerations will be calculated
            4. relative/local/global velocities will be calculated if not filled

        Args:
            c_obj: ClassificationObject
        """

        cid = c_obj.id
        update_relative_velocities(c_obj, self.tracked.get(cid))
        c_obj.velocities[-1].twist.angular.z = (
            c_obj.relative_velocities[-1].twist.angular.z
            + self.ego_state.twist.twist.angular.z
        )
        check_relative_acceleration(c_obj, self.tracked.get(cid))

        # if cid in self.tracked.keys() and self._affirmed_same_after_velocity_check(c_obj):
        if cid in self.tracked.keys():
            if len(self.tracked[cid].relative_poses) == self.tracked_period_horizon:
                # print("TRACKED DELETE 0")
                del self.tracked[cid].relative_poses[0]
                del self.tracked[cid].relative_velocities[0]
                del self.tracked[cid].velocities[0]
                del self.tracked[cid].local_velocities[0]
                del self.tracked[cid].relative_accelerations[0]
            self.tracked[cid].relative_poses.append(deepcopy(c_obj.relative_poses[0]))
            self.tracked[cid].relative_velocities.append(
                deepcopy(c_obj.relative_velocities[0])
            )
            self.tracked[cid].velocities.append(deepcopy(c_obj.velocities[0]))
            self.tracked[cid].local_velocities.append(
                deepcopy(c_obj.local_velocities[0])
            )
            self.tracked[cid].relative_accelerations.append(
                deepcopy(c_obj.relative_accelerations[0])
            )
        else:
            self.tracked[cid] = deepcopy(c_obj)

    def _affirmed_same_after_velocity_check(self, c_obj):
        return (
            c_obj.relative_velocities[-1].twist.linear.x < 5
            and c_obj.relative_velocities[-1].twist.linear.y < 5
        )

    def update_tags(self, c_obj):
        if not self.ego_size:
            ego_length = rospy.get_param("vehicle_length", None)
            ego_width = rospy.get_param("vehicle_width", None)
            if ego_length and ego_width:
                self.ego_size = Vector3(ego_length, ego_width, 2.0)

        if self.ego_state is None or self.ego_size is None:
            rospy.logwarn(
                "[scen_cls] Ego Information Missing.\n"
                "ego_state = {}, ego_size = {}"
                "".format(self.ego_state, self.ego_size)
            )
            return

        str_ego_state = to_cpp(self.ego_state)
        str_c_obj = to_cpp(c_obj)
        str_ego_size = to_cpp(self.ego_size)

        # Check Carriageway User Type

        # c++ implementation example
        str_user_type = self.identify_carriageway_user_type.IdentifyTag(str_c_obj)
        user_type = from_cpp(str_user_type, TagCarriagewayUserType)

        # python implementation example
        # user_type = self.identify_carriageway_user_type.IdentifyTag(c_obj)

        c_obj.tag_trees.carriage_way_user_type = user_type

        if c_obj.label != "ego":
            # Check Initial State
            initial_state = self.identify_initial_state.IdentifyTag(
                c_obj, self.ego_size
            )
            c_obj.tag_trees.initial_state = initial_state

            # Check Lead Vehicle
            lead_vehicle = self.identify_lead_vehicle.IdentifyTag(c_obj, self.ego_size)
            c_obj.tag_trees.lead_vehicle = lead_vehicle

        # Check Lateral Activity
        lateral_activity = self.identify_lateral_activity.IdentifyTag(c_obj)
        c_obj.tag_trees.lateral_activity = lateral_activity

        # Check Longitudinal Activity
        str_longitudinal_activity = self.identify_longitudinal_activity.IdentifyTag(
            str_c_obj
        )
        longitudinal_activity = from_cpp(
            str_longitudinal_activity, TagLongitudinalActivity
        )
        c_obj.tag_trees.longitudinal_activity = longitudinal_activity

        # Check Road Layout

    def _is_moving(self, c_id):
        sampling_width = self.configs["MOVING_SPEED_SAMPLING_WIDTH"]
        moving_average = sum(self.speed_square_tracked[c_id]) / sampling_width
        return abs(moving_average) >= self.configs["ASSUME_MOVING_SPEED"] ** 2

    def _callback_detected_objects(self, msg):
        if self.ego_state:
            rospy.loginfo_once("Got ego state!")
            self.detected_objects = msg
            self.to_classification_object_msg()
            self._previous_ego_state = self.ego_state
        else:
            rospy.logwarn_throttle(5, "No ego state recieved.")

    def _callback_car_state(self, msg):
        self.ego_state = deepcopy(msg)
        yaw = self.ego_state.pose.pose.orientation.z
        self.ego_state.pose.pose.orientation = EulerAngleToQuaternion([0, 0, yaw])


if __name__ == "__main__":
    pass
    # rospy.init_node("tree_of_tags_node")
    # totr = TreeOfTagsRunner()
    # rospy.spin()
