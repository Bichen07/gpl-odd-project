#ifndef _HCT_CROSSING_AT_T_JUNCTION_SIMULATOR_H_
#define _HCT_CROSSING_AT_T_JUNCTION_SIMULATOR_H_

#include <scenario_simulator.h>
#include <unit_dijkstra_waypoint_following_model.h>
#include <unit_stationary_object_model.h>

namespace hct {

class CrossingAtTJunctionSimulator final : public scenario::Simulator
{

public:

    CrossingAtTJunctionSimulator();
    CrossingAtTJunctionSimulator(const CrossingAtTJunctionSimulator &) = delete;
    CrossingAtTJunctionSimulator &operator=(const CrossingAtTJunctionSimulator &) = delete;
    virtual ~CrossingAtTJunctionSimulator() = default;

    virtual void Configure(const scenario::SimulatorConfig &config) override;
    virtual void Update() override;

protected:

private:

    unit::DijkstraWaypointFollowingModel::Ptr mCrossingVehicleModel;
    unit::StationaryObjectModel::Ptr mParkingVehicleModel;
};

} // namespace hct {

#endif // #ifndef _HCT_CROSSING_AT_T_JUNCTION_SIMULATOR_H_
