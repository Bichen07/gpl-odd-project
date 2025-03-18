from geometry_msgs.msg import Point, Polygon, Vector3
import numpy as np

import cy_bounding_box_utils

def get_bounding_box_normal(x, y, z, orientation, size):
    if type(size) in [list, tuple]:
        size = Vector3(*size)
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

if __name__ == '__main__':
    import numpy as np
    from timeit import default_timer
    n = 1000000
    test_data = np.abs(np.random.random_sample((n, 7)) * np.array([100., 100., 1., 6.28, 3., 3., 3.]))

    nocy = get_bounding_box_normal
    cy = cy_bounding_box_utils.get_bounding_box

    t0 = default_timer()
    for t in test_data:
        nocy(t[0], t[1], t[2], t[3], Vector3(t[4], t[5], t[6]))
    t1 = default_timer()

    t2 = default_timer()
    for t in test_data:
        cy(t[0], t[1], t[2], t[3], Vector3(t[4], t[5], t[6]))
    t3 = default_timer()

    print("normal: {:.5f}, avg: {:.8f}".format(t1-t0, (t1-t0)/n))
    print("cython: {:.5f}, avg: {:.8f}".format(t3-t2, (t3-t2)/n))

"""
normal: 29.69574, avg: 0.00002970
cython: 15.15259, avg: 0.00001515
"""