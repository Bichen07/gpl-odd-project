#include <motion_crosswalk_waypoint_generator.h>
#include <ros/console.h>
#include <math_utils.h>

namespace motion {

// public func.

CrosswalkWaypointGenerator::CrosswalkWaypointGenerator()
{
}

CrosswalkWaypointGenerator::~CrosswalkWaypointGenerator()
{
}

std::vector<math::Vector3d_t> CrosswalkWaypointGenerator::Compute(
    const math::real_t timeStep,
    const geometry::Edge3d &edge,
    const map::DirectionId &forwardDirection,
    const math::real_t lateralOffset,
    const math::real_t longitudinalExtendedDistance,
    const math::real_t speed) const
{
    const math::Vector2d_t edgeDirection2d(
        edge.GetDirection().x(),
        edge.GetDirection().y());
    const math::Vector2d_t edgeBeginPosition2d(
        edge.GetBeginPosition().x(),
        edge.GetBeginPosition().y());
    const math::Vector3d_t edgeEndPosition3d =
        edge.GetBeginPosition() + edge.GetDirection() * edge.GetNorm();
    const math::Vector2d_t lateralDirection2d =
        Eigen::Rotation2D<math::real_t>(math::HalfPi<math::real_t>()).toRotationMatrix() *
        edgeDirection2d;
    const math::Vector3d_t lateralDirection3d(
        lateralDirection2d.x(),
        lateralDirection2d.y(),
        0.0);

    const math::Vector3d_t beginWaypoint =
        edge.GetBeginPosition() -
        0.5 * longitudinalExtendedDistance * edge.GetDirection() +
        lateralOffset * lateralDirection3d;

    const int32_t waypointSize = static_cast<int32_t>(
        ceil(((edge.GetNorm() + longitudinalExtendedDistance) / speed) / timeStep));
    const math::real_t headingRadian = std::atan2(
        edge.GetDirection().y(),
        edge.GetDirection().x());
    const math::real_t distancePerStep = timeStep * speed;
    const auto planarEdgeDirection{
        math::Vector3d_t(edge.GetDirection().x(), edge.GetDirection().y(), 0.0)};
    std::vector<math::Vector3d_t> outputWaypoints(waypointSize);
    auto outputWaypoint{outputWaypoints.begin()};
    *outputWaypoint = beginWaypoint;
    ++outputWaypoint;

    while (outputWaypoint != outputWaypoints.end())
    {
        *outputWaypoint = *(outputWaypoint - 1) + distancePerStep * planarEdgeDirection;
        ++outputWaypoint;
    }

    if (map::Direction::Reverse == forwardDirection)
    {
        std::reverse(outputWaypoints.begin(), outputWaypoints.end());
    }

    return outputWaypoints;
}

// protected func.

// private func.

} // namespace motion {
