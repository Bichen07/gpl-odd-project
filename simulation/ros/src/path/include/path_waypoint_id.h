#ifndef _PATH_WAYPOINT_ID_H_
#define _PATH_WAYPOINT_ID_H_

#include <cstdint>
#include <iostream>
#include <path_msgs/WaypointId.h>

namespace path {

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
        const int32_t inputLaneId,
        const int32_t inputPointId)
        : lane{inputLaneId}
        , point{inputPointId}
    {
    }
    WaypointId(const WaypointId &other) = default;
    WaypointId &operator=(const WaypointId &other) = default;
    ~WaypointId() = default;
};

WaypointId ToWaypointId(const path_msgs::WaypointId &msg);

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const WaypointId &waypointId)
{
    ostream << "[path::WaypointId]" << '\n' <<
        "lane: " << waypointId.lane << '\n' <<
        "point: " << waypointId.point;
    return ostream;
}

} // namespace path {

#endif // #ifndef _PATH_WAYPOINT_ID_H_
