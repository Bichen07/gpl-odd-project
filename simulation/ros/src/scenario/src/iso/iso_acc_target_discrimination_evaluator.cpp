#include <iso_acc_target_discrimination_evaluator.h>
#include <stdexcept>
#include <ros/console.h>
#include <utils_converter.h>
#include <iso_test_scenario_agent_id.h>
#include <iso_specification.h>
#include <iso_utils.h>

namespace iso {
namespace acc {

// public func.

TargetDiscriminationEvaluator::TargetDiscriminationEvaluator()
    : mNodeHandle{}
    , mService{}
    , mEgoVehicleObserver{nullptr}
    , mPerformanceClassId{PerformanceClass::Null}
    , mWaypoint3ds{}
    , mWaypoint2ds{}
    , mFrenetTransformer{}
    , mDesiredVehicleEndMps{0.0}
    , mDesiredVehicleBeginMps{0.0}
    , mTimeGapEvaluator{}
    , mPreviousTargetDiscriminationStateId{TargetDiscriminationState::Null}
    , mAgentManager{nullptr}
{
    mService = mNodeHandle.advertiseService(
        "iso_acc_target_discrimination_evaluation",
        &TargetDiscriminationEvaluator::RunService,
        this);
}

TargetDiscriminationEvaluator::~TargetDiscriminationEvaluator()
{
}

TargetDiscriminationStateId TargetDiscriminationEvaluator::Evaluate(
    const VehicleAttribute &targetVehicleAttribute,
    const VehicleState &targetVehicleState,
    const VehicleAttribute &forwardVehicleAttribute,
    const VehicleState &forwardVehicleState)
{
    if (TargetDiscriminationState::PassTest == mPreviousTargetDiscriminationStateId)
    {
        return mPreviousTargetDiscriminationStateId;
    }

    const math::real_t egoVehicleMps = mEgoVehicleObserver->GetState().linearVelocity.norm();
    if (egoVehicleMps < mDesiredVehicleBeginMps)
    {
        mPreviousTargetDiscriminationStateId = TargetDiscriminationState::BeforeInitialCondition;
        return TargetDiscriminationState::BeforeInitialCondition;
    }

    if (egoVehicleMps <= mDesiredVehicleEndMps)
    {
        mPreviousTargetDiscriminationStateId = TargetDiscriminationState::DuringTest;
        return TargetDiscriminationState::DuringTest;
    }

    const auto egoFrenetCoord = mFrenetTransformer.ConvertToFrenetCoord(
        mEgoVehicleObserver->GetTransform2d().translation());
    const auto forwardVehicleFrenetCoord = mFrenetTransformer.ConvertToFrenetCoord(
        utils::ConvertToVector2d(forwardVehicleState.pose.translation()));
    const bool isSubjectExceedingForwardVehicle{
        this->IsSubjectExceedingForwardVehicle(
            egoFrenetCoord,
            forwardVehicleFrenetCoord,
            targetVehicleAttribute.size.x())};
    if (!isSubjectExceedingForwardVehicle)
    {
        mPreviousTargetDiscriminationStateId = TargetDiscriminationState::DuringTest;
        return TargetDiscriminationState::DuringTest;
    }

    const auto timeGapPerformance = mTimeGapEvaluator.Evaluate(
        targetVehicleAttribute,
        targetVehicleState);
    //ROS_INFO_STREAM(timeGapPerformance);
    const bool isValidTimeGap{this->CheckTimeGapPerformance(timeGapPerformance)};
    //ROS_INFO_STREAM(
    //    "1: " << (egoVehicleMps > mDesiredVehicleEndMps) << '\n' <<
    //    "2: " << isValidTimeGap << '\n' <<
    //    "3: " << isSubjectExceedingForwardVehicle);
    if (egoVehicleMps > mDesiredVehicleEndMps &&
        isValidTimeGap &&
        isSubjectExceedingForwardVehicle)
    {
        mPreviousTargetDiscriminationStateId = TargetDiscriminationState::PassTest;
        return TargetDiscriminationState::PassTest;
    }

    return TargetDiscriminationState::FailTest;
}

bool TargetDiscriminationEvaluator::RunService(
    scenario::IsoAccTargetDiscriminationEvaluation::Request &request,
    scenario::IsoAccTargetDiscriminationEvaluation::Response &response)
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
        mAgentManager->QueryAgentId(acc::TargetDiscriminationAgent::TargetVehicle())};
    const std::string forwardVehicleAgentId{
        mAgentManager->QueryAgentId(acc::TargetDiscriminationAgent::ForwardVehicle())};

    const std::string targetVehicleCarlaActorIdKey =
        "simulation/agents/idMatching/car/" +
        targetVehicleAgentId;
    const std::string forwardVehicleCarlaActorIdKey =
        "simulation/agents/idMatching/car/" +
        forwardVehicleAgentId;

