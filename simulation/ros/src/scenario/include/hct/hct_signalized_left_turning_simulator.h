#ifndef _HCT_SIGNALIZED_LEFT_TURNING_SIMULATOR_H_
#define _HCT_SIGNALIZED_LEFT_TURNING_SIMULATOR_H_

#include <scenario_simulator.h>
#include <unit_dijkstra_waypoint_following_model.h>
#include <unit_signalized_intersection_model.h>

namespace hct {

class SignalizedLeftTurningSimulator final : public scenario::Simulator
{

public:

    SignalizedLeftTurningSimulator();
    SignalizedLeftTurningSimulator(const SignalizedLeftTurningSimulator &) = delete;
    SignalizedLeftTurningSimulator &operator=(const SignalizedLeftTurningSimulator &) = delete;
    virtual ~SignalizedLeftTurningSimulator() = default;

    virtual void Configure(const scenario::SimulatorConfig &config) override;
    virtual void Update() override;

protected:

private:

    unit::DijkstraWaypointFollowingModel::Ptr mRightTurningVehicleModel;
    unit::SignalizedIntersectionModel::Ptr mSignalizedIntersectionModel;
};

} // namespace hct {

#endif // #ifndef _HCT_SIGNALIZED_LEFT_TURNING_SIMULATOR_H_
