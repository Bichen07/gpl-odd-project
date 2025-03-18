#include <unit_adaptive_overtaking_model.h>
#include <stdexcept>
#include <ros/console.h>
#include <utils_converter.h>
#include <utils_json.h>
#include <motion_config_reader.h>
#include <motion_utils.h>
#include <motion_waypoint_smoother.h>
#include <actor_utils.h>

namespace unit {

// public func.

AdaptiveOvertakingModel::AdaptiveOvertakingModel()
    : Model()
    , mMovingVehicles{}
    , mMotionConfigs{}
    , mWaypointFollowerManager{}
    , mMovingToLaneLateralSpeedEvaluatorManager{}
    , mSurpassingLateralSpeedEvaluatorManager{}
    , mReturningLateralSpeedEvaluatorManager{}
    , mMovingToRoadsideLateralSpeedEvaluatorManager{}
    , mFrenetDistanceEvaluator{}
    , mMovingTriggerMap{}
    , mSurpassingTriggerMap{}
    , mReturningTriggerMap{}
    , mMovingToRoadsideTriggerMap{}
{
    mEgoVehicleSpeedCommandSubscriber = mNodeHandle.subscribe(
        "speed_cmd",
        Model::DefaultQueueSize(),
        &AdaptiveOvertakingModel::EgoVehicleSpeedCommandCallback,
        this);
}

std::string AdaptiveOvertakingModel::GetId() const
{
    return std::string(AgentIdPrefix()) + std::string("model");
}

void AdaptiveOvertakingModel::Configure(const ModelConfig &config)
{
    Model::Configure<actor::Vehicle, actor::VehicleConfig>(
        config,
        std::string(AgentIdPrefix()),
        mMovingVehicles);
    this->ConfigureMotions();
}

void AdaptiveOvertakingModel::Update()
{
    if (!mCanUpdate || !mDoneConfigureMotions)
    {
        mVisualizer->AppendVehicles(mMovingVehicles);
        return;
    }

    auto movingVehicle{mMovingVehicles.begin()};
    auto motionConfig{mMotionConfigs.cbegin()};
    for (; movingVehicle != mMovingVehicles.end();
         ++movingVehicle, ++motionConfig)
    {
        auto foundMovingTrigger{mMovingTriggerMap.find((*movingVehicle)->GetAttribute().id)};
        if (!foundMovingTrigger->second)
        {
            measure::FrenetDistanceData agentToEgoVehicleDistance;
            mFrenetDistanceEvaluator.Compute(
                (*movingVehicle)->GetWorldBoundingRect3d().topRight,
                mEgoVehicleObserver->GetWorldBoundingRect3d().bottomRight,
                true,
                &agentToEgoVehicleDistance);
            foundMovingTrigger->second =
                agentToEgoVehicleDistance.isObserverBehindTarget &&
                agentToEgoVehicleDistance.distance.s() >
                motionConfig->beginRelativeLongitudinalMovement.triggerDistance;
        }

        if (!foundMovingTrigger->second)
        {
            continue;
        }

        const math::real_t egoVehicleSpeed{
            mEgoVehicleObserver->GetState().linearVelocity.norm()};
        math::real_t longitudinalSpeed{
            egoVehicleSpeed + motionConfig->beginRelativeLongitudinalMovement.speedMps};
        auto movingToLaneLateralSpeedEvaluator{
            mMovingToLaneLateralSpeedEvaluatorManager.QueryObject(
                (*movingVehicle)->GetAttribute().id)};
        math::real_t lateralSpeed{
            movingToLaneLateralSpeedEvaluator->Compute(*(*movingVehicle))};

        auto foundSurpassingTrigger{
            mSurpassingTriggerMap.find((*movingVehicle)->GetAttribute().id)};
        if (!foundSurpassingTrigger->second)
        {
            measure::FrenetDistanceData agentToEgoVehicleDistance;
            mFrenetDistanceEvaluator.Compute(
                (*movingVehicle)->GetWorldBoundingRect3d().topRight,
                mEgoVehicleObserver->GetWorldBoundingRect3d().bottomRight,
                true,
                &agentToEgoVehicleDistance);
            foundSurpassingTrigger->second =
                agentToEgoVehicleDistance.isObserverBehindTarget &&
                agentToEgoVehicleDistance.distance.s() <
                motionConfig->surpassingRelativeLongitudinalMovement.triggerDistance;
        }

        if (foundSurpassingTrigger->second)
        {
            auto foundReturningTrigger{
                mReturningTriggerMap.find((*movingVehicle)->GetAttribute().id)};
            if (!foundReturningTrigger->second)
            {
                measure::FrenetDistanceData agentToEgoVehicleDistance;
                mFrenetDistanceEvaluator.Compute(
                    (*movingVehicle)->GetWorldBoundingRect3d().bottomRight,
                    mEgoVehicleObserver->GetWorldBoundingRect3d().topRight,
                    true,
                    &agentToEgoVehicleDistance);
                foundReturningTrigger->second =
                    !agentToEgoVehicleDistance.isObserverBehindTarget &&
                    agentToEgoVehicleDistance.distance.s() >
                    motionConfig->returningRelativeLongitudinalMovement.triggerDistance;
            }

            if (foundReturningTrigger->second)
            {
                longitudinalSpeed =
                    egoVehicleSpeed +
                    motionConfig->returningRelativeLongitudinalMovement.speedMps;
                auto returningLateralSpeedEvaluator{
                    mReturningLateralSpeedEvaluatorManager.QueryObject(
                        (*movingVehicle)->GetAttribute().id)};
                lateralSpeed = returningLateralSpeedEvaluator->Compute(
                    *(*movingVehicle));

                if ((*movingVehicle)->GetFrenetState().position.d() < math::real_t{0.1})
                {
                    longitudinalSpeed = motionConfig->leadingSpeedMps;

                    auto foundMovingToRoadsideTrigger{
                        mMovingToRoadsideTriggerMap.find((*movingVehicle)->GetAttribute().id)};
                    if (!foundMovingToRoadsideTrigger->second)
                    {
                        measure::FrenetDistanceData agentToEndWaypointDistance;
                        mFrenetDistanceEvaluator.Compute(
                            (*movingVehicle)->GetWorldBoundingRect3d().topRight,
                            mNavigationPath->QueryWaypoint(motionConfig->endWaypointId),
                            true,
                            &agentToEndWaypointDistance);
                        foundMovingToRoadsideTrigger->second =
                            agentToEndWaypointDistance.isObserverBehindTarget;
                    }

                    if (foundMovingToRoadsideTrigger->second)
                    {
                        auto movingToRoadsideLateralSpeedEvaluator{
                            mMovingToRoadsideLateralSpeedEvaluatorManager.QueryObject(
                                (*movingVehicle)->GetAttribute().id)};
                        lateralSpeed = movingToRoadsideLateralSpeedEvaluator->Compute(
                            *(*movingVehicle));
                    }
                }
            } // if (foundReturningTrigger->second)
            else
            {
                longitudinalSpeed =
                    egoVehicleSpeed +
                    motionConfig->surpassingRelativeLongitudinalMovement.speedMps;
                auto surpassingLateralSpeedEvaluator{
                    mSurpassingLateralSpeedEvaluatorManager.QueryObject(
                        (*movingVehicle)->GetAttribute().id)};
                lateralSpeed = surpassingLateralSpeedEvaluator->Compute(
                    *(*movingVehicle));
            } // if (foundReturningTrigger->second)
        } // if (foundSurpassingTrigger->second)

        auto waypointFollower{
            mWaypointFollowerManager.QueryObject(
                (*movingVehicle)->GetAttribute().id)};
        waypointFollower->Update(
            longitudinalSpeed,
            lateralSpeed);
    }

    mVisualizer->AppendVehicles(mMovingVehicles);
    Model::AppendVelocityMarkers(mMovingVehicles);
}

void AdaptiveOvertakingModel::AccessAgentAttributes(
    std::vector<scenario::AgentAttribute> *agentAttributes)
{
    Model::AccessAgentAttributes<actor::Vehicle>(
        agentAttributes,
        mMovingVehicles);
}

void AdaptiveOvertakingModel::RunCarlaUpdate(
    std::vector<carla::ActorUpdateData> *actorUpdateDatas)
{
    this->Update();
    Model::RunCarlaUpdate(
        actorUpdateDatas,
        mMovingVehicles);
}

// protected func.

// private func.

void AdaptiveOvertakingModel::ConfigureMotions()
{
    Model::ConfigureMotions(mMovingVehicles);
    std::function<decltype(motion::ParseAdaptiveOvertakingConfig)> parseFunc{
        motion::ParseAdaptiveOvertakingConfig};
    motion::ParseMotionConfigs(
        mConfigJsonValue["motion_configs"],
        parseFunc,
        mMotionConfigs);
    if (mMovingVehicles.size() != mMotionConfigs.size())
    {
        ROS_ERROR_STREAM(
            "diff. sizes b/t mMovingVehicles & mMotionConfigs" << '\n' <<
            "mMovingVehicles: " << mMovingVehicles.size() << '\n' <<
            "mMotionConfigs: " << mMotionConfigs.size());
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    motion::WaypointSmoother waypointSmoother;
    auto movingVehicle{mMovingVehicles.begin()};
    auto motionConfig{mMotionConfigs.cbegin()};
    for (; movingVehicle != mMovingVehicles.end();
         ++movingVehicle, ++motionConfig)
    {
        mMovingTriggerMap.insert(
            std::make_pair((*movingVehicle)->GetAttribute().id, false));
        mSurpassingTriggerMap.insert(
            std::make_pair((*movingVehicle)->GetAttribute().id, false));
        mReturningTriggerMap.insert(
            std::make_pair((*movingVehicle)->GetAttribute().id, false));
        mMovingToRoadsideTriggerMap.insert(
            std::make_pair((*movingVehicle)->GetAttribute().id, false));
        const map::WaypointId beginWaypointId
        {
            .lane = motionConfig->beginWaypointId.lane,
            .point = motionConfig->beginWaypointId.point
        };
        const map::WaypointId endWaypointId
        {
            .lane = motionConfig->endWaypointId.lane,
            .point = motionConfig->endWaypointId.point
        };
        std::vector<math::Vector3d_t> refWaypoints;
        Model::ExecuteDijkstraPlanning(
            beginWaypointId,
            endWaypointId,
            refWaypoints);
        const auto movingVehicleWaypoints{waypointSmoother.Compute(refWaypoints)};
        const int32_t movingVehicleBeginWaypointIdx{0};
        const math::FrenetCoord initOffset(
            math::real_t{0.0},
            motionConfig->beginLateralMovement.distance);
        actor::ConfigureAgentInitStateTransform(
            movingVehicleBeginWaypointIdx,
            movingVehicleWaypoints,
            initOffset,
            *movingVehicle);

        auto waypointFollower{std::make_shared<ctrl::WaypointFollower>()};
        waypointFollower->Configure(
            mTimeStep,
            *movingVehicle,
            movingVehicleWaypoints);
        mWaypointFollowerManager.Register(
            (*movingVehicle)->GetAttribute().id,
            waypointFollower);
        auto movingToLaneLateralSpeedEvaluator{
            std::make_shared<ctrl::EaseInOutLateralSpeedEvaluator>()};
        movingToLaneLateralSpeedEvaluator->Configure(
            mTimeStep,
            motionConfig->beginLateralMovement.speedMps,
            (*movingVehicle)->GetFrenetState().position.d(),
            (*movingVehicle)->GetFrenetState().position.d() -
            motionConfig->beginLateralMovement.distance);
        mMovingToLaneLateralSpeedEvaluatorManager.Register(
            (*movingVehicle)->GetAttribute().id,
            movingToLaneLateralSpeedEvaluator);

        auto surpassingLateralSpeedEvaluator{
            std::make_shared<ctrl::EaseInOutLateralSpeedEvaluator>()};
        surpassingLateralSpeedEvaluator->Configure(
            mTimeStep,
            motionConfig->surpassingLateralMovement.speedMps,
            (*movingVehicle)->GetFrenetState().position.d() -
            motionConfig->beginLateralMovement.distance,
            (*movingVehicle)->GetFrenetState().position.d() -
            motionConfig->beginLateralMovement.distance +
            motionConfig->surpassingLateralMovement.distance);
        mSurpassingLateralSpeedEvaluatorManager.Register(
            (*movingVehicle)->GetAttribute().id,
            surpassingLateralSpeedEvaluator);

        auto returningLateralSpeedEvaluator{
            std::make_shared<ctrl::EaseInOutLateralSpeedEvaluator>()};
        returningLateralSpeedEvaluator->Configure(
            mTimeStep,
            motionConfig->returningLateralMovement.speedMps,
            (*movingVehicle)->GetFrenetState().position.d() -
            motionConfig->beginLateralMovement.distance +
            motionConfig->surpassingLateralMovement.distance,
            (*movingVehicle)->GetFrenetState().position.d() -
            motionConfig->beginLateralMovement.distance);
        mReturningLateralSpeedEvaluatorManager.Register(
            (*movingVehicle)->GetAttribute().id,
            returningLateralSpeedEvaluator);

        auto movingToRoadsideLateralSpeedEvaluator{
            std::make_shared<ctrl::EaseInOutLateralSpeedEvaluator>()};
        movingToRoadsideLateralSpeedEvaluator->Configure(
            mTimeStep,
            motionConfig->movingToRoadsideLateralMovement.speedMps,
            (*movingVehicle)->GetFrenetState().position.d() -
            motionConfig->beginLateralMovement.distance,
            motionConfig->movingToRoadsideLateralMovement.distance);
        mMovingToRoadsideLateralSpeedEvaluatorManager.Register(
            (*movingVehicle)->GetAttribute().id,
            movingToRoadsideLateralSpeedEvaluator);
    }

    mDoneConfigureMotions = true;
    mCanAccessAgentAttributes = true;
}

void AdaptiveOvertakingModel::EgoVehicleSpeedCommandCallback(const itri_msgs::speed_cmd &msg)
{
    if (msg.kph <= 0.0f)
    {
        return;
    }

    if (mNavigationPath->IsReady())
    {
        mFrenetDistanceEvaluator.Configure(mNavigationPath->GetEgoVehicleGlobalPath());
        mEgoVehicleSpeedCommandSubscriber.shutdown();
        mCanUpdate = true;
        mEgoVehicleSpeedCommandSubscriber.shutdown();
    }
}

} // namespace unit {
