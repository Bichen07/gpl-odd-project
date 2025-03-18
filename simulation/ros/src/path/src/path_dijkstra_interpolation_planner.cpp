#include <path_dijkstra_interpolation_planner.h>
#include <ros/console.h>
#include <math_utils.h>

namespace path {

// public func.

DijkstraInterpolationPlanner::DijkstraInterpolationPlanner()
    : mDijkstraPlanner{}
    , mWaypointManager{}
    , mQuadraticBezierCurve{}
{
}

void DijkstraInterpolationPlanner::Configure(
    const std::string &lanesInfoFileName,
    const std::string &waypointFileName)
{
    mDijkstraPlanner.Configure(lanesInfoFileName);
    mWaypointManager.Configure(
        waypointFileName,
        lanesInfoFileName);
}

void DijkstraInterpolationPlanner::Compute(
    const WaypointId &beginWaypointId,
    const std::vector<LanePair> &lanePairs,
    const WaypointId &endWaypointId,
    std::vector<LanePairPlannedOutput> &plannedOutputs)
{
    if (lanePairs.empty())
    {
        ROS_WARN_STREAM("lanePairs is empty");
        return;
    }

    plannedOutputs.resize(lanePairs.size());
    auto input{lanePairs.cbegin()};
    auto output{plannedOutputs.begin()};
    for (; input != lanePairs.cend(); ++input, ++output)
    {
        if (Interpolator::Null == input->interpolatorId)
        {
            LaneIds plannedLaneIds;
            mDijkstraPlanner.Compute(
                input->beginLaneId,
                input->endLaneId,
                output->plannedLaneIds);
            if (beginWaypointId.lane == input->beginLaneId)
            {
                this->QueryWaypoints(
                    beginWaypointId.point,
                    output->plannedLaneIds,
                    output->plannedWaypointsArray);
            }
            else if (endWaypointId.lane == input->endLaneId)
            {
                this->QueryWaypoints(
                    output->plannedLaneIds,
                    endWaypointId.point,
                    output->plannedWaypointsArray);
            }
            else
            {
                this->QueryWaypoints(
                    output->plannedLaneIds,
                    output->plannedWaypointsArray);
            }
        }
        else
        {
            output->plannedWaypointsArray.resize(std::size_t{1ul});
            Waypoints plannedWaypoints;
            this->ComputeInterpolatedWaypoints(
                *input,
                *output->plannedWaypointsArray.begin());
        }
    }
}

// protected func.

// private func.

void DijkstraInterpolationPlanner::QueryWaypoints(
    const LaneIds &laneIds,
    WaypointsArray &outputWaypointsArray)
{
    outputWaypointsArray.resize(laneIds.size());
    auto laneId{laneIds.cbegin()};
    auto outputWaypoints{outputWaypointsArray.begin()};
    for (; laneId != laneIds.cend(); ++laneId, ++outputWaypoints)
    {
        *outputWaypoints = mWaypointManager.QueryWaypoints(*laneId);
    }
}

void DijkstraInterpolationPlanner::QueryWaypoints(
    const int32_t beginPointId,
    const LaneIds &laneIds,
    WaypointsArray &outputWaypointsArray)
{
    outputWaypointsArray.resize(laneIds.size());
    auto laneId{laneIds.cbegin()};
    auto outputWaypoints{outputWaypointsArray.begin()};
    const int32_t endPointId{
        mWaypointManager.QueryEndPointId(laneIds.front())};
    *outputWaypoints = mWaypointManager.QueryWaypoints(
        *laneId,
        int32_t{1},
        endPointId);
    ++laneId;
    ++outputWaypoints;

    for (; laneId != laneIds.cend(); ++laneId, ++outputWaypoints)
    {
        *outputWaypoints = mWaypointManager.QueryWaypoints(*laneId);
    }
}

void DijkstraInterpolationPlanner::QueryWaypoints(
    const LaneIds &laneIds,
    const int32_t endPointId,
    WaypointsArray &outputWaypointsArray)
{
    outputWaypointsArray.resize(laneIds.size());
    auto laneId{laneIds.cbegin()};
    auto outputWaypoints{outputWaypointsArray.begin()};
    for (; laneId != laneIds.cend() - 1; ++laneId, ++outputWaypoints)
    {
        *outputWaypoints = mWaypointManager.QueryWaypoints(*laneId);
    }

    *outputWaypoints = mWaypointManager.QueryWaypoints(
        *laneId,
        int32_t{1},
        endPointId);
}

void DijkstraInterpolationPlanner::ComputeInterpolatedWaypoints(
    const LanePair &lanePair,
    Waypoints &outputWaypoints)
{
    if (Interpolator::Linear == lanePair.interpolatorId)
    {
        if (std::size_t{2ul} != lanePair.controlPoints.size())
        {
            ROS_ERROR_STREAM(
                "invalid control point size: " << lanePair.controlPoints.size() <<
                " for linear interpolation");
            throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
        }

        this->ComputeLinearInterpolationWaypoints(
            lanePair,
            outputWaypoints);
    }
    else if (Interpolator::QuadraticBezier == lanePair.interpolatorId)
    {
        if (lanePair.controlPoints.size() < std::size_t{3ul})
        {
            ROS_ERROR_STREAM(
                "invalid control point size: " << lanePair.controlPoints.size() <<
                " for Quadratic Bezier curve");
            throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
        }

        this->ComputeQuadraticBezierWaypoints(
            lanePair,
            outputWaypoints);
    }
    else
    {
        ROS_ERROR_STREAM("invalid " << lanePair.interpolatorId);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }
}

void DijkstraInterpolationPlanner::ComputeLinearInterpolationWaypoints(
    const LanePair &lanePair,
    Waypoints &outputWaypoints) const
{
    const double pathLength{
        (lanePair.controlPoints.back() - lanePair.controlPoints.front()).norm()};
    const int32_t waypointSize{
        static_cast<int32_t>(std::round(pathLength))};
    const double unitRatio{1.0 / static_cast<double>(waypointSize)};
    outputWaypoints.clear();
    outputWaypoints.reserve(waypointSize);

    for (int32_t idx{1}; idx < waypointSize; ++idx)
    {
        const double ratio{static_cast<double>(idx) * unitRatio};
        outputWaypoints.push_back(
            math::Lerp(
                math::Vector3d_t(lanePair.controlPoints.front()),
                math::Vector3d_t(lanePair.controlPoints.back()),
                ratio));
    }
}

void DijkstraInterpolationPlanner::ComputeQuadraticBezierWaypoints(
    const LanePair &lanePair,
    Waypoints &outputWaypoints) const
{
    auto controlPoint{lanePair.controlPoints.cbegin()};
    for (; controlPoint != lanePair.controlPoints.cend() - 2;
         ++controlPoint)
    {
        const double pathLength{
            (*controlPoint - *(controlPoint + 2)).norm()};
        const int32_t waypointSize{
            static_cast<int32_t>(std::round(pathLength))};
        const auto bezierPoints{
            mQuadraticBezierCurve.Compute(
                *controlPoint,
                *(controlPoint + 1),
                *(controlPoint + 2),
                waypointSize)};

        std::copy(
            bezierPoints.cbegin(),
            bezierPoints.cend(),
            std::back_inserter(outputWaypoints));
    }
}

} // namespace path {
