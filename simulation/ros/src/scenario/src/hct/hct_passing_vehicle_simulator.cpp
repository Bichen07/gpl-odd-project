#include <hct_passing_vehicle_simulator.h>

namespace hct {

// public func.

PassingVehicleSimulator::PassingVehicleSimulator()
    : Simulator()
    , mPassingVehicleModel{std::make_shared<unit::DijkstraWaypointFollowingModel>()}
{
}

void PassingVehicleSimulator::Configure(const scenario::SimulatorConfig &config)
{
    std::vector<unit::Model::Ptr> unitModels =
    {
        mPassingVehicleModel,
    };
    Simulator::Configure(
        config,
        unitModels);
}

void PassingVehicleSimulator::Update()
{
    Simulator::Update();
}

// protected func.

// private func.

} // namespace hct {
