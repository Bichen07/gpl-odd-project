#ifndef _MOTION_SIGNALIZED_INTERSECTION_CONFIG_H_
#define _MOTION_SIGNALIZED_INTERSECTION_CONFIG_H_

#include <iterator>
#include <vector>
#include <iostream>
#include <jsoncpp/json/json.h>

namespace motion {

struct SignalizedIntersectionConfig
{
    std::vector<int32_t> lateralLaneTrafficLightIds;

    SignalizedIntersectionConfig()
        : lateralLaneTrafficLightIds{}
    {
    }
    SignalizedIntersectionConfig(const std::vector<int32_t> &inputLateralLaneTrafficLightIds)
        : lateralLaneTrafficLightIds{inputLateralLaneTrafficLightIds}
    {
    }
    SignalizedIntersectionConfig(const SignalizedIntersectionConfig &) = default;
    SignalizedIntersectionConfig &operator=(const SignalizedIntersectionConfig &) = default;
    ~SignalizedIntersectionConfig() = default;
};

void ParseSignalizedIntersectionConfig(
    const Json::Value &configJsonValue,
    SignalizedIntersectionConfig &outputConfig);

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const SignalizedIntersectionConfig &config)
{
    ostream << "[motion::SignalizedIntersectionConfig]" << '\n' <<
        "lateralLaneTrafficLightIds: " << '\n';
    std::copy(
        config.lateralLaneTrafficLightIds.cbegin(),
        config.lateralLaneTrafficLightIds.cend(),
        std::ostream_iterator<int32_t>(ostream, ", "));
    return ostream;
}

} // namespace motion {

#endif // #ifndef _MOTION_SIGNALIZED_INTERSECTION_CONFIG_H_
