import sys
import math
import collections
import traceback

import numpy as np
import rospy
from geometry_msgs.msg import Pose, Pose2D, Point, Quaternion, Vector3
from scenario_msgs.msg import AgentData, AgentDataArray
from std_msgs.msg import ColorRGBA
from itri_msgs.msg import CarState, turn_signal_cmd


longitudinal_offset = -0.0

SumoActor = collections.namedtuple('SumoActor', 'actor_id type_id transform extent speed turn_signal')


def mmsl_signal_to_sumo_signal(mmsl_signal_cmd):
    """
    Sumo light state is represented by a 13-bit integer.
    bit 0: VEH_SIGNAL_BLINKER_RIGHT
    bit 1: VEH_SIGNAL_BLINKER_LEFT

    Mmsl turn signal is represent by an uint8 integer.
    0: None
    1: Left
    2: Right
    """
    if 0 <= mmsl_signal_cmd.turn_signal <= 2:
        return {0: 0, 1: 2, 2: 1}[mmsl_signal_cmd.turn_signal]
    else:
        return 0

def sumo_signal_to_mmsl_signal(sumo_signal):
    mmsl_turn_signal_cmd = turn_signal_cmd()
    left = sumo_signal >> 0 & 1
    right = sumo_signal >> 1 & 1
    if left and right:
        mmsl_turn_signal_cmd.turn_signal = 0
    elif left:
        mmsl_turn_signal_cmd.turn_signal = 1
    elif right:
        mmsl_turn_signal_cmd.turn_signal = 2
    return mmsl_turn_signal_cmd


def mmsl_speed_to_sumo_speed(vector3, orientation):  # -> Vector3D
    """
    Sumo speed is represented in longitudinal speed and lateral speed
    Mmsl speed is in world coord (then transformed to ego frame in simulation_adv if needed)
    """
    heading = np.deg2rad(Conversion.quaternion_to_euler(orientation).yaw)
    return Vector3D(msg=vector3).rotate2d(-heading)

def sumo_speed_to_mmsl_speed(vector3d, heading):  # -> Vector3
    return vector3d.rotate2d(heading).get_msg()
    

class Vector3D:
    def __init__(self, x=None, y=None, z=None, msg=None):
        if msg:
            self.x = msg.x
            self.y = msg.y
            self.z = msg.z
        else:
            self.x = x
            self.y = y
            self.z = z

    def get_msg(self):
        return Vector3(self.x, self.y, self.z)

    def rotate2d(self, radian):
        return Vector3D(
            np.cos(radian) * self.x - np.sin(radian) * self.y,
            np.sin(radian) * self.x + np.cos(radian) * self.y,
            self.z)

    def __str__(self):
        return "<class Vector3D x={}, y={}, z={}>".format(self.x, self.y, self.z)


class Location:
    def __init__(self, x=None, y=None, z=0, msg=None):
        if msg:
            self.x = msg.x
            self.y = msg.y
            self.z = msg.z
        else:
            self.x = x
            self.y = y
            self.z = z

    def get_msg(self):
        return Point(self.x, self.y, self.z)

    def get_value(self):
        return self.x, self.y, self.z

    def __str__(self):
        return "Location: {}".format(self.get_value())


class Orientation:
    def __init__(self, w=1, x=0, y=0, z=0, msg=None):
        if msg:
            self.w = msg.w
            self.x = msg.x
            self.y = msg.y
            self.z = msg.z
        else:
            self.w = w
            self.x = x
            self.y = y
            self.z = z

    def get_value(self):
        return self.w, self.x, self.y, self.z

    def get_msg(self):
        return Quaternion(self.x, self.y, self.z, self.w)

    def to_rotation(self):
        return Conversion.quaternion_to_euler(self)


class Rotation:
    def __init__(self, roll=0, pitch=0, yaw=None, msg=None):
        if msg:
            rpy = Conversion.quaternion_to_euler(msg)
            self.roll, self.pitch, self.yaw = rpy.get_value()
        else:
            self.roll = roll
            self.pitch = pitch
            self.yaw = yaw

    def get_value(self):
        return self.roll, self.pitch, self.yaw

    def get_msg(self):
        return Conversion.euler_to_quaternion(self)

    def to_orientation(self):
        return Conversion.euler_to_quaternion(self)

    def __str__(self):
        return "Rotation: {}".format(self.get_value())


