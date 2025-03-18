#ifndef _VISUALIZATION_UTILS_H_
#define _VISUALIZATION_UTILS_H_

#include <visualization_msgs/Marker.h>
#include <visualization_agent_marker_config.h>
#include <visualization_detected_object_id_marker_config.h>
#include <visualization_rss_check_result_object_marker_config.h>
#include <visualization_rss_situation_type_marker_config.h>
#include <visualization_velocity_marker_config.h>
#include <visualization_line_strip_marker_config.h>
#include <visualization_point_marker_config.h>
#include <visualization_text_marker_config.h>

namespace visualization {

void GenerateAgentData(
    const AgentDataConfig &config,
    visualization_msgs::Marker &outputMsg);
void UpdateAgentData(
    const ros::Time &stamp,
    const scenario_msgs::AgentData &agentDataMsg,
    visualization_msgs::Marker &updatedMsg);
void GenerateRssCheckResultMarker(
    const RssCheckResultObjectMarkerConfig &config,
    visualization_msgs::Marker &outputMsg);
void UpdateRssCheckResultMarker(
    const ros::Time &stamp,
    const geometry_msgs::Pose &pose,
    const std_msgs::ColorRGBA &color,
    visualization_msgs::Marker &updatedMsg);
void GenerateVelocityMarker(
    const VelocityMarkerConfig &config,
    visualization_msgs::Marker &outputMsg);
void UpdateVelocityMarker(
    const ros::Time &stamp,
    const geometry_msgs::Vector3 &velocity,
    const geometry_msgs::Point &beginPosition,
    visualization_msgs::Marker &updatedMsg);
void ComputeVelocityMarkerPose(
    const geometry_msgs::Vector3 &velocity,
    const geometry_msgs::Point &beginPosition,
    geometry_msgs::Pose &outputPose);
void GenerateLineStripMarker(
    const LineStripMarkerConfig &config,
    visualization_msgs::Marker &outputMsg);
void UpdateLineStripMarker(
    const ros::Time &stamp,
    const scenario_msgs::LineStripMarker &markerMsg,
    visualization_msgs::Marker &updatedMsg);
void GeneratePointMarker(
    const PointMarkerConfig &config,
    visualization_msgs::Marker &outputMsg);
void UpdatePointMarker(
    const ros::Time &stamp,
    const geometry_msgs::Pose &pose,
    const geometry_msgs::Vector3 &scale,
    const ros::Duration &lifetime,
    const std_msgs::ColorRGBA &color,
    visualization_msgs::Marker &updatedMsg);
void GenerateTextMarker(
    const TextMarkerConfig &config,
    visualization_msgs::Marker &outputMsg);
void UpdateTextMarker(
    const ros::Time &stamp,
    const std::string &text,
    const geometry_msgs::Pose &pose,
    const geometry_msgs::Vector3 &scale,
    const ros::Duration &lifetime,
    const std_msgs::ColorRGBA &color,
    visualization_msgs::Marker &updatedMsg);
void GenerateDetectedObjectIdMarker(
    const DetectedObjectIdMarkerConfig &config,
    visualization_msgs::Marker &outputMsg);
void UpdateDetectedObjectIdMarker(
    const ros::Time &stamp,
    const geometry_msgs::Pose &pose,
    visualization_msgs::Marker &outputMsg);
void GenerateRssSituationTypeMarker(
    const RssSituationTypeMarkerConfig &config,
    visualization_msgs::Marker &outputMsg);
void UpdateRssSituationTypeMarker(
    const std::string &situationTypeText,
    const ros::Time &stamp,
    const geometry_msgs::Pose &pose,
     visualization_msgs::Marker &outputMsg);

const std::string &QueryRssSituationTypeMarkerText(const int32_t situationType);

} // namespace visualization {

#endif // #ifndef _VISUALIZATION_UTILS_H_
