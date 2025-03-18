from __future__ import print_function, division
from pprint import pprint
from typing import Optional
from collections import OrderedDict
import yaml
import rospy
from rss_msgs.msg import ProperResponse, CheckResult, CheckResultEgoVehicleState, CheckResultObjectState, LongitudinalState, LateralState, SafetyState, UnstructuredSafety, StructuredSafety
from itri_msgs.msg import CarState
from std_msgs.msg import Bool, String
from scenario_search.preventable_checkers.preventable_base import PreventableCheckerBase
from safety_metric_base import MetricBase


class RssPreventableChecker(MetricBase):
    def __init__(self):
        print("RssPreventableChecker" * 100)
        self.car_state = None
        self.car_state_subscriber = rospy.Subscriber(
            "/car_state", CarState, self.car_state_callback
        )
        self.rss_proper_response_subscriber = rospy.Subscriber(
            "/rss/proper_response", ProperResponse, self.rss_proper_response_callback
        )
        self.rss_check_result_subscriber = rospy.Subscriber(
            "/rss/check_result", CheckResult, self.rss_check_result_callback
        )

        self.rss_longitudinal_state_subscriber = rospy.Subscriber(
            "/rss/longitudinal_state", LongitudinalState, self.rss_longitudinal_state_callback
        )
        self.rss_lateral_state_subscriber = rospy.Subscriber(
            "/rss/lateral_state", LateralState, self.rss_lateral_state_callback
        )
        self.rss_safety_state_subscriber = rospy.Subscriber(
            "/rss/safety_state", SafetyState, self.rss_safety_state_callback
        )
        self.rss_structured_safety_subscriber = rospy.Subscriber(
            "/rss/structured_safety", StructuredSafety, self.rss_structured_safety_callback
        )
        self.rss_unstructured_safety_subscriber = rospy.Subscriber(
            "/rss/unstructured_safety", UnstructuredSafety, self.rss_unstructured_safety_callback
        )

        self._can_start_sampling_subscriber = rospy.Subscriber(
            "can_start_observation_sampling", Bool, self._can_start_sampling_callback
        )
        self.can_start_observation_sampling = False

        with open("/project/mmsl_simulation/src/rss/data/parameters.yaml", "r") as file:
            self.rss_parameters = yaml.load(file, yaml.SafeLoader)["rss"]

        self._always_response_properly = True
        self._is_scenario_safe = True

        self._always_lateral_left_properly_responsed = True
        self._always_lateral_right_properly_responsed = True
        self._always_longitudinal_properly_responsed = True
        self._always_unstructred_scene_properly_responsed = True

        self._lateral_left_proper_response_queue = []
        self._lateral_left_proper_response_achieved_queue = []

        self._lateral_right_proper_response_queue = []
        self._lateral_right_proper_response_achieved_queue = []

        self._longitudinal_proper_response_queue = []
        self._longitudinal_proper_response_achieved_queue = []

        self._unstructured_scene_proper_response_queue = []
        self._unstructured_scene_proper_response_achieved_queue = []

        self.max_ratio = 2

        self.is_all_rss_safe = True
        self.min_rss_ratio = 2 * self.max_ratio
        self.current_rss_ratio = {}
        self.is_long_safe = {}
        self.is_lat_safe = {}
        self.is_rss_safe = {}

        self.speed_lon = {}
        self.speed_lat = {}
        self.dist_lon = {}
        self.dist_right_lat = {}
        self.dist_left_lat = {}
        self.situation_type = {}

    def reset(self):
        self.car_state = None
        self._is_scenario_safe = True
        self._check_result = None
        self.can_start_observation_sampling = False

        self._always_response_properly = True
        self._always_lateral_left_properly_responsed = True
        self._always_lateral_right_properly_responsed = True
        self._always_longitudinal_properly_responsed = True
        self._always_unstructred_scene_properly_responsed = True

        self.is_all_rss_safe = True
        self.min_rss_ratio = 2 * self.max_ratio
        self.current_rss_ratio = {}
        self.is_long_safe = {}
        self.is_lat_safe = {}
        self.is_rss_safe = {}

        self.speed_lon = {}
        self.speed_lat = {}
        self.situation_type = {}

    def get_score(self):
        result = OrderedDict(
            {
                "min_rss_ratio": self.min_rss_ratio,
                "is_rss_safe": int(self.is_all_rss_safe)
            }
        )
        return result

    def get_record(self):
        result = OrderedDict(
            {
                "rss_long_safe": self.is_long_safe,
                "rss_lat_safe": self.is_lat_safe,
                "is_rss_safe": self.is_rss_safe,
                "rss_ratio": self.current_rss_ratio,
                "speed_lon": self.speed_lon,
                "speed_lat": self.speed_lat,
                "situation_type": self.situation_type,
                "dist_lon": self.dist_lon,
                "dist_right_lat": self.dist_right_lat,
                "dist_left_lat": self.dist_left_lat,
            }
        )
        return result

    def car_state_callback(self, msg):
        # type: (CarState) -> None
        self.car_state = msg

    def rss_check_result_callback(self, msg):
        # type: (CheckResult) -> None
        if msg.object_states is None:
            return
        ego_state = msg.ego_vehicle_state # type: CheckResultObjectState
        self.speed_lon["Ego"] = ego_state.speedLon
        self.speed_lat["Ego"] = ego_state.speedLat
        # print("-"*70)
        # print("Ego")
        # print(ego_state.speedLon)
        # print(ego_state.speedLat)
        for object_state in msg.object_states:
            object_state = object_state # type: CheckResultObjectState

            # print("StructuredSafety")
            # print(object_state.structured_safety)
            # print(object_state.name)
            # print("RSS_STATE")
            # print(object_state.rss_state)
            # print("-"*70)
            # print(object_state.name)
            # print(object_state.speedLon)
            # print(object_state.speedLat)
            # self.situation_type[object_state.name] = object_state.situation_type
            # self.speed_lon[object_state.name] = object_state.speedLon
            # self.speed_lat[object_state.name] = object_state.speedLat

            long_safe_distance = object_state.rss_state.longitudinal_state.safe_distance
            long_curr_distance = object_state.rss_state.longitudinal_state.current_distance
            lat_right_safe_distance = object_state.rss_state.right_lateral_state.safe_distance
            lat_right_curr_distance = object_state.rss_state.right_lateral_state.current_distance
            lat_left_safe_distance = object_state.rss_state.left_lateral_state.safe_distance
            lat_left_curr_distance = object_state.rss_state.left_lateral_state.current_distance

            max_ratio = self.max_ratio
            max_distance = 10000

            long_ratio = max_ratio if long_safe_distance > max_distance or object_state.rss_state.longitudinal_state.is_safe else (0 if long_safe_distance == 0 else long_curr_distance / long_safe_distance)
            lat_right_ratio = max_ratio if lat_right_safe_distance > max_distance or object_state.rss_state.right_lateral_state.is_safe else (0 if lat_right_safe_distance == 0 else lat_right_curr_distance / lat_right_safe_distance)
            lat_left_ratio = max_ratio if lat_left_safe_distance > max_distance or object_state.rss_state.left_lateral_state.is_safe else (0 if lat_left_safe_distance == 0 else lat_left_curr_distance / lat_left_safe_distance)
            rss_ratio = long_ratio + min(lat_right_ratio, lat_left_ratio)

            is_long_safe = long_ratio > 1.0
            is_lat_safe = min(lat_left_ratio, lat_right_ratio) > 1.0

            self.dist_lon[object_state.name] = long_curr_distance
            self.dist_right_lat[object_state.name] = lat_right_curr_distance
            self.dist_left_lat[object_state.name] = lat_left_curr_distance

            # print("-"*70)
            # print(object_state.name)
            # print(object_state.situation_type)
            # print("long safe / curr")
            # print(long_safe_distance)
            # print(long_curr_distance)
            # print("lat right safe / curr")
            # print(lat_right_safe_distance)
            # print(lat_right_curr_distance)
            # print("lat left safe / curr")
            # print(lat_left_safe_distance)
            # print(lat_left_curr_distance)

            self.min_rss_ratio = min(rss_ratio, self.min_rss_ratio)
            self.current_rss_ratio[object_state.name] = rss_ratio
            self.is_long_safe[object_state.name] = is_long_safe
            self.is_lat_safe[object_state.name] = is_lat_safe

            is_rss_safe = not ((not is_lat_safe) and (not is_long_safe))
            self.is_rss_safe[object_state.name] = is_rss_safe
            self.is_all_rss_safe = is_rss_safe & self.is_all_rss_safe

            # print("is_rss_safe")
            # print(is_rss_safe)

            # print("OBJ UNSTRCTURED RESPONSE")
            # print(object_state.unstructured_safety.status)
            # print("OBJ UNSTRCTURED STATUS")
            # print(object_state.unstructured_safety.response)

        # print("-"*70)
        # print("is_rss_safe")
        # pprint(self.is_rss_safe)
        # print("current_rss_ratio")
        # pprint(self.current_rss_ratio)
        # print("is_long_safe")
        # pprint(self.is_long_safe)
        # print("is_lat_safe")
        # pprint(self.is_lat_safe)
        # print("="*70)

    def rss_longitudinal_state_callback(self, msg):
        # type: (LongitudinalState) -> None
        print("MSG LONG STATE RSS")
        print(msg)
        pass

    def rss_lateral_state_callback(self, msg):
        # type: (LateralState) -> None
        print("MSG LATERAL STATE RSS")
        print(msg)
        pass

    def rss_safety_state_callback(self, msg):
        # type: (SafetyState) -> None
        print("MSG Safety STATE RSS")
        print(msg)
        pass

    def rss_structured_safety_callback(self, msg):
        # type: (StructuredSafety) -> None
        print("MSG StructuredSafety RSS")
        print(msg)
        pass

    def rss_unstructured_safety_callback(self, msg):
        # type: (UnstructuredSafety) -> None
        print("MSG unstructuredSafety RSS")
        print(msg)
        pass

    def rss_proper_response_callback(self, msg):
        # type: (ProperResponse) -> None
        if not self.can_start_observation_sampling:
            return
        # print("MSG PROPER RESPONSE")
        # print(msg)

    def _can_start_sampling_callback(self, msg):
        # type: (Bool) -> None
        self.can_start_observation_sampling = msg.data
