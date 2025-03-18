#ifndef __SIMULATION_H__
#define __SIMULATION_H__

#include <Box2D.h>
#include <car.h>
#include <common_vehicle.h>
#include <context.h>
#include <customized_box2d.h>
#include <ego_handler.h>
#include <itri_msgs/CarState.h>
#include <itri_msgs/Path.h>
#include <map>
#include <memory>
#include <pcl/kdtree/kdtree_flann.h>
#include <pcl/point_cloud.h>
#include <ros/node_handle.h>
#include <ros/ros.h>
#include <scenario_msgs/AgentData.h>
#include <scenario_msgs/AgentDataArray.h>
#include <sim_vehicle.h>
#include <simulation_msgs/SimulationAgentControl.h>
#include <simulation_msgs/SimulationAgentDataControl.h>
#include <simulation_msgs/SimulationAgentStateControl.h>
#include <simulation_msgs/SimulationAgentVelocityControl.h>
#include <simulation_srvs/SimulationCreateAgent.h>
#include <simulation_srvs/SimulationCreateAgentByDefaultPose.h>
#include <simulation_srvs/SimulationDeleteAgent.h>
#include <simulation_srvs/SimulationGetAgentsWithinMeters.h>
#include <simulation_srvs/SimulationPlayStateControl.h>
#include <simulation_srvs/SimulationUpdateAgents.h>
#include <simulation_srvs/SimulationUpdateAgentsData.h>
#include <std_msgs/Bool.h>
#include <string>

class Simulation
{
public:
    Simulation(bool publishScenarioVisualization);
    void OneStep();
    void OneStepSync();
    void RestoreStatus();

protected:
    void HandleSimulationProcess();
    void UpdateSimulation(bool simulationPaused);

    void CreateAgent(simulation_srvs::SimulationCreateAgentByDefaultPose::Request& request);
    void CreateEgoWithoutHandler(simulation_srvs::SimulationCreateAgentByDefaultPose::Request& request);
    void CreateAgent(simulation_srvs::SimulationCreateAgent::Request& request);
    void CreateEgoWithoutHandler(simulation_srvs::SimulationCreateAgent::Request& request);
    void DeleteEgoLeaveHandler(const std::string& agentId);
    void DeleteAgent(const std::string& agentId);
    void SetCreateCommon(const std::string& agentId, std::shared_ptr<Vehicle>& agent, bool simWithExternalVehicle, bool createEgoHandler);

private:
    void CalculateGlobalObjects(jsk_recognition_msgs::PolygonArray&,
                                visualization_msgs::MarkerArray&,
                                visualization_msgs::MarkerArray&,
                                scenario_msgs::AgentDataArray&);
    void CalculateObjectPolygon(const CarStatus&, geometry_msgs::PolygonStamped&);

    // Callbacks below were implemented in simulation_control.cpp
    void CallbackAgentDataCmd(const simulation_msgs::SimulationAgentDataControl cmd);
    void CallbackAgentVelocityCmd(const simulation_msgs::SimulationAgentVelocityControl cmd);
    void CallbackAgentStateCmd(const simulation_msgs::SimulationAgentStateControl cmd);
    void CallbackAgentCmd(const simulation_msgs::SimulationAgentControl cmd);
    void CallbackGlobalPath(const itri_msgs::Path& msg);

    void CallbackScenarioControlSpeedCmd(const itri_msgs::speed_cmd& msg);
    void CallbackStartEsmini(const std_msgs::Bool& msg);

    // Service handlers below were implemented in simulation_control.cpp
    bool RunCreateAgentService(simulation_srvs::SimulationCreateAgent::Request& request, simulation_srvs::SimulationCreateAgent::Response& response);
    bool RunCreateAgentByDefaultPoseService(simulation_srvs::SimulationCreateAgentByDefaultPose::Request&  request,
                                            simulation_srvs::SimulationCreateAgentByDefaultPose::Response& response);
    bool RunCreatePropService(simulation_srvs::SimulationUpdateAgentsData::Request&  request,
                              simulation_srvs::SimulationUpdateAgentsData::Response& response);
    bool RunDeleteAgentService(simulation_srvs::SimulationDeleteAgent::Request& request, simulation_srvs::SimulationDeleteAgent::Response& response);
    bool RunUpdateAgentsService(simulation_srvs::SimulationUpdateAgents::Request&  request,
                                simulation_srvs::SimulationUpdateAgents::Response& response);
    bool RunUpdateAgentsDataService(simulation_srvs::SimulationUpdateAgentsData::Request&  request,
                                    simulation_srvs::SimulationUpdateAgentsData::Response& response);
    bool PlayStateControlService(simulation_srvs::SimulationPlayStateControl::Request&  request,
                                 simulation_srvs::SimulationPlayStateControl::Response& response);

    void ScenarioStableCallback(const std_msgs::Bool msg);

    float GetAltitude(const float x, const float y);

    ros::NodeHandle mNodeHandle;
    ros::Publisher  mPubObjectViz;
    ros::Publisher  mPubAgentDataArray;
    ros::Publisher  mPubVelocityArrow;
    ros::Publisher  mPubScenarioVisualization;

    ros::Subscriber mResetPoseCmd;
    ros::Subscriber mSubGlobalPath;
    ros::Subscriber mAgentDataControlCmd;
    ros::Subscriber mAgentControlCmd;
    ros::Subscriber mAgentStateControlCmd;
    ros::Subscriber mAgentVelocityControlCmd;

    ros::Subscriber mScenarioControlSpeedCmd;
    ros::Subscriber mStartEsminiSubscriber;

    ros::ServiceServer mCreateAgentService;
    ros::ServiceServer mCreateAgentByDefaultPoseService;
    ros::ServiceServer mCreatePropService;
    ros::ServiceServer mDeleteAgentService;
    ros::ServiceServer mUpdateAgentsService;
    ros::ServiceServer mUpdateAgentsDataService;
    ros::ServiceServer mPlayStateControlService;

    bool                          mUseCarla;
    bool                          mPublishScenarioVisualization;
    uint64_t                      mLoopStamp;
    PlayStatus                    mPlayStatus;
    uint64_t                      mDetectedObjectIdCount;
    scenario_msgs::AgentDataArray mExternalStaticProp;
    std::string                   mFilteredClusterHullsTopic;

    std::map<std::string, std::shared_ptr<Vehicle>>    mAgentList;
    std::map<std::string, CarStatus>                   mAgentInitStatus;
    std::map<std::string, std::shared_ptr<EgoHandler>> mEgoHandlers;
    std::map<std::string, ControlCommand>              mCommandList;
    std::shared_ptr<std::vector<StatusOneStep>>        mStatusHistory;

    std::shared_ptr<b2World> mWorld;
    MyB2ContactFilter        mContactFilter;
    MyB2ContactListener      mContactListener;

    std::shared_ptr<GlobalPathHandler> mGlobalPathHandler;

    itri_msgs::speed_cmd mScenarioControlSpeedCmdMsg;
    ros::Subscriber      mScenarioStableSubscriber;
    bool                 mScenarioStable;
    bool                 mIsEsminiBegin;
};

#endif  // __SIMULATION_H__
