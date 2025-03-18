#ifndef _ITRI_CAMPUS_OVERTAKING_SIMULATOR_H_
#define _ITRI_CAMPUS_OVERTAKING_SIMULATOR_H_

#include <scenario_simulator.h>
#include <unit_adaptive_overtaking_model.h>

namespace itri_campus {

class AdaptiveOvertakingScenarioSimulator final : public scenario::Simulator
{

public:

    AdaptiveOvertakingScenarioSimulator();
    AdaptiveOvertakingScenarioSimulator(const AdaptiveOvertakingScenarioSimulator &) = delete;
    AdaptiveOvertakingScenarioSimulator &operator=(const AdaptiveOvertakingScenarioSimulator &) = delete;
    virtual ~AdaptiveOvertakingScenarioSimulator() = default;

    virtual void Configure(const scenario::SimulatorConfig &config) override;
    virtual void Update() override;

protected:

private:

    unit::AdaptiveOvertakingModel::Ptr mAdaptiveOvertakingModel;
};

} // namespace itri_campus {

#endif // #ifndef _ITRI_CAMPUS_OVERTAKING_SIMULATOR_H_
