#include <iso_acc_curve_capability_evaluator.h>
#include <map>
#include <stdexcept>
#include <ros/console.h>
#include <iso_specification.h>
#include <iso_test_scenario_agent_id.h>
#include <iso_utils.h>

namespace iso {
namespace acc {

// public func.

CurveCapabilityEvaluator::CurveCapabilityEvaluator()
    : mNodeHandle{}
    , mService{}
    , mEgoVehicleObserver{nullptr}
    , mPerformanceClassId{PerformanceClass::Null}
    , mWaypoint3ds{}
    , mWaypoint2ds{}
    , mTimeGapEvaluator{}
    , mAgentManager{nullptr}
{
    mService = mNodeHandle.advertiseService(
        "iso_acc_curve_capability_evaluation",
        &CurveCapabilityEvaluator::RunService,
        this);
}

CurveCapabilityEvaluator::~CurveCapabilityEvaluator()
{
}

math::real_t CurveCapabilityEvaluator::GetTestTrackRadius(
    const PerformanceClassId &performanceClassId) const
{
    static const std::map<PerformanceClassId, math::real_t> testTrackRadiusMap =
    {
        {PerformanceClass::Two,   CurveCapability::ClassTwoTestTrackRadius()},
        {PerformanceClass::Three, CurveCapability::ClassThreeTestTrackRadius()},
        {PerformanceClass::Four,  CurveCapability::ClassFourTestTrackRadius()},
    };

    const auto foundPair{testTrackRadiusMap.find(performanceClassId)};
    if (testTrackRadiusMap.end() == foundPair)
    {
        ROS_ERROR_STREAM("invalid: " << performanceClassId);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return foundPair->second;
}

math::real_t CurveCapabilityEvaluator::GetMaxLateralAcceleration(
    const PerformanceClassId &performanceClassId) const
{
    static const std::map<PerformanceClassId, math::real_t> maxLateralAccelerationMap =
    {
        {PerformanceClass::Two,   CurveCapability::ClassTwoMaxLateralAcceleration()},
        {PerformanceClass::Three, CurveCapability::ClassThreeMaxLateralAcceleration()},
        {PerformanceClass::Four,  CurveCapability::ClassFourMaxLateralAcceleration()},
    };

    const auto foundPair{maxLateralAccelerationMap.find(performanceClassId)};
    if (maxLateralAccelerationMap.end() == foundPair)
    {
        ROS_ERROR_STREAM("invalid: " << performanceClassId);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return foundPair->second;
}

math::real_t CurveCapabilityEvaluator::ComputeTargetVehicleBeginSpeed(
    const PerformanceClassId &performanceClassId) const
{
    static const std::map<PerformanceClassId, math::real_t> beginSpeedMap =
    {
        {
            PerformanceClass::Two,
            std::sqrt(
                CurveCapability::ClassTwoMaxLateralAcceleration() *
                CurveCapability::ClassTwoTestTrackRadius())
        },
        {
            PerformanceClass::Three,
            std::sqrt(
                CurveCapability::ClassThreeMaxLateralAcceleration() *
                CurveCapability::ClassThreeTestTrackRadius())
        },
        {
            PerformanceClass::Four,
            std::sqrt(
                CurveCapability::ClassFourMaxLateralAcceleration() *
                CurveCapability::ClassFourTestTrackRadius())
        },
    };

    const auto foundPair{beginSpeedMap.find(performanceClassId)};
    if (beginSpeedMap.end() == foundPair)
    {
        ROS_ERROR_STREAM("invalid: " << performanceClassId);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return foundPair->second;
}

TimeGapPerformance CurveCapabilityEvaluator::Evaluate(
    const VehicleAttribute &targetVehicleAttribute,
    const VehicleState &targetVehicleState) const
{
    return mTimeGapEvaluator.Evaluate(
        targetVehicleAttribute,
        targetVehicleState);
}

bool CurveCapabilityEvaluator::RunService(
    scenario::IsoAccCurveCapabilityEvaluation::Request &request,
    scenario::IsoAccCurveCapabilityEvaluation::Response &response)
{
    if (request.attributes.size() != request.states.size())
    {
        ROS_ERROR_STREAM(
            "diff. size b/t request.attributes & request.states" << '\n' <<
            "request.attributes: " << request.attributes.size() << '\n' <<
            "request.states: " << request.states.size());
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    if (request.attributes.empty())
    {
        ROS_WARN_STREAM("request is empty");
        return false;
    }

    const std::string targetVehicleAgentId{
        mAgentManager->QueryAgentId(acc::CurveCapabilityAgent::TargetVehicle())};

    const std::string targetVehicleCarlaActorIdKey =
        "simulation/agents/idMatching/car/" +
        targetVehicleAgentId;

    if (!mNodeHandle.hasParam(targetVehicleCarlaActorIdKey))
    {
        ROS_ERROR_STREAM("invalid targetVehicleCarlaActorIdKey: " << targetVehicleCarlaActorIdKey);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    int32_t targetVehicleCarlaActorId{0};
    mNodeHandle.getParam(targetVehicleCarlaActorIdKey, targetVehicleCarlaActorId);
    //ROS_INFO_STREAM("targetVehicleCarlaActorId: " << targetVehicleCarlaActorId);

    const auto targetVehicleAttribute{
        this->ExtractVehicleAttribute(
            std::to_string(targetVehicleCarlaActorId),
            request.attributes)};
    const auto targetVehicleState{
        this->ExtractVehicleState(
            std::to_string(targetVehicleCarlaActorId),
            request.states)};
    const auto performance = this->Evaluate(
        targetVehicleAttribute,
        targetVehicleState);
    response.performance.time_gap = performance.timeGap;
    response.performance.time_gap_state = static_cast<int32_t>(performance.timeGapStateId);

    return true;
}

void CurveCapabilityEvaluator::Configure(
    const std::shared_ptr<actor::EgoVehicleObserver> &egoVehicleObserver,
    const std::shared_ptr<AgentManager> &agentManager,
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
    mAgentManager = agentManager;
    mPerformanceClassId = performanceClassId;
    mWaypoint3ds = waypoint3ds;
    mWaypoint2ds.resize(mWaypoint3ds.size());
    std::transform(
        mWaypoint3ds.cbegin(),
        mWaypoint3ds.cend(),
        mWaypoint2ds.begin(),
        [](const math::Vector3d_t &waypoint3d)
        {return math::Vector2d_t(waypoint3d.x(), waypoint3d.y());});
    //mFrenetTransformer.Configure(mWaypoint2ds);

    mTimeGapEvaluator.Configure(
        mEgoVehicleObserver,
        performanceClassId,
        waypoint3ds);
}

// protected func.

// private func.

VehicleAttribute CurveCapabilityEvaluator::ExtractVehicleAttribute(
    const std::string &id,
    const std::vector<scenario::IsoVehicleAttribute> &msgs) const
{
    VehicleAttribute outputAttribute;
    for (const auto &msg: msgs)
    {
        if (msg.id == id)
        {
            outputAttribute = iso::ConvertToVehicleAttribute(msg);
            break;
        }
    }

    return outputAttribute;
}

VehicleState CurveCapabilityEvaluator::ExtractVehicleState(
    const std::string &id,
    const std::vector<scenario::IsoVehicleState> &msgs) const
{
    VehicleState outputState;
    for (const auto &msg: msgs)
    {
        if (msg.id == id)
        {
            outputState = iso::ConvertToVehicleState(msg);
            break;
        }
    }

    return outputState;
}

} // namespace acc {
} // namespace iso {
