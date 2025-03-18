#ifndef _MOTION_WAYPOINT_EVALUATOR_H_
#define _MOTION_WAYPOINT_EVALUATOR_H_

#include <math_type.h>
#include <math_frenet_transformer.h>

namespace motion {

class WaypointEvaluator final
{

public:

    WaypointEvaluator();
    explicit WaypointEvaluator(const std::vector<math::Vector3d_t> &refWaypoints);
    WaypointEvaluator(const WaypointEvaluator &) = delete;
    WaypointEvaluator &operator=(const WaypointEvaluator &) = delete;
    virtual ~WaypointEvaluator();

    void Configure(const std::vector<math::Vector3d_t> &refWaypoints);

    math::FrenetCoord ConvertToFrenetCoord(const math::Vector3d_t &point3d) const;
    math::Vector3d_t ConvertToCartesianCoord(const math::FrenetCoord &frenetCoord) const;
    std::vector<math::Vector3d_t> ExtractWaypoints(
        const math::real_t beginLongitudinalDistance) const;
    math::Vector3d_t ComputeForwardLookingTarget(
        const math::Vector3d_t &currentPosition,
        const math::real_t forwardLookingDistance) const;
    math::Vector3d_t ComputeForwardLookingTarget(
        const math::FrenetCoord &currentFrenetCoord,
        const math::real_t forwardLookingDistance) const;

protected:

private:

    math::real_t ComputeAverageHeight(const int32_t waypointIdx) const;

    std::vector<math::Vector3d_t> mRefWaypoint3ds;
    std::vector<math::Vector2d_t> mRefWaypoint2ds;
    math::FrenetTransformer mFrenetTransformer;
};

} // namespace motion {

#endif // #ifndef _MOTION_WAYPOINT_EVALUATOR_H_
