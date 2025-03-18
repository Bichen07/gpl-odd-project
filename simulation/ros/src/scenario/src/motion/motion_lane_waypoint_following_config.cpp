#include <motion_lane_waypoint_following_config.h>
#include <stdexcept>
#include <ros/console.h>
#include <utils_json.h>
#include <motion_config_reader.h>
#include <motion_utils.h>

namespace motion {

void ParseLaneWaypointFollowingConfig(
    const Json::Value &configJsonValue,
    LaneWaypointFollowingConfig *outputConfig)
{
    if (nullptr == outputConfig)
    {
        ROS_ERROR_STREAM("outputConfig is nullptr");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    const char *laneIdKey{"lane_ids"};
    if (!configJsonValue.isMember(laneIdKey))
    {
        ROS_ERROR_STREAM("invalid key: " << laneIdKey);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    outputConfig->laneIds.resize(configJsonValue[laneIdKey].size());
    auto laneId{outputConfig->laneIds.begin()};
    for (const auto &laneIdValue: configJsonValue[laneIdKey])
    {
        *laneId = utils::GetIntJsonValue(laneIdValue);
        ++laneId;
    }

    outputConfig->beginPointId = utils::GetIntJsonValue(
        configJsonValue["begin_point_id"]);
    outputConfig->endPointId = utils::GetIntJsonValue(
        configJsonValue["end_point_id"]);
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
    outputConfig->beginExtendedDistance = utils::GetDoubleJsonValue(
        configJsonValue["begin_extended_distance"]);
    outputConfig->beginExtendedRadian = utils::GetDoubleJsonValue(
        configJsonValue["begin_extended_radian"]);
    outputConfig->endExtendedDistance = utils::GetDoubleJsonValue(
        configJsonValue["end_extended_distance"]);
    outputConfig->endExtendedRadian = utils::GetDoubleJsonValue(
        configJsonValue["end_extended_radian"]);

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
