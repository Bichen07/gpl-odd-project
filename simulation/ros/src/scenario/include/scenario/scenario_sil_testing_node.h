#ifndef _SCENARIO_SIL_TESTING_NODE_
#define _SCENARIO_SIL_TESTING_NODE_

#include <ros/ros.h>
#include <utils_desired_frequency_evaluator.h>
#include <scenario_detected_object_coord.h>
#include <scenario_simulator_manager.h>

namespace scenario {

class SilTestingNode final
{
    static constexpr int32_t DefaultQueueSize()
    {return int32_t{1};}

public:

    static constexpr math::real_t DefaultNodeFrequency()
    {return math::real_t{100.0};}
    static constexpr math::real_t DefaultDetectedObjectFrequency()
    {return math::real_t{10.0};}
    static constexpr math::real_t DefaultVisualizationFrequency()
    {return math::real_t{100.0};}
    static constexpr int32_t DefaultDetectedObjectIdOffset()
    {return int32_t{0};}

    SilTestingNode();
    SilTestingNode(const SilTestingNode &) = delete;
    SilTestingNode &operator=(const SilTestingNode &) = delete;
    virtual ~SilTestingNode() = default;

    void Configure(
        const math::real_t nodeFrequency,
        const math::real_t desiredDetectedObjectFrequency,
        const math::real_t desiredVisualizationFrequency,
        const DetectedObjectCoord &detectedObjectCoord,
        const int32_t detectedObjectIdOffset = DefaultDetectedObjectIdOffset());
    void RunMainLoop();

protected:

private:

    void Publish();

    ros::NodeHandle mNodeHandle;
    ros::ServiceClient mPathRepublishingService;
    math::real_t mNodeFrequency;
    utils::DesiredFrequencyEvaluator mDesiredDetectedObjectFrequencyEvaluator;
    utils::DesiredFrequencyEvaluator mDesiredVisualizationFrequencyEvaluator;
    DetectedObjectCoord mDetectedObjectCoord;
    SimulatorManager mSimulatorManager;
    bool mCanEnablePathRepublishing;

    int32_t mLoopCount;
};

} // namespace scenario {

#endif // #ifndef _SCENARIO_SIL_TESTING_NODE_
