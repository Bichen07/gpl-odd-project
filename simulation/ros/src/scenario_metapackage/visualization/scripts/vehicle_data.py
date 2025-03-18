from collections import OrderedDict
import numpy as np
import rospy
from geometry_msgs.msg import Pose, Point, Quaternion
from itri_msgs.msg import CarState

class VehicleData(object):
    def __init__(self):
        self.timed_traj = OrderedDict()
        self.traj = []
        self.start_t = None
        self.stop_t = 0
        self.done = False

    def append(self, t, pose):
        assert not self.done
        if self.start_t is None:
            self.start_t = t.to_sec()
            self.stop_t = t.to_sec()
        else:
            self.stop_t = t.to_sec()
        self.timed_traj[t.to_sec()] = pose
        self.traj.append(np.array([
            t.to_sec(),
            pose.position.x,
            pose.position.y,
            pose.position.z,
            pose.orientation.x,
            pose.orientation.y,
            pose.orientation.z,
            pose.orientation.w,
        ]))

    def find(self, lookup_t):
        if not self.done:
            self.done = True
            self.traj = np.array(self.traj)

        try:
            lookup_t = lookup_t.to_sec()
        except:
            pass

        if lookup_t > self.stop_t + 1:
            print("lookup_t {} > stop_t of ego {}".format(lookup_t, self.stop_t))
            return self.timed_traj[self.stop_t]
        elif lookup_t in self.timed_traj.keys():
            return self.timed_traj[lookup_t]
        else:
            self.timed_traj[lookup_t] = self._get_interpolate(lookup_t)
            return self.timed_traj[lookup_t]

    def _get_interpolate(self, t):
        return Pose(
            Point(
                np.interp(t, self.traj[:, 0], self.traj[:, 1]),
                np.interp(t, self.traj[:, 0], self.traj[:, 2]),
                np.interp(t, self.traj[:, 0], self.traj[:, 3]),
            ),
            Quaternion(
                np.interp(t, self.traj[:, 0], self.traj[:, 4]),
                np.interp(t, self.traj[:, 0], self.traj[:, 5]),
                np.interp(t, self.traj[:, 0], self.traj[:, 6]),
                np.interp(t, self.traj[:, 0], self.traj[:, 7]),
            )
        )

