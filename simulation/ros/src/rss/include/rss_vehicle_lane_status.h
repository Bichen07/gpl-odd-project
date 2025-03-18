#ifndef _RSS_VEHICLE_LANE_STATUS_H_
#define _RSS_VEHICLE_LANE_STATUS_H_

#include <iostream>
#include <iomanip>

namespace rss {

struct VehicleLaneStatus final
{
    bool isOnSidewalk;
    bool isOnRouteableRoad;
    bool isOnIntersection;

    VehicleLaneStatus()
        : isOnSidewalk{false}
        , isOnRouteableRoad{false}
        , isOnIntersection{false}
    {
    }
    VehicleLaneStatus(
        const bool inputOnSidewalk,
        const bool inputOnRouteableRoad,
        const bool inputOnIntersection)
        : isOnSidewalk{inputOnSidewalk}
        , isOnRouteableRoad{inputOnRouteableRoad}
        , isOnIntersection{inputOnIntersection}
    {
    }
    VehicleLaneStatus(const VehicleLaneStatus &other) = default;
    VehicleLaneStatus &operator=(const VehicleLaneStatus &other) = default;
    ~VehicleLaneStatus() = default;
};

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const VehicleLaneStatus &status)
{
    ostream << std::boolalpha <<
        "[VehicleLaneStatus]" << '\n' <<
        "isOnSidewalk: " << status.isOnSidewalk << '\n' <<
        "isOnRouteableRoad: " << status.isOnRouteableRoad << '\n' <<
        "isOnIntersection: " << status.isOnIntersection;
    return ostream;
}

} // namespace rss {

#endif // #ifndef _RSS_VEHICLE_LANE_STATUS_H_
