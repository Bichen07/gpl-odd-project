#include <scenario_detected_object_publisher.h>
#include <ros/console.h>
#include <itri_msgs/DetectedObjectArray.h>

namespace scenario {

// public func.

DetectedObjectPublisher::DetectedObjectPublisher()
    : mNodeHandle{}
    , mDetectedObjectArrayPublisher{}
    , mAgents{}
    , mLidarDetectedObjects{}
    , mDetectedObjectMsgGenerator{}
{
    mDetectedObjectArrayPublisher =
        mNodeHandle.advertise<itri_msgs::DetectedObjectArray>(
            "detected_objects",
            DefaultQueueSize());
}

void DetectedObjectPublisher::Configure(
    const DetectedObjectIdManager::Ptr &detectedObjectIdManager,
    const math::HomoXfm3d_t &initBaseLinkToMapXfm)
{
    mDetectedObjectMsgGenerator.Configure(
        detectedObjectIdManager,
        initBaseLinkToMapXfm);
}

void DetectedObjectPublisher::AppendAgent(const actor::Agent::Ptr &agent)
{
    if (!agent)
    {
        return;
    }

    mAgents.push_back(agent);
}

void DetectedObjectPublisher::AppendAgents(const std::vector<actor::Agent::Ptr> &agents)
{
    if (agents.empty())
    {
        return;
    }

    mAgents.insert(
        mAgents.end(),
        agents.begin(),
        agents.end());
}

void DetectedObjectPublisher::AppendVehicle(const actor::Vehicle::Ptr &vehicle)
{
    if (!vehicle)
    {
        return;
    }

    mAgents.push_back(vehicle);
}

void DetectedObjectPublisher::AppendVehicles(const std::vector<actor::Vehicle::Ptr> &vehicles)
{
    if (vehicles.empty())
    {
        return;
    }

    mAgents.insert(mAgents.end(), vehicles.begin(), vehicles.end());
}

void DetectedObjectPublisher::AppendPedestrian(const actor::Pedestrian::Ptr &pedestrian)
{
    if (!pedestrian)
    {
        return;
    }

    mAgents.push_back(pedestrian);
}

void DetectedObjectPublisher::AppendPedestrians(
    const std::vector<actor::Pedestrian::Ptr> &pedestrians)
{
    if (pedestrians.empty())
    {
        return;
    }

    mAgents.insert(mAgents.end(), pedestrians.begin(), pedestrians.end());
}

void DetectedObjectPublisher::AppendObstacle(const actor::Obstacle::Ptr &obstacle)
{
    if (!obstacle)
    {
        return;
    }

    mAgents.push_back(obstacle);
}

void DetectedObjectPublisher::AppendObstacles(
    const std::vector<actor::Obstacle::Ptr> &obstacles)
{
    if (obstacles.empty())
    {
        return;
    }

    mAgents.insert(mAgents.end(), obstacles.begin(), obstacles.end());
}

void DetectedObjectPublisher::AppendLidarDetectedObject(
    const std::shared_ptr<sensor::LidarDetectedObject> &lidarDetectedObject)
{
    if (!lidarDetectedObject)
    {
        return;
    }

    mLidarDetectedObjects.push_back(lidarDetectedObject);
}

void DetectedObjectPublisher::AppendLidarDetectedObjects(
    const std::vector<std::shared_ptr<sensor::LidarDetectedObject>> &lidarDetectedObjects)
{
    if (lidarDetectedObjects.empty())
    {
        return;
    }

    mLidarDetectedObjects.insert(
        mLidarDetectedObjects.end(),
        lidarDetectedObjects.begin(),
        lidarDetectedObjects.end());
}

void DetectedObjectPublisher::ExtractDetectedAgentData(
    std::vector<DetectedAgentData> *detectedAgentDatas) const
{
    if (nullptr == detectedAgentDatas)
    {
        ROS_ERROR_STREAM("detectedAgentDatas is nullptr");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    detectedAgentDatas->clear();
    detectedAgentDatas->resize(mAgents.size());
    std::transform(
        mAgents.cbegin(),
        mAgents.cend(),
        detectedAgentDatas->begin(),
        [](const std::shared_ptr<actor::Agent> &agent)
        {
            return DetectedAgentData(
                agent->GetAttribute(),
                agent->GetState());
        });
}

void DetectedObjectPublisher::Publish(const DetectedObjectCoord &coord)
{
    itri_msgs::DetectedObjectArray detectedObjectArray;
    mDetectedObjectMsgGenerator.ComputeMsg(
        mAgents,
        mLidarDetectedObjects,
        ros::Time::now(),
        coord,
        detectedObjectArray);
    mDetectedObjectArrayPublisher.publish(detectedObjectArray);
}

void DetectedObjectPublisher::Clear()
{
    mAgents.clear();
    mLidarDetectedObjects.clear();
}

// protected func.

// private func.

} // namespace scenario {
