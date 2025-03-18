from geometry_msgs.msg import Point, Vector3, Pose, Quaternion, Pose2D
import numpy as np
from simulation_utils.quaternion import mQuaternion


def local_velocity_to_relative_velocity(ref_velocity_local, target_velocity_local):
    assert type(ref_velocity_local) is Vector3, type(ref_velocity_local)
    assert type(target_velocity_local) is Vector3, type(target_velocity_local)
    return Vector3(
        target_velocity_local.x - ref_velocity_local.x,
        target_velocity_local.y - ref_velocity_local.y,
        target_velocity_local.z - ref_velocity_local.z,
    )

# def local_velocity_to_relative_velocity_from_global_ref_velocity(origin, ref_velocity_global, target_velocity_local):
#     assert type(origin) is Pose, type(origin)
#     assert type(ref_velocity_global) is Vector3, type(ref_velocity_global)
#     assert type(target_velocity_local) is Vector3, type(target_velocity_local)
#     ref_velocity_local = global_velocity_to_local_velocity(origin, ref_velocity_global)
#     return local_velocity_to_relative_velocity(ref_velocity_local, target_velocity_local)

# def relative_velocity_to_global_velocity(ref_velocity_global, target_velocity_relative):
#     assert type(ref_velocity_global) is Vector3, type(ref_velocity_global)
#     assert type(target_velocity_relative) is Vector3, type(target_velocity_relative)
#     return Vector3(
#         ref_velocity_global.x + target_velocity_relative.x,
#         ref_velocity_global.y + target_velocity_relative.y,
#         ref_velocity_global.z + target_velocity_relative.z
#     )

# NOT TESTED.
def relative_velocity_to_local_velocity(new_origin, ref_velocity_global, target_velocity_global):
    assert type(new_origin) is Pose, type(new_origin)
    assert type(ref_velocity_global) is Vector3, type(ref_velocity_global)
    assert type(target_velocity_global) is Vector3, type(target_velocity_global)
    relative_velocity_global = Vector3(
        target_velocity_global.x - ref_velocity_global.x,
        target_velocity_global.y - ref_velocity_global.y,
        target_velocity_global.z - ref_velocity_global.z
    )
    return global_velocity_to_local_velocity(new_origin, relative_velocity_global)

def global_velocity_to_local_velocity(new_origin, target_velocity_global):
    assert type(new_origin) is Pose, type(new_origin)
    assert type(target_velocity_global) is Vector3, type(target_velocity_global)
    new_origin_orientation = mQuaternion(new_origin.orientation)

    result_start_point_local = Vector3()
    result_start_point_local.x = - new_origin.position.x
    result_start_point_local.y = - new_origin.position.y
    result_start_point_local.z = - new_origin.position.z

    result_end_point_local = Vector3()
    result_end_point_local.x = target_velocity_global.x - new_origin.position.x
    result_end_point_local.y = target_velocity_global.y - new_origin.position.y
    result_end_point_local.z = target_velocity_global.z - new_origin.position.z

    result_start_point_local = Point(*new_origin_orientation.reverse_rotate(result_start_point_local))
    result_end_point_local = Point(*new_origin_orientation.reverse_rotate(result_end_point_local))

    return Vector3(
        result_end_point_local.x - result_start_point_local.x,
        result_end_point_local.y - result_start_point_local.y,
        result_end_point_local.z - result_start_point_local.z
    )

def local_velocity_to_global_velocity(curr_origin, target_velocity_local):
    assert type(curr_origin) is Pose, type(curr_origin)
    assert type(target_velocity_local) is Vector3, type(target_velocity_local)
    origin = Pose()
    origin.orientation.w = 1
    new_origin = global_pose_to_local_pose(curr_origin, origin)
    return global_velocity_to_local_velocity(new_origin, target_velocity_local)

