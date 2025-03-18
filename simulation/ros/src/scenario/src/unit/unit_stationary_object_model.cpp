#include <unit_stationary_object_model.h>
#include <stdexcept>
#include <ros/console.h>
#include <utils_converter.h>
#include <actor_obstacle_config.h>
#include <actor_utils.h>
#include <motion_config_reader.h>

namespace unit {

// public func.

StationaryObjectModel::StationaryObjectModel()
    : Model()
    , mObjects{}
    , mMotionConfigs{}
{
}

std::string StationaryObjectModel::GetId() const
{
    return std::string(AgentIdPrefix()) + std::string("model");
}

void StationaryObjectModel::Configure(const ModelConfig & config)
{
    Model::Configure<actor::Obstacle, actor::ObstacleConfig>(
        config,
        std::string(AgentIdPrefix()),
        mObjects);
    this->ConfigureMotions();
}

void StationaryObjectModel::Update()
{
    if (!mCanUpdate || !mDoneConfigureMotions)
    {
        return;
    }

    mVisualizer->AppendObstacles(mObjects);
}

void StationaryObjectModel::AccessAgentAttributes(
    std::vector<scenario::AgentAttribute> *agentAttributes)
{
    Model::AccessAgentAttributes<actor::Obstacle>(
        agentAttributes,
        mObjects);
}

void StationaryObjectModel::RunCarlaUpdate(
    std::vector<carla::ActorUpdateData> *actorUpdateDatas)
{
    this->Update();
    Model::RunCarlaUpdate(
        actorUpdateDatas,
        mObjects);
}

// protected func.

// private func.

void StationaryObjectModel::ConfigureMotions()
{
    Model::ConfigureMotions(mObjects);
    std::function<decltype(motion::ParseStationaryObjectConfig)> parseFunc{
        motion::ParseStationaryObjectConfig};
    motion::ParseMotionConfigs(
        mConfigJsonValue["motion_configs"],
        parseFunc,
        mMotionConfigs);
    if (mObjects.size() != mMotionConfigs.size())
    {
        ROS_ERROR_STREAM(
            "diff. size b/t mObjects & mMotionConfigs" << '\n' <<
            "mObjects: " << mObjects.size() << '\n' <<
            "mMotionConfigs: " << mMotionConfigs.size());
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    auto object{mObjects.begin()};
    auto motionConfig{mMotionConfigs.cbegin()};
    for (; object != mObjects.end();
         ++object, ++motionConfig)
    {
        const auto objectInitRouteWaypoint{
            mNavigationPath->QueryRouteWaypoint(
                map::WaypointId(
                    motionConfig->laneId,
                    motionConfig->pointId))};
        actor::ConfigureAgentInitStateTransform(
            geometry::Vector3d(objectInitRouteWaypoint.point),
            objectInitRouteWaypoint.angle,
            motionConfig->offset,
            math::real_t{0.0},
            *object);
    }

    mDoneConfigureMotions = true;
    mCanUpdate = true;
}

} // namespace unit {
