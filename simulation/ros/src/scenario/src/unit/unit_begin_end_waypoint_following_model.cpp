#include <unit_begin_end_waypoint_following_model.h>
#include <stdexcept>
#include <ros/console.h>
#include <utils_json.h>
#include <math_utils.h>
#include <motion_config_reader.h>
#include <motion_waypoint_evaluator.h>
#include <motion_waypoint_smoother.h>
#include <motion_waypoint_translator.h>
#include <actor_config_reader.h>
#include <actor_utils.h>
#include <iso_config_reader.h>

namespace unit {

// public func.

BeginEndWaypointFollowingModel::BeginEndWaypointFollowingModel()
    : Model()
    , mMovingVehicles{}
    , mMotionConfigs{}
    , mWaypointFollowerManager{}
    , mFrenetDistanceEvaluator{}
    , mMoveTriggerMap{}
    , mAgentSpeedManager{}
{
    mEgoVehicleSpeedCommandSubscriber = mNodeHandle.subscribe(
        "speed_cmd",
        Model::DefaultQueueSize(),
        &BeginEndWaypointFollowingModel::EgoVehicleSpeedCommandCallback,
        this);
}

std::string BeginEndWaypointFollowingModel::GetId() const
{
    return std::string(AgentIdPrefix()) + std::string("model");
}

void BeginEndWaypointFollowingModel::Configure(const ModelConfig &config)
{
    Model::Configure<actor::Vehicle, actor::VehicleConfig>(
        config,
        std::string(AgentIdPrefix()),
        mMovingVehicles);
}

void BeginEndWaypointFollowingModel::Update()
{
    if (!mCanUpdate || !mDoneConfigureMotions)
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
            measure::FrenetDistanceData egoVehicleToAgentDistance;
            mFrenetDistanceEvaluator.Compute(
                mEgoVehicleObserver->GetWorldBoundingRect3d().topRight,
                (*movingVehicle)->GetWorldBoundingRect3d().bottomRight,
                true,
                &egoVehicleToAgentDistance);
            moveTriggerPair->second =
                egoVehicleToAgentDistance.distance.s() < motionConfig->moveTriggerDistance;
        }

        if (moveTriggerPair->second)
        {
            const auto speedMps{mAgentSpeedManager.QuerySpeed(*(*movingVehicle))};
            auto waypointFollower{
                mWaypointFollowerManager.QueryObject(
                    (*movingVehicle)->GetAttribute().id)};
            waypointFollower->Update(speedMps);
        }
    }

    mVisualizer->AppendVehicles(mMovingVehicles);
    Model::AppendVelocityMarkers(mMovingVehicles);
}

void BeginEndWaypointFollowingModel::AccessAgentAttributes(
    std::vector<scenario::AgentAttribute> *agentAttributes)
{
    Model::AccessAgentAttributes<actor::Vehicle>(
        agentAttributes,
        mMovingVehicles);
}

void BeginEndWaypointFollowingModel::RunCarlaUpdate(
    std::vector<carla::ActorUpdateData> *actorUpdateDatas)
{
    this->Update();
    Model::RunCarlaUpdate(
        actorUpdateDatas,
        mMovingVehicles);
}

// protected func.

// private func.

void BeginEndWaypointFollowingModel::ConfigureMotions()
{
    Model::ConfigureMotions(mMovingVehicles);
    
    std::function<decltype(motion::ParseBeginEndWaypointFollowingConfig)> parseFunc{
        motion::ParseBeginEndWaypointFollowingConfig};
    motion::ParseMotionConfigs(
        mConfigJsonValue["motion_configs"],
        parseFunc,
        &mMotionConfigs);
    if (mMovingVehicles.size() != mMotionConfigs.size())
    {
        ROS_ERROR_STREAM(
            "diff. sizes b/t mMovingVehicles & mMotionConfigs" << '\n' <<
            "mMovingVehicles: " << mMovingVehicles.size() << '\n' <<
            "mMotionConfigs: " << mMotionConfigs.size());
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
        const map::WaypointId beginWaypointId
        {
            .lane = motionConfig->beginLaneId,
            .point = motionConfig->beginPointId
        };
        const map::WaypointId endWaypointId
        {
            .lane = motionConfig->endLaneId,
            .point = motionConfig->endPointId
        };
        std::vector<math::Vector3d_t> refWaypoints;
        Model::ExecuteDijkstraPlanning(
            beginWaypointId,
            endWaypointId,
            refWaypoints);
        refWaypoints = waypointTranslator.Compute(
            refWaypoints,
            math::FrenetCoord(0.0, motionConfig->waypointLateralOffset),
            int32_t{0});
        const auto movingVehicleWaypoints{waypointSmoother.Compute(refWaypoints)};

        const int32_t movingVehicleBeginWaypointIdx{0};
        actor::ConfigureAgentInitStateTransform(
            movingVehicleBeginWaypointIdx,
            movingVehicleWaypoints,
            *movingVehicle);

        auto waypointFollower{std::make_shared<ctrl::WaypointFollower>()};
        waypointFollower->Configure(
            mTimeStep,
            *movingVehicle,
            movingVehicleWaypoints);
        mWaypointFollowerManager.Register(
            (*movingVehicle)->GetAttribute().id,
            waypointFollower);

        mAgentSpeedManager.Register(
            actor::SpeedConfigRegistrationData{
            .agentId = (*movingVehicle)->GetAttribute().id,
            .agentWaypoints = movingVehicleWaypoints,
            .initAgentFrenetCoord = (*movingVehicle)->GetFrenetState().position,
            .initAgentSpeedMps = motionConfig->initMovingSpeedMps,
            .waypointSpeedConfigs = motionConfig->speedConfigs});
    }

    mCanUpdate = true;

    //std::vector<std::string> isoAgentIds;
    //iso::ParseAgentIds(
    //    mConfigJsonValue["moving_agent_configs"],
    //    &isoAgentIds);
    //Model::RegisterIsoAgents(isoAgentIds, mMovingVehicles);
    mCanAccessAgentAttributes = true;
}

void BeginEndWaypointFollowingModel::EgoVehicleSpeedCommandCallback(const itri_msgs::speed_cmd &msg)
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
