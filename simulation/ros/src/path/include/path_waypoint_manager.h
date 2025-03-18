#ifndef _PATH_WAYPOINT_MANAGER_H_
#define _PATH_WAYPOINT_MANAGER_H_

#include <string>
#include <utility>
#include <geometry_vector_3d.h>
#include <path_type.h>
#include <path_route_waypoint.h>
#include <path_waypoint_id.h>
#include <path_type.h>

namespace path {

class WaypointManager final
{

public:

    WaypointManager();
    WaypointManager(const WaypointManager &) = delete;
    WaypointManager &operator=(const WaypointManager &) = delete;
    virtual ~WaypointManager() = default;

    int32_t QueryEndPointId(const int32_t laneId) const;
    const LaneIds &QueryNextLaneIds(const int32_t givenLaneId) const;
    RouteWaypoint QueryRouteWaypoint(const WaypointId &waypointId) const;
    RouteWaypoints QueryRouteWaypoints(const int32_t laneId) const;
    RouteWaypoints QueryRouteWaypoints(
        const std::vector<int32_t> &connectedLaneIds) const;
    geometry::Vector3d QueryWaypoint(const WaypointId &waypointId) const;
    Waypoints QueryWaypoints(const int32_t laneId) const;
    Waypoints QueryWaypoints(
        const int32_t laneId,
        const int32_t beginPointId,
        const int32_t endPointId) const;
    Waypoints QueryWaypoints(
        const LaneIds &connectedLaneIds) const;
    Waypoints QueryWaypoints(
        const LaneIds &connectedLaneIds,
        const int32_t beginPointId,
        const int32_t endPointId) const;
    bool IsConnectedLaneIds(
        const int32_t precedingLaneId,
        const int32_t succeedingLaneId) const;
    bool IsConnectedLaneIds(const LaneIds &laneIdSequence) const;

    void Configure(const std::string &waypointFileName);
    void Configure(
        const std::string &waypointFileName,
        const std::string &lanesInfoFileName);

protected:

private:

    using IndexedRouteWaypoint = std::pair<int32_t, RouteWaypoint>; // <point-id, route-waypoint>
    using IndexedRouteWaypointMap = std::map<int32_t, std::vector<IndexedRouteWaypoint>>; // <lane-id, indexed-route-waypoints>

    void ParseWaypoints(const std::string &waypointFileName);
    void ParseLanesInfo(const std::string &lanesInfoFileName);
    void ValidatePointId(const int32_t laneId, const int32_t pointId) const;

    std::map<int32_t, Waypoints> mWaypointMap;
    std::map<int32_t, LaneIds> mConnectedLaneIdMap;
    std::map<int32_t, std::vector<RouteWaypoint>> mRouteWaypointMap;
    IndexedRouteWaypointMap mIndexedRouteWaypointMap;
};

} // namespace path {

#endif // #ifndef _PATH_WAYPOINT_MANAGER_H_
