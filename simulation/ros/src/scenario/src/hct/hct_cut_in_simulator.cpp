#include <hct_cut_in_simulator.h>
#include <motion_alks_cut_in_config.h>
#include <unit_alks_cut_in_model.h>

namespace hct {

// public func.

CutInSimulator::CutInSimulator()
  : Simulator()
  , mAlksCutInModel{ std::make_shared<unit::AlksCutInModel>() }
{
}

void
CutInSimulator::Configure(const scenario::SimulatorConfig& config)
{
    std::vector<unit::Model::Ptr> unitModels = {
        mAlksCutInModel,
    };
    Simulator::Configure(config, unitModels);
}

void
CutInSimulator::Update()
{
    Simulator::Update();
}

// protected func.

// private func.

} // namespace hct
