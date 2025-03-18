#ifndef _MAP_WAYPOINT_ID_H_
#define _MAP_WAYPOINT_ID_H_

#include <cstdint>
#include <iostream>
#include <jsoncpp/json/json.h>

namespace map {

struct WaypointId final
{
    int32_t lane;
    int32_t point;

    WaypointId()
        : lane{0}
        , point{0}
    {
    }
    explicit WaypointId(
        const int32_t inputLane,
        const int32_t inputPoint)
        : lane{inputLane}
        , point{inputPoint}
    {
    }
    WaypointId(const WaypointId &other) = default;
    WaypointId &operator=(const WaypointId &other) = default;
    ~WaypointId() = default;
};

void ParseWaypointId(
    const Json::Value &configJsonValue,
    map::WaypointId &outputWaypointId);

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const WaypointId &waypointId)
{
    ostream << "[map::WaypointId]" << '\n' <<
        "lane: " << waypointId.lane <<
        ", point: " << waypointId.point;
    return ostream;
}

} // namespace map {

#endif // #ifndef _MAP_WAYPOINT_ID_H_
