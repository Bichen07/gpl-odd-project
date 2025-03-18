#ifndef _VISUALIZATION_RSS_SITUATION_TYPE_MARKER_CONFIG_H_
#define _VISUALIZATION_RSS_SITUATION_TYPE_MARKER_CONFIG_H_

#include <visualization_marker_config.h>
#include <string>

namespace visualization {

struct RssSituationTypeMarkerConfig final : public MarkerConfig
{
    std::string situationType;

    RssSituationTypeMarkerConfig()
        : MarkerConfig()
        , situationType{}
    {
    }
    RssSituationTypeMarkerConfig(
        const std::string &inputSituationType,
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
        , situationType{inputSituationType}
    {
    }
    RssSituationTypeMarkerConfig(const RssSituationTypeMarkerConfig &other) = default;
    RssSituationTypeMarkerConfig &operator=(const RssSituationTypeMarkerConfig &other) = default;
    virtual ~RssSituationTypeMarkerConfig() = default;
};

} // namespace visualization {

#endif // #ifndef _VISUALIZATION_RSS_SITUATION_TYPE_MARKER_CONFIG_H_
