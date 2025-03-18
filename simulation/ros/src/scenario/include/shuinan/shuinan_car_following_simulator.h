#ifndef _SHUINAN_CAR_FOLLOWING_SIMULATOR_H_
#define _SHUINAN_CAR_FOLLOWING_SIMULATOR_H_

#include <scenario_simulator.h>
#include <unit_lane_roadside_moving_model.h>

namespace shuinan {

class CarFollowingSimulator final : public scenario::Simulator
{

public:

    CarFollowingSimulator();
    CarFollowingSimulator(const CarFollowingSimulator &) = delete;
    CarFollowingSimulator &operator=(const CarFollowingSimulator &) = delete;
    virtual ~CarFollowingSimulator() = default;

    virtual void Configure(const scenario::SimulatorConfig &config) override;
    virtual void Update() override;

protected:

private:

    unit::LaneRoadsideMovingModel::Ptr mLaneRoadsideMovingModel;
};

} // namespace shuinan {

#endif // #ifndef _SHUINAN_CAR_FOLLOWING_SIMULATOR_H_
