#ifndef _UNIT_RED_LIGHT_RUNNING_MODEL_H_
#define _UNIT_RED_LIGHT_RUNNING_MODEL_H_

#include <unit_model.h>
#include <std_msgs/Bool.h>
#include <itri_msgs/TrafficLightObjects.h>
#include <measure_frenet_distance_evaluator.h>
#include <motion_red_light_running_config.h>
#include <actor_vehicle.h>
#include <map_waypoint_manager.h>
#include <map_stop_line_manager.h>
#include <ctrl_collision_avoidance_waypoint_follower.h>
#include <ctrl_ease_in_out_lateral_speed_evaluator.h>

namespace unit {

class RedLightRunningModel final : public Model
{

public:

    typedef std::shared_ptr<RedLightRunningModel> Ptr;

    RedLightRunningModel();
    RedLightRunningModel(const RedLightRunningModel &) = delete;
    RedLightRunningModel &operator=(const RedLightRunningModel &) = delete;
    virtual ~RedLightRunningModel() = default;

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
    {return "red_light_running_";}

    void ConfigureMotions();
    void FakeTrafficLightCallback(const itri_msgs::TrafficLightObjects &msg);
    virtual void EgoVehicleSpeedCommandCallback(const itri_msgs::speed_cmd &msg) override;

    ros::Subscriber mFakeTrafficLightSubscriber;
    std::vector<std::shared_ptr<actor::Vehicle>> mMovingVehicles;
    std::vector<motion::RedLightRunningConfig> mMotionConfigs;
    utils::ObjectManager<ctrl::WaypointFollower> mWaypointFollowerManager;
    utils::ObjectManager<ctrl::EaseInOutLateralSpeedEvaluator> mLateralSpeedEvaluatorManager;
    map::WaypointManager mWaypointManager;
    map::StopLineManager mStopLineManager;
    map::TrafficLightStateId mTrafficLightState;
    std::vector<map::StopLine> mEgoVehicleForwardStopLines;
    measure::FrenetDistanceEvaluator mFrenetDistanceEvaluator;
    std::map<std::string, map::StopLine> mVehicleStopLineMap;
    std::map<std::string, bool> mMoveTriggerMap;
    std::map<std::string, bool> mLateralMoveTriggerMap;
};

} // namespace unit {

#endif // #ifndef _UNIT_RED_LIGHT_RUNNING_MODEL_H_
