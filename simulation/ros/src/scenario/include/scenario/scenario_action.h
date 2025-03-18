#ifndef _SCENARIO_ACTION_H_
#define _SCENARIO_ACTION_H_

#include <vector>
#include <string>
#include <map>
#include <action_overtaking_before_stationary_vehicle_simulator.h>
#include <scenario_simulator_factory.h>

namespace scenario {

static constexpr const char *action_01_overtaking_before_stationary_vehicle_simulator_id()
{return "action_01_overtaking_before_stationary_vehicle_simulator";}

static const std::vector<std::string> ActionScenarioIds =
{
    "action_01",
};

template<typename IdType>
void RegisterActionScenarios(SimulatorFactory<IdType> &outputFactory)
{
    std::map<IdType, boost::function<Simulator *()>> simulatorRegisterMap
    {
        {
            action_01_overtaking_before_stationary_vehicle_simulator_id(),
            boost::bind(boost::factory<action::OvertakingBeforeStationaryVehicleSimulator *>())
        },
    };

    outputFactory.Register(simulatorRegisterMap);
}

template<typename IdType>
void AppendActionScenarioIds(std::vector<IdType> &outputScenarioIds)
{
    outputScenarioIds.insert(
        outputScenarioIds.end(),
        ActionScenarioIds.cbegin(),
        ActionScenarioIds.cend());
}

} // namespace scenario {

#endif // #ifndef _SCENARIO_ACTION_H_
