#ifndef _SHUINAN_ILLEGAL_PARKING_SIMULATOR_H_
#define _SHUINAN_ILLEGAL_PARKING_SIMULATOR_H_

#include <scenario_simulator.h>
#include <unit_lane_roadside_moving_model.h>

namespace shuinan {

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

    unit::LaneRoadsideMovingModel::Ptr mLaneRoadsideMovingModel;
};

} // namespace shuinan {

#endif // #ifndef _SHUINAN_ILLEGAL_PARKING_SIMULATOR_H_
