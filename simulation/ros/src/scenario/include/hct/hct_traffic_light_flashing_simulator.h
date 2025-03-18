#ifndef _HCT_TRAFFIC_LIGHT_FLASHING_SIMULATOR_H_
#define _HCT_TRAFFIC_LIGHT_FLASHING_SIMULATOR_H_

#include <scenario_simulator.h>
#include <unit_dijkstra_waypoint_following_model.h>
#include <unit_signalized_intersection_model.h>

namespace hct {

class TrafficLightFlashingSimulator final : public scenario::Simulator
{

public:

    TrafficLightFlashingSimulator();
    TrafficLightFlashingSimulator(const TrafficLightFlashingSimulator &) = delete;
    TrafficLightFlashingSimulator &operator=(const TrafficLightFlashingSimulator &) = delete;
    virtual ~TrafficLightFlashingSimulator() = default;

    virtual void Configure(const scenario::SimulatorConfig &config) override;
    virtual void Update() override;

protected:

private:

    unit::DijkstraWaypointFollowingModel::Ptr mLeftTurningModel;
    unit::SignalizedIntersectionModel::Ptr mSignalizedIntersectionModel;
};

} // namespace hct {

#endif // #ifndef _HCT_TRAFFIC_LIGHT_FLASHING_SIMULATOR_H_