class Transform:
    def __init__(self, location, rotation):
        self.location = location
        self.rotation = rotation

    def get_msg(self):
        return Pose(
            self.location.get_msg(),
            self.rotation.get_msg())

    def __str__(self):
        return "Transform: [{}, {}]".format(
            self.location, self.rotation)


class Conversion:

    @staticmethod
    def quaternion_to_euler(orientation):
        if isinstance(orientation, list) or isinstance(orientation, tuple):
            assert len(orientation) == 4
            w, x, y, z = orientation
        elif isinstance(orientation, Orientation):
            w, x, y, z = orientation.get_value()
        elif isinstance(orientation, Quaternion):
            w = orientation.w
            x = orientation.x
            y = orientation.y
            z = orientation.z
        else:
            raise TypeError("Unrecognized type : {}"\
                "".format(type(orientation)))
        t0 = + 2.0 * (w * x + y * z)
        t1 = + 1.0 - 2.0 * (x * x + y * y)
        X = math.degrees(math.atan2(t0, t1))
        t2 = + 2.0 * (w * y - z * x)
        t2 = + 1.0 if t2 > + 1.0 else t2
        t2 = - 1.0 if t2 < - 1.0 else t2
        Y = math.degrees(math.asin(t2))
        t3 = + 2.0 * (w * z + x * y)
        t4 = + 1.0 - 2.0 * (y * y + z * z)
        Z = math.degrees(math.atan2(t3, t4))
        return Rotation(X, Y, Z)  # deg

    @staticmethod
    def euler_to_quaternion(rotation, convertFromDegree=True):
        if isinstance(rotation, list) or isinstance(rotation, tuple):
            assert len(rotation) == 3
            r, p, y = rotation
        elif isinstance(rotation, Rotation):
            r, p, y = rotation.get_value()
        else:
            raise TypeError("Unrecognized type : {}".format(type(rotation)))
        if convertFromDegree:
            r = np.deg2rad(r)
            p = np.deg2rad(p)
            y = np.deg2rad(y)
        sr, cr = np.sin(r/2), np.cos(r/2)
        sp, cp = np.sin(p/2), np.cos(p/2)
        sy, cy = np.sin(y/2), np.cos(y/2)
        qx = sr * cp * cy - cr * sp * sy
        qy = cr * sp * cy + sr * cp * sy
        qz = cr * cp * sy - sr * sp * cy
        qw = cr * cp * cy + sr * sp * sy
        return Orientation(qw, qx, qy, qz)  

    @staticmethod
    def pose_to_transform(pose):
        location = Location(msg=pose.position)
        rotation = Quaternion(msg=pose.orientation).to_euler()
        return transform(location, rotation)

    @staticmethod
    def transform_to_pose(transform):
        return transform.get_msg()

    @staticmethod
    def car_state_to_transform(carState):
        return Transform(
            Location(msg=carState.pose.pose.position),
            Rotation(0, 0, np.rad2deg(carState.pose.pose.orientation.z)))

    @staticmethod
    def agent_data_to_transform(agentData):
        return Transform(
            Location(msg=agentData.pose.position),
            Rotation(msg=agentData.pose.orientation))

def apply_offset_to_transform(transform, xy_offset, ego=True):
    transform.location.x += xy_offset[0]
    transform.location.y += xy_offset[1]
    transform.rotation.yaw = -transform.rotation.yaw + 90.
    if ego:
        yaw = transform.rotation.yaw / 180. * np.pi
        transform.location.x += longitudinal_offset * np.cos(yaw)
        transform.location.y += longitudinal_offset * np.sin(yaw)
    return transform

def mmsl_car_state_to_transform(carState, offset, ego=True):
    transform = Conversion.car_state_to_transform(carState)
    return apply_offset_to_transform(transform, offset)


def mmsl_agent_data_to_transform(agentData, offset, ego=True):
    transform = Conversion.agent_data_to_transform(agentData)
    return apply_offset_to_transform(transform, offset)


def mmsl_agent_data_to_sumo_actor(agentData, offset, ego=True):
    # SumoActor('actor_id type_id transform extent speed turn_signal')
    transform = mmsl_agent_data_to_transform(agentData, offset, ego)
    extent = Vector3D(
        agentData.size.x, 
        agentData.size.y,
        agentData.size.z)
    speed = mmsl_speed_to_sumo_speed(agentData.linear_velocity, agentData.pose.orientation)
    turn_signal = mmsl_signal_to_sumo_signal(agentData.turn_signal)
    return SumoActor(agentData.agent_id, None, transform, extent, speed, turn_signal)

