#ifndef _EXPWAY68_VEHICLES_IN_CURRENT_LEFT_LANES_SIMULATOR_H_
#define _EXPWAY68_VEHICLES_IN_CURRENT_LEFT_LANES_SIMULATOR_H_

#include <scenario_simulator.h>
#include <unit_dijkstra_waypoint_following_model.h>

namespace expway68 {

class VehiclesInCurrentRightLanesSimulator final : public scenario::Simulator
{

public:

    VehiclesInCurrentRightLanesSimulator();
    VehiclesInCurrentRightLanesSimulator(const VehiclesInCurrentRightLanesSimulator &) = delete;
    VehiclesInCurrentRightLanesSimulator &operator=(const VehiclesInCurrentRightLanesSimulator &) = delete;
    virtual ~VehiclesInCurrentRightLanesSimulator() = default;

    virtual void Configure(const scenario::SimulatorConfig &config) override;
    virtual void Update() override;

protected:

private:

    ros::NodeHandle mNodeHandle;
    unit::DijkstraWaypointFollowingModel::Ptr mWaypointFollowingModel;
};

} // namespace expway68 {

#endif // #ifndef _EXPWAY68_VEHICLES_IN_CURRENT_LEFT_LANES_SIMULATOR_H_
