import os
from collections import OrderedDict
import matplotlib.pyplot as plt
import yaml, json
import ast

import rospy, rosbag
import numpy as np
import rosgraph_msgs.msg as rosgraph_msgs
import visualization_msgs.msg as visualization_msgs
import itri_msgs.msg as itri_msgs
import std_msgs.msg as std_msgs
import jsk_recognition_msgs.msg as jsk_recognition_msgs
import sensor_msgs.msg as sensor_msgs
import geometry_msgs.msg as geometry_msgs
import simulation_msgs.msg as simulation_msgs
import scenario_msgs.msg as scenario_msgs
import tf2_msgs.msg as tf2_msgs

from simulation_utils.converter import QuaternionToVector3

TIME_MATCHING_DOWN_SAMPLE_RATE = 5
VEHICLE_TRAJ_DOWN_SAMPLE_RATE = 5

def get_record_topics():
    recorded_topics_json_file = rospy.get_param(
        "accident_recorder/topics",
        "".join(["/project/mmsl_simulation/src/"\
            "simulation_monitor/config/recorded_data.json"]))

    all_topics_to_record = []

    with open(recorded_topics_json_file, "r") as f:
        topics = json.load(f)

    for topic_catagory in topics["topic_catagory"]:
        for key, value in topics[topic_catagory].items():
            try:
                module_name, msg_type = value.split('/')
                try:
                    all_topics_to_record.append({
                        "name": str(key),
                        "value": globals()[
                            str(module_name)].__dict__[str(msg_type)]
                    })
                except KeyError as e:
                    rospy.logfatal("KeyError: {}, value: {}\n\tname: {}, type: {}"\
                        "".format(key, value, module_name, msg_type))
                    raise KeyError(e)

            except Exception as e:
                rospy.logfatal("{}: Fail to parse topic name {}"\
                    "".format(e, key))
                raise Exception(e)

    return all_topics_to_record

def identify_response_to_dict(res):
    data = {
        "brief": res.brief,
        "results": []
    }
    for result in res.results:
        data["results"].append(
            {
                "matched": result.matched,
                "type": result.type,
                "case": result.case,
                "responsibility": result.responsibility,
                "notes": ast.literal_eval(result.notes)
            }
        )
    return data

def record_json(profile, json_path, run_path, identified_result):
    with open(json_path, "w") as json_file:
        to_string = str(profile)
        to_dict = yaml.load(to_string)
        json.dump(to_dict, json_file, indent=4, sort_keys=True)

    if not os.path.isfile(run_path):
        with open(run_path, "w") as json_file:
            json.dump(identified_result, json_file, indent=4, sort_keys=True)
    else:
        with open(run_path, "r+") as json_file:
            try:
                data = json.load(json_file)
                data.update(identified_result)
                json_file.seek(0)
            except Exception as e:
                rospy.logwarn("[ARcd] {}".format(e))
                data = identified_result
            json.dump(data, json_file, indent=4, sort_keys=True)

def record_bag(records, bag_path, start_time, end_time):
    with rosbag.Bag(bag_path, "w") as bag:
        i_rec = -1
        i_rec_max = len(records) - 1
        while i_rec < i_rec_max - 1:
            i_rec += 1

            # not popping in this state, so the order is ok
            record = records[i_rec]

            t = record["t"]
            topic = record["topic"]
            msg = record["msg"]

            if t < start_time or t > end_time: continue
            bag.write(topic, msg, t)

