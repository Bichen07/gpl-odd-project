#ifndef _MAP_WAYPOINT_MANAGER_H_
#define _MAP_WAYPOINT_MANAGER_H_

#include <string>
#include <math_type.h>

namespace map {

class WaypointManager final
{

public:

    WaypointManager();
    WaypointManager(const WaypointManager &) = delete;
    WaypointManager &operator=(const WaypointManager &) = delete;
    virtual ~WaypointManager();

    const std::vector<math::Vector3d_t> &GetCubicSplineControlPoints() const;

    std::vector<math::Vector3d_t> QueryWaypoints(const int32_t laneId) const;
    std::vector<math::Vector3d_t> QueryWaypoints(
        const int32_t laneId,
        const int32_t beginPointId,
        const int32_t endPointId) const;
    std::vector<math::Vector3d_t> QueryWaypoints(
        const std::vector<int32_t> &connectedLaneIds) const;
    std::vector<math::Vector3d_t> QueryWaypoints(
        const std::vector<int32_t> &connectedLaneIds,
        const int32_t beginPointId,
        const int32_t endPointId) const;
    std::vector<math::Vector3d_t> QueryWaypoints(
        const std::vector<int32_t> &precedingLaneIds,
        const std::vector<int32_t> &succeedingLaneIds,
        const int32_t beginPointId,
        const int32_t endPointId);
    std::vector<int32_t> QueryNextConnectedLaneIds(const int32_t laneId) const;
    bool IsConnectedLaneIds(
        const int32_t precedingLaneId,
        const int32_t succeedingLaneId) const;
    bool IsConnectedLaneIds(const std::vector<int32_t> &laneIdSequence) const;

    void Configure(const std::string &waypointFileName);
    void Configure(
        const std::string &waypointFileName,
        const std::string &lanesInfoFileName);

protected:

private:

    void ParseWaypoints(const std::string &waypointFileName);
    void ParseLanesInfo(const std::string &lanesInfoFileName);
    int32_t QueryEndPointId(const int32_t laneId) const;
    std::vector<math::Vector3d_t> GenerateConnectedWaypoints(
        const std::vector<int32_t> &precedingLaneIds,
        const int32_t precedingBeginPointId,
        const std::vector<int32_t> &succeedingLaneIds,
        const int32_t succeedingEndPointId);
    void ValidatePointId(const int32_t laneId, const int32_t pointId) const;

    std::map<int32_t, std::vector<math::Vector3d_t>> mWaypointMap;
    std::map<int32_t, std::vector<int32_t>> mConnectedLaneIdMap;

    std::vector<math::Vector3d_t> mCubicSplineControlPoints;
};

} // namespace map {

#endif // #ifndef _MAP_WAYPOINT_MANAGER_H_
