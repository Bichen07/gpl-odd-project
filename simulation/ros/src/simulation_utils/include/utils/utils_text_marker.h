#ifndef _UTILS_TEXT_MARKER_H_
#define _UTILS_TEXT_MARKER_H_

#include <string>
#include <std_msgs/ColorRGBA.h>
#include <ros/duration.h>
#include <scenario_msgs/TextMarker.h>
#include <scenario_msgs/TextMarkerArray.h>
#include <geometry_vector_3d.h>
#include <geometry_transform_3d.h>

namespace utils {

struct TextMarker final
{
    std::string id;
    std::string text;
    geometry::Transform3d pose;
    geometry::Vector3d scale;
    ros::Duration lifetime;
    std_msgs::ColorRGBA color;

    TextMarker()
        : id{}
        , text{}
        , pose{}
        , scale{}
        , lifetime{}
        , color{}
    {
    }
    explicit TextMarker(
        const std::string &inputId,
        const std::string &inputText,
        const geometry::Transform3d &inputPose,
        const geometry::Vector3d &inputScale,
        const ros::Duration &inputLifetime,
        const std_msgs::ColorRGBA &inputColor)
        : id{inputId}
        , text{inputText}
        , pose{inputPose}
        , scale{inputScale}
        , lifetime{inputLifetime}
        , color{inputColor}
    {
    }
    TextMarker(const TextMarker &other) = default;
    TextMarker &operator=(const TextMarker &other) = default;
    ~TextMarker() = default;
};

void GenerateTextMarkerMsg(
    const TextMarker &marker,
    scenario_msgs::TextMarker &msg);
void GenerateTextMarkerArrayMsg(
    const std::vector<TextMarker> &markers,
    scenario_msgs::TextMarkerArray &msg);

} // namespace utils {

#endif // #ifndef _UTILS_TEST_MARKER_H_
