#include <measure_frenet_distance_evaluator.h>
#include <sstream>
#include <stdexcept>
#include <ros/console.h>
#include <utils/utils_empty_container_exception.h>

namespace measure {

// public func.

FrenetDistanceEvaluator::FrenetDistanceEvaluator()
    : mRefWaypoint3ds{}
    , mRefWaypoint2ds{}
    , mFrenetTransformer{}
{
}

void FrenetDistanceEvaluator::Compute(
    const math::Vector3d_t &observerPoint,
    const math::Vector3d_t &targetPoint,
    const bool isMovingInRefWaypointDirection,
    FrenetDistanceData *frenetDistanceData) const
{
    if (nullptr == frenetDistanceData)
    {
        ROS_ERROR_STREAM("frenetDistanceData is nullptr");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    if (mRefWaypoint3ds.empty())
    {
        ROS_ERROR_STREAM("mRefWaypoint3ds is empty");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    const math::Vector2d_t observerPoint2d(observerPoint.x(), observerPoint.y());
    const math::Vector2d_t targetPoint2d(targetPoint.x(), targetPoint.y());

    math::FrenetCoord observerFrenetPointPrecalc =
        mFrenetTransformer.ConvertToFrenetCoord(observerPoint2d);
    if (observerFrenetPointPrecalc.s() < math::real_t{0.0})
    {
        ROS_ERROR_STREAM(
            "invalid observerFrenetPointPrecalc: " << observerFrenetPointPrecalc << '\n' <<
            "cartesian observerPoint: " << observerPoint2d);
        // throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
        observerFrenetPointPrecalc.set_s(math::real_t(0.0));
    }
    const math::FrenetCoord observerFrenetPoint = observerFrenetPointPrecalc;

    math::FrenetCoord targetFrenetPointPreCalc =
        mFrenetTransformer.ConvertToFrenetCoord(targetPoint2d);
    if (targetFrenetPointPreCalc.s() < math::real_t{0.0})
    {
        ROS_ERROR_STREAM("invalid targetFrenetPointPreCalc: " << targetFrenetPointPreCalc);
        // throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
        targetFrenetPointPreCalc.set_s(math::real_t(0.0));
    }
    const math::FrenetCoord targetFrenetPoint = targetFrenetPointPreCalc;

    if (observerFrenetPoint.s() < targetFrenetPoint.s())
    {
        this->Compute(
            observerPoint,
            targetPoint,
            observerFrenetPoint,
            targetFrenetPoint,
            frenetDistanceData);
        if (isMovingInRefWaypointDirection)
        {
            frenetDistanceData->isObserverBehindTarget = true;
        }
        else
        {
            frenetDistanceData->isObserverBehindTarget = false;
        }
    }
    else
    {
        this->Compute(
            targetPoint,
            observerPoint,
            targetFrenetPoint,
            observerFrenetPoint,
            frenetDistanceData);

        frenetDistanceData->observerPoint = observerPoint;
        frenetDistanceData->targetPoint = targetPoint;
        frenetDistanceData->observerFrenetPoint = observerFrenetPoint;
        frenetDistanceData->targetFrenetPoint = targetFrenetPoint;
        std::reverse(
            frenetDistanceData->sequentialPoints.begin(),
            frenetDistanceData->sequentialPoints.end());

        if (isMovingInRefWaypointDirection)
        {
            frenetDistanceData->isObserverBehindTarget = false;
        }
        else
        {
            frenetDistanceData->isObserverBehindTarget = true;
        }
    }
}

void FrenetDistanceEvaluator::Compute(
    const math::Vector3d_t &observerPoint,
    const math::Vector3d_t &targetPoint,
    const bool isMovingInRefWaypointDirection,
    FrenetDistanceData &frenetDistanceData,
    const utils::FileLineNumPair &fileLineNumPair) const
{
    if (mRefWaypoint3ds.empty())
    {
        std::string errorMessage("mRefWaypoint3ds is empty");
        utils::AppendFileLineNumMessage(
            fileLineNumPair,
            errorMessage,
            utils::FileLineNumPairInstance());
        ROS_ERROR_STREAM(errorMessage.c_str());
        throw utils::EmptyContainerException(__FILE__": " + std::to_string(__LINE__));
    }

    const math::Vector2d_t observerPoint2d(observerPoint.x(), observerPoint.y());
    const math::Vector2d_t targetPoint2d(targetPoint.x(), targetPoint.y());

    const math::FrenetCoord observerFrenetPoint =
        mFrenetTransformer.ConvertToFrenetCoord(observerPoint2d);
    if (observerFrenetPoint.s() < math::real_t{0.0})
    {
        std::stringstream errorStream;
        errorStream <<
            "invalid observerFrenetPoint: " << observerFrenetPoint << '\n' <<
            "cartesian observerPoint: " << observerPoint2d;
        std::string errorMessage(errorStream.str());
        utils::AppendFileLineNumMessage(
            fileLineNumPair,
            errorMessage,
            utils::FileLineNumPairInstance());
        ROS_ERROR_STREAM(errorMessage.c_str());
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    const math::FrenetCoord targetFrenetPoint =
        mFrenetTransformer.ConvertToFrenetCoord(targetPoint2d);
    if (targetFrenetPoint.s() < math::real_t{0.0})
    {
        std::stringstream errorStream;
        errorStream << "invalid targetFrenetPoint: " << targetFrenetPoint;
        std::string errorMessage(errorStream.str());
        utils::AppendFileLineNumMessage(
            fileLineNumPair,
            errorMessage,
            utils::FileLineNumPairInstance());
        ROS_ERROR_STREAM("invalid targetFrenetPoint: " << targetFrenetPoint);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    if (observerFrenetPoint.s() < targetFrenetPoint.s())
    {
        this->Compute(
            observerPoint,
            targetPoint,
            observerFrenetPoint,
            targetFrenetPoint,
            &frenetDistanceData);
        if (isMovingInRefWaypointDirection)
        {
            frenetDistanceData.isObserverBehindTarget = true;
        }
        else
        {
            frenetDistanceData.isObserverBehindTarget = false;
        }
    }
    else
    {
        this->Compute(
            targetPoint,
            observerPoint,
            targetFrenetPoint,
            observerFrenetPoint,
            &frenetDistanceData);

        frenetDistanceData.observerPoint = observerPoint;
        frenetDistanceData.targetPoint = targetPoint;
        frenetDistanceData.observerFrenetPoint = observerFrenetPoint;
        frenetDistanceData.targetFrenetPoint = targetFrenetPoint;
        std::reverse(
            frenetDistanceData.sequentialPoints.begin(),
            frenetDistanceData.sequentialPoints.end());

        if (isMovingInRefWaypointDirection)
        {
            frenetDistanceData.isObserverBehindTarget = false;
        }
        else
        {
            frenetDistanceData.isObserverBehindTarget = true;
        }
    }
}

void FrenetDistanceEvaluator::Configure(const std::vector<math::Vector3d_t> &refWaypoints)
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

// protected func.

// private func.

void FrenetDistanceEvaluator::Compute(
    const math::Vector3d_t &observerPoint,
    const math::Vector3d_t &targetPoint,
    const math::FrenetCoord &observerFrenetPoint,
    const math::FrenetCoord &targetFrenetPoint,
    FrenetDistanceData *frenetDistanceData) const
{
    const math::FrenetCoord sequentialBeginFrenetCoord(observerFrenetPoint.s(), 0.0);
    const math::FrenetCoord sequentialEndFrenetCoord(targetFrenetPoint.s(), 0.0);

    const int32_t sequentialBeginWaypointIdx =
        mFrenetTransformer.ComputeWaypointIdx(sequentialBeginFrenetCoord);
    const math::Vector2d_t sequentialBeginPoint2d =
        mFrenetTransformer.ConvertToCartesianCoord(
            sequentialBeginWaypointIdx,
            sequentialBeginFrenetCoord);

    const int32_t sequentialEndWaypointIdx =
        mFrenetTransformer.ComputeWaypointIdx(sequentialEndFrenetCoord);
    const math::Vector2d_t sequentialEndPoint2d =
        mFrenetTransformer.ConvertToCartesianCoord(
            sequentialEndWaypointIdx,
            sequentialEndFrenetCoord);

    const math::Vector3d_t sequentialBeginPoint3d(
        sequentialBeginPoint2d.x(),
        sequentialBeginPoint2d.y(),
        mRefWaypoint3ds.at(sequentialBeginWaypointIdx).z());
    const math::Vector3d_t sequentialEndPoint3d(
        sequentialEndPoint2d.x(),
        sequentialEndPoint2d.y(),
        mRefWaypoint3ds.at(sequentialEndWaypointIdx).z());

    frenetDistanceData->observerPoint = observerPoint;
    frenetDistanceData->targetPoint = targetPoint;
    frenetDistanceData->observerFrenetPoint = observerFrenetPoint;
    frenetDistanceData->targetFrenetPoint = targetFrenetPoint;
    frenetDistanceData->distance = targetFrenetPoint - observerFrenetPoint;

    const int32_t sequentialPointSize =
        sequentialEndWaypointIdx - sequentialBeginWaypointIdx + 2;
    frenetDistanceData->sequentialPoints.reserve(sequentialPointSize);
    frenetDistanceData->sequentialPoints.insert(
        frenetDistanceData->sequentialPoints.end(),
        sequentialBeginPoint3d);
    if (sequentialEndWaypointIdx > sequentialBeginWaypointIdx)
    {
        frenetDistanceData->sequentialPoints.insert(
            frenetDistanceData->sequentialPoints.end(),
            mRefWaypoint3ds.begin() + sequentialBeginWaypointIdx + 1,
            mRefWaypoint3ds.begin() + sequentialEndWaypointIdx);
    }

    frenetDistanceData->sequentialPoints.insert(
        frenetDistanceData->sequentialPoints.end(),
        sequentialEndPoint3d);
}

} // namespace measure {
