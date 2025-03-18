#ifndef _HCT_PASSING_VEHICLE_SIMULATOR_H_
#define _HCT_PASSING_VEHICLE_SIMULATOR_H_

#include <scenario_simulator.h>
#include <unit_dijkstra_waypoint_following_model.h>

namespace hct {

class PassingVehicleSimulator final : public scenario::Simulator
{

public:

    PassingVehicleSimulator();
    PassingVehicleSimulator(const PassingVehicleSimulator &) = delete;
    PassingVehicleSimulator &operator=(const PassingVehicleSimulator &) = delete;
    virtual ~PassingVehicleSimulator() = default;

    virtual void Configure(const scenario::SimulatorConfig &config) override;
    virtual void Update() override;

protected:

private:

    unit::DijkstraWaypointFollowingModel::Ptr mPassingVehicleModel;
};

} // namespace hct {

#endif // #ifndef _HCT_PASSING_VEHICLE_SIMULATOR_H_
