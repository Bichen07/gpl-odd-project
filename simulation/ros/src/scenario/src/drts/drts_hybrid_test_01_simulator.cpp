#include <drts_hybrid_test_01_simulator.h>

namespace drts {

// public func.

HybridTest01Simulator::HybridTest01Simulator()
	: Simulator()
    , mLaneRoadsideMovingModel{std::make_shared<unit::LaneRoadsideMovingModel>()}
	, mPedestrianCrossingModel{std::make_shared<unit::PedestrianCrossingModel>()}
    // , mSideVehicleModel{std::make_shared<unit::DijkstraWaypointFollowingModel>()}
{

}

void HybridTest01Simulator::Configure(const scenario::SimulatorConfig &config)
{
	std::vector<unit::Model::Ptr> unitModels =
    {
        mPedestrianCrossingModel,
        mLaneRoadsideMovingModel
        // mSideVehicleModel
    };
    Simulator::Configure(
        config,
        unitModels);
}

void HybridTest01Simulator::Update()
{
	Simulator::Update();
}


} // namespace drts {