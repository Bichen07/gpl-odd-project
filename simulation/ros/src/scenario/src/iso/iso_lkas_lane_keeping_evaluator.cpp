#include <iso_lkas_lane_keeping_evaluator.h>
#include <map>
#include <stdexcept>
#include <ros/console.h>
#include <iso_specification.h>
#include <iso_test_scenario_agent_id.h>
#include <iso_utils.h>
#include <route_mission_handler/Waypoint.h>
#include <geometry_utils.h>

#define LKAS_Offset_max 0.4  // for light vehicle
//#define LKAS_Offset_max 1.1  // for heavy vehicle
#define DISABLE_RATE_OF_DEPARTURE true
namespace iso{
namespace lkas{

// public func.

LaneKeepingEvaluator::LaneKeepingEvaluator()
    : mNodeHandle{}
    , mPerformancePublisher{}
    , mEgoVehicleObserver{nullptr}
    , mNavigationPath{nullptr}
    , mWaypoint3ds{}
    , mWaypoint2ds{}
    , mMsgSequenceCount{0}
    , mStarted{false}
    , mIsFailed{false}
    , mLaneChanged{false}
    , mOutOfBoundary{false}
    , mCruiseVelocity{0}
    , mTimeStep{0.05}
    , mLastLongitudinalAcceleration{0.}
    , mLastLateralAcceleration{0.}
    , mLastDistanceToLaneCenter{0.}
    , mFrenetTransformer{}
{
    mPerformancePublisher = mNodeHandle.advertise<scenario::IsoLkasLaneKeepingPerformance>(
            "standard_tests/iso/lkas/performance", 1);
}
LaneKeepingEvaluator::~LaneKeepingEvaluator()
{
}


void LaneKeepingEvaluator::Configure(
    const std::shared_ptr<actor::EgoVehicleObserver> &egoVehicleObserver,
    const std::shared_ptr<map::NavigationPath> &navigationPath,
    const math::real_t timeStep)
{
    if (nullptr == egoVehicleObserver)
    {
        ROS_ERROR_STREAM("egoVehicleObserver is nullptr");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    if (navigationPath->GetForwardWaypoints().empty())
    {
        ROS_ERROR_STREAM("waypoint3ds is empty");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    mTimeStep = timeStep;
    mEgoVehicleObserver = egoVehicleObserver;
    mNavigationPath = navigationPath;
    mWaypoint3ds = mNavigationPath->GetForwardWaypoints();
    mWaypoint2ds.resize(mWaypoint3ds.size());
    std::transform(
        mWaypoint3ds.cbegin(),
        mWaypoint3ds.cend(),
        mWaypoint2ds.begin(),
        [](const math::Vector3d_t &waypoint3d)
        {return math::Vector2d_t(waypoint3d.x(), waypoint3d.y());});

    mFrenetTransformer.Configure(mWaypoint2ds);
}

void LaneKeepingEvaluator::Evaluate()
{    
    auto performance = CheckPerformance();

    mPerformancePublisher.publish(performance);
}


// private func.
std::string LaneKeepingEvaluator::CheckLaneChanged()
{
    std::string laneChange{"none"};
    if (!mNodeHandle.hasParam("behavior/lane_change"))
    {
        return laneChange;
    }
    mNodeHandle.getParam(
        "behavior/lane_change", laneChange);
    if (laneChange == "reset")
    {
        mMsgSequenceCount = 0;
        mStarted = false;
        mIsFailed = false;
        mLaneChanged = false;
        mCruiseVelocity = math::real_t{0.0};
        mLastLongitudinalAcceleration = math::real_t{0.0};
        mLastLateralAcceleration = math::real_t{0.0};
    }
    else if (
        (laneChange == "right" || laneChange == "left") && 
        !mLaneChanged)
    {
        mLaneChanged = true;
    }
    return laneChange;
}

math::real_t LaneKeepingEvaluator::CalculateRateOfDeparture(const motion::State state)
{
    const auto egoFrenetCoord{
        mFrenetTransformer.ConvertToFrenetCoord(
            mEgoVehicleObserver->GetTransform2d().translation())};
    
    const auto corners = geometry::ExtractCorners(
        mEgoVehicleObserver->GetWorldBoundingRect2d());

    math::FrenetCoord cornersFrenetCoord[4];

    float cornerDistanceToLaneCenter = 0.;

    for (unsigned i = 0; i < corners.size(); i++)
    {
        cornersFrenetCoord[i] = mFrenetTransformer.ConvertToFrenetCoord(
            corners[i]);

        if ( std::fabs(cornersFrenetCoord[i].d()) > 
                std::fabs(cornerDistanceToLaneCenter))
        {
            cornerDistanceToLaneCenter = cornersFrenetCoord[i].d();
        }
    }

    const float vehicleWidth = 1.849;  // model 3 width from google
    const float laneWidth = 3.2;

    const auto maximumOffset = laneWidth / 2. + LKAS_Offset_max;

    if (std::fabs(cornerDistanceToLaneCenter) > maximumOffset)
    {
        mOutOfBoundary = true;    
    }
    else
    {
        mOutOfBoundary = false;    
    }  

    float distanceToLaneCenter = egoFrenetCoord.d();

    auto rateOfDeparture = 
        (distanceToLaneCenter - mLastDistanceToLaneCenter) / mTimeStep;

    mLastDistanceToLaneCenter = distanceToLaneCenter;

    return rateOfDeparture;
    
}

scenario::IsoLkasLaneKeepingPerformance LaneKeepingEvaluator::CheckPerformance()
{
    
    auto state = mEgoVehicleObserver->GetState();
    auto laneChange = CheckLaneChanged();
    auto rateOfDeparture = CalculateRateOfDeparture(state);
    
    auto longitudinalJerk = 
        (state.longitudinalAcceleration - 
         mLastLongitudinalAcceleration) / mTimeStep;
    auto lateralJerk = 
        (state.lateralAcceleration - mLastLateralAcceleration) / mTimeStep;

    math::real_t longitudinalDeceleration = 0.;  //
    math::real_t longitudinalVelReduction = 0.;  //
    math::real_t longitudinalVelocity = 1.41 * 
        sqrt(state.linearVelocity.x() * state.linearVelocity.x() +
             state.linearVelocity.y() * state.linearVelocity.y());

    if (longitudinalVelocity > 20)
    {
        mStarted = true;
    }

    mCruiseVelocity = std::max(
        mCruiseVelocity, longitudinalVelocity);

    longitudinalDeceleration = std::min(
        state.longitudinalAcceleration, math::real_t{0.});

    if (std::fabs(longitudinalDeceleration) > 1.)
    {
        longitudinalVelReduction = 
            mCruiseVelocity - longitudinalVelocity;
    }

    scenario::IsoLkasLaneKeepingPerformance performance;
    performance.header.seq = mMsgSequenceCount++;
    performance.header.stamp = ros::Time::now();
    performance.started = mStarted;
    performance.laneChanged = mLaneChanged;
    performance.exceedLatAcelMax = std::fabs(state.lateralAcceleration) > 3.;
    performance.exceedLatJerkMax = std::fabs(lateralJerk) > 5.;
    performance.exceedLongDeclMax = std::fabs(longitudinalDeceleration) > 3.;
    performance.exceedLongVelReductionMax = std::fabs(longitudinalVelReduction) > 5.;
    performance.failRateOfDeparture = 
        std::fabs(rateOfDeparture) > 0.6 || std::fabs(rateOfDeparture) < 0.2;
    performance.failKeepInLane = mOutOfBoundary;
    performance.latAcel = (float)state.lateralAcceleration;
    performance.latJerk = (float)lateralJerk;
    performance.longVel = (float)longitudinalVelocity;
    performance.longDecl = (float)longitudinalDeceleration;
    performance.longVelReduction = (float)longitudinalVelReduction;
    performance.rateOfDeparture = rateOfDeparture;
    performance.lateralDistance = mLastDistanceToLaneCenter;


    if (DISABLE_RATE_OF_DEPARTURE)
    {
        performance.failRateOfDeparture = false;
    }
    
    if (mLaneChanged)
    {
        performance.failKeepInLane = false;
    }

    if (!mLaneChanged && mMsgSequenceCount > 100 && (
        performance.exceedLatAcelMax ||
        performance.exceedLatJerkMax ||
        performance.exceedLongDeclMax ||
        performance.exceedLongVelReductionMax ||
        performance.failKeepInLane))
    {
        mIsFailed = true;
    }

    if (mMsgSequenceCount > 100 && performance.failRateOfDeparture && 
        ("right" == laneChange || "left" == laneChange) )
    {
        mIsFailed = true;
    }

    performance.isFailed = mIsFailed;

    mLastLongitudinalAcceleration = 
        (math::real_t)state.longitudinalAcceleration;
    mLastLateralAcceleration = (math::real_t)state.lateralAcceleration;

    return performance;
}


} // namespace lkas{
} // namespace iso{
