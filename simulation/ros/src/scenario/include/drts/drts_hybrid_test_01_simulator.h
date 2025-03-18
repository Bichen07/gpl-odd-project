#ifndef _DRTS_HYBRID_TEST_01_SIMULATOR_H_
#define _DRTS_HYBRID_TEST_01_SIMULATOR_H_

#include <scenario_simulator.h>
#include <unit_pedestrian_crossing_model.h>
#include <unit_lane_roadside_moving_model.h>
#include <unit_dijkstra_waypoint_following_model.h>


namespace drts {

class HybridTest01Simulator final : public scenario::Simulator
{

public:

    HybridTest01Simulator();
    HybridTest01Simulator(const HybridTest01Simulator &) = delete;
    HybridTest01Simulator &operator=(const HybridTest01Simulator &) = delete;
    virtual ~HybridTest01Simulator() = default;

    virtual void Configure(const scenario::SimulatorConfig &config) override;
    virtual void Update() override;

protected:

private:
    // unit::DijkstraWaypointFollowingModel::Ptr mSideVehicleModel;
    unit::LaneRoadsideMovingModel::Ptr mLaneRoadsideMovingModel;
    unit::PedestrianCrossingModel::Ptr mPedestrianCrossingModel;
};

} // namespace drts {


#endif // #ifndef _DRTS_HYBRID_TEST_01_SIMULATOR_H_