def global_pose_to_local_pose(new_origin, target_pose_global):
    assert type(new_origin) is Pose, type(new_origin)
    assert type(target_pose_global) is Pose, type(target_pose_global)
    result_pose_local = Pose()
    result_pose_local.position.x = target_pose_global.position.x - new_origin.position.x
    result_pose_local.position.y = target_pose_global.position.y - new_origin.position.y
    result_pose_local.position.z = target_pose_global.position.z - new_origin.position.z

    new_origin_orientation = mQuaternion(new_origin.orientation)
    target_pose_global_orientation = mQuaternion(target_pose_global.orientation)

    result_pose_local.position = Point(*new_origin_orientation.reverse_rotate(result_pose_local.position))

    result_pose_local.orientation = \
        new_origin_orientation.reverse_rotate(target_pose_global_orientation).normalize().get_msg()

    return result_pose_local

def local_pose_to_global_pose(ref_origin, target_pose_local):
    assert type(ref_origin) is Pose, type(ref_origin)
    assert type(target_pose_local) is Pose, type(target_pose_local)

    result_pose_global = Pose()
    ref_origin_orientation = mQuaternion(ref_origin.orientation)
    target_pose_local_orientation = mQuaternion(target_pose_local.orientation)

    result_pose_global.position = Point(*ref_origin_orientation.rotate(target_pose_local.position))

    result_pose_global.position.x += ref_origin.position.x
    result_pose_global.position.y += ref_origin.position.y
    result_pose_global.position.z += ref_origin.position.z
    result_pose_global.orientation = \
        ref_origin_orientation.rotate(target_pose_local_orientation).normalize().get_msg()

    return result_pose_global

