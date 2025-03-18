#ifndef _MOTION_LANE_ROADSIDE_MOVING_CONFIG_H_
#define _MOTION_LANE_ROADSIDE_MOVING_CONFIG_H_

#include <iterator>
#include <iostream>
#include <jsoncpp/json/json.h>
#include <motion_waypoint_speed_config.h>

namespace motion {

struct LaneRoadsideMovingConfig final
{
    int32_t beginLaneId;
    int32_t beginPointId;
    double beginLongitudinalOffset;
    double beginLateralOffset;
    double beginLateralSpeedMps;
    int32_t endLaneId;
    int32_t endPointId;
    double endLongitudinalOffset;
    double endLateralOffset;
    double endLateralSpeedMps;
    int32_t moveToRoadsideTriggerLaneId;
    int32_t moveToRoadsideTriggerPointId;
    double moveToRoadsideTriggerLongitudinalOffset;
    double waypointLateralOffset;
    double moveTriggerDistance;
    double moveTriggerEgoVehicleMaxSpeedMps;
    double initMovingSpeedMps;
    std::vector<WaypointSpeedConfig> speedConfigs;

    LaneRoadsideMovingConfig()
        : beginLaneId{0}
        , beginPointId{0}
        , beginLongitudinalOffset{0.0}
        , beginLateralOffset{0.0}
        , beginLateralSpeedMps{0.0}
        , endLaneId{0}
        , endPointId{0}
        , endLongitudinalOffset{0.0}
        , endLateralOffset{0.0}
        , endLateralSpeedMps{0.0}
        , moveToRoadsideTriggerLaneId{0}
        , moveToRoadsideTriggerPointId{0}
        , moveToRoadsideTriggerLongitudinalOffset{0.0}
        , waypointLateralOffset{0.0}
        , moveTriggerDistance{0.0}
        , moveTriggerEgoVehicleMaxSpeedMps{0.0}
        , initMovingSpeedMps{0.0}
        , speedConfigs{}
    {
    }
    explicit LaneRoadsideMovingConfig(
        const int32_t inputBeginLaneId,
        const int32_t inputBeginPointId,
        const double inputBeginLongitudinalOffset,
        const double inputBeginLateralOffset,
        const double inputBeginLateralSpeedMps,
        const int32_t inputEndLaneId,
        const int32_t inputEndPointId,
        const double inputEndLongitudinalOffset,
        const double inputEndLateralOffset,
        const double inputEndLateralSpeedMps,
        const int32_t inputMoveToRoadsideTriggerLaneId,
        const int32_t inputMoveToRoadsideTriggerPointId,
        const double inputMoveToRoadsideTriggerLongitudinalOffset,
        const double inputWaypointLateralOffset,
        const double inputMoveTriggerDistance,
        const double inputMoveTriggerEgoVehicleMaxSpeedMps,
        const double inputInitMovingSpeedMps,
         const std::vector<WaypointSpeedConfig> &inputSpeedConfigs)
        : beginLaneId{inputBeginLaneId}
        , beginPointId{inputBeginPointId}
        , beginLongitudinalOffset{inputBeginLongitudinalOffset}
        , beginLateralOffset{inputBeginLateralOffset}
        , beginLateralSpeedMps{inputBeginLateralSpeedMps}
        , endLaneId{inputEndLaneId}
        , endPointId{inputEndPointId}
        , endLongitudinalOffset{inputEndLongitudinalOffset}
        , endLateralOffset{inputEndLateralOffset}
        , endLateralSpeedMps{inputEndLateralSpeedMps}
        , moveToRoadsideTriggerLaneId{inputMoveToRoadsideTriggerLaneId}
        , moveToRoadsideTriggerPointId{inputMoveToRoadsideTriggerPointId}
        , moveToRoadsideTriggerLongitudinalOffset{inputMoveToRoadsideTriggerLongitudinalOffset}
        , waypointLateralOffset{inputWaypointLateralOffset}
        , moveTriggerDistance{inputMoveTriggerDistance}
        , moveTriggerEgoVehicleMaxSpeedMps{inputMoveTriggerEgoVehicleMaxSpeedMps}
        , initMovingSpeedMps{inputInitMovingSpeedMps}
        , speedConfigs{inputSpeedConfigs}
    {
    }
    LaneRoadsideMovingConfig(const LaneRoadsideMovingConfig &other) = default;
    LaneRoadsideMovingConfig &operator=(const LaneRoadsideMovingConfig &other) = default;
    ~LaneRoadsideMovingConfig() = default;
};

void ParseLaneRoadsideMovingConfig(
    const Json::Value &configJsonValue,
    LaneRoadsideMovingConfig *outputConfig);

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const LaneRoadsideMovingConfig &config)
{
    ostream << "[motion::LaneRoadsideMovingConfig]" << '\n' <<
        "beginLaneId: " << config.beginLaneId << '\n' <<
        "beginPointId: " << config.beginPointId << '\n' <<
        "beginLongitudinalOffset: " << config.beginLongitudinalOffset << '\n' <<
        "beginLateralOffset: " << config.beginLateralOffset << '\n' <<
        "beginLateralSpeedMps" << config.beginLateralSpeedMps << '\n' <<
        "endLaneId: " << config.endLaneId << '\n' <<
        "endPointId: " << config.endPointId << '\n' <<
        "endLongitudinalOffset: " << config.endLongitudinalOffset << '\n' <<
        "endLateralOffset: " << config.endLateralOffset << '\n' <<
        "endLateralSpeedMps: " << config.endLateralSpeedMps << '\n' <<
        "moveToRoadsideTriggerLaneId: " << config.moveToRoadsideTriggerLaneId << '\n' <<
        "moveToRoadsideTriggerPointId: " << config.moveToRoadsideTriggerPointId << '\n' <<
        "moveToRoadsideTriggerLongitudinalOffset: " << config.moveToRoadsideTriggerLongitudinalOffset << '\n' <<
        "waypointLateralOffset: " << config.waypointLateralOffset << '\n' <<
        "moveTriggerDistance: " << config.moveTriggerDistance << '\n' <<
        "moveTriggerEgoVehicleMaxSpeedMps: " << config.moveTriggerEgoVehicleMaxSpeedMps << '\n' <<
        "initMovingSpeedMps: " << config.initMovingSpeedMps;
    if (!config.speedConfigs.empty())
    {
        ostream << '\n' << "speedConfigs:" << '\n';
        std::copy(
            config.speedConfigs.cbegin(),
            config.speedConfigs.cend(),
            std::ostream_iterator<WaypointSpeedConfig>(ostream, ",\n"));
    }
    return ostream;
}

} // namespace motion {

#endif // #ifndef _MOTION_LANE_ROADSIDE_MOVING_CONFIG_H_
