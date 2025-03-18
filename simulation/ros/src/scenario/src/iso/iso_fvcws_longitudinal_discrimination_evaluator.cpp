#include <iso_fvcws_longitudinal_discrimination_evaluator.h>
#include <stdexcept>
#include <ros/console.h>
#include <std_msgs/Bool.h>
#include <math_utils.h>
#include <utils_converter.h>
#include <actor_utils.h>
#include <iso_specification.h>
#include <iso_test_scenario_agent_id.h>
#include <iso_utils.h>

namespace iso {
namespace fvcws {

// public func.

LongitudinalDiscriminationEvaluator::LongitudinalDiscriminationEvaluator()
    : mNodeHandle{}
    , mService{}
    , mSubjectAccelerationWarningPublisher{}
    , mEgoVehicleObserver{nullptr}
    , mAgentManager{nullptr}
    , mTimeGapEvaluator{}
    , mPreviousLongitudinalDiscriminationStateId{LongitudinalDiscriminationState::Null}
    , mTimeStepEvaluator{}
    , mFrenetTransformer{}
    , mCurrentEgoVehicleSpeed{0.0}
    , mPreviousEgoVehicleSpeed{0.0}
    , mStableInitFollowingTime{0.0}
    , mStableInitFollowingElapsedTime{0.0}
    , mBeforeTargetDecelerationStableFollowingTime{0.0}
{
    mService = mNodeHandle.advertiseService(
        "iso_fvcws_longitudinal_discrimination_evaluation",
        &LongitudinalDiscriminationEvaluator::RunService,
        this);
    mSubjectAccelerationWarningPublisher = mNodeHandle.advertise<std_msgs::Bool>(
        "iso/fvcws/longitudinal_discrimination/subject_acceleration_warning",
        int32_t{1});
}

LongitudinalDiscriminationEvaluator::~LongitudinalDiscriminationEvaluator()
{
}

LongitudinalDiscriminationStateId LongitudinalDiscriminationEvaluator::Evaluate(
    const VehicleAttribute &nearTargetVehicleAttribute,
    const VehicleState &nearTargetVehicleState)
{
    mPreviousEgoVehicleSpeed = mCurrentEgoVehicleSpeed;
    mCurrentEgoVehicleSpeed = mEgoVehicleObserver->GetState().linearVelocity.norm();
    const auto timeStep{mTimeStepEvaluator.Compute()};
    if (timeStep < math::real_t{1.0e-6})
    {
        ROS_ERROR_STREAM("invalid timeStep: " << timeStep);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    const auto egoVehicleAcceleration =
        (mCurrentEgoVehicleSpeed - mPreviousEgoVehicleSpeed) /
        timeStep;

    if (LongitudinalDiscriminationState::PassTest == mPreviousLongitudinalDiscriminationStateId)
    {
        return mPreviousLongitudinalDiscriminationStateId;
    }

    if (math::IsApproxZero(nearTargetVehicleState.linearVelocity.norm(), math::real_t{1.0e-3}))
    {
        mPreviousLongitudinalDiscriminationStateId = LongitudinalDiscriminationState::BeforeInitialCondition;
        return LongitudinalDiscriminationState::BeforeInitialCondition;
    }

    const math::real_t timeGap{
        mTimeGapEvaluator.ComputeTimeGap(
            nearTargetVehicleAttribute,
            nearTargetVehicleState)};
    const bool isTimeGapInInitFollowingRange = math::IsInRange(
        timeGap,
        LongitudinalDiscrimination::DesiredTimeGap() - math::real_t{0.2},
        LongitudinalDiscrimination::DesiredTimeGap() + math::real_t{0.1});

    if (!isTimeGapInInitFollowingRange &&
        LongitudinalDiscriminationState::BeforeInitialCondition == mPreviousLongitudinalDiscriminationStateId)
    {
        ROS_INFO_STREAM("timeGap: " << timeGap);
        mPreviousLongitudinalDiscriminationStateId = LongitudinalDiscriminationState::BeforeInitialCondition;
        return LongitudinalDiscriminationState::BeforeInitialCondition;
    }

    const bool isValidInitFollowingPreviousState =
        LongitudinalDiscriminationState::BeforeInitialCondition == mPreviousLongitudinalDiscriminationStateId ||
        LongitudinalDiscriminationState::InitFollowing == mPreviousLongitudinalDiscriminationStateId;

    ROS_INFO_STREAM("timeGap: " << timeGap);
    if ((isTimeGapInInitFollowingRange && isValidInitFollowingPreviousState) ||
        (mStableInitFollowingTime > math::real_t{0.0} && mStableInitFollowingElapsedTime < 2.0))
    {
        if (std::fabs(egoVehicleAcceleration) < math::real_t{0.5} &&
            math::IsApproxZero(mStableInitFollowingTime, math::real_t{1.0e-6}))
        {
            mStableInitFollowingTime = ros::Time::now().toSec();
            ROS_WARN_STREAM("mStableInitFollowingTime: " << mStableInitFollowingTime);
        }

        mStableInitFollowingElapsedTime = ros::Time::now().toSec() - mStableInitFollowingTime;
        ROS_WARN_STREAM("elapsedTime: " << mStableInitFollowingElapsedTime);
        if (mStableInitFollowingElapsedTime > math::real_t{2.0})
        {
            mPreviousLongitudinalDiscriminationStateId =
                LongitudinalDiscriminationState::SubjectAcceleratingTriggerWarning;
            return LongitudinalDiscriminationState::SubjectAcceleratingTriggerWarning;
        }

        mPreviousLongitudinalDiscriminationStateId = LongitudinalDiscriminationState::InitFollowing;
        return LongitudinalDiscriminationState::InitFollowing;
    }

    static constexpr const char *isoFvcwsSubjectAcceleratingTriggerKey{
        "iso_fvcws_subject_accelerating_trigger"};
    static constexpr const char *isoFvcwsSubjectAcceleratingWarningKey{
        "iso_fvcws_subject_accelerating_warning"};
    if (LongitudinalDiscriminationState::SubjectAcceleratingTriggerWarning ==
        mPreviousLongitudinalDiscriminationStateId)
    {
        ros::param::set(isoFvcwsSubjectAcceleratingTriggerKey, true);

        bool hasWarning{false};
        //ROS_WARN_STREAM("hasWarning: " << hasWarning);
        if (ros::param::get(isoFvcwsSubjectAcceleratingWarningKey, hasWarning))
        {
            if (hasWarning)
            {
                const bool isValidWarningDistance{this->IsValidWarningDistance(
                        *mEgoVehicleObserver,
                        nearTargetVehicleAttribute,
                        nearTargetVehicleState)};
                ROS_INFO_STREAM(
                    "get first warning, " <<
                    "isValidWarningDistance: " << isValidWarningDistance);

                if (isValidWarningDistance)
                {
                    std_msgs::Bool warningMsg;
                    warningMsg.data = true;
                    mSubjectAccelerationWarningPublisher.publish(warningMsg);
                    ros::param::set(isoFvcwsSubjectAcceleratingTriggerKey, false);
                    ros::param::set(isoFvcwsSubjectAcceleratingWarningKey, false);
                    mPreviousLongitudinalDiscriminationStateId =
                        LongitudinalDiscriminationState::AfterFirstWarningFollowing;
                    return LongitudinalDiscriminationState::AfterFirstWarningFollowing;
                }
                else
                {
                    mPreviousLongitudinalDiscriminationStateId =
                        LongitudinalDiscriminationState::FailTest;
                    return LongitudinalDiscriminationState::FailTest;
                }
            }

            mPreviousLongitudinalDiscriminationStateId =
                LongitudinalDiscriminationState::SubjectAcceleratingTriggerWarning;
            return LongitudinalDiscriminationState::SubjectAcceleratingTriggerWarning;
        }

        mPreviousLongitudinalDiscriminationStateId =
            LongitudinalDiscriminationState::SubjectAcceleratingTriggerWarning;
        return LongitudinalDiscriminationState::SubjectAcceleratingTriggerWarning;
    }

    if (LongitudinalDiscriminationState::AfterFirstWarningFollowing ==
        mPreviousLongitudinalDiscriminationStateId)
    {
        const bool isTimeGapInRange = math::IsInRange(
            timeGap,
            LongitudinalDiscrimination::DesiredTimeGap() - math::real_t{0.5},
            LongitudinalDiscrimination::DesiredTimeGap() + math::real_t{0.1});
        ROS_INFO_STREAM("isTimeGapInRange: " << isTimeGapInRange);
        if (isTimeGapInRange ||
            mBeforeTargetDecelerationStableFollowingTime > math::real_t{0.0})
        {
            if (math::IsApproxZero(mBeforeTargetDecelerationStableFollowingTime, math::real_t{1.0e-6}))
            {
                mBeforeTargetDecelerationStableFollowingTime = ros::Time::now().toSec();
            }

            const math::real_t elapsedTime =
                ros::Time::now().toSec() -
                mBeforeTargetDecelerationStableFollowingTime;
            ROS_WARN_STREAM("2nd elapsedTime: " << elapsedTime);
            if (elapsedTime > math::real_t{5.0})
            {
                const auto nearTargetVehicleId{
                    mAgentManager->QueryAgentId(
                        iso::fvcws::LongitudinalDiscriminationAgent::NearTargetVehicle())};
                actor::UpdateAgentSpeed(
                    nearTargetVehicleId,
                    math::real_t{9.0});

                static constexpr const char *isoFvcwsNearTargetDecelerationKey{
                    "iso_fvcws_near_target_deceleration"};
                ros::param::set(
                    isoFvcwsNearTargetDecelerationKey,
                    true);

                static constexpr const char *isoFvcwsNearTargetDecelerationWarningKey{
                    "iso_fvcws_near_target_decelerating_warning"};
                bool hasWarning{false};
                ros::param::get(isoFvcwsNearTargetDecelerationWarningKey, hasWarning);
                ROS_WARN_STREAM("has near-target deceleration warning: " << hasWarning);
                if (hasWarning)
                {
                    const bool isValidWarningDistance{this->IsValidWarningDistance(
                            *mEgoVehicleObserver,
                            nearTargetVehicleAttribute,
                            nearTargetVehicleState)};

                    if (isValidWarningDistance)
                    {
                        ros::param::set(
                            isoFvcwsNearTargetDecelerationKey,
                            false);
                        mPreviousLongitudinalDiscriminationStateId =
                            LongitudinalDiscriminationState::PassTest;
                        return LongitudinalDiscriminationState::PassTest;
                    }
                    else
                    {
                        mPreviousLongitudinalDiscriminationStateId =
                            LongitudinalDiscriminationState::FailTest;
                        return LongitudinalDiscriminationState::FailTest;
                    }
                }
            }
        }

        mPreviousLongitudinalDiscriminationStateId =
            LongitudinalDiscriminationState::AfterFirstWarningFollowing;
        return LongitudinalDiscriminationState::AfterFirstWarningFollowing;
    }

    //ROS_ERROR_STREAM("stateId: " << LongitudinalDiscriminationState::FailTest);
    //throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    mPreviousLongitudinalDiscriminationStateId = LongitudinalDiscriminationState::FailTest;
    return LongitudinalDiscriminationState::FailTest;
}

bool LongitudinalDiscriminationEvaluator::RunService(
    scenario::IsoFvcwsLongitudinalDiscriminationEvaluation::Request &request,
    scenario::IsoFvcwsLongitudinalDiscriminationEvaluation::Response &response)
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

    const std::string nearTargetVehicleAgentId{
        mAgentManager->QueryAgentId(
            fvcws::LongitudinalDiscriminationAgent::NearTargetVehicle())};
    const std::string nearTargetVehicleCarlaActorIdKey =
        "simulation/agents/idMatching/car/" +
        nearTargetVehicleAgentId;

    if (!mNodeHandle.hasParam(nearTargetVehicleCarlaActorIdKey))
    {
        ROS_ERROR_STREAM(
            "invalid nearTargetVehicleCarlaActorIdKey: " <<
            nearTargetVehicleCarlaActorIdKey);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    int32_t nearTargetVehicleCarlaActorId{0};
    mNodeHandle.getParam(nearTargetVehicleCarlaActorIdKey, nearTargetVehicleCarlaActorId);
    const auto nearTargetVehicleAttribute{
        this->ExtractVehicleAttribute(
            std::to_string(nearTargetVehicleCarlaActorId),
            request.attributes)};
    const auto nearTargetVehicleState{
        this->ExtractVehicleState(
            std::to_string(nearTargetVehicleCarlaActorId),
            request.states)};
    const auto stateId{
        this->Evaluate(
            nearTargetVehicleAttribute,
            nearTargetVehicleState)};
    response.performance.state = static_cast<int8_t>(stateId);
    ROS_INFO_STREAM("stateId: " << stateId);

    return true;
}

void LongitudinalDiscriminationEvaluator::Configure(
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

VehicleAttribute LongitudinalDiscriminationEvaluator::ExtractVehicleAttribute(
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

VehicleState LongitudinalDiscriminationEvaluator::ExtractVehicleState(
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

bool LongitudinalDiscriminationEvaluator::IsValidWarningDistance(
    const actor::EgoVehicleObserver &egoVehicleObserver,
    const VehicleAttribute &nearTargetVehicleAttribute,
    const VehicleState &nearTargetVehicleState) const
{
    const auto relativeSpeed =
        nearTargetVehicleState.linearVelocity.norm() -
        egoVehicleObserver.GetState().linearVelocity.norm();
    auto minWarningDistance{
        iso::fvcws::ComputeMinWarningDistance(
            relativeSpeed,
            nearTargetVehicleState.linearAcceleration.norm())};
    if (relativeSpeed < fvcws::LongitudinalDiscrimination::MinRelativeSpeed())
    {
        minWarningDistance = iso::fvcws::ComputeMinWarningDistance(
            fvcws::LongitudinalDiscrimination::MinRelativeSpeed(),
            nearTargetVehicleState.linearAcceleration.norm());
    }

    const auto egoVehicleFrenetCoord{
        mFrenetTransformer.ConvertToFrenetCoord(
            egoVehicleObserver.GetTransform2d().translation())};
    const auto nearTargetVehicleFrenetCoord{
        mFrenetTransformer.ConvertToFrenetCoord(
            utils::ConvertToVector2d(nearTargetVehicleState.pose.translation()))};
    const auto relativeDistance =
        nearTargetVehicleFrenetCoord.s() -
        egoVehicleFrenetCoord.s() -
        0.5 * egoVehicleObserver.GetSize().x() -
        0.5 * nearTargetVehicleAttribute.size.x();

    const auto isValidWarningDistance = relativeDistance > minWarningDistance ? true : false;
    if (!isValidWarningDistance)
    {
        ROS_ERROR_STREAM("invalid warning distance: " << relativeDistance);
    }
    return isValidWarningDistance;
    //return relativeDistance > minWarningDistance ? true : false;
}

} // namespace fcw {
} // namespace iso {
