#ifndef _UTILS_COORD_TRANSFORM_H_
#define _UTILS_COORD_TRANSFORM_H_

#include <geometry_msgs/Point.h>
#include <geometry_msgs/Point32.h>
#include <geometry_msgs/Pose.h>
#include <geometry_msgs/Pose2D.h>
#include <geometry_msgs/Quaternion.h>
#include <geometry_msgs/Twist.h>
#include <geometry_msgs/Vector3.h>
#include <tf/tf.h>
#include <math_type.h>

namespace utils_coord {

geometry_msgs::Vector3 CoordinateTransform(
    const tf::Transform & newOriginTfTransformGlobal,
    const tf::Vector3 & tragetTfVector3);

geometry_msgs::Vector3 CoordinateTransform(
    const tf::Transform & newOriginTfTransformGlobal,
    const geometry_msgs::Vector3 targetVectorGlobal);

geometry_msgs::Vector3 CoordinateTransform(
    const geometry_msgs::Pose newOriginePoseGlobal,
    const geometry_msgs::Vector3 targetVectorGlobal);

geometry_msgs::Pose CoordinateTransform(
    const tf::Transform & newOriginTfTransformGlobal,
    const tf::Pose targetTfPoseGlobal);

geometry_msgs::Pose CoordinateTransform(
    const tf::Transform & newOriginTfTransformGlobal,
    const geometry_msgs::Point & targetPointGlobal,
    const geometry_msgs::Quaternion & targetOrientationGlobal);

geometry_msgs::Pose CoordinateTransform(
    const tf::Transform & newOriginTfTransformGlobal,
    const geometry_msgs::Pose & targetPoseGlobal);

geometry_msgs::Pose CoordinateTransform(
    const geometry_msgs::Pose newOriginPoseGlobal,
    const tf::Pose targetTfPoseGlobal);

geometry_msgs::Pose CoordinateTransform(
    const geometry_msgs::Pose newOriginPoseGlobal,
    const geometry_msgs::Pose targetPoseGlobal);

geometry_msgs::Pose CoordinateTransform(
    const geometry_msgs::Pose newOriginPoseGlobal,
    const geometry_msgs::Pose2D targetPose2dGlobal);


geometry_msgs::Pose CoordinateTransformToGlobal(
    const tf::Transform tfTransformGlobal,
    const tf::Pose targetTfPoseLocal);

geometry_msgs::Pose CoordinateTransformToGlobal(
    const tf::Transform tfTransformGlobal,
    const geometry_msgs::Pose targetPoseLocal);

geometry_msgs::Pose CoordinateTransformToGlobal(
    const geometry_msgs::Pose poseGlobal,
    const geometry_msgs::Pose targetPoseLocal);

geometry_msgs::Pose CoordinateTransformToGlobal(
    const geometry_msgs::Point positionGlobal,
    const float orientationGlobal,
    const geometry_msgs::Pose targetPoseLocal);

} // namespace utils_coord {

#endif // #ifndef _UTILS_COORD_TRANSFORM_H_
