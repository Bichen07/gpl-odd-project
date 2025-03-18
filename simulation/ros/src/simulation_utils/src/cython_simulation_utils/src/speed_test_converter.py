from simulation_utils.converter import Pose2DToPose as nocy
from simulation_utils.converter import PoseToPose2D as nocy2
from cy_converter import Pose2DToPose as cy
from cy_converter import PoseToPose2D as cy2
from geometry_msgs.msg import Pose2D, Pose, Point, Quaternion

if __name__ == '__main__':
    import numpy as np
    from timeit import default_timer
    n = 1000000
    test_data = np.abs(np.random.random_sample((n, 3)) * np.array([10000, 10000, np.pi]))

    t0 = default_timer()
    for t in test_data:
        nocy(Pose2D(t[0], t[1], t[2]))
    t1 = default_timer()

    t2 = default_timer()
    for t in test_data:
        cy(Pose2D(t[0], t[1], t[2]))
    t3 = default_timer()

    print("Pose2DToPose:")
    print("\tnormal: {:.5f}, avg: {:.8f}".format(t1-t0, (t1-t0)/n))
    print("\tcython: {:.5f}, avg: {:.8f}".format(t3-t2, (t3-t2)/n))


    test_data = np.abs(np.random.random_sample((n, 7)) * np.array([
        10000, 10000, 10000, np.pi, np.pi, np.pi, np.pi]))

    t0 = default_timer()
    for t in test_data:
        nocy2(Pose(Point(t[0], t[1], t[2]), Quaternion(t[3], t[4], t[5], t[6])))
    t1 = default_timer()

    t2 = default_timer()
    for t in test_data:
        cy2(Pose(Point(t[0], t[1], t[2]), Quaternion(t[3], t[4], t[5], t[6])))
    t3 = default_timer()

    print("PoseToPose2D:")
    print("\tnormal: {:.5f}, avg: {:.8f}".format(t1-t0, (t1-t0)/n))
    print("\tcython: {:.5f}, avg: {:.8f}".format(t3-t2, (t3-t2)/n))

"""
Pose2DToPose:
    normal: 12.33117, avg: 0.00001233
    cython: 7.96085, avg: 0.00000796
PoseToPose2D:
    normal: 15.98244, avg: 0.00001598
    cython: 9.60004, avg: 0.00000960
"""