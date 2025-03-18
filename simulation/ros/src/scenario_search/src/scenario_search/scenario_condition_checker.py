import rospy
from std_msgs.msg import std_msgs
import tf2_ros
from scenario_msgs.msg import AgentDataArray
from simulation_msgs.msg import CollisionProfile
from itri_msgs.msg import WaypointArray
from std_msgs.msg import Bool


class EgoTfListener:
    def __init__(self):
        self.tf_buffer = tf2_ros.Buffer()
        self.tf_listener = tf2_ros.TransformListener(self.tf_buffer)

    def get_sd_position(self):
        try:
            trans = self.tf_buffer.lookup_transform(
                "frenet", "base_linkSD", rospy.Time()
            )
            return trans.transform.translation.x, trans.transform.translation.y
        except (
            tf2_ros.LookupException,
            tf2_ros.ConnectivityException,
            tf2_ros.ExtrapolationException,
        ) as e:
            rospy.logwarn_throttle(10, e)
            return False, False


class ScenarioConditionChecker:
    def __init__(self, odd_search_config):
        self._ego_tf_listener = EgoTfListener()
        self.agent_data_subscribers = rospy.Subscriber(
            "/simulation/agent_data_array",
            AgentDataArray,
            self._agent_data_array_callback,
        )
        self.collision_profile_subscriber = rospy.Subscriber(
            "/simulation/collision_profile", CollisionProfile, self._collision_callback
        )
        self.waypoints_subscriber = rospy.Subscriber(
            "/waypoints", WaypointArray, self._waypoints_callback
        )
        self.agent_data = AgentDataArray()
        self.collision_profile = None
        self.odd_search_config = odd_search_config

        self._ignore_first_n_seconds = 7.0
        self.last_end_time = rospy.Time.now()
        self.got_waypoints = False

        self.end_scenario_message = None
        self.ego_stuck_message = None
        self.end_scenario_subscriber = rospy.Subscriber(
            "/end_scenario", Bool, self._end_scenario_callback
        )
        # self.end_scenario_publisher = rospy.Publisher(
        #     "/end_scenario", Bool, queue_size=1
        # )
        self.ego_stuck_subscriber = rospy.Subscriber(
            "/ego_stuck", Bool, self._ego_stuck_callback
        )
        self.agent_moved_before = False
        self.sim_with_external_ego = rospy.get_param(
            "/single_parameterized_scenario_search/sim_with_external"
        )

    @property
    def ignore_first_n_seconds(self):
        return self._ignore_first_n_seconds

    def _waypoints_callback(self, _):
        self.got_waypoints = True

    def _agent_data_array_callback(self, msg):
        self.agent_data = msg

    def _collision_callback(self, msg):
        # type: (CollisionProfile) -> None
        frame_id = msg.header.frame_id
        print("collision callback trigger, frame_id: {}".format(frame_id))
        print(frame_id)
        if "esmini_collision" in frame_id:
            self.collision_profile = msg
        # self.collision_profile = msg

    def _end_scenario_callback(self, msg):
        self.end_scenario_message = msg
        rospy.logerr(
            "[scenario condition checker]: end scenario message callback, msg data: {}".format(
                msg.data
            )
        )

    def _ego_stuck_callback(self, msg):
        self.ego_stuck_message = msg
        rospy.sleep(1.0)
        self.end_scenario_message = msg

    def reset(self):
        self.end_scenario_message = None
        self.agent_moved_before = False
        self.collision_profile = None

    def check_end_condition(self):
        debug_info = {}

        # Avoid unwanted end_condition met shortly after ego's reset.
        if not self.sim_with_external_ego:
            curr_time = rospy.Time.now()
            if curr_time - self.last_end_time < rospy.Duration(
                self.ignore_first_n_seconds
            ):
                print("ignore first n seconds, return end condition return False")
                return False
            if not self.got_waypoints:
                print("not got waypoints, return end condition return False")
                return False

        # if "end_condition_and" in self.odd_search_config.keys():
        #     end_condition_met = True
        #     for key, value in self.odd_search_config["end_condition_and"].items():
        #         condition_met, info = self._check_single_end_condition(key, value)
        #         end_condition_met = end_condition_met and condition_met
        #         debug_info[key] = info
        # elif "end_condition_or" in self.odd_search_config.keys():
        #     end_condition_met = False
        #     for key, value in self.odd_search_config["end_condition_or"].items():
        #         condition_met, info = self._check_single_end_condition(key, value)
        #         end_condition_met = end_condition_met or condition_met
        #         debug_info[key] = info
        #
        # if end_condition_met:
        #     print("end condition from config")
        #
        # if self.collision_profile:
        #     end_condition_met = True
        #     debug_info["collision"] = True
        #     self.collision_profile = None
        #     print("end condition from collision profile")
        # else:
        #     debug_info["collision"] = False
        #
        # # rospy.loginfo(debug_info)
        #
        # # rospy.loginfo(self.end_scenario_message)
        # if self.end_scenario_message is not None:
        #     print(
        #         "end condition from end scenario message: {}".format(
        #             self.end_scenario_message.data
        #         )
        #     )
        #     end_condition_met = self.end_scenario_message is not None
        #     return end_condition_met
        #
        # if end_condition_met or self.collision_profile:
        #     if (
        #         "start_valid_conditions" in self.odd_search_config
        #         and len(self.odd_search_config["start_valid_condition"]) != 0
        #         and self.end_scenario_message is None
        #     ):
        #         end_condition_met = False
        #     else:
        #         msg = Bool()
        #         msg.data = True
        #         self.end_scenario_message = msg

        # self.got_waypoints = False
        # self.last_end_time = rospy.Time.now()

        return self.end_scenario_message is not None

    def _check_single_end_condition(self, key, value):
        if key == "after_frenet_s":
            s, d = self._ego_tf_listener.get_sd_position()
            return s > value, "{} > {}: {}".format(s, value, s > value)
        elif key == "after_agents_stopped":
            all_stopped = self._is_all_agent_stopped()
            return all_stopped, all_stopped

    def _is_all_agent_stopped(self):
        for agent in self.agent_data.data:
            if "ego" in agent.agent_id:
                continue
            stopped = (
                abs(agent.linear_velocity.x) < 0.1
                and abs(agent.linear_velocity.y) < 0.1
            )
            if not self.agent_moved_before and not stopped:
                self.agent_moved_before = True
                return False
            if self.agent_moved_before and stopped:
                return True
        return False
