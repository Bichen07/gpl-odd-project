#ifndef _MOTION_WAYPOINT_SPEED_CONFIG_H_
#define _MOTION_WAYPOINT_SPEED_CONFIG_H_

#include <map_waypoint_id.h>
#include <jsoncpp/json/json.h>

namespace motion {

struct WaypointSpeedConfig final
{
    map::WaypointId waypointId;
    double speedMps;

    WaypointSpeedConfig()
        : waypointId{}
        , speedMps{0.0}
    {
    }
    explicit WaypointSpeedConfig(
        const map::WaypointId &inputWaypointId,
        const double inputSpeedMps)
        : waypointId{inputWaypointId}
        , speedMps{inputSpeedMps}
    {
    }
    WaypointSpeedConfig(const WaypointSpeedConfig &other) = default;
    WaypointSpeedConfig &operator=(const WaypointSpeedConfig &other) = default;
    ~WaypointSpeedConfig() = default;
};

void ParseWaypointSpeedConfig(
    const Json::Value &configJsonValue,
    WaypointSpeedConfig *outputConfig);

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const WaypointSpeedConfig &config)
{
    ostream << "[motion::WaypointSpeedConfig]" << '\n' <<
        "waypointId: " << config.waypointId << '\n' <<
        "speedMps: " << config.speedMps;
    return ostream;
}

} // namespace motion {

#endif // #ifndef _MOTION_WAYPOINT_SPEED_CONFIG_H_
