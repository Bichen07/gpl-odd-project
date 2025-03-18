import math

import numpy as np
from geometry_msgs.msg import Pose, Point, Quaternion, Vector3
from std_msgs.msg import ColorRGBA
from itri_msgs.msg import CarState

XY_OFFSET = (595.39, 452.02)
longitudinal_offset = -2.5

class Vector3D:
    def __init__(self, x, y, z):
        self.x = x
        self.y = y
        self.z = z

    def get_msg(self):
        return Vector3(self.x, self.y, self.z)


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
    def __init__(self, pitch=0, roll=0, yaw=None):
        self.pitch = pitch
        self.roll = roll
        self.yaw = yaw

    def get_value(self):
        return self.pitch, self.roll, self.yaw

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
        w, x, y, z = orientation.get_value()
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
    def euler_to_quaternion(rotation):
        p, r, y = rotation.get_value()
        p = np.deg2rad(p)
        r = np.deg2rad(r)
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


def mmsl_car_state_to_transform(carState, ego=True):
    transform = Conversion.car_state_to_transform(carState)
    transform.location.x += XY_OFFSET[0]
    transform.location.y += XY_OFFSET[1]
    transform.rotation.yaw = -transform.rotation.yaw + 90.
    if ego:
        yaw = transform.rotation.yaw / 180. * np.pi
        transform.location.x += longitudinal_offset * np.cos(yaw)
        transform.location.y += longitudinal_offset * np.sin(yaw)
    return transform


def sumo_actor_to_mmsl_format(sumo_actor):
    # SumoActor(
    #     actor_id, type_id, vclass, transform, signals, extent, color)
    # def spawn_actor(
    #     self, actor_id, pose, size, object_class_id, color):
    pose = Pose()
    pose.position = sumo_actor.transform.location.get_msg()
    pose.position.x -= XY_OFFSET[0]
    pose.position.y -= XY_OFFSET[1]
    pose.orientation.z = - np.deg2rad(sumo_actor.transform.rotation.yaw) \
                         + np.pi / 2
    pose.orientation.x = pose.orientation.y = pose.orientation.w = 0
    size = sumo_actor.extent.get_msg()
    color = ColorRGBA(0, 0, 1, 0.8)

    return (sumo_actor.actor_id, pose, size, "car", color)


def sumo_actor_to_car_state(sumo_actor):
    actor_id, pose, size, _, color = sumo_actor_to_mmsl_format(sumo_actor)
    ret = CarState()
    ret.pose.pose = pose
    # Velocity still need to handle
    return ret

