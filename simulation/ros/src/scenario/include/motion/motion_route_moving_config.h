#ifndef _MOTION_ROUTE_MOVING_CONFIG_H_
#define _MOTION_ROUTE_MOVING_CONFIG_H_

#include <iostream>
#include <iterator>
#include <jsoncpp/json/json.h>
#include <motion_waypoint_speed_config.h>

namespace motion
{

    struct RouteMovingConfig final
    {
        double dlon;
        double vo0_kph;
        double alpha;
        double beta;
        double rho;

        RouteMovingConfig()                                          = default;
        RouteMovingConfig(const RouteMovingConfig &other)            = default;
        RouteMovingConfig &operator=(const RouteMovingConfig &other) = default;
        ~RouteMovingConfig()                                         = default;
    };

    void ParseRouteMovingConfig(const Json::Value &configJsonValue, RouteMovingConfig &outputconfig);

    template <typename charT, typename traits>
    std::basic_ostream<charT, traits> &operator<<(std::basic_ostream<charT, traits> &ostream, const RouteMovingConfig &config)
    {
        ostream << "[motion::RouteMovingConfig]" << '\n'
                << "dlon: " << config.dlon << '\n'
                << "vo0_kph: " << config.vo0_kph << '\n'
                << "alpha: " << config.alpha << '\n'
                << "beta: " << config.beta << '\n'
                << "rho: " << config.rho << '\n';
        return ostream;
    }

}  // namespace motion

#endif  // #ifndef _MOTION_ROUTE_MOVING_CONFIG_H_
