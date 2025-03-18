#include <motion_stationary_object_config.h>
#include <ros/console.h>
#include <utils_json.h>

namespace motion {

void ParseStationaryObjectConfig(
    const Json::Value &configJsonValue,
    StationaryObjectConfig &outputConfig)
{
    outputConfig.laneId = utils::GetDoubleJsonValue(
        configJsonValue["lane_id"]);
    outputConfig.pointId = utils::GetDoubleJsonValue(
        configJsonValue["point_id"]);
    outputConfig.offset.position.set_s(
        utils::GetDoubleJsonValue(configJsonValue["longitudinal_offset"]));
    outputConfig.offset.position.set_d(
        utils::GetDoubleJsonValue(configJsonValue["lateral_offset"]));
    outputConfig.offset.orientation = utils::GetDoubleJsonValue(
        utils::GetDoubleJsonValue(configJsonValue["orientation_offset"]));

    ROS_INFO_STREAM(outputConfig);
}

} // namespace motion {
