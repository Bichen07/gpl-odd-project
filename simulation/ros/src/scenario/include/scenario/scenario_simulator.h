#ifndef _SCENARIO_SIMULATOR_H_
#define _SCENARIO_SIMULATOR_H_

#include <memory>
#include <vector>
#include <ros/ros.h>
#include <std_msgs/Bool.h>
#include <carla_actor_update_data.h>
#include <unit_model.h>
#include <scenario/AgentAttribute.h>
#include <utils_time_step_evaluator.h>
#include <motion_waypoint_evaluator.h>
#include <scenario_simulator_config.h>

namespace scenario {

class Simulator
{

public:

    Simulator(const Simulator &) = delete;
    Simulator &operator=(const Simulator &) = delete;
    virtual ~Simulator() = default;

    virtual void Configure(const SimulatorConfig &config) = 0;
    virtual void Update();
    virtual void AccessAgentAttributes(
        std::vector<scenario::AgentAttribute> *outputAgentAttributes);
    virtual void RunCarlaUpdate(
        std::vector<carla::ActorUpdateData> *outputActorUpdateDatas);
    virtual bool CanAccessAgentAttributes() const;

protected:

    static constexpr int32_t DefaultQueueSize()
    {return int32_t{1};}

    Simulator();
    void Configure(
        const SimulatorConfig &config,
        const std::vector<unit::Model::Ptr> &unitModels);
    void RegisterUnitModel(const unit::Model::Ptr &unitModel);
    void ToUnitModelConfig(
        const SimulatorConfig &simulatorConfig,
        unit::ModelConfig &outputUnitModelConfig) const;
    virtual void NavigationPathReadinessCallback(const std_msgs::Bool &msg);

    ros::NodeHandle mNodeHandle;
    ros::Subscriber mNavigationPathReadinessSubscriber;
    ros::Publisher mRssEgoVehicleDataPublisher;
    ros::Publisher mRssAgentDataArrayPublisher;
    Json::Value mConfigJsonValue;
    Json::Value mAgentModelJsonValue;
    std::shared_ptr<actor::EgoVehicleObserver> mEgoVehicleObserver;
    std::shared_ptr<actor::AgentManager> mAgentManager;
    std::shared_ptr<map::NavigationPath> mNavigationPath;
    std::shared_ptr<map::Visualizer> mMapVisualizer;
    std::shared_ptr<measure::Visualizer> mMeasureVisualizer;
    std::shared_ptr<utils::AuxiliaryVisualizer> mAuxiliaryVisualizer;
    std::shared_ptr<DetectedObjectPublisher> mDetectedObjectPublisher;
    std::shared_ptr<Visualizer> mVisualizer;
    std::string mConfigFileDir;
    math::real_t mTimeStep;

private:

    bool mIsNavigationPathReady;
    motion::WaypointEvaluator mEgoVehicleWaypointEvaluator;
    utils::TimeStepEvaluator mTimeStepEvaluator;
    std::vector<unit::Model::Ptr> mUnitModels;
};

} // namespace scenario {

#endif // #ifndef _SCENARIO_SIMULATOR_H_
