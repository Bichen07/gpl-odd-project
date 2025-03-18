#ifndef _SCENARIO_SERVER_NODE_H_
#define _SCENARIO_SERVER_NODE_H_

#include <mutex>
#include <ros/ros.h>
#include <utils_desired_frequency_evaluator.h>
#include <scenario/DetectedObjectEvaluation.h>
#include <scenario_detected_agent_data.h>
#include <scenario_simulator_manager.h>

namespace scenario {

class UpdaterNode final
{
    static constexpr int32_t DefaultQueueSize()
    {return int32_t{1};}

public:

    static constexpr double DefaultNodeFrequency()
    {return math::real_t{100.0};}
    static constexpr double DefaultDetectedObjectFrequency()
    {return math::real_t{10.0};}
    static constexpr double DefaultVisualizationFrequency()
    {return math::real_t{100.0};}
    static constexpr int32_t DefaultDetectedObjectIdOffset()
    {return int32_t{5000};}

    UpdaterNode();
    UpdaterNode(const UpdaterNode &) = delete;
    UpdaterNode &operator=(const UpdaterNode &) = delete;
    virtual ~UpdaterNode();

    void Configure(
        const double nodeFrequency = DefaultNodeFrequency(),
        const double desiredDetectedObjectFrequency = DefaultDetectedObjectFrequency(),
        const double desiredVisualizationFrequency = DefaultVisualizationFrequency(),
        const int32_t detectedObjectIdOffset = DefaultDetectedObjectIdOffset());
    bool RunDetectedObjectEvaluationService(
        DetectedObjectEvaluation::Request &request,
        DetectedObjectEvaluation::Response &response);
    void RunMainLoop();

protected:

private:

    void Update();  // Update agent info by sending request to simulation_adv

    ros::NodeHandle mNodeHandle;
    ros::ServiceServer mDetectedObjectEvaluationService;
    ros::ServiceClient mRequestAgentUpdate;

    math::real_t mNodeFrequency;
    int32_t mDetectedObjectIdOffset;
    SimulatorManager mSimulatorManager;
    utils::DesiredFrequencyEvaluator mDetectedObjectFrequencyEvaluator;
    utils::DesiredFrequencyEvaluator mDesiredVisualizationFrequencyEvaluator;
    std::vector<DetectedAgentData> mDetectedAgentDatas;
    DetectedObjectMsgGenerator mDetectedObjectMsgGenerator;
    std::mutex mDetectedAgentDataMutex;
};

} // namespace scenario {

#endif // #ifndef _SCENARIO_SERVER_NODE_H_
