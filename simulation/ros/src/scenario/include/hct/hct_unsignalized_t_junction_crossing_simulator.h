#ifndef _HCT_UNSIGNALIZED_T_JUNCTION_CROSSING_SIMULATOR_H_
#define _HCT_UNSIGNALIZED_T_JUNCTION_CROSSING_SIMULATOR_H_

#include <scenario_simulator.h>
#include <unit_dijkstra_waypoint_following_model.h>

namespace hct {

class UnsignalizedTJunctionCrossingSimulator final : public scenario::Simulator
{

public:

    UnsignalizedTJunctionCrossingSimulator();
    UnsignalizedTJunctionCrossingSimulator(
        const UnsignalizedTJunctionCrossingSimulator &) = delete;
    UnsignalizedTJunctionCrossingSimulator &operator=(
        const UnsignalizedTJunctionCrossingSimulator &) = delete;
    virtual ~UnsignalizedTJunctionCrossingSimulator() = default;

    virtual void Configure(const scenario::SimulatorConfig &config) override;
    virtual void Update() override;

protected:

private:

    unit::DijkstraWaypointFollowingModel::Ptr mComingVehicleModel;
};

} // namespace hct {

#endif // #ifndef _HCT_UNSIGNALIZED_T_JUNCTION_CROSSING_SIMULATOR_H_
