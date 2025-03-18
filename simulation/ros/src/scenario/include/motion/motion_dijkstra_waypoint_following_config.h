#ifndef _MOTION_DIJKSTRA_WAYPOINT_FOLLOWING_CONFIG_H_
#define _MOTION_DIJKSTRA_WAYPOINT_FOLLOWING_CONFIG_H_

#include <iterator>
#include <iostream>
#include <jsoncpp/json/json.h>
#include <map_waypoint_id.h>
#include <motion_move_trigger_condition.h>
#include <motion_waypoint_speed_config.h>

namespace motion {

struct DijkstraWaypointFollowingConfig
{
    map::WaypointId beginWaypointId;
    std::vector<int32_t> viaLaneIds;
    map::WaypointId endWaypointId;
    double waypointLateralOffset;
    double initMoveSpeedMps;
    MoveTriggerCondition moveTriggerCondition;
    double lateralSpeedMps;
    double lateralMoveDistance;
    double lateralMoveTriggerDistance;
    std::vector<WaypointSpeedConfig> speedConfigs;

    DijkstraWaypointFollowingConfig()
        : beginWaypointId{}
        , viaLaneIds{}
        , endWaypointId{}
        , waypointLateralOffset{0.0}
        , initMoveSpeedMps{0.0}
        , moveTriggerCondition{}
        , lateralSpeedMps{0.0}
        , lateralMoveDistance{0.0}
        , lateralMoveTriggerDistance{0.0}
        , speedConfigs{}
    {
    }
    DijkstraWaypointFollowingConfig(
        const map::WaypointId &inputBeginWaypointId,
        const std::vector<int32_t> &inputViaLaneIds,
        const map::WaypointId &inputEndWaypointId,
        const double inputWaypointLateralOffset,
        const double inputInitMoveSpeedMps,
        const MoveTriggerCondition &inputMoveTriggerCondition,
        const double inputLateralSpeedMps,
        const double inputLateralMoveDistance,
        const double inputLateralMoveTriggerDistance,
        const std::vector<WaypointSpeedConfig> &inputSpeedConfigs)
        : beginWaypointId{inputBeginWaypointId}
        , viaLaneIds{inputViaLaneIds}
        , endWaypointId{inputEndWaypointId}
        , waypointLateralOffset{inputWaypointLateralOffset}
        , initMoveSpeedMps{inputInitMoveSpeedMps}
        , moveTriggerCondition{inputMoveTriggerCondition}
        , lateralSpeedMps{inputLateralSpeedMps}
        , lateralMoveDistance{inputLateralMoveDistance}
        , lateralMoveTriggerDistance{inputLateralMoveTriggerDistance}
        , speedConfigs{inputSpeedConfigs}
    {
    }
    DijkstraWaypointFollowingConfig(const DijkstraWaypointFollowingConfig &other) = default;
    DijkstraWaypointFollowingConfig &operator=(const DijkstraWaypointFollowingConfig &) = default;
    ~DijkstraWaypointFollowingConfig() = default;
};

void ParseDijkstraWaypointFollowingConfig(
    const Json::Value &configJsonValue,
    DijkstraWaypointFollowingConfig &outputConfig);

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const DijkstraWaypointFollowingConfig &config)
{
    ostream << "[motion::DijkstraWaypointFollowingConfig]" << '\n' <<
        "begainWaypointId: " << config.beginWaypointId << '\n';
    if (!config.viaLaneIds.empty())
    {
        ostream << "viaLaneIds:" << '\n';
        std::copy(
            config.viaLaneIds.cbegin(),
            config.viaLaneIds.cend(),
            std::ostream_iterator<int32_t>(ostream, "\n"));
    }
    ostream <<
        "endWaypointId: " << config.endWaypointId << '\n' <<
        "waypointLateralOffset: " << config.waypointLateralOffset << '\n' <<
        "initMoveSpeedMps: " << config.initMoveSpeedMps << '\n' <<
        "moveTriggerCondition: " << config.moveTriggerCondition << '\n' <<
        "lateralSpeedMps: " << config.lateralSpeedMps << '\n' <<
        "lateralMoveDistance: " << config.lateralMoveDistance << '\n' <<
        "lateralMoveTriggerDistance: " << config.lateralMoveTriggerDistance << '\n';
    if (!config.speedConfigs.empty())
    {
        ostream << "speedConfigs:" << '\n';
        std::copy(
            config.speedConfigs.cbegin(),
            config.speedConfigs.cend(),
            std::ostream_iterator<WaypointSpeedConfig>(ostream, ",\n"));
    }

    return ostream;
}

} // namespace motion {

#endif // #ifndef _MOTION_DIJKSTRA_WAYPOINT_FOLLOWING_CONFIG_H_
