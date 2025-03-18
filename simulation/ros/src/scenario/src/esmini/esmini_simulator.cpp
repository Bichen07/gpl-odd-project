#include <include/esmini/esmini_simulator.h>
#include <motion_alks_cut_in_config.h>
#include <unit_esmini_model.h>

namespace esmini
{

    // public func.

    EsminiSimulator::EsminiSimulator() : Simulator(), mEsminiModel{std::make_shared<unit::EsminiModel>()}
    {
    }

    void EsminiSimulator::Configure(const scenario::SimulatorConfig& config)
    {
        std::vector<unit::Model::Ptr> unitModels = {
            mEsminiModel,
        };
        Simulator::Configure(config, unitModels);
    }

    void EsminiSimulator::Update()
    {
        Simulator::Update();
    }

    // protected func.

    // private func.

}  // namespace esmini
