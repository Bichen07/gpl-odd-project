#include <unit_pedestrian_crossing_model.h>
#include <stdexcept>
#include <ros/console.h>
#include <utils_json.h>
#include <motion_config_reader.h>
#include <motion_crosswalk_waypoint_generator.h>
#include <motion_utils.h>
#include <actor_config_reader.h>
#include <actor_utils.h>
#include <scenario_utils.h>

namespace unit {

// public func.

PedestrianCrossingModel::PedestrianCrossingModel()
    : Model()
    , mPedestrians{}
    , mMotionConfigs{}
    , mMoveTriggerMap{}
{
    mEgoVehicleSpeedCommandSubscriber = mNodeHandle.subscribe(
        "speed_cmd",
        Model::DefaultQueueSize(),
        &PedestrianCrossingModel::EgoVehicleSpeedCommandCallback,
        this);
}

std::string PedestrianCrossingModel::GetId() const
{
    return std::string(AgentIdPrefix()) + std::string("model");
}

void PedestrianCrossingModel::Configure(const ModelConfig &config)
{
    Model::Configure<actor::Pedestrian, actor::PedestrianConfig>(
        config,
        std::string(AgentIdPrefix()),
        mPedestrians);
}

void PedestrianCrossingModel::Update()
{
    if (mPedestrians.empty() || !mDoneConfigureMotions)
    {
        return;
    }

    auto pedestrian{mPedestrians.begin()};
    auto motionConfig{mMotionConfigs.cbegin()};
    for (; pedestrian != mPedestrians.end();
         ++pedestrian, ++motionConfig)
    {
        const auto crosswalkRefPointPair{
            mCrosswalkRefPointMap.find((*pedestrian)->GetAttribute().id)};
        if (mCrosswalkRefPointMap.end() == crosswalkRefPointPair)
        {
            ROS_ERROR_STREAM("invalid pedestrian id: " << (*pedestrian)->GetAttribute().id);
            throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
        }

        auto moveTriggerPair{
            mMoveTriggerMap.find((*pedestrian)->GetAttribute().id)};
        if (mMoveTriggerMap.end() == moveTriggerPair)
        {
            ROS_ERROR_STREAM("invalid pedestrian id: " << (*pedestrian)->GetAttribute().id);
            throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
        }
        measure::FrenetDistanceData egoVehicleToCrosswalkDistance;
        mFrenetDistanceEvaluator.Compute(
            mEgoVehicleObserver->GetWorldBoundingRect3d().topRight,
            crosswalkRefPointPair->second,
            true,
            &egoVehicleToCrosswalkDistance);

        if (!moveTriggerPair->second)
        {
            if (egoVehicleToCrosswalkDistance.distance.s() < motionConfig->pedestrianMoveTriggerDistance)
            {
                moveTriggerPair->second = true;
            }
        }

        if (moveTriggerPair->second)
        {
            auto waypointFollower{mWaypointFollowerManager.QueryObject(
                (*pedestrian)->GetAttribute().id)};
            waypointFollower->Update(motionConfig->speedMps);
        }
    }

    mVisualizer->AppendPedestrians(mPedestrians);
    Model::AppendVelocityMarkers(mPedestrians);
}

void PedestrianCrossingModel::AccessAgentAttributes(
    std::vector<scenario::AgentAttribute> *agentAttributes)
{
        Model::AccessAgentAttributes<actor::Pedestrian>(
        agentAttributes,
        mPedestrians);
}

void PedestrianCrossingModel::RunCarlaUpdate(
    std::vector<carla::ActorUpdateData> *actorUpdateDatas)
{
    this->Update();
    Model::RunCarlaUpdate(
        actorUpdateDatas,
        mPedestrians);
}

// protected func.

// private func.

void PedestrianCrossingModel::ConfigureMotions()
{
    Model::ConfigureMotions(mPedestrians);

    std::function<decltype(motion::ParsePedestrianCrossingMovingConfig)> parseFunc{
        motion::ParsePedestrianCrossingMovingConfig};
    motion::ParseMotionConfigs(
        mConfigJsonValue["motion_configs"],
        parseFunc,
        &mMotionConfigs);

    if (mPedestrians.size() != mMotionConfigs.size())
    {
        ROS_ERROR_STREAM(
            "diff. sizes b/t mPedestrians & mMotionConfigs" << '\n' <<
            "mPedestrians: " << mPedestrians.size() << '\n' <<
            "mMotionConfigs: " << mMotionConfigs.size());
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    const std::string crosswalkFileName =
        std::string(MAP_DATA_DIR) +
        mNavigationPath->GetNavigationPathConfig().map +
        std::string("/pedestrian_crossing.json");
    mCrosswalkManager.Configure(crosswalkFileName);
    mMapVisualizer->SetCrosswalkMap(mCrosswalkManager.GetCrosswalkMap());
    mFrenetDistanceEvaluator.Configure(mNavigationPath->GetEgoVehicleGlobalPath());

    motion::CrosswalkWaypointGenerator crosswalkWaypointGenerator;
    
    auto pedestrian{mPedestrians.begin()};
    auto motionConfig{mMotionConfigs.cbegin()};
    for (; pedestrian != mPedestrians.end();
         ++pedestrian, ++motionConfig)
    {

        mMoveTriggerMap.insert(std::make_pair(
            (*pedestrian)->GetAttribute().id, false));

        const auto crosswalk{mCrosswalkManager.QueryCrosswalk(motionConfig->crosswalkId)};
        const auto edge{crosswalk.GetEdges().at(motionConfig->crosswalkEdgeId)};
        const auto waypoints = crosswalkWaypointGenerator.Compute(
            mTimeStep,
            edge,
            motionConfig->forwardDirection,
            motionConfig->lateralOffsetToEdge,
            motionConfig->longitudinalExtendedDistance,
            motionConfig->speedMps);

        const auto crosswalkRefPoint = scenario::ExtractClosestCrosswalkCorner(
            mFrenetDistanceEvaluator,
            crosswalk,
            mNavigationPath->GetEgoVehicleGlobalPath().front());
        mCrosswalkRefPointMap.insert(std::make_pair(
            (*pedestrian)->GetAttribute().id, crosswalkRefPoint));

        auto waypointFollower{std::make_shared<ctrl::WaypointFollower>()};
        waypointFollower->Configure(
            mTimeStep,
            (*pedestrian),
            waypoints);
        mWaypointFollowerManager.Register(
            (*pedestrian)->GetAttribute().id,
            waypointFollower);

        const int32_t beginWaypointIdx{0};
        actor::ConfigureAgentInitStateTransform(
            beginWaypointIdx,
            waypoints,
            (*pedestrian));
    }

    mCanAccessAgentAttributes = true;
}

void PedestrianCrossingModel::EgoVehicleSpeedCommandCallback(const itri_msgs::speed_cmd &msg)
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