if __name__ == '__main__':
    import copy
    from simulation_utils.converter import EulerAngleToQuaternion
    x = (np.random.random() - 0.5) * 2 * 100
    y = (np.random.random() - 0.5) * 2 * 100
    yaw = (np.random.random() - 0.5) * 2 * np.pi # * 0
    orientation = EulerAngleToQuaternion([0, 0, yaw])
    origin = Pose(Point(x, y, 0.), copy.deepcopy(orientation))

    x = (np.random.random() - 0.5) * 2 * 100
    y = (np.random.random() - 0.5) * 2 * 100
    yaw = (np.random.random() - 0.5) * 2 * np.pi # * 0
    orientation = EulerAngleToQuaternion([0, 0, yaw])
    target = Pose(Point(x, y, 0.), copy.deepcopy(orientation))

    vx1 = (np.random.random() - 0.5) * 2 * 20
    vy1 = (np.random.random() - 0.5) * 2 * 20
    vx2 = (np.random.random() - 0.5) * 2 * 20
    vy2 = (np.random.random() - 0.5) * 2 * 20
    gv1 = Vector3(vx1, vy1, 0.)
    gv2 = Vector3(vx2, vy2, 0.)

    length_gv1 = (gv1.x**2 + gv1.y**2 + gv1.z**2)**0.5
    length_gv2 = (gv2.x**2 + gv2.y**2 + gv2.z**2)**0.5

    # Test 1
    lp = global_pose_to_local_pose(origin, target)
    gp = local_pose_to_global_pose(origin, lp)

    print("\n")
    try:
        assert abs(target.position.x - gp.position.x) < 1e-12 \
            and abs(target.position.y - gp.position.y) < 1e-12 \
            and abs(target.orientation.x - gp.orientation.x) < 1e-12 \
            and abs(target.orientation.y - gp.orientation.y) < 1e-12 \
            and abs(target.orientation.z - gp.orientation.z) < 1e-12 \
            and abs(target.orientation.w - gp.orientation.w) < 1e-12
        print("\033[1;33mTest 1 Pass!\n\n\033[0m")
    except AssertionError as e:
        print("\033[1;31mPose Transform Error: \033[0m")
        print("Target Pose Ground Truth: \n{}\n".format(target))
        print("Target Pose Calculated:   \n{}\n\n".format(gp))

    # Test 2
    lv2 = global_velocity_to_local_velocity(origin, gv2)
    gv2_calculate = local_velocity_to_global_velocity(origin, lv2)
    try:
        assert abs(gv2.x - gv2_calculate.x) < 1e-12 \
            and abs(gv2.y - gv2_calculate.y) < 1e-12 \
            and abs(gv2.z - gv2_calculate.z) < 1e-12
        print("\033[1;33mTest 2 Pass!\n\n\033[0m")
    except AssertionError as e:
        print("\033[1;31mVelocity Transform Error: \033[0m")
        print("origin: \n{}\n".format(origin))
        print("lv2: \n{}\n".format(lv2))
        print("Target Vel Ground Truth: \n{}\n".format(gv2))
        print("Target Vel Calculated:   \n{}\n".format(gv2_calculate))


    # # Test 3
    # lv1 = global_velocity_to_local_velocity(origin, gv1)
    # rv2 = local_velocity_to_relative_velocity(lv1, lv2)
    # gv2_calculate = relative_velocity_to_global_velocity(gv1, rv2)

    # try:
    #     length_gv2 = (gv2.x**2 + gv2.y**2 + gv2.z**2)**0.5
    #     length_rv2 = (rv2.x**2 + rv2.y**2 + rv2.z**2)**0.5
    #     length_gv2_calculate = (gv2_calculate.x**2 + gv2_calculate.y**2 + gv2_calculate.z**2)**0.5
    #     assert abs(gv2.x - gv2_calculate.x) < 1e-12 \
    #         and abs(gv2.y - gv2_calculate.y) < 1e-12 \
    #         and abs(gv2.z - gv2_calculate.z) < 1e-12 \
    #         and abs(length_gv2 - length_gv2_calculate) < 1e-12
    #     print("\033[1;33mTest 3 Pass!\n\n\033[0m")
    # except AssertionError as e:
    #     print("\033[1;31mGlobal Relative Velocity Transform Error: \033[0m")
    #     print("diff| {}, {}, {}".format(
    #         gv2.x - gv2_calculate.x,
    #         gv2.y - gv2_calculate.y,
    #         gv2.z - gv2_calculate.z))
    #     print("length| gv2: {}, gv2_calculate: {}".format(length_gv2, length_gv2_calculate))
    #     print("origin: \n{}\n".format(origin))
    #     print("target: \n{}\n".format(target))
    #     print("gv1: \n{}\n".format(gv1))
    #     print("gv2: \n{}\n".format(gv2))
    #     print("lv1: \n{}\n".format(lv1))
    #     print("rv2: \n{}\n".format(rv2))
    #     print("global Target Vel Ground Truth: \n{}\n".format(gv2))
    #     print("global Target Vel Calculated:   \n{}\n".format(gv2_calculate))

    # # Test 4
    # lv2_calculate = relative_velocity_to_local_velocity(origin, gv1, gv2)
    # try:
    #     length_lv2 = (lv2.x**2 + lv2.y**2 + lv2.z**2)**0.5
    #     length_rv2 = (rv2.x**2 + rv2.y**2 + rv2.z**2)**0.5
    #     length_lv2_calculate = (lv2_calculate.x**2 + lv2_calculate.y**2 + lv2_calculate.z**2)**0.5
    #     assert abs(lv2.x - lv2_calculate.x) < 1e-12 \
    #         and abs(lv2.y - lv2_calculate.y) < 1e-12 \
    #         and abs(lv2.z - lv2_calculate.z) < 1e-12 \
    #         and abs(length_lv2 - length_lv2_calculate) < 1e-12 \
    #         and abs(length_gv2 - length_lv2_calculate) < 1e-12 \
    #         and abs(length_gv2 - length_lv2) < 1e-12
    #     print("\033[1;33mTest 4 Pass!\n\n\033[0m")
    # except AssertionError as e:
    #     print("\033[1;31mRelative Velocity Transform Error: \033[0m")
    #     print("diff| {}, {}, {}".format(
    #         lv2.x - lv2_calculate.x,
    #         lv2.y - lv2_calculate.y,
    #         lv2.z - lv2_calculate.z))
    #     print("length| gv2: {}, lv2: {}, lv2_calculate: {}".format(length_gv2, length_lv2, length_lv2_calculate))
    #     print("origin: \n{}\n".format(origin))
    #     print("target: \n{}\n".format(target))
    #     print("gv1: \n{}\n".format(gv1))
    #     print("gv2: \n{}\n".format(gv2))
    #     print("lv1: \n{}\n".format(lv1))
    #     print("rv2: \n{}\n".format(rv2))
    #     print("Relative Target Vel Ground Truth: \n{}\n".format(lv2))
    #     print("Relative Target Vel Calculated:   \n{}\n".format(lv2_calculate))

