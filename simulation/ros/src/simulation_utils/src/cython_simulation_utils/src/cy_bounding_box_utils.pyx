from geometry_msgs.msg import Point, Polygon
import numpy as np
from libc.math cimport sin, cos, atan2, asin, pi, sqrt

cpdef get_bounding_box(x, y, z, orientation, size):
    return _get_bounding_box(
        x, y, z, orientation, size.x, size.y, size.z)

cdef _get_bounding_box(
        float x, float y, float z, float orientation,
        float size_x, float size_y, float size_z):
    cdef float l = sqrt(size_x * size_x + size_y * size_y) / 2.0
    cdef float phi = atan2(size_x, size_y)
    cdef float gamma1 = orientation + phi - pi / 2.0
    cdef float gamma2 = gamma1 - 2 * phi
    cdef float gamma3 = gamma1 - np.pi
    cdef float gamma4 = gamma3 - 2 * phi
    cdef float cg1 = cos(gamma1)
    cdef float sg1 = sin(gamma1)
    cdef float cg2 = cos(gamma2)
    cdef float sg2 = sin(gamma2)
    cdef float cg3 = cos(gamma3)
    cdef float sg3 = sin(gamma3)
    cdef float cg4 = cos(gamma4)
    cdef float sg4 = sin(gamma4)
    z += size_z / 2.0

    return Polygon([
        Point(x + l * cg1, y + l * sg1, z),
        Point(x + l * cg2, y + l * sg2, z),
        Point(x + l * cg3, y + l * sg3, z),
        Point(x + l * cg4, y + l * sg4, z),
        Point(x + l * cg1, y + l * sg1, z),
        Point(x + l * cg2, y + l * sg2, z),
        Point(x + l * cg3, y + l * sg3, z),
        Point(x + l * cg4, y + l * sg4, z),
        Point(x + l * cg1, y + l * sg1, z)
    ])


