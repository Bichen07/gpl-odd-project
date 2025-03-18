#ifndef _ACTION_OVERTAKING_BEFORE_STATIONARY_VEHICLE_SIMULATOR_H_
#define _ACTION_OVERTAKING_BEFORE_STATIONARY_VEHICLE_SIMULATOR_H_

#include <scenario_simulator.h>
#include <unit_adaptive_overtaking_model.h>
#include <unit_stationary_object_model.h>

namespace action {

class OvertakingBeforeStationaryVehicleSimulator final : public scenario::Simulator
{

public:

    OvertakingBeforeStationaryVehicleSimulator();
    OvertakingBeforeStationaryVehicleSimulator(
        const OvertakingBeforeStationaryVehicleSimulator &) = delete;
    OvertakingBeforeStationaryVehicleSimulator &operator=(
        const OvertakingBeforeStationaryVehicleSimulator &) = delete;
    virtual ~OvertakingBeforeStationaryVehicleSimulator() = default;

    virtual void Configure(const scenario::SimulatorConfig &config) override;
    virtual void Update() override;

protected:

private:

    unit::AdaptiveOvertakingModel::Ptr mAdaptiveOvertakingModel;
    unit::StationaryObjectModel::Ptr mStationaryVehicleModel;
};

} // namespace action {

#endif // #ifndef _ACTION_OVERTAKING_BEFORE_STATIONARY_VEHICLE_SIMULATOR_H_
