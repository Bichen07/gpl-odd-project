#ifndef _HCT_SIGNALIZED_STRAIGHT_GOING_SIMULATOR_H_
#define _HCT_SIGNALIZED_STRAIGHT_GOING_SIMULATOR_H_

#include <scenario_simulator.h>
#include <unit_dijkstra_waypoint_following_model.h>
#include <unit_signalized_intersection_model.h>

namespace hct {

class SignalizedStraightGoingSimulator final : public scenario::Simulator
{

public:

    SignalizedStraightGoingSimulator();
    SignalizedStraightGoingSimulator(const SignalizedStraightGoingSimulator &) = delete;
    SignalizedStraightGoingSimulator &operator=(const SignalizedStraightGoingSimulator &) = delete;
    virtual ~SignalizedStraightGoingSimulator() = default;

    virtual void Configure(const scenario::SimulatorConfig &config) override;
    virtual void Update() override;

protected:

private:

    unit::DijkstraWaypointFollowingModel::Ptr mCrossingVehicleModel;
    unit::SignalizedIntersectionModel::Ptr mSignalizedIntersectionModel;
};

} // namespace hct {

#endif // #ifndef _HCT_SIGNALIZED_STRAIGHT_GOING_SIMULATOR_H_
