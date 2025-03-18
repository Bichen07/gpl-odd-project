#include <motion_dijkstra_waypoint_following_config.h>
#include <ros/console.h>
#include <utils_json.h>
#include <motion_config_reader.h>
#include <motion_utils.h>

namespace motion {

void ParseDijkstraWaypointFollowingConfig(
    const Json::Value &configJsonValue,
    DijkstraWaypointFollowingConfig &outputConfig)
{
    map::ParseWaypointId(
        configJsonValue["begin_waypoint_id"],
        outputConfig.beginWaypointId);
    static constexpr const char *viaLaneIdsKey{"via_lane_ids"};
    if (configJsonValue.isMember(viaLaneIdsKey))
    {
        if (!configJsonValue[viaLaneIdsKey].empty())
        {
            outputConfig.viaLaneIds.resize(configJsonValue[viaLaneIdsKey].size());
            auto viaLaneId{outputConfig.viaLaneIds.begin()};
            for (const auto &viaLaneIdValue: configJsonValue[viaLaneIdsKey])
            {
                *viaLaneId = utils::GetIntJsonValue(viaLaneIdValue);
                ++viaLaneId;
            }
        }
    }

    map::ParseWaypointId(
        configJsonValue["end_waypoint_id"],
        outputConfig.endWaypointId);
    outputConfig.waypointLateralOffset = utils::GetDoubleJsonValue(
        configJsonValue["waypoint_lateral_offset"]);
    outputConfig.initMoveSpeedMps = motion::ConvertToMps(
        utils::GetDoubleJsonValue(configJsonValue["init_move_speed_kph"]));
    motion::ParseMoveTriggerCondition(
        configJsonValue["move_trigger_condition"],
        outputConfig.moveTriggerCondition);
    outputConfig.lateralSpeedMps = motion::ConvertToMps(
        utils::GetDoubleJsonValue(configJsonValue["lateral_speed_kph"]));
    outputConfig.lateralMoveDistance = utils::GetDoubleJsonValue(
        configJsonValue["lateral_move_distance"]);
    outputConfig.lateralMoveTriggerDistance = utils::GetDoubleJsonValue(
        configJsonValue["lateral_move_trigger_distance"]);
    static constexpr const char *speedConfigKey{"speed_configs"};
    if (utils::IsMemberKey(configJsonValue, speedConfigKey))
    {
        std::function<decltype(motion::ParseWaypointSpeedConfig)> parseFunc{
            motion::ParseWaypointSpeedConfig};
        motion::ParseMotionConfigs(
            configJsonValue[speedConfigKey],
            parseFunc,
            &outputConfig.speedConfigs);
    }

    ROS_INFO_STREAM(outputConfig);
}

} // namespace motion {
