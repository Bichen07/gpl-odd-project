#ifndef _PATH_DIJKSTRA_INTERPOLATION_PLANNER_H_
#define _PATH_DIJKSTRA_INTERPOLATION_PLANNER_H_

#include <vector>
#include <path_dijkstra_planner.h>
#include <path_lane_pair.h>
#include <path_lane_pair_planned_output.h>
#include <path_waypoint_id.h>
#include <path_waypoint_manager.h>
#include <math_quadratic_bezier_curve.h>

namespace path {

class DijkstraInterpolationPlanner final
{

public:

    DijkstraInterpolationPlanner();
    DijkstraInterpolationPlanner(const DijkstraInterpolationPlanner &) = delete;
    DijkstraInterpolationPlanner &operator=(const DijkstraInterpolationPlanner &) = delete;
    virtual ~DijkstraInterpolationPlanner() = default;

    void Configure(
        const std::string &lanesInfoFileName,
        const std::string &waypointFileName);

    void Compute(
        const WaypointId &beginWaypointId,
        const std::vector<LanePair> &lanePairs,
        const WaypointId &endWaypointId,
        std::vector<LanePairPlannedOutput> &plannedOutputs);

protected:

private:

    void QueryWaypoints(
        const LaneIds &laneIds,
        WaypointsArray &outputWaypointsArray);
    void QueryWaypoints(
        const int32_t beginPointId,
        const LaneIds &laneIds,
        WaypointsArray &outputWaypointsArray);
    void QueryWaypoints(
        const LaneIds &laneIds,
        const int32_t endPointId,
        WaypointsArray &outputWaypointsArray);
    void ComputeInterpolatedWaypoints(
        const LanePair &lanePair,
        Waypoints &outputWaypoints);
    void ComputeLinearInterpolationWaypoints(
        const LanePair &lanePair,
        Waypoints &outputWaypoints) const;
    void ComputeQuadraticBezierWaypoints(
        const LanePair &lanePair,
        Waypoints &outputWaypoints) const;

    DijkstraPlanner mDijkstraPlanner;
    WaypointManager mWaypointManager;
    math::QuadraticBezierCurve mQuadraticBezierCurve;
};

} // namespace path {

#endif // #ifndef _PATH_DIJKSTRA_INTERPOLATION_PLANNER_H_
