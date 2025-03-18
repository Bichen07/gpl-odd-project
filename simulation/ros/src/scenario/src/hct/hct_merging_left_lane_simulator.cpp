#include <hct_merging_left_lane_simulator.h>

namespace hct {

// public func.

MergingLeftLaneSimulator::MergingLeftLaneSimulator()
    : Simulator()
    , mLeftLaneVehicleModel{std::make_shared<unit::LaneWaypointFollowingModel>()}
{
}

void MergingLeftLaneSimulator::Configure(const scenario::SimulatorConfig &config)
{
    std::vector<unit::Model::Ptr> unitModels =
    {
        mLeftLaneVehicleModel,
    };
    Simulator::Configure(
        config,
        unitModels);
}

void MergingLeftLaneSimulator::Update()
{
    Simulator::Update();
}

// protected func.

// private func.

} // namespace hct {
