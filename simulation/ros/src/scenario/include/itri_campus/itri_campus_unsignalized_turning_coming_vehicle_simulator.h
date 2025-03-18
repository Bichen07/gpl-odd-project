#ifndef _ITRI_CAMPUS_UNSIGNALIZED_TURNING_COMING_VEHICLE_SIMULATOR_H_
#define _ITRI_CAMPUS_UNSIGNALIZED_TURNING_COMING_VEHICLE_SIMULATOR_H_

// itri_campus_unsignalized_turning_coming_vehicle_simulator

#include <scenario_simulator.h>
#include <unit_lane_roadside_moving_model.h>

namespace itri_campus {

class UnsignalizedTurningComingVehicleSimulator final : public scenario::Simulator
{

public:

    UnsignalizedTurningComingVehicleSimulator();
    UnsignalizedTurningComingVehicleSimulator(const UnsignalizedTurningComingVehicleSimulator &) = delete;
    UnsignalizedTurningComingVehicleSimulator &operator=(const UnsignalizedTurningComingVehicleSimulator &) = delete;
    virtual ~UnsignalizedTurningComingVehicleSimulator() = default;

    virtual void Configure(const scenario::SimulatorConfig &config) override;
    virtual void Update() override;

protected:

private:

    unit::LaneRoadsideMovingModel::Ptr mLaneRoadsideComingModel;
};

} // namespace itri_campus {

#endif // #ifndef _ITRI_CAMPUS_UNSIGNALIZED_TURNING_COMING_VEHICLE_SIMULATOR_H_
