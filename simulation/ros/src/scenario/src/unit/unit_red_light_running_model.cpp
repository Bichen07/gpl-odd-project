#include <unit_red_light_running_model.h>
#include <limits>
#include <math_utils.h>
#include <utils_default_color.h>
#include <utils_json.h>
#include <utils_line_strip_marker.h>
#include <utils_point_marker.h>
#include <motion_config_reader.h>
#include <motion_utils.h>
#include <motion_waypoint_smoother.h>
#include <actor_config_reader.h>
#include <actor_utils.h>

namespace unit {

// public func.

RedLightRunningModel::RedLightRunningModel()
    : Model()
    , mFakeTrafficLightSubscriber{}
    , mMovingVehicles{}
    , mMotionConfigs{}
    , mWaypointFollowerManager{}
    , mLateralSpeedEvaluatorManager{}
    , mWaypointManager{}
    , mStopLineManager{}
    , mTrafficLightState{map::TrafficLightState::Null}
    , mEgoVehicleForwardStopLines{}
    , mFrenetDistanceEvaluator{}
    , mVehicleStopLineMap{}
    , mMoveTriggerMap{}
    , mLateralMoveTriggerMap{}
{
    mEgoVehicleSpeedCommandSubscriber = mNodeHandle.subscribe(
        "speed_cmd",
        Model::DefaultQueueSize(),
        &RedLightRunningModel::EgoVehicleSpeedCommandCallback,
        this);
    mFakeTrafficLightSubscriber = mNodeHandle.subscribe(
        "traffic_light_status_fake",
        Model::DefaultQueueSize(),
        &RedLightRunningModel::FakeTrafficLightCallback,
        this);
}

std::string RedLightRunningModel::GetId() const
{
    return std::string(AgentIdPrefix()) + std::string("model");
}

void RedLightRunningModel::Configure(const ModelConfig &config)
{
    Model::Configure<actor::Vehicle, actor::VehicleConfig>(
        config,
        std::string(AgentIdPrefix()),
        mMovingVehicles);

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

    const std::string roadMarkerFileName =
        std::string(MAP_DATA_DIR) +
        mNavigationPath->GetNavigationPathConfig().map +
        std::string("/roadmarkers.json");
    mStopLineManager.Configure(roadMarkerFileName);
    //mMapVisualizer->SetStopLineMap(mStopLineManager.GetStopLineMap());
}

void RedLightRunningModel::Update()
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
            const auto foundStopLine = mVehicleStopLineMap.find(
                (*movingVehicle)->GetAttribute().id);
            if (mVehicleStopLineMap.end() == foundStopLine)
            {
                ROS_INFO_STREAM(
                    "invalid moving vehilce id: " << (*movingVehicle)->GetAttribute().id);
                throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
            }

            const auto stopLineRefPoint = math::ExtractFurthestPoint(
                mEgoVehicleObserver->GetWorldBoundingRect3d().topRight,
                foundStopLine->second.GetCorner3ds());
            measure::FrenetDistanceData egoVehicleToStopLineDistance;
            mFrenetDistanceEvaluator.Compute(
                mEgoVehicleObserver->GetWorldBoundingRect3d().topRight,
                stopLineRefPoint,
                true,
                &egoVehicleToStopLineDistance);
            moveTriggerPair->second =
                !egoVehicleToStopLineDistance.isObserverBehindTarget &&
                egoVehicleToStopLineDistance.distance.s() > motionConfig->moveTriggerDistance &&
                map::TrafficLightState::Green == mTrafficLightState;
        }

        if (moveTriggerPair->second)
        {
            auto lateralMoveTriggerPair{mLateralMoveTriggerMap.find((*movingVehicle)->GetAttribute().id)};
            if (!lateralMoveTriggerPair->second)
            {
                lateralMoveTriggerPair->second =
                    (*movingVehicle)->GetFrenetState().position.s() > motionConfig->lateralMoveTriggerDistance;
            }

            math::real_t lateralSpeed{0.0};
            math::real_t longitudinalSpeed = motionConfig->movingSpeedMps;
            if (lateralMoveTriggerPair->second)
            {
                auto lateralSpeedEvaluator{
                    mLateralSpeedEvaluatorManager.QueryObject((*movingVehicle)->GetAttribute().id)};
                lateralSpeed = lateralSpeedEvaluator->Compute(*(*movingVehicle));
                longitudinalSpeed = motion::ComputeLongitudinalSpeed(
                    motionConfig->movingSpeedMps,
                    lateralSpeed);
            }

            auto waypointFollower = mWaypointFollowerManager.QueryObject(
                (*movingVehicle)->GetAttribute().id);
            waypointFollower->Update(
                longitudinalSpeed,
                lateralSpeed);
        }
    }

    mVisualizer->AppendVehicles(mMovingVehicles);
    Model::AppendVelocityMarkers(mMovingVehicles);
}

