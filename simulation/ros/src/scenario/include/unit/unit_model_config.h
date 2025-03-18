#ifndef _UNIT_MODEL_CONFIG_H_
#define _UNIT_MODEL_CONFIG_H_

#include <memory>
#include <string>
#include <jsoncpp/json/json.h>
#include <map_navigation_path.h>
#include <map_visualizer.h>
#include <measure_visualizer.h>
#include <utils_auxiliary_visualizer.h>
#include <actor_agent_manager.h>
#include <actor_ego_vehicle_observer.h>
#include <scenario_type.h>
#include <scenario_detected_object_publisher.h>
#include <scenario_visualizer.h>

namespace unit {

struct ModelConfig final
{
    double nodeFrequency;
    Json::Value configJsonValue;
    Json::Value agentModelJsonValue;
    std::shared_ptr<actor::EgoVehicleObserver> egoVehicleObserver;
    std::shared_ptr<actor::AgentManager> agentManager;
    std::shared_ptr<map::NavigationPath> navigationPath;
    std::shared_ptr<map::Visualizer> mapVisualizer;
    std::shared_ptr<measure::Visualizer> measureVisualizer;
    std::shared_ptr<utils::AuxiliaryVisualizer> auxiliaryVisualizer;
    std::shared_ptr<scenario::DetectedObjectPublisher> detectedObjectPublisher;
    std::shared_ptr<scenario::Visualizer> visualizer;
    std::string configFileDir;

    ModelConfig()
        : nodeFrequency{0.0}
        , configJsonValue{}
        , agentModelJsonValue{}
        , egoVehicleObserver{nullptr}
        , agentManager{nullptr}
        , navigationPath{nullptr}
        , mapVisualizer{nullptr}
        , measureVisualizer{nullptr}
        , auxiliaryVisualizer{nullptr}
        , detectedObjectPublisher{nullptr}
        , visualizer{nullptr}
        , configFileDir{}
    {
    }
    ModelConfig(const ModelConfig &) = delete;
    ModelConfig &operator=(const ModelConfig &) = delete;
    ~ModelConfig() = default;
};

} // namespace unit {

#endif // #ifndef _UNIT_MODEL_CONFIG_H_
