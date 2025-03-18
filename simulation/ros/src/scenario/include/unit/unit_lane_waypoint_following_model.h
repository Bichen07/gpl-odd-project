#ifndef _UNIT_LANE_WAYPOINT_FOLLOWING_MODEL_H_
#define _UNIT_LANE_WAYPOINT_FOLLOWING_MODEL_H_

#include <unit_model.h>
#include <map>
#include <std_msgs/Bool.h>
#include <actor_agent_speed_manager.h>
#include <measure_frenet_distance_evaluator.h>
#include <map_waypoint_manager.h>
#include <motion_lane_waypoint_following_config.h>
#include <ctrl_waypoint_follower.h>
#include <utils_object_manager.h>

namespace unit {

class LaneWaypointFollowingModel final : public Model
{

public:

    typedef std::shared_ptr<LaneWaypointFollowingModel> Ptr;

    LaneWaypointFollowingModel();
    LaneWaypointFollowingModel(const LaneWaypointFollowingModel &) = delete;
    LaneWaypointFollowingModel &operator=(const LaneWaypointFollowingModel &) = delete;
    virtual ~LaneWaypointFollowingModel() = default;

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
    {return "lane_waypoint_following_";}
    
    void ConfigureMotions();
    virtual void EgoVehicleSpeedCommandCallback(const itri_msgs::speed_cmd &msg) override;

    std::vector<std::shared_ptr<actor::Vehicle>> mMovingVehicles;
    std::vector<motion::LaneWaypointFollowingConfig> mMotionConfigs;
    utils::ObjectManager<ctrl::WaypointFollower> mWaypointFollowerManager;
    map::WaypointManager mWaypointManager;
    measure::FrenetDistanceEvaluator mFrenetDistanceEvaluator;
    std::map<std::string, bool> mMoveTriggerMap;
    actor::AgentSpeedManager mAgentSpeedManager;
};

} // namespace unit {

#endif // #ifndef _UNIT_LANE_WAYPOINT_FOLLOWING_MODEL_H_
