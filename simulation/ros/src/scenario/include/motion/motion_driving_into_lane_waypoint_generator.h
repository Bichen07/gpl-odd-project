#ifndef _MOTION_DRIVING_INTO_LANE_WAYPONIT_GENERATOR_H_
#define _MOTION_DRIVING_INTO_LANE_WAYPONIT_GENERATOR_H_

#include <math_type.h>
#include <math_frenet_coord.h>
#include <math_quadratic_bezier_curve.h>
#include <geometry_vector_3d.h>
#include <map_navigation_path.h>

namespace motion {

class DrivingIntoLaneWaypointGenerator final
{

public:

    DrivingIntoLaneWaypointGenerator();
    DrivingIntoLaneWaypointGenerator(const DrivingIntoLaneWaypointGenerator &) = delete;
    DrivingIntoLaneWaypointGenerator &operator=(const DrivingIntoLaneWaypointGenerator &) = delete;
    virtual ~DrivingIntoLaneWaypointGenerator() = default;

    const math::Vector3d_t &GetBeginPoint() const;
    const math::Vector3d_t &GetViaPoint() const;
    const math::Vector3d_t &GetEndPoint() const;

    std::vector<math::Vector3d_t> Compute(
        map::NavigationPath::Ptr &navigationPath,
        const int32_t refBeginLaneId,
        const int32_t refBeginPointId,
        const math::FrenetCoord &beginOffset,
        const math::real_t timeStep,
        const math::real_t speed);

protected:

private:

    map::NavigationPath::Ptr mNavigationPath;
    math::QuadraticBezierCurve mQuadraticBezierCurve;
    math::Vector3d_t mBeginPoint;
    math::Vector3d_t mViaPoint;
    math::Vector3d_t mEndPoint;
};

} // namespace motion {

#endif // #ifndef _MOTION_DRIVING_INTO_LANE_WAYPONIT_GENERATOR_H_
