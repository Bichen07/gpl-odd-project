#!/usr/bin/env python
from collections import deque

import tf
import rospy

from geometry_msgs.msg import TwistStamped, Pose2D
from itri_msgs.msg import speed_cmd, steer_cmd, CarState, Path
from itri_msgs.msg import WaypointArray
from route_mission_handler.srv import LoadRouteByIdSrv
from motion_planner.srv import RequestGenerateWaypointsService

def main():
    rospy.init_node("ego_stuck_helper", anonymous=True)
    handler = EgoStuckHelper()


class EgoStuckHelper:

    init_pose_2d = Pose2D(5.355, -9.424, 2.405)
    preset_route_id = 5

    def __init__(self):
        rospy.loginfo("[EgoStuckHelper] Initialize.")
        self.generate_waypoint_service = rospy.ServiceProxy(
            "motion_planner/request_generate_waypoints", 
            RequestGenerateWaypointsService)
        self.load_route_by_id_service = rospy.ServiceProxy(
            "route_mission_handler/load_route_by_id",
            LoadRouteByIdSrv)
        self.global_path = rospy.wait_for_message(
            "global_path", Path)
        self.tf_prefix = rospy.get_namespace()
        self.ego_frame_id = self.tf_prefix + "base_link"
        self.ego_pose_assigner = rospy.Publisher(
            "simulation/reset_car_state", CarState, queue_size=1)
        rospy.Subscriber("waypoints", WaypointArray, self.wp_callback)

        self.tf_listener = tf.TransformListener()

        self.run()


    def run(self):
        continuous_failure_count = 0
        while True:
            result = self.run_once()

            if result:
                continuous_failure_count = 0
            else:
                continuous_failure_count += 1

            if continuous_failure_count > 5:
                self.load_route_by_id_service(self.preset_route_id)

    def run_once(self):
        try:
            speed = rospy.wait_for_message("speed_cmd", speed_cmd, timeout=1.0)
            rospy.sleep(0.5)

            sd, rot = self.tf_listener.lookupTransform(
                "frenet", "{}SD".format(self.ego_frame_id), rospy.Time(0))

            if sd[1] > 4.5:
                self._help_ego()
                return False

        except rospy.exceptions.ROSException:
            self._help_ego()
            return False

        return True
    

    def _help_ego(self):
        rospy.logwarn("[EgoStuckHelper] Ego Stuck.")
        car_state = rospy.wait_for_message("car_state", CarState)
        idx = self.find_nearest_on_global_path(car_state)
        car_state = CarState()
        car_state.pose = self.global_path.waypoints[idx].pose
        car_state.twist = TwistStamped()

        if self.init_pose_2d is not None:
            car_state.pose.pose.position.x = self.init_pose_2d.x
            car_state.pose.pose.position.y = self.init_pose_2d.y
            car_state.pose.pose.orientation.z = self.init_pose_2d.theta

        last_time_request_waypoint = rospy.Time.now()
        got_waypoints = 0


        rate = rospy.Rate(100)

        while True:
            self.ego_pose_assigner.publish(car_state)

            if not got_waypoints:

                if not hasattr(self, "deque"):
                    self.deque = deque(maxlen=1)

                if len(self.deque):
                    got_waypoints = 1
                    del self.deque

                if rospy.Time.now() - last_time_request_waypoint \
                        > rospy.Duration(3.0):
                    try:
                        last_time_request_waypoint = rospy.Time.now()
                        self.generate_waypoint_service()
                    except:
                        rospy.sleep(0.1)
            else:
                got_waypoints += 1
                if got_waypoints > 50:
                    break

            rate.sleep()


    def wp_callback(self, msg):
        if hasattr(self, "deque"):
            self.deque.append(True)



    def find_nearest_on_global_path(self, car_state):
        cx = car_state.pose.pose.position.x
        cy = car_state.pose.pose.position.y

        nearest_idx = -1.
        nearest_dist = -1.
        nearest_wp = None

        for i, wp in enumerate(self.global_path.waypoints):
            x = wp.pose.pose.position.x
            y = wp.pose.pose.position.y
            
            dist = (cx-x)**2 + (cy-y)**2

            if nearest_dist == -1 or dist < nearest_dist:
                nearest_dist = dist
                nearest_idx = i
                nearest_wp = wp

        assert nearest_idx != -1, "Path length: {}"\
            "".format(len(self.global_path.waypoints))

        return nearest_idx



            
if __name__ == '__main__':
    main()