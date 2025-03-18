#ifndef _UNIT_ADAPTIVE_OVERTAKING_MODEL_H_
#define _UNIT_ADAPTIVE_OVERTAKING_MODEL_H_

#include <unit_model.h>
#include <map>
#include <measure_frenet_distance_evaluator.h>
#include <motion_adaptive_overtaking_config.h>
#include <actor_vehicle.h>
#include <ctrl_waypoint_follower.h>
#include <ctrl_ease_in_out_lateral_speed_evaluator.h>
#include <utils_object_manager.h>

namespace unit {

class AdaptiveOvertakingModel final : public Model
{

public:

    typedef std::shared_ptr<AdaptiveOvertakingModel> Ptr;

    AdaptiveOvertakingModel();
    AdaptiveOvertakingModel(const AdaptiveOvertakingModel &) = delete;
    AdaptiveOvertakingModel &operator=(const AdaptiveOvertakingModel &) = delete;
    virtual ~AdaptiveOvertakingModel() = default;

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
    {return "adaptive_overtaking_";}

    void ConfigureMotions();
    virtual void EgoVehicleSpeedCommandCallback(const itri_msgs::speed_cmd &msg) override;

    std::vector<actor::Vehicle::Ptr> mMovingVehicles;
    std::vector<motion::AdaptiveOvertakingConfig> mMotionConfigs;
    utils::ObjectManager<ctrl::WaypointFollower> mWaypointFollowerManager;
    utils::ObjectManager<ctrl::EaseInOutLateralSpeedEvaluator> mMovingToLaneLateralSpeedEvaluatorManager;
    utils::ObjectManager<ctrl::EaseInOutLateralSpeedEvaluator> mSurpassingLateralSpeedEvaluatorManager;
    utils::ObjectManager<ctrl::EaseInOutLateralSpeedEvaluator> mReturningLateralSpeedEvaluatorManager;
    utils::ObjectManager<ctrl::EaseInOutLateralSpeedEvaluator> mMovingToRoadsideLateralSpeedEvaluatorManager;
    measure::FrenetDistanceEvaluator mFrenetDistanceEvaluator;
    std::map<std::string, bool> mMovingTriggerMap;
    std::map<std::string, bool> mSurpassingTriggerMap;
    std::map<std::string, bool> mReturningTriggerMap;
    std::map<std::string, bool> mMovingToRoadsideTriggerMap;
};

} // namespace unit {

#endif // #ifndef _UNIT_ADAPTIVE_OVERTAKING_MODEL_H_
