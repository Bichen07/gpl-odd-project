#include <hct_vehicle_turning_right_at_exit_simulator.h>

namespace hct {

// public func.

VehicleTurningRightAtExitSimulator::VehicleTurningRightAtExitSimulator()
    : Simulator()
    , mTurningRightVehicleModel{std::make_shared<unit::DrivingIntoLaneModel>()}
{
}

void VehicleTurningRightAtExitSimulator::Configure(const scenario::SimulatorConfig &config)
{
    std::vector<unit::Model::Ptr> unitModels =
    {
        mTurningRightVehicleModel,
    };
    Simulator::Configure(
        config,
        unitModels);
}

void VehicleTurningRightAtExitSimulator::Update()
{
    Simulator::Update();
}

// protected func.

// private func.

} // namespace hct {
