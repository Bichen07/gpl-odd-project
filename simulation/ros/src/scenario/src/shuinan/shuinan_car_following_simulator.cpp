#include <shuinan_car_following_simulator.h>
#include <stdexcept>
#include <ros/console.h>
#include <utils_json.h>

namespace shuinan {

// public func.

CarFollowingSimulator::CarFollowingSimulator()
    : Simulator()
    , mLaneRoadsideMovingModel{std::make_shared<unit::LaneRoadsideMovingModel>()}
{
}

void CarFollowingSimulator::Configure(const scenario::SimulatorConfig &config)
{
    std::vector<unit::Model::Ptr> unitModels =
    {
        mLaneRoadsideMovingModel,
    };
    Simulator::Configure(
        config,
        unitModels);
}

void CarFollowingSimulator::Update()
{
    Simulator::Update();
}

// protected func.

// private func.

} // namespace shuinan {
