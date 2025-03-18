#include <hct_signalized_straight_going_simulator.h>

namespace hct {

// public func.

SignalizedStraightGoingSimulator::SignalizedStraightGoingSimulator()
    : Simulator()
    , mCrossingVehicleModel{std::make_shared<unit::DijkstraWaypointFollowingModel>()}
    , mSignalizedIntersectionModel{std::make_shared<unit::SignalizedIntersectionModel>()}
{
}

void SignalizedStraightGoingSimulator::Configure(const scenario::SimulatorConfig &config)
{
    std::vector<unit::Model::Ptr> unitModels =
    {
        mCrossingVehicleModel,
        mSignalizedIntersectionModel,
    };
    Simulator::Configure(
        config,
        unitModels);
}

void SignalizedStraightGoingSimulator::Update()
{
    Simulator::Update();
}

// protected func.

// private func.

} // namespace hct {
