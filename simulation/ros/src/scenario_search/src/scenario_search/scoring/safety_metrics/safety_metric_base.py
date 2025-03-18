import rospy
from std_msgs.msg import Bool
from collections import OrderedDict


class MetricBase(object):
    def __init__(self):
        self._can_start_sampling_subscriber = rospy.Subscriber(
            "can_start_observation_sampling", Bool, self._can_start_sampling_callback
        )
        self.can_start_observation_sampling = False

    def reset(self):
        # type: () -> None
        return None

    def get_record(self):
        # type: () -> OrderedDict
        return OrderedDict()

    def get_score(self):
        # type: () -> OrderedDict
        return OrderedDict()

    def _can_start_sampling_callback(self, msg):
        # type: (Bool) -> None
        self.can_start_observation_sampling = msg.data
