#!/usr/bin/env python
import numpy as np

from accident_base import AccidentBase

class NLIAForwardAccident(AccidentBase):
    def __init__(self):
        AccidentBase.__init__(self, "NLIAForwardAccident")

    def _match_result(self, pf):

        match_dict = {
            "matched": False,
            "category": "NLIA",
            "type": self.accident_type,
            "case": "",
            "responsibility": -1,
            "notes": {}}

        if pf.road_type == 3:
            match_dict["notes"] = str({
                "reason": "road_type = 3"})
            return match_dict
        if pf.agent.vel_reversing \
                and pf.agent.heading_reversing \
                and pf.agent.is_crossing_lane:

            match_dict["notes"] = str({
                "reason": "agent from opposite"})
            return match_dict

        lat_dist = pf.ego.lat_dist_to_opposite_lane \
            - pf.agent.lat_dist_to_opposite_lane
        ego_width = 2 if pf.ego.size.y == 0 else pf.ego.size.y

        match_dict["matched"] = True


        # frenet:  front s+ / left d+

        if pf.ego.is_crossing_lane:
            ego_sensitive_crossing_lane = 0.3
            if pf.ego.in_opposite_lane:
                ego_sensitive_crossing_lane = 1.
        else:
            ego_sensitive_crossing_lane = 0.

        relative, front, rear, left, right = \
            self._get_relative_on_frenet(pf)
        match_dict["notes"].update(relative)

        if front.s_vel < -self.S_VEL_THRESHOLD:
            if front.in_opposite_lane:
                match_dict = self._assign(
                    case="undefined", responsibility=1., pf=pf,
                    good_car=front, bad_car=rear, 
                    mdict=match_dict, ego_sensitive=0.)        
            else:
                # case 2 reverse driving
                ego_sensitive = ego_sensitive_crossing_lane
                match_dict = self._assign(
                    case="2", responsibility=1., pf=pf,
                    good_car=rear, bad_car=front, 
                    mdict=match_dict, ego_sensitive=ego_sensitive)

        elif abs(front.d_vel) > self.D_VEL_THRESHOLD \
            and rear.s_vel > self.S_VEL_THRESHOLD:
            """case 9, case 10, case 11, case 12 U turn
                Road line was not considered, 
                hence no different between 9 and 10
            """
            ego_sensitive = max(ego_sensitive_crossing_lane, 0.3)
            match_dict = self._assign(
                case="9|10|11|12", responsibility=1., pf=pf,
                good_car=front, bad_car=rear,
                mdict=match_dict, ego_sensitive=ego_sensitive)

        elif abs(front.d_vel) < self.D_VEL_THRESHOLD \
            and abs(rear.d_vel) < self.D_VEL_THRESHOLD:
            # case 1
            ego_sensitive = ego_sensitive_crossing_lane
            match_dict = self._assign(
                case="1", responsibility=1., pf=pf,
                good_car=front, bad_car=rear,
                mdict=match_dict, ego_sensitive=ego_sensitive)

        elif abs(front.d_vel) >= self.D_VEL_THRESHOLD \
            and abs(rear.d_vel) >= self.D_VEL_THRESHOLD:
            """ case 13 | case 15 lateral collision
                Road geometry was not considered
            """
            if front.d_vel * rear.d_vel >= 0:
                ego_sensitive = ego_sensitive_crossing_lane
                if left.d_vel < right.d_vel \
                    and right.d_vel > 0:  # left drifting
                    # case 13a
                    match_dict = self._assign(
                        case="13a|14|15", responsibility=1., pf=pf,
                        good_car=right, bad_car=left, 
                        mdict=match_dict, ego_sensitive=ego_sensitive)

                elif abs(left.d_vel) > abs(right.d_vel) \
                    and left.d_vel < 0:  # right drifting
                    # case 13a, case 15
                    match_dict = self._assign(
                        case="13a|14|15", responsibility=1., pf=pf,
                        good_car=left, bad_car=right, 
                        mdict=match_dict, ego_sensitive=ego_sensitive)

            else:
                # case 13b
                ego_sensitive = ego_sensitive_crossing_lane
                match_dict = self._assign(
                    case="13b", responsibility=0.5, pf=pf,
                    good_car=front, bad_car=rear,
                    mdict=match_dict, ego_sensitive=ego_sensitive)

        elif abs(front.d_vel) < self.D_VEL_THRESHOLD \
            and abs(rear.d_vel) >= self.D_VEL_THRESHOLD:
            # case 3 | case 14
            # ego_sensitive = ego_sensitive_crossing_lane
            ego_sensitive = max(
                0.5 * pf.ego.in_opposite_lane,
                0.3 * pf.ego.is_outside_the_road)
            match_dict = self._assign(
                case="3|14", responsibility=1., pf=pf,
                good_car=front, bad_car=rear,
                mdict=match_dict, ego_sensitive=ego_sensitive)

        elif abs(front.d_vel) >= self.D_VEL_THRESHOLD \
            and abs(rear.d_vel) < self.D_VEL_THRESHOLD:
            # case 4 | case 8 | case 14
            ego_sensitive = max(ego_sensitive_crossing_lane, 0.5)
            match_dict = self._assign(
                case="4|8|14", responsibility=1., pf=pf,
                good_car=rear, bad_car=front,
                mdict=match_dict, ego_sensitive=ego_sensitive)

        else:
            # case 5, case 6 and 7 were skipped
            match_dict["case"] = "unknown"

        match_dict["notes"] = str(match_dict["notes"])
        return match_dict



    def _assign(self, case, responsibility, pf, 
        good_car, bad_car, mdict, ego_sensitive=0.0):
        """_assign
            assign value to match_dict (mdict)
            it tells which is good car and bad car, 
            assign responsibility to ego.
            if ego_sensitive is not 0.0, 
            it means even when ego is good car,
            it could probably be somewhat responsible.
            For example, in case 14,
            if ego is the car closer to left side, 
            it should still get some responsibility.
        """

        exception_info = "id(good_car): {}, id(bad_car): {}, "\
            "id(ego), id(agent)".format(
                id(good_car), id(bad_car), id(pf.ego), id(pf.agent))

        mdict["matched"] = True
        mdict["case"] = case
        assert id(good_car) != id(bad_car), exception_info
        if id(bad_car) == id(pf.ego):
            mdict["responsibility"] = responsibility
        elif id(good_car) == id(pf.ego):
            if ego_sensitive:
                mdict["responsibility"] = max(
                    ego_sensitive, 1. - responsibility)
            else:
                mdict["responsibility"] = 1. - responsibility
        else:
            assert False, exception_info

        return mdict


if __name__ == "__main__":
    from simulation_msgs.msg import CollisionProfile
    pf = CollisionProfile()
    fa = ForwardAccident()
    print(fa._match_result(pf))