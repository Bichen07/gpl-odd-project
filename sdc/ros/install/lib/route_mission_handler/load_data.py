#!/usr/bin/python2.7

import rospy
import rospkg

from std_msgs.msg import Header
from std_msgs.msg import String
from std_msgs.msg import Bool
from geometry_msgs.msg import Pose
from geometry_msgs.msg import Point
from route_mission_handler.msg import Pair
from route_mission_handler.msg import ItriPoint
from route_mission_handler.msg import MarkerPolygon
from route_mission_handler.msg import MarkerPolygonArray
from route_mission_handler.msg import Paths
from route_mission_handler.msg import PathsArray
from route_mission_handler.msg import Lanes
from route_mission_handler.msg import Lane
from route_mission_handler.msg import LanesArray
from route_mission_handler.msg import Waypoints
from route_mission_handler.msg import Waypoint
from route_mission_handler.msg import NavgRoad
from route_mission_handler.msg import NavgRoadArray
from route_mission_handler.msg import LaneNavgRoad
from route_mission_handler.msg import LaneNavgRoadArray
from route_mission_handler.msg import ConnectedNavgRoad
from route_mission_handler.msg import RoadLineArray
from route_mission_handler.msg import RoadLine
from route_mission_handler.msg import RoadLinePoint
from route_mission_handler.msg import ParkingSpace
from route_mission_handler.msg import ParkingSpaceArray
from route_mission_handler.msg import ParkingLot
from route_mission_handler.msg import ParkingLotArray
from route_mission_handler.msg import ParkingLane
from route_mission_handler.msg import ParkingLanePoint
from route_mission_handler.msg import TrafficLight
from route_mission_handler.msg import TrafficLightArray
import numbers
import json
import os
import numpy as np
import time

