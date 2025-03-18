#!/usr/bin/env python
from collections import namedtuple, OrderedDict
import argparse

import matplotlib.pyplot as plt
import numpy as np
import rospy
import rosbag
from geometry_msgs.msg import Pose, Point, Quaternion
from rss_msgs.msg import CheckResult
from itri_msgs.msg import DetectedObjectArray
from itri_msgs.msg import CarState

from agent_data import AgentData, AgentDataHandler, EgoData

def object_filter_rule(detected_object_id):
    # Modify this function to decide 
    # which objects' rss result should be visualized
    return detected_object_id >= 5000

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("bag", help="full path to bag file.")
    parser.add_argument("-s", "--label_shaded_area", action="store_true")
    args = parser.parse_args()
    offlineRssVisualizationTool = OfflinRssVisualizationTool(args)
    offlineRssVisualizationTool.plot()

class OfflinRssVisualizationTool:

    def __init__(self, args):
        self.args = args
        print("Loading rosbag [{}] ...".format(args.bag))
        self.bag = rosbag.Bag(args.bag, "r")
        print("Rosbag loaded.\n")
        self.ego_data = EgoData()
        self.agent_data_handler = AgentDataHandler(object_filter_rule)
        self._get_data_from_read_bag()

    def _get_data_from_read_bag(self):
        print("Start reading topics from rosbag ...")
        topics = ["/car_state", "/detected_objects", "/rss/check_result"]
        for topic, msg, t in self.bag.read_messages(topics=topics):
            if topic == "/car_state":
                self.ego_data.append(t, msg)
            elif topic == "/detected_objects":
                self.agent_data_handler.append_detected_objects(t, msg)
            elif topic == "/rss/check_result":
                self.agent_data_handler.append_rss_check_result(t, msg)
        print("All data read.\n")
        self.agent_data_handler.run_rss_matching()

    def plot(self):
        print("Start plotting.")
        for _id, agent in self.agent_data_handler.get_agent():
            result_array = np.zeros((agent.get_size(), 6))
            if len(agent.get_rss_result()) < 50:
                continue
            for i, rss_result_dict in enumerate(agent.get_rss_result()):
                result_array[i][0] = rss_result_dict["t"]
                result_array[i][1] = float(rss_result_dict["is_structured"])
                result_array[i][2] = float(rss_result_dict["status"])
                result_array[i][3] = rss_result_dict["distance"]
                result_array[i][4] = rss_result_dict["x"]
                result_array[i][5] = rss_result_dict["y"]
                # result_array[i][3] = self.ego_data.check_distance(
                #     rss_result_dict["t"], rss_result_dict["pose"])
            self._plot(_id, result_array)
        print("All plot saved.\n")

    
    def _plot(self, _id, result_array):
        rss_structure_color_map = {0: 'tab:orange', 1: 'tab:blue'}
        rss_structure_label_map = {0: 'Unstructured Data', 1: 'Structured Data'}
        rss_status_color_map = {0: ('g', 0.15), 1: ('y', 0.25), 2: ('r', 0.25)}
        rss_status_label_map = {0: 'rss status: safe', 1: "rss status: warning", 2: 'rss status: dangerous'}

        def _plot_distance(from_idx, to_idx, is_structured, label=False):
            if label: kwargs = {"label": rss_structure_label_map[is_structured]}
            else: kwargs = {}
            ax1.plot(
                result_array[from_idx: to_idx+1, 0],
                result_array[from_idx: to_idx+1, 4],
                color=rss_structure_color_map[is_structured],
                **kwargs)
            ax2.plot(
                result_array[from_idx: to_idx+1, 0],
                result_array[from_idx: to_idx+1, 5],
                color=rss_structure_color_map[is_structured])

        def _plot_shaded(from_t, to_t, status, label=False):
            if label: kwargs = {"label": rss_status_label_map[status]}
            else: kwargs = {}
            ax1.axvspan(start_t, t, 
                facecolor=rss_status_color_map[status][0], 
                alpha=rss_status_color_map[status][1])
            ax2.axvspan(start_t, t, 
                facecolor=rss_status_color_map[status][0], 
                alpha=rss_status_color_map[status][1],
                **kwargs)

        result_array[:, 0] -= result_array[0, 0]

        fig, (ax1, ax2) = plt.subplots(2, 1, sharex='all')
        fig.suptitle("Agent # {}".format(_id))
        ax1.set_ylabel("longitudinal distance (m)")
        ax2.set_xlabel("time (s)")
        ax2.set_ylabel("lateral distance (m)")

        current_status = result_array[0, 2]
        start_t = result_array[0, 0]

        current_is_structured = result_array[0, 1]
        start_idx_is_structured = 0
        
        # Labels
        #   To avoid duplicated labels, 
        #   has_label list keeps tracking of used label
        #   after a new label is applied, add it to has_label.
        #   ax1 labels lines, ax2 labels shaded area.
        has_label = []

        for i, (t, is_structured, status, __, x, y) in enumerate(result_array):
            if current_status != status:
                _plot_shaded(
                    start_t, t, 
                    current_status, 
                    not current_status + 10 in has_label and self.args.label_shaded_area)
                has_label.append(current_status + 10)
                current_status = status
                start_t = t
            if current_is_structured != is_structured:
                _plot_distance(
                    start_idx_is_structured, i, 
                    current_is_structured, 
                    not is_structured in has_label)
                has_label.append(is_structured)
                current_is_structured = is_structured
                start_idx_is_structured = i - 1

        _plot_shaded(
            start_t, t, 
            current_status,
            not current_status + 10 in has_label and self.args.label_shaded_area)
        _plot_distance(
            start_idx_is_structured, i, 
            result_array[-1, 1], 
            not is_structured in has_label)

        # is_stuctured legend
        lines_labels = [ax1.get_legend_handles_labels()]
        lines, labels = [sum(lol, []) for lol in zip(*lines_labels)]
        if self.args.label_shaded_area:
            fig.legend(lines, labels, loc='upper right', fontsize="x-small")
            # status legend
            shaded_labels = [ax2.get_legend_handles_labels()]
            shaded, slabels = [sum(lol, []) for lol in zip(*shaded_labels)]
            fig.legend(shaded, slabels, loc='upper left', fontsize="x-small", markerscale=0.2)
        else:
            fig.legend(lines, labels, loc='upper right')

        plt.savefig("{}.jpg".format(_id))
        


if __name__ == '__main__':
    main()