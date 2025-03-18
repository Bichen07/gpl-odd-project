#include <iso_adaptive_cruise_control.h>
#include <limits>
#include <ros/console.h>
#include <math_utils.h>
#include <iso_utils.h>

namespace iso {

// public func.

AdaptiveCruiseControl::AdaptiveCruiseControl()
    : mNodeHandle{}
    , mPerformanceEvaluationService{}
    , mEgoVehicleObserver{nullptr}
    , mPerformanceClassId{PerformanceClass::Null}
    , mWaypoint3ds{}
    , mWaypoint2ds{}
    , mFrenetTransformer{}
{
    mPerformanceEvaluationService = mNodeHandle.advertiseService(
        "iso_acc_performance_evaluation",
        &AdaptiveCruiseControl::RunPerformanceEvaluationService,
        this);
}

AdaptiveCruiseControl::~AdaptiveCruiseControl()
{
}

AdaptiveCruiseControlPerformance AdaptiveCruiseControl::Evaluate(
    const VehicleState &vehicleState)
{
    AdaptiveCruiseControlPerformance performance;
    performance.timeGap = this->ComputeTimeGap(
        *mEgoVehicleObserver,
        vehicleState);
    performance.isSuccessfulTimeGap = this->EvaluateSuccessfulTimeGap(
        mPerformanceClassId,
        performance.timeGap);

    return performance;
}

void AdaptiveCruiseControl::Configure(
    const std::shared_ptr<actor::EgoVehicleObserver> &egoVehicleObserver,
    const PerformanceClassId &performanceClassId,
    const std::vector<math::Vector3d_t> &waypoint3ds)
{
    if (nullptr == egoVehicleObserver)
    {
        ROS_ERROR_STREAM("egoVehicleObserver is nullptr");
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

bool AdaptiveCruiseControl::RunPerformanceEvaluationService(
    scenario::IsoAccPerformanceEvaluation::Request &request,
    scenario::IsoAccPerformanceEvaluation::Response &response)
{
    const auto vehicleState{iso::ConvertToVehicleState(request.states.front())};
    //ROS_INFO_STREAM("vehicle pose" << '\n' <<
    //    vehicleState.pose);
    const auto performance{this->Evaluate(vehicleState)};
    response.performance.is_successful_time_gap = performance.isSuccessfulTimeGap;
    response.performance.time_gap = performance.timeGap;

    return true;
}

math::real_t AdaptiveCruiseControl::ComputeTimeGap(
    const actor::EgoVehicleObserver &egoVehicleObserver,
    const VehicleState &vehicleState) const
{
    const math::real_t speed = egoVehicleObserver.GetState().linearVelocity.norm();

    if (speed < math::real_t{1.0e-6})
    {
        return std::numeric_limits<math::real_t>::max();
    }

    //return this->ComputeClearance(egoVehicleObserver, vehicleState) / speed;
    const auto clearance{this->ComputeClearance(egoVehicleObserver, vehicleState)};
    const auto timeGap{clearance / speed};
    //ROS_INFO_STREAM('\n' <<
    //    "speed: " << speed << '\n' <<
    //    "clearance: " << clearance << '\n' <<
    //    "timeGap: " << timeGap);

    return timeGap;
}

math::real_t AdaptiveCruiseControl::ComputeClearance(
    const actor::EgoVehicleObserver &egoVehicleObserver,
    const VehicleState &vehicleState) const
{
    const auto egoFrenetCoord{
        mFrenetTransformer.ConvertToFrenetCoord(
            egoVehicleObserver.GetTransform2d().translation())};
    const math::Vector2d_t vehiclePos2d(
        vehicleState.pose.translation().x(),
        vehicleState.pose.translation().y());
    const auto vehicleFrenetCoord{
        mFrenetTransformer.ConvertToFrenetCoord(vehiclePos2d)};

    const auto halfEgoLength{0.5 * mEgoVehicleObserver->GetSize().x()};
    const auto halfVehicleLength{3.0};
    //ROS_INFO_STREAM('\n' <<
    //    "ego frenet: " << egoFrenetCoord << '\n' <<
    //    "agent frenet: " << vehicleFrenetCoord);
    return vehicleFrenetCoord.s() - egoFrenetCoord.s() - halfEgoLength - halfVehicleLength;
}

bool AdaptiveCruiseControl::EvaluateSuccessfulTimeGap(
    const PerformanceClassId &performanceClassId,
    const math::real_t timeGap) const
{
    return timeGap >= math::real_t{1.5};
}

} // namespace iso {
