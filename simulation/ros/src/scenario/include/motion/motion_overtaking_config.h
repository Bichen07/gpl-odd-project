#ifndef _MOTION_OVERTAKING_CONFIG_H_
#define _MOTION_OVERTAKING_CONFIG_H_

#include <iostream>
#include <jsoncpp/json/json.h>

namespace motion {

struct OvertakingConfig final
{
    int32_t beginLaneId;
    int32_t beginPointId;
    double beginLateralOffset;
    double beginLateralSpeedMps;
    int32_t endLaneId;
    int32_t endPointId;
    double endLateralOffset;
    double endLateralSpeedMps;
    int32_t moveToRoadsideTriggerLaneId;
    int32_t moveToRoadsideTriggerPointId;
    double movingSpeedMps;
    double overtakingTriggerDistance;
    double returningTriggerDistance;
    double overtakingLateralDistance;
    double overtakingSpeedMps;
    double overtakingLateralSpeedMps;
    double returningSpeedMps;
    double returningLateralSpeedMps;
    double leadingSpeedMps;
    double moveTriggerDistance;

    OvertakingConfig()
        : beginLaneId{0}
        , beginPointId{0}
        , beginLateralOffset{0.0}
        , beginLateralSpeedMps{0.0}
        , endLaneId{0}
        , endPointId{0}
        , endLateralOffset{0.0}
        , endLateralSpeedMps{0.0}
        , movingSpeedMps{0.0}
        , overtakingTriggerDistance{0.0}
        , returningTriggerDistance{0.0}
        , overtakingLateralDistance{0.0}
        , overtakingSpeedMps{0.0}
        , overtakingLateralSpeedMps{0.0}
        , returningSpeedMps{0.0}
        , returningLateralSpeedMps{0.0}
        , leadingSpeedMps{0.0}
        , moveTriggerDistance{0.0}
    {
    }
    explicit OvertakingConfig(
        const int32_t inputBeginLaneId,
        const int32_t inputBeginPointId,
        const double inputBeginLateralOffset,
        const double inputBeginLateralSpeedMps,
        const int32_t inputEndLaneId,
        const int32_t inputEndPointId,
        const double inputEndLateralOffset,
        const double inputEndLateralSpeedMps,
        const int32_t inputMoveToRoadsideTriggerLaneId,
        const int32_t inputMoveToRoadsideTriggerPointId,
        const double inputMovingSpeedMps,
        const double inputOvertakingTriggerDistance,
        const double inputReturningTriggerDistance,
        const double inputOvertakingLateralDistance,
        const double inputOvertakingSpeedMps,
        const double inputOvertakingLateralSpeedMps,
        const double inputReturningSpeedMps,
        const double inputReturningLateralSpeedMps,
        const double inputLeadingSpeedMps,
        const double inputMoveTriggerDistance)
        : beginLaneId{inputBeginLaneId}
        , beginPointId{inputBeginPointId}
        , beginLateralOffset{inputBeginLateralOffset}
        , beginLateralSpeedMps{inputBeginLateralSpeedMps}
        , endLaneId{inputEndLaneId}
        , endPointId{inputEndPointId}
        , endLateralOffset{inputEndLateralOffset}
        , endLateralSpeedMps{inputEndLateralSpeedMps}
        , moveToRoadsideTriggerLaneId{inputMoveToRoadsideTriggerLaneId}
        , moveToRoadsideTriggerPointId{inputMoveToRoadsideTriggerPointId}
        , movingSpeedMps{inputMovingSpeedMps}
        , overtakingTriggerDistance{inputOvertakingTriggerDistance}
        , returningTriggerDistance{inputReturningTriggerDistance}
        , overtakingLateralDistance{inputOvertakingLateralDistance}
        , overtakingSpeedMps{inputOvertakingSpeedMps}
        , overtakingLateralSpeedMps{inputOvertakingLateralSpeedMps}
        , returningSpeedMps{inputReturningSpeedMps}
        , returningLateralSpeedMps{inputReturningLateralSpeedMps}
        , leadingSpeedMps{inputLeadingSpeedMps}
        , moveTriggerDistance{inputMoveTriggerDistance}
    {
    }
    OvertakingConfig(const OvertakingConfig &other) = default;
    OvertakingConfig &operator=(const OvertakingConfig &other) = default;
    ~OvertakingConfig() = default;
};

void ParseOvertakingConfig(
    const Json::Value &configJsonValue,
    OvertakingConfig *outputConfig);

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const OvertakingConfig &config)
{
    ostream << "[motion::OvertakingConfig]" << '\n' <<
        "beginLaneId: " << config.beginLaneId << '\n' <<
        "beginPointId: " << config.beginPointId << '\n' <<
        "beginLateralOffset: " << config.beginLateralOffset << '\n' <<
        "beginLateralSpeedMps: " << config.beginLateralSpeedMps << '\n' <<
        "endLaneId: " << config.endLaneId << '\n' <<
        "endPointId: " << config.endPointId << '\n' <<
        "endLateralOffset: " << config.endLateralOffset << '\n' <<
        "endLateralSpeedMps: " << config.endLateralSpeedMps << '\n' <<
        "moveToRoadsideTriggerLaneId: " << config.moveToRoadsideTriggerLaneId << '\n' <<
        "moveToRoadsideTriggerPointId: " << config.moveToRoadsideTriggerPointId << '\n' <<
        "movingSpeedMps: " << config.movingSpeedMps << '\n' <<
        "overtakingTriggerDistance: " << config.overtakingTriggerDistance << '\n' <<
        "returningTriggerDistance: " << config.returningTriggerDistance << '\n' <<
        "overtakingLateralDistance: " << config.overtakingLateralDistance << '\n' <<
        "overtakingSpeedMps: " << config.overtakingSpeedMps << '\n' <<
        "overtakingLateralSpeedMps: " << config.overtakingLateralSpeedMps << '\n' <<
        "returningSpeedMps: " << config.returningSpeedMps << '\n' <<
        "returningLateralSpeedMps: " << config.returningLateralSpeedMps << '\n' <<
        "leadingSpeedMps: " << config.leadingSpeedMps << '\n' <<
        "moveTriggerDistance: " << config.moveTriggerDistance;
    return ostream;
}

} // namespace motion {

#endif // #ifndef _MOTION_OVERTAKING_CONFIG_H_