    if (!mNodeHandle.hasParam(targetVehicleCarlaActorIdKey))
    {
        ROS_ERROR_STREAM("invalid targetVehicleCarlaActorIdKey: " << targetVehicleCarlaActorIdKey);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    if (!mNodeHandle.hasParam(forwardVehicleCarlaActorIdKey))
    {
        ROS_ERROR_STREAM("invalid forwardVehicleCarlaActorIdKey: " << forwardVehicleCarlaActorIdKey);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    int32_t targetVehicleCarlaActorId{0};
    mNodeHandle.getParam(targetVehicleCarlaActorIdKey, targetVehicleCarlaActorId);
    int32_t forwardVehicleCarlaActorId{0};
    mNodeHandle.getParam(forwardVehicleCarlaActorIdKey, forwardVehicleCarlaActorId);

    const auto targetVehicleAttribute{
        this->ExtractVehicleAttribute(
            std::to_string(targetVehicleCarlaActorId),
            request.attributes)};
    const auto targetVehicleState{
        this->ExtractVehicleState(
            std::to_string(targetVehicleCarlaActorId),
            request.states)};
    const auto forwardVehicleAttribute{
        this->ExtractVehicleAttribute(
            std::to_string(forwardVehicleCarlaActorId),
            request.attributes)};
    const auto forwardVehicleState{
        this->ExtractVehicleState(
            std::to_string(forwardVehicleCarlaActorId),
            request.states)};
    const auto stateId{
        this->Evaluate(
            targetVehicleAttribute,
            targetVehicleState,
            forwardVehicleAttribute,
            forwardVehicleState)};
    response.performance.state = static_cast<int32_t>(stateId);

    return true;
}

void TargetDiscriminationEvaluator::Configure(
    const std::shared_ptr<actor::EgoVehicleObserver> &egoVehicleObserver,
    const std::shared_ptr<AgentManager> &agentManager,
    const PerformanceClassId &performanceClassId,
    const std::vector<math::Vector3d_t> &waypoint3ds,
    const math::real_t desiredVehicleEndMps)
{
    if (nullptr == egoVehicleObserver)
    {
        ROS_ERROR_STREAM("egoVehicleObserver is nullptr");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    if (nullptr == agentManager)
    {
        ROS_ERROR_STREAM("agentManager is nullptr");
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

    if (desiredVehicleEndMps < TargetDiscrimination::MinDesiredVehicleEndMps())
    {
        ROS_ERROR_STREAM("invalid desiredVehicleEndMsp: " << desiredVehicleEndMps);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    mEgoVehicleObserver = egoVehicleObserver;
    mAgentManager = agentManager;
    mWaypoint3ds = waypoint3ds;
    mWaypoint2ds.resize(mWaypoint3ds.size());
    std::transform(
        mWaypoint3ds.cbegin(),
        mWaypoint3ds.cend(),
        mWaypoint2ds.begin(),
        [](const math::Vector3d_t &waypoint3d)
        {return math::Vector2d_t(waypoint3d.x(), waypoint3d.y());});
    mFrenetTransformer.Configure(mWaypoint2ds);

    mDesiredVehicleEndMps = desiredVehicleEndMps;
    mDesiredVehicleBeginMps =
        mDesiredVehicleEndMps -
        TargetDiscrimination::BeginEndMpsDifference();

    mTimeGapEvaluator.Configure(
        mEgoVehicleObserver,
        PerformanceClass::One,
        waypoint3ds);
}

// protected func.

// private func.

VehicleAttribute TargetDiscriminationEvaluator::ExtractVehicleAttribute(
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

VehicleState TargetDiscriminationEvaluator::ExtractVehicleState(
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
bool TargetDiscriminationEvaluator::CheckTimeGapPerformance(
    const TimeGapPerformance &timeGapPerformance) const
{
    return TimeGapState::WithinRange == timeGapPerformance.timeGapStateId ||
        TimeGapState::AboveRangeMax == timeGapPerformance.timeGapStateId;
}

bool TargetDiscriminationEvaluator::IsSubjectExceedingForwardVehicle(
    const math::FrenetCoord &egoVehicleFrenetCoord,
    const math::FrenetCoord &forwardVehicleFrenetCoord,
    const math::real_t targetVehicleLength) const
{
    static const math::real_t extraDistance{1.0};
    const math::real_t targetLongitudinalDistance =
        forwardVehicleFrenetCoord.s() +
        math::real_t{0.5} * targetVehicleLength +
        extraDistance;
    return egoVehicleFrenetCoord.s() > targetLongitudinalDistance;
}

} // namespace acc {
} // namespace iso {
