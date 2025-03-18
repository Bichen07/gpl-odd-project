from StringIO import StringIO
from copy import deepcopy
import json
import math
import rospy
from collections import OrderedDict
from geometry_msgs.msg import PoseStamped, Pose
from geometry_msgs.msg import TwistStamped, Twist
from scenario_classification.msg import ClassificationObject
from scenario_classification.msg import ClassificationObjectArray
from scenario_classification.msg import TagTrees
from scenario_classification.msg import TagCarriagewayUserType
from scenario_classification.msg import TagInitialState
from scenario_classification.msg import TagLateralActivity
from scenario_classification.msg import TagLongitudinalActivity
from scenario_classification.msg import TagLeadVehicle
from scenario_classification.msg import TagRoadLayout
from cython_simulation_utils import cy_converter as converter
from cython_simulation_utils import cy_coord_transform as transform
from identifier.utils import POSSIBLE_OUTCOMES

SCENARIO_CATEGORIES_PATH = "/project/mmsl_simulation/src/" \
    "scenario_classification/src/tag_trees/scenario_categories.json"

POSSIBLE_OUTCOMES_BINARY_DIGITS = OrderedDict()
POSSIBLE_OUTCOMES_BINARY_TOTAL_DIGITS = 0
for key, value in POSSIBLE_OUTCOMES.items():
    digits = int(math.floor(math.log(len(value) - 1, 2)) + 1)
    POSSIBLE_OUTCOMES_BINARY_DIGITS[key] = digits
    POSSIBLE_OUTCOMES_BINARY_TOTAL_DIGITS += digits


def get_tag_trees_outcome(tag_trees):
    # type: (TagTrees) -> dict[str, str]
    result = {}  # type: dict[str, str]
    for tree_name in tag_trees.__slots__:
        tree_state = tag_trees.__getattribute__(tree_name)
        mapping = {}
        for member in dir(tree_state):
            if member.startswith('_') or member[0].islower():
                continue
            member_value = tree_state.__getattribute__(member)
            member = member.lower()
            starter = member.split('_')[0].lower()
            tag_name = member.replace(starter + "_", "")
            if tree_name == "initial_state" and "position" in tag_name:
                tag_name = tag_name.replace("position_", "")
            if not starter in mapping:
                mapping[starter] = {}
            mapping[starter][member_value] = tag_name
        outcome_string = ""
        for slot in tree_state.__slots__:
            category = slot.replace("_category", "")
            if tree_name == "initial_state" and "position" in category:
                category = category.replace("_position", "")
            value = tree_state.__getattribute__(slot)
            if category == "primary":
                mapped_value = mapping["primary"][value]
                outcome_string = mapping["primary"][value] + outcome_string
                if mapped_value == "unknown":
                    break
            elif category == "secondary":
                mapped_value = mapping["primary"][value]
                if mapped_value == "unknown":
                    break
                outcome_string += ":" + mapping["secondary"][value]
            else:
                outcome_string = mapping[category][value]
                result["{}_{}".format(tree_name, category)] = outcome_string
        if tree_name != "initial_state":
            result[tree_name] = outcome_string
    return result


def get_tag_trees_binary_encoding(arg):
    # type: (dict[str, str] | TagTrees) -> str
    outcome = None
    if type(arg) is TagTrees:
        tag_trees = arg
        outcome = get_tag_trees_outcome(tag_trees)
    elif type(arg) is dict[str, str]:
        outcome = arg
    else:
        raise TypeError("arg must be TagTrees or dict[str, str]")
    binary_string = ""
    for key, value in POSSIBLE_OUTCOMES.items():
        assert key in outcome
        binary_string += format(value.index(outcome[key]), 'b') \
            .zfill(POSSIBLE_OUTCOMES_BINARY_DIGITS[key])
    return binary_string


def tag_trees_binary_string_to_outcome(binary_string):
    # type: (str) -> dict[str, str]
    assert len(binary_string) == POSSIBLE_OUTCOMES_BINARY_TOTAL_DIGITS, \
        "binary string length does not correct."
    result = {}  # type: dict[str, str]
    for category, digits in POSSIBLE_OUTCOMES_BINARY_DIGITS.items():
        category_binary = binary_string[:digits]
        value = int(category_binary, 2)
        result[category] = POSSIBLE_OUTCOMES[category][value]
        binary_string = binary_string[digits:]
    return result


def tag_trees_integer_to_outcome(number):
    # type: (int) -> dict[str, str]
    binary_string = format(number, 'b').zfill(
        POSSIBLE_OUTCOMES_BINARY_TOTAL_DIGITS)
    return tag_trees_binary_string_to_outcome(binary_string)


def update_relative_velocities(c_obj, last):
    cid = c_obj.id
    if len(c_obj.relative_poses) - len(c_obj.relative_velocities) == 1:
        if last:
            vel_stamped = TwistStamped()
            vel_stamped.header.stamp = c_obj.relative_poses[-1].header.stamp
            t_diff = (c_obj.relative_poses[-1].header.stamp -
                      last.relative_poses[-1].header.stamp).to_sec()
            if t_diff > 0.005:
                pose2d_vel = converter.Pose2DSpeed(
                    converter.PoseToPose2D(c_obj.relative_poses[-1].pose),
                    converter.PoseToPose2D(last.relative_poses[-1].pose),
                    t_diff)
                vel_stamped.twist.linear.x = pose2d_vel.x
                vel_stamped.twist.linear.y = pose2d_vel.y
                vel_stamped.twist.angular.z = pose2d_vel.theta
            else:
                rospy.logwarn("[scen_cls - check_relative_velocities] t_diff too small: {}"
                              "".format(t_diff))
                vel_stamped = deepcopy(last.relative_velocities[-1])
            c_obj.relative_velocities.append(vel_stamped)
        else:
            c_obj.relative_velocities.append(TwistStamped())
            c_obj.relative_velocities[-1].header.stamp = c_obj.relative_poses[-1].header.stamp
    else:
        assert len(c_obj.relative_poses) == len(c_obj.relative_velocities), ""\
            "len(c_obj.relative_poses) = {}, len(c_obj.relative_velocities) = {}"\
            "".format(len(c_obj.relative_poses),
                      len(c_obj.relative_velocities))


