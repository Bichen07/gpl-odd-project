#include <itri_campus_lane_roadside_moving_simulator.h>
#include <stdexcept>
#include <ros/console.h>
#include <utils_json.h>

namespace itri_campus {

// public func.

LaneRoadsideMovingSimulator::LaneRoadsideMovingSimulator()
    : Simulator()
    , mLaneRoadsideParkingModel{std::make_shared<unit::LaneRoadsideMovingModel>()}
{
}

void LaneRoadsideMovingSimulator::Configure(const scenario::SimulatorConfig &config)
{
    std::vector<unit::Model::Ptr> unitModels =
    {
        mLaneRoadsideParkingModel
    };
    Simulator::Configure(
        config,
        unitModels);
}

void LaneRoadsideMovingSimulator::Update()
{
    Simulator::Update();
}

// protected func.

// private func.

} // namespace itri_campus {
