#ifndef _SCENARIO_SIMULATOR_MANAGER_H_
#define _SCENARIO_SIMULATOR_MANAGER_H_

#include <memory>
#include <string>
#include <mutex>
#include <ros/ros.h>
#include <scenario/CarlaActorUpdate.h>
#include <scenario/AgentAttributeAccess.h>
#include <scenario/ScenarioUpdate.h>
#include <map_navigation_path.h>
#include <utils_auxiliary_visualizer.h>
#include <actor_agent_manager.h>
#include <actor_ego_vehicle_observer.h>
#include <carla_ego_vehicle_simulator.h>
#include <collision_detector.h>
#include <scenario_simulator_factory.h>
#include <scenario_detected_object_coord.h>
#include <scenario_detected_object_id_manager.h>
#include <scenario_detected_object_publisher.h>
#include <scenario_visualization_msgs_manager.h>
#include <scenario_visualizer.h>
#include <actionlib/server/simple_action_server.h>
#include <scenario/ScenarioReconfigureAction.h>


namespace scenario {

class SimulatorManager final
{
    static constexpr const char *DefaultDataDir()
    {return "/data/";}

public:

    SimulatorManager();
    SimulatorManager(const SimulatorManager &) = delete;
    SimulatorManager &operator=(const SimulatorManager &) = delete;
    virtual ~SimulatorManager() = default;

    void Configure(
        const double nodeFrequency,
        const int32_t detectedObjectIdOffset = 0);
    void Configure(
        const std::string scenarioConfigFile,
        const double nodeFrequency,
        const int32_t detectedObjectIdOffset = 0);

    void Update();
    void Reset();
    void PublishVisualization();
    void PublishDetectedObjects(const DetectedObjectCoord &detectedObjectCoord);

    void ExtractDetectedAgentData(std::vector<DetectedAgentData> *detectedAgentDatas) const;

protected:

private:

    void UpdateEgoVehicle();
    void VerifyScenarioId(const std::string &scenarioId) const;
    void ConfigureEgoVehicleInitPose(
        const std::string &scenarioId,
        const std::string &mapId,
        const std::string &egoInitPoseCnofigFile,
        const std::string &simulatedEgoConfigFile,
        math::HomoXfm3d_t &outputEgoVehicleInitPose);
    bool AccessAgentAttributes(
        AgentAttributeAccess::Request &request,
        AgentAttributeAccess::Response &reponse);
    bool UpdateCarlaActors(
        CarlaActorUpdate::Request &request,
        CarlaActorUpdate::Response &response);
    bool UpdateScenario(
        ScenarioUpdate::Request &request,
        ScenarioUpdate::Response &response);
    bool IsSimulationNodeActive() const;
    void ScenarioReconfigureActionCallback(
        const scenario::ScenarioReconfigureGoalConstPtr &goal);

    ros::NodeHandle mNodeHandle;
    ros::ServiceServer mAgentAttributeAccessService;
    ros::ServiceServer mCarlaActorUpdateService;
    ros::ServiceServer mScenarioUpdateService;
    std::vector<std::string> mScenarioIds;
    SimulatorFactory<std::string> mSimulatorFactory;
    std::unique_ptr<Simulator> mSimulator;
    carla::EgoVehicleSimulator mEgoVehicleSimulator;
    std::shared_ptr<actor::AgentManager> mAgentManager;
    std::shared_ptr<actor::EgoVehicleObserver> mEgoVehicleObserver;
    collision::Detector mCollisionDetector;
    std::shared_ptr<measure::Visualizer> mMeasureVisualizer;
    std::shared_ptr<map::NavigationPath> mNavigationPath;
    std::shared_ptr<map::Visualizer> mMapVisualizer;
    std::shared_ptr<utils::AuxiliaryVisualizer> mAuxiliaryVisualizer;
    std::shared_ptr<DetectedObjectIdManager> mDetectedObjectIdManager;
    std::shared_ptr<DetectedObjectPublisher> mDetectedObjectPublisher;
    std::shared_ptr<Visualizer> mVisualizer;
    std::shared_ptr<VisualizationMsgsManager> mVisualizationMsgsManager;
    bool mUseSimTime;
    bool mUseCarla;
    std::mutex mAgentMotionUpdateMutex;
    std::mutex mDetectedObjectPublishingMutex;
    std::mutex mVisualizationPublishingMutex;
    std::mutex mReconfiguringMutex;

    double mNodeFrequency;
    int32_t mDetectedObjectIdOffset;
    actionlib::SimpleActionServer<
        scenario::ScenarioReconfigureAction> mScenarioReconfigureActionServer;

};

} // namespace scenario {

#endif // #ifndef _SCENARIO_SIMULATOR_MANAGER_H_
