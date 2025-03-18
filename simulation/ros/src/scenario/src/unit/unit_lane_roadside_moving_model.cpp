#include <unit_lane_roadside_moving_model.h>
#include <stdexcept>
#include <ros/console.h>
#include <math_utils.h>
#include <utils_converter.h>
#include <utils_json.h>
#include <path_msgs/WaypointId.h>
#include <path/WaypointQuerying.h>
#include <motion_config_reader.h>
#include <motion_utils.h>
#include <motion_waypoint_smoother.h>
#include <motion_waypoint_translator.h>
#include <actor_vehicle_config.h>
#include <actor_utils.h>

namespace unit {

// public func.

LaneRoadsideMovingModel::LaneRoadsideMovingModel()
    : Model()
    , mMovingVehicles{}
    , mMotionConfigs{}
    , mWaypointFollowerManager{}
    , mMoveToLaneLateralSpeedEvaluatorManager{}
    , mMoveToRoadsideLateralSpeedEvaluatorManager{}
    , mFrenetDistanceEvaluator{}
    , mMoveToRoadsideTriggerDistanceMap{}
    , mMoveTriggerMap{}
    , mMoveToRoadsideTriggerMap{}
    , mPoseApproximationEvaluatorManager{}
    , mAgentSpeedManager{}
{
    mEgoVehicleWaypointsSubscriber = mNodeHandle.subscribe(
        "waypoints",
        Model::DefaultQueueSize(),
        &LaneRoadsideMovingModel::EgoVehicleWaypointsCallback,
        this);
}

std::string LaneRoadsideMovingModel::GetId() const
{
    return std::string(AgentIdPrefix()) + std::string("model");
}

void LaneRoadsideMovingModel::Configure(const ModelConfig &config)
{
    Model::Configure<actor::Vehicle, actor::VehicleConfig>(
        config,
        std::string(AgentIdPrefix()),
        mMovingVehicles);
}

void LaneRoadsideMovingModel::Update()
{
    if (mMovingVehicles.empty() || !mDoneConfigureMotions)
    {
        return;
    }

    auto movingVehicle{mMovingVehicles.begin()};
    auto motionConfig{mMotionConfigs.cbegin()};
    for (; movingVehicle != mMovingVehicles.end(); ++movingVehicle, ++motionConfig)
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
                egoVehicleToAgentDistance.distance.s() < motionConfig->moveTriggerDistance &&
                mEgoVehicleObserver->GetState().linearVelocity.norm() < motionConfig->moveTriggerEgoVehicleMaxSpeedMps;
        }

        if (moveTriggerPair->second)
        {
            const auto moveToRoadsideTriggerDistancePair{
                mMoveToRoadsideTriggerDistanceMap.find(
                    (*movingVehicle)->GetAttribute().id)};
            math::real_t lateralSpeed{0.0};
            if ((*movingVehicle)->GetFrenetState().position.s() <
                moveToRoadsideTriggerDistancePair->second)
            {
                auto moveToLaneLateralSpeedEvaluator{
                    mMoveToLaneLateralSpeedEvaluatorManager.QueryObject(
                        (*movingVehicle)->GetAttribute().id)};
                lateralSpeed = moveToLaneLateralSpeedEvaluator->Compute(
                    *(*movingVehicle));
            }
            else
            {
                auto moveToRoadsideLateralSpeedEvaluator{
                    mMoveToRoadsideLateralSpeedEvaluatorManager.QueryObject(
                        (*movingVehicle)->GetAttribute().id)};
                lateralSpeed = moveToRoadsideLateralSpeedEvaluator->Compute(
                    *(*movingVehicle));
            }

            const auto speedMps{mAgentSpeedManager.QuerySpeed(*(*movingVehicle))};
            const auto longitudinalSpeed = motion::ComputeLongitudinalSpeed(
                speedMps,
                lateralSpeed);
            auto waypointFollower = mWaypointFollowerManager.QueryObject(
                (*movingVehicle)->GetAttribute().id);
            waypointFollower->Update(
                longitudinalSpeed,
                lateralSpeed);
            ROS_DEBUG_STREAM_COND(
                false,
                "speedMps: " << speedMps <<
                ", longitudinal: " << longitudinalSpeed <<
                ", lateral: " << lateralSpeed);
        }
    }

    mVisualizer->AppendVehicles(mMovingVehicles);
    Model::AppendVelocityMarkers(mMovingVehicles);

    const math::Vector3d_t rotationAngles = math::ToEulerAngleXyz(
        mMovingVehicles.front()->GetTransform3d().linear());
}

void LaneRoadsideMovingModel::AccessAgentAttributes(
    std::vector<scenario::AgentAttribute> *agentAttributes)
{
    Model::AccessAgentAttributes<actor::Vehicle>(
        agentAttributes,
        mMovingVehicles);
}

void LaneRoadsideMovingModel::RunCarlaUpdate(
    std::vector<carla::ActorUpdateData> *actorUpdateDatas)
{
    this->Update();
    Model::RunCarlaUpdate(
        actorUpdateDatas,
        mMovingVehicles);
}

// protected func.

// private func.

void LaneRoadsideMovingModel::ConfigureMotions()
{
    Model::ConfigureMotions(mMovingVehicles);

    std::function<decltype(motion::ParseLaneRoadsideMovingConfig)> parseFunc{
        motion::ParseLaneRoadsideMovingConfig};

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
        mMoveToRoadsideTriggerMap.insert(std::make_pair(
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
        const auto movingVehicleWaypoints = waypointSmoother.Compute(refWaypoints);

        const int32_t movingVehicleBeginWaypointIdx{0};
        const math::FrenetCoord initOffset(
            motionConfig->beginLongitudinalOffset,
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

        measure::FrenetDistanceData moveToRoadsideTriggerDistance;
        const auto moveToRoadsideTriggerWaypoint{
            mNavigationPath->QueryWaypoint(
                motionConfig->moveToRoadsideTriggerLaneId,
                motionConfig->moveToRoadsideTriggerPointId)};
        mFrenetDistanceEvaluator.Compute(
            (*movingVehicle)->GetWorldBoundingRect3d().topRight,
            moveToRoadsideTriggerWaypoint,
            true,
            &moveToRoadsideTriggerDistance);
        mMoveToRoadsideTriggerDistanceMap.insert(
            std::make_pair(
                (*movingVehicle)->GetAttribute().id,
                moveToRoadsideTriggerDistance.distance.s() +
                motionConfig->moveToRoadsideTriggerLongitudinalOffset));

        mPoseApproximationEvaluatorManager.Register(
            (*movingVehicle)->GetAttribute().id,
            std::make_shared<PoseApproximationEvaluator>(
                PoseApproximationEvaluator::DefaultEpsilon()));

        mAgentSpeedManager.Register(
            actor::SpeedConfigRegistrationData{
            .agentId = (*movingVehicle)->GetAttribute().id,
            .agentWaypoints = movingVehicleWaypoints,
            .initAgentFrenetCoord = (*movingVehicle)->GetFrenetState().position,
            .initAgentSpeedMps = motionConfig->initMovingSpeedMps,
            .waypointSpeedConfigs = motionConfig->speedConfigs});
    }

    mCanAccessAgentAttributes = true;
}


void LaneRoadsideMovingModel::EgoVehicleWaypointsCallback(const itri_msgs::WaypointArray &msg)
{
    this->ConfigureMotions();
    mDoneConfigureMotions = true;
    mEgoVehicleWaypointsSubscriber.shutdown();
}

} // namespace unit {
