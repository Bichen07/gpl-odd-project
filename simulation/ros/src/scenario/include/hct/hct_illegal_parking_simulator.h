#ifndef _HCT_ILLEGAL_PARKING_SIMULATOR_H_
#define _HCT_ILLEGAL_PARKING_SIMULATOR_H_

#include <scenario_simulator.h>
#include <unit_stationary_object_model.h>

namespace hct {

class IllegalParkingSimulator final : public scenario::Simulator
{

public:

    IllegalParkingSimulator();
    IllegalParkingSimulator(const IllegalParkingSimulator &) = delete;
    IllegalParkingSimulator &operator=(const IllegalParkingSimulator &) = delete;
    virtual ~IllegalParkingSimulator() = default;

    virtual void Configure(const scenario::SimulatorConfig &config) override;
    virtual void Update() override;

protected:

private:

    unit::StationaryObjectModel::Ptr mIllegalParkingVehicleModel;
};

} // namespace hct {

#endif // #ifndef _HCT_ILLEGAL_PARKING_SIMULATOR_H_
