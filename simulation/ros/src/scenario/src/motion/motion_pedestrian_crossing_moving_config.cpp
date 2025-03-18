#include <motion_pedestrian_crossing_moving_config.h>
#include <stdexcept>
#include <ros/console.h>
#include <utils_json.h>
#include <map_utils.h>
#include <motion_utils.h>

namespace motion {

void ParsePedestrianCrossingMovingConfig(
    const Json::Value &configJsonValue,
    PedestrianCrossingMovingConfig *outputConfig)
{
    if (nullptr == outputConfig)
    {
        ROS_ERROR_STREAM("outputConfig is nullptr");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    outputConfig->crosswalkId = configJsonValue["crosswalk_id"].asInt();
    outputConfig->crosswalkEdgeId = configJsonValue["crosswalk_edge_id"].asInt();
    outputConfig->forwardDirection = map::QueryDirectionId(
        configJsonValue["forward_direction"].asString());
    outputConfig->lateralOffsetToEdge = configJsonValue["lateral_offset_to_edge"].asDouble();
    outputConfig->longitudinalExtendedDistance = configJsonValue["longitudinal_extended_distance"].asDouble();
    outputConfig->speedMps = motion::ConvertToMps(configJsonValue["speed_kph"].asDouble());
    outputConfig->pedestrianMoveTriggerDistance =
        utils::GetDoubleJsonValue(configJsonValue["pedestrian_move_trigger_distance"]);

    ROS_INFO_STREAM(*outputConfig);
}

} // namespace motion {
