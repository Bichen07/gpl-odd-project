import numpy as np
from geometry_msgs.msg import Pose, Quaternion, Vector3, Point

cdef class _mVec3d(object):
    cdef float x, y, z
    def __init__(self, x, y, z):
        self.x, self.y, self.z = x, y, z

    cdef get_array(self):
        cdef float arr[3]
        arr[0], arr[1], arr[2]
        return arr

    cdef get_numpy(self):
        return np.array([self.x, self.y, self.z])

    cdef get_msg(self):
        return Vector3(self.x, self.y, self.z)

    def __str__(self):
        return "<class _mVec3d x={}, y={}, z={}>"\
            "".format(self.x, self.y, self.z)

cdef mQuaternion_by_array(float[4] a):
    return _mQuaternion(a[0], a[1], a[2], a[3])

cdef mQuaternion(msg):
    return _mQuaternion(msg.x, msg.y, msg.z, msg.w)

cdef class _mQuaternion(object):
    # ref: https://zh.wikipedia.org/zh-tw/%E5%9B%9B%E5%85%83%E6%95%B8
    cdef float a
    cdef _mVec3d u

    def __init__(self, x, y, z, w):
        self.a = w
        self.u = _mVec3d(x, y, z)

    cdef get_msg(self):
        return Quaternion(self.u.x, self.u.y, self.u.z, self.a)

    cdef get_numpy(self):
        return np.array([self.u.x, self.u.y, self.u.z,self.a])

    def __str__(self):
        return "<class _mQuaternion x={}, y={}, z={}, w={}>"\
            "".format(self.u.x, self.u.y, self.u.z, self.a)

    def __add__(self, other):
        t = other.a
        v = other.u
        return _mQuaternion(
            self.u.x + v.x,
            self.u.y + v.y,
            self.u.z + v.z,
            self.a + t
        )

    def __neg__(self):
        return _mQuaternion(
            -self.u.x, -self.u.y, -self.u.z, -self.a)

    def __sub__(self, other):
        return self + (-other)

    # def __eq__(self, other):
    #     return abs(self.u.x - other.u.x) < 1e-12 \
    #         and abs(self.u.y - other.u.y) < 1e-12 \
    #         and abs(self.u.z - other.u.z) < 1e-12 \
    #         and abs(self.a - other.a) < 1e-12

    def __mul__(self, other):
        if type(other) != _mQuaternion:
            vec = other * self.get_numpy()
            return _mQuaternion(vec[0], vec[1], vec[2], vec[3])
        else:
            a, u = self.a, self.u.get_numpy()
            t, v = other.a, other.u.get_numpy()
            w = a * t - np.dot(u, v)
            vec = v * a + u * t + np.cross(u, v)
            return _mQuaternion(vec[0], vec[1], vec[2], w)

    def __div__(self, other):
        if type(other) != _mQuaternion:
            return self * (1./other)
        else:
            pass

    def __abs__(self):
        return (self.u.x**2 + self.u.y**2 + self.u.z**2 + self.a**2)**0.5

    cdef dot(self, _mQuaternion other):
        a, u = self.a, self.u.get_numpy()
        t, v = other.a, other.u.get_numpy()
        return a * t + np.dot(u, v)

    cdef cross(self, _mQuaternion other):
        a, u = self.a, self.u.get_numpy()
        t, v = other.a, other.u.get_numpy()
        return np.cross(u, v)

    cdef conjugate(self):
        return _mQuaternion(-self.u.x, -self.u.y, -self.u.z, self.a)

    cdef inverse(self):
        return self.conjugate() / self.dot(self)

    cdef sgn(self):
        return self / abs(self)

    cdef normalize(self):
        return _mQuaternion(self.u.x, self.u.y, self.u.z, self.a) / abs(self)

    cdef vec(self, str return_type="numpy"):
        if return_type == "numpy":
            return np.array([self.u.x, self.u.y, self.u.z])
        elif return_type == "point":
            return Point(self.u.x, self.u.y, self.u.z)
        else:
            return _mVec3d(self.u.x, self.u.y, self.u.z)

    cdef rotate(self, p): # p' = qpq**-1
        if type(p) == list: p = np.array(p).flatten()
        if type(p) is Quaternion: p = _mQuaternion(p.x, p.y, p.z, p.w)
        if type(p) is Vector3: p = np.array([p.x, p.y, p.z])
        if type(p) is Point: p = np.array([p.x, p.y, p.z])
        if type(p) is _mVec3d: p = p.get_numpy()
        if type(p) in [np.array, np.ndarray]:
            if p.shape == (3, ):
                quat = _mQuaternion(p[0], p[1], p[2], 0)
                return (self * quat * self.inverse()).vec()
            else:
                quat = _mQuaternion(*p)
                return self * quat
        elif type(p) == type(self):
            return self * p
        else: assert False, '%s, %s' % (type(p), type(self))

    cdef reverse_rotate(self, p): # p' = q**-1pq
        return self.inverse().rotate(p)

