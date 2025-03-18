import numpy as np
from geometry_msgs.msg import Point, Polygon

def get_bounding_box(x, y, z, orientation, size):
    l = (size.x ** 2 + size.y ** 2) ** 0.5 / 2.
    phi = np.arctan2(size.x, size.y)
    gamma1 = orientation + phi - np.pi / 2.
    gamma2 = gamma1 - 2 * phi
    gamma3 = gamma1 - np.pi
    gamma4 = gamma3 - 2 * phi
    cg1 = np.cos(gamma1)
    sg1 = np.sin(gamma1)
    cg2 = np.cos(gamma2)
    sg2 = np.sin(gamma2)
    cg3 = np.cos(gamma3)
    sg3 = np.sin(gamma3)
    cg4 = np.cos(gamma4)
    sg4 = np.sin(gamma4)
    z += size.z / 2

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
