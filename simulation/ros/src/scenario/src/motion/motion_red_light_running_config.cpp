#include <motion_red_light_running_config.h>
#include <ros/console.h>
#include <utils_json.h>
#include <motion_utils.h>

namespace motion {

void ParseRedLightRunningConfig(
    const Json::Value &configJsonValue,
    RedLightRunningConfig *outputConfig)
{
    if (nullptr == outputConfig)
    {
        ROS_ERROR_STREAM("outputConfig is nullptr");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    const char *precedingLaneIdKey{"preceding_lane_ids"};
    if (!configJsonValue.isMember(precedingLaneIdKey))
    {
        ROS_ERROR_STREAM("invalid key: " << precedingLaneIdKey);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    const char *succeedingLaneIdKey{"succeeding_lane_ids"};
    if (!configJsonValue.isMember(succeedingLaneIdKey))
    {
        ROS_ERROR_STREAM("invalid key: " << succeedingLaneIdKey);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    outputConfig->precedingLaneIds.resize(configJsonValue[precedingLaneIdKey].size());
    auto precedingLaneId{outputConfig->precedingLaneIds.begin()};
    for (const auto &precedingLaneIdValue: configJsonValue[precedingLaneIdKey])
    {
        *precedingLaneId = utils::GetIntJsonValue(precedingLaneIdValue);
        ++precedingLaneId;
    }

    outputConfig->succeedingLaneIds.resize(configJsonValue[succeedingLaneIdKey].size());
    auto succeedingLaneId{outputConfig->succeedingLaneIds.begin()};
    for (const auto &succeedingLaneIdValue: configJsonValue[succeedingLaneIdKey])
    {
        *succeedingLaneId = utils::GetIntJsonValue(succeedingLaneIdValue);
        ++succeedingLaneId;
    }

    outputConfig->beginPointId = utils::GetIntJsonValue(
        configJsonValue["begin_point_id"]);
    outputConfig->endPointId = utils::GetIntJsonValue(
        configJsonValue["end_point_id"]);
    outputConfig->movingSpeedMps = motion::ConvertToMps(
        utils::GetDoubleJsonValue(configJsonValue["moving_speed_kph"]));
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

    ROS_INFO_STREAM(*outputConfig);
}

} // namespace motion {
