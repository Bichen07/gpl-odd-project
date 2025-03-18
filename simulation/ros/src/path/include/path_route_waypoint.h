#ifndef _PATH_ROUTE_WAYPOINT_H_
#define _PATH_ROUTE_WAYPOINT_H_

#include <iostream>
#include <geometry_vector_3d.h>

namespace path {

struct RouteWaypoint final
{
    geometry::Vector3d point;
    double angle;
    double leftBoundary;
    double rightBoundary;
    double curvature;
    double slope;

    RouteWaypoint()
        : point{}
        , angle{0.0}
        , leftBoundary{0.0}
        , rightBoundary{0.0}
        , curvature{0.0}
        , slope{0.0}
    {
    }
    explicit RouteWaypoint(
        const geometry::Vector3d &inputPoint,
        const double inputAngle,
        const double inputLeftBoundary,
        const double inputRightBoundary,
        const double inputCurvature,
        const double inputSlope)
        : point{inputPoint}
        , angle{inputAngle}
        , leftBoundary{inputLeftBoundary}
        , rightBoundary{inputRightBoundary}
        , curvature{inputCurvature}
        , slope{inputSlope}
    {
    }
    RouteWaypoint(const RouteWaypoint &other) = default;
    RouteWaypoint &operator=(const RouteWaypoint &other) = default;
    ~RouteWaypoint() = default;
};

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const RouteWaypoint &routeWaypoint)
{
    ostream << "[path::RouteWaypoint]" << '\n' <<
        "point: " << routeWaypoint.point.transpose() << '\n' <<
        "angle: " << routeWaypoint.angle;
    return ostream;
}

} // namespace path {

#endif // #ifndef _PATH_ROUTE_WAYPOINT_H_