def draw_image(records, profile, img_path, start_time, end_time):

        def _offset(heading, length=0.4):
            return  length * np.cos(heading), length * np.sin(heading)

        def _road_line(x, y, heading, dist_l, dist_r):
            # front s+ / left d+
            return (
                (
                    x + dist_l * np.cos(heading + np.pi / 2.),
                    y + dist_l * np.sin(heading + np.pi / 2.)
                ),
                (
                    x + dist_r * np.cos(heading - np.pi / 2.),
                    y + dist_r * np.sin(heading - np.pi / 2.)
                )
            )

        def draw_route(forward_route, opposite_route):
            for route in (forward_route, opposite_route):
                road_line_xs_l, road_line_ys_l = [], []
                road_line_xs_r, road_line_ys_r = [], []
                for wp in route:  # path_msgs/RouteWaypoint[]
                    wpx, wpy = wp.point.x, wp.point.y
                    wph = wp.angle
                    wpl = wp.left_boundary
                    wpr = wp.right_boundary

                    # Draw routes
                    plt.arrow(wpx, wpy, *_offset(wph),
                        width=0.1,
                        fc = "grey",
                        alpha=0.4)

                    road_lines = _road_line(wpx, wpy, wph, wpl, wpr)
                    if wp.curvature > 0.075 and len(road_line_xs_l):
                        # Ignore curvature > 0.075 and
                        # start a new line.
                        plt.plot(road_line_xs_l, road_line_ys_l,
                            alpha=0.8,
                            c="grey",
                            linewidth=0.4,
                            markersize=5)
                        plt.plot(road_line_xs_r, road_line_ys_r,
                            alpha=0.8,
                            c="grey",
                            linewidth=0.4,
                            markersize=5)
                        road_line_xs_l, road_line_ys_l = [], []
                        road_line_xs_r, road_line_ys_r = [], []
                    else:
                        road_line_xs_l.append(road_lines[0][0])
                        road_line_ys_l.append(road_lines[0][1])
                        road_line_xs_r.append(road_lines[1][0])
                        road_line_ys_r.append(road_lines[1][1])

                if len(road_line_xs_l):
                    plt.plot(road_line_xs_l, road_line_ys_l,
                        alpha=0.8,
                        c="black",
                        linewidth=0.4,
                        markersize=5)
                    plt.plot(road_line_xs_r, road_line_ys_r,
                        alpha=0.8,
                        c="black",
                        linewidth=0.4,
                        markersize=5)

        def calculate_trajs():
            arrows, time_matching = {}, {}
            trajs = {"opponent": [], "ego": []}
            i_rec = -1
            i_rec_max = len(records) - 1

            while i_rec <= i_rec_max - 1:
                i_rec += 1

                t = records[i_rec]["t"]
                topic = records[i_rec]["topic"]

                if topic != "simulation/agent_data_array": continue
                if t < start_time or t > end_time: continue

                time_matching[i_rec] = []

                msg = records[i_rec]["msg"]

                for agent in msg.data:
                    if agent.agent_id not in arrows.keys():
                        arrows[agent.agent_id] = []

                    ax, ay = agent.pose.position.x, agent.pose.position.y
                    ah = QuaternionToVector3(agent.pose.orientation).z
                    adx, ady = _offset(ah, length=0.1)
                    arrows[agent.agent_id].append(
                        (i_rec, ax, ay, adx, ady, agent.polygon))
                    time_matching[i_rec].append(
                        (agent.agent_id, ax, ay))

                    if agent.agent_id == profile.opponent_id:
                        trajs["opponent"].append(geometry_msgs.Pose2D(ax, ay, ah))
                    elif agent.agent_id == "ego":
                        trajs["ego"].append(geometry_msgs.Pose2D(ax, ay, ah))
            return arrows, time_matching, trajs

        def draw_vehicles(arrows, time_matching):

            def draw_vehicle_polygon(polygon, color, legend=None):
                pxs, pys = [], []
                for p in polygon.points[:4]:
                    pxs.append(p.x)
                    pys.append(p.y)
                pxs.append(polygon.points[0].x)
                pys.append(polygon.points[0].y)
                if legend:
                    return plt.plot(pxs, pys,
                            alpha=0.8,
                            linewidth=3.2,
                            c=color,
                            label=legend)
                else:
                    return plt.plot(pxs, pys,
                            alpha=0.8,
                            linewidth=3.2,
                            c=color)

            legends = {}
            time_matching_counts = 0

            for agent_id, arrow in arrows.items():

                color_map = {
                    "ego": (1., 0.1, 0.1, 0.5),
                    "agent": (0.1, 0.1, 1., 0.5),
                    "opponent": (0.6, 0.2, 0.8, 0.5)
                }

                wp_x, wp_y = [], []
                for i_arrow, arrow_param in enumerate(arrow):
                    i_rec, vx, vy, vdx, vdy, polygon = arrow_param
                    if agent_id == "ego":
                        color = color_map["ego"]
                        label = "Ego"
                    elif agent_id == profile.opponent_id:
                        color = color_map["opponent"]
                        label = "Opponent Agent"
                    else:
                        color = color_map["agent"]
                        label = "Other Agent(s)"

                    if agent_id == "ego":
                        # Draw match timing line
                        for (aid, ax, ay) in time_matching[i_rec]:
                            if aid == profile.opponent_id:
                                if time_matching_counts % TIME_MATCHING_DOWN_SAMPLE_RATE == 0:
                                    plt.plot([ax, vx], [ay, vy],
                                        c="navy",
                                        linewidth=0.4,
                                        label="Matched Timing",
                                        alpha=0.3)
                                time_matching_counts += 1

                    # Draw vehicle waypoints
                    if i_arrow % VEHICLE_TRAJ_DOWN_SAMPLE_RATE == 0:
                        plt.arrow(vx, vy, vdx, vdy, width=0.07, color=color)

                    if i_arrow == len(arrow) - 1:
                        handle, = draw_vehicle_polygon(polygon, color)
                        if label not in legends.keys():
                            legends[label] = handle

                    if i_arrow % VEHICLE_TRAJ_DOWN_SAMPLE_RATE == 0:
                        wp_x.append(vx)
                        wp_y.append(vy)

                # Draw vehicle trajs
                if len(wp_x):
                    plt.plot(wp_x, wp_y,
                        alpha=0.4,
                        c=color,
                        linewidth=1.2,
                        markersize=10)

                plt.legend(legends.values(), legends.keys())

        plt.cla()
        plt.xlim(profile.ego.pose.x - 16, profile.ego.pose.x + 16)
        plt.ylim(profile.ego.pose.y - 16, profile.ego.pose.y + 16)

        # Draw routes and road line
        draw_route(
            profile.nearby_forward_route,
            profile.nearby_opposite_route)

        # Draw Waypoints
        for wp in profile.current_waypoints.waypoints:
            plt.scatter(wp.point.x, wp.point.y,
                c="g",
                alpha=0.12,
                s=72)

        # Calculate vehicle trajs
        arrows, time_matching, trajs = calculate_trajs()

        # Draw vehicles
        draw_vehicles(arrows, time_matching)

        plt.savefig(img_path, dpi=800)

        return trajs  # for json recorder