#ifndef _HCT_APPROACHING_EGO_SIMULATOR_H_
#define _HCT_APPROACHING_EGO_SIMULATOR_H_

#include <scenario_simulator.h>
#include <unit_constant_velocity_model.h>

namespace hct {

class ApproachingEgoSimulator final : public scenario::Simulator
{

  public:
    ApproachingEgoSimulator();
    ApproachingEgoSimulator(const ApproachingEgoSimulator&) = delete;
    ApproachingEgoSimulator& operator=(const ApproachingEgoSimulator&) = delete;
    virtual ~ApproachingEgoSimulator() = default;

    virtual void Configure(const scenario::SimulatorConfig& config) override;
    virtual void Update() override;

  protected:
  private:
    unit::ConstantVelocityModel::Ptr mApproachingEgoVehicleModel;
    ros::Publisher mEndScenarioPublisher;
};

} // namespace hct

#endif // #ifndef _HCT_APPROACHING_EGO_SIMULATOR_H_