def sumo_actor_to_mmsl_format(sumo_actor, xy_offset, use_car_state=False):
    # SumoActor('actor_id type_id transform extent speed turn_signal')
    pose = Pose()
    pose.position = sumo_actor.transform.location.get_msg()
    pose.position.x -= xy_offset[0]
    pose.position.y -= xy_offset[1]
    yaw = - np.deg2rad(sumo_actor.transform.rotation.yaw) \
          + np.pi / 2
    while(yaw < 0):
        yaw += 2 * np.pi
    while(yaw > 2 * np.pi):
        yaw -= 2 * np.pi
    if not use_car_state:
        pose.orientation = Conversion.euler_to_quaternion(
            [0., 0., yaw], False).get_msg()
    else:
        pose.orientation.z = yaw
        pose.orientation.x = pose.orientation.y = pose.orientation.w = 0.
    size = sumo_actor.extent.get_msg()
    speed = sumo_speed_to_mmsl_speed(sumo_actor.speed, yaw)
    turn_signal = sumo_signal_to_mmsl_signal(sumo_actor.turn_signal)
    return (sumo_actor.actor_id, "", pose, size, speed, turn_signal)

def sumo_actor_to_mmsl_agent_data(sumo_actor, offset):
    actor_id, _, pose, size, speed, turn_signal = sumo_actor_to_mmsl_format(sumo_actor, offset)
    agentData = AgentData()
    agentData.agent_id = sumo_actor.actor_id
    agentData.pose = pose
    agentData.size = size
    agentData.linear_velocity = speed
    agentData.turn_signal = turn_signal
    return agentData

def sumo_actor_to_car_state(sumo_actor, offset):
    actor_id, _, pose, size, speed, turn_signal = sumo_actor_to_mmsl_format(sumo_actor, offset, True)
    ret = CarState()
    ret.pose.pose = pose
    ret.twist.twist.linear = speed
    # Velocity still need to handle
    return ret

def mmsl_actors_to_sumo(agents, offset):
    """
    scenario_msgs/AgentDataArray -> [SumoActors(), ]
    """
    sumo_actors = []
    for agent in agents.data:
        if agent.agent_id.startswith("sumo"): continue
        sumo_actors.append(
            mmsl_agent_data_to_sumo_actor(agent, offset, ego=True))
    return sumo_actors

def sumo_actors_to_mmsl(agents, offset):
    """
    [SumoActors(), ] -> scenario_msgs/AgentDataArray
    """
    mmsl_actors = []
    for agent in agents:
        if agent.actor_id.startswith("mmsl"): continue
        mmsl_actors.append(
            sumo_actor_to_mmsl_agent_data(agent, offset))
    return mmsl_actors


### Error Handle

def trace(e):
    error_class = e.__class__.__name__
    cl, exc, tb = sys.exc_info()

    if len(e.args):
        trace_log = "[{}]: {}\n".format(error_class, e.args[0])
    else:
        trace_log = "[{}]\n".format(error_class)
    trace_log += "==== traceback ===="
    for i, stack in enumerate(traceback.extract_tb(tb)):
        tabs = " " * i
        fileName, lineNum, funcName = stack[0: 3]
        msg = "\n{} | File \"{}\", line {}, in {}"\
            "".format(tabs, fileName, lineNum, funcName)
        trace_log += msg
    trace_log += "\n==== traceback ===="
    return trace_log

def GlobalExceptionHandler(prefix):
    def FunctionExceptionHandler(func):
        def wrap(*args, **kwargs):
            try: return func(*args, **kwargs)
            except Exception as e:
                # rospy.logwarn("[{}] Capture error in function \"{}\" "\
                #     "with args \"{}\" and \"{}\". For more information, "\
                #     "please find in log file.".format(prefix, func.__name__,
                #         args, kwargs))
                rospy.loginfo("[{}] Capture error in function \"{}\" "\
                    "with args \"{}\" and \"{}\". There should be no harm "\
                    "to the process unless this log keep showing. \n{}. "\
                    "".format(
                        prefix, func.__name__, args, kwargs, trace(e)))
            return False
        return wrap
    return FunctionExceptionHandler