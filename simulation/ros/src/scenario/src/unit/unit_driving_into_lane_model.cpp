#include <unit_driving_into_lane_model.h>
#include <stdexcept>
#include <ros/console.h>
#include <utils_default_color.h>
#include <utils_json.h>
#include <utils_line_strip_marker.h>
#include <motion_config_reader.h>
#include <motion_driving_into_lane_waypoint_generator.h>
#include <motion_utils.h>
#include <motion_waypoint_smoother.h>
#include <actor_config_reader.h>
#include <actor_utils.h>

namespace unit {

// public func.

DrivingIntoLaneModel::DrivingIntoLaneModel()
    : Model()
    , mMovingVehicles{}
    , mMotionConfigs{}
    , mWaypointFollowerManager{}
    , mFrenetDistanceEvaluator{}
    , mMoveTriggerMap{}
{
    mEgoVehicleSpeedCommandSubscriber = mNodeHandle.subscribe(
        "speed_cmd",
        Model::DefaultQueueSize(),
        &DrivingIntoLaneModel::EgoVehicleSpeedCommandCallback,
        this);
}

std::string DrivingIntoLaneModel::GetId() const
{
    return std::string(AgentIdPrefix() + std::string("model"));
}

void DrivingIntoLaneModel::Configure(const ModelConfig &config)
{
    Model::Configure<actor::Vehicle, actor::VehicleConfig>(
        config,
        std::string(AgentIdPrefix()),
        mMovingVehicles);
}

void DrivingIntoLaneModel::Update()
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
            auto waypointFollower{
                mWaypointFollowerManager.QueryObject(
                    (*movingVehicle)->GetAttribute().id)};
            waypointFollower->Update(motionConfig->initMovingSpeedMps);
        }
    }

    mVisualizer->AppendVehicles(mMovingVehicles);
    Model::AppendVelocityMarkers(mMovingVehicles);
}

void DrivingIntoLaneModel::AccessAgentAttributes(
    std::vector<scenario::AgentAttribute> *agentAttributes)
{
    Model::AccessAgentAttributes<actor::Vehicle>(
        agentAttributes,
        mMovingVehicles);
}

void DrivingIntoLaneModel::RunCarlaUpdate(
    std::vector<carla::ActorUpdateData> *actorUpdateDatas)
{
    this->Update();
    Model::RunCarlaUpdate(
        actorUpdateDatas,
        mMovingVehicles);
}

// protected func.

// private func.

void DrivingIntoLaneModel::ConfigureMotions()
{
    Model::ConfigureMotions(mMovingVehicles);

    std::function<decltype(motion::ParseDrivingIntoLaneConfig)> parseFunc{
        motion::ParseDrivingIntoLaneConfig};
    motion::ParseMotionConfigs(
        mConfigJsonValue["motion_configs"],
        parseFunc,
        mMotionConfigs);
    if (mMovingVehicles.size() != mMotionConfigs.size())
    {
        ROS_ERROR_STREAM(
            "diff. size b/t mMovingVehicles & mMotionConfigs" << '\n' <<
            "mMovingVehicles: " << mMovingVehicles.size() << '\n' <<
            "mMotionConfigs: " << mMotionConfigs.size());
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
    motion::DrivingIntoLaneWaypointGenerator waypointGenerator;
    auto movingVehicle{mMovingVehicles.begin()};
    auto motionConfig{mMotionConfigs.cbegin()};
    for (; movingVehicle != mMovingVehicles.end();
         ++movingVehicle, ++motionConfig)
    {
        mMoveTriggerMap.insert(
            std::make_pair((*movingVehicle)->GetAttribute().id, false));
        const auto cutInWaypoints{
            waypointGenerator.Compute(
                mNavigationPath,
                motionConfig->laneIds.front(),
                motionConfig->beginPointId,
                motionConfig->beginOffset,
                mTimeStep,
                motionConfig->initMovingSpeedMps)};
        auto followingWaypoints{
            mWaypointManager.QueryWaypoints(
                motionConfig->laneIds,
                motionConfig->beginPointId,
                motionConfig->endPointId)};
        std::vector<math::Vector3d_t> refWaypoints;
        refWaypoints.reserve(cutInWaypoints.size() + followingWaypoints.size());
        refWaypoints.insert(
            refWaypoints.end(),
            cutInWaypoints.cbegin(),
            cutInWaypoints.cend() - 1);
        refWaypoints.insert(
            refWaypoints.end(),
            followingWaypoints.cbegin(),
            followingWaypoints.cend());
        const auto movingVehicleWaypoints = motion::ExtendWaypoints(
            waypointSmoother.Compute(refWaypoints),
            motionConfig->beginExtendedDistance,
            motionConfig->beginExtendedRadian,
            0.0,
            0.0);

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

        static constexpr bool canShowWaypoints{false};
        if (canShowWaypoints)
        {
            mAuxiliaryVisualizer->AppendLineStripMarker(
                utils::LineStripMarker{
                .id = (*movingVehicle)->GetAttribute().id + "_turning_waypoints",
                .points = movingVehicleWaypoints,
                .scale = 0.3,
                .lifeTime = ros::Duration(),
                .color = utils::Magenta()});
        }
    }

    mCanUpdate = true;
    mCanAccessAgentAttributes = true;
}

void DrivingIntoLaneModel::EgoVehicleSpeedCommandCallback(const itri_msgs::speed_cmd &msg)
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
