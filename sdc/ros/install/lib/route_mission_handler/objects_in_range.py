#!/usr/bin/python2.7
import rospy
import rospkg

from std_msgs.msg import Header
from std_msgs.msg import Int32
from geometry_msgs.msg import Pose
from geometry_msgs.msg import Point
# from geometry_msgs.msg import Polygon
from geometry_msgs.msg import Polygon, PolygonStamped, Point32
from route_mission_handler.msg import ObjectsInRange
from itri_msgs.msg import CarState
from shapely.geometry import Polygon as sPolygon
from shapely.geometry import LineString
from shapely.geometry import MultiPolygon
from shapely.ops import cascaded_union
from jsk_recognition_msgs.msg import PolygonArray
from matplotlib import pyplot
import numbers
import json
import os
import numpy as np
import time
import random

class ValidObjectsManager():

    def DoPolygon(self, coords):
        r = LineString(coords)
        rp = sPolygon(r)
        sp = rp.simplify(0.05, preserve_topology=False)
        return sp

    def DoBuffer(self, coords, size):
        r = LineString(coords)
        vp = r.buffer(size, cap_style=3)
        vp = vp.simplify(0.05, preserve_topology=False)
        return vp

    def GetPolygonStamp(self, polygon, header):
        ps = PolygonStamped()
        ps.header = header
        for p in list(polygon.exterior.coords):
            p32 = Point32()
            p32.x = p[0]
            p32.y = p[1]
            ps.polygon.points.append(p32)
        return ps

    def DisplayVirtualPolygons(self, polygons):
        msg = PolygonArray()
        header = Header()
        header.frame_id = "/map"
        header.stamp = rospy.Time.now()
        msg.header = header
        for vp in polygons:
            ps = PolygonStamped()
            ps.header = header
            for p in list(vp.exterior.coords)[::-1]:
                p32 = Point32()
                p32.x = p[0]
                p32.y = p[1]
                ps.polygon.points.append(p32)
            msg.polygons.append(ps)
        rospy.loginfo("DisplayVirtualPolygons polygons num %ld, msg.polygons %ld",
            len(polygons), len(msg.polygons))
        self.virtualObjectsPub.publish(msg)

    def HandleLanes(self, lanes):
        rospy.loginfo("HandleLanes lanes num %ld", len(lanes))
        polygons = []
        for lane in lanes:
            waypoints = lane.points
            if len(waypoints) > 1:
                coords = []
                for pnt in waypoints:
                    coords.append((pnt.pose.position.x, pnt.pose.position.y))
                vp = self.DoBuffer(coords, 3.0)
                polygons.append(vp)
        self.DisplayVirtualPolygons(polygons)
        return polygons

    def Union(self, range, virual_polygons, objects):
        polygons = []
        coords = []
        for pnt in range.points:
            coords.append((pnt.x, pnt.y))
        rp = self.DoPolygon(coords)
        # each object union with range
        for vp in virual_polygons:
            uvp = rp.intersection(vp)
            if uvp.area > 0:
                if isinstance(uvp, MultiPolygon):
                    for plg in uvp.geoms:
                        polygons.append(plg)
                else:
                    polygons.append(uvp)
        rospy.loginfo("Union, add virtual polygons %ld", len(polygons))
        if isinstance(objects, sPolygon):
            ubp = rp.intersection(objects)
            if ubp.area > 0:
                if isinstance(ubp, MultiPolygon):
                    rospy.loginfo("Union multipolygon, geoms num %d",
                        len(ubp.geoms))
                    for plg in ubp.geoms:
                        polygons.append(plg)
                else:
                    polygons.append(ubp)
        else:
            for bp in objects:
                ubp = rp.intersection(bp)
                if ubp.area > 0:
                    if isinstance(ubp, MultiPolygon):
                        rospy.loginfo("Union multipolygon, geoms num %d",
                            len(ubp.geoms))
                        for plg in ubp.geoms:
                            polygons.append(plg)
                    else:
                        polygons.append(ubp)
        rospy.loginfo("Union, add roadline, polygons %ld", len(polygons))
        return polygons

    def ConvertRosPolygon(self, objects):
        bps = []
        for o in objects:
            # covert type
            bcoords = []
            for pnt in o.points:
                bcoords.append((pnt.x, pnt.y))
            bp = self.DoPolygon(bcoords)
            bb = self.DoBuffer(bcoords, 1.0)
            bps.append(bp)
            bps.append(bb)
        unp = cascaded_union(bps)
        return unp;

    def ObjectsCallback(self, msg):
        rospy.loginfo("ObjectsCallback, range points num %ld, lanes num %ld, "
            "objects size %ld, changed %d",
            len(msg.range.points), len(msg.lanes), len(msg.objects), msg.changed)
        self.range = msg.range;
        self.lanes = msg.lanes;
        self.objects = msg.objects;
        if msg.changed:
            self.virual_polygons = self.HandleLanes(self.lanes)
            self.lane_objects = self.ConvertRosPolygon(self.objects);
        final_polygons = self.Union(
            self.range, self.virual_polygons, self.lane_objects)
        unionp = None
        if len(final_polygons) > 0:
            pubMsg = PolygonArray()
            header = Header()
            header.frame_id = "/map"
            header.stamp = rospy.Time.now()
            pubMsg.header = header

            unionp = cascaded_union(final_polygons)
            if isinstance(unionp, MultiPolygon):
                rospy.loginfo("ObjectsCallback multipolygon, geoms num %d",
                    len(unionp.geoms))
                for plg in unionp.geoms:
                    ps = self.GetPolygonStamp(plg, header)
                    pubMsg.polygons.append(ps)
            else:
                ps = self.GetPolygonStamp(unionp, header)
                pubMsg.polygons.append(ps)
            if len(pubMsg.polygons) >= 2:
                rospy.logwarn("Publish validObjectsPub object num %d",
                    len(pubMsg.polygons))
            self.validObjectsPub.publish(pubMsg)

    def __init__(self):
        self.lanes = []
        self.objects = []
        self.virual_polygons = []
        self.lane_objects = []
        self.range = None

        self.pathSub = rospy.Subscriber(
            "/objects_inrange", ObjectsInRange, self.ObjectsCallback)
        self.virtualObjectsPub = rospy.Publisher("/virtual_objects", PolygonArray, queue_size=10)
        self.validObjectsPub = rospy.Publisher("/valid_objects", PolygonArray, queue_size=10)
        rospy.spin()

if __name__ == '__main__' :
    try:
        rospy.loginfo('objects_inrange_node main')
        rospy.init_node('objects_inrange_node', anonymous=True)
        rospack = rospkg.RosPack()
        manager = ValidObjectsManager()
    except rospy.ROSInterruptException:
        pass
