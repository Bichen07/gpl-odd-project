#include <motion_constant_velocity_config.h>
#include <ros/console.h>
#include <utils_json.h>

namespace motion {

void
ParseConstantVelocityConfig(const Json::Value& configJsonValue,
                            ConstantVelocityConfig& outputConfig)
{
    outputConfig.longitudinalOffsetRatio =
      utils::GetDoubleJsonValue(configJsonValue["longitudinal_offset_ratio"]);
    outputConfig.lateralOffsetRatio =
      utils::GetDoubleJsonValue(configJsonValue["lateral_offset_ratio"]);
    outputConfig.longitudinalOffset =
      utils::GetDoubleJsonValue(configJsonValue["longitudinal_offset"]);
    outputConfig.lateralOffset =
      utils::GetDoubleJsonValue(configJsonValue["lateral_offset"]);
    outputConfig.agentSpeedKph =
      utils::GetDoubleJsonValue(configJsonValue["agent_speed_kph"]);
    outputConfig.agentHeadingDegrees =
      utils::GetDoubleJsonValue(configJsonValue["agent_heading_degrees"]);
    outputConfig.egoSpeedKph =
      utils::GetDoubleJsonValue(configJsonValue["ego_speed_kph"]);
    outputConfig.beginLaneId =
      utils::GetIntJsonValue(configJsonValue["begin_lane_id"]);
    outputConfig.beginPointId =
      utils::GetIntJsonValue(configJsonValue["begin_point_id"]);
    outputConfig.endLaneId =
      utils::GetIntJsonValue(configJsonValue["end_lane_id"]);
    outputConfig.endPointId =
      utils::GetIntJsonValue(configJsonValue["end_point_id"]);

    ROS_INFO_STREAM(outputConfig);
}

} // namespace motion
