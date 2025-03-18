#include <motion_adaptive_overtaking_config.h>
#include <ros/console.h>
#include <utils_json.h>
#include <motion_utils.h>

namespace motion {

void ParseAdaptiveOvertakingConfig(
    const Json::Value &configJsonValue,
    AdaptiveOvertakingConfig &outputConfig)
{
    map::ParseWaypointId(
        configJsonValue["begin_waypoint_id"],
        outputConfig.beginWaypointId);
    motion::ParseLongitudinalSubmovement(
        configJsonValue["begin_relative_longitudinal_movement"],
        outputConfig.beginRelativeLongitudinalMovement);
    motion::ParseLateralSubmovement(
        configJsonValue["begin_lateral_movement"],
        outputConfig.beginLateralMovement);
    motion::ParseLongitudinalSubmovement(
        configJsonValue["surpassing_relative_longitudinal_movement"],
        outputConfig.surpassingRelativeLongitudinalMovement);
    motion::ParseLateralSubmovement(
        configJsonValue["surpassing_lateral_movement"],
        outputConfig.surpassingLateralMovement);
    motion::ParseLongitudinalSubmovement(
        configJsonValue["returning_relative_longitudinal_movement"],
        outputConfig.returningRelativeLongitudinalMovement);
    motion::ParseLateralSubmovement(
        configJsonValue["returning_lateral_movement"],
        outputConfig.returningLateralMovement);
    outputConfig.leadingSpeedMps = motion::ConvertToMps(
        utils::GetDoubleJsonValue(configJsonValue["leading_speed_kph"]));
    motion::ParseLongitudinalSubmovement(
        configJsonValue["moving_to_roadside_longitudinal_movement"],
        outputConfig.movingToRoadsideLongitudinalMovement);
    motion::ParseLateralSubmovement(
        configJsonValue["moving_to_roadside_lateral_movement"],
        outputConfig.movingToRoadsideLateralMovement);
    map::ParseWaypointId(
        configJsonValue["end_waypoint_id"],
        outputConfig.endWaypointId);
    ROS_INFO_STREAM(outputConfig);
}


} // namespace motion {
