#ifndef _UTILS_CONVERTER_H_
#define _UTILS_CONVERTER_H_

#include <std_msgs/ColorRGBA.h>
#include <geometry_msgs/Accel.h>
#include <geometry_msgs/Point.h>
#include <geometry_msgs/Pose.h>
#include <geometry_msgs/Pose2D.h>
#include <geometry_msgs/Quaternion.h>
#include <geometry_msgs/Twist.h>
#include <tf/transform_listener.h>
#include <math_type.h>

namespace utils {

math::Vector2d_t ConvertToVector2d(const geometry_msgs::Point &point);
math::Vector2d_t ConvertToVector2d(const math::Vector3d_t &vector3d);

math::Vector3d_t ConvertToVector3d(const geometry_msgs::Vector3 &vector3);
math::Vector3d_t ConvertToVector3d(const geometry_msgs::Pose &pose);
math::Vector3d_t ConvertToVector3d(const geometry_msgs::Quaternion &orientation);
math::Vector3d_t ConvertToVector3d(const geometry_msgs::Point &point);
math::Vector3d_t ConvertToVector3d(const tf::Vector3 &tfvector3);
math::Vector3d_t ConvertToVector3d(
    const math::Vector2d_t &vector2d,
    const math::real_t coordZ);
std::vector<math::Vector3d_t> ConvertToVector3ds(
    const std::vector<math::Vector2d_t> &vector2ds,
    const math::real_t coordZ);
std::vector<math::Vector2d_t> ConvertToVector2ds(const std::vector<math::Vector3d_t> &vector3ds);

math::Vector6d_t ConvertToVector6d(const geometry_msgs::Twist &twist);

math::RotMat3d_t ConvertToRotMat3d(const tf::Matrix3x3 &tfrotmat);

math::Quaternion_t ConvertToQuaternion(const geometry_msgs::Quaternion &quaternionMsg);
math::Quaternion_t ConvertToQuaternion(const tf::Quaternion &tfQuaternion);

math::HomoXfm3d_t ConvertToHomoXfm3d(const tf::Transform &tfTransform);
math::HomoXfm3d_t ConvertToHomoXfm3d(const geometry_msgs::Pose &pose);

geometry_msgs::Vector3 ConvertToGeometryMsgsVector3(const geometry_msgs::Quaternion &orientation);
geometry_msgs::Vector3 ConvertToGeometryMsgsVector3(
    const math::real_t x,
    const math::real_t y,
    const math::real_t z);
geometry_msgs::Vector3 ConvertToGeometryMsgsVector3(const math::Vector3d_t &vector3d);
geometry_msgs::Vector3 ConvertToGeometryMsgsVector3(const tf::Vector3 &vector3);
geometry_msgs::Point32 ConvertToGeometryMsgsPoint32(const geometry_msgs::Point &point);
geometry_msgs::Point32 ConvertToGeometryMsgsPoint32(const tf::Point &tfPoint);
geometry_msgs::Point32 ConvertToGeometryMsgsPoint32(const math::Vector3d_t &vector3d);
geometry_msgs::Point ConvertToGeometryMsgsPoint(const math::Vector3d_t &vector3d);
geometry_msgs::Point ConvertToGeometryMsgsPoint(const tf::Vector3 &tfVector3);
geometry_msgs::Point ConvertToGeometryMsgsPoint(const geometry_msgs::Point32 &point32);
geometry_msgs::Accel ConvertToGeometryMsgsAccel(const math::Vector6d_t &vector6d);

geometry_msgs::Quaternion ConvertToGeometryMsgsQuaternion(const math::real_t orientation);
geometry_msgs::Quaternion ConvertToGeometryMsgsQuaternion(const geometry_msgs::Vector3 &eulerAngles);
geometry_msgs::Quaternion ConvertToGeometryMsgsQuaternion(const math::Quaternion_t &quaternion);
geometry_msgs::Quaternion ConvertToGeometryMsgsQuaternion(const tf::Quaternion &tfQuaternion);

geometry_msgs::Pose ConvertToGeometryMsgsPose(const geometry_msgs::Pose2D &pose2d);
geometry_msgs::Pose ConvertToGeometryMsgsPose(const math::Vector3d_t &vector3d);
geometry_msgs::Pose ConvertToGeometryMsgsPose(const tf::Vector3 &vector3);
geometry_msgs::Pose ConvertToGeometryMsgsPose(
    const math::real_t x,
    const math::real_t y,
    const math::real_t z);
geometry_msgs::Pose ConvertToGeometryMsgsPose(
    const math::RotMat3d_t &rotmat3d,
    const math::Vector3d_t &translation3d);
geometry_msgs::Pose ConvertToGeometryMsgsPose(
    const math::Quaternion_t &orientation,
    const math::Vector3d_t &position);
geometry_msgs::Pose ConvertToGeometryMsgsPose(
    const math::Vector3d_t &position,
    const math::Quaternion_t &orientation);
geometry_msgs::Pose ConvertToGeometryMsgsPose(const math::HomoXfm3d_t &transform);
geometry_msgs::Pose ConvertToGeometryMsgsPose(const tf::Pose &tfPose);

tf::Point ConvertToTfPoint(const math::Vector3d_t &vector);
tf::Point ConvertToTfPoint(const geometry_msgs::Point32 &point32);
tf::Vector3 ConvertToTfVector3(const math::Vector3d_t &vector);
tf::Vector3 ConvertToTfVector3(const geometry_msgs::Vector3 &vector3);
tf::Vector3 ConvertToTfVector3(const geometry_msgs::Point &point);
tf::Vector3 ConvertToTfVector3(const geometry_msgs::Point32 &point32);

tf::Quaternion ConvertToTfQuaternion(const math::Quaternion_t &quaternion);
tf::Quaternion ConvertToTfQuaternion(const geometry_msgs::Quaternion &quaternion);

std_msgs::ColorRGBA ConvertToColorRGBA(
    const float red,
    const float green,
    const float blue,
    const float alpha);

} // namespace utils {

#endif // #ifndef _UTILS_CONVERTER_H_
