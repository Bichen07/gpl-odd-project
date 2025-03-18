#ifndef _MOTION_BEGIN_END_WAYPOINT_FOLLOWING_CONFIG_H_
#define _MOTION_BEGIN_END_WAYPOINT_FOLLOWING_CONFIG_H_

#include <iterator>
#include <iostream>
#include <motion_waypoint_speed_config.h>

namespace motion {

struct BeginEndWaypointFollowingConfig final
{
    int32_t beginLaneId;
    int32_t beginPointId;
    int32_t endLaneId;
    int32_t endPointId;
    double waypointLateralOffset;
    double initMovingSpeedMps;
    double lateralSpeedMps;
    double lateralMoveDistance;
    double moveTriggerDistance;
    double lateralMoveTriggerDistance;
    std::vector<WaypointSpeedConfig> speedConfigs;

    BeginEndWaypointFollowingConfig()
        : beginLaneId{0}
        , beginPointId{0}
        , endLaneId{0}
        , endPointId{0}
        , waypointLateralOffset{0.0}
        , initMovingSpeedMps{0.0}
        , lateralSpeedMps{0.0}
        , lateralMoveDistance{0.0}
        , moveTriggerDistance{0.0}
        , lateralMoveTriggerDistance{0.0}
        , speedConfigs{}
    {
    }
    BeginEndWaypointFollowingConfig(const BeginEndWaypointFollowingConfig &other) = default;
    BeginEndWaypointFollowingConfig &operator=(const BeginEndWaypointFollowingConfig &other) = default;
    ~BeginEndWaypointFollowingConfig() = default;
};

void ParseBeginEndWaypointFollowingConfig(
    const Json::Value &configJsonValue,
    BeginEndWaypointFollowingConfig *outputConfig);

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const BeginEndWaypointFollowingConfig &config)
{
    ostream << "[motion::BeginEndWaypointFollowingConfig]" << '\n' <<
        "beginLaneId: " << config.beginLaneId << '\n' <<
        "beginPointId: " << config.beginPointId << '\n' <<
        "endLaneId: " << config.endLaneId << '\n' <<
        "endPointId: " << config.endPointId << '\n' <<
        "waypointLateralOffset: " << config.waypointLateralOffset << '\n' <<
        "initMovingSpeedMps: " << config.initMovingSpeedMps << '\n' <<
        "lateralSpeedMps: " << config.lateralSpeedMps << '\n' <<
        "lateralMoveDistance: " << config.lateralMoveDistance << '\n' <<
        "moveTriggerDistance: " << config.moveTriggerDistance << '\n' <<
        "lateralMoveTriggerDistance: " << config.lateralMoveTriggerDistance;
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

#endif // #ifndef _MOTION_BEGIN_END_WAYPOINT_FOLLOWING_CONFIG_H_
