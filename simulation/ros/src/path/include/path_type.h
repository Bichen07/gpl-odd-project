#ifndef _PATH_TYPE_H_
#define _PATH_TYPE_H_

#include <geometry_vector_3d.h>
#include <path_route_waypoint.h>

namespace path {

typedef std::vector<geometry::Vector3d> Waypoints;
typedef std::vector<Waypoints> WaypointsArray;
typedef std::vector<RouteWaypoint> RouteWaypoints;
typedef std::vector<RouteWaypoints> RouteWaypointsArray;
typedef std::vector<int32_t> LaneIds;
typedef std::vector<LaneIds> LaneIdsArray;

} // namespace path {

#endif // #ifndef _PATH_TYPE_H_
