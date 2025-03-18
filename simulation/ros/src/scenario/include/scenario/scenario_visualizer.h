#ifndef _SCENARIO_VISUALIZER_H_
#define _SCENARIO_VISUALIZER_H_

#include <memory>
#include <mutex>
#include <list>
#include <map>
#include <ros/ros.h>
#include <std_msgs/ColorRGBA.h>
#include <geometry_msgs/Pose.h>
#include <geometry_msgs/Vector3.h>
#include <visualization_msgs/MarkerArray.h>
#include <math_type.h>
#include <scenario_msgs/AgentData.h>
#include <scenario_msgs/AgentDataArray.h>
#include <geometry_type.h>
#include <actor_obstacle.h>
#include <actor_pedestrian.h>
#include <actor_vehicle.h>
#include <scenario_type.h>
#include <scenario_detected_object_id_manager.h>
#include <scenario_visualization_msgs_manager.h>
#include <motion_state.h>

namespace scenario {

class Visualizer final
{
    static constexpr int32_t DefaultQueueSize()
    {return int32_t{1};}

public:

    Visualizer();
    Visualizer(const Visualizer &) = delete;
    Visualizer &operator=(const Visualizer &) = delete;
    ~Visualizer();

    void Configure(
        const std::shared_ptr<VisualizationMsgsManager> &visualizationMsgsManager,
        const std::shared_ptr<DetectedObjectIdManager> &detectedObjectIdManager);
    void SetEgoVehicleRect(const geometry::Rect3d &egoVehicleRect, const motion::State &carState);
    void SetEgoVehicleCollisionState(const bool hasEgoVehicleCollision);

    void AppendVehicle(const std::shared_ptr<actor::Vehicle> &vehicle);
    void AppendVehicles(const std::vector<std::shared_ptr<actor::Vehicle>> &vehicles);
    void AppendPedestrian(const std::shared_ptr<actor::Pedestrian> &pedestrian);
    void AppendPedestrians(const std::vector<std::shared_ptr<actor::Pedestrian>> &pedestrians);
    void AppendObstacle(const std::shared_ptr<actor::Obstacle> &obstacle);
    void AppendObstacles(const std::vector<std::shared_ptr<actor::Obstacle>> &obstacles);
    void AppendVehicleFrontWarningRegion(const std::vector<math::Vector3d_t> &region);
    void AppendVehicleFrontWarningRegions(const std::vector<std::vector<math::Vector3d_t>> &regions);
    void AppendCollidedAgentId(const std::string &agentId);
    void AppendCollidedAgentIds(const std::list<std::string> &agentIds);

    void AppendWaypoints(const std::string &id, const std::vector<math::Vector3d_t> &waypoints);

    void Publish();
    void ClearAgents();

protected:

private:

    using ColorPair = std::pair<std_msgs::ColorRGBA, std_msgs::ColorRGBA>;

    void PublishEgoVehicleRect();
    void PublishVehicleFrontWarningRegions();
    void PublishAgents();
    void PublishWaypoints();

    void GenerateAgentDataArray();
    void PublishVehicles();
    void PublishPedestrians();
    void PublishObstacles();

    void GenerateEgoVehicleRectMarkerMsgs(
        const int32_t id,
        const std::vector<math::Vector3d_t> &rect,
        const std_msgs::ColorRGBA &colorMsgs,
        visualization_msgs::Marker *markerMsgs) const;
    void GenerateVehicleMarkerMsgs(
        const actor::Vehicle &vehicle,
        visualization_msgs::Marker *markerMsgs);
    void GeneratePedestrianMarkerMsgs(
        const actor::Pedestrian &pedestrian,
        visualization_msgs::Marker *markerMsgs);
    void GenerateObstacleMarkerMsgs(
        const actor::Obstacle &obstacle,
        visualization_msgs::Marker *markerMsgs);
    void GenerateVehicleWarningRegionMarkerMsgs(
        const int32_t id,
        const std::vector<math::Vector3d_t> &region,
        const std_msgs::ColorRGBA &colorMsgs,
        visualization_msgs::Marker *markerMsgs) const;

    bool QueryAgentCollisionState(const std::string &agentId) const;

    template<typename AgentPtr>
    void GenerateAgentDataArrayMsg(
        const std::vector<AgentPtr> &agents,
        DetectedObjectIdManager::Ptr &detectedObjectIdManager,
        scenario_msgs::AgentDataArray &outputMsg);
    void GenerateAgentDataMsg(
        const actor::Agent &agent,
        DetectedObjectIdManager::Ptr &detectedObjectIdManager,
        scenario_msgs::AgentData &outputMsg);

    ros::NodeHandle mNodeHandle;
    ros::Publisher mAgentDataArrayPublisher;
    std::shared_ptr<VisualizationMsgsManager> mVisualizationMsgsManager;
    DetectedObjectIdManager::Ptr mDetectedObjectIdManager;
    std::vector<std::shared_ptr<actor::Vehicle>> mVehicles;
    std::vector<std::shared_ptr<actor::Pedestrian>> mPedestrians;
    std::vector<std::shared_ptr<actor::Obstacle>> mObstacles;
    scenario_msgs::AgentDataArray mAgentDataArray;
    std::list<std::string> mCollidedAgentIdList;
    std::map<std::string, math::Vector3dColl_t> mWaypointMap;
    geometry::Rect3d mEgoVehicleRect;
    motion::State mEgoVehicleCarState;
    std::vector<std::vector<math::Vector3d_t>> mVehicleFrontWarningRegions;
    bool mHasEgoVehicleCollision;
    std::string mEgoVehicleId;
};

} // namespace scenario {

#endif // #ifndef _SCENARIO_VISUALIZER_H_
