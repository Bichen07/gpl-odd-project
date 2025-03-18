#ifndef _ITRI_CAMPUS_PEDESTRIAN_CROSSING_SIMULATOR_H_
#define _ITRI_CAMPUS_PEDESTRIAN_CROSSING_SIMULATOR_H_

#include <scenario_simulator.h>
#include <unit_pedestrian_crossing_model.h>

namespace itri_campus {

class PedestrianCrossingSimulator final : public scenario::Simulator
{

public:

    PedestrianCrossingSimulator();
    PedestrianCrossingSimulator(const PedestrianCrossingSimulator &) = delete;
    PedestrianCrossingSimulator &operator=(const PedestrianCrossingSimulator &) = delete;
    virtual ~PedestrianCrossingSimulator() = default;

    virtual void Configure(const scenario::SimulatorConfig &config) override;
    virtual void Update() override;

protected:

private:

    unit::PedestrianCrossingModel::Ptr mPedestrianCrossingModel;
};

} // namespace itri_campus {

#endif // #ifndef _ITRI_CAMPUS_PEDESTRIAN_CROSSING_SIMULATOR_H_
