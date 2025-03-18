#ifndef _RANDOM_FRENET_TRAJECTORY_GENERATOR_H_
#define _RANDOM_FRENET_TRAJECTORY_GENERATOR_H_

#include <math_frenet_transformer.h>
#include <math_frenet_velocity_transformer.h>
#include <vector>
#include <string>
#include <ros/ros.h>
#include <motion_state.h>
#include <actor_ego_vehicle_observer.h>
#include <std_msgs/String.h>
#include <geometry_msgs/Pose.h>
#include <geometry_msgs/Vector3.h>
#include <itri_msgs/Path.h>
#include <itri_msgs/CarState.h>
#include <scenario_search/QuinticWaypoint.h>
#include <scenario_search/QuinticWaypointArray.h>
#include <scenario_search/GenerateAgentByWaypoint.h>
#include <simulation_srvs/SimulationCreateAgent.h>
#include <simulation_srvs/SimulationDeleteAgent.h>
#include <simulation_msgs/CollisionProfile.h>


namespace scen_srch{

class FrenetTrajectoryAgentGenerator final
{

public:
    FrenetTrajectoryAgentGenerator();
    FrenetTrajectoryAgentGenerator(
        std::string agentSuffix, geometry_msgs::Vector3 agentSize);
    virtual ~FrenetTrajectoryAgentGenerator();

    void Configure(const std::vector<math::Vector3d_t> &waypoint3ds);
    void MainLoop(const bool autoGenerate);
    void CleanAgentsWithSameName();

private:

    std::vector<itri_msgs::CarState> GenerateQuinticAgent(
        scenario_search::GenerateAgentByWaypoint::Request request,
        geometry_msgs::Pose egoPose, math::FrenetCoord fPoint);
    void PublishTrajectory(std::vector<itri_msgs::CarState> & msg);
    bool AgentFailed(itri_msgs::CarState & state);

    bool CheckIntersection(
        std::vector<itri_msgs::CarState> agentProfile, uint currentIdx, 
        math::real_t lookAheadSec);

    bool AgentInDangerArea(const geometry_msgs::Pose agent);

    bool RunGeneratedAgentWrapper(
        std::vector<itri_msgs::CarState> agentProfile,
        const math::real_t delayTime, const math::real_t triggerDistance);
    bool RunGeneratedAgent(
        std::vector<itri_msgs::CarState> agentProfile,
        const math::real_t delayTime, const math::real_t triggerDistance);

    void CallbackGlobalPath(const itri_msgs::Path & msg);
    void CallbackCollisionPath(
        const simulation_msgs::CollisionProfile & msg);

    bool RunGenerateAgentByWaypointService(
        scenario_search::GenerateAgentByWaypoint::Request &request,
        scenario_search::GenerateAgentByWaypoint::Response &response);

    std::string mAgentName;
    geometry_msgs::Vector3 mAgentSize;

    ros::NodeHandle mNodeHandle;
    ros::Subscriber mGlobalPathSubscriber;
    ros::Subscriber mCollisionSubscriber;
    ros::Publisher mAgentTrajPublisher;
    ros::Publisher mAgentStatePublisher;

    ros::ServiceServer mGenerateAgentByWaypointService;
    ros::ServiceClient mCreateAgentService;
    ros::ServiceClient mDeleteAgentService;
    simulation_srvs::SimulationCreateAgent mCreateAgentRequest;
    simulation_srvs::SimulationDeleteAgent mDeleteAgentRequest;

    itri_msgs::Path mGlobalPath;
    std::vector<math::Vector3d_t> mRefWaypoint3ds;
    std::vector<math::Vector2d_t> mRefWaypoint2ds;
    math::FrenetTransformer mFrenetTransformer;
    math::FrenetVelocityTransformer mFrenetVelocityTransformer;

    actor::EgoVehicleObserver mEgoVehicleObserver;

    bool mGlobalPathAcquired;
    ros::Time mCollisionTime;
    uint mMaxTrajMarker;
    uint mAgentCount;
    std::string mCurrentAgentId;
};


} // namespace scen_srch{

#endif // #ifndef _RANDOM_FRENET_TRAJECTORY_GENERATOR_H_