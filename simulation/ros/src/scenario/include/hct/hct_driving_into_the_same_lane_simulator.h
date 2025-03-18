#ifndef _HCT_DRIVING_INTO_THE_SAME_LANE_SIMULATOR_H_
#define _HCT_DRIVING_INTO_THE_SAME_LANE_SIMULATOR_H_

#include <scenario_simulator.h>
#include <unit_dijkstra_waypoint_following_model.h>

namespace hct {

class DrivingIntoTheSameLaneSimulator final : public scenario::Simulator
{

public:

    DrivingIntoTheSameLaneSimulator();
    DrivingIntoTheSameLaneSimulator(
        const DrivingIntoTheSameLaneSimulator &) = delete;
    DrivingIntoTheSameLaneSimulator &operator=(
        const DrivingIntoTheSameLaneSimulator &) = delete;
    virtual ~DrivingIntoTheSameLaneSimulator() = default;

    virtual void Configure(const scenario::SimulatorConfig &config) override;
    virtual void Update() override;

protected:

private:

    unit::DijkstraWaypointFollowingModel::Ptr mOtherVehicleModel;
};

} // namespace hct {

#endif // #ifndef _HCT_DRIVING_INTO_THE_SAME_LANE_SIMULATOR_H_
