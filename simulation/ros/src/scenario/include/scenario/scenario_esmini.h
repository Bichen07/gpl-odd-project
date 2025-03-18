#ifndef _SCENARIO_ESMINI_H_
#define _SCENARIO_ESMINI_H_

#include <vector>
#include <string>
#include <map>
#include <esmini_simulator.h>
#include <scenario_simulator_factory.h>

namespace scenario
{

    static constexpr const char *esmini_simulator_id()
    {
        return "esmini_simulator";
    }

    static const std::vector<std::string> EsminiScenarioIds = {
        "esmini",
    };

    template <typename IdType>
    void RegisterEsminiScenarios(SimulatorFactory<IdType> &outputFactory)
    {
        std::map<IdType, boost::function<Simulator *()>> simulatorRegisterMap{
            {esmini_simulator_id(), boost::bind(boost::factory<esmini::EsminiSimulator *>())},
        };

        outputFactory.Register(simulatorRegisterMap);
    }

    template <typename IdType>
    void AppendEsminiScenarioIds(std::vector<IdType> &outputScenarioIds)
    {
        outputScenarioIds.insert(outputScenarioIds.end(), EsminiScenarioIds.cbegin(), EsminiScenarioIds.cend());
    }

}  // namespace scenario

#endif  // #ifndef _SCENARIO_ESMINI_H_
