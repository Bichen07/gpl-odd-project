#include <map_traffic_light_state.h>
#include <cctype>
#include <algorithm>
#include <stdexcept>
#include <ros/console.h>

namespace map {

TrafficLightStateId ToTrafficLightStateId(const std::string &key)
{
    std::string lowercaseKey{key};
    std::transform(
        key.cbegin(),
        key.cend(),
        lowercaseKey.begin(),
        [](const char input)
        {return std::tolower(input);});
    static const std::map<std::string, TrafficLightStateId> trafficLightStateIdMap =
    {
        {ToTrafficLightStateLabel(TrafficLightState::Red),            TrafficLightState::Red},
        {ToTrafficLightStateLabel(TrafficLightState::Yellow),         TrafficLightState::Yellow},
        {ToTrafficLightStateLabel(TrafficLightState::Green),          TrafficLightState::Green},
        {ToTrafficLightStateLabel(TrafficLightState::FlashingRed),    TrafficLightState::FlashingRed},
        {ToTrafficLightStateLabel(TrafficLightState::FlashingYellow), TrafficLightState::FlashingYellow},
    };

    const auto foundPair{trafficLightStateIdMap.find(lowercaseKey)};
    if (trafficLightStateIdMap.end() == foundPair)
    {
        ROS_ERROR_STREAM(
            "invalid key: " << key << '\n' <<
            "return TrafficLightState::Null instead");
        return TrafficLightState::Null;
    }

    return TrafficLightState::Null;
}

std::string ToTrafficLightStateLabel(const TrafficLightStateId &trafficLightStateId)
{
    static const std::map<TrafficLightStateId, const char *> trafficLightStateLabelMap =
    {
        {TrafficLightState::Red,            "red"},
        {TrafficLightState::Yellow,         "yellow"},
        {TrafficLightState::Green,          "green"},
        {TrafficLightState::FlashingRed,    "flashing_red"},
        {TrafficLightState::FlashingYellow, "flashing_yello"},
    };

    const auto foundPair{trafficLightStateLabelMap.find(trafficLightStateId)};
    if (trafficLightStateLabelMap.end() == foundPair)
    {
        ROS_ERROR_STREAM("invalid " << trafficLightStateId);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return foundPair->second;
}

TrafficLightStateId EvaluateTrafficLightState(
    const TrafficLightStateId &currentStateId,
    const bool isLateralLaneTrafficLight)
{
    static const std::map<TrafficLightStateId, TrafficLightStateId> lateralLaneTrafficLightStateMap =
    {
        {TrafficLightState::Green, TrafficLightState::Red},
        {TrafficLightState::Red,   TrafficLightState::Green},
    };

    const bool isIdenticalTrafficLight =
        currentStateId == map::TrafficLightState::Yellow ||
        currentStateId == map::TrafficLightState::FlashingRed ||
        currentStateId == map::TrafficLightState::FlashingYellow ||
        currentStateId == map::TrafficLightState::Null;

    auto outputStateId{currentStateId};
    if (!isIdenticalTrafficLight)
    {
        if (isLateralLaneTrafficLight)
        {
            const auto found{
                lateralLaneTrafficLightStateMap.find(currentStateId)};
            if (lateralLaneTrafficLightStateMap.end() == found)
            {
                ROS_ERROR_STREAM("invalid " << currentStateId);
                throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
            }

            outputStateId = found->second;
        }
    }

    return outputStateId;
}

} // namespace map {
