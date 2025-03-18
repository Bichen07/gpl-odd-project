#ifndef _MAP_TRAFFIC_LIGHT_STATE_H_
#define _MAP_TRAFFIC_LIGHT_STATE_H_

#include <map>
#include <iostream>

namespace map {

typedef enum class TrafficLightState: int32_t
{
    Red = 0,
    Yellow,
    Green,
    FlashingRed,
    FlashingYellow,
    Num,
    Null = Num,
} TrafficLightStateId;

TrafficLightStateId ToTrafficLightStateId(const std::string &key);
std::string ToTrafficLightStateLabel(const TrafficLightStateId &trafficLightStateId);
TrafficLightStateId EvaluateTrafficLightState(
    const TrafficLightStateId &currentStateId,
    const bool isLateralLaneTrafficLight);

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const TrafficLightStateId &trafficLightStateId)
{
    static const std::map<TrafficLightStateId, const char *> trafficLightStateIdMap =
    {
        {TrafficLightState::Red,            "TrafficLightState::Red"},
        {TrafficLightState::Yellow,         "TrafficLightState::Yellow"},
        {TrafficLightState::Green,          "TrafficLightState::Green"},
        {TrafficLightState::FlashingRed,    "TrafficLightState::FlashingRed"},
        {TrafficLightState::FlashingYellow, "TrafficLightState::FlashingYellow"},
        {TrafficLightState::Null,           "TrafficLightState::Null"},
    };

    ostream << trafficLightStateIdMap.find(trafficLightStateId)->second;
    return ostream;
}

} // namespace map {

#endif // #ifndef _MAP_TRAFFIC_LIGHT_STATE_H_
