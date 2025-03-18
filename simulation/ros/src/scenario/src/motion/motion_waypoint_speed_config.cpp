#include <motion_waypoint_speed_config.h>
#include <stdexcept>
#include <ros/console.h>
#include <utils_json.h>
#include <motion_utils.h>

namespace motion {

void ParseWaypointSpeedConfig(
    const Json::Value &configJsonValue,
    WaypointSpeedConfig *outputConfig)
{
    if (nullptr == outputConfig)
    {
        ROS_ERROR_STREAM("outputConfig is nullptr");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    outputConfig->waypointId.lane = utils::GetIntJsonValue(
        configJsonValue["lane_id"]);
    outputConfig->waypointId.point = utils::GetIntJsonValue(
        configJsonValue["point_id"]);
    outputConfig->speedMps = motion::ConvertToMps(
        utils::GetDoubleJsonValue(configJsonValue["speed_kph"]));
}

} // namespace motion {

