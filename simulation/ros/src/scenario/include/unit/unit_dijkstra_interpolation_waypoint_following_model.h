#ifndef _UNIT_DIJKSTRA_INTERPOLATION_WAYPOINT_FOLLOWING_MODEL_H_
#define _UNIT_DIJKSTRA_INTERPOLATION_WAYPOINT_FOLLOWING_MODEL_H_

#include <unit_model.h>
#include <map>
#include <measure_frenet_distance_evaluator.h>
#include <motion_dijkstra_interpolation_waypoint_following_config.h>
#include <motion_move_trigger.h>
#include <actor_agent_speed_manager.h>
#include <ctrl_waypoint_follower.h>
#include <utils_object_manager.h>

namespace unit {

class DijkstraInterpolationWaypointFollowingModel final : public Model
{

public:

    typedef std::shared_ptr<DijkstraInterpolationWaypointFollowingModel> Ptr;

    DijkstraInterpolationWaypointFollowingModel();
    DijkstraInterpolationWaypointFollowingModel(
        const DijkstraInterpolationWaypointFollowingModel &) = delete;
    DijkstraInterpolationWaypointFollowingModel &operator=(
        const DijkstraInterpolationWaypointFollowingModel &) = delete;
    virtual ~DijkstraInterpolationWaypointFollowingModel() = default;

    virtual std::string GetId() const override;
    virtual void Configure(const ModelConfig &config) override;
    virtual void Update() override;
    virtual void AccessAgentAttributes(
        std::vector<scenario::AgentAttribute> *agentAttributes) override;
    virtual void RunCarlaUpdate(
        std::vector<carla::ActorUpdateData> *actorUpdateDatas) override;

protected:

private:

    static constexpr const char *AgentIdPrefix()
    {return "dijkstra_interpolation_waypoint_following";}

    void ConfigureMotions();
    virtual void EgoVehicleSpeedCommandCallback(const itri_msgs::speed_cmd &msg) override;
    virtual void EgoVehicleGlobalPathCallback(const itri_msgs::Path &msg) override;

    std::vector<actor::Vehicle::Ptr> mMovingVehicles;
    std::vector<motion::DijkstraInterpolationWaypointFollowingConfig> mMotionConfigs;
    utils::ObjectManager<ctrl::WaypointFollower> mWaypointFollowerManager;
    utils::ObjectManager<motion::MoveTrigger> mMoveTriggerManager;
    measure::FrenetDistanceEvaluator mFrenetDistanceEvaluator;
    std::map<std::string, bool> mMoveTriggerMap;
    actor::AgentSpeedManager mAgentSpeedManager;
};

} // namespace unit {

#endif // #ifndef _UNIT_DIJKSTRA_INTERPOLATION_WAYPOINT_FOLLOWING_MODEL_H_
