#include <hct_unsignalized_t_junction_crossing_simulator.h>

namespace hct {

// public func.

UnsignalizedTJunctionCrossingSimulator::UnsignalizedTJunctionCrossingSimulator()
    : Simulator()
    , mComingVehicleModel{std::make_shared<unit::DijkstraWaypointFollowingModel>()}
{
}

void UnsignalizedTJunctionCrossingSimulator::Configure(
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

void  UnsignalizedTJunctionCrossingSimulator::Update()
{
    Simulator::Update();
}

// protected func.

// private func.

} // namespace hct {
