#include <iso_fvcws_lateral_discrimination_evaluator.h>
#include <stdexcept>
#include <ros/console.h>
#include <std_msgs/Bool.h>
#include <math_utils.h>
#include <iso_ros_param_key.h>
#include <iso_specification.h>
#include <iso_test_scenario_agent_id.h>
#include <iso_utils.h>

namespace iso {
namespace fvcws {

// public func.

LateralDiscriminationEvaluator::LateralDiscriminationEvaluator()
    : mNodeHandle{}
    , mService{}
    , mEgoVehicleObserver{nullptr}
    , mAgentManager{nullptr}
    , mFrenetTransformer{}
    , mPreviousLateralDiscriminationStateId{LateralDiscriminationState::Null}
    , mTimeGapEvaluator{}
{
    mService = mNodeHandle.advertiseService(
        "iso_fvcws_lateral_discrimination_evaluation",
        &LateralDiscriminationEvaluator::RunService,
        this);

    ros::param::set(
        WaitIsoFvcwsLateralDiscriminationSubjectWarning(),
        false);
    ros::param::set(
        HasSentIsoFvcwsLateralDiscriminationSubjectWarning(),
        false);
}

LateralDiscriminationEvaluator::~LateralDiscriminationEvaluator()
{
}

LateralDiscriminationStateId LateralDiscriminationEvaluator::Evaluate(
    const VehicleAttribute &targetVehicleAttribute,
    const VehicleState &targetVehicleState,
    const VehicleAttribute &forwardVehicleAttribute,
    const VehicleState &forwardVehicleState)
{
    if (LateralDiscriminationState::PassTest == mPreviousLateralDiscriminationStateId)
    {
        ros::param::set(
            WaitIsoFvcwsLateralDiscriminationSubjectWarning(),
            false);
        ros::param::set(
            HasSentIsoFvcwsLateralDiscriminationSubjectWarning(),
            true);
        return mPreviousLateralDiscriminationStateId;
    }

    if (math::IsApproxZero(targetVehicleState.linearVelocity.norm(), math::real_t{1.0e-3}))
    {
        mPreviousLateralDiscriminationStateId = LateralDiscriminationState::BeforeInitCondition;
        return LateralDiscriminationState::BeforeInitCondition;
    }

    const math::real_t timeGap{
        mTimeGapEvaluator.ComputeTimeGap(
            targetVehicleAttribute,
            targetVehicleState)};
    const bool isTimeGapInInitFollowingRange = math::IsInRange(
        timeGap,
        LateralDiscrimination::DesiredTimeGap() - math::real_t{0.5},
        LateralDiscrimination::DesiredTimeGap() + math::real_t{0.2});
    //ROS_INFO_STREAM("timeGap: " << timeGap);
    if (!isTimeGapInInitFollowingRange &&
        LateralDiscriminationState::BeforeInitCondition == mPreviousLateralDiscriminationStateId)
    {
        mPreviousLateralDiscriminationStateId = LateralDiscriminationState::BeforeInitCondition;
        return LateralDiscriminationState::BeforeInitCondition;
    }

    const bool isValidInitFollowingPreviousState =
        LateralDiscriminationState::BeforeInitCondition == mPreviousLateralDiscriminationStateId ||
        LateralDiscriminationState::InitFollowing == mPreviousLateralDiscriminationStateId;
    const bool isForwardVehicleDeceleration =
        forwardVehicleState.linearVelocity.norm() <
        (LateralDiscrimination::ForwardVehicleInitSpeed() - math::real_t{2.0});

    //ROS_INFO_STREAM('\n' <<
    //    "timeGap: " << timeGap << '\n' <<
    //    "isTimeGapInInitFollowingRange: " << isTimeGapInInitFollowingRange << '\n' <<
    //    "isValidInitFollowingPreviousState: " << isValidInitFollowingPreviousState);
    if (isTimeGapInInitFollowingRange &&
        isValidInitFollowingPreviousState)
    {
        if (isForwardVehicleDeceleration)
        {
            mPreviousLateralDiscriminationStateId = LateralDiscriminationState::ForwardDeceleration;
            return LateralDiscriminationState::ForwardDeceleration;
        }

        mPreviousLateralDiscriminationStateId = LateralDiscriminationState::InitFollowing;
        return LateralDiscriminationState::InitFollowing;
    }

    auto forwardVehicle{
        mAgentManager->QueryVehicle(
            fvcws::LateralDiscriminationAgent::ForwardVehicle())};
    const auto subjectRearFrenetCoord{
        mFrenetTransformer.ConvertToFrenetCoord(
            mEgoVehicleObserver->GetWorldBoundingRect2d().bottomRight)};
    const auto forwardFrontFrenetCoord{
        mFrenetTransformer.ConvertToFrenetCoord(
            forwardVehicle->GetWorldBoundingRect2d().topRight)};
    const bool isSubjectOvertakingForward =
        subjectRearFrenetCoord.s() > forwardFrontFrenetCoord.s() ? true : false;

    if (LateralDiscriminationState::ForwardDeceleration == mPreviousLateralDiscriminationStateId)
    {
        if (isSubjectOvertakingForward)
        {
            mPreviousLateralDiscriminationStateId = LateralDiscriminationState::SubjectPassForward;
            return LateralDiscriminationState::SubjectPassForward;
        }

        mPreviousLateralDiscriminationStateId = LateralDiscriminationState::ForwardDeceleration;
        return LateralDiscriminationState::ForwardDeceleration;
    }

    const bool isTargetDeceleration =
        targetVehicleState.linearVelocity.norm() <
        (LateralDiscrimination::TargetVehicleInitSpeed() - math::real_t{2.0});

    if (isTargetDeceleration)
    {
        ros::param::set(
            WaitIsoFvcwsLateralDiscriminationSubjectWarning(),
            true);

        bool hasWarning{false};
        if (ros::param::get(HasSentIsoFvcwsLateralDiscriminationSubjectWarning(), hasWarning))
        {
            if (hasWarning)
            {
                mPreviousLateralDiscriminationStateId =
                    LateralDiscriminationState::PassTest;
                return LateralDiscriminationState::PassTest;
            }
        }

        mPreviousLateralDiscriminationStateId =
            LateralDiscriminationState::TargetDeceleration;
        return mPreviousLateralDiscriminationStateId;
    }
    else
    {
        mPreviousLateralDiscriminationStateId =
            LateralDiscriminationState::SubjectPassForward;
        return LateralDiscriminationState::SubjectPassForward;
    }

    mPreviousLateralDiscriminationStateId = LateralDiscriminationState::FailTest;
    return LateralDiscriminationState::FailTest;
}

bool LateralDiscriminationEvaluator::RunService(
    scenario::IsoFvcwsLateralDiscriminationEvaluation::Request &request,
    scenario::IsoFvcwsLateralDiscriminationEvaluation::Response &response)
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
        mAgentManager->QueryAgentId(
            fvcws::LateralDiscriminationAgent::TargetVehicle())};
    const std::string targetVehicleCarlaActorIdKey =
        "simulation/agents/idMatching/car/" +
        targetVehicleAgentId;

