#ifndef _SCENARIO_SHUINAN_H_
#define _SCENARIO_SHUINAN_H_

#include <vector>
#include <string>
#include <scenario_simulator_factory.h>
#include <shuinan_car_following_simulator.h>
#include <shuinan_eco_transportation_mixed_traffic_simulator.h>
#include <shuinan_illegal_parking_simulator.h>
#include <shuinan_left_turn_driving_simulator.h>
#include <shuinan_overtaking_simulator.h>
#include <shuinan_passenger_carrying_simulator.h>
#include <shuinan_pedestrian_crossing_simulator.h>
#include <shuinan_red_light_running_simulator.h>
#include <shuinan_right_turn_driving_simulator.h>
#include <shuinan_signalized_intersection_simulator.h>
#include <shuinan_straight_driving_simulator.h>
#include <shuinan_pedestrian_crossing_overtaking_car_following_simulator.h>

namespace scenario {

static constexpr const char *shuinan_01_straight_driving_simulator_id()
{return "shuinan_01_straight_driving_simulator";}
static constexpr const char *shuinan_02_left_turn_driving_simulator_id()
{return "shuinan_02_left_turn_driving_simulator";}
static constexpr const char *shuinan_03_right_turn_driving_simulator_id()
{return "shuinan_03_right_turn_driving_simulator";}
static constexpr const char *shuinan_04_car_following_simulator_id()
{return "shuinan_04_car_following_simulator";}
static constexpr const char *shuinan_05_passenger_carrying_simulator_id()
{return "shuinan_05_passenger_carrying_simulator";}
static constexpr const char *shuinan_06_signalized_intersection_simulator_id()
{return "shuinan_06_signalized_intersection_simulator";}
static constexpr const char *shuinan_07_illegal_parking_simulator_id()
{return "shuinan_07_illegal_parking_simulator";}
static constexpr const char *shuinan_08_eco_transportation_mixed_traffic_simulator_id()
{return "shuinan_08_eco_transportation_mixed_traffic_simulator";}
static constexpr const char *shuinan_09_overtaking_simulator_id()
{return "shuinan_09_overtaking_simulator";}
static constexpr const char *shuinan_10_pedestrian_crossing_simulator_id()
{return "shuinan_10_pedestrian_crossing_simulator";}
static constexpr const char *shuinan_11_red_light_running_simulator_id()
{return "shuinan_11_red_light_running_simulator";}
static constexpr const char *shuinan_12_pedestrian_crossing_overtaking_car_following_simulator_id()
{return "shuinan_12_pedestrian_crossing_overtaking_car_following_simulator";}

static const std::vector<std::string> ShuinanScenarioIds =
{
    "shuinan_01",
    "shuinan_02",
    "shuinan_03",
    "shuinan_04",
    "shuinan_05",
    "shuinan_06",
    "shuinan_07",
    "shuinan_08",
    "shuinan_09",
    "shuinan_10",
    "shuinan_11",
    "shuinan_12",
};

template<typename IdType>
void RegisterShuinanScenarios(SimulatorFactory<IdType> &outputFactory)
{
    std::map<IdType, boost::function<Simulator *()>> simulatorRegisterMap
    {
        {
            shuinan_01_straight_driving_simulator_id(),
            boost::bind(boost::factory<shuinan::StraightDrivingSimulator *>())
        },
        {
            shuinan_02_left_turn_driving_simulator_id(),
            boost::bind(boost::factory<shuinan::LeftTurnDrivingSimulator *>())
        },
        {
            shuinan_03_right_turn_driving_simulator_id(),
            boost::bind(boost::factory<shuinan::RightTurnDrivingSimulator *>())
        },
        {
            shuinan_04_car_following_simulator_id(),
            boost::bind(boost::factory<shuinan::CarFollowingSimulator *>())
        },
        {
            shuinan_05_passenger_carrying_simulator_id(),
            boost::bind(boost::factory<shuinan::PassengerCarryingSimulator *>())
        },
        {
            shuinan_06_signalized_intersection_simulator_id(),
            boost::bind(boost::factory<shuinan::SignalizedIntersectionSimulator *>())
        },
        {
            shuinan_07_illegal_parking_simulator_id(),
            boost::bind(boost::factory<shuinan::IllegalParkingSimulator *>())
        },
        {
            shuinan_08_eco_transportation_mixed_traffic_simulator_id(),
            boost::bind(boost::factory<shuinan::EcoTransportationMixedTrafficSimulator *>())
        },
        {
            shuinan_09_overtaking_simulator_id(),
            boost::bind(boost::factory<shuinan::OvertakingSimulator *>())
        },
        {
            shuinan_10_pedestrian_crossing_simulator_id(),
            boost::bind(boost::factory<shuinan::PedestrianCrossingSimulator *>())
        },
        {
            shuinan_11_red_light_running_simulator_id(),
            boost::bind(boost::factory<shuinan::RedLightRunningSimulator *>())
        },
        {
            shuinan_12_pedestrian_crossing_overtaking_car_following_simulator_id(),
            boost::bind(boost::factory<shuinan::PedestrianCrossingOvertakingCarFollowingSimulator *>())
        },
    };

    outputFactory.Register(simulatorRegisterMap);
}

template<typename IdType>
void AppendShuinanScenarioIds(std::vector<IdType> &outputScenarioIds)
{
    outputScenarioIds.insert(
        outputScenarioIds.end(),
        ShuinanScenarioIds.cbegin(),
        ShuinanScenarioIds.cend());
}

} // namespace scenario {

#endif // #ifndef _SCENARIO_SHUINAN_H_
