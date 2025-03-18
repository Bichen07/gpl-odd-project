#!/usr/bin/python2.7

import json
import os
import numpy as np
import rospy
import rospkg
import matplotlib.pyplot as plt
from matplotlib.pyplot import cm
from route_mission_handler.msg import PathsArray

use_map = None

def CalCurvature(lane):
    a = np.array(lane)
    dx_dt = np.gradient(a[:, 0])
    dy_dt = np.gradient(a[:, 1])
    velocity = np.array([ [dx_dt[i], dy_dt[i]] for i in range(dx_dt.size)])

    ds_dt = np.sqrt(dx_dt * dx_dt + dy_dt * dy_dt)


    tangent = np.array([1/ds_dt] * 2).transpose() * velocity
    tangent_x = tangent[:, 0]
    tangent_y = tangent[:, 1]

    deriv_tangent_x = np.gradient(tangent_x)
    deriv_tangent_y = np.gradient(tangent_y)

    dT_dt = np.array([ [deriv_tangent_x[i], deriv_tangent_y[i]] for i in range(deriv_tangent_x.size)])

    length_dT_dt = np.sqrt(deriv_tangent_x * deriv_tangent_x + deriv_tangent_y * deriv_tangent_y)

    normal = np.array([1/length_dT_dt] * 2).transpose() * dT_dt

    d2s_dt2 = np.gradient(ds_dt)
    d2x_dt2 = np.gradient(dx_dt)
    d2y_dt2 = np.gradient(dy_dt)
    curvature = np.abs(d2x_dt2 * dy_dt - dx_dt * d2y_dt2) / (dx_dt * dx_dt + dy_dt * dy_dt+0.001)**1.5
    return curvature

def CheckFileValue(route, waypoints, key, check_route=False):
    route_x, route_y = [], []
    raw_key_data = []
    line = []
    points_id = []
    route_num = 0
    color=iter(cm.rainbow(np.linspace(0,1,len(waypoints))))
    if check_route:
        for route_id in route:
            c = next(color)
            for lane in waypoints:
                if lane["lane_id"] == int(route_id):
                    for point in lane["points"]:
                        route_x.append(float(point["x"]))
                        route_y.append(float(point["y"]))

                        if key == "curvature":
                            if point["curvature"]:
                                if type(point["curvature"]) is float:
                                    raw_key_data.append(float(point["curvature"]))
                                elif type(point["curvature"]) is dict:
                                    raw_key_data.append(float(point["curvature"]["imag"]))
                            else:
                                raw_key_data.append(0.0)
                        if key == "angle":
                            raw_key_data.append(point["angle"])

                        route_num = route_num + 1
                        points_id.append(point["id"])
                        line.append([point["x"], point["y"]])
    else:
        for lane in waypoints:
            for point in lane["points"]:
                route_x.append(float(point["x"]))
                route_y.append(float(point["y"]))

                if key == "curvature":
                    if point["curvature"]:
                        if type(point["curvature"]) is float:
                            raw_key_data.append(float(point["curvature"]))
                        elif type(point["curvature"]) is dict:
                            raw_key_data.append(float(point["curvature"]["imag"]))
                    else:
                        raw_key_data.append(0.0)
                if key == "angle":
                    raw_key_data.append(point["angle"])

                route_num = route_num + 1
                points_id.append(point["id"])
                line.append([point["x"], point["y"]])
    plt.figure()
    plt.title("Check "+key+"'s values on the "+ use_map +" map")
    idx = []
    for i in range(len(raw_key_data)):
        idx.append(i)
    plt.plot(idx, raw_key_data)
    plt.scatter(idx, raw_key_data, color='red')
    plt.show()

def CheckFileOrDir(filepath):
    json_files = []
    if os.path.isdir(filepath):
        json_files = [f for f in os.listdir(filepath) if f.endswith(".json")]
        json_files = sorted(json_files, key = lambda x: x.rsplit('.', 1)[0])
    else:
        json_files.append(filepath)
        filepath=''
        print("CheckFileOrDir json file name %ld"%(len(json_files)))
    return json_files, filepath


if __name__ == "__main__":
    rospy.init_node("checkvalue", anonymous=True)

    rospack = rospkg.RosPack()
    pkgPath = rospack.get_path('route_mission_handler')
    use_map = rospy.get_param('~route', None)
    check_route = rospy.get_param('~check_route', None)

    artc_navgcroad = rospy.get_param('~artc_navgcroad', None)
    artc_lanes = rospy.get_param('~artc_lanes', None)

    itri_navgcroad = rospy.get_param('~itri_navgcroad', None)
    itri_lanes = rospy.get_param('~itri_lanes', None)

    folder = {}
    filepath = pkgPath + '/data/' + use_map + '/'
    json_files, filedir = CheckFileOrDir(filepath)
    if "waypoints.json" in json_files:
        with open(filedir + "/waypoints.json", 'r') as f:
            data = json.load(f)
    waypoints = data["waypoints"]
    if use_map == "itri":
        CheckFileValue(itri_lanes.split(","), waypoints, "angle", check_route=check_route)
        CheckFileValue(itri_lanes.split(","), waypoints, "curvature", check_route=check_route)
    elif use_map == "artc":
        CheckFileValue(artc_lanes.split(","), waypoints, "angle", check_route=check_route)
        CheckFileValue(artc_lanes.split(","), waypoints, "curvature", check_route=check_route)

    rospy.spin()
