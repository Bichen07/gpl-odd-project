from __future__ import division
from pprint import pprint
from datetime import datetime
import json
from typing import Tuple, List
from collections import OrderedDict
import math
import os
import fcntl
import joblib
import xml.etree.ElementTree as ET
from pathlib import Path


def normalize(params, pbounds):
    result = OrderedDict()
    for feature in pbounds.keys():
        lower_bound, upper_bound = pbounds[feature]
        result[feature] = (params[feature] - lower_bound) / (upper_bound - lower_bound)
    for key in params.keys():
        if key not in result:
            result[key] = params[key]
    return result


def scale_back(params, pbounds):
    result = OrderedDict()
    for feature in pbounds.keys():
        lower_bound, upper_bound = pbounds[feature]
        result[feature] = params[feature] * (upper_bound - lower_bound) + lower_bound
    for key in params.keys():
        if key not in result:
            result[key] = params[key]
    return result


def get_rotated_points(origin, heading_radians, points):
    # Define the rotation matrix
    rotation_matrix = [
        [math.cos(heading_radians), -math.sin(heading_radians)],
        [math.sin(heading_radians), math.cos(heading_radians)],
    ]

    # Initialize an empty list to store the rotated points
    rotated_points = []

    # Iterate through each point and apply the rotation
    for point in points:
        # Translate the point to be relative to the origin
        relative_point = [point[0] - origin[0], point[1] - origin[1]]

        # Apply the rotation transformation
        rotated_x = (
            relative_point[0] * rotation_matrix[0][0]
            + relative_point[1] * rotation_matrix[0][1]
        )
        rotated_y = (
            relative_point[0] * rotation_matrix[1][0]
            + relative_point[1] * rotation_matrix[1][1]
        )

        # Translate the rotated point back to its absolute position
        rotated_point = [rotated_x + origin[0], rotated_y + origin[1]]

        # Append the rotated point to the result list
        rotated_points.append(rotated_point)

    return rotated_points


saved_folder = "/project/mmsl_simulation/src/scenario_search/data/saved/{}/".format(
    datetime.now().strftime("%Y%m%d_%H%M%S")
)


def save_json(data, filepath=Path("/tmp/dummy.json")):
    filepath_str = str(filepath)
    try:
        if not os.path.exists(os.path.dirname(filepath_str)):
            os.makedirs(os.path.dirname(filepath_str))
        with open(filepath_str, "w") as file:
            fcntl.flock(file, fcntl.LOCK_EX)
            json.dump(data, file, sort_keys=True, indent=4)
            print("JSON DUMP TO {}".format(filepath_str))
            file.flush()
            fcntl.flock(file, fcntl.LOCK_UN)
    except Exception as e:
        print("An error occurred: {}".format(str(e)))


def pickle_data(data, filename):
    filepath = saved_folder + filename + ".pkl"
    try:
        if not os.path.exists(os.path.dirname(filepath)):
            os.makedirs(os.path.dirname(filepath))
        with open(filepath, "w") as file:
            fcntl.flock(file, fcntl.LOCK_EX)
            joblib.dump(data, filepath)
            print("JOBLIB DUMP TO {}".format(filepath))
            file.flush()
            fcntl.flock(file, fcntl.LOCK_UN)
    except Exception as e:
        print("An error occurred: {}".format(str(e)))


def heading_vector_from_yaw(yaw):
    # type: (float) -> Tuple[float ,float]
    x_component = math.cos(yaw)
    y_component = math.sin(yaw)
    return (x_component, y_component)


def openscenario_contraint_checker(motion_model_config, xml_content=None):
    if "openscenario_template" not in motion_model_config.keys():
        return True

    if xml_content is None:
        with open(motion_model_config["openscenario_template"], "r") as file:
            xml_content = file.read()

    root = ET.fromstring(xml_content)

    for motion_config in motion_model_config["motion_configs"]:
        for parameter, value in motion_config.items():
            parameter_decleration = root.find(
                ".//ParameterDeclaration[@name='{}']".format(parameter)
            )
            if parameter_decleration is None:
                print("Cannot found parameter declaration of {}".format(parameter))
                continue
            value_contraints = parameter_decleration.findall(".//ValueConstraint")
            if not value_contraints:
                # print("Cannot found value constraint of {}".format(parameter))
                continue
            for value_constraint in value_contraints:
                rule = value_constraint.attrib["rule"]
                value = value_constraint.attrib["value"]

                # print()
                if (
                    isinstance(value, str)
                    and value.startswith("${")
                    and value.endswith("}")
                ):
                    expression = value[2:-1]
                    # print(expression)
                    for parameter_string, replace_value in motion_config.items():
                        replace_parameter_string = "$" + parameter_string
                        expression = expression.replace(
                            replace_parameter_string, str(replace_value)
                        )
                    value = eval(expression)
                    # print(expression)
                else:
                    value = float(value)

                # print(parameter)
                # print(rule)
                # print(value)
                # print(motion_config[parameter])
                # print()

                if (
                    (rule == "greaterThan" and motion_config[parameter] <= value)
                    or (rule == "lessThan" and motion_config[parameter] >= value)
                    or (rule == "greaterOrEqual" and motion_config[parameter] < value)
                    or (rule == "lessOrEqual" and motion_config[parameter] > value)
                    or (rule == "equalTo" and motion_config[parameter] != value)
                ):
                    print(parameter)
                    print(rule)
                    print(value)
                    print(motion_config[parameter])
                    print("FAILED")
                    return False
    return True


def get_pbounds(record_root_dir, search_name):
    with open(record_root_dir + "odd_search_config.json", "r") as file:
        odd_search_config = json.load(file)

    pbounds = {}
    for key in odd_search_config:
        if not search_name in key:
            continue
        for search_key in odd_search_config[key]:
            if not "_model" in search_key:
                continue
            motion_model_name = search_key
            pbounds = odd_search_config[key][motion_model_name]["motion_configs"][0]
            break

    keys = sorted(pbounds)
    updated = OrderedDict()
    for key in keys:
        updated[key] = [pbounds[key][0], pbounds[key][1]]
    return updated


def get_motion_model_name(config):
    for key in config:
        for search_key in config[key]:
            if not "_model" in search_key:
                continue
            motion_model_name = search_key
            return motion_model_name
    raise RuntimeError("motion model name not found")


def get_simulator_name(config):
    for key in config:
        if "_simulator" in key:
            return key
    raise RuntimeError("simulator name not found")
