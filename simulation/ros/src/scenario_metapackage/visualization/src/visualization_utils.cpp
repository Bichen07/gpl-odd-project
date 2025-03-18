#include <visualization_utils.h>
#include <map>
#include <string>
#include <ros/console.h>
#include <rss_msgs/CheckResultObjectState.h>
#include <utils_converter.h>
#include <utils_geometry_msgs.h>
#include <utils_visualization_msgs.h>

namespace visualization {

void GenerateAgentData(
    const AgentDataConfig &config,
    visualization_msgs::Marker &outputMsg)
{
    outputMsg.header.frame_id = "map";
    outputMsg.header.stamp = config.stamp;
    outputMsg.ns = config.ns;
    outputMsg.action = visualization_msgs::Marker::ADD;
    outputMsg.id = config.dataId;
    outputMsg.type = visualization_msgs::Marker::CUBE;
    outputMsg.pose = config.dataMsg.pose;
    outputMsg.scale = config.dataMsg.size;
    outputMsg.lifetime = config.lifetime;
    outputMsg.color = config.dataMsg.color;
}

void UpdateAgentData(
    const ros::Time &stamp,
    const scenario_msgs::AgentData &agentDataMsg,
    visualization_msgs::Marker &updatedMsg)
{
    updatedMsg.header.stamp = stamp;
    updatedMsg.pose = agentDataMsg.pose;
}

void GenerateRssCheckResultMarker(
    const RssCheckResultObjectMarkerConfig &config,
    visualization_msgs::Marker &outputMsg)
{
    outputMsg.header.frame_id = "map";
    outputMsg.header.stamp = config.stamp;
    outputMsg.ns = config.ns;
    outputMsg.action = visualization_msgs::Marker::ADD;
    outputMsg.id = config.markerId;
    outputMsg.type = visualization_msgs::Marker::SPHERE;
    outputMsg.pose = config.pose;
    outputMsg.scale = config.size;
    outputMsg.lifetime = config.lifetime;
    outputMsg.color = config.color;
}

void UpdateRssCheckResultMarker(
    const ros::Time &stamp,
    const geometry_msgs::Pose &pose,
    const std_msgs::ColorRGBA &color,
    visualization_msgs::Marker &updatedMsg)
{
    updatedMsg.header.stamp = stamp;
    updatedMsg.pose = pose;
    updatedMsg.color = color;
}

void GenerateVelocityMarker(
    const VelocityMarkerConfig &config,
    visualization_msgs::Marker &outputMsg)
{
    outputMsg.header.frame_id = "map";
    outputMsg.header.stamp = config.stamp;
    outputMsg.ns = config.ns;
    outputMsg.action = visualization_msgs::Marker::ADD;
    outputMsg.id = config.markerId;
    outputMsg.type = visualization_msgs::Marker::ARROW;
    outputMsg.pose = config.pose;
    outputMsg.scale = config.size;
    outputMsg.lifetime = config.lifetime;
    outputMsg.color = config.color;
}

void UpdateVelocityMarker(
    const ros::Time &stamp,
    const geometry_msgs::Vector3 &velocity,
    const geometry_msgs::Point &beginPosition,
    visualization_msgs::Marker &updatedMsg)
{
    updatedMsg.header.stamp = stamp;
    updatedMsg.scale = utils::ConvertToGeometryMsgsVector3(
        utils::ComputeNorm(velocity),
        0.3,
        0.3);
    visualization::ComputeVelocityMarkerPose(
        velocity,
        beginPosition,
        updatedMsg.pose);
}

void ComputeVelocityMarkerPose(
    const geometry_msgs::Vector3 &velocity,
    const geometry_msgs::Point &beginPosition,
    geometry_msgs::Pose &outputPose)
{
    const geometry_msgs::Quaternion orientation{
        utils::ComputeOrientationXy(velocity)};
    outputPose.orientation = orientation;
    outputPose.position = beginPosition;
}

void GenerateLineStripMarker(
    const LineStripMarkerConfig &config,
    visualization_msgs::Marker &outputMsg)
{
    const auto scale{
        utils::ConvertToGeometryMsgsVector3(
            config.markerMsg.scale,
            config.markerMsg.scale,
            config.markerMsg.scale)};
    utils::GenerateVisualizationLineStripMsg(
        config.markerId,
        config.ns,
        config.stamp,
        config.markerMsg.points,
        scale,
        config.markerMsg.lifetime,
        config.markerMsg.color,
        outputMsg);
}

void UpdateLineStripMarker(
    const ros::Time &stamp,
    const scenario_msgs::LineStripMarker &markerMsg,
    visualization_msgs::Marker &updatedMsg)
{
    updatedMsg.header.stamp = stamp;
    updatedMsg.points = markerMsg.points;
    updatedMsg.scale = utils::ConvertToGeometryMsgsVector3(
        markerMsg.scale,
        markerMsg.scale,
        markerMsg.scale);
    updatedMsg.lifetime = markerMsg.lifetime;
    updatedMsg.color = markerMsg.color;
}

void GeneratePointMarker(
    const PointMarkerConfig &config,
    visualization_msgs::Marker &outputMsg)
{
    if (scenario_msgs::PointMarker::CUBE == config.type)
    {
        utils::GenerateVisualizationCubeMsg(
            config.markerId,
            config.ns,
            config.stamp,
            config.pose,
            config.size,
            config.lifetime,
            config.color,
            outputMsg);
    }
    else if (scenario_msgs::PointMarker::SPHERE == config.type)
    {
        utils::GenerateVisualizationSphereMsg(
            config.markerId,
            config.ns,
            config.stamp,
            config.pose,
            config.size,
            config.lifetime,
            config.color,
            outputMsg);
    }
    else
    {
        ROS_ERROR_STREAM(
            "invalid scenario_msgs::PointMarker::type: " << config.type);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }
}

void UpdatePointMarker(
    const ros::Time &stamp,
    const geometry_msgs::Pose &pose,
    const geometry_msgs::Vector3 &scale,
    const ros::Duration &lifetime,
    const std_msgs::ColorRGBA &color,
    visualization_msgs::Marker &updatedMsg)
{
    updatedMsg.header.stamp = stamp;
    updatedMsg.pose = pose;
    updatedMsg.scale = scale;
    updatedMsg.lifetime = lifetime;
    updatedMsg.color = color;
}

void GenerateTextMarker(
    const TextMarkerConfig &config,
    visualization_msgs::Marker &outputMsg)
{
    utils::GenerateVisualizationTextMsg(
        config.text,
        config.markerId,
        config.ns,
        config.stamp,
        config.pose,
        config.size,
        config.lifetime,
        config.color,
        outputMsg);
}

void UpdateTextMarker(
    const ros::Time &stamp,
    const std::string &text,
    const geometry_msgs::Pose &pose,
    const geometry_msgs::Vector3 &scale,
    const ros::Duration &lifetime,
    const std_msgs::ColorRGBA &color,
    visualization_msgs::Marker &updatedMsg)
{
    updatedMsg.header.stamp = stamp;
    updatedMsg.text = text;
    updatedMsg.pose = pose;
    updatedMsg.scale = scale;
    updatedMsg.lifetime = lifetime;
    updatedMsg.color = color;
}

void GenerateDetectedObjectIdMarker(
    const DetectedObjectIdMarkerConfig &config,
    visualization_msgs::Marker &outputMsg)
{
    utils::GenerateVisualizationTextMsg(
        config.detectedObjectId,
        config.markerId,
        config.ns,
        config.stamp,
        config.pose,
        config.scale,
        config.lifetime,
        config.color,
        outputMsg);
}

void UpdateDetectedObjectIdMarker(
    const ros::Time &stamp,
    const geometry_msgs::Pose &pose,
    visualization_msgs::Marker &outputMsg)
{
    outputMsg.header.stamp = stamp;
    outputMsg.pose = pose;
}

void GenerateRssSituationTypeMarker(
    const RssSituationTypeMarkerConfig &config,
    visualization_msgs::Marker &outputMsg)
{
    utils::GenerateVisualizationTextMsg(
        config.situationType,
        config.markerId,
        config.ns,
        config.stamp,
        config.pose,
        config.size,
        config.lifetime,
        config.color,
        outputMsg);
}

void UpdateRssSituationTypeMarker(
    const std::string &situationTypeText,
    const ros::Time &stamp,
    const geometry_msgs::Pose &pose,
    visualization_msgs::Marker &outputMsg)
{
    outputMsg.text = situationTypeText;
    outputMsg.header.stamp = stamp;
    outputMsg.pose = pose;
}

const std::string &QueryRssSituationTypeMarkerText(const int32_t situationType)
{
    static const std::map<int32_t, std::string> situationTypeTextMap =
    {
        {rss_msgs::CheckResultObjectState::SITUATION_NOT_RELEVANT,                     "not rel"},
        {rss_msgs::CheckResultObjectState::SITUATION_SAME_DIRECTION,                   "same dir"},
        {rss_msgs::CheckResultObjectState::SITUATION_OPPOSITE_DIRECTION,               "oppo dir"},
        {rss_msgs::CheckResultObjectState::SITUATION_INTERSECTION_EGO_HAS_PRIORITY,    "ego pri"},
        {rss_msgs::CheckResultObjectState::SITUATION_INTERSECTION_OBJECT_HAS_PRIORITY, "obj pri"},
        {rss_msgs::CheckResultObjectState::SITUATION_INTERSECTION_SAME_PRIORITY,       "same pri"},
        {rss_msgs::CheckResultObjectState::SITUATION_UNSTRUCTURED,                     "unstruct"},
    };

    const auto foundSituationTypeText{
        situationTypeTextMap.find(situationType)};
    if (situationTypeTextMap.end() == foundSituationTypeText)
    {
        ROS_ERROR_STREAM(
            "invalid situationType" << situationType << '\n' <<
            "min value is " << rss_msgs::CheckResultObjectState::SITUATION_NOT_RELEVANT << '\n' <<
            "max value is " << rss_msgs::CheckResultObjectState::SITUATION_UNSTRUCTURED);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return foundSituationTypeText->second;
}

} // namespace visualization {
