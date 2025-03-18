#ifndef _ITRI_CAMPUS_LANE_ROADSIDE_MOVING_SIMULATOR_H_
#define _ITRI_CAMPUS_LANE_ROADSIDE_MOVING_SIMULATOR_H_

#include <scenario_simulator.h>
#include <unit_lane_roadside_moving_model.h>

namespace itri_campus {

class LaneRoadsideMovingSimulator final : public scenario::Simulator
{

public:

    LaneRoadsideMovingSimulator();
    LaneRoadsideMovingSimulator(const LaneRoadsideMovingSimulator &) = delete;
    LaneRoadsideMovingSimulator &operator=(const LaneRoadsideMovingSimulator &) = delete;
    virtual ~LaneRoadsideMovingSimulator() = default;

    virtual void Configure(const scenario::SimulatorConfig &config) override;
    virtual void Update() override;

protected:

private:

    unit::LaneRoadsideMovingModel::Ptr mLaneRoadsideParkingModel;
};

} // namespace itri_campus {

#endif // #ifndef _ITRI_CAMPUS_LANE_ROADSIDE_MOVING_SIMULATOR_H_
