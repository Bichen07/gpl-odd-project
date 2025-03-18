#include <unit_lane_waypoint_following_model.h>
#include <stdexcept>
#include <ros/console.h>
#include <utils_converter.h>
#include <utils_default_color.h>
#include <utils_json.h>
#include <path/DijkstraPlanning.h>
#include <motion_config_reader.h>
#include <motion_utils.h>
#include <motion_waypoint_smoother.h>
#include <motion_waypoint_translator.h>
#include <actor_config_reader.h>
#include <actor_utils.h>
#include <iso_config_reader.h>

namespace unit {

// public func.

LaneWaypointFollowingModel::LaneWaypointFollowingModel()
    : Model()
    , mMovingVehicles{}
    , mMotionConfigs{}
    , mWaypointFollowerManager{}
    , mWaypointManager{}
    , mFrenetDistanceEvaluator{}
    , mMoveTriggerMap{}
    , mAgentSpeedManager{}
{
    mEgoVehicleSpeedCommandSubscriber = mNodeHandle.subscribe(
        "speed_cmd",
        Model::DefaultQueueSize(),
        &LaneWaypointFollowingModel::EgoVehicleSpeedCommandCallback,
        this);
    mDijkstraPlanningService = mNodeHandle.serviceClient<path::DijkstraPlanning>(
        "path/dijkstra_planning");
}

std::string LaneWaypointFollowingModel::GetId() const
{
    return std::string(AgentIdPrefix()) + std::string("model");
}

void LaneWaypointFollowingModel::Configure(const ModelConfig &config)
{
    Model::Configure<actor::Vehicle, actor::VehicleConfig>(
        config,
        std::string(AgentIdPrefix()),
        mMovingVehicles);
}

void LaneWaypointFollowingModel::Update()
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
            measure::FrenetDistanceData agentToEgoVehicleDistance;
            mFrenetDistanceEvaluator.Compute(
                (*movingVehicle)->GetWorldBoundingRect3d().topRight,
                mEgoVehicleObserver->GetWorldBoundingRect3d().bottomRight,
                true,
                &agentToEgoVehicleDistance);

            if (motionConfig->moveTriggerDistance >= double{0.0})
            {
                moveTriggerPair->second =
                    egoVehicleToAgentDistance.distance.s() < 
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

void LaneWaypointFollowingModel::AccessAgentAttributes(
    std::vector<scenario::AgentAttribute> *agentAttributes)
{
    Model::AccessAgentAttributes<actor::Vehicle>(
        agentAttributes,
        mMovingVehicles);
}


void LaneWaypointFollowingModel::RunCarlaUpdate(
    std::vector<carla::ActorUpdateData> *actorUpdateDatas)
{
    this->Update();
    Model::RunCarlaUpdate(
        actorUpdateDatas,
        mMovingVehicles);
}

// protected func.

// private func.

void LaneWaypointFollowingModel::ConfigureMotions()
{
    Model::ConfigureMotions(mMovingVehicles);

    std::function<decltype(motion::ParseLaneWaypointFollowingConfig)> parseFunc{
        motion::ParseLaneWaypointFollowingConfig};
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

    if (!ros::service::waitForService("path/dijkstra_planning", ros::Duration(1.0)))
    {
        ROS_ERROR_STREAM("fail to wait path/dijkstra_planning service");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    const std::string waypointFileName =
        std::string(MAP_DATA_DIR) +
        mNavigationPath->GetNavigationPathConfig().map +
        std::string("/waypoints.json");
    const std::string lanesInfoFileName =
        std::string(MAP_DATA_DIR) +
        mNavigationPath->GetNavigationPathConfig().map +
        std::string("/lanes_info.json");
    mWaypointManager.Configure(
        waypointFileName,
        lanesInfoFileName);

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
        std::vector<math::Vector3d_t> refWaypoints;
        Model::ExecuteDijkstraPlanning(
            map::WaypointId(motionConfig->laneIds.front(), motionConfig->beginPointId),
            map::WaypointId(motionConfig->laneIds.back(), motionConfig->endPointId),
            refWaypoints);
        const auto movingVehicleWaypoints = motion::ExtendWaypoints(
            waypointSmoother.Compute(refWaypoints),
            motionConfig->beginExtendedDistance,
            motionConfig->beginExtendedRadian,
            motionConfig->endExtendedDistance,
            motionConfig->endExtendedRadian);

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

        path::DijkstraPlanning dijkstraPlanning;
        dijkstraPlanning.request.begin_waypoint_id.lane = 240;
        dijkstraPlanning.request.begin_waypoint_id.point = 5;
        dijkstraPlanning.request.via_lane_ids = std::vector<int32_t>{
            75, 231, 239};
        dijkstraPlanning.request.end_waypoint_id.lane = 86;
        dijkstraPlanning.request.end_waypoint_id.point = 5;
        ROS_DEBUG_STREAM_COND(
            false,
            "dijkstraPlanning.request" << '\n' <<
            dijkstraPlanning.request);
        if (!mDijkstraPlanningService.call(dijkstraPlanning))
        {
            ROS_ERROR_STREAM(
                "fail to call dijkstra planning service" << '\n' <<
                "request" << '\n' <<
                dijkstraPlanning.request << '\n' <<
                "response waypoint size: " <<
                dijkstraPlanning.response.planned_waypoints.size());
        }
        else
        {
            static constexpr bool canShowPlannedLandIds{false};
            if (canShowPlannedLandIds)
            {
                ROS_DEBUG_STREAM_COND(
                    true,
                    "planned_lane_ids, size: " <<
                    dijkstraPlanning.response.planned_lane_ids.size());
                std::copy(
                    dijkstraPlanning.response.planned_lane_ids.cbegin(),
                    dijkstraPlanning.response.planned_lane_ids.cend(),
                    std::ostream_iterator<int32_t>(std::cout, ", "));
                std::cout << std::endl;
            }
        }

        static constexpr bool canShowWaypoints{true};
        if (canShowWaypoints)
        {
            std::vector<math::Vector3d_t> markerPoints(
                dijkstraPlanning.response.planned_waypoints.size());
            std::transform(
                dijkstraPlanning.response.planned_waypoints.cbegin(),
                dijkstraPlanning.response.planned_waypoints.cend(),
                markerPoints.begin(),
                [](const geometry_msgs::Point &input)
                {return utils::ConvertToVector3d(input);});
            mAuxiliaryVisualizer->AppendLineStripMarker(
                utils::LineStripMarker{
                    .id = (*movingVehicle)->GetAttribute().id + "_waypoints",
                    .points = markerPoints,
                    .scale = 0.3,
                    .lifeTime = ros::Duration(),
                    .color = utils::Magenta()});
        }
    }

    //std::vector<std::string> isoAgentIds;
    //iso::ParseAgentIds(
    //    mConfigJsonValue["moving_agent_configs"],
    //    &isoAgentIds);
    //Model::RegisterIsoAgents(isoAgentIds, mMovingVehicles);

    mCanUpdate = true;
    mCanAccessAgentAttributes = true;
}

void LaneWaypointFollowingModel::EgoVehicleSpeedCommandCallback(const itri_msgs::speed_cmd &msg)
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
