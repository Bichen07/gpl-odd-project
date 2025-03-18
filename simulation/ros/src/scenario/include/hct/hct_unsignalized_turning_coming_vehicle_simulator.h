#ifndef _HCT_UNSIGNALIZED_TURNING_COMING_VEHICLE_SIMULATOR_H_
#define _HCT_UNSIGNALIZED_TURNING_COMING_VEHICLE_SIMULATOR_H_

#include <scenario_simulator.h>
#include <unit_dijkstra_waypoint_following_model.h>

namespace hct {

class UnsignalizedTurningComingVehicleSimulator : public scenario::Simulator
{

public:

    UnsignalizedTurningComingVehicleSimulator();
    UnsignalizedTurningComingVehicleSimulator(
        const UnsignalizedTurningComingVehicleSimulator &) = delete;
    UnsignalizedTurningComingVehicleSimulator &operator=(
        const UnsignalizedTurningComingVehicleSimulator &) = delete;
    virtual ~UnsignalizedTurningComingVehicleSimulator() = default;

    virtual void Configure(const scenario::SimulatorConfig &config) override;
    virtual void Update() override;

protected:

private:

    unit::DijkstraWaypointFollowingModel::Ptr mComingVehicleModel;
};

} // namespace hct {

#endif // #ifndef _HCT_UNSIGNALIZED_TURNING_COMING_VEHICLE_SIMULATOR_H_