class FileManager():
    def __init__(self, folder, publisher):
        self.folder = folder
        self.publisher = publisher

    def GetWaypointsData(self, waypoints_info):
        waypoint = Waypoints()
        headingWrongCnt = 0
        if 'point_id' in waypoints_info:
            waypoint.pointId = waypoints_info['point_id']
        # elif 'id' in waypoints_info:
        #     waypoint.pointId = waypoints_info['id']

        if 'x' in waypoints_info:
            waypoint.pose.position.x = waypoints_info['x']
        if 'y' in waypoints_info:
            waypoint.pose.position.y = waypoints_info['y']
        if 'z' in waypoints_info:
            waypoint.pose.position.z = waypoints_info['z']

        if 'heading' in waypoints_info:
            waypoint.pose.orientation.w =  waypoints_info['heading']
        elif 'angle' in waypoints_info:
            if waypoints_info['angle'] is None:
                print('waypoint.pointId %d, angle is null: %s'% (waypoint.pointId, waypoints_info['angle']))
                waypoint.pose.orientation.w =  0.0
            else:
                waypoint.pose.orientation.w =  waypoints_info['angle']
            if waypoint.pose.orientation.w == 0.0:
                headingWrongCnt += 1
                print('waypoint.pointId %d, angle: %s'% (waypoint.pointId, waypoints_info['angle']))

        if 'road_width' in waypoints_info:
            waypoint.roadWidth = waypoints_info['road_width']
        elif 'width' in waypoints_info:
            waypoint.roadWidth = waypoints_info['width']
        else:
            waypoint.roadWidth = 2.0

        if 'distToLeftLine' in waypoints_info:
            waypoint.distToLeftLine = waypoints_info['distToLeftLine']
        elif 'distance_to_left_boundary' in waypoints_info:
            waypoint.distToLeftLine = waypoints_info['distance_to_left_boundary']
        elif 'left_boundary' in waypoints_info:
            waypoint.distToLeftLine = waypoints_info['left_boundary']
        else:
            waypoint.distToLeftLine = 1.0

        if 'distToRightLine' in waypoints_info:
            waypoint.distToRightLine = waypoints_info['distToRightLine']
        elif 'distance_to_right_boundary' in waypoints_info:
            waypoint.distToRightLine = waypoints_info['distance_to_right_boundary']
        elif 'right_boundary' in waypoints_info:
            waypoint.distToRightLine = waypoints_info['right_boundary']
        else:
            waypoint.distToRightLine = 1.0

        if 'right_road_bound' in waypoints_info:
            waypoint.right_road_bound = float(waypoints_info['right_road_bound'])
        if 'left_road_bound' in waypoints_info:
            waypoint.left_road_bound = float(waypoints_info['left_road_bound'])

        if 'markerId' in waypoints_info:
            waypoint.markerIds.append(int(waypoints_info['markerId']))
        elif 'road_marker_id' in waypoints_info:
            if waypoints_info['road_marker_id'] != None:
                if isinstance(waypoints_info['road_marker_id'], list):
                    for tmp in waypoints_info['road_marker_id']:
                        waypoint.markerIds.append(int(tmp))
                else:
                    waypoint.markerIds.append(int(waypoints_info['road_marker_id']))
            # elif waypoints_info['road_marker_id'] == ' ' or waypoints_info['road_marker_id'] == None:
            #     rospy.logwarn('road_marker_id none')
            # else:
            #     rospy.logwarn('road_marker_id is null')

        if 'markerType' in waypoints_info:
            waypoint.markerTypes.append(int(waypoints_info['markerType']))
        elif 'road_marker_type' in waypoints_info:
            if waypoints_info['road_marker_type'] != None:
                # print(waypoints_info['road_marker_type'])
                if isinstance(waypoints_info['road_marker_type'], list):
                    for tmp in waypoints_info['road_marker_type']:
                        waypoint.markerTypes.append(int(tmp))
                else:
                    waypoint.markerTypes.append(int(waypoints_info['road_marker_type']))
            # else:
            #     rospy.logwarn('road_marker_type is null')

        if 'curve' in waypoints_info:
            waypoint.curve = waypoints_info['curve']
        elif 'curvature' in waypoints_info:
            if waypoints_info['curvature'] is None:
                waypoint.curve = 0.0
            elif isinstance(waypoints_info['curvature'], numbers.Number):
                waypoint.curve = float(waypoints_info['curvature'])
            elif 'imag' in waypoints_info['curvature']:
                waypoint.curve = float(waypoints_info['curvature']['imag'])
                rospy.logwarn('curvature %s', waypoints_info['curvature'])
        else:
            waypoint.curve = 0.0

        # if 'lat' in waypoints_info:
        #     waypoint.geopoint.latitude = waypoints_info['lat']
        # else:
        #     waypoint.geopoint.latitude = 0.0
        #
        # if 'lng' in waypoints_info:
        #     waypoint.geopoint.longitude = waypoints_info['lng']
        # else:
        #     waypoint.geopoint.longitude = 0.0

        if 'bank_angle' in waypoints_info:
            if waypoints_info['bank_angle'] is None:
                waypoint.bank_angle = 0.0
            elif waypoints_info['bank_angle'] == ' ':
                waypoint.bank_angle = 0.0
            else:
                waypoint.bank_angle = waypoints_info['bank_angle']
        else:
            waypoint.bank_angle = 0.0

        if 'slope' in waypoints_info:
            if waypoints_info['slope'] is None:
                waypoint.slope = 0.0
            else:
                waypoint.slope = waypoints_info['slope']
        else:
            waypoint.slope = 0.0
        return waypoint, headingWrongCnt

    def ReadChangedWaypointsFile(self, fileIndex, jsonData):
        path = Paths()
        laneId = 0
        headingCnt = 0
        if 'handdrive' in jsonData:
            path.handdrive = jsonData['handdrive']
        for globalpath_index in range(len(jsonData['waypoints'])):
            if 'global_path' in jsonData['waypoints'][globalpath_index]:
                for path_info in jsonData['waypoints'][globalpath_index]['global_path']:
                    lane = Lanes()
                    if 'lane_id' in path_info:
                        laneId = int(path_info['lane_id'])
                    else:
                        laneId += 1
                    lane.id = laneId

                    for waypoints_info in path_info['points']:
                        waypoint, headingErrorCnt = self.GetWaypointsData(waypoints_info)
                        waypoint.laneId = laneId
                        lane.waypoints.append(waypoint)
                        headingCnt += headingErrorCnt
                    rospy.loginfo("ReadChangedWaypointsFile 1, lane %d, points len %d", lane.id, len(lane.points))
                    path.lanes.append(lane)
            else:
                waypoints_info = jsonData['waypoints'][globalpath_index]
                lane = Lanes()
                if 'lane_id' in waypoints_info:
                    laneId = int(waypoints_info['lane_id'])
                else:
                    laneId += 1
                lane.id = laneId
                if 'points' in waypoints_info:
                    if waypoints_info['points'] == None:
                        rospy.loginfo("laneId %d no points", laneId)
                    else:
                        for point_index in range(len(waypoints_info['points'])):
                            waypoint, headingErrorCnt = self.GetWaypointsData(waypoints_info['points'][point_index])
                            waypoint.laneId = laneId
                            # if waypoint.pointId % 10 == 0:
                            #     rospy.loginfo("ReadChangedWaypointsFile, waypoint lane %d, pointId %d, x,y,z %f,%f,%f, curve %f",
                            #         waypoint.laneId, waypoint.pointId, waypoint.pose.position.x, waypoint.pose.position.y,waypoint.pose.position.z, waypoint.curve)
                            # path.waypoints.append(waypoint)
                            lane.points.append(waypoint)
                            headingCnt += headingErrorCnt
                else:
                    waypoint, headingErrorCnt = self.GetWaypointsData(waypoints_info)
                    waypoint.laneId = laneId
                    lane.points.append(waypoint)
                    headingCnt += headingErrorCnt

                    rospy.loginfo("ReadChangedWaypointsFile, waypoint lane %d, pointId %d, x,y,z %f,%f,%f, curve %f",
                        waypoint.laneId, waypoint.pointId, waypoint.pose.position.x, waypoint.pose.position.y,waypoint.pose.position.z, waypoint.curve)
                    # path.waypoints.append(waypoint)
                # rospy.loginfo("ReadChangedWaypointsFile 2, lane %d, points len %d, headingCnt %d", lane.id, len(lane.points), headingCnt)
                path.lanes.append(lane)

        rospy.loginfo("ReadChangedWaypointsFile, path.lanes size %ld, headingCnt %d", len(path.lanes), headingCnt)
        return path

    def ReadNavgRoadsFile(self, jsonData):
        navgroadArray = NavgRoadArray()
        rospy.loginfo("ReadNavgRoadsFile, len(jsonData['navgroads'] %ld", len(jsonData['navgroads']))
        cnt = 0
        for navgroad_index in range(len(jsonData['navgroads'])):
            navgroad = NavgRoad()
            cnt +=1
            for path_info in jsonData['navgroads'][navgroad_index]:
                data = jsonData['navgroads'][navgroad_index][path_info]
                if path_info == 'id':
                    navgroad.id = data
                elif path_info == 'nav_croad_id':
                    navgroad.id = data

                if path_info == "length":
                    navgroad.length = float(data)

                if path_info == "mode":
                    navgroad.mode = data
                if path_info == "n_as":
                    navgroad.n_as = data
                if path_info == "n_kph":
                    navgroad.n_kph = data
                if path_info == "type":
                    navgroad.type = data
                if path_info == "p_as":
                    navgroad.p_as = data
                if path_info == "p_kph":
                    navgroad.p_kph = data
                if path_info == "r_class" and data != None:
                    navgroad.r_class = data
                if path_info == "routing" and data != None:
                    navgroad.routing = data
                if path_info == "two_way":
                    navgroad.twoWay = data
                elif path_info == 'direction':
                    navgroad.twoWay = data

                if path_info == "pos_lanes" and data != None:
                    if isinstance(data, list):
                        for lane_id in data:
                            navgroad.positiveLaneIds.append(int(lane_id))

                if path_info == "neg_lanes" and data != None:
                    if isinstance(data, list):
                        for lane_id in data:
                            navgroad.negativeLaneIds.append(int(lane_id))

                if path_info == "heads" or path_info == "head_point":
                    if isinstance(data, list):
                        for heads_info in data:
                            # print(heads_info)
                            if heads_info != None and heads_info != 'nan':
                                nr = ConnectedNavgRoad()
                                if isinstance(heads_info, dict):
                                    nr.id = int(heads_info['id'])
                                    nr.pointId = int(heads_info['point_id'])
                                elif heads_info != "None":
                                    nr.id = int(heads_info)
                                navgroad.heads.append(nr)
                    elif data != None:
                        for heads_info in data:
                            nr = ConnectedNavgRoad()
                            nr.id = -1
                            if 'id' in heads_info:
                                nr.id = heads_info['id']
                                nr.pointId = heads_info['point_id']
                            elif heads_info != '' and heads_info != ' ':
                                if isinstance(heads_info, str):
                                    nr.id = int(heads_info)
                                else:
                                    print(heads_info)
                                    rospy.logwarn("ReadNavgRoadsFile, heads_info not str type")
                            if nr.id >= 0:
                                navgroad.heads.append(nr)

                if path_info == "tails" or path_info == "end_point":
                    if isinstance(data, list):
                        for tails_info in data:
                            # print(tails_info)
                            if tails_info != None and tails_info != 'nan':
                                nr = ConnectedNavgRoad()
                                if isinstance(tails_info, dict):
                                    nr.id = int(tails_info['id'])
                                    nr.pointId = int(tails_info['point_id'])
                                elif tails_info != "None":
                                    nr.id = int(tails_info)
                                navgroad.tails.append(nr)
                    elif data != None:
                        for tails_info in data:
                            nr = ConnectedNavgRoad()
                            nr.id = -1
                            rospy.loginfo("ReadNavgRoadsFile, tails_info %s!", tails_info)
                            if 'id' in tails_info:
                                nr.id = tails_info['id']
                                nr.pointId = tails_info['point_id']
                            elif tails_info != '' and tails_info != ' ':
                                if isinstance(tails_info, str):
                                    nr.id = int(tails_info)
                                else:
                                    print(tails_info)
                                    rospy.logwarn("ReadNavgRoadsFile, tails_info not str type")
                            if nr.id >= 0:
                                navgroad.tails.append(nr)

                if path_info == "points" and data is not None:
                    tempNavgId = -1
                    for point_info in data:
                        # rospy.loginfo("ReadNavgRoadsFile, point_info %s", point_info)
                        point = ItriPoint()
                        if 'id' in point_info:
                            point.id = point_info['id']
                        if 'nav_croad_id' in point_info:
                            point.belongId = point_info['nav_croad_id']
                            # rospy.loginfo("ReadNavgRoadsFile npoint.belongId %d, navgroad.id %d", point.belongId, navgroad.id)
                            if navgroad.id != point.belongId:
                                if len(navgroad.points) > 0:
                                    navgroadArray.navgroads.append(navgroad)
                                    # rospy.loginfo("ReadNavgRoadsFile navgroadArray add navg %d, point size %ld", navgroad.id, len(navgroad.points))
                                navgroad = NavgRoad()
                                navgroad.id = point.belongId
                                # rospy.loginfo("ReadNavgRoadsFile add new navg %d", navgroad.id)
                        elif navgroad.id == 0:
                            point.belongId = cnt
                        else:
                            point.belongId = navgroad.id
                        if 'point_id' in point_info:
                            point.pointId = point_info['point_id']

                        # ns = NavSatFix()
                        # if 'lat' in point_info:
                        #     point.geopoint.latitude = point_info['lat']
                        # if 'lng' in point_info:
                        #     point.geopoint.longitude = point_info['lng']

                        if 'x' in point_info:
                            point.pose.position.x = point_info['x']
                        if 'y' in point_info:
                            point.pose.position.y = point_info['y']
                        if 'z' in point_info:
                            point.pose.position.z = point_info['z']
                        if 'heading' in point_info:
                            point.pose.orientation.w =  point_info['heading']
                        # rospy.loginfo("ReadNavgRoadsFile navgroad %d, position %f, %f, %f", navgroad.id, point.pose.position.x, point.pose.position.y, point.pose.position.z)
                        navgroad.points.append(point)
            # rospy.loginfo("ReadNavgRoadsFile navgroad %d, mode %d, points %d", navgroad.id, navgroad.mode, len(navgroad.points))
            navgroadArray.navgroads.append(navgroad)
        return navgroadArray

    def ReadLanesNavgRoadsFile(self, jsonData):
        laneNavgRoadArray = LaneNavgRoadArray()
        for laneNavg_info in jsonData['lanes_navgroads']:

            lanenavgroad = LaneNavgRoad()
            lanenavgroad.lane_id = laneNavg_info['lane_id']
            if 'navgroad1' in laneNavg_info:
                lanenavgroad.navgroad1 = laneNavg_info['navgroad1']
            elif 'nav_croad1_id' in laneNavg_info:
                lanenavgroad.navgroad1 = laneNavg_info['nav_croad1_id']

            if 'isPositive1' in laneNavg_info:
                lanenavgroad.isPositive1 = laneNavg_info['isPositive1']
            elif 'croad1_positive' in laneNavg_info:
                lanenavgroad.isPositive1 = laneNavg_info['croad1_positive']

            if 'navgroad2' in laneNavg_info:
                lanenavgroad.navgroad2 = laneNavg_info['navgroad2']
            elif 'nav_croad2_id' in laneNavg_info:
                lanenavgroad.navgroad2 = laneNavg_info['nav_croad2_id']

            if 'isPositive2' in laneNavg_info:
                lanenavgroad.isPositive2 = laneNavg_info['isPositive2']
            elif 'croad2_positive' in laneNavg_info:
                lanenavgroad.isPositive2 = laneNavg_info['croad2_positive']

            if 'laneno' in laneNavg_info:
                lanenavgroad.laneno = laneNavg_info['laneno']
            if 'seqner' in laneNavg_info and laneNavg_info['seqner'] != None:
                print(laneNavg_info['seqner'])
                if isinstance(laneNavg_info['seqner'], str):
                    lanenavgroad.seqner = laneNavg_info['seqner']
                else:
                    print("seqner not string")
            laneNavgRoadArray.lanenavgroads.append(lanenavgroad)
        return laneNavgRoadArray

    def ReadLaneInfoFile(self, index, jsonData):
        lane = Lanes()

        if 'lane_id' in jsonData:
            lane.id = jsonData['lane_id']
        elif 'id' in jsonData:
            lane.id = jsonData['id']
        else:
            lane.id = index

        if 'isTurn' in jsonData:
            lane.isTurn = int(jsonData['isTurn']) == 1
        elif 'subtype' in jsonData and jsonData['subtype'] != ' ':
            lane.isTurn = int(jsonData['subtype']) == 1
        else:
            lane.isTurn = False

        if 'direction' in jsonData:
            lane.direction = int(jsonData['direction']) == 1
        else:
            lane.direction = False

        if 'nexts' in jsonData:
            if ',' in jsonData['nexts']:
                nexts = jsonData['nexts'].split(',')
            else:
                nexts = jsonData['nexts'].split()
            for temp in nexts:
                lane.nexts.append(int(temp))
        elif 'next_clane' in jsonData and jsonData['next_clane'] != None:
            for laneid in jsonData['next_clane']:
                lane.nexts.append(int(laneid))

        if 'laneno' in jsonData:
            lane.laneno = int(jsonData['laneno'])
        else:
            lane.laneno = 0

        if 'speed_limit' in jsonData:
            lane.max_speed_limit = int(jsonData['speed_limit'])

        if 'type' in jsonData:
            lane.type = int(jsonData['type'])
        else:
            lane.type = 0

        lane.roadLineIds.append(0)
        lane.roadLineIds.append(0)
        if 'roadLineIds' in jsonData:
            roadLineIds = jsonData['roadLineIds'].split()
            pcnt = 0
            for temp in roadLineIds:
                lane.roadLineIds[pcnt] = int(temp)
                pcnt = pcnt + 1
                # rospy.loginfo("lane %d, lane.roadLineIds[%d] = %d", lane.id, pcnt, int(temp))
        elif 'roadlines' in jsonData:
            pcnt = 0
            if jsonData['roadlines'] != None:
                for temp in jsonData['roadlines']:
                    lane.roadLineIds[pcnt] = int(temp)
                    pcnt = pcnt + 1
                    # rospy.loginfo("lane %d, lane.roadLineIds[%d] = %d", lane.id, pcnt, int(temp))
        else:
            if 'lroadline_id' in jsonData:
                lane.roadLineIds[0] = int(jsonData['lroadline_id'])
            if 'rroadline_id' in jsonData:
                lane.roadLineIds[1] = int(jsonData['rroadline_id'])
        # rospy.loginfo("lane %d, roadLineIds len %d",lane.id, len(lane.roadLineIds))
        return lane

    def GetLanes(self, filedir):
        laneArray = LanesArray()
        json_files, filedir = self.CheckFileOrDir(filedir)

        for file_index in range(len(json_files)):
            with open(filedir + '/' + json_files[file_index]) as json_data:
                print(filedir + '/' + json_files[file_index])
                jsonData = json.load(json_data)
                if 'lanes' in jsonData:
                    for lane_index in range(len(jsonData['lanes'])):
                        lane = self.ReadLaneInfoFile((lane_index + 1), jsonData['lanes'][lane_index])
                        laneArray.lanes.append(lane)

        if len(laneArray.lanes) > 0:
            publisher["PubLanes"].publish(laneArray)
            rospy.loginfo("publish topic [/laneinfo_fromfile]")

    def GetRoadLinesFromFile(self, jsonData):
        lineArray = RoadLineArray()
        lineId = 1
        prevPnt = Point()
        prevPnt.x = 0
        prevPnt.y = 0
        prevPnt.z = 0

        for i in range(int(len(jsonData['roadlines']))):
            dataJson = jsonData['roadlines'][i]
            line = RoadLine()
            if 'id' in dataJson:
                line.id = dataJson['id']
            elif 'roadline_id' in dataJson:
                line.id = dataJson['roadline_id']
            else:
                line.id = lineId
                lineId += 1

            if 'points' not in dataJson:
                print("road line %d not points"%(line.id))
            else:
                points = dataJson['points']
                if points is not None:
                    line.points, prevPnt = self.GetPointsOfRoadLine(points, prevPnt)
            lineArray.lines.append(line)
            # print("lineArray line id %d, points num %d"%(line.id, len(line.points)))
        rospy.loginfo("GetRoadLinesFromFile, lineArray publish lineArray len %d", len(lineArray.lines))
        publisher["PubRoadLine"].publish(lineArray)

    def ParseRoadMarker(self, markerJson):
        marker = MarkerPolygon()
        if 'type' in markerJson:
            marker.type = markerJson['type']
        elif 'category' in markerJson:
            marker.type = markerJson['category']

        if 'id' not in markerJson:
            marker.id = cnt
        else:
            marker.id = markerJson['id']

        if 'on' in markerJson:
            marker.on = int(markerJson['on']) == 1
        else:
            marker.on = True

        if 'value' in markerJson:
            marker.value = markerJson['value']
        else:
            marker.value = ''
        rospy.loginfo("ParseRoadMarker marker %d(%d) on %d, value %s", marker.id, marker.type, marker.on, marker.value)
        if 'lanes' in markerJson and markerJson['lanes'] != None:
            for pairId in range(len(markerJson['lanes'])):
                pair = Pair()
                pairJson = markerJson['lanes'][pairId]
                if 'lane_id' in pairJson:
                    pair.laneId = int(pairJson['lane_id'])
                if 'pointIds' in pairJson and pairJson['pointIds'] is not None:
                    # print("pointId num %d"%len(pairJson['pointIds']))
                    for pntId in range(len(pairJson['pointIds'])):
                        pair.pointIds.append(int(pairJson['pointIds'][pntId]))
                # print("pair laneId %d, pointIds num %d"%(pair.laneId, len(pair.pointIds)))
                marker.pairs.append(pair)
        elif 'lane_id' in markerJson:
            if isinstance(markerJson['lane_id'], int):
                rospy.loginfo("lane_id is int type %d", markerJson['lane_id'])
            else:
                for laneId in markerJson['lane_id']:
                    pair = Pair()
                    pair.laneId = int(laneId)
                    marker.pairs.append(pair)
        else:
            pair = Pair()
            if 'lane_id' in markerJson:
                pair.laneId = int(markerJson['lane_id'])

            if 'point_ids' in markerJson:
                point_ids = markerJson['point_ids'].split()
                for temp in point_ids:
                    pair.pointIds.append(int(temp))
            elif 'point_id' in markerJson:
                pair.pointIds.append(int(markerJson['point_id']))
            rospy.loginfo("ParseRoadMarker marker %d add pair laneId %d, pointIds num %d", marker.id, pair.laneId, len(pair.pointIds))
            marker.pairs.append(pair)

        # if 'lat' in markerJson:
        #     marker.center_geopoint.latitude = markerJson['lat']
        # else:
        #     marker.center_geopoint.latitude = 0.0
        # # center lat, lng, x, y, z
        # if 'lng' in markerJson:
        #     marker.center_geopoint.longitude = markerJson['lng']
        # else:
        #     marker.center_geopoint.longitude = 0.0

        if 'center_point' in markerJson:
            center_point = markerJson['center_point']
            if 'x' in center_point and center_point['x'] != None:
                marker.center_point.x = float(center_point['x'])
            if 'y' in center_point and center_point['y'] != None:
                marker.center_point.y = float(center_point['y'])
            if 'z' in center_point and center_point['z'] != None:
                marker.center_point.z = float(center_point['z'])

        if 'points' not in markerJson:
            rospy.logwarn("No points key in marker")
        else:
            rect_points = markerJson['points']
            for pid in range(len(rect_points)):
                pnt = Point();
                if 'x' in rect_points[pid]:
                    pnt.x = float(rect_points[pid]['x'])
                if 'y' in rect_points[pid]:
                    pnt.y = float(rect_points[pid]['y'])
                if 'z' in rect_points[pid]:
                    pnt.z = float(rect_points[pid]['z'])
                # print("ParseRoadMarker x %f, y %f, z %f"%(pnt.x, pnt.y, pnt.z))
                marker.corner_points.append(pnt)

                # ns = NavSatFix();
                # if 'lat' in rect_points[pid]:
                #     ns.latitude = rect_points[pid]['lat']
                # if 'lng' in rect_points[pid]:
                #     ns.longitude = rect_points[pid]['lng']
                # if ns.latitude != 0 and ns.longitude != 0:
                #     marker.corner_geopoints.append(ns)

        if 'cloud_points' in markerJson and markerJson['cloud_points'] is not None:
            print("cloud_points num %d"%len(markerJson['cloud_points']))
            points = []
            cloud_points = markerJson['cloud_points']
            for pntId in range(len(cloud_points)):
                x = cloud_points[pntId]['x']
                y = cloud_points[pntId]['y']
                z = cloud_points[pntId]['z']
                r = cloud_points[pntId]['r']
                g = cloud_points[pntId]['g']
                b = cloud_points[pntId]['b']
                rgb = (r << 16 | g << 8 | b);
                if pntId % 20 == 0:
                    print("pntId %d, r %d, g %d, b %d, rgb %d"%(pntId, r, g, b, rgb))
                pt = [x, y, z, rgb]
                points.append(pt)
            fields = [PointField('x', 0, PointField.FLOAT32, 1), PointField('y', 4, PointField.FLOAT32, 1), PointField('z', 8, PointField.FLOAT32, 1), PointField('rgba', 12, PointField.UINT32, 1)]

            header = Header()
            header.frame_id = "map"
            # marker.color_cloud_ptr = point_cloud2.create_cloud(header, fields, points)
        # print("ParseRoadMarker done, marker id %d, type %d"%(marker.id, marker.type))
        return marker

    def GetNoAccessibleFromFile(self, jsonData):
        polygonArray = MarkerPolygonArray()
        cnt = 0
        if 'non_accessible' in jsonData:
            publisher = self.publisher["PubNonAccessibles"]
            data = jsonData['non_accessible']
            rospy.loginfo("parse non_accessible")
        elif 'curbs':
            publisher = self.publisher["PubCurbs"]
            data = jsonData['curbs']
            rospy.loginfo("parse curbs")
        print("GetNoAccessibleFromFile num %d"%(len(data)))
        for i in range(int(len(data))):
            dataJson = data[i]
            marker = MarkerPolygon()
            if 'id' in dataJson:
                marker.id = dataJson['id']
            if 'category' in dataJson:
                marker.type = dataJson['category']
            if 'type' in dataJson:
                marker.type = dataJson['type']
            # rospy.loginfo("GetNoAccessibleFromFile marker %d, type %d", marker.id, marker.type)

            if 'nav_croad_id' in dataJson:
                marker.navgId = dataJson['nav_croad_id']

            if 'lane_id' in dataJson or 'lane_ids' in dataJson:
                if 'lane_id' in dataJson:
                    lane_key = 'lane_id'
                else:
                    lane_key = 'lane_ids'
                    # rospy.loginfo("GetNoAccessibleFromFile 2 lane_key: %s, len %d", lane_key, len(dataJson[lane_key]))
                if dataJson[lane_key] is not None:
                    for index in range(len(dataJson[lane_key])):
                        pair = Pair()
                        # print("GetNoAccessibleFromFile lane_id %s"%(dataJson[lane_key][index]))
                        if dataJson[lane_key][index] != '':
                            pair.laneId = int(dataJson[lane_key][index])
                            marker.pairs.append(pair)
                else:
                    rospy.loginfo("GetNoAccessibleFromFile dataJson[lane_key] is None")

            if 'points' in dataJson and dataJson['points'] != None:
                rect_points = dataJson['points']
                for pid in range(len(rect_points)):
                    pnt = Point();
                    pnt.x = rect_points[pid]['x']
                    pnt.y = rect_points[pid]['y']
                    pnt.z = rect_points[pid]['z']
                    marker.corner_points.append(pnt)
            else:
               print(dataJson['points'])
            polygonArray.markers.append(marker)
        publisher.publish(polygonArray)
        rospy.loginfo("publish topic")

    def GetRoadMarkerFromFile(self, jsonData):
        polygonArray = MarkerPolygonArray()
        cnt = 0
        if 'roadmarkers' in jsonData:
            data = jsonData['roadmarkers']
            rospy.loginfo("parse roadmarkers")
        elif 'no_temperate_parking_zone' in jsonData:
            data = jsonData['no_temperate_parking_zone']
            rospy.loginfo("parse no_temperate_parking_zone")
        elif 'pedestrian_crossing' in jsonData:
            data = jsonData['pedestrian_crossing']
            rospy.loginfo("parse pedestrian_crossing")
        print("GetRoadMarkerFromFile num %d"%(len(data)))
        for i in range(int(len(data))):
            laneJson = data[i]
            if 'lane_id' in laneJson:
                lane_id = laneJson['lane_id']

            if 'markers' in laneJson:
                for id in range(len(laneJson['markers'])):
                    markerJson = laneJson['markers'][id]
                    cnt += 1
                    marker = self.ParseRoadMarker(markerJson)
                    polygonArray.markers.append(marker)
            else:
                marker = self.ParseRoadMarker(laneJson)
                polygonArray.markers.append(marker)
        self.publisher["PubRoadMarkers"].publish(polygonArray)
        rospy.loginfo("publish topic [/road_markers_display]")

    def GetParkingSpaceFromFile(self, jsonData):
        spaceArray = ParkingSpaceArray()
        cnt = 0
        print("GetParkingSpaceFromFile num %d"%(len(jsonData['parking_space'])))
        for i in range(int(len(jsonData['parking_space']))):
            dataJson = jsonData['parking_space'][i]
            space = ParkingSpace()
            if 'space_id' in dataJson:
                space.id = dataJson['space_id']
            if 'order_type' in dataJson:
                space.orderType = dataJson['order_type']

            if 'lane_id' in dataJson:
                space.laneId = dataJson['lane_id']
            if 'point_id' in dataJson:
                space.pointId = dataJson['point_id']
            if 'type' in dataJson:
                space.type = dataJson['type']
            if 'parkinglot_id' in dataJson:
                space.parkingLotId = dataJson['parkinglot_id']
            if 'side' in dataJson:
                space.side = dataJson['side']
            # rospy.loginfo("GetParkingSpaceFromFile space %d, type %d, side %d, laneId %d, pointId %d", space.id, space.type, space.side, space.laneId, space.pointId)

            # if 'lat' in dataJson:
            #     space.geopoint.latitude = dataJson['lat']
            # if 'lng' in dataJson:
            #     space.geopoint.longitude = dataJson['lng']

            if 'points' in dataJson:
                for id in range(len(dataJson['points'])):
                    pntJson = dataJson['points'][id]
                    orderPnt = Point()
                    if 'x' in pntJson:
                        orderPnt.x = pntJson['x']
                    if 'y' in pntJson:
                        orderPnt.y = pntJson['y']
                    if 'z' in pntJson:
                        orderPnt.z = pntJson['z']
                    space.points.append(orderPnt)
            spaceArray.spaces.append(space)
        self.publisher["PubParkingSpaces"].publish(spaceArray)
        rospy.loginfo("publish topic [/parking_spaces]")

    def GetWaypointData(self, jsonData):
        waypoint = Waypoint()
        if 'point_id' in jsonData:
            waypoint.point_id = jsonData['point_id']

        if 'x' in jsonData:
            waypoint.point.x = jsonData['x']
        if 'y' in jsonData:
            waypoint.point.y = jsonData['y']
        if 'z' in jsonData:
            waypoint.point.z = jsonData['z']

        if 'heading' in jsonData:
            waypoint.heading =  jsonData['heading']

        if 'road_width' in jsonData:
            waypoint.roadWidth = jsonData['road_width']

        if 'distToLeftLine' in jsonData:
            waypoint.distToLeftLine = jsonData['distToLeftLine']

        if 'distToRightLine' in jsonData:
            waypoint.distToRightLine = jsonData['distToRightLine']

        if 'left_road_bound' in jsonData:
            waypoint.left_road_bound = float(jsonData['left_road_bound'])

        if 'right_road_bound' in jsonData:
            waypoint.right_road_bound = float(jsonData['right_road_bound'])

        if 'road_marker_id' in jsonData:
            if jsonData['road_marker_id'] != None:
                if isinstance(jsonData['road_marker_id'], list):
                    for tmp in jsonData['road_marker_id']:
                        waypoint.markerIds.append(int(tmp))
                else:
                    waypoint.markerIds.append(int(jsonData['road_marker_id']))

        if 'road_marker_type' in jsonData:
            if jsonData['road_marker_type'] != None:
                # print(waypoints_info['road_marker_type'])
                if isinstance(jsonData['road_marker_type'], list):
                    for tmp in jsonData['road_marker_type']:
                        waypoint.markerTypes.append(int(tmp))
                else:
                    waypoint.markerTypes.append(int(jsonData['road_marker_type']))
            # else:
            #     rospy.logwarn('road_marker_type is null')

        if 'curve' in jsonData:
            waypoint.curvature = jsonData['curve']
        return waypoint

    def GetParkingLaneFromFile(self, jsonData):
        lotArray = ParkingLotArray()
        cnt = 0
        print("GetParkingLaneFromFile num %d"%(len(jsonData['parking_lanes'])))
        for i in range(int(len(jsonData['parking_lanes']))):
            dataJson = jsonData['parking_lanes'][i]
            lot = ParkingLot()
            if 'parkinglot_id' in dataJson:
                lot.id = dataJson['parkinglot_id']
            if 'lanes' in dataJson and dataJson['lanes'] != None:
                for temp in dataJson['lanes']:
                    # print(temp)
                    plane = ParkingLane()
                    if 'lane_id' in temp:
                        plane.id = temp['lane_id']
                    if 'points' in temp and temp['points'] != None:
                        for p in range(int(len(temp['points']))):
                            pnt = temp['points'][p]
                            lanePoint = ParkingLanePoint()
                            if 'lane_id' in pnt:
                                lanePoint.laneId = pnt['lane_id']
                            if 'point_id' in pnt:
                                lanePoint.pointId = pnt['point_id']
                            plane.points.append(lanePoint)
                    lot.lanes.append(plane)
                    rospy.loginfo("GetParkingLaneFromFile lot %d add lane %d with points num %d",
                        lot.id, plane.id, len(plane.points))

            lotArray.lots.append(lot)
            rospy.loginfo("GetParkingLaneFromFile lotArray add lot %d", lot.id)
        self.publisher["PubParkingLane"].publish(lotArray)
        rospy.loginfo("publish topic [/parking_lanes], len %ld", len(lotArray.lots))

    def GetParkingLotFromFile(self, jsonData):
        lotArray = ParkingLotArray()
        cnt = 0
        print("GetParkingLotFromFile num %d"%(len(jsonData['parking_lot'])))
        for i in range(int(len(jsonData['parking_lot']))):
            dataJson = jsonData['parking_lot'][i]
            lot = ParkingLot()
            if 'id' in dataJson:
                lot.id = dataJson['id']
            if 'name' in dataJson:
                lot.name = dataJson['name']

            if 'nav_croad_id' in dataJson:
                lot.nav_croad_id = dataJson['nav_croad_id']
            if 'point_id' in dataJson:
                lot.pointId1 = dataJson['point_id']
            if 'nav_croad_id2' in dataJson:
                lot.nav_croad_id2 = dataJson['nav_croad_id2']
            if 'point_id2' in dataJson:
                lot.pointId2 = dataJson['point_id2']
            if 'positive' in dataJson:
                lot.croad1_positive = dataJson['positive']
            if 'positive2' in dataJson:
                lot.croad2_positive = dataJson['positive2']

            rospy.loginfo("GetParkingLotFromFile parking lot %d(%s), nv1 %d(%d), nv2 %d(%d)", lot.id, lot.name, lot.nav_croad_id, lot.pointId1, lot.nav_croad_id2, lot.pointId2)
            lotArray.lots.append(lot)
        self.publisher["PubParkingLot"].publish(lotArray)
        rospy.loginfo("publish topic [/parking_lots], len %ld", len(lotArray.lots))

    def GetTrafficLightFromFile(self, jsonData):
        lightArray = TrafficLightArray()
        cnt = 0
        print("GetTrafficLightFromFile num %d"%(len(jsonData['traffic_light'])))
        for i in range(int(len(jsonData['traffic_light']))):
            dataJson = jsonData['traffic_light'][i]
            lot = TrafficLight()
            if 'id' in dataJson:
                lot.id = dataJson['id']
            if 'lane_ids' in dataJson and dataJson['lane_ids'] != ' ' and dataJson['lane_ids'] != None:
                # print(dataJson['lane_ids'])
                if ';' in dataJson['lane_ids']:
                    lanes = dataJson['lane_ids'].split(';')
                    for temp in lanes:
                        lot.laneIds.append(int(temp))
                elif isinstance(dataJson['lane_ids'], list):
                    for temp in dataJson['lane_ids']:
                        lot.laneIds.append(int(temp))
                elif isinstance(dataJson['lane_ids'], int):
                    lot.laneIds.append(int(dataJson['lane_ids']))

            # if 'lat' in dataJson:
            #     lot.geopoint.latitude = dataJson['lat']
            # if 'lng' in dataJson:
            #     lot.geopoint.longitude = dataJson['lng']

            if 'category' in dataJson:
                lot.type = dataJson['category']
            if 'light_num' in dataJson:
                lot.lightNum = dataJson['light_num']
            if 'vps' in dataJson and dataJson['vps'] != None:
                lot.vps = dataJson['vps']
            if 'vpe' in dataJson and dataJson['vpe'] != None:
                lot.vpe = dataJson['vpe']
            if 'heading' in dataJson:
                lot.heading = dataJson['heading']
            if 'lights' in dataJson:
                for id in range(len(dataJson['lights'])):
                    if isinstance(dataJson['lights'][id], list):
                        for id2 in range(len(dataJson['lights'][id])):
                            lightstr = dataJson['lights'][id][id2]
                            lot.lights.append(lightstr)
                    else:
                        lightstr = dataJson['lights'][id]
                        # rospy.loginfo("GetTrafficLightFromFile 1 lightstr %s", lightstr.encode('utf-8'))
                        lot.lights.append(lightstr)
                    # rospy.loginfo("GetTrafficLightFromFile lights len %d", len(lot.lights))
            if 'points' in dataJson:
                for id in range(len(dataJson['points'])):
                    pointJson = dataJson['points'][id]
                    if isinstance(pointJson, list):
                        for id2 in range(len(pointJson)):
                            point = Point()
                            point.x = float(pointJson[id2]['x'])
                            point.y = float(pointJson[id2]['y'])
                            point.z = float(pointJson[id2]['z'])
                            lot.points.append(point)
                    else:
                        point = Point()
                        point.x = float(pointJson['x'])
                        point.y = float(pointJson['y'])
                        point.z = float(pointJson['z'])
                        lot.points.append(point)
            rospy.loginfo("GetTrafficLightFromFile light %d(%d), vpe %s, vpe %s, heading %f, point %d, lights %d", lot.id, lot.lightNum, lot.vps, lot.vpe, lot.heading, len(lot.points), len(lot.lights))
            lightArray.lights.append(lot)
        self.publisher["PubTrafficLight"].publish(lightArray)
        rospy.loginfo("publish topic [/traffic_lights], len %ld", len(lightArray.lights))

    # def GetDistanceBetweenPoints(self, point1, point2):
    #     return math.sqrt((point2.x - point1.x) * (point2.x - point1.x) +
    #         (point2.y - point1.y)*(point2.y - point1.y) +
    #         (point2.z - point1.z)*(point2.z - point1.z));

    def GetPointsOfRoadLine(self, points, prevPnt):
        pointId = 1
        pointArray = []
        pointNum = len(points)
        for pid in range(len(points)):
            currentPnt = Point()
            currentPnt.x = points[pid]['x']
            currentPnt.y = points[pid]['y']
            currentPnt.z = points[pid]['z']

            # if prevPnt.x is not 0 and prevPnt.y is not 0 and prevPnt.z is not 0:
                # dist = self.GetDistanceBetweenPoints(currentPnt, prevPnt)
                # if dist < 0.3:
                #     continue;

            pnt = RoadLinePoint();
            if 'point_id' not in points[pid]:
                pnt.id = pointId
                pointId += 1
            else:
                pnt.id = points[pid]['point_id']
                if len(pointArray) > 0 and pnt.id - 1 > pointArray[len(pointArray) - 1].id:
                    pnt.id = pointArray[len(pointArray) - 1].id + 1

            if 'type' not in points[pid]:
                pnt.type = 0
            else:
                pnt.type = points[pid]['type']
            pnt.position.x = currentPnt.x
            pnt.position.y = currentPnt.y
            pnt.position.z = currentPnt.z

            # if pnt.id == pointNum:
            #     print("point x %f, y %f, z %f", pnt.position.x, pnt.position.y, pnt.position.z)
            pointArray.append(pnt)

            prevPnt.x = pnt.position.x
            prevPnt.y = pnt.position.y
            prevPnt.z = pnt.position.z
        return pointArray, prevPnt

    def CheckFileOrDir(self, filedir):
        json_files = []
        if os.path.isdir(filedir):
            json_files = [f for f in os.listdir(filedir) if f.endswith(".json")]
            json_files = sorted(json_files, key = lambda x: x.rsplit('.', 1)[0])
        else:
            json_files.append(filedir)
            filedir=''
            print("CheckFileOrDir json file name %ld"%(len(json_files)))
        return json_files, filedir

    def ShowAllData(self, filedir):
        pathArray = PathsArray()
        pathNavgArray = NavgRoadArray()
        laneNavgRoadArray = LaneNavgRoadArray()
        laneArray = LanesArray()
        # filedir = self.folder["filedir"] + self.folder["waypoints_folder_name"]
        json_files, filedir = self.CheckFileOrDir(filedir)

        index = 1
        waypointsfile_flag = False
        for file_index in range(len(json_files)):
            time.sleep(0.5)
            with open(filedir + '/' + json_files[file_index]) as json_data:
                rospy.loginfo("ShowAllData filename %s",json_files[file_index])
                jsonData = json.load(json_data)
                if 'waypoints' in jsonData:
                    path=None

                    path = self.ReadChangedWaypointsFile(index, jsonData)
                    waypointsfile_flag = True
                if waypointsfile_flag :
                    path.name = json_files[file_index]
                    pathArray.paths.append(path)
                    index += 1
                    waypointsfile_flag = False

                    if len(pathArray.paths) > 0:
                        self.publisher["PubGlobalPathPoints"].publish(pathArray)
                        rospy.loginfo("publish topic [/global_waypoints_display]")
                    else:
                        rospy.logwarn("pathArray no paths")
                elif 'navgroads' in  jsonData:
                    pathNavgArray = self.ReadNavgRoadsFile(jsonData)

                    if len(pathNavgArray.navgroads) > 0:
                        self.publisher["PubNavgRoadPaths"].publish(pathNavgArray)
                        rospy.loginfo("publish topic [/global_navgroads_display]")
                    else:
                        rospy.logwarn("pathNavgArray no navgroads")
                elif 'lanes_navgroads' in  jsonData:
                    laneNavgRoadArray = self.ReadLanesNavgRoadsFile(jsonData)

                    if len(laneNavgRoadArray.lanenavgroads) > 0:
                        self.publisher["PubLaneNavgRoadPaths"].publish(laneNavgRoadArray)
                        rospy.loginfo("publish topic [/global_lanenavgroads_display]")
                    else:
                        rospy.logwarn("laneNavgRoadArray no lanenavgroads")
                elif 'lanes' in jsonData:
                    self.GetLanes(filedir + '/' + json_files[file_index])
                elif 'roadmarkers' in jsonData or 'no_temperate_parking_zone' in jsonData or 'pedestrian_crossing' in jsonData:
                    self.GetRoadMarkerFromFile(jsonData)
                elif 'non_accessible' in jsonData  or 'curbs' in jsonData:
                    self.GetNoAccessibleFromFile(jsonData)
                elif 'roadlines' in jsonData:
                    self.GetRoadLinesFromFile(jsonData)
                elif 'traffic_light' in jsonData:
                    self.GetTrafficLightFromFile(jsonData)
                elif 'parking_space' in jsonData:
                    self.GetParkingSpaceFromFile(jsonData)
                elif 'parking_lot' in jsonData:
                    self.GetParkingLotFromFile(jsonData)
                elif 'parking_lanes' in jsonData:
                    self.GetParkingLaneFromFile(jsonData)
                else:
                    rospy.logwarn('ShowAllData not parse %s', json_files[file_index])


    def ShowRoadLines(self, filedir):
        json_files, filedir = self.CheckFileOrDir(filedir)
        rospy.loginfo("ShowRoadLines Load %s, json file num %ld", filedir, len(json_files))

        for json_file_index in range(len(json_files)):
            with open(filedir + '/' + json_files[json_file_index]) as json_data:
                jsonData = json.load(json_data)
                self.GetRoadLinesFromFile(jsonData)

    def ShowRoadMarker(self, filedir):
        json_files, filedir = self.CheckFileOrDir(filedir)
        print("ShowRoadMarker filedir %s, json file name %ld"%(filedir, len(json_files)))
        for json_file_index in range(len(json_files)):
            with open(filedir + '/' + json_files[json_file_index]) as json_data:
                print(filedir + '/' + json_files[json_file_index])
                jsonData = json.load(json_data)
                if 'roadmarkers' in jsonData or 'no_temperate_parking_zone' in jsonData or 'pedestrian_crossing' in jsonData:
                    self.GetRoadMarkerFromFile(jsonData)
                elif 'non_accessible' in jsonData or 'curbs' in jsonData:
                    self.GetNoAccessibleFromFile(jsonData)
                else:
                    rospy.logwarn("ShowRoadMarker not marker file")

    def ShowNavgRoads(self, filedir):
        json_files, filedir = self.CheckFileOrDir(filedir)
        print("ShowNavgRoads filedir %s, json file name %ld"%(filedir, len(json_files)))
        for json_file_index in range(len(json_files)):
            with open(filedir + '/' + json_files[json_file_index]) as json_data:
                print(filedir + '/' + json_files[json_file_index])
                jsonData = json.load(json_data)
                if 'lanes_navgroads' in jsonData:
                    laneNavgRoadArray = self.ReadLanesNavgRoadsFile(jsonData)
                    if len(laneNavgRoadArray.lanenavgroads) > 0:
                        self.publisher["PubLaneNavgRoadPaths"].publish(laneNavgRoadArray)
                        rospy.loginfo("publish topic [/global_lanenavgroads_display]")
                elif 'navgroads' in jsonData:
                    pathNavgArray = self.ReadNavgRoadsFile(jsonData)
                    if len(pathNavgArray.navgroads) > 0:
                        self.publisher["PubNavgRoadPaths"].publish(pathNavgArray)
                        rospy.loginfo("publish topic [/global_navgroad_display]")
                elif 'points' in jsonData:
                    self.ReadNavgRoadsFile(jsonData)
                else:
                    rospy.logwarn("ShowNavgRoads not marker file")

    def ShowParkingSpace(self, filedir):
        json_files, filedir = self.CheckFileOrDir(filedir)
        print("ShowParkingSpace filedir %s, json file name %ld"%(filedir, len(json_files)))
        for json_file_index in range(len(json_files)):
            with open(filedir + '/' + json_files[json_file_index]) as json_data:
                print(filedir + '/' + json_files[json_file_index])
                jsonData = json.load(json_data)
                if 'parking_space' in jsonData:
                    self.GetParkingSpaceFromFile(jsonData)
                elif 'parking_lot' in jsonData:
                    self.GetParkingLotFromFile(jsonData)
                else:
                    rospy.logwarn("ShowParkingSpace not parking related file")

    def ShowTrafficLight(self, filedir):
        json_files, filedir = self.CheckFileOrDir(filedir)
        print("ShowTrafficLight filedir %s, json file name %ld"%(filedir, len(json_files)))
        for json_file_index in range(len(json_files)):
            with open(filedir + '/' + json_files[json_file_index]) as json_data:
                print(filedir + '/' + json_files[json_file_index])
                jsonData = json.load(json_data)
                if 'traffic_light' in jsonData:
                    self.GetTrafficLightFromFile(jsonData)
                else:
                    rospy.logwarn("ShowTrafficLight not parking related file")

    def ShowGlobalPath(self, filedir):
        pathArray = PathsArray()
        json_files, filedir = self.CheckFileOrDir(filedir)

        index = 1
        waypointsfile_flag = False
        for file_index in range(len(json_files)):
            rospy.loginfo("ShowGlobalPath filename %s",json_files[file_index])
            with open(filedir + '/' + json_files[file_index]) as json_data:
                jsonData = json.load(json_data)
                path = Paths()
                waypointsfile_flag = False
                if 'waypoints' in jsonData:
                    waypointsfile_flag = True
                    # if os.path.exists(self.folder["raw_data_path"]):
                    #     rospy.logwarn("ShowAllData:: splited file exist")
                    #     with open(self.folder["raw_data_path"]) as json_data:
                    #         jsonData = json.load(json_data)
                    #     path = self.ReadChangedWaypointsFile(index, jsonData)
                    # else:
                    path = self.ReadChangedWaypointsFile(index, jsonData)
                # elif 'global_path' in jsonData:
                #     waypointsfile_flag = True
                #     path = self.ReadWaypointJsonFile(index, jsonData)

                if waypointsfile_flag:
                    path.name = json_files[file_index]
                    pathArray.paths.append(path)
                    index += 1

        if len(pathArray.paths) > 0:
            self.publisher["PubGlobalPathPoints"].publish(pathArray)
            rospy.loginfo("publish topic [/global_waypoints_display]")

