#!/usr/bin/env python

import rospy
from geometry_msgs.msg import Quaternion, Vector3
from visualization_msgs.msg import Marker, MarkerArray
from itri_msgs.msg import DetectedObjectArray
from std_msgs.msg import ColorRGBA
import copy

class DetectedObjectsMarker:
    def __init__(self):
        rospy.Subscriber("/detected_objects", DetectedObjectArray, self.CallBackDetectedObjects)
        self.publisher = rospy.Publisher("agent_marker", MarkerArray, queue_size=1)
        self.objTemplate = Marker()
        self.objTemplate.ns = "agent_marker"
        self.objTemplate.type = 9
        self.objTemplate.action = 0
        self.objTemplate.pose.orientation = Quaternion(0, 0, 0, -1)
        self.objTemplate.color = ColorRGBA(1,1,1,1)
        self.objTemplate.scale = Vector3(1, 1, 1)
        self.objTemplate.lifetime = rospy.Duration(0.1)


    def run(self):
        rospy.spin()

    def CallBackDetectedObjects(self, msg):
        output = MarkerArray()
        for i, obj in enumerate(msg.objects):
            marker = copy.deepcopy(self.objTemplate)
            marker.header = msg.header
            marker.id = i
            marker.pose.position = obj.pose.position
            marker.pose.position.x += 3
            marker.text = str(obj.id)
            output.markers.append(copy.deepcopy(marker))

        try:
            self.publisher.publish(output)
        except AttributeError as e:
            rospy.logfatal(output)
            raise AttributeError(e)


def main():
    rospy.init_node("detected_objects_marker_node")
    marker = DetectedObjectsMarker()
    marker.run()

if __name__ == "__main__":
    main()
