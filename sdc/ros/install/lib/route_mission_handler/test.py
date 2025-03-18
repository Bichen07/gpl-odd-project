#!/usr/bin/python2.7
import rospy
import rospkg

from std_msgs.msg import Header
from std_msgs.msg import Int32
from geometry_msgs.msg import Pose
from geometry_msgs.msg import Point
from route_mission_handler.msg import CroadLanesArray
from itri_msgs.msg import CarState
import numbers
import json
import os
import numpy as np
import time
import random
import tf

class SimulateManager():

    def PublishCarState(self, pose):
        rospy.loginfo("PublishCarState")
        msg = CarState();
        msg.pose.pose = pose
        msg.twist.twist.linear.x = 20 #speed
        self.carStatePub.publish(msg)

        self.br.sendTransform(
            (pose.position.x, pose.position.y, pose.position.z),
            tf.transformations.quaternion_from_euler(0, 0, pose.orientation.z),
            rospy.Time.now(),
            "base_link", "map")

    def SimulateDrive(self):
        if self.currentLane == None:
            self.currentLane = random.choice(
                self.mLaneArray[self.mLaneIndex].lanes)

        self.mPointIndex += self.mRate
        if self.mPointIndex >= len(self.currentLane.waypoints):
            self.mLaneIndex += 1
            if self.mLaneIndex >= len(self.mLaneArray):
                rospy.loginfo("SimulateDrive mLaneIndex %d > len mLaneArray, stop",
                    self.mLaneIndex)
                self.mState = 0
                self.Reset()
                # self.PublishMode(self.mState)
                return
            while len(self.mLaneArray[self.mLaneIndex].lanes) == 0:
                self.mLaneIndex += 1
                self.mPointIndex = 0
                rospy.loginfo("SimulateDrive, no lanes, add mLaneIndex %d",
                    self.mLaneIndex)

            rospy.loginfo("SimulateDrive self.mLaneArray len %d, new mLaneArray[%d].lanes num %d",
                 len(self.mLaneArray), self.mLaneIndex, len(self.mLaneArray[self.mLaneIndex].lanes))
            if len(self.mLaneArray[self.mLaneIndex].lanes) > 1:
                self.currentLane = random.choice(self.mLaneArray[self.mLaneIndex].lanes)
            else:
                self.currentLane = self.mLaneArray[self.mLaneIndex].lanes[0]
            self.mPointIndex = 0
            rospy.loginfo("SimulateDrive mLaneIndex %d, new currentLane %d, "
                "mPointIndex %d",
                self.mLaneIndex, self.currentLane.lane_id, self.mPointIndex)
            waypoint = self.currentLane.waypoints[self.mPointIndex]
        else:
            rospy.loginfo("SimulateDrive currentLane %d, mPointIndex %d",
                self.currentLane.lane_id, self.mPointIndex)
            waypoint = self.currentLane.waypoints[self.mPointIndex]

        pose = Pose()
        pose.position.x = waypoint.point.x
        pose.position.y = waypoint.point.y
        pose.position.z = waypoint.point.z
        pose.orientation.z = waypoint.heading
        self.PublishCarState(pose)

    def PathCallback(self, msg):
        rospy.loginfo("PathCallback, path name %s", msg.name)
        # global mLanes, mNavgRoads
        self.mLaneArray = msg.clanes;
        # self.mLanes = msg.lanes;
        rospy.loginfo("PathCallback, mLaneArray num %d",
            len(self.mLaneArray))
        if len(self.mLaneArray) > 0:
            rospy.loginfo("PathCallback, first mLaneArray's lanes num %d",
                len(self.mLaneArray[0].lanes)

    def RateSetCallback(self, msg):
        self.mRate = msg.data
        rospy.loginfo("RateSetCallback, rate %d", self.mRate)

    # mState 0: idle, 1: start, 2: stop
    def Reset(self):
        if self.mState == 0:
            self.mPointIndex = 0
            self.mLaneIndex = 0
            self.currentLane = None
            rospy.loginfo("Reset reset mPointIndex %d, mLaneIndex %d",
                self.mPointIndex, self.mLaneIndex)

    def ActionCallback(self, msg):
        rospy.loginfo("ActionCallback action %s", msg.data)
        # global mState
        if self.mState == msg.data:
            return;
        self.mState = msg.data
        self.Reset()
        # self.PublishMode(self.mState)

    def __init__(self):
        self.mLaneArray = []
        self.currentLane = None
        self.mLaneIndex = 0
        self.mPointIndex = 0

        self.mState = 0
        self.mRate = 1
        self.pathSub = rospy.Subscriber(
            "/path_lanes", CroadLanesArray, self.PathCallback)
        self.rateSub = rospy.Subscriber(
            "/drive_rate", Int32, self.RateSetCallback)
        self.actionSub = rospy.Subscriber(
            "/action_event", Int32, self.ActionCallback)
        self.carStatePub = rospy.Publisher("/car_state", CarState, queue_size=10)
        self.br = tf.TransformBroadcaster()
        rate = rospy.Rate(10) # 10hz
        while not rospy.is_shutdown():
            if self.mState == 1:
                self.SimulateDrive()
                # time.sleep(0.1)
            rate.sleep()


if __name__ == '__main__' :
    try:
        rospy.loginfo('main')
        rospy.init_node('simulate_driveing_node', anonymous=True)
        rospack = rospkg.RosPack()
        filemanager = SimulateManager()
    except rospy.ROSInterruptException:
        pass
