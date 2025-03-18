#ifndef _ESMINI_SIMULATOR_H_
#define _ESMINI_SIMULATOR_H_

#include <scenario_simulator.h>
#include <unit_esmini_model.h>

namespace esmini
{

    class EsminiSimulator final : public scenario::Simulator
    {
    public:
        EsminiSimulator();
        EsminiSimulator(const EsminiSimulator&)            = delete;
        EsminiSimulator& operator=(const EsminiSimulator&) = delete;
        virtual ~EsminiSimulator()                         = default;

        virtual void Configure(const scenario::SimulatorConfig& config) override;
        virtual void Update() override;

    protected:
    private:
        unit::EsminiModel::Ptr mEsminiModel;
    };

}  // namespace hct

#endif  // #ifndef _ESMINI_SIMULATOR_H_
