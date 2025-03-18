#ifndef _UTILS_VISUALIZATION_MSGS_H_
#define _UTILS_VISUALIZATION_MSGS_H_

#include <ros/ros.h>
#include <std_msgs/ColorRGBA.h>
#include <visualization_msgs/MarkerArray.h>
#include <math_type.h>
#include <utils_point_marker.h>

namespace utils {

void GenerateVisualizationSphereMsgs(
    const int32_t id,
    const char *ns,
    const ros::Time &stamp,
    const math::HomoXfm3d_t &pose,
    const math::Vector3d_t &scale,
    const ros::Duration &lifetTime,
    const std_msgs::ColorRGBA &colorMsgs,
    visualization_msgs::Marker *markerMsgs);
void GenerateVisualizationSphereMsg(
    const int32_t id,
    const std::string &ns,
    const ros::Time &stamp,
    const geometry_msgs::Pose &pose,
    const geometry_msgs::Vector3 &scale,
    const ros::Duration &lifeTime,
    const std_msgs::ColorRGBA &color,
    visualization_msgs::Marker &outputMsg);

void GenerateVisualizationCubeMsgs(
    const int32_t id,
    const char *ns,
    const ros::Time &stamp,
    const math::HomoXfm3d_t &pose,
    const math::Vector3d_t &scale,
    const ros::Duration &lifeTime,
    const std_msgs::ColorRGBA &colorMsgs,
    visualization_msgs::Marker *markerMsgs);
void GenerateVisualizationCubeMsg(
    const int32_t id,
    const std::string &ns,
    const ros::Time &stamp,
    const geometry_msgs::Pose &pose,
    const geometry_msgs::Vector3 &scale,
    const ros::Duration &lifeTime,
    const std_msgs::ColorRGBA &colorMsgs,
    visualization_msgs::Marker &markerMsgs);

void GenerateVisualizationLineStripMsgs(
    const int32_t id,
    const char *ns,
    const ros::Time &stamp,
    const std::vector<math::Vector3d_t> &points,
    const math::Vector3d_t &scale,
    const ros::Duration &lifeTime,
    const std_msgs::ColorRGBA &colorMsgs,
    visualization_msgs::Marker *markerMsgs);
void GenerateVisualizationLineStripMsg(
    const int32_t id,
    const std::string &ns,
    const ros::Time &stamp,
    const std::vector<geometry_msgs::Point> &points,
    const geometry_msgs::Vector3 &scale,
    const ros::Duration &lifeTime,
    const std_msgs::ColorRGBA &colorMsgs,
    visualization_msgs::Marker &markerMsgs);

void GenerateVisualizationClosedLineStripMsgs(
    const int32_t id,
    const char *ns,
    const ros::Time &stamp,
    const std::vector<math::Vector3d_t> &vertices,
    const math::Vector3d_t &scale,
    const ros::Duration &lifeTime,
    const std_msgs::ColorRGBA &colorMsgs,
    visualization_msgs::Marker *markerMsgs);

void GenerateVisualizationArrowMsgs(
    const int32_t id,
    const char *ns,
    const ros::Time &stamp,
    const math::HomoXfm3d_t &pose,
    const math::Vector3d_t &scale,
    const ros::Duration &lifeTime,
    const std_msgs::ColorRGBA &colorMsgs,
    visualization_msgs::Marker *markerMsgs);

void GenerateVisualizationTextMsgs(
    const std::string &text,
    const int32_t id,
    const char *ns,
    const ros::Time &stamp,
    const math::HomoXfm3d_t &pose,
    const math::Vector3d_t &scale,
    const ros::Duration &lifeTime,
    const std_msgs::ColorRGBA &colorMsgs,
    visualization_msgs::Marker *markerMsgs);
void GenerateVisualizationTextMsg(
    const std::string &text,
    const int32_t id,
    const std::string &ns,
    const ros::Time &stamp,
    const geometry_msgs::Pose &pose,
    const geometry_msgs::Vector3 &scale,
    const ros::Duration &lifetime,
    const std_msgs::ColorRGBA &colorMsg,
    visualization_msgs::Marker &markerMsgs);

void DeleteVisualizationMsgs(
    const int32_t id,
    const char *ns,
    const ros::Time &stamp,
    visualization_msgs::Marker *markerMsgs);

void GenerateVisualizationPointMarkerMsgs(
    const int32_t id,
    const char *ns,
    const ros::Time &stamp,
    const PointMarker &pointMarker,
    visualization_msgs::Marker *markerMsgs);

} // namespace utils {

#endif // #ifndef _UTILS_VISUALIZATION_MSGS_H_
