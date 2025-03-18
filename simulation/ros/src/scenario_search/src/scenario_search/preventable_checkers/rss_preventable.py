from __future__ import print_function, division
from typing import Optional
import yaml
import rospy
from rss_msgs.msg import ProperResponse, CheckResult, CheckResultObjectState
from itri_msgs.msg import CarState
from scenario_search.preventable_checkers.preventable_base import PreventableCheckerBase


class RssPreventableChecker(PreventableCheckerBase):
    def __init__(self):
        pass

    def reset(self):
        pass

    def is_preventable(self):
        return True
