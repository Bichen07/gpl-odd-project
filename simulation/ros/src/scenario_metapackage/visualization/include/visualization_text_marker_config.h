#ifndef _VISUALIZATOIN_TEXT_MARKER_CONFIG_H_
#define _VISUALIZATOIN_TEXT_MARKER_CONFIG_H_

#include <visualization_marker_config.h>

namespace visualization {

struct TextMarkerConfig final : public MarkerConfig
{
    std::string text;

    TextMarkerConfig()
        : MarkerConfig()
        , text{}
    {
    }
    TextMarkerConfig(
        const std::string &inputText,
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
        , text{inputText}
    {
    }
    TextMarkerConfig(const TextMarkerConfig &other) = default;
    TextMarkerConfig &operator=(const TextMarkerConfig &other) = default;
    virtual ~TextMarkerConfig() = default;
};

} // namespace visualization {

#endif // #ifndef _VISUALIZATOIN_TEST_MARKER_CONFIG_H_
