#!/usr/bin/env python

import rospy
from tf2_msgs.msg import TFMessage
from collections import deque
import copy

class TfStaticRemapper:

    def __init__(self):

        self.mappings = self.GetMappings()
        self.subscriber = rospy.Subscriber(
            "/tf_static_old", TFMessage, self.Callback)
        self.publisher = rospy.Publisher(
            "/tf_static", TFMessage, queue_size=1)
        self.tf_publisher = rospy.Publisher(
            "/tf", TFMessage, queue_size=1)
        # self.subscriber = rospy.Subscriber(
        #     "/tf", TFMessage, self.Callback_tf)
        
        self.velodyne_msg = None
        self.allMsgs = deque()

    def GetMappings(self):
        mappings = rospy.get_param("/tf_remapper/mappings")
        newMappings = {}
        """
        Convert original format of 
        [{"old": OLD_NAME1, "new": NEW_NAME1}, 
         {"old": OLD_NAME2, "new": NEW_NAME2},
         {"old": OLD_NAME3, "new": NEW_NAME3}]
        to
        {"OLD_NAME1": "NEW_NAME1", 
         "OLD_NAME2": "NEW_NAME2", 
         "OLD_NAME3": "NEW_NAME3"}
        """
        for item in mappings:
            newMappings[item["old"]] = item["new"]
        return newMappings

    def Callback_tf(self, msgs):
        for msg in msgs.transforms:
            if msg.header.frame_id == "map":
                rospy.loginfo("child: {}".format(msg.child_frame_id))

    def Callback(self, msg):
    
        for i, transform in enumerate(msg.transforms):

            frame = transform.header.frame_id
            newFrame = self.mappings.get(frame)
            if newFrame:
                msg.transforms[i].header.frame_id = newFrame

            frame = transform.child_frame_id
            newFrame = self.mappings.get(frame)
            if newFrame:
                msg.transforms[i].child_frame_id = newFrame

        try:
            self.publisher.publish(msg)
        except rospy.ROSException as e:
            rospy.logerr("[tf_static_remapper] {}".format(e))

    def run(self):
        rospy.spin()


if __name__ == '__main__':
    rospy.init_node("tf_static_remapper_node")
    remapper = TfStaticRemapper()
    remapper.run()