#include <motion_zigzag_moving_config.h>
#include <ros/console.h>
#include <utils_json.h>
#include <motion_utils.h>

namespace motion {

void ParseZigzagMovingConfig(
    const Json::Value &configJsonValue,
    ZigzagMovingConfig *outputConfig)
{
    if (nullptr == outputConfig)
    {
        ROS_ERROR_STREAM("outputConfig is nullptr");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    outputConfig->beginLaneId =
        utils::GetIntJsonValue(configJsonValue["begin_lane_id"]);
    outputConfig->beginPointId =
        utils::GetIntJsonValue(configJsonValue["begin_point_id"]);
    outputConfig->endLaneId =
        utils::GetIntJsonValue(configJsonValue["end_lane_id"]);
    outputConfig->endPointId =
        utils::GetIntJsonValue(configJsonValue["end_point_id"]);
    outputConfig->lateralOffset =
        utils::GetDoubleJsonValue(configJsonValue["lateral_offset"]);
    outputConfig->movingSpeedMps = motion::ConvertToMps(
        utils::GetDoubleJsonValue(configJsonValue["moving_speed_kph"]));
    outputConfig->moveTriggerDistance =
        utils::GetDoubleJsonValue(configJsonValue["move_trigger_distance"]);
    outputConfig->maxLateralSpeedMps = motion::ConvertToMps(
        utils::GetDoubleJsonValue(configJsonValue["max_lateral_speed_kph"]));
    outputConfig->minLateralSpeedMps = motion::ConvertToMps(
        utils::GetDoubleJsonValue(configJsonValue["min_lateral_speed_kph"]));
    outputConfig->lateralSpeedFrequency =
        utils::GetDoubleJsonValue(configJsonValue["lateral_speed_frequency"]);
    outputConfig->lateralSpeedPhaseRadian =
        utils::GetDoubleJsonValue(configJsonValue["lateral_speed_phase_radian"]);
    ROS_INFO_STREAM(*outputConfig);
}

} // namespace motion {
