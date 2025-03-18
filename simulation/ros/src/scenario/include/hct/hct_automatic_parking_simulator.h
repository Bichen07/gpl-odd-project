#ifndef _HCT_AUTOMATIC_PARKING_SIMULATOR_H_
#define _HCT_AUTOMATIC_PARKING_SIMULATOR_H_

#include <scenario_simulator.h>

namespace hct {

class AutomaticParkingSimulator final : public scenario::Simulator
{

public:

    AutomaticParkingSimulator();
    AutomaticParkingSimulator(const AutomaticParkingSimulator &) = delete;
    AutomaticParkingSimulator &operator=(const AutomaticParkingSimulator &) = delete;
    virtual ~AutomaticParkingSimulator() = default;

    virtual void Configure(const scenario::SimulatorConfig &config) override;
    virtual void Update() override;

protected:

private:

};

} // namespace hct {

#endif // #ifndef _HCT_AUTOMATIC_PARKING_SIMULATOR_H_
