#include <hct_signalized_right_turning_simulator.h>

namespace hct {

// public func.

SignalizedRightTurningSimulator::SignalizedRightTurningSimulator()
    : Simulator()
    , mOppositeComingModel{std::make_shared<unit::DijkstraWaypointFollowingModel>()}
    , mLeftComingModel{std::make_shared<unit::LaneWaypointFollowingModel>()}
    , mSignalizedIntersectionModel{std::make_shared<unit::SignalizedIntersectionModel>()}
{
}

void SignalizedRightTurningSimulator::Configure(const scenario::SimulatorConfig &config)
{
    std::vector<unit::Model::Ptr> unitModels =
    {
        mOppositeComingModel,
        mLeftComingModel,
        mSignalizedIntersectionModel,
    };
    Simulator::Configure(
        config,
        unitModels);
}

void SignalizedRightTurningSimulator::Update()
{
    Simulator::Update();
}

// protected func.

// private func.

} // namespace hct {
