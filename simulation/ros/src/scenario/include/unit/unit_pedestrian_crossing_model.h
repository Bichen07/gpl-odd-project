#ifndef _UNIT_PEDESTRIAN_CROSSING_MODEL_H_
#define _UNIT_PEDESTRIAN_CROSSING_MODEL_H_

#include <unit_model.h>
#include <map>
#include <std_msgs/Bool.h>
#include <map_crosswalk.h>
#include <map_crosswalk_manager.h>
#include <measure_frenet_distance_evaluator.h>
#include <motion_pedestrian_crossing_moving_config.h>
#include <actor_pedestrian.h>
#include <actor_pedestrian_config.h>
#include <ctrl_waypoint_follower_manager.h>
#include <ctrl_waypoint_follower.h>

namespace unit {

class PedestrianCrossingModel final : public Model
{

public:

    typedef std::shared_ptr<PedestrianCrossingModel> Ptr;

    PedestrianCrossingModel();
    PedestrianCrossingModel(const PedestrianCrossingModel &) = delete;
    PedestrianCrossingModel &operator=(const PedestrianCrossingModel &) = delete;
    virtual ~PedestrianCrossingModel() = default;

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
    {return "pedestrian_crossing_";}

    void ConfigureMotions();
    virtual void EgoVehicleSpeedCommandCallback(const itri_msgs::speed_cmd &msg) override;

    std::vector<std::shared_ptr<actor::Pedestrian>> mPedestrians;
    std::vector<motion::PedestrianCrossingMovingConfig> mMotionConfigs;
    map::CrosswalkManager mCrosswalkManager;
    std::map<std::string, bool> mMoveTriggerMap;
    std::map<std::string, math::Vector3d_t> mCrosswalkRefPointMap;
    utils::ObjectManager<ctrl::WaypointFollower> mWaypointFollowerManager;
    measure::FrenetDistanceEvaluator mFrenetDistanceEvaluator;
};

} // namespace unit {

#endif // #ifndef _UNIT_PEDESTRIAN_CROSSING_MODEL_H_
