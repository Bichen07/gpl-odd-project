#!/usr/bin/env python
import rospy

from itri_msgs.msg import BehaviorState
from route_mission_handler.srv import LoadRouteByIdSrv


def main():
    rospy.init_node("auto_restart_handler_node", anonymous=True)
    handler = AutoRestartHandler()


class AutoRestartHandler:

    RESET_ROUTE_ID = 5

    def __init__(self):
        rospy.loginfo("[AutoRestartHandler] Initialize.")
        reset_service_handler = rospy.ServiceProxy(
            "route_mission_handler/load_route_by_id", LoadRouteByIdSrv)
        self.reset_operation = \
            lambda: reset_service_handler(self.RESET_ROUTE_ID);

        self.behavior_state = {"last": None, "timestamp": None}

        # rospy.Publisher("")
        rospy.Subscriber("behavior_state",
                         BehaviorState,
                         self.behavior_state_callback)
        rospy.loginfo("[AutoRestartHandler] "\
            "Wait for route_mission_handler/load_route_by_id service.")
        rospy.wait_for_service("route_mission_handler/load_route_by_id")
        rospy.loginfo("[AutoRestartHandler] Start Running.")
        rospy.spin()

    def behavior_state_callback(self, msg):
        if msg.behavior_state != self.behavior_state["last"]:
            self.behavior_state["last"] = msg.behavior_state
            self.behavior_state["timestamp"] = rospy.Time.now()
        else:
            lasting = (rospy.Time.now() \
                      - self.behavior_state["timestamp"]).to_sec()
            if msg.behavior_state in [17, 18] and lasting > 10. :
                # DestinationWaypoints, DestinationGlobalPath
                rospy.loginfo("[MmslSimulation] Reset route_mission_handler")
                self.reset_operation()
                self.behavior_state["last"] = None

if __name__ == '__main__':
    main()