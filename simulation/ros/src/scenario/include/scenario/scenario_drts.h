#ifndef _SCENARIO_DRTS_H_
#define _SCENARIO_DRTS_H_

#include <vector>
#include <string>
#include <scenario_simulator_factory.h>
#include <drts_hybrid_test_01_simulator.h>
#include <drts_hybrid_test_02_simulator.h>

namespace scenario {

static constexpr const char *drts_01_hybrid_test_simulator_id()
{return "drts_01_hybrid_test_route_01_scenario_simulation";}
static constexpr const char *drts_02_hybrid_test_simulator_id()
{return "drts_02_hybrid_test_route_02_scenario_simulation";}

static const std::vector<std::string> DrtsScenarioIds =
{
    "drts_01",
    "drts_02",
};

template<typename IdType>
void RegisterDrtsScenarios(SimulatorFactory<IdType> &outputFactory)
{
    std::map<IdType, boost::function<Simulator *()>> simulatorRegisterMap
    {
        {
            drts_01_hybrid_test_simulator_id(),
            boost::bind(boost::factory<drts::HybridTest01Simulator *>())
        },
        {
            drts_02_hybrid_test_simulator_id(),
            boost::bind(boost::factory<drts::HybridTest02Simulator *>())
        }
    };

    outputFactory.Register(simulatorRegisterMap);
}

template<typename IdType>
void AppendDrtsScenarioIds(std::vector<IdType> &outputScenarioIds)
{
    outputScenarioIds.insert(
        outputScenarioIds.end(),
        DrtsScenarioIds.cbegin(),
        DrtsScenarioIds.cend());
}

} // namespace scenario {

#endif // #ifndef _SCENARIO_DRTS_H_
