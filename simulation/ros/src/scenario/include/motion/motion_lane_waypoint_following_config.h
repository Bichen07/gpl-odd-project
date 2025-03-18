#ifndef _MOTION_LANE_WAYPOINT_FOLLOWING_CONFIG_H_
#define _MOTION_LANE_WAYPOINT_FOLLOWING_CONFIG_H_

#include <iterator>
#include <iostream>
#include <jsoncpp/json/json.h>
#include <motion_waypoint_speed_config.h>

namespace motion {

struct LaneWaypointFollowingConfig final
{
    std::vector<int32_t> laneIds;
    int32_t beginPointId;
    int32_t endPointId;
    double initMovingSpeedMps;
    double lateralSpeedMps;
    double lateralMoveDistance;
    double moveTriggerDistance;
    double lateralMoveTriggerDistance;
    double beginExtendedDistance;
    double beginExtendedRadian;
    double endExtendedDistance;
    double endExtendedRadian;
    std::vector<WaypointSpeedConfig> speedConfigs;

    LaneWaypointFollowingConfig()
        : laneIds{}
        , beginPointId{0}
        , endPointId{0}
        , initMovingSpeedMps{0.0}
        , lateralSpeedMps{0.0}
        , lateralMoveDistance{0.0}
        , moveTriggerDistance{0.0}
        , lateralMoveTriggerDistance{0.0}
        , beginExtendedDistance{0.0}
        , beginExtendedRadian{0.0}
        , endExtendedDistance{0.0}
        , endExtendedRadian{0.0}
        , speedConfigs{}
    {
    }
    LaneWaypointFollowingConfig(const LaneWaypointFollowingConfig &other) = default;
    LaneWaypointFollowingConfig &operator=(const LaneWaypointFollowingConfig &other) = default;
    ~LaneWaypointFollowingConfig() = default;
};

void ParseLaneWaypointFollowingConfig(
    const Json::Value &configJsonValue,
    LaneWaypointFollowingConfig *outputConfig);

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const LaneWaypointFollowingConfig &config)
{
    ostream << "[motion::LaneWaypointFollowingConfig]" << '\n' <<
        "laneIds: ";
    std::copy(
        config.laneIds.cbegin(),
        config.laneIds.cend(),
        std::ostream_iterator<int32_t>(ostream, ", "));

    ostream << '\n' <<
        "beginPointId: " << config.beginPointId << '\n' <<
        "endPointId: " << config.endPointId << '\n' <<
        "initMovingSpeedMps: " << config.initMovingSpeedMps << '\n' <<
        "lateralSpeedMps: " << config.lateralSpeedMps << '\n' <<
        "lateralMoveDistance: " << config.lateralMoveDistance << '\n' <<
        "moveTriggerDistance: " << config.moveTriggerDistance << '\n' <<
        "lateralMoveTriggerDistance: " << config.lateralMoveTriggerDistance << '\n' <<
        "beginExtendedDistance: " << config.beginExtendedDistance << '\n' <<
        "beginExtendedRadian: " << config.beginExtendedRadian << '\n' <<
        "endExtendedDistance: " << config.endExtendedDistance << '\n' <<
        "endExtendedRadian: " << config.endExtendedRadian;
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

#endif // #ifndef _MOTION_LANE_WAYPOINT_FOLLOWING_CONFIG_H_
