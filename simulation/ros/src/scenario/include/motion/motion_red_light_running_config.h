#ifndef _MOTION_RED_LIGHT_RUNNING_CONFIG_H_
#define _MOTION_RED_LIGHT_RUNNING_CONFIG_H_

#include <iterator>
#include <vector>
#include <iostream>
#include <jsoncpp/json/json.h>

namespace motion {

struct RedLightRunningConfig final
{
    std::vector<int32_t> precedingLaneIds;
    std::vector<int32_t> succeedingLaneIds;
    int32_t beginPointId;
    int32_t endPointId;
    double movingSpeedMps;
    double lateralSpeedMps;
    double lateralMoveDistance;
    double moveTriggerDistance;
    double lateralMoveTriggerDistance;
    double beginExtendedDistance;
    double beginExtendedRadian;
    double endExtendedDistance;
    double endExtendedRadian;

    RedLightRunningConfig()
        : precedingLaneIds{}
        , succeedingLaneIds{}
        , beginPointId{0}
        , endPointId{0}
        , movingSpeedMps{0.0}
        , lateralSpeedMps{0.0}
        , lateralMoveDistance{0.0}
        , moveTriggerDistance{0.0}
        , lateralMoveTriggerDistance{0.0}
        , beginExtendedDistance{0.0}
        , beginExtendedRadian{0.0}
        , endExtendedDistance{0.0}
        , endExtendedRadian{0.0}
    {
    }

    RedLightRunningConfig(
        const std::vector<int32_t> inputPrecedingLaneIds,
        const std::vector<int32_t> inputSucceedingLaneIds,
        const int32_t inputBeginPointId,
        const int32_t inputEndPointId,
        const double inputMovingSpeedMps,
        const double inputLateralSpeedMps,
        const double inputLateralMoveDistance,
        const double inputMoveTriggerDistance,
        const double inputLateralMoveTriggerDistance,
        const double inputBeginExtendedDistance,
        const double inputBeginExtendedRadian,
        const double inputEndExtendedDistance,
        const double inputEndExtendedRadian)
        : precedingLaneIds{inputPrecedingLaneIds}
        , succeedingLaneIds{inputSucceedingLaneIds}
        , beginPointId{inputBeginPointId}
        , endPointId{inputEndPointId}
        , movingSpeedMps{inputMovingSpeedMps}
        , lateralSpeedMps{inputLateralSpeedMps}
        , lateralMoveDistance{inputLateralMoveDistance}
        , moveTriggerDistance{inputMoveTriggerDistance}
        , lateralMoveTriggerDistance{0.0}
        , beginExtendedDistance{inputBeginExtendedDistance}
        , beginExtendedRadian{inputBeginExtendedRadian}
        , endExtendedDistance{inputEndExtendedDistance}
        , endExtendedRadian{inputEndExtendedRadian}
    {
    }
    RedLightRunningConfig(const RedLightRunningConfig &other) = default;
    RedLightRunningConfig &operator=(const RedLightRunningConfig &other) = default;
    ~RedLightRunningConfig() = default;
};

void ParseRedLightRunningConfig(
    const Json::Value &configJsonValue,
    RedLightRunningConfig *outputConfig);

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const RedLightRunningConfig &config)
{
    ostream << "[motion::RedLightRunningConfig]" << '\n' <<
        "precedingLaneIds: ";
    std::copy(
        config.precedingLaneIds.cbegin(),
        config.precedingLaneIds.cend(),
        std::ostream_iterator<int32_t>(std::cout, ", "));
    ostream << '\n' << "succeedingLaneIds: ";
    std::copy(
        config.succeedingLaneIds.cbegin(),
        config.succeedingLaneIds.cend(),
        std::ostream_iterator<int32_t>(std::cout, ", "));
    ostream << '\n' <<
        "beginPointId: " << config.beginPointId << '\n' <<
        "endPointId: " << config.endPointId << '\n' <<
        "movingSpeedMps: " << config.movingSpeedMps << '\n' <<
        "lateralSpeedMps: " << config.lateralSpeedMps << '\n' <<
        "lateralMoveDistance: " << config.lateralMoveDistance << '\n' <<
        "moveTriggerDistance" << config.moveTriggerDistance << '\n' <<
        "lateralMoveTriggerDistance: " << config.lateralMoveTriggerDistance << '\n' <<
        "beginExtendedDistance: " << config.beginExtendedDistance << '\n' <<
        "beginExtendedRadian: " << config.beginExtendedRadian << '\n' <<
        "endExtendedDistance: " << config.endExtendedDistance << '\n' <<
        "endExtendedRadian: " << config.endExtendedRadian;

    return ostream;
}

} // namespace motion {


#endif // #ifndef _MOTION_RED_LIGHT_RUNNING_CONFIG_H_
