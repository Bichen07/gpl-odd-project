#ifndef _HCT_MERGING_LEFT_LANE_SIMULATOR_H_
#define _HCT_MERGING_LEFT_LANE_SIMULATOR_H_

#include <scenario_simulator.h>
#include <unit_lane_waypoint_following_model.h>

namespace hct {

class MergingLeftLaneSimulator final : public scenario::Simulator
{

public:

    MergingLeftLaneSimulator();
    MergingLeftLaneSimulator(const MergingLeftLaneSimulator &) = delete;
    MergingLeftLaneSimulator &operator=(const MergingLeftLaneSimulator &) = delete;
    virtual ~MergingLeftLaneSimulator() = default;

    virtual void Configure(const scenario::SimulatorConfig &config) override;
    virtual void Update() override;

protected:

private:

    unit::LaneWaypointFollowingModel::Ptr mLeftLaneVehicleModel;
};

} // namespace hct {

#endif // #ifndef _HCT_LEAVING_RAMP_MERGING_SIMULATOR_H_
