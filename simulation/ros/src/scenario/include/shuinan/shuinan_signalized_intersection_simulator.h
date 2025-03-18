#ifndef _SHUINAN_SIGNALIZED_INTERSECTION_SIMULATOR_H
#define _SHUINAN_SIGNALIZED_INTERSECTION_SIMULATOR_H

#include <scenario_simulator.h>
#include <unit_signalized_intersection_model.h>

namespace shuinan {

class SignalizedIntersectionSimulator final : public scenario::Simulator
{

public:

    SignalizedIntersectionSimulator();
    SignalizedIntersectionSimulator(const SignalizedIntersectionSimulator &) = delete;
    SignalizedIntersectionSimulator &operator=(const SignalizedIntersectionSimulator &) = delete;
    virtual ~SignalizedIntersectionSimulator() = default;

    virtual void Configure(const scenario::SimulatorConfig &config) override;
    virtual void Update() override;

protected:

private:

    unit::SignalizedIntersectionModel::Ptr mSignalizedIntersectionModel;
};

} // namespace shuinan {

#endif // #ifndef _SHUINAN_SIGNALIZED_INTERSECTION_SIMULATOR_H
