#!/usr/bin/env python
import rospy


class AccidentBase:
    D_VEL_THRESHOLD = 0.2
    S_VEL_THRESHOLD = 0.2
    def __init__(self, _type):
        self.accident_type = _type

    def get_matching_result(self, collision_profile):
        return self._match_result(collision_profile)

    def _match_result(self, collision_profile):
        raise NotImplementedError

    def _get_relative_on_frenet(self, collision_profile):

        pf = collision_profile

        result = {
            "ego_relative_frenet":{
                "longitudinal": None,
                "lateral": None,
            }
        }

        if pf.ego.s > pf.agent.s:
            front, rear = pf.ego, pf.agent
            result["ego_relative_frenet"]["longitudinal"] = "front";

        else:
            front, rear = pf.agent, pf.ego
            result["ego_relative_frenet"]["longitudinal"] = "rear";

        if pf.ego.d < pf.agent.d:
            left, right = pf.ego, pf.agent
            result["ego_relative_frenet"]["lateral"] = "right";

        else:
            left, right = pf.agent, pf.ego
            result["ego_relative_frenet"]["lateral"] = "left";

        return result, front, rear, left, right

