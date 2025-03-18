#ifndef _SHUINAN_OVERTAKING_SIMULATOR_H_
#define _SHUINAN_OVERTAKING_SIMULATOR_H_

#include <scenario_simulator.h>
#include <unit_overtaking_model.h>

namespace shuinan {

class OvertakingSimulator final : public scenario::Simulator
{

public:

    OvertakingSimulator();
    OvertakingSimulator(const OvertakingSimulator &) = delete;
    OvertakingSimulator &operator=(const OvertakingSimulator &) = delete;
    virtual ~OvertakingSimulator() = default;

    virtual void Configure(const scenario::SimulatorConfig &config) override;
    virtual void Update() override;

protected:

private:

    unit::OvertakingModel::Ptr mOvertakingModel;
};

} // namespace shuinan {

#endif // #ifndef _SHUINAN_OVERTAKING_SIMULATOR_H_
