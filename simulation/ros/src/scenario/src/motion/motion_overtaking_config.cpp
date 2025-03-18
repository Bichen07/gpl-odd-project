#include <motion_overtaking_config.h>
#include <stdexcept>
#include <ros/console.h>
#include <utils_json.h>
#include <motion_utils.h>

namespace motion {

void ParseOvertakingConfig(
    const Json::Value &configJsonValue,
    OvertakingConfig *outputConfig)
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
    outputConfig->beginLateralOffset = utils::GetDoubleJsonValue(
        configJsonValue["begin_lateral_offset"]);
    outputConfig->beginLateralSpeedMps = motion::ConvertToMps(
        utils::GetDoubleJsonValue(configJsonValue["begin_lateral_speed_kph"]));
    outputConfig->endLaneId = utils::GetIntJsonValue(
        configJsonValue["end_lane_id"]);
    outputConfig->endPointId = utils::GetIntJsonValue(
        configJsonValue["end_point_id"]);
    outputConfig->endLateralOffset = utils::GetDoubleJsonValue(
        configJsonValue["end_lateral_offset"]);
    outputConfig->endLateralSpeedMps = motion::ConvertToMps(
        utils::GetDoubleJsonValue(configJsonValue["end_lateral_speed_kph"]));
    outputConfig->moveToRoadsideTriggerLaneId =
        utils::GetIntJsonValue(configJsonValue["move_to_roadside_trigger_lane_id"]);
    outputConfig->moveToRoadsideTriggerPointId =
        utils::GetIntJsonValue(configJsonValue["move_to_roadside_trigger_point_id"]);
    outputConfig->movingSpeedMps = motion::ConvertToMps(
        utils::GetDoubleJsonValue(configJsonValue["moving_speed_kph"]));
    outputConfig->overtakingTriggerDistance = utils::GetDoubleJsonValue(
        configJsonValue["overtaking_trigger_distance"]);
    outputConfig->returningTriggerDistance = utils::GetDoubleJsonValue(
        configJsonValue["returning_trigger_distance"]);
    outputConfig->overtakingLateralDistance = utils::GetDoubleJsonValue(
        configJsonValue["overtaking_lateral_distance"]);
    outputConfig->overtakingSpeedMps = motion::ConvertToMps(
        utils::GetDoubleJsonValue(configJsonValue["overtaking_speed_kph"]));
    outputConfig->overtakingLateralSpeedMps = motion::ConvertToMps(
        utils::GetDoubleJsonValue(configJsonValue["overtaking_lateral_speed_kph"]));
    outputConfig->returningSpeedMps = motion::ConvertToMps(
        utils::GetDoubleJsonValue(configJsonValue["returning_speed_kph"]));
    outputConfig->returningLateralSpeedMps = motion::ConvertToMps(
        utils::GetDoubleJsonValue(configJsonValue["returning_lateral_speed_kph"]));
    outputConfig->leadingSpeedMps = motion::ConvertToMps(
        utils::GetDoubleJsonValue(configJsonValue["leading_speed_kph"]));
    outputConfig->moveTriggerDistance = utils::GetDoubleJsonValue(
        configJsonValue["move_trigger_distance"]);

    ROS_INFO_STREAM(*outputConfig);
}

} // namespace motion {
