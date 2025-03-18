#include <visualization_rss_processor.h>
#include <ros/console.h>
#include <scenario_msgs/PointMarker.h>
#include <utils_converter.h>
#include <utils_default_color.h>
#include <utils_geometry_msgs.h>
#include <utils_ros_param.h>
#include <geometry_transform_3d.h>
#include <visualization_line_strip_marker_config.h>
#include <visualization_point_marker_config.h>
#include <visualization_utils.h>

namespace visualization {

// public func.

RssProcessor::RssProcessor()
    : Processor()
    , mCheckResultMsg{nullptr}
    , mCanShowEgoVehicleBrakeTrajectorySet{false}
    , mCanShowEgoVehicleContinueForwardTrajectorySet{false}
    , mCanShowObjectBrakeTrajectorySet{false}
    , mCanShowObjectContinueForwardTrajectorySet{false}
    , mCanShowSituationType{false}
    , mCanShowLandmark{false}
{
    const std::string commonPrefix{"rss/visualization/"};
    ros::param::get(
        commonPrefix + std::string("canShowEgoVehicleBrakeTrajectorySet"),
        mCanShowEgoVehicleBrakeTrajectorySet);
    ros::param::get(
        commonPrefix + std::string("canShowEgoVehicleContinueForwardTrajectorySet"),
        mCanShowEgoVehicleContinueForwardTrajectorySet);
    ros::param::get(
        commonPrefix + std::string("canShowObjectBrakeTrajectorySet"),
        mCanShowObjectBrakeTrajectorySet);
    ros::param::get(
        commonPrefix + std::string("canShowObjectContinueForwardTrajectorySet"),
        mCanShowObjectContinueForwardTrajectorySet);
    ros::param::get(
        commonPrefix + std::string("canShowSituationType"),
        mCanShowSituationType);
    ros::param::get(
        commonPrefix + std::string("canShowLandmark"),
        mCanShowLandmark);
}

void RssProcessor::UpdateEgoVehicleUnstructuredData(
    const ros::Time &stamp,
    visualization_msgs::MarkerArray &outputVisualizationMsg)
{
    this->UpdateEgoVehicleUnstructuredTrajectorySet(
            stamp,
            mCheckResultMsg->ego_vehicle_state,
            outputVisualizationMsg);
}

void RssProcessor::UpdateAgentSafetyIndicator(
    const ros::Time &stamp,
    const scenario_msgs::AgentDataArray &agentDataArray,
    visualization_msgs::MarkerArray &outputVisualizationMsg)
{
    if (agentDataArray.data.empty())
    {
        return;
    }

    if (!this->IsValidCheckResult())
    {
        return;
    }

    for (auto agentData{agentDataArray.data.cbegin()};
         agentData != agentDataArray.data.cend();
         ++agentData)
    {
        const auto foundCheckResultObjectState{
            this->QueryCheckResultObjectState(
                *mCheckResultMsg,
                agentData->detected_object_id)};
        if (mCheckResultMsg->object_states.cend() == foundCheckResultObjectState)
        {
            continue;
        }

        const std::string markerIdQueryKey{
            agentData->agent_id + "_rss_safety_indicator"};
        const auto markerId{Processor::QueryMarkerId(markerIdQueryKey)};
        auto foundVisMsg{
            Processor::QueryVisualizationMarker(
                outputVisualizationMsg,
                markerId)};
        static const geometry::Vector3d positionOffset(
            double{0.0}, double{0.0}, double{1.5});
        const geometry::Transform3d markerPose(
                geometry::Quaternion(agentData->pose.orientation),
                geometry::Vector3d(agentData->pose.position) + positionOffset);
        if (outputVisualizationMsg.markers.end() == foundVisMsg)
        {
            const auto markerConfig = RssCheckResultObjectMarkerConfig
            {
                .markerId = markerId,
                .stamp = stamp,
                .ns = "rss_safety_indicator",
                .lifetime = mDefaultLifetime,
                .pose = markerPose.ToPose(),
                .size = utils::ConvertToGeometryMsgsVector3(0.75, 0.75, 0.75),
                .color = this->EvaluateSafetyIndicatorColor(
                    *foundCheckResultObjectState), 
            };

            visualization_msgs::Marker checkResultObjectMarker;
            visualization::GenerateRssCheckResultMarker(
                markerConfig,
                checkResultObjectMarker);
            outputVisualizationMsg.markers.push_back(checkResultObjectMarker);
            Processor::AddVisMarkerUpdateStatus(markerId);
        }
        else
        {
            visualization::UpdateRssCheckResultMarker(
                stamp,
                markerPose.ToPose(),
                this->EvaluateSafetyIndicatorColor(*foundCheckResultObjectState), 
                *foundVisMsg);
            Processor::RecordVisMarkerUpdate(markerId);
        }

        this->UpdateSituationType(
            stamp,
            *foundCheckResultObjectState,
            markerPose.ToPose(),
            outputVisualizationMsg);
        this->UpdateObjectUnstructuredTrajectorySet(
            stamp,
            *foundCheckResultObjectState,
            outputVisualizationMsg);
    }

    Processor::RemoveOutdatedVisMarkers(outputVisualizationMsg);
}

void RssProcessor::UpdateDetectedObjectSafetyIndicator(
    const ros::Time &stamp,
    const std::map<uint32_t, geometry_msgs::Pose> &detectedObjectPoseMap,
    const scenario_msgs::AgentDataArray &agentDataArray,
    visualization_msgs::MarkerArray &outputVisualizationMsg)
{
    if (detectedObjectPoseMap.empty())
    {
        return;
    }

    if (!this->IsValidCheckResult())
    {
        return;
    }

    for (auto detectedObjectPosePair{detectedObjectPoseMap.cbegin()};
         detectedObjectPosePair != detectedObjectPoseMap.cend();
         ++detectedObjectPosePair)
    {
        const auto foundCheckResultObjectState{
            this->QueryCheckResultObjectState(
                *mCheckResultMsg,
                detectedObjectPosePair->first)};
        if (mCheckResultMsg->object_states.cend() == foundCheckResultObjectState)
        {
            continue;
        }

        const auto foundAgentData{
            this->QueryAgentData(
                agentDataArray,
                detectedObjectPosePair->first)};
        if (agentDataArray.data.cend() != foundAgentData)
        {
            continue;
        }

        const std::string markerIdQueryKey{
            std::to_string(detectedObjectPosePair->first) + "_rss_safety_indicator"};
        const auto markerId{Processor::QueryMarkerId(markerIdQueryKey)};
        auto foundVisMsg{
            Processor::QueryVisualizationMarker(
                outputVisualizationMsg,
                markerId)};

        static const geometry::Vector3d positionOffset(
            double{0.0}, double{0.0}, double{1.5});
        const auto markerPose{
            geometry::Transform3d(
                geometry::Quaternion(detectedObjectPosePair->second.orientation),
                geometry::Vector3d(detectedObjectPosePair->second.position) + positionOffset)};
        if (outputVisualizationMsg.markers.end() == foundVisMsg)
        {
            const auto checkResultObjectMarkerConfig = RssCheckResultObjectMarkerConfig
            {
                .markerId = markerId,
                .stamp = stamp,
                .ns = "rss_safety_indicator",
                .lifeTime = mDefaultLifetime,
                .pose = markerPose.ToPose(),
                .size = geometry::Vector3d(0.75, 0.75, 0.75).ToVector3(),
                .color = this->EvaluateSafetyIndicatorColor(
                    *foundCheckResultObjectState), 
            };

            visualization_msgs::Marker checkResultObjectMarker;
            visualization::GenerateRssCheckResultMarker(
                checkResultObjectMarkerConfig,
                checkResultObjectMarker);
            outputVisualizationMsg.markers.push_back(checkResultObjectMarker);
            Processor::AddVisMarkerUpdateStatus(markerId);
        }
        else
        {
            visualization::UpdateRssCheckResultMarker(
                stamp,
                markerPose.ToPose(),
                this->EvaluateSafetyIndicatorColor(*foundCheckResultObjectState),
                *foundVisMsg);
            Processor::RecordVisMarkerUpdate(markerId);
        }

        this->UpdateSituationType(
            stamp,
            *foundCheckResultObjectState,
            markerPose.ToPose(),
            outputVisualizationMsg);
        this->UpdateObjectUnstructuredTrajectorySet(
            stamp,
            *foundCheckResultObjectState,
            outputVisualizationMsg);
    }

    Processor::RemoveOutdatedVisMarkers(outputVisualizationMsg);
}

void RssProcessor::UpdateCheckResult(const rss_msgs::CheckResult::ConstPtr &msg)
{
    mCheckResultMsg = msg;
}

void RssProcessor::UpdateLandmarks(
    const rss_msgs::LandmarkArray::ConstPtr &msg,
    visualization_msgs::MarkerArray &outputVisualizationMsg)
{
    if (!mCanShowLandmark)
    {
        return;
    }

    const ros::Time stamp{ros::Time::now()};
    for (auto landmark{msg->landmarks.cbegin()};
         landmark != msg->landmarks.cend();
         ++landmark)
    {
        // draw position
        const auto posMarkerId{
            Processor::QueryMarkerId("landmark_pos_" + landmark->id)};
        auto foundPosVisMsg{
            std::find_if(
                outputVisualizationMsg.markers.begin(),
                outputVisualizationMsg.markers.end(),
                [&posMarkerId](const visualization_msgs::Marker &visMarker)
                {return visMarker.id == posMarkerId;})};
        if (outputVisualizationMsg.markers.end() == foundPosVisMsg)
        {
            const auto config = PointMarkerConfig
            {
                .type = scenario_msgs::PointMarker::CUBE,
                .markerId = posMarkerId,
                .stamp = stamp,
                .ns= std::string("landmark_position"),
                .lifetime = ros::Duration(),
                .pose = geometry::Transform3d(
                    geometry::Vector3d(landmark->position)).ToPose(),
                .size = geometry::Vector3d(0.5, 0.5, 0.5).ToVector3(),
                .color = utils::Red(),
            };

            visualization_msgs::Marker posMarker;
            visualization::GeneratePointMarker(
                config,
                posMarker);
            outputVisualizationMsg.markers.push_back(posMarker);
        }
        else
        {
            visualization::UpdatePointMarker(
                stamp,
                geometry::Transform3d(geometry::Vector3d(landmark->position)).ToPose(),
                geometry::Vector3d(0.5, 0.5, 0.5).ToVector3(),
                ros::Duration(),
                utils::Red(),
                *foundPosVisMsg);
        }

        // draw id
        const auto idMarkerId{
            Processor::QueryMarkerId("landmark_id_" + landmark->id)};
        auto foundIdVisMsg{
            std::find_if(
                outputVisualizationMsg.markers.begin(),
                outputVisualizationMsg.markers.end(),
                [&idMarkerId](const visualization_msgs::Marker &visMarker)
                {return visMarker.id == idMarkerId;})};
        if (outputVisualizationMsg.markers.end() == foundIdVisMsg)
        {
        }
        else
        {
        }
        // draw orientation
    }
}

// protected func.

// private func.

void RssProcessor::UpdateSituationType(
    const ros::Time &stamp,
    const rss_msgs::CheckResultObjectState &checkResultObjectState,
    const geometry_msgs::Pose &refMarkerPose,
    visualization_msgs::MarkerArray &outputVisualizationMsg)
{
    if (!mCanShowSituationType)
    {
        return;
    }

    static const auto positionOffset{
        utils::ConvertToGeometryMsgsVector3(
            double{2.25}, double{-2.25}, double{2.5})};
    const auto markerPose{
        utils::ComputeOffsetPose(
            refMarkerPose,
            positionOffset)};
    const std::string markerIdQueryKey{
        std::to_string(checkResultObjectState.detected_object_id) +
        std::string("_rss_situation_type")};
    const auto markerId{
        Processor::QueryMarkerId(markerIdQueryKey)};
    auto foundVisMsg{
        std::find_if(
            outputVisualizationMsg.markers.begin(),
            outputVisualizationMsg.markers.end(),
            [&markerId](const visualization_msgs::Marker &visualizationMarker)
            {return visualizationMarker.id == markerId;})};
    if (outputVisualizationMsg.markers.end() == foundVisMsg)
    {
        const auto rssSituationTypeMarkerConfig = RssSituationTypeMarkerConfig
        {
            .situationType = visualization::QueryRssSituationTypeMarkerText(
                checkResultObjectState.situation_type),
            .markerId = markerId,
            .stamp = stamp,
            .ns = "rss_situation_type",
            .lifetime = mDefaultLifetime,
            .pose = markerPose,
            .size = utils::ConvertToGeometryMsgsVector3(3.0, 3.0, 3.0),
            .color = utils::Yellow()
        };

        visualization_msgs::Marker rssSituationTypeMarker;
        visualization::GenerateRssSituationTypeMarker(
            rssSituationTypeMarkerConfig,
            rssSituationTypeMarker);
        outputVisualizationMsg.markers.push_back(
            rssSituationTypeMarker);
        Processor::AddVisMarkerUpdateStatus(markerId);
    }
    else
    {
        visualization::UpdateRssSituationTypeMarker(
            visualization::QueryRssSituationTypeMarkerText(
                checkResultObjectState.situation_type),
            stamp,
            markerPose,
            *foundVisMsg);
        Processor::RecordVisMarkerUpdate(markerId);
    }
}

void RssProcessor::UpdateEgoVehicleUnstructuredTrajectorySet(
    const ros::Time &stamp,
    const rss_msgs::CheckResultEgoVehicleState &checkResultEgoVehicleState,
    visualization_msgs::MarkerArray &outputVisMarkerArray)
{
    if (mCanShowEgoVehicleBrakeTrajectorySet)
    {
        this->UpdateBrakeTrajectorySet(
            stamp,
            "ego_vehicle",
            checkResultEgoVehicleState.brake_trajectory_set,
            outputVisMarkerArray);
    }

    if (mCanShowEgoVehicleContinueForwardTrajectorySet)
    {
        this->UpdateContinueForwardTrajectorySet(
            stamp,
            "ego_vehicle",
            checkResultEgoVehicleState.continue_forward_trajectory_set,
            outputVisMarkerArray);
    }
}

void RssProcessor::UpdateObjectUnstructuredTrajectorySet(
    const ros::Time &stamp,
    const rss_msgs::CheckResultObjectState &checkResultObjectState,
    visualization_msgs::MarkerArray &outputVisMarkerArray)
{
    if (mCanShowObjectBrakeTrajectorySet)
    {
        this->UpdateBrakeTrajectorySet(
            stamp,
            std::string("detected_object") + std::to_string(checkResultObjectState.detected_object_id),
            checkResultObjectState.unstructured_safety.brake_trajectory_set,
            outputVisMarkerArray);
    }

    if (mCanShowObjectContinueForwardTrajectorySet)
    {
        this->UpdateContinueForwardTrajectorySet(
            stamp,
            std::string("detected_object") + std::to_string(checkResultObjectState.detected_object_id),
            checkResultObjectState.unstructured_safety.continue_forward_trajectory_set,
            outputVisMarkerArray);
    }
}

void RssProcessor::UpdateBrakeTrajectorySet(
    const ros::Time &stamp,
    const std::string &id,
    const std::vector<geometry_msgs::Point> &brakeTrajectorySet,
    visualization_msgs::MarkerArray &outputVisMarkerArray)
{
    const std::string markerIdQueryKey{
        id + std::string("_brake_trajectory_set")};
    const auto markerId{
        Processor::QueryMarkerId(markerIdQueryKey)};
    auto foundVisMarker{
        std::find_if(
            outputVisMarkerArray.markers.begin(),
            outputVisMarkerArray.markers.end(),
            [&markerId](const visualization_msgs::Marker &visMarker)
            {return visMarker.id == markerId;})};
    if (outputVisMarkerArray.markers.end() == foundVisMarker)
    {
        scenario_msgs::LineStripMarker lineStripMarker;
        lineStripMarker.id = std::string(id + std::string("_brake_trajectory_set"));
        lineStripMarker.points = brakeTrajectorySet;
        lineStripMarker.scale = double{0.2};
        lineStripMarker.lifetime = mDefaultLifetime;
        lineStripMarker.color = utils::Red();
        const auto trajectoryMarkerConfig{
            LineStripMarkerConfig(
                lineStripMarker,
                markerId,
                stamp,
                std::string("rss_unstructured_visualization"))};

        visualization_msgs::Marker trajectoryMarker;
        visualization::GenerateLineStripMarker(
            trajectoryMarkerConfig,
            trajectoryMarker);
        outputVisMarkerArray.markers.push_back(trajectoryMarker);
        Processor::AddVisMarkerUpdateStatus(markerId);
    }
    else
    {
        scenario_msgs::LineStripMarker lineStripMarker;
        lineStripMarker.id = std::string(id + std::string("_brake_trajectory_set"));
        lineStripMarker.points = brakeTrajectorySet;
        lineStripMarker.scale = double{0.2};
        lineStripMarker.lifetime = mDefaultLifetime;
        lineStripMarker.color = utils::Red();
        const auto trajectoryMarkerConfig{
            LineStripMarkerConfig(
                lineStripMarker,
                markerId,
                stamp,
                std::string("rss_unstructured_visualization"))};
        visualization_msgs::Marker trajectoryMarker;
        visualization::GenerateLineStripMarker(
            trajectoryMarkerConfig,
            *foundVisMarker);
        Processor::RecordVisMarkerUpdate(markerId);
    }
}

void RssProcessor::UpdateContinueForwardTrajectorySet(
    const ros::Time &stamp,
    const std::string &id,
    const std::vector<geometry_msgs::Point> &continueForwardTrajectorySet,
    visualization_msgs::MarkerArray &outputVisMarkerArray)
{
    const std::string markerIdQueryKey{
        id + std::string("_continue_forward_trajectory_set")};
    const auto markerId{
        Processor::QueryMarkerId(markerIdQueryKey)};

    scenario_msgs::LineStripMarker trajectoryMarker;
    trajectoryMarker.id = std::string(id + "_continue_forward_trajectory_set");
    trajectoryMarker.points = continueForwardTrajectorySet;
    trajectoryMarker.scale = double{0.3};
    trajectoryMarker.lifetime = mDefaultLifetime;
    trajectoryMarker.color = utils::Green();
    const auto trajectoryMarkerConfig{
        LineStripMarkerConfig(
            trajectoryMarker,
            markerId,
            stamp,
            std::string("rss_unstructed_visualization"))};

    auto foundVisMarker{
        std::find_if(
            outputVisMarkerArray.markers.begin(),
            outputVisMarkerArray.markers.end(),
            [&markerId](const visualization_msgs::Marker &visMarker)
            {return visMarker.id == markerId;})};
    if (outputVisMarkerArray.markers.end() == foundVisMarker)
    {
        visualization_msgs::Marker newVisMarker;
        visualization::GenerateLineStripMarker(
            trajectoryMarkerConfig,
            newVisMarker);
        outputVisMarkerArray.markers.push_back(newVisMarker);
        Processor::AddVisMarkerUpdateStatus(markerId);
    }
    else
    {
        visualization::GenerateLineStripMarker(
            trajectoryMarkerConfig,
            *foundVisMarker);
        Processor::RecordVisMarkerUpdate(markerId);
    }
}

std::vector<rss_msgs::CheckResultObjectState>::const_iterator
    RssProcessor::QueryCheckResultObjectState(
        const rss_msgs::CheckResult &checkResultMsg,
        const uint32_t detectedObjectId) const
{
    std::vector<rss_msgs::CheckResultObjectState>::const_iterator foundObjectState =
        std::find_if(
            checkResultMsg.object_states.cbegin(),
            checkResultMsg.object_states.cend(),
            [&detectedObjectId](const rss_msgs::CheckResultObjectState &objectState)
            {return objectState.detected_object_id == detectedObjectId;});
    return foundObjectState;
}

std::vector<scenario_msgs::AgentData>::const_iterator
    RssProcessor::QueryAgentData(
        const scenario_msgs::AgentDataArray &agentDataArray,
        const uint32_t detectedObjectId) const
{
    std::vector<scenario_msgs::AgentData>::const_iterator foundAgentData =
        std::find_if(
            agentDataArray.data.cbegin(),
            agentDataArray.data.cend(),
            [&detectedObjectId](const scenario_msgs::AgentData &agentData)
            {return agentData.detected_object_id == detectedObjectId;});
    return foundAgentData;
}

const std_msgs::ColorRGBA &RssProcessor::EvaluateSafetyIndicatorColor(
    const rss_msgs::CheckResultObjectState &objectState) const
{
    if (rss_msgs::CheckResultObjectState::SITUATION_UNSTRUCTURED ==
        objectState.situation_type)
    {
        return this->EvaluateUnstructuredSafetyIndicatorColor(
            objectState.unstructured_safety);
    }

    return this->EvaluateStructuredSafetyIndicatorColor(
        objectState.structured_safety);
}

const std_msgs::ColorRGBA &RssProcessor::EvaluateStructuredSafetyIndicatorColor(
    const rss_msgs::StructuredSafety &structuredSafety) const
{
    static const std::map<int32_t, std_msgs::ColorRGBA> colorMap =
    {
        {rss_msgs::StructuredSafety::STATUS_SAFE,      utils::Green()},
        {rss_msgs::StructuredSafety::STATUS_WARNING,   utils::Yellow()},
        {rss_msgs::StructuredSafety::STATUS_DANGEROUS, utils::Red()},
        {rss_msgs::StructuredSafety::STATUS_NULL,      utils::Black()},
    };

    const auto foundColor{colorMap.find(structuredSafety.status)};
    if (colorMap.end() == foundColor)
    {
        ROS_ERROR_STREAM("invalid status: " << structuredSafety.status);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return foundColor->second;
}

const std_msgs::ColorRGBA &RssProcessor::EvaluateUnstructuredSafetyIndicatorColor(
    const rss_msgs::UnstructuredSafety &unstructuredSafety) const
{
    static const std::map<int32_t, std_msgs::ColorRGBA> colorMap =
    {
        {rss_msgs::StructuredSafety::STATUS_SAFE,      utils::Green()},
        {rss_msgs::StructuredSafety::STATUS_DANGEROUS, utils::Red()},
        {rss_msgs::StructuredSafety::STATUS_NULL,      utils::Black()},
    };

    const auto foundColor{colorMap.find(unstructuredSafety.status)};
    if (colorMap.end() == foundColor)
    {
        ROS_ERROR_STREAM(std::string(__FILE__":") + std::to_string(__LINE__));
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return foundColor->second;
}

bool RssProcessor::IsValidCheckResult() const
{
    if (!mCheckResultMsg)
    {
        return false;
    }

    if (mCheckResultMsg->object_states.empty())
    {
        ROS_WARN_STREAM("mCheckResultMsg->object_states is empty");
        return false;
    }

    return true;
}

} // namespace visualization {
