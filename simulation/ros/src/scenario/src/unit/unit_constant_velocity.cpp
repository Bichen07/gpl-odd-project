#include "itri_msgs/Waypoint.h"
#include "std_msgs/Bool.h"
#include <actor_obstacle_config.h>
#include <actor_utils.h>
#include <math_frenet_coord.h>
#include <math_utils.h>
#include <motion_config_reader.h>
#include <motion_frenet_state.h>
#include <motion_utils.h>
#include <motion_waypoint_smoother.h>
#include <motion_waypoint_translator.h>
#include <ros/console.h>
#include <unit_constant_velocity_model.h>
#include <unit_model.h>
#include <utils_converter.h>

#include <stdexcept>

namespace unit {

static int32_t currentScenarioCount = 0;
static int32_t scenarioCountRecord = -1;

// public func.

ConstantVelocityModel::ConstantVelocityModel()
  : Model()
  , mMovingVehicles{}
  , mMotionConfigs{}
  , mFrenetTransformer{}
  , mYawRateFilter{ std::size_t{ 20ul } }
{
    mDoneConfigureMotions = false;

    mEgoVehicleWaypointsSubscriber = mNodeHandle.subscribe(
      "global_path",
      Model::DefaultQueueSize(),
      &ConstantVelocityModel::EgoVehicleGlobalPathCallback,
      this);

    mScenarioCountSubscriber =
      mNodeHandle.subscribe("scenario_monitor/scenario_count",
                            Model::DefaultQueueSize(),
                            &ConstantVelocityModel::ScenarioCountCallback,
                            this);

    mScenarioStableSubscriber =
      mNodeHandle.subscribe("scenario_monitor/scenario_stable",
                            Model::DefaultQueueSize(),
                            &ConstantVelocityModel::ScenarioStableCallback,
                            this);

    mEgoSpeedCmdPublisher = mNodeHandle.advertise<itri_msgs::speed_cmd>(
      "scenario_control_speed_cmd", 1);

    mEndScenarioPublisher =
      mNodeHandle.advertise<std_msgs::Bool>("end_scenario", 1);
}

std::string
ConstantVelocityModel::GetId() const
{
    return std::string(AgentIdPrefix()) + std::string("model");
}

void
ConstantVelocityModel::Configure(const ModelConfig& config)
{
    Model::Configure<actor::Vehicle, actor::VehicleConfig>(
      config, std::string(AgentIdPrefix()), mMovingVehicles);
    this->ConfigureMotions();
}

void
ConstantVelocityModel::Update()
{
    if (mKdtreeWaypointMap.empty()) {
        return;
    }

    const auto& egoOrientation = mEgoVehicleObserver->GetState().orientation;
    const auto& egoPosition = mEgoVehicleObserver->GetState().position;
    const auto& egoSize = mEgoVehicleObserver->GetSize();
    const auto& egoVelocity = mEgoVehicleObserver->GetState().linearVelocity;
    const auto& egoAcceleration =
      mEgoVehicleObserver->GetState().longitudinalAcceleration;
    Eigen::Matrix3d rotationMatrix = egoOrientation.toRotationMatrix();
    const auto localEgoVelocity = rotationMatrix.inverse() * egoVelocity;

    const auto isEgoMoving = [&](double movingTreshold) {
        return abs(egoVelocity.x()) > movingTreshold &&
               abs(egoVelocity.y()) > movingTreshold;
    };

    pcl::PointXYZ searchPoint;
    searchPoint.x = egoPosition.x();
    searchPoint.y = egoPosition.y();
    searchPoint.z = egoPosition.z();
    std::vector<int> pointIndices;
    std::vector<float> pointDistances;

    mEgoNearestWaypoint = nullptr;

    const int foundCount = mGlobalPathKdtree.nearestKSearch(
      searchPoint, 1, pointIndices, pointDistances);

    if (foundCount > 0) {
        int nearestIndex = pointIndices[0];
        float nearestDistance = pointDistances[0];
        itri_msgs::Waypoint nearest = mKdtreeWaypointMap[nearestIndex];
        mEgoNearestWaypoint.reset(new itri_msgs::Waypoint{ nearest });
    }
    const auto& nearest = mEgoNearestWaypoint;

    // bool isNewScenario = scenarioCountRecord < currentScenarioCount;
    auto motionConfig{ mMotionConfigs.cbegin() };
    auto movingVehicle{ mMovingVehicles.cbegin() };
    const auto& agent = (*movingVehicle);

    auto speedCmd = itri_msgs::speed_cmd{};
    if (!mDoneConfigureMotions && mScenarioStable) {
        speedCmd.header.frame_id = "scenario_control";
        speedCmd.kph = motionConfig->egoSpeedKph;
    }
    mEgoSpeedCmdPublisher.publish(speedCmd);

    bool egoInInitialPosition =
      nearest != nullptr && (nearest->lane_id == motionConfig->beginLaneId &&
                             nearest->point_id == motionConfig->beginPointId);
    if (mScenarioStable && !mDoneConfigureMotions && egoInInitialPosition) {
        motion::WaypointSmoother waypointSmoother;
        motion::WaypointTranslator waypointTranslator;

        const map::WaypointId beginWaypointId{ nearest->lane_id,
                                               nearest->point_id };
        const map::WaypointId endWaypointId{ motionConfig->endLaneId,
                                             motionConfig->endPointId };

        std::vector<math::Vector3d_t> refWaypoints;
        Model::ExecuteDijkstraPlanning(
          beginWaypointId, endWaypointId, refWaypoints);
        refWaypoints = waypointSmoother.Compute(refWaypoints);
        std::vector<math::Vector2d_t> refWaypoints2d;
        for (const auto& waypoint : refWaypoints) {
            refWaypoints2d.emplace_back(waypoint.x(), waypoint.y());
        }
        mFrenetTransformer.Configure(refWaypoints2d,
                                     utils::FileLineNumPairInstance());

        auto waypointFollower{ std::make_shared<ctrl::WaypointFollower>() };
        waypointFollower->Configure(mTimeStep, *movingVehicle, refWaypoints);

        bool hasBeenRegistered = mWaypointFollowerManager.Register(
          (*movingVehicle)->GetAttribute().id, waypointFollower);
        if (hasBeenRegistered) {
            auto msg = std_msgs::Bool();
            msg.data = true;
            mEndScenarioPublisher.publish(msg);
        }

        math::Vector3d_t offset{ motionConfig->longitudinalOffset,
                                 motionConfig->lateralOffset,
                                 0.0 };
        offset = rotationMatrix * offset;
        math::Vector2d_t initPosition{ egoPosition.x() + offset.x(),
                                       egoPosition.y() + offset.y() };

        auto initFrenetPosition =
          mFrenetTransformer.ConvertToFrenetCoord(initPosition);
        actor::ConfigureAgentInitStateTransform(
          0, refWaypoints, initFrenetPosition, *movingVehicle);

        double vx0 = motionConfig->agentSpeedKph / 3.6 *
                     cos(math::ToRadian(motionConfig->agentHeadingDegrees));
        double vy0 = motionConfig->agentSpeedKph / 3.6 *
                     sin(math::ToRadian(motionConfig->agentHeadingDegrees));
        mAgentInitialVelocity.set_xyz(vx0, vy0, 0.0);
        mAgentInitialVelocity = rotationMatrix * mAgentInitialVelocity;

        ROS_ERROR_STREAM("before rotated offset: "
                         << motionConfig->longitudinalOffset << " "
                         << motionConfig->lateralOffset);
        ROS_ERROR_STREAM("offset: " << offset.x() << " " << offset.y());
        ROS_ERROR_STREAM("ego: " << egoPosition.x() << " " << egoPosition.y());
        ROS_ERROR_STREAM("vx0: " << vx0 << ", vy0: " << vy0
                                 << ", dx0: " << initPosition.x()
                                 << ", dy0: " << initPosition.y());

        mDoneConfigureMotions = true;
        scenarioCountRecord = currentScenarioCount;
    }

    if (mMovingVehicles.empty() || !mDoneConfigureMotions) {
        return;
    }

    const auto& agentPosition = agent->GetState().position;
    const math::Vector3d_t updatedPosition3d(
      agentPosition.x() + mAgentInitialVelocity.x() * mTimeStep,
      agentPosition.y() + mAgentInitialVelocity.y() * mTimeStep,
      egoPosition.z());
    auto updatedState = motion::ComputeUpdatedState(
      mTimeStep, agent->GetState(), updatedPosition3d);
    mYawRateFilter.Push(updatedState.angularVelocity.z());
    const math::Vector3d_t movingAverageAngularVelocity(
      math::real_t{ 0.0 },
      math::real_t{ 0.0 },
      mYawRateFilter.ComputeAverage());
    updatedState.angularVelocity = movingAverageAngularVelocity;

    agent->UpdateState(updatedState);
    agent->UpdateTransform(updatedState);
    const auto updatedFrenetVelocity = motion::ComputeFrenetVelocity(
      agent->GetState().linearVelocity, agent->GetTransform2d());
    const auto updatedFrenetState =
      motion::FrenetState(agent->GetFrenetState().idx,
                          agent->GetFrenetState().position,
                          updatedFrenetVelocity);
    agent->UpdateFrenetState(updatedFrenetState);

    mVisualizer->AppendVehicles(mMovingVehicles);
    Model::AppendVelocityMarkers(mMovingVehicles);
}

void
ConstantVelocityModel::AccessAgentAttributes(
  std::vector<scenario::AgentAttribute>* agentAttributes)
{
    Model::AccessAgentAttributes<actor::Vehicle>(agentAttributes,
                                                 mMovingVehicles);
}

void
ConstantVelocityModel::RunCarlaUpdate(
  std::vector<carla::ActorUpdateData>* actorUpdateDatas)
{
    this->Update();
    Model::RunCarlaUpdate(actorUpdateDatas, mMovingVehicles);
}

// protected func.

// private func.

void
ConstantVelocityModel::ConfigureMotions()
{
    mDoneConfigureMotions = false;
    mAgentInitialVelocity.setZero();
    Model::ConfigureMotions(mMovingVehicles);
    std::function<decltype(motion::ParseConstantVelocityConfig)> parseFunc{
        motion::ParseConstantVelocityConfig
    };
    motion::ParseMotionConfigs(
      mConfigJsonValue["motion_configs"], parseFunc, mMotionConfigs);
    if (mMovingVehicles.size() != mMotionConfigs.size()) {
        ROS_ERROR_STREAM("diff. sizes b/t mMovingVehicles & mMotionConfigs"
                         << '\n'
                         << "mMovingVehicles: " << mMovingVehicles.size()
                         << '\n'
                         << "mMotionConfigs" << mMotionConfigs.size());
        throw std::invalid_argument(std::string(__FILE__ ":") +
                                    std::to_string(__LINE__));
    }
}

void
ConstantVelocityModel::ScenarioCountCallback(const std_msgs::Int32 msg)
{
    currentScenarioCount = msg.data;
}

void
ConstantVelocityModel::ScenarioStableCallback(const std_msgs::Bool msg)
{
    mScenarioStable = msg.data;
}

void
ConstantVelocityModel::EgoVehicleGlobalPathCallback(const itri_msgs::Path& msg)
{
    Model::EgoVehicleGlobalPathCallback(msg);

    pcl::PointCloud<pcl::PointXYZ>::Ptr cloud(
      new pcl::PointCloud<pcl::PointXYZ>);
    for (int i = 0; i < msg.waypoints.size(); i++) {
        const auto& pathWaypoint = msg.waypoints[i];
        const auto& position = pathWaypoint.pose.pose.position;

        pcl::PointXYZ pclPoint;
        pclPoint.x = position.x;
        pclPoint.y = position.y;
        pclPoint.z = position.z;

        cloud->push_back(pclPoint);
        mKdtreeWaypointMap[i] = pathWaypoint;
    }
    mGlobalPathKdtree.setInputCloud(cloud);
    mEgoVehicleGlobalPathSubscriber.shutdown();
}

} // namespace unit
