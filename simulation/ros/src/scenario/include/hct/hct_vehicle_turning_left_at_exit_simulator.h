#ifndef _HCT_VEHICLE_TURNING_LEFT_AT_EXIT_SIMULATOR_H_
#define _HCT_VEHICLE_TURNING_LEFT_AT_EXIT_SIMULATOR_H_

#include <scenario_simulator.h>
#include <unit_driving_into_lane_model.h>

namespace hct {

class VehicleTurningLeftAtExitSimulator final : public scenario::Simulator
{

public:

    VehicleTurningLeftAtExitSimulator();
    VehicleTurningLeftAtExitSimulator(const VehicleTurningLeftAtExitSimulator &) = delete;
    VehicleTurningLeftAtExitSimulator &operator=(const VehicleTurningLeftAtExitSimulator &) = delete;
    virtual ~VehicleTurningLeftAtExitSimulator() = default;

    virtual void Configure(const scenario::SimulatorConfig &config) override;
    virtual void Update() override;

protected:

private:

    unit::DrivingIntoLaneModel::Ptr mTurningLeftVehicleModel;
};

} // namespace hct {

#endif // #ifndef _HCT_VEHICLE_TURNING_LEFT_AT_EXIT_SIMULATOR_H_
