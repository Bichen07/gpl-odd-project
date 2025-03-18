#ifndef _HCT_MIXED_TRAFFIC_FLOW_SIMULATOR_H_
#define _HCT_MIXED_TRAFFIC_FLOW_SIMULATOR_H_

#include <scenario_simulator.h>
#include <unit_dijkstra_waypoint_following_model.h>

namespace hct {

class MixedTrafficFlowSimulator final : public scenario::Simulator
{

public:

    MixedTrafficFlowSimulator();
    MixedTrafficFlowSimulator(const MixedTrafficFlowSimulator &) = delete;
    MixedTrafficFlowSimulator &operator=(const MixedTrafficFlowSimulator &) = delete;
    virtual ~MixedTrafficFlowSimulator() = default;

    virtual void Configure(const scenario::SimulatorConfig &config) override;
    virtual void Update() override;

protected:

private:

    unit::DijkstraWaypointFollowingModel::Ptr mBicycleModel;
};

} // namespace hct {

#endif // #ifndef _HCT_MIXED_TRAFFIC_FLOW_SIMULATOR_H_
