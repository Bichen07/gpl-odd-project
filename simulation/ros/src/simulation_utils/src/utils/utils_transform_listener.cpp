#include "utils_transform_listener.h"
#include <ros/console.h>

namespace utils {

// public func.

TransformListener::TransformListener()
    : mTransformListener{}
    , mInitTransformMap{}
{
}

void TransformListener::Configure(const TransformMap &initTransformMap)
{
    mInitTransformMap = initTransformMap;
}

void TransformListener::AppendInitTransform(
    const SourceTargetFramePair &sourceTargetFramePair,
    const tf::Transform &initTransform)
{
    mInitTransformMap.emplace(
        sourceTargetFramePair,
        initTransform);
}

void TransformListener::Run(
    const std::string &targetFrame,
    const std::string &sourceFrame,
    const ros::Time &stamp,
    tf::StampedTransform *transform)
{
    if (!this->IsValidFramePair(std::make_pair(sourceFrame, targetFrame)))
    {
        const auto foundInitTransformPair{
            mInitTransformMap.find(std::make_pair(sourceFrame, targetFrame))};
        if (mInitTransformMap.end() != foundInitTransformPair)
        {
            *transform = tf::StampedTransform(
                foundInitTransformPair->second,
                stamp,
                targetFrame,
                sourceFrame);

            static const bool canShowInvalidTransformInfo{false};
            if (canShowInvalidTransformInfo)
            {
                ROS_WARN_STREAM(
                    '\n' <<
                    "targetFrame: " << targetFrame << '\n' <<
                    "sourceFrame: " << sourceFrame << '\n' <<
                    "input stamp: " << stamp << '\n' <<
                    "output stamp: " << transform->stamp_ << '\n' <<
                    "output frame id: " << transform->frame_id_ << '\n' <<
                    "output child frame id: " << transform->child_frame_id_);
            }

            return;
        }
    }
 
    try
    {
        mTransformListener.waitForTransform(
            targetFrame,
            sourceFrame,
            stamp,
            ros::Duration(1.0));
        mTransformListener.lookupTransform(
            targetFrame,
            sourceFrame,
            stamp,
            *transform);

        static const bool canShowTransformInfo{false};
        if (canShowTransformInfo)
        {
            ROS_WARN_STREAM(
                '\n' <<
                "targetFrame: " << targetFrame << '\n' <<
                "sourceFrame: " << sourceFrame << '\n' <<
                "input stamp:  " << stamp << '\n' <<
                "output stamp: " << transform->stamp_ << '\n' <<
                "output frame id: " << transform->frame_id_ << '\n' <<
                "output child frame id: " << transform->child_frame_id_);
        }
    }
    catch (const tf::TransformException &ex)
    {
        ROS_WARN("%s", ex.what());
        ROS_WARN_STREAM(
            "fail to look up transform, target frame: " << targetFrame <<
            ", source frame: " << sourceFrame);
    }
}

// protected func.

// private func.

bool TransformListener::IsValidFramePair(const SourceTargetFramePair &sourceTargetFramePair) const
{
    const bool sourceFrameExists{
        mTransformListener.frameExists(sourceTargetFramePair.first)};
    if (!sourceFrameExists)
    {
        return false;
    }

    const bool targetFrameExists{
        mTransformListener.frameExists(sourceTargetFramePair.second)};
    if (!targetFrameExists)
    {
        return false;
    }

    return true;
}

} // namespace utils {
