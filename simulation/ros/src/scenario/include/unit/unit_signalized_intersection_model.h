#ifndef _UNIT_SIGNALIZED_INTERSECTION_MODEL_H
#define _UNIT_SIGNALIZED_INTERSECTION_MODEL_H

#include <unit_model.h>
#include <std_msgs/Bool.h>
#include <itri_msgs/TrafficLightObjects.h>
#include <math_type.h>
#include <map_type.h>
#include <map_traffic_light_manager.h>
#include <measure_frenet_distance_evaluator.h>
#include <motion_signalized_intersection_config.h>

namespace unit {

class SignalizedIntersectionModel final : public Model
{

public:

    typedef std::shared_ptr<SignalizedIntersectionModel> Ptr;

    SignalizedIntersectionModel();
    SignalizedIntersectionModel(const SignalizedIntersectionModel &) = delete;
    SignalizedIntersectionModel &operator=(const SignalizedIntersectionModel &) = delete;
    virtual ~SignalizedIntersectionModel() = default;

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
    {return "signalized_intersection_";}

    void ConfigureMotions();
    void AppendTrafficLightMarker(
        const map::TrafficLight &trafficLight,
        const map::TrafficLightStateId &trafficLightStateId);
    void FakeTrafficLightCallback(const itri_msgs::TrafficLightObjects &msg);
    virtual void EgoVehicleSpeedCommandCallback(const itri_msgs::speed_cmd &msg) override;

    ros::Subscriber mFakeTrafficLightSubscriber;
    map::TrafficLightManager mTrafficLightManager;
    map::TrafficLightStateId mTrafficLightState;
    measure::FrenetDistanceEvaluator mFrenetDistanceEvaluator;
    std::vector<motion::SignalizedIntersectionConfig> mMotionConfigs;
    std::vector<int32_t> mLateralLaneTrafficLightIds;
};

} // namespace unit {

#endif // #ifndef _UNIT_SIGNALIZED_INTERSECTION_MODEL_H
