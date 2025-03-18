from geometry_msgs.msg import Point, Vector3, Pose, Quaternion, Pose2D
import numpy as np

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
    diff = Pose2dDiff(pose2d1, pose2d2)
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
    cr = np.cos(roll * 0.5)
    sr = np.sin(roll * 0.5)
    cp = np.cos(pitch * 0.5)
    sp = np.sin(pitch * 0.5)
    cy = np.cos(yaw * 0.5)
    sy = np.sin(yaw * 0.5)
    orientation.w = cr * cp * cy + sr * sp * sy
    orientation.x = sr * cp * cy - cr * sp * sy
    orientation.y = cr * sp * cy + sr * cp * sy
    orientation.z = cr * cp * sy - sr * sp * cy
    return orientation

def QuaternionToVector3(quaternion, two_d=False):
    """
        Convert Quaternion to Euler angle of type Vector3
    """
    q = quaternion
    sinr_cosp = 2 * (q.w * q.x + q.y * q.z)
    cosr_cosp = 1 - 2 * (q.x * q.x + q.y * q.y)

    siny_cosp = 2 * (q.w * q.z + q.x * q.y)
    cosy_cosp = 1 - 2 * (q.y * q.y + q.z * q.z)
    yaw = np.arctan2(siny_cosp, cosy_cosp)

    if not two_d:
        roll = np.arctan2(sinr_cosp, cosr_cosp)

        sinp = 2 * (q.w * q.y - q.z * q.x)
        if abs(sinp) >= 1:
            # use 90 degrees if out of range
            pitch = np.pi / 2 * np.sign(sinp)
        else:
            pitch = np.arcsin(sinp)

        return Vector3(roll, pitch, yaw)
    else:
        return Vector3(0., 0., yaw)

