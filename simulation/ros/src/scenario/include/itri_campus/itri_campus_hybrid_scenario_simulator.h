#ifndef _ITRI_CAMPUS_HYBRID_SCENARIO_SIMULATOR_H_
#define _ITRI_CAMPUS_HYBRID_SCENARIO_SIMULATOR_H_

#include <scenario_simulator.h>
#include <unit_lane_roadside_moving_model.h>
#include <unit_pedestrian_crossing_model.h>
#include <unit_overtaking_model.h>

namespace itri_campus {

class HybridScenarioSimulator final : public scenario::Simulator
{

public:

    HybridScenarioSimulator();
    HybridScenarioSimulator(const HybridScenarioSimulator &) = delete;
    HybridScenarioSimulator &operator=(const HybridScenarioSimulator &) = delete;
    virtual ~HybridScenarioSimulator() = default;

    virtual void Configure(const scenario::SimulatorConfig &config) override;
    virtual void Update() override;

protected:

private:

    unit::PedestrianCrossingModel::Ptr mPedestrianCrossingModel;
    unit::LaneRoadsideMovingModel::Ptr mLaneRoadsideParkingModel;
    unit::OvertakingModel::Ptr mOvertakingModel;
};

} // namespace itri_campus {

#endif // #ifndef _ITRI_CAMPUS_HYBRID_SCENARIO_SIMULATOR_H_
