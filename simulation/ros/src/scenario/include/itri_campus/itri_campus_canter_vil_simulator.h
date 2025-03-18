#ifndef _ITRI_CAMPUS_CANTER_VIL_SIMULATOR_H_
#define _ITRI_CAMPUS_CANTER_VIL_SIMULATOR_H_

#include <scenario_simulator.h>
#include <unit_lane_roadside_moving_model.h>
#include <unit_pedestrian_crossing_model.h>
#include <unit_overtaking_model.h>

namespace itri_campus {

class CanterVilSimulator final : public scenario::Simulator
{

public:

    CanterVilSimulator();
    CanterVilSimulator(const CanterVilSimulator &) = delete;
    CanterVilSimulator &operator=(const CanterVilSimulator &) = delete;
    virtual ~CanterVilSimulator() = default;

    virtual void Configure(const scenario::SimulatorConfig &config) override;
    virtual void Update() override;

protected:

private:

    unit::PedestrianCrossingModel::Ptr mPedestrianCrossingModel;
    unit::LaneRoadsideMovingModel::Ptr mLaneRoadsideParkingModel;
    unit::OvertakingModel::Ptr mOvertakingModel;
};

} // namespace itri_campus {

#endif // #ifndef _ITRI_CAMPUS_CANTER_VIL_SIMULATOR_H_
