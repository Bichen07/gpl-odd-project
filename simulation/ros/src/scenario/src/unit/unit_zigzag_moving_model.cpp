#include <unit_zigzag_moving_model.h>
#include <stdexcept>
#include <ros/console.h>
#include <utils_json.h>
#include <motion_config_reader.h>
#include <motion_utils.h>
#include <motion_waypoint_smoother.h>
#include <motion_waypoint_translator.h>
#include <actor_config_reader.h>
#include <actor_utils.h>

namespace unit {

// public func.

ZigzagMovingModel::ZigzagMovingModel()
    : Model()
    , mMovingVehicles{}
    , mMotionConfigs{}
    , mMoveTriggerMap{}
    , mAccumulatedTimeMap{}
    , mLateralSpeedEvaluatorManager{}
    , mWaypointFollowerManager{}
    , mFrenetDistanceEvaluator{}
{
    mEgoVehicleSpeedCommandSubscriber = mNodeHandle.subscribe(
        "speed_cmd",
        Model::DefaultQueueSize(),
        &ZigzagMovingModel::EgoVehicleSpeedCommandCallback,
        this);
}

std::string ZigzagMovingModel::GetId() const
{
    return std::string(AgentIdPrefix()) + std::string("model");
}

void ZigzagMovingModel::Configure(const ModelConfig &config)
{
    Model::Configure<actor::Vehicle, actor::VehicleConfig>(
        config,
        std::string(AgentIdPrefix()),
        mMovingVehicles);
}

void ZigzagMovingModel::Update()
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
        auto moveTriggerPair{
            mMoveTriggerMap.find((*movingVehicle)->GetAttribute().id)};
        if (!moveTriggerPair->second)
        {
            measure::FrenetDistanceData frenetDistanceData;
            mFrenetDistanceEvaluator.Compute(
                mEgoVehicleObserver->GetWorldBoundingRect3d().topRight,
                (*movingVehicle)->GetWorldBoundingRect3d().bottomRight,
                true,
                &frenetDistanceData);
            measure::FrenetDistanceData agentToEgoVehicleDistance;
            mFrenetDistanceEvaluator.Compute(
                (*movingVehicle)->GetWorldBoundingRect3d().topRight,
                mEgoVehicleObserver->GetWorldBoundingRect3d().bottomRight,
                true,
                &agentToEgoVehicleDistance);
            if (motionConfig->moveTriggerDistance >= 0)
            {
                moveTriggerPair->second =
                    frenetDistanceData.distance.s() < 
                    motionConfig->moveTriggerDistance;
            }
            else
            {
                moveTriggerPair->second = 
                    agentToEgoVehicleDistance.isObserverBehindTarget &&
                    agentToEgoVehicleDistance.distance.s() > 
                    - motionConfig->moveTriggerDistance;
            }
        }

        if (moveTriggerPair->second)
        {
            auto accumulatedTimePair{
                mAccumulatedTimeMap.find((*movingVehicle)->GetAttribute().id)};
            accumulatedTimePair->second += mTimeStep;

            auto lateralSpeedEvaluator{
                mLateralSpeedEvaluatorManager.QueryObject((*movingVehicle)->GetAttribute().id)};
            const auto lateralSpeed{
                lateralSpeedEvaluator->Compute(accumulatedTimePair->second)};
            const auto longitudinalSpeed = motion::ComputeLongitudinalSpeed(
                motionConfig->movingSpeedMps,
                lateralSpeed);

            auto waypointFollower{
                mWaypointFollowerManager.QueryObject(
                    (*movingVehicle)->GetAttribute().id)};
            waypointFollower->Update(
                longitudinalSpeed,
                lateralSpeed);
        }
    }

    mVisualizer->AppendVehicles(mMovingVehicles);
    Model::AppendVelocityMarkers(mMovingVehicles);
}

void ZigzagMovingModel::AccessAgentAttributes(
    std::vector<scenario::AgentAttribute> *agentAttributes)
{
        Model::AccessAgentAttributes<actor::Vehicle>(
        agentAttributes,
        mMovingVehicles);
}

void ZigzagMovingModel::RunCarlaUpdate(
    std::vector<carla::ActorUpdateData> *actorUpdateDatas)
{
    this->Update();
    Model::RunCarlaUpdate(
        actorUpdateDatas,
        mMovingVehicles);
}

// protected func.

// private func.

void ZigzagMovingModel::ConfigureMotions()
{
    Model::ConfigureMotions(mMovingVehicles);

    std::function<decltype(motion::ParseZigzagMovingConfig)> parseFunc{
        motion::ParseZigzagMovingConfig};
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
    motion::WaypointTranslator waypointTranslator;
    
    auto movingVehicle{mMovingVehicles.begin()};
    auto motionConfig{mMotionConfigs.cbegin()};
    for (; movingVehicle != mMovingVehicles.end();
         ++movingVehicle, ++motionConfig)
    {
        
        mMoveTriggerMap.insert(std::make_pair(
                (*movingVehicle)->GetAttribute().id,
                false));
        mAccumulatedTimeMap.insert(std::make_pair(
                (*movingVehicle)->GetAttribute().id, 
                math::real_t{0.0}));

        std::vector<math::Vector3d_t> refWaypoints;
        Model::ExecuteDijkstraPlanning(
            map::WaypointId(
                motionConfig->beginLaneId,
                motionConfig->beginPointId),
            map::WaypointId(
                motionConfig->endLaneId,
                motionConfig->endPointId),
            refWaypoints);
        refWaypoints = waypointSmoother.Compute(refWaypoints);

        const auto vehicleWaypoints = waypointTranslator.Compute(
            refWaypoints,
            math::FrenetCoord(0.0, motionConfig->lateralOffset),
            int32_t{0});

        auto waypointFollower{std::make_shared<ctrl::WaypointFollower>()};
        waypointFollower->Configure(
            mTimeStep,
            (*movingVehicle),
            vehicleWaypoints);
        mWaypointFollowerManager.Register(
            (*movingVehicle)->GetAttribute().id,
            waypointFollower);

        auto lateralSpeedEvaluator{std::make_shared<ctrl::LateralZigzagSpeedEvaluator>()};
        lateralSpeedEvaluator->Configure(
            motionConfig->maxLateralSpeedMps,
            motionConfig->minLateralSpeedMps,
            motionConfig->lateralSpeedFrequency,
            motionConfig->lateralSpeedPhaseRadian);
        mLateralSpeedEvaluatorManager.Register(
            (*movingVehicle)->GetAttribute().id,
            lateralSpeedEvaluator);

        const int32_t beginWaypointIdx{0};
        actor::ConfigureAgentInitStateTransform(
            beginWaypointIdx,
            vehicleWaypoints,
            (*movingVehicle));
    }

    mCanAccessAgentAttributes = true;
}

void ZigzagMovingModel::EgoVehicleSpeedCommandCallback(const itri_msgs::speed_cmd &msg)
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
