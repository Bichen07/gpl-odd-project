#ifndef _SCENARIO_EXPRESSWAY_68_H_
#define _SCENARIO_EXPRESSWAY_68_H_

#include <vector>
#include <string>
#include <map>
#include <expway68_vehicles_in_current_right_lanes_simulator.h>
#include <scenario_simulator_factory.h>

namespace scenario {

static constexpr const char *expway68_01_vehicles_in_current_right_lanes_simulator_id()
{return "expway68_01_vehicles_in_current_right_lanes_simulator";}

static const std::vector<std::string> Expway68ScenarioIds =
{
    "expway68_01",
};

template<typename IdType>
void RegisterExpway68Scenarios(SimulatorFactory<IdType> &outputFactory)
{
    std::map<IdType, boost::function<Simulator *()>> simulatorRegisterMap
    {
        {
            expway68_01_vehicles_in_current_right_lanes_simulator_id(),
            boost::bind(boost::factory<expway68::VehiclesInCurrentRightLanesSimulator *>())
        },
    };

    outputFactory.Register(simulatorRegisterMap);
}

template<typename IdType>
void AppendExpway68ScenarioIds(std::vector<IdType> &outputScenarioIds)
{
    outputScenarioIds.insert(
        outputScenarioIds.end(),
        Expway68ScenarioIds.cbegin(),
        Expway68ScenarioIds.cend());
}

} // namespace scenario {

#endif // #ifndef _SCENARIO_EXPRESSWAY_68_H_
