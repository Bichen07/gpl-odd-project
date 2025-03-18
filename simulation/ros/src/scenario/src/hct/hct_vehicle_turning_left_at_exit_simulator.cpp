#include <hct_vehicle_turning_left_at_exit_simulator.h>
#include <ros/console.h>

namespace hct {

// public func.

VehicleTurningLeftAtExitSimulator::VehicleTurningLeftAtExitSimulator()
    : Simulator()
    , mTurningLeftVehicleModel{std::make_shared<unit::DrivingIntoLaneModel>()}
{
}

void VehicleTurningLeftAtExitSimulator::Configure(const scenario::SimulatorConfig &config)
{
    std::vector<unit::Model::Ptr> unitModels =
    {
        mTurningLeftVehicleModel,
    };
    Simulator::Configure(
        config,
        unitModels);
}

void VehicleTurningLeftAtExitSimulator::Update()
{
    Simulator::Update();
}

// protected func.

// private func.

} // namespace hct {
