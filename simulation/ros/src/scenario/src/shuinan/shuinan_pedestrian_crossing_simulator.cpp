#include <shuinan_pedestrian_crossing_simulator.h>
#include <stdexcept>
#include <ros/console.h>
#include <utils_json.h>

namespace shuinan {

// public func.

PedestrianCrossingSimulator::PedestrianCrossingSimulator()
    : Simulator()
    , mPedestrianCrossingModel{std::make_shared<unit::PedestrianCrossingModel>()}
{
}

void PedestrianCrossingSimulator::Configure(const scenario::SimulatorConfig &config)
{
    std::vector<unit::Model::Ptr> unitModels =
    {
        mPedestrianCrossingModel,
    };
    Simulator::Configure(
        config,
        unitModels);
}

void PedestrianCrossingSimulator::Update()
{
    Simulator::Update();
}

// protected func.

// private func.

} // namespace shuinan {
