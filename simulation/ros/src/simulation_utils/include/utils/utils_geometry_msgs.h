#ifndef _UTILS_GEOMETRY_MSGS_H_
#define _UTILS_GEOMETRY_MSGS_H_

#include <geometry_msgs/Accel.h>
#include <geometry_msgs/Vector3.h>
#include <geometry_msgs/Pose.h>
#include <geometry_msgs/Polygon.h>
#include <tf/tf.h>
#include <math_type.h>

namespace utils {

geometry_msgs::Vector3 GetZeroGeometryMsgsVector3();
geometry_msgs::Point GetZeroGeometryMsgsPoint();
geometry_msgs::Accel GetZeroGeometryMsgsAccel();
geometry_msgs::Quaternion GetIdentityGeometryMsgsQuaternion();
geometry_msgs::Pose GetIdentityGeometryMsgsPose();
geometry_msgs::Polygon ComputeGeometryMsgsLocalCoordCubePolygon(
    const geometry_msgs::Pose &cubePoseMsg,
    const math::Vector3d_t &cubeSize,
    const tf::StampedTransform &baseLinkToWorldTransform);
geometry_msgs::Polygon ComputeGeometryMsgsWorldCoordCubePolygon(
    const geometry_msgs::Pose &cubePoseMsg,
    const math::Vector3d_t &cubeSize);
geometry_msgs::Polygon ComputeGeometryMsgsLocalCoordPolygonalColumn(
    const std::vector<math::Vector3d_t> &worldCorners,
    const tf::StampedTransform &baselinkToWorldTransform);
geometry_msgs::Polygon ComputeGeometryMsgsWorldCoordPoygonalColumn(
    const std::vector<math::Vector3d_t> &worldCorners);
geometry_msgs::Pose ComputeOffsetPose(
    const geometry_msgs::Pose &originalPose,
    const geometry_msgs::Vector3 &offset);
double ComputeSquaredNorm(const geometry_msgs::Vector3 &vector3);
double ComputeNorm(const geometry_msgs::Vector3 &vector3);
geometry_msgs::Quaternion ComputeOrientationXy(const geometry_msgs::Vector3 &vector3);
bool IsApprox(
    const geometry_msgs::Point32 &firstPoint,
    const geometry_msgs::Point32 &secondPoint,
    const double epsilon = double{1.0e-5});
bool IsApprox(
    const geometry_msgs::Point &firstPoint,
    const geometry_msgs::Point &secondPoint,
    const double epsilon = double{1.0e-5});
bool IsApprox(
    const geometry_msgs::Vector3 &firstVector,
    const geometry_msgs::Vector3 &secondVector,
    const double epsilon = double{1.0e-5});
bool IsApprox(
    const geometry_msgs::Quaternion &firstQuaternion,
    const geometry_msgs::Quaternion &secondQuaternion,
    const double epsilon = double{1.0e-5});
bool IsApprox(
    const geometry_msgs::Pose &firstPose,
    const geometry_msgs::Pose &secondPose,
    const double epsilon = double{1.0e-5});
template<typename CoordXyzType>
bool IsApproxZero(
    const CoordXyzType &input,
    const double epsilon = double{1.0e-5});

} // namespace utils {

#endif // #ifndef _UTILS_GEOMETRY_MSGS_H_
