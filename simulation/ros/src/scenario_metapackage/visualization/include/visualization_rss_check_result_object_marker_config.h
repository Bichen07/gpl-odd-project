#ifndef _VISUALIZATION_RSS_CHECK_RESULT_OBJECT_MARKER_CONFIG_H_
#define _VISUALIZATION_RSS_CHECK_RESULT_OBJECT_MARKER_CONFIG_H_

#include <string>
#include <ros/time.h>
#include <ros/duration.h>
#include <std_msgs/ColorRGBA.h>
#include <geometry_msgs/Pose.h>
#include <geometry_msgs/Vector3.h>

namespace visualization {

struct RssCheckResultObjectMarkerConfig final
{
    int32_t markerId;
    ros::Time stamp;
    std::string ns;
    ros::Duration lifetime;
    geometry_msgs::Pose pose;
    geometry_msgs::Vector3 size;
    std_msgs::ColorRGBA color;

    RssCheckResultObjectMarkerConfig()
        : markerId{0}
        , stamp{}
        , ns{}
        , lifetime{}
        , pose{}
        , size{}
        , color{}
    {
    }
    RssCheckResultObjectMarkerConfig(
        const int32_t inputMarkerId,
        const ros::Time &inputStamp,
        const std::string &inputNs,
        const ros::Duration inputLifetime,
        const geometry_msgs::Pose inputPose,
        const geometry_msgs::Vector3 inputSize,
        const std_msgs::ColorRGBA inputColor)
        : markerId{inputMarkerId}
        , stamp{inputStamp}
        , ns{inputNs}
        , lifetime{inputLifetime}
        , pose{inputPose}
        , size{inputSize}
        , color{inputColor}
    {
    }
    RssCheckResultObjectMarkerConfig(
        const RssCheckResultObjectMarkerConfig &other) = default;
    RssCheckResultObjectMarkerConfig &operator=(
        const RssCheckResultObjectMarkerConfig &other) = default;
    ~RssCheckResultObjectMarkerConfig() = default;
};

} // namespace visualization {

#endif // #ifndef _VISUALIZATION_RSS_CHECK_RESULT_OBJECT_MARKER_CONFIG_H_
