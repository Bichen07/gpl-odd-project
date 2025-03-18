#include <motion_driving_into_lane_config.h>
#include <stdexcept>
#include <ros/console.h>
#include <utils_json.h>
#include <motion_utils.h>

namespace motion {

void ParseDrivingIntoLaneConfig(
    const Json::Value &configJsonValue,
    DrivingIntoLaneConfig &outputConfig)
{
    const char *laneIdKey{"lane_ids"};
    if (!configJsonValue.isMember(laneIdKey))
    {
        ROS_ERROR_STREAM("invalid key: " << laneIdKey);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    outputConfig.laneIds.resize(configJsonValue[laneIdKey].size());
    auto laneId{outputConfig.laneIds.begin()};
    for (const auto &laneIdValue: configJsonValue[laneIdKey])
    {
        *laneId = utils::GetIntJsonValue(laneIdValue);
        ++laneId;
    }
    outputConfig.beginPointId = utils::GetIntJsonValue(
        configJsonValue["begin_point_id"]);
    outputConfig.endPointId = utils::GetIntJsonValue(
        configJsonValue["end_point_id"]);
    outputConfig.beginOffset = math::FrenetCoord(
        utils::GetDoubleJsonValue(configJsonValue["begin_offset_s"]),
        utils::GetDoubleJsonValue(configJsonValue["begin_offset_d"]));
    outputConfig.initMovingSpeedMps = motion::ConvertToMps(
        utils::GetDoubleJsonValue(configJsonValue["init_moving_speed_kph"]));
    outputConfig.moveTriggerDistance = utils::GetDoubleJsonValue(
        configJsonValue["move_trigger_distance"]);
    outputConfig.beginExtendedDistance = utils::GetDoubleJsonValue(
        configJsonValue["begin_extended_distance"]);
    outputConfig.beginExtendedRadian = utils::GetDoubleJsonValue(
        configJsonValue["begin_extended_radian"]);

    ROS_INFO_STREAM(outputConfig);
}

} // namespace motion {