void RedLightRunningModel::AccessAgentAttributes(
    std::vector<scenario::AgentAttribute> *agentAttributes)
{
    Model::AccessAgentAttributes<actor::Vehicle>(
        agentAttributes,
        mMovingVehicles);
}

void RedLightRunningModel::RunCarlaUpdate(
    std::vector<carla::ActorUpdateData> *actorUpdateDatas)
{
    this->Update();
    Model::RunCarlaUpdate(
        actorUpdateDatas,
        mMovingVehicles);
}

// protected func.

// private func.

void RedLightRunningModel::ConfigureMotions()
{
    Model::ConfigureMotions(mMovingVehicles);

    std::function<decltype(motion::ParseRedLightRunningConfig)> parseFunc{
        motion::ParseRedLightRunningConfig};
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

        mMoveTriggerMap.insert(std::make_pair(
            (*movingVehicle)->GetAttribute().id, 
            false));
        mLateralMoveTriggerMap.insert(std::make_pair(
            (*movingVehicle)->GetAttribute().id, 
            false));

        const auto refWaypoints = mWaypointManager.QueryWaypoints(
            motionConfig->precedingLaneIds,
            motionConfig->succeedingLaneIds,
            motionConfig->beginPointId,
            motionConfig->endPointId);
        const auto movingVehicleWaypoints = motion::ExtendWaypoints(
            waypointSmoother.Compute(refWaypoints),
            motionConfig->beginExtendedDistance,
            motionConfig->beginExtendedRadian,
            motionConfig->endExtendedDistance,
            motionConfig->endExtendedRadian);

        static constexpr bool canShowWaypoints{false};
        if (canShowWaypoints)
        {
            mAuxiliaryVisualizer->AppendLineStripMarker(
                utils::LineStripMarker{
                    .id = (*movingVehicle)->GetAttribute().id + "_crossing_waypoints",
                    .points = movingVehicleWaypoints,
                    .scale = 0.3,
                    .lifeTime = ros::Duration(),
                    .color = utils::Magenta()});
        }

        static constexpr bool canShowSplineControlPoints{false};
        if (canShowSplineControlPoints)
        {
            if (!mWaypointManager.GetCubicSplineControlPoints().empty())
            {
                const auto cubicSplineControlPoints{
                    mWaypointManager.GetCubicSplineControlPoints()};
                mAuxiliaryVisualizer->AppendPointMarker(
                    utils::PointMarker{
                    .id = (*movingVehicle)->GetAttribute().id + "_control_point_0",
                    .type = utils::PointMarkerType::Sphere,
                    .pose = math::HomoXfm3d_t(cubicSplineControlPoints.at(0)),
                    .scale = math::Vector3d_t::Ones(),
                    .lifeTime = ros::Duration(),
                    .color = utils::Red()});
                mAuxiliaryVisualizer->AppendPointMarker(
                    utils::PointMarker{
                    .id = (*movingVehicle)->GetAttribute().id + "_control_point_1",
                    .type = utils::PointMarkerType::Sphere,
                    .pose = math::HomoXfm3d_t(cubicSplineControlPoints.at(1)),
                    .scale = math::Vector3d_t::Ones(),
                    .lifeTime = ros::Duration(),
                    .color = utils::Green()});
                mAuxiliaryVisualizer->AppendPointMarker(
                    utils::PointMarker{
                    .id = (*movingVehicle)->GetAttribute().id + "_control_point_2",
                    .type = utils::PointMarkerType::Sphere,
                    .pose = math::HomoXfm3d_t(cubicSplineControlPoints.at(2)),
                    .scale = math::Vector3d_t::Ones(),
                    .lifeTime = ros::Duration(),
                    .color = utils::Blue()});
                mAuxiliaryVisualizer->AppendPointMarker(
                    utils::PointMarker{
                    .id = (*movingVehicle)->GetAttribute().id + "_control_point_3",
                    .type = utils::PointMarkerType::Sphere,
                    .pose = math::HomoXfm3d_t(cubicSplineControlPoints.at(3)),
                    .scale = math::Vector3d_t::Ones(),
                    .lifeTime = ros::Duration(),
                    .color = utils::Cyan()});
                mAuxiliaryVisualizer->AppendPointMarker(
                    utils::PointMarker{
                    .id = (*movingVehicle)->GetAttribute().id + "_control_point_4",
                    .type = utils::PointMarkerType::Sphere,
                    .pose = math::HomoXfm3d_t(cubicSplineControlPoints.at(4)),
                    .scale = math::Vector3d_t::Ones(),
                    .lifeTime = ros::Duration(),
                    .color = utils::OrangeRed()});
            }
        }

        const int32_t movingVehicleBeginWaypointIdx{0};
        actor::ConfigureAgentInitStateTransform(
            movingVehicleBeginWaypointIdx,
            movingVehicleWaypoints,
            *movingVehicle);

        auto waypointFollower{std::make_shared<ctrl::WaypointFollower>()};
        waypointFollower->Configure(
            mTimeStep,
            (*movingVehicle),
            movingVehicleWaypoints);
        //waypointFollower->Configure(
        //    ctrl::CollisionAvoidanceWaypointFollowerConfig{
        //        .timeStep = mTimeStep,
        //        .vehicle = *movingVehicle,
        //        .waypoint3ds = movingVehicleWaypoints,
        //        .agentManager = mAgentManager,
        //        .egoVehicleObserver = mEgoVehicleObserver,
        //        .minRelativeDistance = utils::GetDoubleJsonValue(mConfigJsonValue["min_relative_distance"])});
        mWaypointFollowerManager.Register(
            (*movingVehicle)->GetAttribute().id,
            waypointFollower);

        auto lateralSpeedEvaluator{
            std::make_shared<ctrl::EaseInOutLateralSpeedEvaluator>()};
        lateralSpeedEvaluator->Configure(
            mTimeStep,
            motionConfig->lateralSpeedMps,
            (*movingVehicle)->GetFrenetState().position.d(),
            (*movingVehicle)->GetFrenetState().position.d() + motionConfig->lateralMoveDistance);
        mLateralSpeedEvaluatorManager.Register(
            (*movingVehicle)->GetAttribute().id,
            lateralSpeedEvaluator);

        if (mEgoVehicleForwardStopLines.empty())
        {
            ROS_ERROR_STREAM("empty mEgoVehicleForwardStopLines");
            throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
        }

        map::StopLine closestStopLine;
        math::real_t minVehicleToStopLineDistance{
            std::numeric_limits<math::real_t>::max()};
        for (auto forwardStopLine{mEgoVehicleForwardStopLines.cbegin()};
             forwardStopLine != mEgoVehicleForwardStopLines.cend();
             ++forwardStopLine)
        {
            measure::FrenetDistanceData vehicleToStopLineDistance;
            mFrenetDistanceEvaluator.Compute(
                (*movingVehicle)->GetTransform3d().translation(),
                forwardStopLine->GetCentroid3d(),
                true,
                &vehicleToStopLineDistance);

            if (vehicleToStopLineDistance.distance.s() < minVehicleToStopLineDistance)
            {
                minVehicleToStopLineDistance = vehicleToStopLineDistance.distance.s();
                closestStopLine = *forwardStopLine;
            }
        }

        mVehicleStopLineMap.insert(
            std::make_pair(
                (*movingVehicle)->GetAttribute().id,
                closestStopLine));
    }

    mCanAccessAgentAttributes = true;
}

