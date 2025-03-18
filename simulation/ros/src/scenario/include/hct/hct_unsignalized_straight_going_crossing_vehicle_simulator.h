#ifndef _HCT_UNSIGNALIZED_STRAIGHT_GOING_CROSSING_VEHICLE_SIMULATOR_H_
#define _HCT_UNSIGNALIZED_STRAIGHT_GOING_CROSSING_VEHICLE_SIMULATOR_H_

#include <scenario_simulator.h>
#include <unit_driving_into_lane_model.h>

namespace hct {

class UnsignalizedStraightGoingCrossingVehicleSimulator final : public scenario::Simulator
{

public:

    UnsignalizedStraightGoingCrossingVehicleSimulator();
    UnsignalizedStraightGoingCrossingVehicleSimulator(
        const UnsignalizedStraightGoingCrossingVehicleSimulator &) = delete;
    UnsignalizedStraightGoingCrossingVehicleSimulator &operator=(
        const UnsignalizedStraightGoingCrossingVehicleSimulator &) = delete;
    virtual ~UnsignalizedStraightGoingCrossingVehicleSimulator() = default;

    virtual void Configure(const scenario::SimulatorConfig &config) override;
    virtual void Update() override;

protected:

private:

    unit::DrivingIntoLaneModel::Ptr mCrossingVehicleModel;
};

} // namespace hct {

#endif // #ifndef _HCT_UNSIGNALIZED_STRAIGHT_GOING_CROSSING_VEHICLE_SIMULATOR_H_
