#!/usr/bin/env python2

from itri_msgs.msg import VehicleState
from geometry_msgs.msg import Point, Pose, PoseArray, \
    PoseStamped, PolygonStamped
from jsk_recognition_msgs.msg import PolygonArray
from route_mission_handler.msg import Path
from shapely.geometry import LineString
import numpy as np
import json
import rospy
import os
from geo import *

def processLineString(line_raw):
    points = []
    for pt in line_raw['points']:
        points.append([pt['x'], pt['y']])
    if len(points) > 1:
        line = LineString(points)
        return line.simplify(0.15, preserve_topology=False)
    else:
        return None

def quaternion2Yaw(q):
    siny_cosp = 2. * (q.w * q.z + q.x * q.y);
    cosy_cosp = 1. - 2. * (q.y * q.y + q.z * q.z);

    return np.arctan2(siny_cosp, cosy_cosp);

class Node:
    def __init__(self):
        rospy.init_node("remote_path_plan")

        self.ORIGIN = [24.8482262475, 120.930716756, 25.587]
        self.vehicle_pose = None
        self.vehicle_state = None
        self.simulation = rospy.get_param('~simulation', False)

        self.sub_vehicle_state = rospy.Subscriber(
            '/vehicle_state', VehicleState, self.callbackVehicleState)
        self.sub_remote_request = rospy.Subscriber(
            '/remote_path_plan/request', Point, self.callbackRequest)
        self.sub_local_result = rospy.Subscriber(
            '/navigation_path', Path, self.callbackResult)
        self.sub_vehicle_pose = rospy.Subscriber(
            '/predict_pose', PoseStamped, self.callbackVehiclePose)
        self.info_publisher = rospy.Publisher(
            '/remote_path_plan/info', Pose, queue_size=1)
        self.result_publisher = rospy.Publisher(
            '/remote_path_plan/result', PolygonArray, queue_size=1)
        self.request_publisher = rospy.Publisher(
            '/remote_path_plan_request', PoseArray, queue_size=1)

    def callbackVehicleState(self, msg):
        self.vehicle_state = msg

    def callbackRequest(self, msg):
        if self.vehicle_pose is not None and \
           self.vehicle_state is not None:
            request = PoseArray()
            request.poses.append(self.vehicle_pose)
            pose = Pose()
            pose.position = msg
            request.poses.append(pose)
            if self.simulation or \
               self.vehicle_state.mode == VehicleState.MANUAL:
                self.request_publisher.publish(request)

    def callbackResult(self, msg):
        result = PolygonArray()
        for road in msg.nroads:
            road_poly = PolygonStamped()
            for pt in road.points:
                point = Point()
                point.x, point.y = self.en_to_ll(pt.x, pt.y)
                point.x -= self.ORIGIN[0]
                point.y -= self.ORIGIN[1]
                road_poly.polygon.points.append(point)
            result.polygons.append(road_poly)
        self.result_publisher.publish(result)

    def callbackVehiclePose(self, msg):
        self.vehicle_pose = msg.pose
        self.vehicle_pose.orientation.z = quaternion2Yaw(msg.pose.orientation)
        self.vehicle_pose.position.x, self.vehicle_pose.position.y = \
            self.en_to_ll(
                self.vehicle_pose.position.x, self.vehicle_pose.position.y)
        self.info_publisher.publish(self.vehicle_pose)

    def ll_to_en(self, lat, lng):
        x, y, z =  geodetic_to_enu(lat, lng, self.ORIGIN[2],
            self.ORIGIN[0], self.ORIGIN[1], self.ORIGIN[2])
        return x, y

    def en_to_ll(self, x, y):
        lat, lng, h = enu_to_geodetic(x, y, self.ORIGIN[2],
            self.ORIGIN[0], self.ORIGIN[1], self.ORIGIN[2])
        return lat, lng

    def run(self):
        rospy.spin()

def main():
    node = Node()
    node.run()

if __name__ == "__main__":
    main()
