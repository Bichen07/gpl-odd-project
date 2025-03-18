#include <hct_mixed_traffic_flow_simulator.h>

namespace hct {

// public func.

MixedTrafficFlowSimulator::MixedTrafficFlowSimulator()
    : Simulator()
    , mBicycleModel{std::make_shared<unit::DijkstraWaypointFollowingModel>()}
{
}

void MixedTrafficFlowSimulator::Configure(const scenario::SimulatorConfig &config)
{
    std::vector<unit::Model::Ptr> unitModels =
    {
        mBicycleModel,
    };
    Simulator::Configure(
        config,
        unitModels);
}

void MixedTrafficFlowSimulator::Update()
{
    Simulator::Update();
}

// protected func.

// private func.

} // namespace hct {
