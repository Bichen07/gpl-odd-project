#include <drts_hybrid_test_02_simulator.h>

namespace drts {

// public func.

HybridTest02Simulator::HybridTest02Simulator()
	: Simulator()
	, mLaneRoadsideMovingModel{std::make_shared<unit::LaneRoadsideMovingModel>()}
    , mIllegalParkingVehicleModel{std::make_shared<unit::StationaryObjectModel>()}
{

}

void HybridTest02Simulator::Configure(const scenario::SimulatorConfig &config)
{
	std::vector<unit::Model::Ptr> unitModels =
    {
        mLaneRoadsideMovingModel,
        mIllegalParkingVehicleModel
    };
    Simulator::Configure(
        config,
        unitModels);
}

void HybridTest02Simulator::Update()
{
	Simulator::Update();
}


} // namespace drts {