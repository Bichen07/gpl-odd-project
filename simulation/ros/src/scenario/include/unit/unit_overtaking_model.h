#ifndef _UNIT_OVERTAKING_MODEL_H_
#define _UNIT_OVERTAKING_MODEL_H_

#include <unit_model.h>
#include <map>
#include <std_msgs/Bool.h>
#include <measure_frenet_distance_evaluator.h>
#include <motion_overtaking_config.h>
#include <actor_vehicle.h>
#include <ctrl_waypoint_follower.h>
#include <ctrl_ease_in_out_lateral_speed_evaluator.h>
#include <utils_object_manager.h>

namespace unit {

class OvertakingModel final : public Model
{

public:

    typedef std::shared_ptr<OvertakingModel> Ptr;

    OvertakingModel();
    OvertakingModel(const OvertakingModel &) = delete;
    OvertakingModel &operator=(const OvertakingModel &) = delete;
    virtual ~OvertakingModel() = default;

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
    {return "overtaking_";}

    void ConfigureMotions();
    virtual void EgoVehicleSpeedCommandCallback(const itri_msgs::speed_cmd &msg) override;

    std::vector<std::shared_ptr<actor::Vehicle>> mMovingVehicles;
    std::vector<motion::OvertakingConfig> mMotionConfigs;
    utils::ObjectManager<ctrl::WaypointFollower> mWaypointFollowerManager;
    utils::ObjectManager<ctrl::EaseInOutLateralSpeedEvaluator> mMoveToLaneLateralSpeedEvaluatorManager;
    utils::ObjectManager<ctrl::EaseInOutLateralSpeedEvaluator> mOvertakingLateralSpeedEvaluatorManager;
    utils::ObjectManager<ctrl::EaseInOutLateralSpeedEvaluator> mReturningLateralSpeedEvaluatorManager;
    utils::ObjectManager<ctrl::EaseInOutLateralSpeedEvaluator> mMoveToRoadsideLateralSpeedEvaluatorManager;
    measure::FrenetDistanceEvaluator mFrenetDistanceEvaluator;
    std::map<std::string, math::real_t> mMoveToRoadsideTriggerDistanceMap;
    std::map<std::string, bool> mMoveTriggerMap;
    std::map<std::string, bool> mOvertakingTriggerMap;
    std::map<std::string, bool> mReturningTriggerMap;
    std::map<std::string, bool> mMoveToRoadsideTriggerMap;
};

} // namespace unit {

#endif // #ifndef _UNIT_OVERTAKING_MODEL_H_
