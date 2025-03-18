#ifndef _MOTION_WAYPOINT_SMOOTHER_H_
#define _MOTION_WAYPOINT_SMOOTHER_H_

#include <math_type.h>

namespace motion {

class WaypointSmoother
{
    static constexpr math::real_t DefaultDistanceThreshold()
    {return math::real_t{0.2};}

public:

    WaypointSmoother();
    WaypointSmoother(const WaypointSmoother &) = delete;
    WaypointSmoother &operator=(const WaypointSmoother &) = delete;
    virtual ~WaypointSmoother();

    std::vector<math::Vector3d_t> Compute(
        const std::vector<math::Vector3d_t> &refWaypoint3ds,
        const math::real_t distanceThreshold = DefaultDistanceThreshold());

protected:

private:

};

} // namespace motion {

#endif // #ifndef _MOTION_WAYPOINT_SMOOTHER_H_