    if (!mNodeHandle.hasParam(targetVehicleCarlaActorIdKey))
    {
        ROS_ERROR_STREAM(
            "invalid targetVehicleCarlaActorIdKey: " <<
            targetVehicleCarlaActorIdKey);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    int32_t targetVehicleCarlaActorId{0};
    mNodeHandle.getParam(
        targetVehicleCarlaActorIdKey,
        targetVehicleCarlaActorId);
    const auto targetVehicleAttribute{
        iso::ExtractVehicleAttribute(
            std::to_string(targetVehicleCarlaActorId),
            request.attributes)};
    const auto targetVehicleState{
        iso::ExtractVehicleState(
            std::to_string(targetVehicleCarlaActorId),
            request.states)};

    const std::string forwardVehicleAgentId{
        mAgentManager->QueryAgentId(
            fvcws::LateralDiscriminationAgent::ForwardVehicle())};
    const std::string forwardVehicleCarlaActorIdKey =
        "simulation/agents/idMatching/car/" +
        forwardVehicleAgentId;

    if (!mNodeHandle.hasParam(forwardVehicleCarlaActorIdKey))
    {
        ROS_ERROR_STREAM(
            "invalid forwardVehicleCarlaActorIdKey: " <<
            forwardVehicleCarlaActorIdKey);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    int32_t forwardVehicleCarlaActorId{0};
    mNodeHandle.getParam(
        forwardVehicleCarlaActorIdKey,
        forwardVehicleCarlaActorId);
    const auto forwardVehicleAttribute{
        iso::ExtractVehicleAttribute(
            std::to_string(forwardVehicleCarlaActorId),
            request.attributes)};
    const auto forwardVehicleState{
        iso::ExtractVehicleState(
            std::to_string(forwardVehicleCarlaActorId),
            request.states)};

    const auto stateId{
        this->Evaluate(
            targetVehicleAttribute,
            targetVehicleState,
            forwardVehicleAttribute,
            forwardVehicleState)};
    response.performance.state = static_cast<int8_t>(stateId);
    ROS_INFO_STREAM("stateId: " << stateId);

    return true;
}

void LateralDiscriminationEvaluator::Configure(
    const std::shared_ptr<actor::EgoVehicleObserver> &egoVehicleObserver,
    const std::shared_ptr<AgentManager> &agentManager,
    const std::vector<math::Vector3d_t> &egoVehicleWaypoints)
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

    mEgoVehicleObserver = egoVehicleObserver;
    mAgentManager = agentManager;
    mTimeGapEvaluator.Configure(
        mEgoVehicleObserver,
        PerformanceClass::One,
        egoVehicleWaypoints);
    std::vector<math::Vector2d_t> egoVehicleWaypoint2ds(egoVehicleWaypoints.size());
    std::transform(
        egoVehicleWaypoints.cbegin(),
        egoVehicleWaypoints.cend(),
        egoVehicleWaypoint2ds.begin(),
        [](const math::Vector3d_t &waypoint3d)
        {return math::Vector2d_t(waypoint3d.x(), waypoint3d.y());});
    mFrenetTransformer.Configure(egoVehicleWaypoint2ds);
}

// protected func.

// private func.

} // namespace fvcws {
} // namespace iso {
