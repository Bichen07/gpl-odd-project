#!/usr/bin/env python
from collections import deque
import copy
import time

import numpy as np
import tf2_ros
import rospy
from simulation_utils.exception_handler import TryToCallAfterFailed
from std_msgs.msg import ColorRGBA
from std_srvs.srv import SetBool, Empty, EmptyResponse
from itri_msgs.msg import BehaviorState, CarState
from itri_msgs.msg import WaypointArray, Path, speed_cmd
from scenario_msgs.msg import AgentDataArray
from simulation_srvs.srv import SimulationCreateAgentByDefaultPose
from simulation_srvs.srv import SimulationDeleteAgent
from simulation_msgs.msg import SimulationAgentControl

try:
    from route_mission_handler.srv import LoadRouteByFileNameSrv

    USE_ROUTE_MISSION_HANDLER_SERVICE = True
except:
    USE_ROUTE_MISSION_HANDLER_SERVICE = False


def main():
    rospy.init_node("ego_wrapper", disable_signals=True)

    if not USE_ROUTE_MISSION_HANDLER_SERVICE:
        rospy.logwarn(
            "[EgoWrapper] " "Not using route_mission_handler/LoadRouteByFileNameSrv."
        )

        # Check if this service is necessary
        usage_scenario_search_param_name = (
            "/simulation/usage" "/parameterized_scenario_search"
        )
        if rospy.get_param(usage_scenario_search_param_name, False):
            raise RuntimeError(
                "[EgoWrapper] LoadRouteByFileNameSrv service "
                "is necessary for usage of scenario_search. Please make sure "
                "that the sdc branch contains this service like commit # "
                "589b97 does."
            )

    disable_monitor = rospy.get_param("~disable_monitor", False)
    ego_wrapper = None
    ego_wrapper = EgoWrapper()
    if not disable_monitor:
        ego_wrapper.run()


def ROSExceptionHandleWrapper(func):
    def wrap(self, *args, **kwargs):
        try:
            return func(self, *args, **kwargs)
        except rospy.ROSException as error:
            rospy.logwarn(
                "[EgoWrapper] ROSException in "
                'function "{}" with args "{}" and "{}"'
                ": {}.".format(func.__name__, args, kwargs, error)
            )
        except rospy.service.ServiceException as error:
            rospy.logwarn(
                "[EgoWrapper] ROS Service error in "
                'function "{}" with args "{}" and "{}"'
                ": {}.".format(func.__name__, args, kwargs, error)
            )

    return wrap


