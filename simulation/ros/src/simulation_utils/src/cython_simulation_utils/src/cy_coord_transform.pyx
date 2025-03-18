from geometry_msgs.msg import Point, Vector3, Pose, Quaternion, Pose2D
from geometry_msgs.msg import TransformStamped
import numpy as np
from simulation_utils.quaternion import mQuaternion

cpdef local_velocity_to_relative_velocity(ref_velocity_local, target_velocity_local):
    assert type(ref_velocity_local) is Vector3, type(ref_velocity_local)
    assert type(target_velocity_local) is Vector3, type(target_velocity_local)
    return Vector3(
        target_velocity_local.x - ref_velocity_local.x,
        target_velocity_local.y - ref_velocity_local.y,
        target_velocity_local.z - ref_velocity_local.z,
    )

# cpdef local_velocity_to_relative_velocity_from_global_ref_velocity(origin, ref_velocity_global, target_velocity_local):
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

cpdef relative_velocity_to_local_velocity(new_origin, ref_velocity_global, target_velocity_global):
    assert type(new_origin) is Pose, type(new_origin)
    assert type(ref_velocity_global) is Vector3, type(ref_velocity_global)
    assert type(target_velocity_global) is Vector3, type(target_velocity_global)
    relative_velocity_global = Vector3(
        target_velocity_global.x - ref_velocity_global.x,
        target_velocity_global.y - ref_velocity_global.y,
        target_velocity_global.z - ref_velocity_global.z
    )
    return global_velocity_to_local_velocity(new_origin, relative_velocity_global)

cpdef global_velocity_to_local_velocity(new_origin, target_velocity_global):
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

cpdef local_velocity_to_global_velocity(curr_origin, target_velocity_local):
    assert type(curr_origin) is Pose, type(curr_origin)
    assert type(target_velocity_local) is Vector3, type(target_velocity_local)
    origin = Pose()
    origin.orientation.w = 1
    new_origin = global_pose_to_local_pose(curr_origin, origin)
    return global_velocity_to_local_velocity(new_origin, target_velocity_local)

def transform_stamped_to_pose(trans):
    return Pose(
        Point(
            trans.transform.translation.x,
            trans.transform.translation.y,
            trans.transform.translation.z
        ),
        Quaternion(
            trans.transform.rotation.x,
            trans.transform.rotation.y,
            trans.transform.rotation.z,
            trans.transform.rotation.w
        )
    )
    return result

def transform_stamped_ref_a_to_ref_b(ref_origin, new_origin, target_pose):
    assert type(ref_origin) is TransformStamped, type(ref_origin)
    assert type(new_origin) is TransformStamped, type(new_origin)
    assert type(target_pose) is Pose, type(target_pose)
    return pose_ref_a_to_ref_b(
        transform_stamped_to_pose(ref_origin),
        transform_stamped_to_pose(new_origin),
        target_pose
    )

def pose_ref_a_to_ref_b(ref_origin, new_origin, target_pose):
    assert type(ref_origin) is Pose, type(ref_origin)
    assert type(new_origin) is Pose, type(new_origin)
    assert type(target_pose) is Pose, type(target_pose)
    target_global = local_pose_to_global_pose(ref_origin, target_pose)
    return global_pose_to_local_pose(new_origin, target_global)

cpdef global_pose_to_local_pose(new_origin, target_pose_global):
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


cpdef local_pose_to_global_pose(ref_origin, target_pose_local):
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
    A = Pose(
        Point(5, 3, 0),
        Quaternion(0, 0, 0.7071068, 0.7071068)
    )

    B = Pose(
        Point(5, 3, 0),
        Quaternion(0, 0, 0.7071068, 0.7071068)
    )

    # global_pose_to_local_pose(A, B)
    # print(global_pose_to_local_pose(A, B))
    print(local_pose_to_global_pose(A, B))
