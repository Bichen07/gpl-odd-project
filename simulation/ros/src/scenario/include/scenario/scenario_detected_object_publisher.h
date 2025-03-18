#ifndef _SCENARIO_DETECTED_OBJECT_PUBLISHER_H_
#define _SCENARIO_DETECTED_OBJECT_PUBLISHER_H_

#include <list>
#include <ros/ros.h>
#include <actor_obstacle.h>
#include <actor_pedestrian.h>
#include <actor_vehicle.h>
#include <sensor_lidar_detected_object.h>
#include <scenario_detected_agent_data.h>
#include <scenario_detected_object_id_manager.h>
#include <scenario_detected_object_msg_generator.h>

namespace scenario {

class DetectedObjectPublisher final
{
    static constexpr int32_t DefaultQueueSize()
    {return int32_t{1};}

public:

    DetectedObjectPublisher();
    DetectedObjectPublisher(const DetectedObjectPublisher &) = delete;
    DetectedObjectPublisher &operator=(const DetectedObjectPublisher &) = delete;
    virtual ~DetectedObjectPublisher() = default;

    void Configure(
        const DetectedObjectIdManager::Ptr &detectedObjectIdManager,
        const math::HomoXfm3d_t &initBaseLinkToMapXfm);
    void AppendAgent(const actor::Agent::Ptr &inputAgent);
    void AppendAgents(const std::vector<actor::Agent::Ptr> &inputAgents);
    void AppendVehicle(const actor::Vehicle::Ptr &vehicle);
    void AppendVehicles(const std::vector<actor::Vehicle::Ptr> &vehicles);
    void AppendPedestrian(const actor::Pedestrian::Ptr &pedestrian);
    void AppendPedestrians(const std::vector<actor::Pedestrian::Ptr> &pedestrians);
    void AppendObstacle(const actor::Obstacle::Ptr &obstacle);
    void AppendObstacles(const std::vector<actor::Obstacle::Ptr> &obstacles);
    void AppendLidarDetectedObject(
        const std::shared_ptr<sensor::LidarDetectedObject> &lidarDetectedObject);
    void AppendLidarDetectedObjects(
        const std::vector<std::shared_ptr<sensor::LidarDetectedObject>> &lidarDetectedObjects);
    void ExtractDetectedAgentData(std::vector<DetectedAgentData> *detectedAgentDatas) const;
    void Publish(const DetectedObjectCoord &coord);
    void Clear();

protected:

private:

    ros::NodeHandle mNodeHandle;
    ros::Publisher mDetectedObjectArrayPublisher;
    std::vector<actor::Agent::Ptr> mAgents;
    std::vector<std::shared_ptr<sensor::LidarDetectedObject>> mLidarDetectedObjects;
    DetectedObjectMsgGenerator mDetectedObjectMsgGenerator;
};

} // namespace scenario {

#endif // #ifndef _SCENARIO_DETECTED_OBJECT_PUBLISHER_H_
