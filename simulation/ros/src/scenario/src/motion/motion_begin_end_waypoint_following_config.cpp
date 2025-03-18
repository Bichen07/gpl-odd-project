#include <motion_begin_end_waypoint_following_config.h>
#include <ros/console.h>
#include <utils_json.h>
#include <motion_config_reader.h>
#include <motion_utils.h>

namespace motion {

void ParseBeginEndWaypointFollowingConfig(
    const Json::Value &configJsonValue,
    BeginEndWaypointFollowingConfig *outputConfig)
{
    if (nullptr == outputConfig)
    {
        ROS_ERROR_STREAM("outputConfig is nullptr");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    outputConfig->beginLaneId = utils::GetIntJsonValue(
        configJsonValue["begin_lane_id"]);
    outputConfig->beginPointId = utils::GetIntJsonValue(
        configJsonValue["begin_point_id"]);
    outputConfig->endLaneId = utils::GetIntJsonValue(
        configJsonValue["end_lane_id"]);
    outputConfig->endPointId = utils::GetIntJsonValue(
        configJsonValue["end_point_id"]);
    outputConfig->waypointLateralOffset = utils::GetDoubleJsonValue(
        configJsonValue["waypoint_lateral_offset"]);
    outputConfig->initMovingSpeedMps = motion::ConvertToMps(
        utils::GetDoubleJsonValue(configJsonValue["init_moving_speed_kph"]));
    outputConfig->lateralSpeedMps = motion::ConvertToMps(
        utils::GetDoubleJsonValue(configJsonValue["lateral_speed_kph"]));
    outputConfig->lateralMoveDistance = utils::GetIntJsonValue(
        configJsonValue["lateral_move_distance"]);
    outputConfig->moveTriggerDistance = utils::GetDoubleJsonValue(
        configJsonValue["move_trigger_distance"]);
    outputConfig->lateralMoveTriggerDistance = utils::GetDoubleJsonValue(
        configJsonValue["lateral_move_trigger_distance"]);

    static constexpr const char *speedConfigKey{"speed_configs"};
    if (utils::IsMemberKey(configJsonValue, speedConfigKey))
    {
        std::function<decltype(motion::ParseWaypointSpeedConfig)> parseFunc{
            motion::ParseWaypointSpeedConfig};
        motion::ParseMotionConfigs(
            configJsonValue[speedConfigKey],
            parseFunc,
            &outputConfig->speedConfigs);
    }

    ROS_INFO_STREAM(*outputConfig);
}

} // namespace motion {
