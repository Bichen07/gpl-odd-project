#include <unit_dijkstra_waypoint_following_model.h>
#include <stdexcept>
#include <ros/console.h>
#include <utils_default_color.h>
#include <utils_json.h>
#include <math_utils.h>
#include <motion_config_reader.h>
#include <motion_waypoint_evaluator.h>
#include <motion_waypoint_smoother.h>
#include <motion_waypoint_translator.h>
#include <actor_agent_based_trigger_ref_position.h>
#include <actor_config_reader.h>
#include <actor_utils.h>

namespace unit {

// public func.

DijkstraWaypointFollowingModel::DijkstraWaypointFollowingModel()
    : Model()
    , mMovingVehicles{}
    , mMotionConfigs{}
    , mWaypointFollowerManager{}
    , mMoveTriggerManager{}
    , mFrenetDistanceEvaluator{}
    , mMoveTriggerMap{}
    , mAgentSpeedManager{}
{
    mEgoVehicleSpeedCommandSubscriber = mNodeHandle.subscribe(
        "speed_cmd",
        Model::DefaultQueueSize(),
        &DijkstraWaypointFollowingModel::EgoVehicleSpeedCommandCallback,
        this);
    mEgoVehicleGlobalPathSubscriber = mNodeHandle.subscribe(
        "global_path",
        Model::DefaultQueueSize(),
        &DijkstraWaypointFollowingModel::EgoVehicleGlobalPathCallback,
        this);
}

std::string DijkstraWaypointFollowingModel::GetId() const
{
    return std::string(AgentIdPrefix()) + std::string("model");
}

void DijkstraWaypointFollowingModel::Configure(const ModelConfig &config)
{
    Model::Configure<actor::Vehicle, actor::VehicleConfig>(
        config,
        std::string(AgentIdPrefix()),
        mMovingVehicles);
    this->ConfigureMotions();
}

void DijkstraWaypointFollowingModel::Update()
{
    if (!mCanUpdate || !mDoneConfigureMotions || !mIsEgoVehicleSpeedCommandReady)
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
            auto moveTrigger{
                mMoveTriggerManager.QueryObject(
                    (*movingVehicle)->GetAttribute().id)};
            measure::FrenetDistanceData egoVehicleToAgentDistance;
            mFrenetDistanceEvaluator.Compute(
                mEgoVehicleObserver->GetWorldBoundingRect3d().topRight,
                moveTrigger->GetRefPosition(),
                true,
                egoVehicleToAgentDistance,
                utils::FileLineNumPairInstance());

            const motion::SpatialRelationId spatialRelationId =
                egoVehicleToAgentDistance.isObserverBehindTarget ?
                motion::SpatialRelation::AheadOfEgoVehicle :
                motion::SpatialRelation::BehindEgoVehicle;
            const motion::MoveTriggerState currentState(
                spatialRelationId,
                egoVehicleToAgentDistance.distance.s());
            moveTriggerPair->second = (*moveTrigger)(currentState);
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

void DijkstraWaypointFollowingModel::AccessAgentAttributes(
    std::vector<scenario::AgentAttribute> *agentAttributes)
{
    Model::AccessAgentAttributes<actor::Vehicle>(
        agentAttributes,
        mMovingVehicles);
}

void DijkstraWaypointFollowingModel::RunCarlaUpdate(
    std::vector<carla::ActorUpdateData> *actorUpdateDatas)
{
    this->Update();
    Model::RunCarlaUpdate(
        actorUpdateDatas,
        mMovingVehicles);
}

// protected func.

// private func.

void DijkstraWaypointFollowingModel::ConfigureMotions()
{
    Model::ConfigureMotions(mMovingVehicles);

    std::function<decltype(motion::ParseDijkstraWaypointFollowingConfig)> parseFunc{
        motion::ParseDijkstraWaypointFollowingConfig};
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
    motion::WaypointTranslator waypointTranslator;
    auto movingVehicle{mMovingVehicles.begin()};
    auto motionConfig{mMotionConfigs.cbegin()};
    for (; movingVehicle != mMovingVehicles.end();
         ++movingVehicle, ++motionConfig)
    {
        mMoveTriggerMap.insert(
            std::make_pair(
                (*movingVehicle)->GetAttribute().id,
                false));
        std::vector<math::Vector3d_t> plannedWaypoints;
        Model::ExecuteDijkstraPlanning(
            motionConfig->beginWaypointId,
            motionConfig->viaLaneIds,
            motionConfig->endWaypointId,
            plannedWaypoints);

        static constexpr bool canShowWaypoints{false};
        if (canShowWaypoints)
        {
            mAuxiliaryVisualizer->AppendLineStripMarker(
                utils::LineStripMarker{
                .id = (*movingVehicle)->GetAttribute().id + "_waypoints",
                .points = plannedWaypoints,
                .scale = 0.3,
                .lifeTime = ros::Duration(),
                .color = utils::Magenta()});
        }

        plannedWaypoints = waypointTranslator.Compute(
            plannedWaypoints,
            math::FrenetCoord(0.0, motionConfig->waypointLateralOffset),
            int32_t{0});
        const auto movingVehicleWaypoints{waypointSmoother.Compute(plannedWaypoints)};

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

        motion::MoveTrigger::Ptr moveTrigger{nullptr};
        if (motion::TriggerRefPosition::Type::AgentBased ==
            motionConfig->moveTriggerCondition.triggerRefPosition->GetTypeId())
        {
            actor::AgentBasedTriggerRefPosition::Ptr agentBasedTriggerRefPosition{
                std::make_shared<actor::AgentBasedTriggerRefPosition>()};
            agentBasedTriggerRefPosition->Configure(*(*movingVehicle));
            motion::MoveTriggerCondition agentBasedMoveTriggerCondition =
            {
                .triggerRefPosition = agentBasedTriggerRefPosition,
                .spatialRelationId = motionConfig->moveTriggerCondition.spatialRelationId,
                .distance = motionConfig->moveTriggerCondition.distance,
            };
            moveTrigger = std::make_shared<motion::MoveTrigger>(
                agentBasedMoveTriggerCondition);
        }
        else if (motion::TriggerRefPosition::Type::PositionBased ==
                 motionConfig->moveTriggerCondition.triggerRefPosition->GetTypeId())
        {
            moveTrigger = std::make_shared<motion::MoveTrigger>(
                motionConfig->moveTriggerCondition);

            static constexpr bool canShowTriggerPosition{true};
            if (canShowTriggerPosition)
            {
                mAuxiliaryVisualizer->AppendPointMarker(
                    utils::PointMarker{
                        .id = (*movingVehicle)->GetAttribute().id + "_trigger_position",
                        .type = utils::PointMarkerType::Sphere,
                        .pose = math::HomoXfm3d_t(
                            motionConfig->moveTriggerCondition.triggerRefPosition->Evaluate()),
                        .scale = math::Vector3d_t::Ones() * math::real_t{2.5},
                        .lifeTime = ros::Duration(),
                        .color = utils::Red()});
            }
        }
        else
        {
            ROS_ERROR_STREAM(
                "invalid " << motionConfig->moveTriggerCondition.triggerRefPosition->GetTypeId());
            throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
        }

        mMoveTriggerManager.Register(
            (*movingVehicle)->GetAttribute().id,
            moveTrigger);

        mAgentSpeedManager.Register(
            actor::SpeedConfigRegistrationData{
            .agentId = (*movingVehicle)->GetAttribute().id,
            .agentWaypoints = movingVehicleWaypoints,
            .initAgentFrenetCoord = (*movingVehicle)->GetFrenetState().position,
            .initAgentSpeedMps = motionConfig->initMoveSpeedMps,
            .waypointSpeedConfigs = motionConfig->speedConfigs});
    }

    mCanUpdate = true;
    mCanAccessAgentAttributes = true;
    mDoneConfigureMotions = true;
}

void DijkstraWaypointFollowingModel::EgoVehicleSpeedCommandCallback(const itri_msgs::speed_cmd &msg)
{
    if (msg.kph <= 0.0f)
    {
        return;
    }

    ROS_DEBUG_STREAM_COND(
        false,
        "speed_cmd.kph: " << msg.kph);
    mIsEgoVehicleSpeedCommandReady = true;
    mEgoVehicleSpeedCommandSubscriber.shutdown();
}

void DijkstraWaypointFollowingModel::EgoVehicleGlobalPathCallback(const itri_msgs::Path &msg)
{
    mEgoVehicleGlobalPath.resize(msg.waypoints.size());
    auto pathWaypoint{msg.waypoints.cbegin()};
    auto egoVehicleWaypoint{mEgoVehicleGlobalPath.begin()};
    for (; pathWaypoint != msg.waypoints.cend();
         ++pathWaypoint, ++egoVehicleWaypoint)
    {
        *egoVehicleWaypoint = pathWaypoint->pose.pose.position;
    }

    std::vector<math::Vector3d_t> refWaypoints(mEgoVehicleGlobalPath.size());
    std::transform(
        mEgoVehicleGlobalPath.cbegin(),
        mEgoVehicleGlobalPath.cend(),
        refWaypoints.begin(),
        [](const geometry::Vector3d &input)
        {return math::Vector3d_t(input);});
    mFrenetDistanceEvaluator.Configure(refWaypoints);
    static constexpr bool canShowEgoVehicleGlobalPath{false};
    if (canShowEgoVehicleGlobalPath)
    {
        mAuxiliaryVisualizer->AppendLineStripMarker(
            utils::LineStripMarker{
            .id = "ego_vehicle_global_path",
            .points = refWaypoints,
            .scale = 0.3,
            .lifeTime = ros::Duration(),
            .color = utils::Magenta()});
    }
}

} // namespace unit {
