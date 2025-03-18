#ifndef _SHUINAN_RED_LIGHT_RUNNING_SIMULATOR_H_
#define _SHUINAN_RED_LIGHT_RUNNING_SIMULATOR_H_

#include <scenario_simulator.h>
#include <unit_red_light_running_model.h>
#include <unit_signalized_intersection_model.h>

namespace shuinan {

class RedLightRunningSimulator final : public scenario::Simulator
{

public:

    RedLightRunningSimulator();
    RedLightRunningSimulator(const RedLightRunningSimulator &) = delete;
    RedLightRunningSimulator &operator=(const RedLightRunningSimulator &) = delete;
    virtual ~RedLightRunningSimulator() = default;

    virtual void Configure(const scenario::SimulatorConfig &config) override;
    virtual void Update() override;

protected:

private:

    unit::RedLightRunningModel::Ptr mRedLightRunningModel;
    unit::SignalizedIntersectionModel::Ptr mSignalizedIntersectionModel;
};

} // namespace shuinan {

#endif // #ifndef _SHUINAN_RED_LIGHT_RUNNING_SIMULATOR_H_
