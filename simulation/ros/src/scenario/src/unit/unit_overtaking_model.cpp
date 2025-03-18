#include <unit_overtaking_model.h>
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

OvertakingModel::OvertakingModel()
    : Model()
    , mMovingVehicles{}
    , mMotionConfigs{}
    , mWaypointFollowerManager{}
    , mMoveToLaneLateralSpeedEvaluatorManager{}
    , mOvertakingLateralSpeedEvaluatorManager{}
    , mReturningLateralSpeedEvaluatorManager{}
    , mMoveToRoadsideLateralSpeedEvaluatorManager{}
    , mFrenetDistanceEvaluator{}
    , mMoveToRoadsideTriggerDistanceMap{}
    , mMoveTriggerMap{}
    , mOvertakingTriggerMap{}
    , mReturningTriggerMap{}
    , mMoveToRoadsideTriggerMap{}
{
    mEgoVehicleSpeedCommandSubscriber = mNodeHandle.subscribe(
        "speed_cmd",
        Model::DefaultQueueSize(),
        &OvertakingModel::EgoVehicleSpeedCommandCallback,
        this);
}

std::string OvertakingModel::GetId() const
{
    return std::string(AgentIdPrefix()) + std::string("model");
}

void OvertakingModel::Configure(const ModelConfig &config)
{
    Model::Configure<actor::Vehicle, actor::VehicleConfig>(
        config,
        std::string(AgentIdPrefix()),
        mMovingVehicles);
}

