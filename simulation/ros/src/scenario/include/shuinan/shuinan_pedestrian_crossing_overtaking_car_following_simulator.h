#ifndef _SHUINAN_PEDESTRIAN_CROSSING_OVERTAKING_CAR_FOLLOWING_SIMULATOR_H_
#define _SHUINAN_PEDESTRIAN_CROSSING_OVERTAKING_CAR_FOLLOWING_SIMULATOR_H_

#include <scenario_simulator.h>
#include <unit_lane_roadside_moving_model.h>
#include <unit_overtaking_model.h>
#include <unit_pedestrian_crossing_model.h>

namespace shuinan {

class PedestrianCrossingOvertakingCarFollowingSimulator final : public scenario::Simulator
{

public:

    PedestrianCrossingOvertakingCarFollowingSimulator();
    PedestrianCrossingOvertakingCarFollowingSimulator(
        const PedestrianCrossingOvertakingCarFollowingSimulator &) = delete;
    PedestrianCrossingOvertakingCarFollowingSimulator &operator=(
        const PedestrianCrossingOvertakingCarFollowingSimulator &) = delete;
    virtual ~PedestrianCrossingOvertakingCarFollowingSimulator() = default;

    virtual void Configure(const scenario::SimulatorConfig &config) override;
    virtual void Update() override;

protected:

private:

    unit::PedestrianCrossingModel::Ptr mPedestrianCrossingModel;
    unit::OvertakingModel::Ptr mOvertakingModel;
    unit::LaneRoadsideMovingModel::Ptr mCarFollowingModel;
};

} // namespace shuinan {

#endif // #ifndef _SHUINAN_PEDESTRIAN_CROSSING_OVERTAKING_CAR_FOLLOWING_SIMULATOR_H_
