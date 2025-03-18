#include <motion_alks_cut_in_config.h>
#include <ros/console.h>
#include <utils_json.h>

namespace motion
{

    void ParseAlksCutInConfig(const Json::Value& configJsonValue, AlksCutInConfig& outputConfig)
    {
        outputConfig.begin_lane_id  = utils::GetIntJsonValue(configJsonValue["begin_lane_id"]);
        outputConfig.begin_point_id = utils::GetIntJsonValue(configJsonValue["begin_point_id"]);
        outputConfig.end_lane_id    = utils::GetIntJsonValue(configJsonValue["end_lane_id"]);
        outputConfig.end_point_id   = utils::GetIntJsonValue(configJsonValue["end_point_id"]);
        outputConfig.delay_seconds  = utils::GetDoubleJsonValue(configJsonValue["delay_seconds"]);

        outputConfig.ve0_kph = utils::GetDoubleJsonValue(configJsonValue["ve0_kph"]);
        outputConfig.vo0_kph = utils::GetDoubleJsonValue(configJsonValue["vo0_kph"]);
        outputConfig.dx0_m   = utils::GetDoubleJsonValue(configJsonValue["dx0_m"]);
        outputConfig.dy0_m   = utils::GetDoubleJsonValue(configJsonValue["dy0_m"]);
        outputConfig.vy_mps  = utils::GetDoubleJsonValue(configJsonValue["vy_mps"]);

        ROS_INFO_STREAM(outputConfig);
    }

}  // namespace motion