def check_relative_acceleration(c_obj, last):
    cid = c_obj.id
    if len(c_obj.relative_velocities) - len(c_obj.relative_accelerations) == 1:
        if last:
            acceleration_stamped = TwistStamped()
            acceleration_stamped.header.stamp = c_obj.relative_velocities[-1].header.stamp
            x_diff = c_obj.relative_velocities[-1].twist.linear.x - \
                last.relative_velocities[-1].twist.linear.x
            y_diff = c_obj.relative_velocities[-1].twist.linear.y - \
                last.relative_velocities[-1].twist.linear.y
            t_diff = (c_obj.relative_velocities[-1].header.stamp -
                      last.relative_velocities[-1].header.stamp).to_sec()
            if t_diff > 0.005:
                acceleration_stamped.twist.linear.x = - x_diff / t_diff
                acceleration_stamped.twist.linear.y = - y_diff / t_diff
                # Needs to fill with rotation speed
            else:
                rospy.logwarn("[scen_cls - check_relative_acceleration] t_diff too small: {}"
                              "".format(t_diff))
                acceleration_stamped = deepcopy(
                    last.relative_accelerations[-1])
            c_obj.relative_accelerations.append(acceleration_stamped)
        else:
            c_obj.relative_accelerations.append(TwistStamped())
            c_obj.relative_accelerations[-1].header.stamp = c_obj.relative_velocities[-1].header.stamp
    else:
        assert len(c_obj.relative_velocities) == len(c_obj.relative_accelerations), ""\
            "len(c_obj.relative_velocities) = {}, len(c_obj.relative_accelerations) = {}"\
            "".format(len(c_obj.relative_velocities),
                      len(c_obj.relative_accelerations))


def get_velocity_by_stamped_poses(pose1, pose2):
    dist = ((pose1.pose.x - pose2.pose.x) ** 2 +
            (pose1.pose.y - pose2.pose.y) ** 2) ** 0.5
    time_diff = abs((pose1.header.stamp - pose2.header.stamp).to_sec())
    return dist / time_diff


def to_ego_frame(d_obj, ego_state, velocity_on_ego_frame):
    c_obj = ClassificationObject()
    c_obj.id = d_obj.id
    c_obj.label = d_obj.label
    c_obj.size = d_obj.dimensions

    rel_pos = PoseStamped()
    rel_pos.pose = deepcopy(d_obj.pose)
    rel_pos.header = deepcopy(d_obj.header)
    c_obj.relative_poses.append(rel_pos)

    vel = TwistStamped()
    vel.header = deepcopy(d_obj.header)
    local_velocities = TwistStamped()
    local_velocities.header = deepcopy(d_obj.header)

    ego_local_velocity = transform.global_velocity_to_local_velocity(
        ego_state.pose.pose, ego_state.twist.twist.linear)
    ego_local_velocity.x *= -1
    ego_local_velocity.y *= -1
    if velocity_on_ego_frame:
        vel.twist.linear = transform.local_velocity_to_global_velocity(
            ego_state.pose.pose, d_obj.velocity.linear)
        local_velocities.twist = deepcopy(d_obj.velocity)

    else:
        obj_local_velocity = transform.global_velocity_to_local_velocity(
            ego_state.pose.pose,
            d_obj.velocity.linear)

        vel.twist = deepcopy(d_obj.velocity)
        local_velocities.twist.linear = obj_local_velocity

    c_obj.velocities.append(vel)
    c_obj.local_velocities.append(local_velocities)
    return c_obj


def to_cpp(msg):
    """Return a serialized string from a ROS message

    Parameters
    ----------
    - msg: a ROS message instance.
    """
    buf = StringIO()
    msg.serialize(buf)
    return buf.getvalue()


def from_cpp(str_msg, cls):
    """Return a ROS message from a serialized string

    Parameters
    ----------
    - str_msg: str, serialized message
    - cls: ROS message class, e.g. sensor_msgs.msg.LaserScan.
    """
    msg = cls()
    return msg.deserialize(str_msg)


def get_configs(print_config=True, file_path="/project/mmsl_simulation/"
                "src/scenario_classification/src/tag_trees/identifier/"
                "parameters.h"):
    with open(file_path, "r") as f:
        lines = f.readlines()
    configs = OrderedDict()
    for line in lines:
        if "=" in line:
            param = line.replace("constexpr", "").replace("auto", "")
            param = param.replace("f;", ";").replace(" ", "")
            param = param.split(";")[0]
            name, value = param.split("=")
            try:
                configs[name] = float(value)
            except ValueError:
                if value == "true":
                    configs[name] = True
                elif value == "false":
                    configs[name] = False
                else:
                    raise ValueError(value)
    if print_config:
        print("[scen_cls] \033[1;33mConfigurations:\033[0m")
        print(json.dumps(configs, indent=4))
    return configs
