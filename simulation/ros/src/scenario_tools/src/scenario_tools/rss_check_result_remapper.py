#!/usr/bin/env python
import rospy
from visualization_msgs.msg import MarkerArray
import numpy as np

def main():
    remapper = RssCheckResultRemapper()

class RssCheckResultRemapper:
    def __init__(self):
        rospy.init_node("rss_check_result_remapper_node")
        rospy.Subscriber("/scenario_visualization/old", MarkerArray, self.Callback)
        self.publisher = rospy.Publisher("/scenario_visualization", MarkerArray, queue_size=1)
        rospy.spin()

    def Callback(self, msg):
        for i, marker in enumerate(msg.markers):
            if marker.ns == "rss_safety_indicator":
                marker.ns = "rss_safety_indicator/old"
                yaw = self._get_yaw(marker.pose.orientation)
                msg.markers[i].pose.position.x += np.sin(yaw) * 0.5
                msg.markers[i].pose.position.y += np.cos(yaw) * 0.5
                msg.markers[i].scale.x = msg.markers[i].scale.y = \
                    msg.markers[i].scale.z = 0.5
        self.publisher.publish(msg)

    def _get_yaw(self, q):
        siny_cosp = 2 * (q.w * q.z + q.x * q.y)
        cosy_cosp = 1 - 2 * (q.y * q.y + q.z * q.z)
        return np.arctan2(siny_cosp, cosy_cosp)

if __name__ == '__main__':
    main()