#ifndef _HCT_CUT_IN_SIMULATOR_H_
#define _HCT_CUT_IN_SIMULATOR_H_

#include <scenario_simulator.h>
#include <unit_alks_cut_in_model.h>

namespace hct {

class CutInSimulator final : public scenario::Simulator
{

  public:
    CutInSimulator();
    CutInSimulator(const CutInSimulator&) = delete;
    CutInSimulator& operator=(const CutInSimulator&) = delete;
    virtual ~CutInSimulator() = default;

    virtual void Configure(const scenario::SimulatorConfig& config) override;
    virtual void Update() override;

  protected:
  private:
    unit::AlksCutInModel::Ptr mAlksCutInModel;
};

} // namespace hct

#endif // #ifndef _HCT_CUT_IN_SIMULATOR_H_
