#ifndef _HCT_VEHICLE_TURING_RIGHT_AT_EXIT_SIMULATOR_H_
#define _HCT_VEHICLE_TURING_RIGHT_AT_EXIT_SIMULATOR_H_

#include <scenario_simulator.h>
#include <unit_driving_into_lane_model.h>

namespace hct {

class VehicleTurningRightAtExitSimulator final : public scenario::Simulator
{

public:

    VehicleTurningRightAtExitSimulator();
    VehicleTurningRightAtExitSimulator(const VehicleTurningRightAtExitSimulator &) = delete;
    VehicleTurningRightAtExitSimulator &operator=(const VehicleTurningRightAtExitSimulator &) = delete;
    virtual ~VehicleTurningRightAtExitSimulator() = default;

    virtual void Configure(const scenario::SimulatorConfig &config) override;
    virtual void Update() override;

protected:

private:

    unit::DrivingIntoLaneModel::Ptr mTurningRightVehicleModel;
};

} // namespace hct {

#endif // #ifndef _HCT_VEHICLE_TURING_RIGHT_AT_EXIT_SIMULATOR_H_
