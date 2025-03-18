#include <shuinan_pedestrian_crossing_overtaking_car_following_simulator.h>
#include <stdexcept>
#include <ros/console.h>
#include <utils_json.h>

namespace shuinan {

// public func.

PedestrianCrossingOvertakingCarFollowingSimulator::PedestrianCrossingOvertakingCarFollowingSimulator()
    : Simulator()
    , mPedestrianCrossingModel{std::make_shared<unit::PedestrianCrossingModel>()}
    , mOvertakingModel{std::make_shared<unit::OvertakingModel>()}
    , mCarFollowingModel{std::make_shared<unit::LaneRoadsideMovingModel>()}
{
}

void PedestrianCrossingOvertakingCarFollowingSimulator::Configure(
    const scenario::SimulatorConfig &config)
{
    std::vector<unit::Model::Ptr> unitModels =
    {
        mPedestrianCrossingModel,
        mOvertakingModel,
        mCarFollowingModel,
    };
    Simulator::Configure(
        config,
        unitModels);
}

void PedestrianCrossingOvertakingCarFollowingSimulator::Update()
{
    Simulator::Update();
}

// protected func.

// private func.

} // namespace shuinan {
