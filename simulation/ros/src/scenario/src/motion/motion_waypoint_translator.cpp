#include <motion_waypoint_translator.h>
#include <ros/console.h>
#include <math_utils.h>

namespace motion {

// public func.

WaypointTranslator::WaypointTranslator()
{
}

WaypointTranslator::~WaypointTranslator()
{
}

std::vector<math::Vector3d_t> WaypointTranslator::Compute(
    const std::vector<math::Vector3d_t> &inputWaypoints,
    const math::FrenetCoord &offset,
    const int32_t refWaypointIdx) const
{
    if (!this->IsValidWaypointIdx(inputWaypoints, refWaypointIdx))
    {
        return std::vector<math::Vector3d_t>();
    }

    const math::Vector3d_t longitudinalVector =
        (inputWaypoints.at(refWaypointIdx + 1) - inputWaypoints.at(refWaypointIdx)).normalized();
    const math::Vector3d_t lateralVector =
        math::AngleAxis_t(math::HalfPi<math::real_t>(), math::Vector3d_t::UnitZ()) *
        longitudinalVector;

    const math::Vector3d_t longitudinalOffset =
        longitudinalVector * offset.s();
    const math::Vector3d_t lateralOffset =
        lateralVector * offset.d();

    std::vector<math::Vector3d_t> outputWaypoints(inputWaypoints.size());
    auto outputWaypoint{outputWaypoints.begin()};
    for (const auto &inputWaypoint: inputWaypoints)
    {
        *outputWaypoint = inputWaypoint + longitudinalOffset + lateralOffset;
        ++outputWaypoint;
    }

    return outputWaypoints;
}

// protected func.

// private func.

bool WaypointTranslator::IsValidWaypointIdx(
    const std::vector<math::Vector3d_t> &inputWaypoints,
    const int32_t idx) const
{
    if (idx < 0)
    {
        ROS_ERROR_STREAM("invalid waypoint idx: " << idx);
        return false;
    }

    if (idx > static_cast<int32_t>(inputWaypoints.size() - 2ul))
    {
        ROS_ERROR_STREAM(
            "invalid waypoint idx: " << idx << '\n' <<
            "inputWaypoints size: " << inputWaypoints.size());
        return false;
    }

    return true;
}

} // namespace motion {
