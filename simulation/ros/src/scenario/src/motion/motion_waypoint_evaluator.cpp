#include <motion_waypoint_evaluator.h>
#include <stdexcept>
#include <ros/console.h>
#include <math_utils.h>

namespace motion {

// public func.

WaypointEvaluator::WaypointEvaluator()
    : mRefWaypoint3ds{}
    , mRefWaypoint2ds{}
    , mFrenetTransformer{}
{
}

WaypointEvaluator::WaypointEvaluator(const std::vector<math::Vector3d_t> &refWaypoints)
    : mRefWaypoint3ds{}
    , mRefWaypoint2ds{}
    , mFrenetTransformer{}
{
    this->Configure(refWaypoints);
}

WaypointEvaluator::~WaypointEvaluator()
{
}

void WaypointEvaluator::Configure(const std::vector<math::Vector3d_t> &refWaypoints)
{
    mRefWaypoint3ds = refWaypoints;
    mRefWaypoint2ds.resize(mRefWaypoint3ds.size());
    std::transform(
        mRefWaypoint3ds.begin(),
        mRefWaypoint3ds.end(),
        mRefWaypoint2ds.begin(),
        [](const math::Vector3d_t &waypoint3d)
        {return math::Vector2d_t(waypoint3d.x(), waypoint3d.y());});
    mFrenetTransformer.Configure(
        mRefWaypoint2ds,
        utils::FileLineNumPairInstance());
}

math::FrenetCoord WaypointEvaluator::ConvertToFrenetCoord(
    const math::Vector3d_t &point3d) const
{
    return mFrenetTransformer.ConvertToFrenetCoord(
        math::Vector2d_t(point3d.x(), point3d.y()));
}

math::Vector3d_t WaypointEvaluator::ConvertToCartesianCoord(
    const math::FrenetCoord &frenetCoord) const
{
    const int32_t waypointIdx = mFrenetTransformer.ComputeWaypointIdx(frenetCoord);
    const math::Vector2d_t outputPoint2d =
        mFrenetTransformer.ConvertToCartesianCoord(waypointIdx, frenetCoord);
    return math::Vector3d_t(
        outputPoint2d.x(),
        outputPoint2d.y(),
        this->ComputeAverageHeight(waypointIdx));
}

std::vector<math::Vector3d_t> WaypointEvaluator::ExtractWaypoints(
    const math::real_t beginLongitudinalDistance) const
{
    if (beginLongitudinalDistance < 0.0)
    {
        ROS_ERROR_STREAM(
            "invalid beginLongitudinalDistance < 0.0: " << beginLongitudinalDistance);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }
    const math::FrenetCoord inputFrenetCoord(beginLongitudinalDistance, 0.0);
    const int32_t waypointIdx =
        mFrenetTransformer.ComputeWaypointIdx(inputFrenetCoord);
    const math::Vector2d_t beginWaypoint2d =
        mFrenetTransformer.ConvertToCartesianCoord(
            waypointIdx,
            inputFrenetCoord);
    const math::Vector3d_t beginWaypoint3d(
        beginWaypoint2d.x(),
        beginWaypoint2d.y(),
        this->ComputeAverageHeight(waypointIdx));
    std::vector<math::Vector3d_t> outputWaypoints(
        mRefWaypoint3ds.size() - static_cast<std::size_t>(waypointIdx));
    auto outputWaypoint{outputWaypoints.begin()};
    *outputWaypoint = beginWaypoint3d;
    ++outputWaypoint;
    for (; outputWaypoint != outputWaypoints.end(); ++outputWaypoint)
    {
        const int32_t idx = std::distance(
            outputWaypoints.begin(),
            outputWaypoint);
        *outputWaypoint = mRefWaypoint3ds.at(idx + waypointIdx);
    }

    return outputWaypoints;
}

math::Vector3d_t WaypointEvaluator::ComputeForwardLookingTarget(
    const math::Vector3d_t &currentPosition,
    const math::real_t forwardLookingDistance) const
{
    const auto currentFrenetCoord{
        this->ConvertToFrenetCoord(currentPosition)};
    return this->ComputeForwardLookingTarget(
        currentFrenetCoord,
        forwardLookingDistance);
}

math::Vector3d_t WaypointEvaluator::ComputeForwardLookingTarget(
    const math::FrenetCoord &currentFrenetCoord,
    const math::real_t forwardLookingDistance) const
{
    if (forwardLookingDistance < 0.0)
    {
        ROS_ERROR_STREAM("invalid forwardLookingDistance: " << forwardLookingDistance);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    const math::FrenetCoord inputFrenetCoord(
        currentFrenetCoord.s() + forwardLookingDistance,
        math::real_t{0.0});
    const int32_t forwardLookingWaypointIdx{
        mFrenetTransformer.ComputeWaypointIdx(inputFrenetCoord)};
    const math::Vector2d_t forwardLookingWaypoint2d =
        mFrenetTransformer.ConvertToCartesianCoord(
            forwardLookingWaypointIdx,
            inputFrenetCoord);
    const math::Vector3d_t forwardLookingWaypoint3d(
        forwardLookingWaypoint2d.x(),
        forwardLookingWaypoint2d.y(),
        this->ComputeAverageHeight(forwardLookingWaypointIdx));

    return forwardLookingWaypoint3d;
}

// protected func.

// private func.

math::real_t WaypointEvaluator::ComputeAverageHeight(const int32_t waypointIdx) const
{
    if (0 == waypointIdx)
    {
        return mRefWaypoint3ds.front().z();
    }

    if (waypointIdx < 0)
    {
        ROS_ERROR_STREAM("invalid waypointIdx: " << waypointIdx);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }
    
    if (waypointIdx > static_cast<int32_t>(mRefWaypoint3ds.size() -1ul))
    {
        ROS_ERROR_STREAM(
            "invalid waypointIdx: " << waypointIdx << '\n' <<
            "mRefWaypoint3ds size: " << mRefWaypoint3ds.size());
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    if (static_cast<int32_t>(mRefWaypoint3ds.size() - 1ul) == waypointIdx)
    {
        return mRefWaypoint3ds.back().z();
    }

    return 0.5 * (mRefWaypoint3ds.at(waypointIdx - int32_t{1}).z() + mRefWaypoint3ds.at(waypointIdx).z());
}

} // namespace motion {
