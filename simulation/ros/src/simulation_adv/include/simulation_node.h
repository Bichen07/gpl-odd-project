#ifndef __SIMULATION_NODE_H__
#define __SIMULATION_NODE_H__

#include <itri_msgs/Path.h>
#include <itri_msgs/CarState.h>
#include <itri_msgs/speed_cmd.h>
#include <itri_msgs/steer_cmd.h>
#include <itri_msgs/DetectedObjectArray.h>
#include <simulation_adv/Trigger.h>
#include <memory>
#include <mutex>
#include <functional>
#include <ros/ros.h>
#include <ros/node_handle.h>
#include <simulation.h>

class SimulationNode
{
public:
    using ScenarioPublishFunc           = std::function<void()>;
    using GenerateScenarioAgentMsgsFunc = std::function<void(itri_msgs::DetectedObjectArray *msgs)>;

    SimulationNode();
    ~SimulationNode();
    void Configure();
    void Configure(const ScenarioPublishFunc           &scenarioPublishFunc,
                   const GenerateScenarioAgentMsgsFunc &generateScenarioAgentMsgsFunc,
                   const bool                           isPublishingVisualizationStatus);
    void MainLoop();
    void RunByTick();

protected:
    void CallbackGlobalPath(const itri_msgs::Path &);

private:
    bool TriggerRecieverService(simulation_adv::Trigger::Request &request, simulation_adv::Trigger::Response &response);

    std::shared_ptr<Simulation> mSimulation;
    using PublishStatusFunc = std::function<void()>;

    ros::NodeHandle    mNodeHandle;
    ros::ServiceServer mTriggerServer;

    ScenarioPublishFunc           mScenarioPublishFunc;
    GenerateScenarioAgentMsgsFunc mGenerateScenarioAgentMsgsFunc;
    PublishStatusFunc             mPublishStatusFunc;

    bool  mUseCarla;
    float mTimeStep;
};

#endif  // __SIMULATION_NODE_H__
