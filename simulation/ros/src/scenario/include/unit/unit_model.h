#ifndef _UNIT_MODEL_H_
#define _UNIT_MODEL_H_

#include <memory>
#include <vector>
#include <functional>
#include <ros/ros.h>
#include <itri_msgs/Path.h>
#include <itri_msgs/speed_cmd.h>
#include <itri_msgs/WaypointArray.h>
#include <math_type.h>
#include <carla_actor_update_data.h>
#include <scenario/AgentAttribute.h>
#include <actor_vehicle.h>
#include <map_waypoint_id.h>
#include <iso_agent_manager.h>
#include <utils_object_manager.h>
#include <utils_approximation_evaluator.h>
#include <geometry_vector_3d.h>
#include <unit_model_config.h>

namespace unit {

class Model
{

public:

    typedef std::shared_ptr<Model> Ptr;

    Model(const Model &) = delete;
    Model &operator=(const Model &) = delete;
    virtual ~Model() = default;

    virtual std::string GetId() const;
    virtual void Configure(const ModelConfig &config);
    virtual void Update() = 0;
    virtual void AccessAgentAttributes(
        std::vector<scenario::AgentAttribute> *agentAttributes);
    virtual void RunCarlaUpdate(
        std::vector<carla::ActorUpdateData> *outputActorUpdateDatas);
    void ConfigureIsoPerformanceEvaluation(
        const std::shared_ptr<iso::AgentManager> &isoAgentManager);
    bool CanAccessAgentAttributes() const;

protected:

    using PoseApproximationEvaluator = utils::ApproximationEvaluator<math::HomoXfm3d_t>;
    static constexpr int32_t DefaultQueueSize()
    {return int32_t{1};}

    Model();
    void RegisterIsoAgents(
        const std::vector<std::string> &isoAgentIds,
        const std::vector<std::shared_ptr<actor::Vehicle>> &movingVehicles);
    template<typename AgentType, typename ConfigType>
    void Configure(
        const ModelConfig &config,
        const std::string &agentIdPrefix,
        std::vector<std::shared_ptr<AgentType>> &agnets);
    virtual void ConfigureMotions();
    template <typename AgentType>
    void ConfigureMotions(
        std::vector<std::shared_ptr<AgentType>> &agents);
    template <typename AgentType>
    void AccessAgentAttributes(
        std::vector<scenario::AgentAttribute> *agentAttributes,
        std::vector<std::shared_ptr<AgentType>> agents) const;
    template <typename AgentType> void RunCarlaUpdate(
        std::vector<carla::ActorUpdateData> *actorUpdateDatas,
        std::vector<std::shared_ptr<AgentType>> agents);
    template<typename AgentType>
    void AppendVelocityMarkers(const std::vector<std::shared_ptr<AgentType>> &movingAgents);
    void ExecuteDijkstraPlanning(
        const map::WaypointId &beginWaypointId,
        const map::WaypointId &endWaypointId,
        std::vector<math::Vector3d_t> &outputPlannedWaypoints);
    void ExecuteDijkstraPlanning(
        const map::WaypointId &beginWaypointId,
        const std::vector<int32_t> &viaLaneIds,
        const map::WaypointId &endWaypointId,
        std::vector<math::Vector3d_t> &outputPlannedWaypoints);
    virtual void EgoVehicleSpeedCommandCallback(const itri_msgs::speed_cmd &msg);
    virtual void EgoVehicleWaypointsCallback(const itri_msgs::WaypointArray &msg);
    virtual void EgoVehicleGlobalPathCallback(const itri_msgs::Path &msg);

    Json::Value mConfigJsonValue;
    Json::Value mAgentModelJsonValue;
    std::shared_ptr<actor::EgoVehicleObserver> mEgoVehicleObserver;
    std::shared_ptr<actor::AgentManager> mAgentManager;
    std::shared_ptr<iso::AgentManager> mIsoAgentManager;
    std::shared_ptr<map::NavigationPath> mNavigationPath;
    std::shared_ptr<map::Visualizer> mMapVisualizer;
    std::shared_ptr<measure::Visualizer> mMeasureVisualizer;
    std::shared_ptr<utils::AuxiliaryVisualizer> mAuxiliaryVisualizer;
    std::shared_ptr<scenario::DetectedObjectPublisher> mDetectedObjectPublisher;
    std::shared_ptr<scenario::Visualizer> mVisualizer;
    utils::ObjectManager<PoseApproximationEvaluator> mPoseApproximationEvaluatorManager;
    std::string mConfigFileDir;
    math::real_t mTimeStep;
    bool mCanAccessAgentAttributes;
    bool mDoneConfigureMotions;
    bool mGotGlobalPath;
    bool mGotSpeedCmd;
    bool mCanUpdate;
    ros::NodeHandle mNodeHandle;
    ros::Subscriber mEgoVehicleSpeedCommandSubscriber;
    ros::Subscriber mEgoVehicleGlobalPathSubscriber;
    ros::Subscriber mEgoVehicleWaypointsSubscriber;
    ros::ServiceClient mDijkstraPlanningService;
    std::vector<geometry::Vector3d> mEgoVehicleGlobalPath;
    bool mIsEgoVehicleSpeedCommandReady;

private:

    bool mIsValidProcedure;
};

} // namespace unit {

#endif // #ifndef _UNIT_MODEL_H_
