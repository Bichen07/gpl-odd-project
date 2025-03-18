#!/usr/bin/env python
import json
import ast
import os, glob
import csv
import argparse
from collections import OrderedDict

import numpy as np
from geometry_msgs.msg import Quaternion

try:
    import traj_dist.distance as tdist
    from traj_dist.pydist.linecell import trajectory_set_grid
except ImportError as e:
    raise ImportError("Please install traj-dist by \"pip2 install traj-dist\"")

PRINT_TO_CHECK_DATA = False

np.set_printoptions(suppress=True, threshold=1e20, linewidth=150)

data_name = "recorded-traj-2021-07-19-10-36-32.json"
result_name = data_name.split(".")[0] + "-result.txt"

distances_criteria = ["sspd", "discret_frechet", "hausdorff", "dtw", "lcss", "edr", "erp"]

PARAM_TYPE_D = "euclidean"  # Available options: ["euclidean", "spherical"]
PARAM_EPS = 1.  # required by criteria "edr" and "lcss"
PARAM_G = np.array([0.5, 0.5])  # required by "erp"

# "['timestamp', 'x', 'y', 'z', 'q.x', 'q.y', 'q.z', 'q.w', 'speed cmd', 'actual speed']"
# "['timestamp', 'x', 'y', 'z', 'yaw', 'speed cmd', 'actual speed']"

dimensions = OrderedDict([
    ("x", True),
    ("y", True),
    ("z", True),
    ("q.x", False),
    ("q.y", False),
    ("q.z", False),
    ("q.w", False),
    ("yaw", True),
    ("speed cmd", True),
    ("actual speed", True)
])


def print_both(f, val):
    f.write("{}\n".format(val))
    print(val)

with open(result_name, "w") as output_file:

    print_ = lambda s: print_both(output_file, s)

    with open(data_name, "r") as data_file:
        data = json.load(data_file)
        data["data_format"] = ast.literal_eval(data["data_format"])
        info = "\n========== Data load from {} ==========\n".format(data_name) + \
            "\tData Format: \n\t\t{}\n".format(data["data_format"]) + \
            "\tInit timestamp: {:.3f}\n".format(data["init_stamp"]) + \
            "\tSim data:\n" + \
            "\t\tLength: {}\n".format(len(data["sim"])) + \
            "\t\tRelative Stamp from {:.3f} to {:.3f}\n"\
                "".format(data["sim"][0][0]-data["init_stamp"], data["sim"][-1][0]-data["init_stamp"]) + \
            "\tReal data:\n" + \
            "\t\tLength: {}\n".format(len(data["real"])) + \
            "\t\tRelative Stamp from {:.3f} to {:.3f}\n"\
                "".format(data["real"][0][0]-data["init_stamp"], data["real"][-1][0]-data["init_stamp"]) + \
            "=" * (37 + len(data_name)) + "\n\n"
        print_(info)

    for ego_from in ["sim", "real"]:
        # Remove timestamp
        data[ego_from] = np.array(data[ego_from])[:, 1:]

    # Check keys    
    for key in data["data_format"]:
        if key == "timestamp": continue
        warning = "Unrecognized key (\"{}\") from data file, "\
            "please add it in dimensions dictionary above.".format(key)
        assert key in dimensions.keys(), warning

    # Check keys
    print_("Dimensions to be calculated:")
    for col, (key, chosen) in enumerate(dimensions.items()):
        if key in data["data_format"]:
            print_("\t{:12} : {}".format(key, chosen))
            if not chosen:
                for ego_from in ["sim", "real"]:
                    data[ego_from][:, col] = np.nan
        elif chosen:
            print_("\t{:12} : Not recognized, please check \"data_format\" in data file."\
                "".format(key))
        else:
            print_("\t{:12} : {}".format(key, chosen))

    # Remove unused dimensions
    for ego_from in ["sim", "real"]:
        if PRINT_TO_CHECK_DATA:
            print(data[ego_from])
            raw_input("\t ^ Data of {}, press enter to continue".format(ego_from))
        data[ego_from] = data[ego_from][:,~np.all(np.isnan(data[ego_from]), axis=0)]

    traj_list = [data["sim"], data["real"]]

    title = "Dist Result for {}:".format(data_name)
    print_("\n\n{}".format(title))
    for metric in distances_criteria:
        try:
            dist = tdist.pdist(traj_list, metric=metric, type_d=PARAM_TYPE_D, eps=PARAM_EPS, g=PARAM_G)[0]
            result = "\t{:16}| {:.12f}".format(metric, dist)
        except ValueError as e:
            result = "\t{:16}| ValueError: {}".format(metric, e)
        print_(result)

print("")

