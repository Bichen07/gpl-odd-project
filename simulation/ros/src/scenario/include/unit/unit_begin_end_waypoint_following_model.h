#ifndef _UNIT_BEGIN_END_WAYPOINT_FOLLOWING_MODEL_H_
#define _UNIT_BEGIN_END_WAYPOINT_FOLLOWING_MODEL_H_

#include <unit_model.h>
#include <map>
#include <std_msgs/Bool.h>
#include <measure_frenet_distance_evaluator.h>
#include <motion_begin_end_waypoint_following_config.h>
#include <actor_agent_speed_manager.h>
#include <ctrl_waypoint_follower.h>
#include <utils_object_manager.h>

namespace unit {

class BeginEndWaypointFollowingModel final : public Model
{

public:

    typedef std::shared_ptr<BeginEndWaypointFollowingModel> Ptr;

    BeginEndWaypointFollowingModel();
    BeginEndWaypointFollowingModel(const BeginEndWaypointFollowingModel &) = delete;
    BeginEndWaypointFollowingModel &operator=(const BeginEndWaypointFollowingModel &) = delete;
    virtual ~BeginEndWaypointFollowingModel() = default;

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
    {return "begin_end_waypoint_following_";}

    void ConfigureMotions();
    virtual void EgoVehicleSpeedCommandCallback(const itri_msgs::speed_cmd &msg) override;

    std::vector<actor::Vehicle::Ptr> mMovingVehicles;
    std::vector<motion::BeginEndWaypointFollowingConfig> mMotionConfigs;
    utils::ObjectManager<ctrl::WaypointFollower> mWaypointFollowerManager;
    measure::FrenetDistanceEvaluator mFrenetDistanceEvaluator;
    std::map<std::string, bool> mMoveTriggerMap;
    actor::AgentSpeedManager mAgentSpeedManager;
};

} // namespace unit {

#endif // #ifndef _UNIT_BEGIN_END_WAYPOINT_FOLLOWING_MODEL_H_
