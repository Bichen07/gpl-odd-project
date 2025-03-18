#ifndef _SCENARIO_ITRI_H_
#define _SCENARIO_ITRI_H_

#include <vector>
#include <string>
#include <scenario_simulator_factory.h>
#include <itri_campus_lane_roadside_moving_simulator.h>
#include <itri_campus_pedestrian_crossing_simulator.h>
#include <itri_campus_hybrid_scenario_simulator.h>
#include <itri_campus_overtaking_simulator.h>
#include <itri_campus_canter_vil_simulator.h>
#include <itri_campus_unsignalized_turning_coming_vehicle_simulator.h>

namespace scenario {

static constexpr const char *itri_00_hybrid_scenario_simulator_id()
{return "itri_00_hybrid_scenario_simulator";}
static constexpr const char *itri_01_pedestrian_crossing_simulator_id()
{return "itri_01_pedestrian_crossing_simulator";}
static constexpr const char *itri_02_adaptive_overtaking_simulator_id()
{return "itri_02_adaptive_overtaking_simulator";}
static constexpr const char *itri_03_lane_roadside_moving_simulator_id()
{return "itri_03_lane_roadside_moving_simulator";}
static constexpr const char *itri_04_canter_vil_simulator_id()
{return "itri_04_canter_vil_simulator";}
static constexpr const char *itri_05_unsignalized_turning_coming_vehicle_simulator_id()
{return "itri_05_unsignalized_turning_coming_vehicle_simulator";}

static const std::vector<std::string> ItriScenarioIds =
{
    "itri_00",
    "itri_01",
    "itri_02",
    "itri_03",
    "itri_04",
    "itri_05"
};

template<typename IdType>
void RegisterItriScenarios(SimulatorFactory<IdType> &outputFactory)
{
    std::map<IdType, boost::function<Simulator *()>> simulatorRegisterMap
    {
        {
            itri_00_hybrid_scenario_simulator_id(),
            boost::bind(boost::factory<itri_campus::HybridScenarioSimulator *>())
        },
        {
            itri_01_pedestrian_crossing_simulator_id(),
            boost::bind(boost::factory<itri_campus::PedestrianCrossingSimulator *>())
        },
        {
            itri_02_adaptive_overtaking_simulator_id(),
            boost::bind(boost::factory<itri_campus::AdaptiveOvertakingScenarioSimulator *>())
        },
        {
            itri_03_lane_roadside_moving_simulator_id(),
            boost::bind(boost::factory<itri_campus::LaneRoadsideMovingSimulator *>())
        },
        {
            itri_04_canter_vil_simulator_id(),
            boost::bind(boost::factory<itri_campus::CanterVilSimulator *>())
        },
        {
            itri_05_unsignalized_turning_coming_vehicle_simulator_id(),
            boost::bind(boost::factory<itri_campus::UnsignalizedTurningComingVehicleSimulator *>())
        }
    };

    outputFactory.Register(simulatorRegisterMap);
}

template<typename IdType>
void AppendItriScenarioIds(std::vector<IdType> &outputScenarioIds)
{
    outputScenarioIds.insert(
        outputScenarioIds.end(),
        ItriScenarioIds.cbegin(),
        ItriScenarioIds.cend());
}

} // namespace scenario {

#endif // #ifndef _SCENARIO_ITRI_H_
