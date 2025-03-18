#include <motion_dijkstra_interpolation_waypoint_following_config.h>
#include <ros/console.h>
#include <math_stream_utils.h>
#include <utils_json.h>
#include <motion_utils.h>
#include <motion_config_reader.h>

namespace motion {

void ParseDijkstraInterpolationWaypointFollowingConfig(
    const Json::Value &configJsonValue,
    DijkstraInterpolationWaypointFollowingConfig &outputConfig)
{
    outputConfig.beginLaneId = utils::GetIntJsonValue(
        configJsonValue["begin_lane_id"]);
    outputConfig.endLaneId = utils::GetIntJsonValue(
        configJsonValue["end_lane_id"]);
    outputConfig.interpolatorId = path::ToInterpolatorId(
        utils::GetStringJsonValue(configJsonValue["interpolation_id"]));
    outputConfig.controlPoints = math::ParseVector3ds(
        configJsonValue["control_points"]);
    outputConfig.initMoveSpeedMps = motion::ConvertToMps(
        utils::GetDoubleJsonValue(configJsonValue["init_move_speed_kph"]));
    motion::ParseMoveTriggerCondition(
        configJsonValue["move_trigger_condition"],
        outputConfig.moveTriggerCondition);
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
