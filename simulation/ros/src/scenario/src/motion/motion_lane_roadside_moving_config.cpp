#include <motion_lane_roadside_moving_config.h>
#include <stdexcept>
#include <ros/console.h>
#include <utils_json.h>
#include <motion_config_reader.h>
#include <motion_utils.h>

namespace motion {

void ParseLaneRoadsideMovingConfig(
    const Json::Value &configJsonValue,
    LaneRoadsideMovingConfig *outputConfig)
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
    outputConfig->beginLongitudinalOffset = utils::GetDoubleJsonValue(
        configJsonValue["begin_longitudinal_offset"]);
    outputConfig->beginLateralOffset = utils::GetDoubleJsonValue(
        configJsonValue["begin_lateral_offset"]);
    outputConfig->beginLateralSpeedMps = motion::ConvertToMps(
        utils::GetDoubleJsonValue(configJsonValue["begin_lateral_speed_kph"]));
    outputConfig->endLaneId = utils::GetIntJsonValue(
        configJsonValue["end_lane_id"]);
    outputConfig->endPointId = utils::GetIntJsonValue(
        configJsonValue["end_point_id"]);
    outputConfig->endLongitudinalOffset = utils::GetDoubleJsonValue(
        configJsonValue["end_longitudinal_offset"]);
    outputConfig->endLateralOffset = utils::GetDoubleJsonValue(
        configJsonValue["end_lateral_offset"]);
    outputConfig->endLateralSpeedMps = motion::ConvertToMps(
        utils::GetDoubleJsonValue(configJsonValue["end_lateral_speed_kph"]));
    outputConfig->moveToRoadsideTriggerLaneId = utils::GetIntJsonValue(
        configJsonValue["move_to_roadside_trigger_lane_id"]);
    outputConfig->moveToRoadsideTriggerPointId = utils::GetIntJsonValue(
        configJsonValue["move_to_roadside_trigger_point_id"]);
    outputConfig->moveToRoadsideTriggerLongitudinalOffset = utils::GetDoubleJsonValue(
        configJsonValue["move_to_roadside_trigger_longitudinal_offset"]);
    outputConfig->waypointLateralOffset = utils::GetDoubleJsonValue(
        configJsonValue["waypoint_lateral_offset"]);
    outputConfig->moveTriggerDistance = utils::GetDoubleJsonValue(
        configJsonValue["move_trigger_distance"]);
    outputConfig->moveTriggerEgoVehicleMaxSpeedMps = motion::ConvertToMps(
        utils::GetDoubleJsonValue(configJsonValue["move_trigger_ego_vehicle_max_speed_kph"]));
    if (utils::IsMemberKey(configJsonValue, "init_moving_speed_kph"))
    {
        outputConfig->initMovingSpeedMps = motion::ConvertToMps(
            utils::GetDoubleJsonValue(configJsonValue["init_moving_speed_kph"]));
    }
    else
    {
        outputConfig->initMovingSpeedMps = motion::ConvertToMps(
            utils::GetDoubleJsonValue(configJsonValue["moving_speed_kph"]));   
    }

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
