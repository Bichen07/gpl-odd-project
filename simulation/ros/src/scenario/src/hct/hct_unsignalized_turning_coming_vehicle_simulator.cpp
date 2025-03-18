#include <hct_unsignalized_turning_coming_vehicle_simulator.h>

namespace hct {

// public func.

UnsignalizedTurningComingVehicleSimulator::UnsignalizedTurningComingVehicleSimulator()
    : Simulator()
    , mComingVehicleModel{std::make_shared<unit::DijkstraWaypointFollowingModel>()}
{
}

void UnsignalizedTurningComingVehicleSimulator::Configure(
    const scenario::SimulatorConfig &config)
{
    std::vector<unit::Model::Ptr> unitModels =
    {
        mComingVehicleModel,
    };
    Simulator::Configure(
        config,
        unitModels);
}

void UnsignalizedTurningComingVehicleSimulator::Update()
{
    Simulator::Update();
}

// protected func.

// private func.

} // namespace hct {
