#include <visualization_detected_object_processor.h>
#include <utils_converter.h>
#include <utils_default_color.h>
#include <utils_geometry_msgs.h>
#include <visualization_agent_marker_config.h>
#include <visualization_velocity_marker_config.h>
#include <visualization_utils.h>

namespace visualization {

// public func.

DetectedObjectProcessor::DetectedObjectProcessor()
    : Processor()
    , mAgentDataArray{}
    , mAgentNsMap{}
    , mDetectedObjectCoordConverter{}
    , mDetectedObjectPoseMap{}
    , mCanShowDetectedObjectId{false}
{
    mAgentNsMap = std::map<std::string, std::string>
    {
        {"car",       "vehicle"},
        {"truck",     "vehicle"},
        {"bus",       "vehicle"},
        {"bicycle",   "vehicle"},
        {"motorbike", "vehicle"},
        {"person",    "pedestrian"},
        {"unknown",   "obstacle"},
    };

    const std::string commonPrefix{"rss/visualization/"};
    ros::param::get(
        commonPrefix + std::string("canShowDetectedObjectId"),
        mCanShowDetectedObjectId);
}

const scenario_msgs::AgentDataArray &DetectedObjectProcessor::GetAgentDataArray() const
{
    return mAgentDataArray;
}

const DetectedObjectProcessor::DetectedObjectPoseMap
    &DetectedObjectProcessor::GetDetectedObjectPoseMap() const
{
    return mDetectedObjectPoseMap;
}

void DetectedObjectProcessor::Update(
    const ros::Time &stamp,
    const scenario_msgs::AgentDataArray &agentDataArray,
    visualization_msgs::MarkerArray &outputVisualizationMsg)
{
    mAgentDataArray = agentDataArray;
    for (auto agentData{mAgentDataArray.data.cbegin()};
         agentData != mAgentDataArray.data.cend();
         ++agentData)
    {
        const auto markerId{Processor::QueryMarkerId(agentData->agent_id)};
        auto foundMarkerMsg{
            std::find_if(
                outputVisualizationMsg.markers.begin(),
                outputVisualizationMsg.markers.end(),
                [&markerId](const visualization_msgs::Marker &markerMsg)
                {return markerMsg.id == markerId;})};

        if (outputVisualizationMsg.markers.end() == foundMarkerMsg)
        {
            const auto agentDataConfig = AgentDataConfig
            {
                .markerMsg = *agentData,
                .markerId = markerId,
                .stamp = stamp,
                .ns = this->QueryAgentNs(agentData->objectClassId),
                .lifeTime = mDefaultLifetime,
            };

            visualization_msgs::Marker outputMarkerMsg;
            visualization::GenerateAgentData(
                agentDataConfig,
                outputMarkerMsg);
            outputVisualizationMsg.markers.push_back(outputMarkerMsg);
            Processor::AddVisMarkerUpdateStatus(markerId);
        }
        else
        {
            visualization::UpdateAgentData(
                stamp,
                *agentData,
                *foundMarkerMsg);
            Processor::RecordVisMarkerUpdate(markerId);
        }

        this->UpdateVelocityMarker(
            stamp,
            *agentData,
            outputVisualizationMsg);
    }

    this->UpdateDetectedObjectIdMarker(
        stamp,
        mAgentDataArray,
        mDetectedObjectPoseMap,
        outputVisualizationMsg);

    Processor::RemoveOutdatedVisMarkers(outputVisualizationMsg);
}

void DetectedObjectProcessor::UpdateDetectedObjectArray(
    const itri_msgs::DetectedObjectArray &msg)
{
    mDetectedObjectPoseMap.clear();
    for (auto object{msg.objects.cbegin()};
         object != msg.objects.cend();
         ++object)
    {
        geometry_msgs::Pose worldPose;
        mDetectedObjectCoordConverter.ToWorldCoord(
            msg.header.stamp,
            object->pose,
            worldPose);
        if (!mDetectedObjectPoseMap.emplace(object->id, worldPose).second)
        {
            ROS_WARN_STREAM("invalid detected object id: " << object->id);
        }
    }
}

// protected func.

// private func.

const std::string &DetectedObjectProcessor::QueryAgentNs(const std::string &objectClassId)
{
    const auto found{mAgentNsMap.find(objectClassId)};
    if (mAgentNsMap.end() == found)
    {
        ROS_ERROR_STREAM("invalid objectClassId: " << objectClassId);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return found->second;
}

void DetectedObjectProcessor::UpdateVelocityMarker(
    const ros::Time &stamp,
    const scenario_msgs::AgentData &agentDataMsg,
    visualization_msgs::MarkerArray &outputVisualizationMsg)
{
    const std::string velocityMarkerId{
        agentDataMsg.agent_id + "_velocity"};
    const auto markerId{Processor::QueryMarkerId(velocityMarkerId)};
    auto foundMarker{
        std::find_if(
            outputVisualizationMsg.markers.begin(),
            outputVisualizationMsg.markers.end(),
            [&markerId](const visualization_msgs::Marker &visualizationMarker)
            {return visualizationMarker.id == markerId;})};

    if (outputVisualizationMsg.markers.end() == foundMarker)
    {
        geometry_msgs::Pose velocityMarkerPose;
        visualization::ComputeVelocityMarkerPose(
            agentDataMsg.linear_velocity,
            agentDataMsg.pose.position,
            velocityMarkerPose);
        const auto velocityMarkerConfig = VelocityMarkerConfig
        {
            .velocity = agentDataMsg.linear_velocity,
            .size = utils::ConvertToGeometryMsgsVector3(
                utils::ComputeNorm(agentDataMsg.linear_velocity),
                0.3,
                0.3),
            .pose = velocityMarkerPose,
            .color = agentDataMsg.color,
            .markerId = markerId,
            .stamp = stamp,
            .ns = "agent_velocity",
            .lifeTime = mDefaultLifetime,
        };
        visualization_msgs::Marker velocityMarker;
        visualization::GenerateVelocityMarker(
            velocityMarkerConfig,
            velocityMarker);
        outputVisualizationMsg.markers.push_back(
            velocityMarker);
        Processor::AddVisMarkerUpdateStatus(markerId);
    }
    else
    {
        visualization::UpdateVelocityMarker(
            stamp,
            agentDataMsg.linear_velocity,
            agentDataMsg.pose.position,
            *foundMarker);
        Processor::RecordVisMarkerUpdate(markerId);
    }
}

void DetectedObjectProcessor::UpdateDetectedObjectIdMarker(
    const ros::Time &stamp,
    const scenario_msgs::AgentDataArray &agentDataArrayMsg,
    const DetectedObjectPoseMap &detectedObjectPoseMap,
    visualization_msgs::MarkerArray &outputVisualizationMsg)
{
    if (!mCanShowDetectedObjectId)
    {
        return;
    }

    if (detectedObjectPoseMap.empty())
    {
        return;
    }

    for (auto detectedObjectPosePair{mDetectedObjectPoseMap.cbegin()};
         detectedObjectPosePair != mDetectedObjectPoseMap.cend();
         ++detectedObjectPosePair)
    {
        const std::string markerQueryId{
            std::to_string(detectedObjectPosePair->first) +
            std::string("_detected_object_id")};
        const auto markerId{Processor::QueryMarkerId(markerQueryId)};
        auto foundMarker{
            std::find_if(
                outputVisualizationMsg.markers.begin(),
                outputVisualizationMsg.markers.end(),
                [&markerId](const visualization_msgs::Marker &visualizationMarker)
                {return visualizationMarker.id == markerId;})};
        const auto foundAgentDataMsg{
            std::find_if(
                agentDataArrayMsg.data.cbegin(),
                agentDataArrayMsg.data.cend(),
                [&detectedObjectPosePair](const scenario_msgs::AgentData &msg)
                {return msg.detected_object_id == detectedObjectPosePair->first;})};
        const auto markerRefPose =
            agentDataArrayMsg.data.cend() == foundAgentDataMsg ?
            detectedObjectPosePair->second :
            foundAgentDataMsg->pose;
        static const auto positionOffset{
            utils::ConvertToGeometryMsgsVector3(
                double{2.25},
                double{2.25},
                double{2.5})};
        const auto markerPose{
            utils::ComputeOffsetPose(
                markerRefPose,
                positionOffset)};
        const auto color =
            agentDataArrayMsg.data.cend() == foundAgentDataMsg ?
            utils::White() :
            foundAgentDataMsg->color;
        if (outputVisualizationMsg.markers.end() == foundMarker)
        {
            const auto markerConfig = DetectedObjectIdMarkerConfig
            {
                .detectedObjectId = std::to_string(detectedObjectPosePair->first),
                .markerId = markerId,
                .stamp = stamp,
                .ns = "detected_object_id",
                .pose = markerPose,
                .scale = utils::ConvertToGeometryMsgsVector3(3.0, 3.0, 3.0),
                .color = color,
                .lifetime = mDefaultLifetime,
            };
            visualization_msgs::Marker markerMsg;
            visualization::GenerateDetectedObjectIdMarker(
                markerConfig,
                markerMsg);
            outputVisualizationMsg.markers.push_back(markerMsg);
            Processor::AddVisMarkerUpdateStatus(markerId);
        }
        else
        {
            visualization::UpdateDetectedObjectIdMarker(
                stamp,
                markerPose,
                *foundMarker);
            Processor::RecordVisMarkerUpdate(markerId);
        }
    }
}

} // namespace visualization {
