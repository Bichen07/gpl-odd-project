#include <hct_traffic_light_flashing_simulator.h>

namespace hct {

// public func.

TrafficLightFlashingSimulator::TrafficLightFlashingSimulator()
    : Simulator()
    , mLeftTurningModel{std::make_shared<unit::DijkstraWaypointFollowingModel>()}
    , mSignalizedIntersectionModel{std::make_shared<unit::SignalizedIntersectionModel>()}
{
}

void TrafficLightFlashingSimulator::Configure(const scenario::SimulatorConfig &config)
{
    std::vector<unit::Model::Ptr> unitModels =
    {
        mLeftTurningModel,
        mSignalizedIntersectionModel,
    };
    Simulator::Configure(
        config,
        unitModels);
}

void TrafficLightFlashingSimulator::Update()
{
    Simulator::Update();
}

// protected func.

// private func.

} // namespace hct {
