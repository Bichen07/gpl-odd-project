#include "utils_coord_transform.h"
namespace utils_coord{

geometry_msgs::Vector3 CoordinateTransform(
    const tf::Transform & newOriginTfTransformGlobal,
    const tf::Vector3 & tragetTfVector3)
{
    tf::Vector3 end = tragetTfVector3;
    tf::Vector3 origin = tf::Vector3(0., 0., 0.);
    tf::Vector3 output =
        newOriginTfTransformGlobal.inverse() * end -
        newOriginTfTransformGlobal.inverse() * origin;
    geometry_msgs::Vector3 outputMsg;
    outputMsg.x = output.x();
    outputMsg.y = output.y();
    outputMsg.z = output.z();
    return outputMsg;
}

geometry_msgs::Vector3 CoordinateTransform(
    const tf::Transform & newOriginTfTransformGlobal,
    const geometry_msgs::Vector3 targetVectorGlobal)
{
    tf::Vector3 targetTfVectorGlobal = tf::Vector3(
        targetVectorGlobal.x,
        targetVectorGlobal.y,
        targetVectorGlobal.z);
    return CoordinateTransform(
        newOriginTfTransformGlobal, targetTfVectorGlobal);
}

geometry_msgs::Vector3 CoordinateTransform(
    const geometry_msgs::Pose newOriginPoseGlobal,
    const geometry_msgs::Vector3 targetVectorGlobal)
{
    tf::Transform newOriginTfTransformGlobal;
    newOriginTfTransformGlobal.setOrigin(tf::Point(
        newOriginPoseGlobal.position.x,
        newOriginPoseGlobal.position.y,
        newOriginPoseGlobal.position.z));
    newOriginTfTransformGlobal.setRotation(tf::Quaternion(
        newOriginPoseGlobal.orientation.x,
        newOriginPoseGlobal.orientation.y,
        newOriginPoseGlobal.orientation.z,
        newOriginPoseGlobal.orientation.w));
    tf::Vector3 targetTfVectorGlobal = tf::Vector3(
        targetVectorGlobal.x,
        targetVectorGlobal.y,
        targetVectorGlobal.z);
    return CoordinateTransform(
        newOriginTfTransformGlobal, targetTfVectorGlobal);
}

geometry_msgs::Pose CoordinateTransform(
    const tf::Transform & newOriginTfTransformGlobal,
    const tf::Pose targetTfPoseGlobal)
{
    geometry_msgs::Pose resultPoseTransformed;
    tf::Pose targetTfPoseTransformed = \
        newOriginTfTransformGlobal.inverse() * targetTfPoseGlobal;
    targetTfPoseTransformed.setRotation(
        targetTfPoseTransformed.getRotation().normalize());
    tf::poseTFToMsg(targetTfPoseTransformed, resultPoseTransformed);
    return resultPoseTransformed;
}

geometry_msgs::Pose CoordinateTransform(
    const tf::Transform & newOriginTfTransformGlobal,
    const geometry_msgs::Point & targetPointGlobal,
    const geometry_msgs::Quaternion & targetOrientationGlobal)
{
    tf::Pose targetTfPoseGlobal;
    targetTfPoseGlobal.setOrigin(tf::Point(
        targetPointGlobal.x, targetPointGlobal.y, targetPointGlobal.z));
    targetTfPoseGlobal.setRotation(tf::Quaternion(
        targetOrientationGlobal.x, targetOrientationGlobal.y,
        targetOrientationGlobal.z, targetOrientationGlobal.w));
    return CoordinateTransform(
        newOriginTfTransformGlobal, targetTfPoseGlobal);
}

geometry_msgs::Pose CoordinateTransform(
    const tf::Transform & newOriginTfTransformGlobal,
    const geometry_msgs::Pose & targetPoseGlobal)
{
    return CoordinateTransform(
        newOriginTfTransformGlobal,
        targetPoseGlobal.position,
        targetPoseGlobal.orientation);
}

geometry_msgs::Pose CoordinateTransform(
    const geometry_msgs::Pose newOriginPoseGlobal,
    const tf::Pose targetTfPoseGlobal)
{
    tf::Transform newOriginTfTransformGlobal;
    newOriginTfTransformGlobal.setOrigin(tf::Point(
        newOriginPoseGlobal.position.x,
        newOriginPoseGlobal.position.y,
        newOriginPoseGlobal.position.z));
    newOriginTfTransformGlobal.setRotation(tf::Quaternion(
        newOriginPoseGlobal.orientation.x,
        newOriginPoseGlobal.orientation.y,
        newOriginPoseGlobal.orientation.z,
        newOriginPoseGlobal.orientation.w));
    return CoordinateTransform(
        newOriginTfTransformGlobal,
        targetTfPoseGlobal);
}

geometry_msgs::Pose CoordinateTransform(
    const geometry_msgs::Pose newOriginPoseGlobal,
    const geometry_msgs::Pose targetPoseGlobal)
{
    tf::Transform newOriginTfTransformGlobal;
    newOriginTfTransformGlobal.setOrigin(tf::Point(
        newOriginPoseGlobal.position.x,
        newOriginPoseGlobal.position.y,
        newOriginPoseGlobal.position.z));
    newOriginTfTransformGlobal.setRotation(tf::Quaternion(
        newOriginPoseGlobal.orientation.x,
        newOriginPoseGlobal.orientation.y,
        newOriginPoseGlobal.orientation.z,
        newOriginPoseGlobal.orientation.w));
    return CoordinateTransform(
        newOriginTfTransformGlobal,
        targetPoseGlobal.position,
        targetPoseGlobal.orientation);
}

geometry_msgs::Pose CoordinateTransform(
    const geometry_msgs::Pose newOriginPoseGlobal,
    const geometry_msgs::Pose2D targetPose2dGlobal)
{
    tf::Pose targetTfPoseGlobal;
    targetTfPoseGlobal.setOrigin(tf::Point(
        targetPose2dGlobal.x,
        targetPose2dGlobal.y,
        0.0f));
    targetTfPoseGlobal.setRotation(tf::Quaternion(
        0.0f,
        0.0f,
        sin(targetPose2dGlobal.theta/2),
        cos(targetPose2dGlobal.theta/2)));
    return CoordinateTransform(
        newOriginPoseGlobal,
        targetTfPoseGlobal);
}



geometry_msgs::Pose CoordinateTransformToGlobal(
    const tf::Transform tfTransformGlobal,
    const tf::Pose targetTfPoseLocal)
{
    geometry_msgs::Pose resultPoseTransformed;
    tf::Pose targetTfPoseTransformed = \
        tfTransformGlobal * targetTfPoseLocal;
    targetTfPoseTransformed.setRotation(
        targetTfPoseTransformed.getRotation().normalize());
    tf::poseTFToMsg(targetTfPoseTransformed, resultPoseTransformed);
    return resultPoseTransformed;
}

geometry_msgs::Pose CoordinateTransformToGlobal(
    const tf::Transform tfTransformGlobal,
    const geometry_msgs::Pose targetPoseLocal)
{
    tf::Pose targetTfPoseGlobal;
    targetTfPoseGlobal.setOrigin(tf::Point(
        targetPoseLocal.position.x,
        targetPoseLocal.position.y,
        targetPoseLocal.position.z));
    targetTfPoseGlobal.setRotation(tf::Quaternion(
        targetPoseLocal.orientation.x,
        targetPoseLocal.orientation.y,
        targetPoseLocal.orientation.z,
        targetPoseLocal.orientation.w));
    return CoordinateTransformToGlobal(
        tfTransformGlobal, targetTfPoseGlobal);
}

geometry_msgs::Pose CoordinateTransformToGlobal(
    const geometry_msgs::Pose poseGlobal,
    const geometry_msgs::Pose targetPoseLocal)
{
    tf::Transform tfTransformGlobal;
    tfTransformGlobal.setOrigin(tf::Point(
        poseGlobal.position.x,
        poseGlobal.position.y,
        poseGlobal.position.z));
    tfTransformGlobal.setRotation(tf::Quaternion(
        poseGlobal.orientation.x,
        poseGlobal.orientation.y,
        poseGlobal.orientation.z,
        poseGlobal.orientation.w));
    return CoordinateTransformToGlobal(
        tfTransformGlobal, targetPoseLocal);
}

geometry_msgs::Pose CoordinateTransformToGlobal(
    const geometry_msgs::Point positionGlobal,
    const float orientationGlobal,
    const geometry_msgs::Pose targetPoseLocal)
{
    tf::Transform tfTransformGlobal;
    tfTransformGlobal.setOrigin(tf::Point(
        positionGlobal.x,
        positionGlobal.y,
        positionGlobal.z));
    tfTransformGlobal.setRotation(tf::Quaternion(
        0.0f,
        0.0f,
        sin(orientationGlobal/2),
        cos(orientationGlobal/2)));
    return CoordinateTransformToGlobal(
        tfTransformGlobal, targetPoseLocal);
}


} // namespace utils_coord{