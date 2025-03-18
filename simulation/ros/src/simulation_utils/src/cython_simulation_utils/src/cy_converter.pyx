from geometry_msgs.msg import Point, Vector3, Pose, Quaternion, Pose2D
import numpy as np
from libc.math cimport sin, cos, atan2, asin, pi

def ToPoint(val):
    if isinstance(val, list) or isinstance(val, tuple):
        assert len(val) == 3
        return Pose(*val)
    elif isinstance(val, Vector3):
        return Pose(val.x, val.y, val.z)
    else:
        raise TypeError("[simulation_utils/converter.py] "\
            "Unrecognized type for ToPoint: {}".format(type(val)))

def ToVector3(val):
    if isinstance(val, list) or isinstance(val, tuple):
        assert len(val) == 3
        return Vector3(*val)
    elif isinstance(val, Point):
        return Vector3(val.x, val.y, val.z)
    else:
        raise TypeError("[simulation_utils/converter.py] "\
            "Unrecognized type for ToVector3: {}".format(type(val)))

def Pose2DToPose(pose2d):
    return Pose(
        Point(pose2d.x, pose2d.y, 0),
        EulerAngleToQuaternion([0, 0, pose2d.theta]))

def PoseToPose2D(pose):
    return Pose2D(
        pose.position.x,
        pose.position.y,
        QuaternionToVector3(pose.orientation).z)

def Pose2DDiff(pose2d1, pose2d2):
    assert isinstance(pose2d1, Pose2D)
    assert isinstance(pose2d2, Pose2D)
    return Pose2D(
        pose2d1.x-pose2d2.x,
        pose2d1.y-pose2d2.y,
        pose2d1.theta-pose2d2.theta)

def Pose2DSpeed(pose2d1, pose2d2, t):
    diff = Pose2DDiff(pose2d1, pose2d2)
    return Pose2D(
        diff.x / t, diff.y / t, diff.theta / t)

def EulerAngleToQuaternion(euler):
    """
        Convert Euler angle of type list, tuple,
        Point or Vector3 to Quaternion
    """
    orientation = Quaternion()
    if isinstance(euler, list) or isinstance(euler, tuple):
        assert len(euler) == 3
        roll, pitch, yaw = euler
    if isinstance(euler, Point) or isinstance(euler, Vector3):
        roll, pitch, yaw = euler.x, euler.y, euler.z
    return Quaternion(*_EulerAngleToQuaternion(roll, pitch, yaw))

cdef _EulerAngleToQuaternion(
        float roll, float pitch, float yaw):
    cdef float cr = cos(roll * 0.5)
    cdef float sr = sin(roll * 0.5)
    cdef float cp = cos(pitch * 0.5)
    cdef float sp = sin(pitch * 0.5)
    cdef float cy = cos(yaw * 0.5)
    cdef float sy = sin(yaw * 0.5)
    cdef float w = cr * cp * cy + sr * sp * sy
    cdef float x = sr * cp * cy - cr * sp * sy
    cdef float y = cr * sp * cy + sr * cp * sy
    cdef float z = cr * cp * sy - sr * sp * cy
    cdef float[4] return_val = [x, y, z, w]
    return return_val

def QuaternionToVector3(quaternion, two_d=False):
    """
        Convert Quaternion to Euler angle of type Vector3
    """
    q = quaternion
    vec = Vector3(*_QuaternionToVector3(q.x, q.y, q.z, q.w))
    if two_d:
        return Vector3(0., 0., vec.z)
    else:
        return vec

cdef _QuaternionToVector3(
        float x, float y, float z, float w):
    cdef float roll, pitch, yaw
    cdef float sinp = 2 * (w * y - z * x)
    cdef float sinr_cosp = 2 * (w * x + y * z)
    cdef float cosr_cosp = 1 - 2 * (x * x + y * y)
    cdef float siny_cosp = 2 * (w * z + x * y)
    cdef float cosy_cosp = 1 - 2 * (y * y + z * z)

    roll = atan2(sinr_cosp, cosr_cosp)
    if abs(sinp) >= 1.:
        # use 90 degrees if out of range
        pitch = pi / 2.
        if sinp < 0:
            pitch = - pitch
    else:
        pitch = asin(sinp)
    yaw = atan2(siny_cosp, cosy_cosp)

    cdef float[3] return_val = [roll, pitch, yaw]
    return return_val