#include <motion_driving_into_lane_waypoint_generator.h>
#include <stdexcept>
#include <ros/console.h>
#include <math_utils.h>

namespace motion {

// public func.

DrivingIntoLaneWaypointGenerator::DrivingIntoLaneWaypointGenerator()
    : mQuadraticBezierCurve{}
    , mBeginPoint{}
    , mViaPoint{}
    , mEndPoint{}
{
}

const math::Vector3d_t &DrivingIntoLaneWaypointGenerator::GetBeginPoint() const
{
    return mBeginPoint;
}

const math::Vector3d_t &DrivingIntoLaneWaypointGenerator::GetViaPoint() const
{
    return mViaPoint;
}

const math::Vector3d_t &DrivingIntoLaneWaypointGenerator::GetEndPoint() const
{
    return mEndPoint;
}

std::vector<math::Vector3d_t> DrivingIntoLaneWaypointGenerator::Compute(
        map::NavigationPath::Ptr &navigationPath,
        const int32_t refBeginLaneId,
        const int32_t refBeginPointId,
        const math::FrenetCoord &beginOffset,
        const math::real_t timeStep,
        const math::real_t speed)
{
    const auto refBeginRouteWaypoint{
        navigationPath->QueryRouteWaypoint(
            refBeginLaneId,
            refBeginPointId)};
    const math::Vector3d_t longitudinalVector(
        std::cos(refBeginRouteWaypoint.angle),
        std::sin(refBeginRouteWaypoint.angle),
        double{0.0});
    const math::Vector3d_t lateralVector{
        math::AngleAxis_t(math::HalfPi<double>(), math::Vector3d_t::UnitZ()) *
        longitudinalVector};
    const math::Vector3d_t refBeginWaypoint(
        refBeginRouteWaypoint.point.x,
        refBeginRouteWaypoint.point.y,
        refBeginRouteWaypoint.point.z);
    const math::Vector3d_t longitudinalOffset{beginOffset.s() * longitudinalVector};
    const math::Vector3d_t lateralOffset{beginOffset.d() * lateralVector};
    mEndPoint = math::Vector3d_t(
        refBeginRouteWaypoint.point.x,
        refBeginRouteWaypoint.point.y,
        refBeginRouteWaypoint.point.z);
    mBeginPoint = refBeginWaypoint + longitudinalOffset + lateralOffset;
    const double approxCutInDistance = std::hypot(beginOffset.s(), beginOffset.d());

    const int32_t curveSize = boost::numeric_cast<int32_t>(
        std::ceil((approxCutInDistance / speed) / timeStep)) * 2;

    if (curveSize <= int32_t{0})
    {
        ROS_ERROR_STREAM("invalid curveSize: " << curveSize);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    mViaPoint =
        refBeginWaypoint + 1.0 * longitudinalOffset - 0.05 * lateralOffset;

    const std::vector<math::Vector3d_t> cutInWaypoints{
        mQuadraticBezierCurve.Compute(
            mBeginPoint,
            mViaPoint,
            refBeginWaypoint,
            curveSize)};

    return cutInWaypoints;
}

// protected func.

// private func.

} // namespace motion {
