#include <motion_route_moving_config.h>
#include <ros/console.h>
#include <utils_json.h>

namespace motion
{

    void ParseRouteMovingConfig(const Json::Value &configJsonValue, RouteMovingConfig &outputConfig)
    {
        outputConfig.vo0_kph = utils::GetDoubleJsonValue(configJsonValue["vo0_kph"]);
        outputConfig.dlon    = utils::GetDoubleJsonValue(configJsonValue["dlon"]);
        outputConfig.alpha   = utils::GetDoubleJsonValue(configJsonValue["alpha"]);
        outputConfig.beta    = utils::GetDoubleJsonValue(configJsonValue["beta"]);
        outputConfig.rho     = utils::GetDoubleJsonValue(configJsonValue["rho"]);

        ROS_INFO_STREAM(outputConfig);
    }

}  // namespace motion