void OvertakingModel::Update()
{
    if (mMovingVehicles.empty() || !mDoneConfigureMotions)
    {
        return;
    }

    auto movingVehicle{mMovingVehicles.begin()};
    auto motionConfig{mMotionConfigs.cbegin()};
    for (; movingVehicle != mMovingVehicles.end();
         ++movingVehicle, ++motionConfig)
    {
        auto moveTriggerPair{mMoveTriggerMap.find((*movingVehicle)->GetAttribute().id)};
        if (!moveTriggerPair->second)
        {
            measure::FrenetDistanceData agentToEgoVehicleDistance;
            mFrenetDistanceEvaluator.Compute(
                (*movingVehicle)->GetWorldBoundingRect3d().topRight,
                mEgoVehicleObserver->GetWorldBoundingRect3d().bottomRight,
                true,
                &agentToEgoVehicleDistance);
            moveTriggerPair->second =
                agentToEgoVehicleDistance.isObserverBehindTarget &&
                agentToEgoVehicleDistance.distance.s() > motionConfig->moveTriggerDistance;
        }

        if (!moveTriggerPair->second)
        {
            continue;
        }

        math::real_t resultantMovingSpeed{motionConfig->movingSpeedMps};
        auto moveToLaneLateralSpeedEvaluator{
            mMoveToLaneLateralSpeedEvaluatorManager.QueryObject(
                (*movingVehicle)->GetAttribute().id)};
        math::real_t lateralSpeed{
            moveToLaneLateralSpeedEvaluator->Compute(*(*movingVehicle))};

        auto overtakingTriggerPair{
            mOvertakingTriggerMap.find((*movingVehicle)->GetAttribute().id)};
        if (!overtakingTriggerPair->second)
        {
            measure::FrenetDistanceData agentToEgoVehicleDistance;
            mFrenetDistanceEvaluator.Compute(
                (*movingVehicle)->GetWorldBoundingRect3d().topRight,
                mEgoVehicleObserver->GetWorldBoundingRect3d().bottomRight,
                true,
                &agentToEgoVehicleDistance);
            overtakingTriggerPair->second =
                agentToEgoVehicleDistance.isObserverBehindTarget &&
                agentToEgoVehicleDistance.distance.s() < motionConfig->overtakingTriggerDistance;
        }

        if (overtakingTriggerPair->second)
        {
            auto returningTriggerPair{
                mReturningTriggerMap.find((*movingVehicle)->GetAttribute().id)};
            if (!returningTriggerPair->second)
            {
                measure::FrenetDistanceData agentToEgoVehicleDistance;
                mFrenetDistanceEvaluator.Compute(
                    (*movingVehicle)->GetWorldBoundingRect3d().bottomRight,
                    mEgoVehicleObserver->GetWorldBoundingRect3d().topRight,
                    true,
                    &agentToEgoVehicleDistance);
                returningTriggerPair->second =
                    !agentToEgoVehicleDistance.isObserverBehindTarget &&
                    agentToEgoVehicleDistance.distance.s() > motionConfig->returningTriggerDistance;
            }

            resultantMovingSpeed = motionConfig->overtakingSpeedMps;
            if (returningTriggerPair->second)
            {
                resultantMovingSpeed = motionConfig->returningSpeedMps;
                auto returningLateralSpeedEvaluator{
                    mReturningLateralSpeedEvaluatorManager.QueryObject(
                        (*movingVehicle)->GetAttribute().id)};
                lateralSpeed = returningLateralSpeedEvaluator->Compute(
                    *(*movingVehicle));

                if ((*movingVehicle)->GetFrenetState().position.d() < math::real_t{0.1})
                {
                    resultantMovingSpeed = motionConfig->leadingSpeedMps;

                    const auto moveToRoadsideTriggerDistancePair{
                        mMoveToRoadsideTriggerDistanceMap.find(
                            (*movingVehicle)->GetAttribute().id)};

                    if ((*movingVehicle)->GetFrenetState().position.s() >
                        moveToRoadsideTriggerDistancePair->second)
                    {
                        auto moveToRoadsideLateralSpeedEvaluator{
                            mMoveToRoadsideLateralSpeedEvaluatorManager.QueryObject(
                                (*movingVehicle)->GetAttribute().id)};
                        lateralSpeed = moveToRoadsideLateralSpeedEvaluator->Compute(
                            *(*movingVehicle));
                    }
                }
            }
            else
            {
                auto overtakingLateralSpeedEvaluator{
                    mOvertakingLateralSpeedEvaluatorManager.QueryObject(
                        (*movingVehicle)->GetAttribute().id)};
                lateralSpeed = overtakingLateralSpeedEvaluator->Compute(
                    *(*movingVehicle));
                //ROS_WARN_STREAM("lateralSpeed: " << motion::ConvertToKph(lateralSpeed));
            }
        }

        //ROS_INFO_STREAM('\n' <<
        //    "resultantMovingSpeed: " << motion::ConvertToKph(resultantMovingSpeed) << '\n' <<
        //    "lateralSpeed: " << motion::ConvertToKph(lateralSpeed));
        const auto longitudinalSpeed{motion::ComputeLongitudinalSpeed(
                resultantMovingSpeed,
                lateralSpeed)};
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

void OvertakingModel::AccessAgentAttributes(
    std::vector<scenario::AgentAttribute> *agentAttributes)
{
    Model::AccessAgentAttributes<actor::Vehicle>(
        agentAttributes,
        mMovingVehicles);
}

void OvertakingModel::RunCarlaUpdate(
    std::vector<carla::ActorUpdateData> *actorUpdateDatas)
{
    this->Update();
    Model::RunCarlaUpdate(
        actorUpdateDatas,
        mMovingVehicles);
}

// protected func.

// private func.

void OvertakingModel::ConfigureMotions()
{
    Model::ConfigureMotions(mMovingVehicles);

    std::function<void (const Json::Value &, motion::OvertakingConfig *)> parseFunc{
        motion::ParseOvertakingConfig};
    motion::ParseMotionConfigs(
        mConfigJsonValue["motion_configs"],
        parseFunc,
        &mMotionConfigs);
    if (mMovingVehicles.size() != mMotionConfigs.size())
    {
        ROS_ERROR_STREAM(
            "diff. sizes b/t mMovingVehicles & mMotionConfigs" << '\n' <<
            "mMovingVehicles: " << mMovingVehicles.size() << '\n' <<
            "mMotionConfigs" << mMotionConfigs.size());
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    mFrenetDistanceEvaluator.Configure(mNavigationPath->GetEgoVehicleGlobalPath());
    motion::WaypointSmoother waypointSmoother;

    auto movingVehicle{mMovingVehicles.begin()};
    auto motionConfig{mMotionConfigs.cbegin()};
    for (; movingVehicle != mMovingVehicles.end();
         ++movingVehicle, ++motionConfig)
    {
        mMoveTriggerMap.insert(
            std::make_pair((*movingVehicle)->GetAttribute().id, false));
        mOvertakingTriggerMap.insert(
            std::make_pair((*movingVehicle)->GetAttribute().id, false));
        mReturningTriggerMap.insert(
            std::make_pair((*movingVehicle)->GetAttribute().id, false));
        mMoveToRoadsideTriggerMap.insert(
            std::make_pair((*movingVehicle)->GetAttribute().id, false));
        std::vector<math::Vector3d_t> refWaypoints;
        Model::ExecuteDijkstraPlanning(
            map::WaypointId(
                motionConfig->beginLaneId,
                motionConfig->beginPointId),
            map::WaypointId(
                motionConfig->endLaneId,
                motionConfig->endPointId),
            refWaypoints);
        const auto movingVehicleWaypoints{waypointSmoother.Compute(refWaypoints)};
        const int32_t movingVehicleBeginWaypointIdx{0};
        const math::FrenetCoord initOffset(
            math::real_t{0.0},
            motionConfig->beginLateralOffset);
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
        auto moveToLaneLateralSpeedEvaluator{
            std::make_shared<ctrl::EaseInOutLateralSpeedEvaluator>()};
        moveToLaneLateralSpeedEvaluator->Configure(
            mTimeStep,
            motionConfig->beginLateralSpeedMps,
            (*movingVehicle)->GetFrenetState().position.d(),
            (*movingVehicle)->GetFrenetState().position.d() - motionConfig->beginLateralOffset);
        mMoveToLaneLateralSpeedEvaluatorManager.Register(
            (*movingVehicle)->GetAttribute().id,
            moveToLaneLateralSpeedEvaluator);

        auto overtakingLateralSpeedEvaluator{
            std::make_shared<ctrl::EaseInOutLateralSpeedEvaluator>()};
        overtakingLateralSpeedEvaluator->Configure(
            mTimeStep,
            motionConfig->overtakingLateralSpeedMps,
            (*movingVehicle)->GetFrenetState().position.d(),
            (*movingVehicle)->GetFrenetState().position.d() -
            motionConfig->beginLateralOffset +
            motionConfig->overtakingLateralDistance);
        mOvertakingLateralSpeedEvaluatorManager.Register(
            (*movingVehicle)->GetAttribute().id,
            overtakingLateralSpeedEvaluator);

        auto returningLateralSpeedEvaluator{
            std::make_shared<ctrl::EaseInOutLateralSpeedEvaluator>()};
        returningLateralSpeedEvaluator->Configure(
            mTimeStep,
            motionConfig->returningLateralSpeedMps,
            (*movingVehicle)->GetFrenetState().position.d() -
            motionConfig->beginLateralOffset +
            motionConfig->overtakingLateralDistance,
            (*movingVehicle)->GetFrenetState().position.d() -
            motionConfig->beginLateralOffset);
        mReturningLateralSpeedEvaluatorManager.Register(
            (*movingVehicle)->GetAttribute().id,
            returningLateralSpeedEvaluator);

        auto moveToRoadsideLateralSpeedEvaluator{
            std::make_shared<ctrl::EaseInOutLateralSpeedEvaluator>()};
        moveToRoadsideLateralSpeedEvaluator->Configure(
            mTimeStep,
            motionConfig->endLateralSpeedMps,
            (*movingVehicle)->GetFrenetState().position.d() - motionConfig->beginLateralOffset,
            motionConfig->endLateralOffset);
        mMoveToRoadsideLateralSpeedEvaluatorManager.Register(
            (*movingVehicle)->GetAttribute().id,
            moveToRoadsideLateralSpeedEvaluator);

        const auto moveToRoadsideTriggerWaypoint{
            mNavigationPath->QueryWaypoint(
                motionConfig->moveToRoadsideTriggerLaneId,
                motionConfig->moveToRoadsideTriggerPointId)};
        measure::FrenetDistanceData moveToRoadsideTriggerDistance;
        mFrenetDistanceEvaluator.Compute(
            (*movingVehicle)->GetWorldBoundingRect3d().topRight,
            moveToRoadsideTriggerWaypoint,
            true,
            &moveToRoadsideTriggerDistance);
        mMoveToRoadsideTriggerDistanceMap.insert(
            std::make_pair(
                (*movingVehicle)->GetAttribute().id,
                moveToRoadsideTriggerDistance.distance.s()));
    }

    mCanAccessAgentAttributes = true;
}

void OvertakingModel::EgoVehicleSpeedCommandCallback(const itri_msgs::speed_cmd &msg)
{
    if (msg.kph <= 0.0f)
    {
        return;
    }

    this->ConfigureMotions();
    mDoneConfigureMotions = true;
    mEgoVehicleSpeedCommandSubscriber.shutdown();
}

} // namespace unit {
