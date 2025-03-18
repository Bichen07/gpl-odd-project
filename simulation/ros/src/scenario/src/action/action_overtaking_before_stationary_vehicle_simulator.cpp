#include <action_overtaking_before_stationary_vehicle_simulator.h>

namespace action {

// public func.

OvertakingBeforeStationaryVehicleSimulator::OvertakingBeforeStationaryVehicleSimulator()
    : Simulator()
    , mAdaptiveOvertakingModel{std::make_shared<unit::AdaptiveOvertakingModel>()}
    , mStationaryVehicleModel{std::make_shared<unit::StationaryObjectModel>()}
{
}

void OvertakingBeforeStationaryVehicleSimulator::Configure(const scenario::SimulatorConfig &config)
{
    std::vector<unit::Model::Ptr> unitModels =
    {
        mAdaptiveOvertakingModel,
        mStationaryVehicleModel,
    };
    Simulator::Configure(
        config,
        unitModels);
}

void OvertakingBeforeStationaryVehicleSimulator::Update()
{
    Simulator::Update();
}

// protedted func.

// private func.

} // namespace action {
