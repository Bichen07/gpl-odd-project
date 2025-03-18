#include <expway68_vehicles_in_current_right_lanes_simulator.h>

namespace expway68 {

// public func.

VehiclesInCurrentRightLanesSimulator::VehiclesInCurrentRightLanesSimulator()
    : Simulator()
    , mWaypointFollowingModel{std::make_shared<unit::DijkstraWaypointFollowingModel>()}
{
}

void VehiclesInCurrentRightLanesSimulator::Configure(const scenario::SimulatorConfig &config)
{
    std::vector<unit::Model::Ptr> unitModels =
    {
        mWaypointFollowingModel,
    };
    Simulator::Configure(
        config,
        unitModels);
}

void VehiclesInCurrentRightLanesSimulator::Update()
{
    Simulator::Update();
}

// protected func.

// private func.

} // namespace expway68 {
