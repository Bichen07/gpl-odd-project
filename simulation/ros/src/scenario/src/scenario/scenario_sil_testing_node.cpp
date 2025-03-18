#include <scenario_sil_testing_node.h>
#include <ros/console.h>
#include <path/Republishing.h>
#include <utils_ros_param.h>

namespace scenario {

// public func.

SilTestingNode::SilTestingNode()
    : mNodeHandle{}
    , mPathRepublishingService{}
    , mNodeFrequency{DefaultNodeFrequency()}
    , mDesiredDetectedObjectFrequencyEvaluator{}
    , mDesiredVisualizationFrequencyEvaluator{}
    , mDetectedObjectCoord{}
    , mSimulatorManager{}
    , mCanEnablePathRepublishing{false}

    , mLoopCount{0}
{
    mPathRepublishingService = mNodeHandle.serviceClient<path::Republishing>(
        "path/republishing");
    mCanEnablePathRepublishing = utils::GetRosParam<bool>(
        "sil_testing/can_enable_path_republishing");
    ROS_DEBUG_STREAM_COND(
        true,
        "mCanEnablePathRepublishing: " << mCanEnablePathRepublishing);
}

void SilTestingNode::Configure(
    const math::real_t nodeFrequency,
    const math::real_t desiredDetectedObjectFrequency,
    const math::real_t desiredVisualizationFrequency,
    const DetectedObjectCoord &detectedObjectCoord,
    const int32_t detectedObjectIdOffset)
{
    if (nodeFrequency < math::real_t{10.0})
    {
        ROS_ERROR_STREAM("invalid nodeFrequency: " << nodeFrequency);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    mNodeFrequency = nodeFrequency;
    mDesiredDetectedObjectFrequencyEvaluator.Configure(
        desiredDetectedObjectFrequency);
    mDesiredVisualizationFrequencyEvaluator.Configure(
        desiredVisualizationFrequency);
    mDetectedObjectCoord = detectedObjectCoord;
    mSimulatorManager.Configure( nodeFrequency,
        detectedObjectIdOffset);
}

void SilTestingNode::RunMainLoop()
{
    ros::Rate nodeRate(mNodeFrequency);
    while (ros::ok())
    {
        mSimulatorManager.Update();
        this->Publish();
        ros::spinOnce();
        nodeRate.sleep();

        if (mCanEnablePathRepublishing)
        {
            ++mLoopCount;

            if (mLoopCount % 100 == 0)
            {
                ROS_DEBUG_STREAM_COND(
                    false,
                    "loop count: " << mLoopCount);
            }

            if (mLoopCount == 3200)
            {
                ROS_WARN_STREAM("----------------Reset-------------------------");
                mSimulatorManager.Reset();
                mLoopCount = 0;

                const double nodeFrequency{
                    utils::GetRosParam<double>(
                        "sil_testing/node_frequency")};
                const int32_t detectedObjectIdOffset{
                    utils::GetRosParam<int32_t>(
                        "sil_testing/detected_object_id_offset")};
                mSimulatorManager.Configure(
                    nodeFrequency,
                    detectedObjectIdOffset);

                path::Republishing pathRepublishing;
                pathRepublishing.request.can_republish_ego_vehicle_global_path = false;
                if (!mPathRepublishingService.call(pathRepublishing))
                {
                    ROS_ERROR_STREAM(
                        "fail to call path/republishing service" << '\n' <<
                        "request" << '\n' <<
                        pathRepublishing.request << '\n' <<
                        "response" << '\n' <<
                        pathRepublishing.response);
                    throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
                }
            }
        }
    }
}

// protected func.

// private func.

void SilTestingNode::Publish()
{
    if (mDesiredDetectedObjectFrequencyEvaluator.CanTriggerEvent())
    {
        mSimulatorManager.PublishDetectedObjects(mDetectedObjectCoord);
    }

    if (mDesiredVisualizationFrequencyEvaluator.CanTriggerEvent())
    {
        mSimulatorManager.PublishVisualization();
    }
}

} // namespace scenario {