class EgoWrapper:
    def __init__(self, create_ego_kwargs={}):
        rospy.loginfo("[EgoWrapper] Initialization.")

        self._create_ego_kwargs = create_ego_kwargs
        self._ns = rospy.get_namespace().replace("/", "")
        if self._ns:
            self._car_id = "{}/ego".format(self._ns)
            self._frame_id = "{}/base_link".format(self._ns)
        else:
            self._car_id = "ego"
            self._frame_id = "base_link".format(self._ns)
        self._reload_route_file_name = rospy.get_param("route_mission_handler/fileName")
        self._run_once = rospy.get_param("~run_once", False)
        self._run_mr_vil = rospy.get_param("~run_mr_vil", False)
        self._dt = 0.01

        self._load_parameters()

        self.reset_service = rospy.Service(
            "ego_handler/reset_ego", Empty, self._reset_server
        )
        self._allow_moving_proxy = rospy.ServiceProxy("allow_moving", SetBool)
        self._create_proxy = rospy.ServiceProxy(
            "/simulation/agent_srv/create_by_default_pose",
            SimulationCreateAgentByDefaultPose,
        )
        self._delete_proxy = rospy.ServiceProxy("/cosim/delete", SimulationDeleteAgent)
        self._self_destruction_proxy = rospy.ServiceProxy(
            "/simulation/agent_srv/delete", SimulationDeleteAgent
        )
        if USE_ROUTE_MISSION_HANDLER_SERVICE:
            self._reload_route_proxy = rospy.ServiceProxy(
                "route_mission_handler/load_route_by_file_name", LoadRouteByFileNameSrv
            )

        self._behavior_queue = deque(maxlen=1)
        self._car_state_queue = deque(maxlen=int(10.0 * (1.0 / self._dt)))
        self._agent_data_array_queue = deque(maxlen=1)
        self._waypoint_queue = deque(maxlen=1)

        rospy.Subscriber("behavior_state", BehaviorState, self._behavior_state_callback)
        rospy.Subscriber("car_state", CarState, self._callback, self._car_state_queue)
        rospy.Subscriber(
            "agent_data_array",
            AgentDataArray,
            self._callback,
            self._agent_data_array_queue,
        )
        rospy.Subscriber(
            "waypoints", WaypointArray, self._callback, self._waypoint_queue
        )

        self._behaviod_state = {"last": None, "timestamp": rospy.Time.now()}

        rospy.loginfo(
            "[EgoWrapper] Settings:\n\tCar ID: {}\n\tRun Once: {}\n\tRun MR-ViL: {}\n"
            "".format(self._car_id, self._run_once, self._run_mr_vil)
        )

        create_ego_service_name = "/simulation/agent_srv/create_by_default_pose"
        rospy.loginfo(
            "[EgoWrapper] Wait for service {}" "".format(create_ego_service_name)
        )
        rospy.wait_for_service(create_ego_service_name)

        self.create_ego(**create_ego_kwargs)
        rospy.loginfo("[EgoWrapper] Ego created with name {}." "".format(self._car_id))

        self._tf_buffer = tf2_ros.Buffer()
        self._tf_listener = tf2_ros.TransformListener(self._tf_buffer)

        if USE_ROUTE_MISSION_HANDLER_SERVICE:
            reload_route_service_name = "route_mission_handler/load_route_by_file_name"
            rospy.loginfo(
                "[EgoWrapper] Wait for service {}" "".format(reload_route_service_name)
            )
            rospy.wait_for_service(reload_route_service_name)

        rospy.loginfo("[EgoWrapper] Constructed.")

    def create_ego(
        self,
        model=None,
        route=None,
        file_name=None,
        pose_sequence=None,
        sim_with_external_vehicle=False,
    ):
        spawn_information = rospy.get_param("~spawn_information", {})
        if not (
            rospy.has_param("behavior/vehicle")
            and rospy.has_param("route_mission_handler/route")
            and rospy.has_param("route_mission_handler/fileName")
        ):
            rospy.logwarn(
                "[Ego Wrapper] It is recommended to load"
                "vehicle_configuration.yaml first. "
            )
        if pose_sequence is not None:
            pose_sequence = pose_sequence
        else:
            pose_sequence = int(spawn_information.get("defaultPoseSequence")) or 0
        response = self._create_proxy(
            self._car_id,
            "car",
            model or rospy.get_param("behavior/vehicle") or "pacifica",
            route or rospy.get_param("route_mission_handler/route") or "III_itri",
            file_name or rospy.get_param("route_mission_handler/fileName") or "loop",
            pose_sequence,
            0.0,  # longitudinalNoiseScale
            ColorRGBA(),
            sim_with_external_vehicle
            or spawn_information.get("simWithExternalVehicle"),
        )
        return response.isSuccess

    def _callback(self, msg, queue):
        queue.append(msg)

    def _load_parameters(self):
        import os
        import rosparam

        SDC_CONFIG_DIR = os.environ["SDC_CONFIG_DIR"]
        params_path = os.path.join(SDC_CONFIG_DIR, "parameters.yaml")
        params = rosparam.load_file(params_path)[0][0]
        for key, value in params.items():
            rospy.set_param(key, value)

    def _reset_server(self, req):
        self.accumulate_error = 0
        self._reset_ego_pose_and_cmd()
        return EmptyResponse()

    @ROSExceptionHandleWrapper
    def _load_route(self, time_stamp):
        rospy.loginfo(
            "[Ego Wrapper] {} " "Reset route_mission_handler".format(self._car_id)
        )
        if USE_ROUTE_MISSION_HANDLER_SERVICE:
            rospy.loginfo(
                "[Ego Wrapper] {} reloads route {}.".format(
                    self._car_id, self._reload_route_file_name
                )
            )
            self._reload_route_proxy(self._reload_route_file_name)
        self._behaviod_state["last"] = None
        self._behaviod_state["timestamp"] = time_stamp

    @ROSExceptionHandleWrapper
    def _behavior_state_callback(self, msg):
        time_stamp = rospy.Time.now()

        def _remove(reason=""):
            result = self._remove_nearest()
            if result:
                isSuccess, removed_id = result
                if isSuccess:
                    rospy.loginfo(
                        "[Ego Wrapper] {} "
                        'remove nearest vehicle {} for "{}"'
                        "".format(self._car_id, removed_id, reason)
                    )
            self._behaviod_state["last"] = None
            self._behaviod_state["timestamp"] = time_stamp

        if msg.behavior_state != self._behaviod_state["last"]:
            self._behaviod_state["last"] = msg.behavior_state
            self._behaviod_state["timestamp"] = time_stamp
        else:
            last = self._behaviod_state["timestamp"]
            lasting = (time_stamp - last).to_sec()
            if msg.behavior_state == 17 and lasting > 10.0 and not self._run_once:
                # DestinationWaypoints
                self._load_route(time_stamp)
            elif msg.behavior_state == 18 and lasting > 10.0 and not self._run_once:
                # DestinationGlobalPath
                self._load_route(time_stamp)
            elif msg.behavior_state == 1 and lasting > 10.0:
                # AEB
                _remove("AEB Stucked.")
            elif msg.behavior_state == 9 and self._is_stopped(sec=5.0) and lasting > 10:
                # ACC and Stucked
                _remove("ACC Stucked.")

    def _get_nearest(self):
        if self._agent_data_array_queue:
            agents = copy.deepcopy(self._agent_data_array_queue[-1])
            agents.data.sort(key=lambda x: x.distance)
            for agent in agents.data:
                if "ego" in agent.agent_id:
                    continue
                return agent.agent_id
            return False
        return False

    @ROSExceptionHandleWrapper
    def _remove_nearest(self):
        id_to_be_deleted = self._get_nearest()
        rospy.loginfo("[Ego Wrapper] nearest result: {}".format(id_to_be_deleted))
        if id_to_be_deleted:
            rospy.wait_for_service("/cosim/delete", timeout=1.0)
            isSuccess = self._delete_proxy(id_to_be_deleted).isSuccess
            return isSuccess, id_to_be_deleted
        else:
            return False, ""

    def _is_stopped(self, sec=-1):  # if sec = -1: check all in queue
        history = list(self._car_state_queue)

        if len(history) == 0:
            return True

        if sec == -1:
            check_steps = len(history)
        else:
            check_steps = int(min(sec * (1.0 / self._dt), len(history)))

        for ego in history[-check_steps:][::-1]:
            if ego.twist.twist.linear.x > 1e-2 or ego.twist.twist.linear.y > 1e-2:
                return False
        return True

    @TryToCallAfterFailed(tag="EgoWrapper", max_attempt=10, sleep=1)
    def _reset_ego_pose_and_cmd(self):
        if not self._run_mr_vil:
            self._allow_moving_proxy(False)
            self.create_ego(**self._create_ego_kwargs)
            self._wait_for_waypoints(500)
            self._allow_moving_proxy(True)

    @ROSExceptionHandleWrapper
    def _wait_for_waypoints(self, load_every_n_iters=0):
        counter = 0
        self._waypoint_queue.clear()

        def _reload(counter):
            if load_every_n_iters > 0:
                if counter % load_every_n_iters == 0:
                    return True
            return False

        while not self._waypoint_queue and not rospy.is_shutdown():
            if _reload(counter):
                self._load_route(rospy.Time.now())
            rospy.loginfo_throttle(
                30, "[EgoWrapper] {} " "wait for waypoint.".format(self._car_id)
            )
            counter += 1
            rospy.sleep(0.01)
        rospy.loginfo("[EgoWrapper] Got Waypoints.")
        return True

    def run(self):
        try:
            self._run()
        except KeyboardInterrupt:
            self.destroy()
            rospy.signal_shutdown("Shutdown by KeyboardInterrupt.")

    def _run(self):
        rospy.loginfo("[EgoWrapper] Wait for global path and waypoints.")
        self.global_path = rospy.wait_for_message("global_path", Path)
        rospy.loginfo("[EgoWrapper] Got global path. Initialization done.")

        self._wait_for_waypoints()
        rospy.loginfo("[EgoWrapper] Start monitoring.")

        self.accumulate_error = 0

        while not rospy.is_shutdown():
            if self._step_once():
                self.accumulate_error = 0
            else:
                self.accumulate_error += 1

            if self.accumulate_error >= 3:
                self._reset_ego_pose_and_cmd()
                self.accumulate_error = 0

    def _step_once(self):
        try:
            speed = rospy.wait_for_message("speed_cmd", speed_cmd, timeout=1.0)
            rospy.sleep(0.5)
            transform_stamped = self._tf_buffer.lookup_transform(
                "frenet", "{}SD".format(self._frame_id), rospy.Time()
            )
            lateral_drift = transform_stamped.transform.translation.y
            if abs(lateral_drift) > 4.5:
                rospy.logwarn(
                    "[Ego Wrapper] {} out of "
                    "maximum lateral tolerance. Reset."
                    "".format(self._car_id)
                )
                return False
        except rospy.exceptions.ROSException as error:
            rospy.logwarn_throttle(
                60,
                "[EgoWrapper] {} command rate dropped "
                "to under 1 hz. Reset. ({})"
                "".format(self._car_id, error),
            )
            return False
        except tf2_ros.LookupException as error:
            rospy.logwarn_throttle(
                5,
                "[EgoWrapper] {} tf2 lookup exception: {}"
                "".format(self._car_id, error),
            )

        return True

    def destroy(self):
        try:
            rospy.wait_for_service("/simulation/agent_srv/delete", timeout=1)
            self._self_destruction_proxy(self._car_id)
        except rospy.service.ServiceException as e:
            rospy.logwarn(e)


if __name__ == "__main__":
    main()
