#ifndef _UNIT_LANE_ROADSIDE_MOVING_MODEL_H_
#define _UNIT_LANE_ROADSIDE_MOVING_MODEL_H_

#include <unit_model.h>
#include <map>
#include <std_msgs/Bool.h>
#include <itri_msgs/Path.h>
#include <itri_msgs/WaypointArray.h>
#include <measure_frenet_distance_evaluator.h>
#include <motion_lane_roadside_moving_config.h>
#include <actor_vehicle.h>
#include <actor_agent_speed_manager.h>
#include <ctrl_ease_in_out_lateral_speed_evaluator.h>
#include <ctrl_waypoint_follower.h>
#include <utils_object_manager.h>
#include <utils_approximation_evaluator.h>

namespace unit {

class LaneRoadsideMovingModel final : public Model
{

public:

    typedef std::shared_ptr<LaneRoadsideMovingModel> Ptr;

    LaneRoadsideMovingModel();
    LaneRoadsideMovingModel(const LaneRoadsideMovingModel &) = delete;
    LaneRoadsideMovingModel &operator=(const LaneRoadsideMovingModel &) = delete;
    virtual ~LaneRoadsideMovingModel() = default;

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
    {return "lane_roadside_moving_";}

    void ConfigureMotions();
    bool CanAgentMove(const math::real_t agentVehicleDistance);
    virtual void EgoVehicleWaypointsCallback(const itri_msgs::WaypointArray &msg) override;

    std::vector<actor::Vehicle::Ptr> mMovingVehicles;
    std::vector<motion::LaneRoadsideMovingConfig> mMotionConfigs;
    utils::ObjectManager<ctrl::WaypointFollower> mWaypointFollowerManager;
    utils::ObjectManager<ctrl::EaseInOutLateralSpeedEvaluator> mMoveToLaneLateralSpeedEvaluatorManager;
    utils::ObjectManager<ctrl::EaseInOutLateralSpeedEvaluator> mMoveToRoadsideLateralSpeedEvaluatorManager;
    measure::FrenetDistanceEvaluator mFrenetDistanceEvaluator;
    std::map<std::string, math::real_t> mMoveToRoadsideTriggerDistanceMap;
    std::map<std::string, bool> mMoveTriggerMap;
    std::map<std::string, bool> mMoveToRoadsideTriggerMap;
    utils::ObjectManager<PoseApproximationEvaluator> mPoseApproximationEvaluatorManager;
    actor::AgentSpeedManager mAgentSpeedManager;
};

} // namespace unit {

#endif // #ifndef _UNIT_LANE_ROADSIDE_MOVING_MODEL_H_