if __name__ == '__main__' :
    try:
        rospy.loginfo('main')
        rospy.init_node('load_file_node', anonymous=True)
        rospack = rospkg.RosPack()
        # pkgPath = rospack.get_path('route_mission_handler')

        folder = {}
        route = rospy.get_param('~route', None)
        pkgPath = rospy.get_param('~map_data', None)

        publisher = {}
        navgroad_display_pub = rospy.get_param('~navgroad_display', None)
        lanenavgroad_display_pub = rospy.get_param('~lanenavgroad_display', None)

        waypoints_display_pub = rospy.get_param('~waypoints_display', None)
        roadline_display_pub = rospy.get_param('~roadline_display', None)
        roadmarker_display_pub = rospy.get_param('~roadmarker_display', None)
        intersections_display_pub = rospy.get_param('~intersections_display', None)

        publisher["PubLaneNavgRoadPaths"] = rospy.Publisher(lanenavgroad_display_pub, LaneNavgRoadArray, queue_size=1, latch=True)
        publisher["PubNavgRoadPaths"] = rospy.Publisher(navgroad_display_pub, NavgRoadArray, queue_size=1, latch=True)
        publisher["PubGlobalPathPoints"] = rospy.Publisher(waypoints_display_pub, PathsArray, queue_size=1, latch=True)
        publisher["PubRoadLine"] = rospy.Publisher(roadline_display_pub, RoadLineArray, queue_size=1, latch=True)
        publisher["PubRoadMarkers"] = rospy.Publisher(roadmarker_display_pub, MarkerPolygonArray, queue_size=1, latch=True)
        publisher["PubLanes"] = rospy.Publisher('/laneinfo_fromfile', LanesArray, queue_size=1, latch=True)
        publisher["PubNonAccessibles"] = rospy.Publisher('/non_accessibles', MarkerPolygonArray, queue_size=1, latch=True)
        publisher["PubCurbs"] = rospy.Publisher('/curbs', MarkerPolygonArray, queue_size=1, latch=True)
        publisher["PubParkingSpaces"] = rospy.Publisher('/parking_spaces', ParkingSpaceArray, queue_size=1, latch=True)
        publisher["PubParkingLot"] = rospy.Publisher('/parking_lots', ParkingLotArray, queue_size=1, latch=True)
        publisher["PubParkingLane"] = rospy.Publisher('/parking_lanes', ParkingLotArray, queue_size=1, latch=True)
        publisher["PubTrafficLight"] = rospy.Publisher('/traffic_lights',TrafficLightArray, queue_size=1, latch=True)

        loadCompletedPub = rospy.Publisher('/load_completed', Bool, queue_size=1, latch=True)

        folder["filedir"] = pkgPath + '/data/' + route + '/'

        filemanager = FileManager(folder, publisher)
        filemanager.ShowAllData(folder['filedir'])
        rospy.loginfo("ShowAllData finish!")

        doneMsg = Bool()
        time.sleep(0.5)
        loadCompletedPub.publish(doneMsg)
        rospy.loginfo("publish load completey!")
        rospy.spin()

    except rospy.ROSInterruptException:
        pass
