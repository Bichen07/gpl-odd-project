#include <motion_signalized_intersection_config.h>
#include <ros/console.h>
#include <utils_json.h>

namespace motion {

void ParseSignalizedIntersectionConfig(
    const Json::Value &configJsonValue,
    SignalizedIntersectionConfig &outputConfig)
{
    static constexpr const char *lateralLaneTrafficLightIdsKey{
        "lateral_lane_traffic_light_ids"};
    if (configJsonValue.isMember(lateralLaneTrafficLightIdsKey))
    {
        outputConfig.lateralLaneTrafficLightIds.resize(
            configJsonValue[lateralLaneTrafficLightIdsKey].size());
        auto trafficLightId{outputConfig.lateralLaneTrafficLightIds.begin()};
        for (const auto &trafficLightIdValue: configJsonValue[lateralLaneTrafficLightIdsKey])
        {
            *trafficLightId = utils::GetIntJsonValue(trafficLightIdValue);
            ++trafficLightId;
        }
    }

    ROS_INFO_STREAM(outputConfig);
}

} // namespace motion {
