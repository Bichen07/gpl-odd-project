#include "scenario_visualizer.h"
#include <ros/console.h>
#include <math_utils.h>
#include <utils_converter.h>
#include <utils_default_color.h>
#include <utils_color.h>
#include <utils_visualization_msgs.h>
#include <geometry_utils.h>
#include <actor_utils.h>

namespace scenario {

// public func.

Visualizer::Visualizer()
    : mNodeHandle{}
    , mAgentDataArrayPublisher{}
    , mVisualizationMsgsManager{nullptr}
    , mDetectedObjectIdManager{nullptr}
    , mVehicles{}
    , mPedestrians{}
    , mObstacles{}
    , mCollidedAgentIdList{}
    , mWaypointMap{}
    , mEgoVehicleRect{}
    , mVehicleFrontWarningRegions{}
    , mHasEgoVehicleCollision{false}
    , mEgoVehicleId{"ego_vehicle"}
{
    mAgentDataArrayPublisher =
        mNodeHandle.advertise<scenario_msgs::AgentDataArray>(
            "scenario/agent_data_array",
            DefaultQueueSize());

    if (!ros::param::get("carla/actual_role_name", mEgoVehicleId))
    {
        mEgoVehicleId = "ego_vehicle";
    }

}

Visualizer::~Visualizer()
{
}

void Visualizer::Configure(
    const std::shared_ptr<VisualizationMsgsManager> &visualizationMsgsManager,
    const std::shared_ptr<DetectedObjectIdManager> &detectedObjectIdManager)
{
    mVisualizationMsgsManager = visualizationMsgsManager;
    mDetectedObjectIdManager = detectedObjectIdManager;
}

void Visualizer::SetEgoVehicleRect(const geometry::Rect3d &egoVehicleRect, const motion::State &carState)
{
    mEgoVehicleRect = egoVehicleRect;
    mEgoVehicleCarState = carState;
}

void Visualizer::SetEgoVehicleCollisionState(const bool hasEgoVehicleCollision)
{
    mHasEgoVehicleCollision = hasEgoVehicleCollision;
}

void Visualizer::AppendVehicle(const std::shared_ptr<actor::Vehicle> &vehicle)
{
    if (!vehicle)
    {
        return;
    }

    mVehicles.push_back(vehicle);
}

void Visualizer::AppendVehicles(const std::vector<std::shared_ptr<actor::Vehicle>> &vehicles)
{
    if (vehicles.empty())
    {
        return;
    }

    mVehicles.insert(mVehicles.end(), vehicles.begin(), vehicles.end());
}

void Visualizer::AppendPedestrian(const std::shared_ptr<actor::Pedestrian> &pedestrian)
{
    if (!pedestrian)
    {
        return;
    }

    mPedestrians.push_back(pedestrian);
}

void Visualizer::AppendPedestrians(const std::vector<std::shared_ptr<actor::Pedestrian>> &pedestrians)
{
    if (pedestrians.empty())
    {
        return;
    }

    mPedestrians.insert(mPedestrians.end(), pedestrians.begin(), pedestrians.end());
}

void Visualizer::AppendObstacle(const std::shared_ptr<actor::Obstacle> &obstacle)
{
    if (!obstacle)
    {
        return;
    }

    mObstacles.push_back(obstacle);
}

void Visualizer::AppendObstacles(const std::vector<std::shared_ptr<actor::Obstacle>> &obstacles)
{
    if (obstacles.empty())
    {
        return;
    }

    mObstacles.insert(mObstacles.end(), obstacles.begin(), obstacles.end());
}

void Visualizer::AppendVehicleFrontWarningRegion(const std::vector<math::Vector3d_t> &region)
{
    mVehicleFrontWarningRegions.push_back(region);
}

void Visualizer::AppendVehicleFrontWarningRegions(const std::vector<std::vector<math::Vector3d_t>> &regions)
{
    if (regions.empty())
    {
        return;
    }

    mVehicleFrontWarningRegions.insert(
        mVehicleFrontWarningRegions.end(),
        regions.begin(),
        regions.end());
}

void Visualizer::AppendCollidedAgentId(const std::string &agentId)
{
    mCollidedAgentIdList.push_back(agentId);
}

void Visualizer::AppendCollidedAgentIds(const std::list<std::string> &agentIds)
{
    if (agentIds.empty())
    {
        return;
    }

    mCollidedAgentIdList.insert(mCollidedAgentIdList.end(), agentIds.begin(), agentIds.end());
}

void Visualizer::AppendWaypoints(const std::string &id, const std::vector<math::Vector3d_t> &waypoints)
{
    mWaypointMap.emplace(id, waypoints);
}

void Visualizer::Publish()
{
    this->PublishVehicleFrontWarningRegions();
    this->PublishEgoVehicleRect();
    this->PublishWaypoints();

    this->PublishAgents();
}

void Visualizer::ClearAgents()
{
    mVehicles.clear();
    mPedestrians.clear();
    mObstacles.clear();
    mCollidedAgentIdList.clear();
    mHasEgoVehicleCollision = false;
}

// protected func.

// private func.

void Visualizer::PublishEgoVehicleRect()
{
    if (geometry::IsZero(mEgoVehicleRect))
    {
        return;
    }

    std_msgs::ColorRGBA colorMsgs{utils::Red()};
    if (mHasEgoVehicleCollision)
    {
        colorMsgs = utils::ComputeComplementaryColor(colorMsgs);
    }

    visualization_msgs::Marker egoVehicleRectMarker;
    this->GenerateEgoVehicleRectMarkerMsgs(
        mVisualizationMsgsManager->QueryMarkerId(mEgoVehicleId),
        geometry::ExtractCorners(mEgoVehicleRect),
        colorMsgs,
        &egoVehicleRectMarker);

    mVisualizationMsgsManager->Publish(egoVehicleRectMarker);
}

void Visualizer::PublishVehicleFrontWarningRegions()
{
    if (mVehicleFrontWarningRegions.empty())
    {
        return;
    }

    visualization_msgs::MarkerArray warningRegionMarkerArray;
    warningRegionMarkerArray.markers.resize(mVehicleFrontWarningRegions.size());

    auto region{mVehicleFrontWarningRegions.cbegin()};
    auto marker{warningRegionMarkerArray.markers.begin()};
    for (; region != mVehicleFrontWarningRegions.cend(); ++region, ++marker)
    {
        const int32_t idx = static_cast<int32_t>(
            std::distance(mVehicleFrontWarningRegions.cbegin(), region));
        if (region->empty())
        {
            continue;
        }

        const std::string regionId =
            "vehicle_front_warning_region_" +
            std::to_string(idx);

        this->GenerateVehicleWarningRegionMarkerMsgs(
            mVisualizationMsgsManager->QueryMarkerId(regionId),
            *region,
            utils::Brown(),
            &(*marker));
    }

    mVisualizationMsgsManager->Publish(warningRegionMarkerArray);
    mVehicleFrontWarningRegions.clear();
}

void Visualizer::PublishAgents()
{
    this->GenerateAgentDataArray();
    if (!mAgentDataArray.data.empty())
    {
        mAgentDataArrayPublisher.publish(mAgentDataArray);
    }

    mCollidedAgentIdList.clear();
    mHasEgoVehicleCollision = false;
}

void Visualizer::PublishWaypoints()
{
    if (mWaypointMap.empty())
    {
        return;
    }

    visualization_msgs::MarkerArray markerArray;
    markerArray.markers.resize(mWaypointMap.size());
    const ros::Time stamp{ros::Time::now()};
    const char *ns{"scenario_waypoints"};

    auto waypointPair{mWaypointMap.begin()};
    auto marker{markerArray.markers.begin()};
    for (; waypointPair != mWaypointMap.end(); ++waypointPair, ++marker)
    {
        const int32_t markerId = mVisualizationMsgsManager->QueryMarkerId(
            waypointPair->first);
        utils::GenerateVisualizationLineStripMsgs(
            markerId,
            ns,
            stamp,
            waypointPair->second,
            math::Vector3d_t(0.5, 0.2, 0.2),
            ros::Duration(),
            utils::Magenta(),
            &(*marker));
        ++marker;
    }

    mVisualizationMsgsManager->Publish(markerArray);
    mWaypointMap.clear();
}

void Visualizer::GenerateAgentDataArray()
{
    const std::size_t agentSize{
        mVehicles.size() + mPedestrians.size() + mObstacles.size()};
    mAgentDataArray.data.clear();
    if (!mVehicles.empty())
    {
        scenario_msgs::AgentDataArray vehicleDataArray;
        this->GenerateAgentDataArrayMsg(
            mVehicles,
            mDetectedObjectIdManager,
            vehicleDataArray);
        mAgentDataArray.data.insert(
            mAgentDataArray.data.end(),
            vehicleDataArray.data.cbegin(),
            vehicleDataArray.data.cend());
    }

    if (!mPedestrians.empty())
    {
        scenario_msgs::AgentDataArray pedestrianDataArray;
        this->GenerateAgentDataArrayMsg(
            mPedestrians,
            mDetectedObjectIdManager,
            pedestrianDataArray);
        mAgentDataArray.data.insert(
            mAgentDataArray.data.end(),
            pedestrianDataArray.data.cbegin(),
            pedestrianDataArray.data.cend());
    }

    if (!mObstacles.empty())
    {
        scenario_msgs::AgentDataArray obstacleDataArray;
        this->GenerateAgentDataArrayMsg(
            mObstacles,
            mDetectedObjectIdManager,
            obstacleDataArray);
        mAgentDataArray.data.insert(
            mAgentDataArray.data.end(),
            obstacleDataArray.data.cbegin(),
            obstacleDataArray.data.cend());
    }

    mVehicles.clear();
    mPedestrians.clear();
    mObstacles.clear();
}

void Visualizer::PublishVehicles()
{
    if (mVehicles.empty())
    {
        return;
    }

    visualization_msgs::MarkerArray vehicleMarkerArray;
    vehicleMarkerArray.markers.resize(mVehicles.size());

    auto vehicle{mVehicles.begin()};
    auto marker{vehicleMarkerArray.markers.begin()};
    for (; vehicle != mVehicles.end(); ++vehicle, ++marker)
    {
        this->GenerateVehicleMarkerMsgs(
            *(*vehicle),
            &(*marker));
    }

    mVehicles.clear();
}

void Visualizer::PublishPedestrians()
{
    if (mPedestrians.empty())
    {
        return;
    }

    visualization_msgs::MarkerArray pedestrianMarkerArray;
    pedestrianMarkerArray.markers.resize(mPedestrians.size());

    auto pedestrian{mPedestrians.begin()};
    auto marker{pedestrianMarkerArray.markers.begin()};
    for (; pedestrian != mPedestrians.end(); ++pedestrian, ++marker)
    {
        this->GeneratePedestrianMarkerMsgs(
            *(*pedestrian),
            &(*marker));
    }

    mVisualizationMsgsManager->Publish(pedestrianMarkerArray);

    mPedestrians.clear();
}

void Visualizer::PublishObstacles()
{
    if (mObstacles.empty())
    {
        return;
    }

    visualization_msgs::MarkerArray markerArray;
    markerArray.markers.resize(mObstacles.size());

    auto marker{markerArray.markers.begin()};

    for (const auto obstacle: mObstacles)
    {
        this->GenerateObstacleMarkerMsgs(
            *obstacle,
            &(*marker));
        ++marker;
    }

    mVisualizationMsgsManager->Publish(markerArray);
    mObstacles.clear();
}

void Visualizer::GenerateEgoVehicleRectMarkerMsgs(
    const int32_t id,
    const std::vector<math::Vector3d_t> &rect,
    const std_msgs::ColorRGBA &colorMsgs,
    visualization_msgs::Marker *markerMsgs) const
{
    markerMsgs->header.frame_id = "map";
    markerMsgs->header.stamp = ros::Time::now();
    markerMsgs->ns = "ego_vehicle";
    markerMsgs->action = visualization_msgs::Marker::ADD;

    markerMsgs->id = id;
    markerMsgs->type = visualization_msgs::Marker::LINE_STRIP;
    markerMsgs->pose = utils::ConvertToGeometryMsgsPose(
        math::RotMat3d_t::Identity(),
        math::Vector3d_t::Zero());
    markerMsgs->scale = utils::ConvertToGeometryMsgsVector3(
        math::Vector3d_t(0.2, 0.2, 0.2));
    markerMsgs->lifetime = ros::Duration();

    markerMsgs->points.resize(rect.size() + 1ul);
    markerMsgs->colors.resize(rect.size() + 1ul);
    auto vertex = rect.begin();
    auto point = markerMsgs->points.begin();
    auto color = markerMsgs->colors.begin();
    for (; vertex != rect.end(); ++vertex, ++point, ++color)
    {
        *point = utils::ConvertToGeometryMsgsPoint(*vertex);
        *color = colorMsgs;
    }

    markerMsgs->points.back() = utils::ConvertToGeometryMsgsPoint(rect.front());
    markerMsgs->colors.back() = colorMsgs;
}

void Visualizer::GenerateVehicleMarkerMsgs(
    const actor::Vehicle &vehicle,
    visualization_msgs::Marker *markerMsgs)
{
    if (!math::IsNormalizedQuaternion(vehicle.GetState().orientation, 1.0e-6))
    {
        ROS_ERROR_STREAM(std::setprecision(6) << std::fixed <<
            "vehicle's orientation is not a normalized quaternion:" << '\n' <<
            "orientation: " << vehicle.GetState().orientation << '\n' <<
            "norm: " << vehicle.GetState().orientation.norm());
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    markerMsgs->header.frame_id = "map";
    markerMsgs->header.stamp = ros::Time::now();
    markerMsgs->ns = "vehicle";
    markerMsgs->action = visualization_msgs::Marker::ADD;
    markerMsgs->id = mVisualizationMsgsManager->QueryMarkerId(
        vehicle.GetAttribute().id);
    markerMsgs->type = visualization_msgs::Marker::CUBE;
    markerMsgs->pose = utils::ConvertToGeometryMsgsPose(
        vehicle.GetState().orientation,
        vehicle.GetState().position);
    markerMsgs->scale = utils::ConvertToGeometryMsgsVector3(
        vehicle.GetAttribute().size);

    if (this->QueryAgentCollisionState(vehicle.GetAttribute().id))
    {
        markerMsgs->color = utils::ComputeComplementaryColor(vehicle.GetAttribute().color);
    }
    else
    {
        markerMsgs->color = vehicle.GetAttribute().color;
    }

    markerMsgs->lifetime = ros::Duration();
}

void Visualizer::GeneratePedestrianMarkerMsgs(
    const actor::Pedestrian &pedestrian,
    visualization_msgs::Marker *markerMsgs)
{
    markerMsgs->header.frame_id = "map";
    markerMsgs->header.stamp = ros::Time::now();
    markerMsgs->ns = "pedestrian";
    markerMsgs->action = visualization_msgs::Marker::ADD;

    markerMsgs->id = mVisualizationMsgsManager->QueryMarkerId(
        pedestrian.GetAttribute().id);

    markerMsgs->type = visualization_msgs::Marker::CUBE;
    markerMsgs->pose = utils::ConvertToGeometryMsgsPose(
        pedestrian.GetState().orientation,
        pedestrian.GetState().position);
    markerMsgs->scale = utils::ConvertToGeometryMsgsVector3(
        pedestrian.GetAttribute().size);

    if (this->QueryAgentCollisionState(pedestrian.GetAttribute().id))
    {
        markerMsgs->color = utils::ComputeComplementaryColor(pedestrian.GetAttribute().color);
    }
    else
    {
        markerMsgs->color = pedestrian.GetAttribute().color;
    }

    markerMsgs->lifetime = ros::Duration();
}

void Visualizer::GenerateObstacleMarkerMsgs(
    const actor::Obstacle &obstacle,
    visualization_msgs::Marker *markerMsgs)
{
    markerMsgs->header.frame_id = "map";
    markerMsgs->header.stamp = ros::Time::now();
    markerMsgs->ns = "obstacle";
    markerMsgs->action = visualization_msgs::Marker::ADD;

    markerMsgs->id = mVisualizationMsgsManager->QueryMarkerId(
        obstacle.GetAttribute().id);

    markerMsgs->type = visualization_msgs::Marker::CUBE;
    markerMsgs->pose = utils::ConvertToGeometryMsgsPose(
        obstacle.GetState().orientation,
        obstacle.GetState().position);
    markerMsgs->scale = utils::ConvertToGeometryMsgsVector3(
        obstacle.GetAttribute().size);

    if (this->QueryAgentCollisionState(obstacle.GetAttribute().id))
    {
        markerMsgs->color = utils::ComputeComplementaryColor(obstacle.GetAttribute().color);
    }
    else
    {
        markerMsgs->color = obstacle.GetAttribute().color;
    }

    markerMsgs->lifetime = ros::Duration();
}

void Visualizer::GenerateVehicleWarningRegionMarkerMsgs(
    const int32_t id,
    const std::vector<math::Vector3d_t> &region,
    const std_msgs::ColorRGBA &colorMsgs,
    visualization_msgs::Marker *markerMsgs) const
{
    markerMsgs->header.frame_id = "map";
    markerMsgs->header.stamp = ros::Time::now();
    markerMsgs->ns = "vehicle_front_warning_region";
    markerMsgs->action = visualization_msgs::Marker::ADD;

    markerMsgs->id = id;
    markerMsgs->type = visualization_msgs::Marker::LINE_STRIP;
    markerMsgs->pose = utils::ConvertToGeometryMsgsPose(
        math::Quaternion_t::Identity(),
        math::Vector3d_t::Zero());
    markerMsgs->scale = utils::ConvertToGeometryMsgsVector3(
        math::Vector3d_t(0.2, 0.2, 0.2));
    markerMsgs->lifetime = ros::Duration();

    markerMsgs->points.resize(region.size());
    markerMsgs->colors.resize(region.size());

    auto vertex{region.begin()};
    auto point{markerMsgs->points.begin()};
    auto color{markerMsgs->colors.begin()};
    for (; vertex != region.end(); ++vertex, ++point, ++color)
    {
        *point = utils::ConvertToGeometryMsgsPoint(*vertex);
        *color = colorMsgs;
    }
}

bool Visualizer::QueryAgentCollisionState(const std::string &agentId) const
{
    const auto foundId = std::find(
        mCollidedAgentIdList.begin(),
        mCollidedAgentIdList.end(),
        agentId);

    return mCollidedAgentIdList.end() != foundId ? true : false;
}

template<typename AgentPtr>
void Visualizer::GenerateAgentDataArrayMsg(
    const std::vector<AgentPtr> &agents,
    DetectedObjectIdManager::Ptr &detectedObjectIdManager,
    scenario_msgs::AgentDataArray &outputMsg)
{
    outputMsg.data.resize(agents.size());
    auto agent{agents.cbegin()};
    auto marker{outputMsg.data.begin()};
    for (; agent != agents.cend();
         ++agent, ++marker)
    {
        this->GenerateAgentDataMsg(
            *(*agent),
            detectedObjectIdManager,
            *marker);
    }
}
template void Visualizer::GenerateAgentDataArrayMsg(
    const std::vector<actor::Vehicle::Ptr> &,
    DetectedObjectIdManager::Ptr &,
    scenario_msgs::AgentDataArray &outputMsg);
template void Visualizer::GenerateAgentDataArrayMsg(
    const std::vector<actor::Pedestrian::Ptr> &,
    DetectedObjectIdManager::Ptr &,
    scenario_msgs::AgentDataArray &outputMsg);
template void Visualizer::GenerateAgentDataArrayMsg(
    const std::vector<actor::Obstacle::Ptr> &,
    DetectedObjectIdManager::Ptr &,
    scenario_msgs::AgentDataArray &outputMsg);

void Visualizer::GenerateAgentDataMsg(
    const actor::Agent &agent,
    DetectedObjectIdManager::Ptr &detectedObjectIdManager,
    scenario_msgs::AgentData &outputMsg)
{
    outputMsg.agent_id = agent.GetAttribute().id;
    outputMsg.detected_object_id = detectedObjectIdManager->QueryId(
        agent.GetAttribute().id);
    outputMsg.pose = utils::ConvertToGeometryMsgsPose(
        agent.GetTransform3d());
    outputMsg.linear_velocity = utils::ConvertToGeometryMsgsVector3(
        agent.GetState().linearVelocity);
    outputMsg.size = utils::ConvertToGeometryMsgsVector3(
        agent.GetAttribute().size);
    outputMsg.color = agent.GetAttribute().color;
    outputMsg.objectClassId = actor::ToObjectClassLabel(agent.GetAttribute().objectClassId);
}

} // namespace scenario {
