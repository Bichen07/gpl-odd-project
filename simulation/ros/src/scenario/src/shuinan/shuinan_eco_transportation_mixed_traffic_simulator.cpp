#include <shuinan_eco_transportation_mixed_traffic_simulator.h>
#include <stdexcept>
#include <ros/console.h>
#include <utils_json.h>

namespace shuinan {

// public func.

EcoTransportationMixedTrafficSimulator::EcoTransportationMixedTrafficSimulator()
    : Simulator()
    , mLaneRoadsideMovingModel{std::make_shared<unit::LaneRoadsideMovingModel>()}
    , mZigzagMovingModel{std::make_shared<unit::ZigzagMovingModel>()}
{
}

void EcoTransportationMixedTrafficSimulator::Configure(const scenario::SimulatorConfig &config)
{
    std::vector<unit::Model::Ptr> unitModels =
    {
        mLaneRoadsideMovingModel,
        mZigzagMovingModel,
    };
    Simulator::Configure(
        config,
        unitModels);
}

void EcoTransportationMixedTrafficSimulator::Update()
{
    Simulator::Update();
}

// protected func.

// private func.

} // namespace shuinan {
