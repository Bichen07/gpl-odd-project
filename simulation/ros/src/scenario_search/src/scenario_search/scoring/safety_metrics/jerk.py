import rospy
import numpy as np
from collections import OrderedDict, deque
from safety_metric_base import MetricBase
from itri_msgs.msg import CarState
from std_msgs.msg import Bool


class JerkMetric(MetricBase):
    def __init__(self):
        super(JerkMetric, self).__init__()
        self.scenario_stable = False
        self.jerk_queue = deque()

        self.car_state_subscriber = rospy.Subscriber(
            "car_state", CarState, self._car_state_callback
        )
        self._scenario_stable_subscriber = rospy.Subscriber(
            "scenario_monitor/scenario_stable", Bool, self._scenario_stable_callback
        )

    def reset(self):
        self.scenario_stable = False
        self.jerk_queue = deque()

    def get_score(self):
        result = OrderedDict({"jerk_max": np.max(list(self.jerk_queue))})
        return result

    def get_record(self):
        result = OrderedDict(
            {
                "jerk": self.jerk_queue[-1]
                if len(self.jerk_queue) > 0
                else float("nan"),
            }
        )
        return result

    def _car_state_callback(self, msg):
        if not self.scenario_stable:
            return
        if not self.can_start_observation_sampling:
            return
        self.jerk_queue.append(msg.jerk)

    def _scenario_stable_callback(self, msg):
        self.scenario_stable = msg.data
