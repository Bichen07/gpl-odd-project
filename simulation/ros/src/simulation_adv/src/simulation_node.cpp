#include <fstream>
#include <ros/console.h>
#include <ros/init.h>
#include <ros/param.h>
#include <ros/rate.h>
#include <simulation_node.h>

static const float DEFAULT_SAMPLING_TIME = 0.01f;
static const int   TOPIC_BUFFER          = 1;

SimulationNode::SimulationNode() : mNodeHandle(), mScenarioPublishFunc{}, mGenerateScenarioAgentMsgsFunc{}, mUseCarla{false}, mTimeStep{0.01f}
{
    Configure();
    bool publishScenarioVisualization;
    bool publishDetectedObjects100hz;
    ros::param::param<bool>("simulation/using_carla", mUseCarla, false);

    // Set to false if using scenario_visualization package
    // to publish scenario_visualization
    ros::param::param<bool>("~publish_scenario_visualization", publishScenarioVisualization, true);

    mSimulation = std::make_shared<Simulation>(publishScenarioVisualization);
}

SimulationNode::~SimulationNode()
{
}

void SimulationNode::Configure()
{
    ROS_INFO("Running simulation_adv!");

    bool useSimTime{false};

    mTimeStep = DEFAULT_SAMPLING_TIME;

    if (mNodeHandle.hasParam("/use_sim_time"))
    {
        mNodeHandle.getParam("/use_sim_time", useSimTime);
        if (useSimTime)
        {
            if (!ros::param::get("/time_step", mTimeStep))
            {
                ROS_ERROR_STREAM("invalid timeStepKey: /time_step");
                throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
            }

            if (mTimeStep < float{1.0e-6f})
            {
                ROS_ERROR_STREAM("time_step: " << mTimeStep << "is too small");
                throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
            }
        }
    }

    ROS_INFO_STREAM("time_step: " << mTimeStep);
}

void SimulationNode::Configure(const ScenarioPublishFunc&           scenarioPublishFunc,
                               const GenerateScenarioAgentMsgsFunc& generateScenarioAgentMsgsFunc,
                               const bool                           isPublishingVisualizationStatus)
{
    mScenarioPublishFunc           = scenarioPublishFunc;
    mGenerateScenarioAgentMsgsFunc = generateScenarioAgentMsgsFunc;
    Configure();
}

void SimulationNode::MainLoop()
{
    ros::Rate nodeRate(static_cast<int>(1.0f / mTimeStep));
    while (ros::ok())
    {
        mSimulation->OneStep();
        ros::spinOnce();
        nodeRate.sleep();
        if (mScenarioPublishFunc)
            mScenarioPublishFunc();
    }
}

void SimulationNode::RunByTick()
{
    mTriggerServer = mNodeHandle.advertiseService("/simulation/control/trigger", &SimulationNode::TriggerRecieverService, this);

    ros::spin();
}

bool SimulationNode::TriggerRecieverService(simulation_adv::Trigger::Request& request, simulation_adv::Trigger::Response& response)
{
    uint32_t tick = request.tick;
    mSimulation->OneStepSync();
    if (mScenarioPublishFunc)
        mScenarioPublishFunc();

    response.success = true;
    response.message = "";
}

