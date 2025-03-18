#ifndef _UNIT_DRIVING_INTO_LANE_MODEL_H_
#define _UNIT_DRIVING_INTO_LANE_MODEL_H_

#include <unit_model.h>
#include <map>
#include <std_msgs/Bool.h>
#include <measure_frenet_distance_evaluator.h>
#include <map_waypoint_manager.h>
#include <motion_driving_into_lane_config.h>
#include <ctrl_waypoint_follower.h>
#include <utils_object_manager.h>

namespace unit {

class DrivingIntoLaneModel final : public Model
{

public:

    typedef std::shared_ptr<DrivingIntoLaneModel> Ptr;

    DrivingIntoLaneModel();
    DrivingIntoLaneModel(const DrivingIntoLaneModel &) = delete;
    DrivingIntoLaneModel &operator=(const DrivingIntoLaneModel &) = delete;
    virtual ~DrivingIntoLaneModel() = default;

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
    {return "driving_into_lane_";}

    void ConfigureMotions();
    virtual void EgoVehicleSpeedCommandCallback(const itri_msgs::speed_cmd &msg) override;

    std::vector<std::shared_ptr<actor::Vehicle>> mMovingVehicles;
    std::vector<motion::DrivingIntoLaneConfig> mMotionConfigs;
    utils::ObjectManager<ctrl::WaypointFollower> mWaypointFollowerManager;
    map::WaypointManager mWaypointManager;
    measure::FrenetDistanceEvaluator mFrenetDistanceEvaluator;
    std::map<std::string, bool> mMoveTriggerMap;
};

} // namespace unit {

#endif // #ifndef _UNIT_DRIVING_INTO_LANE_MODEL_H_
