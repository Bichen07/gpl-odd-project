#ifndef _HCT_SIGNALIZED_RIGHT_TURNING_SIMULATOR_H_
#define _HCT_SIGNALIZED_RIGHT_TURNING_SIMULATOR_H_

#include <scenario_simulator.h>
#include <unit_dijkstra_waypoint_following_model.h>
#include <unit_lane_waypoint_following_model.h>
#include <unit_signalized_intersection_model.h>

namespace hct {

class SignalizedRightTurningSimulator final : public scenario::Simulator
{

public:

    SignalizedRightTurningSimulator();
    SignalizedRightTurningSimulator(const SignalizedRightTurningSimulator &) = delete;
    SignalizedRightTurningSimulator &operator=(const SignalizedRightTurningSimulator &) = delete;
    virtual ~SignalizedRightTurningSimulator() = default;

    virtual void Configure(const scenario::SimulatorConfig &config) override;
    virtual void Update() override;

protected:

private:

    unit::DijkstraWaypointFollowingModel::Ptr mOppositeComingModel;
    unit::LaneWaypointFollowingModel::Ptr mLeftComingModel;
    unit::SignalizedIntersectionModel::Ptr mSignalizedIntersectionModel;
};

} // namespace hct {

#endif // #ifndef _HCT_SIGNALIZED_RIGHT_TURNING_SIMULATOR_H_
