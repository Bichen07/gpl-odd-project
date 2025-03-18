#include <shuinan_illegal_parking_simulator.h>
#include <stdexcept>
#include <ros/console.h>
#include <utils_json.h>

namespace shuinan {

// public func.

IllegalParkingSimulator::IllegalParkingSimulator()
    : Simulator()
    , mLaneRoadsideMovingModel{std::make_shared<unit::LaneRoadsideMovingModel>()}
{
}

void IllegalParkingSimulator::Configure(const scenario::SimulatorConfig &config)
{
    std::vector<unit::Model::Ptr> unitModels =
    {
        mLaneRoadsideMovingModel,
    };
    Simulator::Configure(
        config,
        unitModels);
}

void IllegalParkingSimulator::Update()
{
    Simulator::Update();
}

// protected func.

// private func.

} // namespace shuinan {
