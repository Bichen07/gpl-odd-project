#ifndef _MOTION_ZIGZAG_MOVING_CONFIG_H_
#define _MOTION_ZIGZAG_MOVING_CONFIG_H_

#include <iostream>
#include <jsoncpp/json/json.h>

namespace motion {

struct ZigzagMovingConfig final
{
    int32_t beginLaneId;
    int32_t beginPointId;
    int32_t endLaneId;
    int32_t endPointId;
    double lateralOffset;
    double movingSpeedMps;
    double moveTriggerDistance;
    double maxLateralSpeedMps;
    double minLateralSpeedMps;
    double lateralSpeedFrequency;
    double lateralSpeedPhaseRadian;

    ZigzagMovingConfig()
        : beginLaneId{0}
        , beginPointId{0}
        , endLaneId{0}
        , endPointId{0}
        , lateralOffset{0.0}
        , movingSpeedMps{0.0}
        , moveTriggerDistance{0.0}
        , maxLateralSpeedMps{0.0}
        , minLateralSpeedMps{0.0}
        , lateralSpeedFrequency{0.0}
        , lateralSpeedPhaseRadian{0.0}
    {
    }
    ZigzagMovingConfig(const ZigzagMovingConfig &other) = default;
    ZigzagMovingConfig &operator=(const ZigzagMovingConfig &other) = default;
    ~ZigzagMovingConfig() = default;
};

void ParseZigzagMovingConfig(
    const Json::Value &configJsonValue,
    ZigzagMovingConfig *outputConfig);

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const ZigzagMovingConfig &config)
{
    ostream << "[motion::ZigzagMovingConfig]" << '\n' <<
        "beginLaneId: " << config.beginLaneId << '\n' <<
        "beginPointId: " << config.beginPointId << '\n' <<
        "endLaneId: " << config.endLaneId << '\n' <<
        "endPointId: " << config.endPointId << '\n' <<
        "movingSpeedMps: " << config.movingSpeedMps << '\n' <<
        "moveTriggerDistance: " << config.moveTriggerDistance << '\n' <<
        "maxLateralSpeedMps: " << config.maxLateralSpeedMps << '\n' <<
        "minLateralSpeedMps: " << config.minLateralSpeedMps << '\n' <<
        "lateralSpeedFrequency: " << config.lateralSpeedFrequency << '\n' <<
        "lateralSpeedPhaseRadian: " << config.lateralSpeedPhaseRadian;
    return ostream;
}

} // namespace motion {

#endif // #ifndef _MOTION_ZIGZAG_MOVING_CONFIG_H_