void RedLightRunningModel::FakeTrafficLightCallback(
    const itri_msgs::TrafficLightObjects &msg)
{
    if (msg.lights.empty())
    {
        mTrafficLightState = map::TrafficLightState::Null;
    }

    if (msg.lights.front().red)
    {
        mTrafficLightState = map::TrafficLightState::Red;
    }
    else if (msg.lights.front().yellow)
    {
        mTrafficLightState = map::TrafficLightState::Yellow;
    }
    else if (msg.lights.front().green)
    {
        mTrafficLightState = map::TrafficLightState::Green;
    }
    else
    {
        mTrafficLightState = map::TrafficLightState::Null;
    }
}

void RedLightRunningModel::EgoVehicleSpeedCommandCallback(const itri_msgs::speed_cmd &msg)
{
    if (msg.kph <= 0.0f)
    {
        return;
    }

    std::vector<map::StopLine> stopLines;
    const auto forwardLaneIds{mNavigationPath->GetForwardLaneIds()};
    for (auto forwardLaneId{forwardLaneIds.cbegin()};
         forwardLaneId != forwardLaneIds.cend();
         ++forwardLaneId)
    {
        if (mStopLineManager.QueryStopLines(*forwardLaneId, &stopLines))
        {
            mEgoVehicleForwardStopLines.insert(
                mEgoVehicleForwardStopLines.cend(),
                stopLines.cbegin(),
                stopLines.cend());
        }
    }

    this->ConfigureMotions();
    mDoneConfigureMotions = true;
    mEgoVehicleSpeedCommandSubscriber.shutdown();
}

} // namespace unit {
