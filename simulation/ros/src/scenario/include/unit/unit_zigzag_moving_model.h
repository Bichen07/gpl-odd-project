#ifndef _UNIT_ZIGZAG_MOVING_MODEL_H_
#define _UNIT_ZIGZAG_MOVING_MODEL_H_

#include <unit_model.h>
#include <map>
#include <std_msgs/Bool.h>
#include <measure_frenet_distance_evaluator.h>
#include <motion_zigzag_moving_config.h>
#include <actor_vehicle.h>
#include <ctrl_lateral_zigzag_speed_evaluator.h>
#include <ctrl_waypoint_follower.h>
#include <utils_object_manager.h>

namespace unit {

class ZigzagMovingModel final : public Model
{

public:

    typedef std::shared_ptr<ZigzagMovingModel> Ptr;

    ZigzagMovingModel();
    ZigzagMovingModel(const ZigzagMovingModel &) = delete;
    ZigzagMovingModel &operator=(const ZigzagMovingModel &) = delete;
    virtual ~ZigzagMovingModel() = default;

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
    {return "zigzag_moving_";}

    void ConfigureMotions();
    virtual void EgoVehicleSpeedCommandCallback(const itri_msgs::speed_cmd &msg) override;

    std::vector<std::shared_ptr<actor::Vehicle>> mMovingVehicles;
    std::vector<motion::ZigzagMovingConfig> mMotionConfigs;
    std::map<std::string, bool> mMoveTriggerMap;
    std::map<std::string, math::real_t> mAccumulatedTimeMap;
    utils::ObjectManager<ctrl::LateralZigzagSpeedEvaluator> mLateralSpeedEvaluatorManager;
    utils::ObjectManager<ctrl::WaypointFollower> mWaypointFollowerManager;
    measure::FrenetDistanceEvaluator mFrenetDistanceEvaluator;
};

} // namespace unit {

#endif // #ifndef _UNIT_ZIGZAG_MOVING_MODEL_H_
