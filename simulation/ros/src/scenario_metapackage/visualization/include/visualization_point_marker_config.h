#ifndef _VISUALIZATION_POINT_MARKER_CONFIG_H_
#define _VISUALIZATION_POINT_MARKER_CONFIG_H_

#include <visualization_marker_config.h>
#include <limits>

namespace visualization {

struct PointMarkerConfig final : public MarkerConfig
{
    uint8_t type;

    PointMarkerConfig()
        : MarkerConfig()
        , type{std::numeric_limits<uint8_t>::max()}
    {
    }
    PointMarkerConfig(
        const uint8_t inputType,
        const int32_t inputMarkerId,
        const ros::Time &inputStamp,
        const std::string &inputNs,
        const ros::Duration &inputLifetime,
        const geometry_msgs::Pose &inputPose,
        const geometry_msgs::Vector3 &inputSize,
        const std_msgs::ColorRGBA &inputColor)
        : MarkerConfig(
            inputMarkerId,
            inputStamp,
            inputNs,
            inputLifetime,
            inputPose,
            inputSize,
            inputColor)
        , type{inputType}
    {
    }
    PointMarkerConfig(const PointMarkerConfig &other) = default;
    PointMarkerConfig &operator=(const PointMarkerConfig &other) = default;
    virtual ~PointMarkerConfig() = default;
};

} // namespace visualization {

#endif // #ifndef _VISUALIZATION_POINT_MARKER_CONFIG_H_
