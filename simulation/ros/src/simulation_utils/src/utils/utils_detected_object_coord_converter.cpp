#include <utils_detected_object_coord_converter.h>
#include <stdexcept>
#include <ros/console.h>
#include <geometry_msgs/PoseStamped.h>
#include <geometry_msgs/PointStamped.h>
#include <geometry_msgs/Vector3Stamped.h>
#include <utils_converter.h>

namespace utils {

// public func.

DetectedObjectCoordConverter::DetectedObjectCoordConverter()
    : mTransformListener{}
    , mBaseLinkId{"/base_link"}
{
    std::string ns = ros::this_node::getNamespace();
    mBaseLinkId = (ns=="" || ns=="/")?("base_link"):(ns + "/base_link");
}

void DetectedObjectCoordConverter::ToWorldCoord(
    const itri_msgs::DetectedObjectArray &localObjectArray,
    itri_msgs::DetectedObjectArray &worldObjectArray)
{
    worldObjectArray.objects.resize(
        localObjectArray.objects.size());
    auto worldObject{worldObjectArray.objects.begin()};
    auto localObject{localObjectArray.objects.cbegin()};
    for (; localObject != localObjectArray.objects.cend();
         ++localObject, ++worldObject)
    {
        *worldObject = *localObject;
        this->ToWorldCoord(
            localObjectArray.header.stamp,
            localObject->pose,
            worldObject->pose);
    }
}

void DetectedObjectCoordConverter::ToLocalCoord(
    const itri_msgs::DetectedObjectArray &worldObjectArray,
    itri_msgs::DetectedObjectArray &localObjectArray)
{
    ROS_ERROR_STREAM("no implementation");
    throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    localObjectArray.objects.resize(
        worldObjectArray.objects.size());
    auto localObject{localObjectArray.objects.cbegin()};
    auto worldObject{worldObjectArray.objects.begin()};
    for (; worldObject != worldObjectArray.objects.cend();
         ++worldObject, ++localObject)
    {
    }
}

void DetectedObjectCoordConverter::ToWorldCoord(
    const ros::Time &stamp,
    const geometry_msgs::Pose &localPose,
    geometry_msgs::Pose &outputWorldPose) const
{
    if (!this->IsValidFramePair(mBaseLinkId, MapId()))
    {
        outputWorldPose = localPose;
        return;
    }

    geometry_msgs::PoseStamped localPoseStamped;
    localPoseStamped.header.frame_id = mBaseLinkId;
    localPoseStamped.header.stamp = stamp - ros::Duration(0.001);
    localPoseStamped.pose = localPose;
    geometry_msgs::PoseStamped worldPoseStamped;
    worldPoseStamped.header.frame_id = MapId();
    worldPoseStamped.header.stamp = stamp - ros::Duration(0.001);

    try
    {
        mTransformListener.transformPose(
            MapId(),
            localPoseStamped,
            worldPoseStamped);
    }
    catch (const tf2::InvalidArgumentException &ex)
    {
        ROS_WARN_STREAM(ex.what());
        //ROS_WARN_STREAM(localPose);
    }
    catch (const tf2::ExtrapolationException &ex)
    {
        ROS_WARN_STREAM(ex.what());
    }
    outputWorldPose = worldPoseStamped.pose;
}

void DetectedObjectCoordConverter::ToLocalCoord(
    const ros::Time &stamp,
    const geometry_msgs::Pose &worldPose,
    geometry_msgs::Pose &outputLocalPose) const
{
    if (!this->IsValidFramePair(mBaseLinkId, MapId()))
    {
        outputLocalPose = worldPose;
        return;
    }

    geometry_msgs::PoseStamped worldPoseStamped;
    worldPoseStamped.header.frame_id = MapId();
    worldPoseStamped.header.stamp = stamp;
    worldPoseStamped.pose = worldPose;
    geometry_msgs::PoseStamped localPoseStamped;
    localPoseStamped.header.frame_id = mBaseLinkId;
    localPoseStamped.header.stamp = stamp;

    try
    {
        mTransformListener.transformPose(
            mBaseLinkId,
            worldPoseStamped,
            localPoseStamped);
    }
    catch (const tf2::InvalidArgumentException &ex)
    {
        ROS_WARN_STREAM(ex.what());
    }
    catch (const tf2::ExtrapolationException &ex)
    {
        ROS_WARN_STREAM(ex.what());
    }
    catch (const tf2::LookupException &ex)
    {
        ROS_WARN_STREAM(ex.what());
    }

    outputLocalPose = localPoseStamped.pose;
    //ROS_INFO_STREAM("given stamp: " << stamp << '\n' <<
    //    "localPoseStamped" << '\n' <<
    //    localPoseStamped);
}

void DetectedObjectCoordConverter::ToLocalCoord(
    const ros::Time &stamp,
    const geometry_msgs::Vector3 &worldVector,
    geometry_msgs::Vector3 &outputLocalVector) const
{
    if (!this->IsValidFramePair(mBaseLinkId, MapId()))
    {
        outputLocalVector = worldVector;
        return;
    }

    geometry_msgs::Vector3Stamped worldVectorStamped;
    worldVectorStamped.header.frame_id = MapId();
    worldVectorStamped.header.stamp = stamp;
    worldVectorStamped.vector = worldVector;

    geometry_msgs::Vector3Stamped localVectorStamped;
    localVectorStamped.header.frame_id = mBaseLinkId;
    localVectorStamped.header.stamp = stamp;

    try
    {
        mTransformListener.transformVector(
            mBaseLinkId,
            worldVectorStamped,
            localVectorStamped);
    }
    catch (const tf2::InvalidArgumentException &ex)
    {
        ROS_WARN_STREAM(ex.what());
    }
    catch (const tf2::ExtrapolationException &ex)
    {
        ROS_WARN_STREAM(ex.what());
    }
    catch (const tf2::LookupException &ex)
    {
        ROS_WARN_STREAM(ex.what());
    }

    outputLocalVector = localVectorStamped.vector;
}

void DetectedObjectCoordConverter::ToLocalCoord(
    const ros::Time &stamp,
    const geometry_msgs::Point &worldPoint,
    geometry_msgs::Point &outputLocalPoint) const
{
    if (!this->IsValidFramePair(mBaseLinkId, MapId()))
    {
        outputLocalPoint = worldPoint;
        return;
    }

    geometry_msgs::PointStamped worldPointStamped;
    worldPointStamped.header.frame_id = MapId();
    worldPointStamped.header.stamp = stamp;
    worldPointStamped.point = worldPoint;

    geometry_msgs::PointStamped localPointStamped;
    localPointStamped.header.frame_id = mBaseLinkId;
    localPointStamped.header.stamp = stamp;

    try
    {
        mTransformListener.transformPoint(
            mBaseLinkId,
            worldPointStamped,
            localPointStamped);
    }
    catch (const tf2::InvalidArgumentException &ex)
    {
        ROS_WARN_STREAM(ex.what());
    }
    catch (const tf2::ExtrapolationException &ex)
    {
        ROS_WARN_STREAM(ex.what());
    }
    catch (const tf2::LookupException &ex)
    {
        ROS_WARN_STREAM(ex.what());
    }

    outputLocalPoint = localPointStamped.point;
}

void DetectedObjectCoordConverter::ToLocalCoord(
    const ros::Time &stamp,
    const geometry_msgs::Point32 &worldPoint32,
    geometry_msgs::Point32 &outputLocalPoint32) const
{
    geometry_msgs::Point outputPoint;
    this->ToLocalCoord(
        stamp,
        utils::ConvertToGeometryMsgsPoint(worldPoint32),
        outputPoint);

    outputLocalPoint32 = utils::ConvertToGeometryMsgsPoint32(outputPoint);
}

// protected func.

// private func.

bool DetectedObjectCoordConverter::IsValidFramePair(
    const std::string &localFrameId,
    const std::string &worldFrameId) const
{
    if (!mTransformListener.frameExists(localFrameId))
    {
        //ROS_WARN_STREAM("frame " << localFrameId << " does not exist");
        return false;
    }

    if (!mTransformListener.frameExists(worldFrameId))
    {
        //ROS_WARN_STREAM("frame " << worldFrameId << " does not exist");
        return false;
    }

    return true;
}

} // namespace utils {
