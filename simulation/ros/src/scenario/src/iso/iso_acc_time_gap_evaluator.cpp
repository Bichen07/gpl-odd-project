#include <iso_acc_time_gap_evaluator.h>
#include <algorithm>
#include <utils_converter.h>
#include <iso_specification.h>

namespace iso {
namespace acc {

// public func.

TimeGapEvaluator::TimeGapEvaluator()
    : mEgoVehicleObserver{nullptr}
    , mPerformanceClassId{PerformanceClass::Null}
    , mWaypoint3ds{}
    , mWaypoint2ds{}
    , mFrenetTransformer{}
    , mTimeGaps{}
{
    mTimeGaps = std::vector<math::real_t>
    {
        TimeGap::CriticalMin(),
        TimeGap::RangeMin(),
        TimeGap::RangeMax(),
    };
    std::sort(mTimeGaps.begin(), mTimeGaps.end());
}

TimeGapEvaluator::~TimeGapEvaluator()
{
}

TimeGapPerformance TimeGapEvaluator::Evaluate(
    const VehicleAttribute &targetVehicleAttribute,
    const VehicleState &targetVehicleState) const
{
    const auto timeGap = this->ComputeTimeGap(
        *mEgoVehicleObserver,
        targetVehicleAttribute,
        targetVehicleState);
    const auto timeGapStateId{this->EvaluateTimeGapState(timeGap)};

    return TimeGapPerformance{
        .timeGap = timeGap,
        .timeGapStateId = timeGapStateId};
}

math::real_t TimeGapEvaluator::ComputeTimeGap(
    const VehicleAttribute &targetVehicleAttribute,
    const VehicleState &targetVehicleState) const
{
    return this->ComputeTimeGap(
        *mEgoVehicleObserver,
        targetVehicleAttribute,
        targetVehicleState);
}

math::real_t TimeGapEvaluator::ComputeClearance(
    const VehicleAttribute &targetVehicleAttribute,
    const VehicleState &targetVehicleState) const
{
    return this->ComputeClearance(
        *mEgoVehicleObserver,
        targetVehicleAttribute,
        targetVehicleState);
}

void TimeGapEvaluator::Configure(
    const std::shared_ptr<actor::EgoVehicleObserver> &egoVehicleObserver,
    const PerformanceClassId &performanceClassId,
    const std::vector<math::Vector3d_t> &waypoint3ds)
{
    if (nullptr == egoVehicleObserver)
    {
        ROS_ERROR_STREAM("egoVehicleObserver is nullptr");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    if (PerformanceClass::Null == performanceClassId)
    {
        ROS_ERROR_STREAM("invalid " << performanceClassId);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    if (waypoint3ds.empty())
    {
        ROS_ERROR_STREAM("waypoint3ds is empty");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    mEgoVehicleObserver = egoVehicleObserver;
    mPerformanceClassId = performanceClassId;
    mWaypoint3ds = waypoint3ds;
    mWaypoint2ds.resize(mWaypoint3ds.size());
    std::transform(
        mWaypoint3ds.cbegin(),
        mWaypoint3ds.cend(),
        mWaypoint2ds.begin(),
        [](const math::Vector3d_t &waypoint3d)
        {return math::Vector2d_t(waypoint3d.x(), waypoint3d.y());});
    mFrenetTransformer.Configure(mWaypoint2ds);
}

// protected func.

// private func.

math::real_t TimeGapEvaluator::ComputeTimeGap(
    const actor::EgoVehicleObserver &egoVehicleObserver,
    const VehicleAttribute &targetVehicleAttribute,
    const VehicleState &targetVehicleState) const
{
    const math::real_t speed = egoVehicleObserver.GetState().linearVelocity.norm();

    if (speed < math::real_t{1.0e-6})
    {
        return std::numeric_limits<math::real_t>::max();
    }

    //return this->ComputeClearance(egoVehicleObserver, targetVehicleState) / speed;
    const auto clearance{this->ComputeClearance(
            egoVehicleObserver,
            targetVehicleAttribute,
            targetVehicleState)};
    const auto timeGap{clearance / speed};
    //ROS_INFO_STREAM('\n' <<
    //    "speed: " << speed << '\n' <<
    //    "clearance: " << clearance << '\n' <<
    //    "timeGap: " << timeGap);

    return timeGap;
}

math::real_t TimeGapEvaluator::ComputeClearance(
    const actor::EgoVehicleObserver &egoVehicleObserver,
    const VehicleAttribute &targetVehicleAttribute,
    const VehicleState &targetVehicleState) const
{
    const auto egoFrenetCoord{
        mFrenetTransformer.ConvertToFrenetCoord(
            egoVehicleObserver.GetTransform2d().translation())};
    const auto targetVehicleFrenetCoord{
        mFrenetTransformer.ConvertToFrenetCoord(
            utils::ConvertToVector2d(targetVehicleState.pose.translation()))};

    const auto halfEgoLength{0.5 * mEgoVehicleObserver->GetSize().x()};
    const auto halfVehicleLength{0.5 * targetVehicleAttribute.size.x()};
    //ROS_INFO_STREAM('\n' <<
    //    "ego frenet: " << egoFrenetCoord << '\n' <<
    //    "agent frenet: " << targetVehicleFrenetCoord);
    return targetVehicleFrenetCoord.s() - egoFrenetCoord.s() - halfEgoLength - halfVehicleLength;
}

TimeGapStateId TimeGapEvaluator::EvaluateTimeGapState(const math::real_t timeGap) const
{
    static const auto timeGapStateIds = std::vector<TimeGapStateId>
    {
        TimeGapState::UnderCriticalMin,
        TimeGapState::UnderRangeMin,
        TimeGapState::WithinRange,
    };

    const auto upper = std::upper_bound(
        mTimeGaps.cbegin(),
        mTimeGaps.cend(),
        timeGap);

    if (mTimeGaps.end() == upper)
    {
        return TimeGapState::AboveRangeMax;
    }
    const auto idx = std::distance(mTimeGaps.begin(), upper);
    return timeGapStateIds.at(idx);
}

} // namespace acc {
} // namespace iso {
