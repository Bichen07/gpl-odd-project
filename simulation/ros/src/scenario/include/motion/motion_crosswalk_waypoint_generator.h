#ifndef _MOTION_CROSSWALK_WAYPOINT_GENERATOR_H_
#define _MOTION_CROSSWALK_WAYPOINT_GENERATOR_H_

#include <math_type.h>
#include <geometry_type.h>
#include <map_type.h>

namespace motion {

class CrosswalkWaypointGenerator final
{

public:

    CrosswalkWaypointGenerator();
    CrosswalkWaypointGenerator(const CrosswalkWaypointGenerator &) = delete;
    CrosswalkWaypointGenerator &operator=(const CrosswalkWaypointGenerator &) = delete;
    virtual ~CrosswalkWaypointGenerator();

    std::vector<math::Vector3d_t> Compute(
        const math::real_t timeStep,
        const geometry::Edge3d &edge,
        const map::DirectionId &forwardDirection,
        const math::real_t lateralOffset,
        const math::real_t longitudinalExtendedDistance,
        const math::real_t speed) const;

protected:

private:

};

} // namespace motion {

#endif // #ifndef _MOTION_CROSSWALK_WAYPOINT_GENERATOR_H_
