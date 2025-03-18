#ifndef _SCENARIO_HCT_H_
#define _SCENARIO_HCT_H_

#include <hct_approaching_ego_simulator.h>
#include <hct_automatic_parking_simulator.h>
#include <hct_crossing_at_t_junction_simulator.h>
#include <hct_cut_in_simulator.h>
#include <hct_route_moving_simulator.h>
#include <hct_driving_into_the_same_lane_simulator.h>
#include <hct_illegal_parking_simulator.h>
#include <hct_merging_left_lane_simulator.h>
#include <hct_mixed_traffic_flow_simulator.h>
#include <hct_passing_vehicle_simulator.h>
#include <hct_signalized_left_turning_simulator.h>
#include <hct_signalized_right_turning_simulator.h>
#include <hct_signalized_straight_going_simulator.h>
#include <hct_traffic_light_flashing_simulator.h>
#include <hct_unsignalized_straight_going_crossing_vehicle_simulator.h>
#include <hct_unsignalized_t_junction_crossing_simulator.h>
#include <hct_unsignalized_turning_coming_vehicle_simulator.h>
#include <map>
#include <string>
#include <vector>
// #include <hct_vehicle_turning_left_at_exit_simulator.h>
// #include <hct_vehicle_turning_right_at_exit_simulator.h>
#include <scenario_simulator_factory.h>

namespace scenario
{

    static constexpr const char* hct_01_unsignalized_t_junction_crossing_simulator_id()
    {
        return "hct_01_unsignalized_t_junction_crossing_simulator";
    }
    static constexpr const char* hct_02_unsignalized_straight_going_crossing_vehicle_simulator_id()
    {
        return "hct_02_unsignalized_straight_going_crossing_vehicle_simulator";
    }
    static constexpr const char* hct_03_illegal_parking_simulator_id()
    {
        return "hct_03_illegal_parking_simulator";
    }
    static constexpr const char* hct_04_passing_vehicle_simulator_id()
    {
        return "hct_04_passing_vehicle_simulator";
    }
    static constexpr const char* hct_05_unsignalized_turning_coming_vehicle_simulator_id()
    {
        return "hct_05_unsignalized_turning_coming_vehicle_simulator";
    }
    static constexpr const char* hct_06_mixed_traffic_flow_simulator_id()
    {
        return "hct_06_mixed_traffic_flow_simulator";
    }
    static constexpr const char* hct_07_signalized_straight_going_simulator_id()
    {
        return "hct_07_signalized_straight_going_simulator";
    }
    static constexpr const char* hct_08_signalized_right_turning_simulator_id()
    {
        return "hct_08_signalized_right_turning_simulator";
    }
    static constexpr const char* hct_09_signalized_left_turning_simulator_id()
    {
        return "hct_09_signalized_left_turning_simulator";
    }
    static constexpr const char* hct_10_merging_left_lane_simulator_id()
    {
        return "hct_10_merging_left_lane_simulator";
    }
    static constexpr const char* hct_11_automatic_parking_simulator_id()
    {
        return "hct_11_automatic_parking_simulator";
    }
    static constexpr const char* hct_12_traffic_light_flashing_id()
    {
        return "hct_12_traffic_light_flashing_simulator";
    }
    static constexpr const char* hct_13_approaching_ego_simulator_id()
    {
        return "hct_13_approaching_ego_simulator";
    }
    static constexpr const char* hct_14_cut_in_simulator_id()
    {
        return "hct_14_cut_in_simulator";
    }
    static constexpr const char* hct_15_route_moving_simulator_id()
    {
        return "hct_15_route_moving_simulator";
    }
    // static constexpr const char *hct_02_leaving_ramp_merging_simulator_id()
    //{return "hct_02_leaving_ramp_merging_simulator";}
    // static constexpr const char
    // *hct_03_vehicle_turning_left_at_exit_simulator_id() {return
    //"hct_03_vehicle_turning_left_at_exit_simulator";} static constexpr const char
    // *hct_04_vehicle_turning_right_at_exit_simulator_id() {return
    //"hct_04_vehicle_turning_right_at_exit_simulator";} static constexpr const char
    // *hct_05_crossing_at_t_junction_simulator_id() {return
    //"hct_05_crossing_at_t_junction_simulator";}

    static const std::vector<std::string> HctScenarioIds = {"hct_01",
                                                            "hct_02",
                                                            "hct_03",
                                                            "hct_04",
                                                            "hct_05",
                                                            "hct_06",
                                                            "hct_07",
                                                            "hct_08",
                                                            "hct_09",
                                                            "hct_10",
                                                            "hct_11",
                                                            "hct_12",
                                                            "hct_13",
                                                            "hct_14",
                                                            "hct_15"};

    template <typename IdType>
    void RegisterHctScenarios(SimulatorFactory<IdType>& outputFactory)
    {
        std::map<IdType, boost::function<Simulator*()>> simulatorRegisterMap{
            {hct_01_unsignalized_t_junction_crossing_simulator_id(), boost::bind(boost::factory<hct::UnsignalizedTJunctionCrossingSimulator*>())},
            {hct_02_unsignalized_straight_going_crossing_vehicle_simulator_id(),
             boost::bind(boost::factory<hct::UnsignalizedStraightGoingCrossingVehicleSimulator*>())},
            {hct_03_illegal_parking_simulator_id(), boost::bind(boost::factory<hct::IllegalParkingSimulator*>())},
            {hct_04_passing_vehicle_simulator_id(), boost::bind(boost::factory<hct::PassingVehicleSimulator*>())},
            {hct_05_unsignalized_turning_coming_vehicle_simulator_id(),
             boost::bind(boost::factory<hct::UnsignalizedTurningComingVehicleSimulator*>())},
            {hct_06_mixed_traffic_flow_simulator_id(), boost::bind(boost::factory<hct::MixedTrafficFlowSimulator*>())},
            {hct_07_signalized_straight_going_simulator_id(), boost::bind(boost::factory<hct::SignalizedStraightGoingSimulator*>())},
            {hct_08_signalized_right_turning_simulator_id(), boost::bind(boost::factory<hct::SignalizedRightTurningSimulator*>())},
            {hct_09_signalized_left_turning_simulator_id(), boost::bind(boost::factory<hct::SignalizedLeftTurningSimulator*>())},
            {hct_10_merging_left_lane_simulator_id(), boost::bind(boost::factory<hct::MergingLeftLaneSimulator*>())},
            {hct_11_automatic_parking_simulator_id(), boost::bind(boost::factory<hct::AutomaticParkingSimulator*>())},
            {hct_12_traffic_light_flashing_id(), boost::bind(boost::factory<hct::TrafficLightFlashingSimulator*>())},
            {hct_13_approaching_ego_simulator_id(), boost::bind(boost::factory<hct::ApproachingEgoSimulator*>())},
            {hct_14_cut_in_simulator_id(), boost::bind(boost::factory<hct::CutInSimulator*>())},
            {hct_15_route_moving_simulator_id(), boost::bind(boost::factory<hct::RouteMovingSimulator*>())},
            //        {
            //            hct_02_leaving_ramp_merging_simulator_id(),
            //            boost:bind(boost::factory<hct::LeavingRampMergingSimulator
            //            *>())
            //        },
            //        {
            //            hct_03_vehicle_turning_left_at_exit_simulator_id(),
            //            boost::bind(boost::factory<hct::VehicleTurningLeftAtExitSimulator
            //            *>())
            //        },
            //        {
            //            hct_04_vehicle_turning_right_at_exit_simulator_id(),
            //            boost::bind(boost::factory<hct::VehicleTurningRightAtExitSimulator
            //            *>())
            //        },
            //        {
            //            hct_05_crossing_at_t_junction_simulator_id(),
            //            boost::bind(boost::factory<hct::CrossingAtTJunctionSimulator
            //            *>())
            //        },
        };

        outputFactory.Register(simulatorRegisterMap);
    }

    template <typename IdType>
    void AppendHctScenarioIds(std::vector<IdType>& outputScenarioIds)
    {
        outputScenarioIds.insert(outputScenarioIds.end(), HctScenarioIds.cbegin(), HctScenarioIds.cend());
    }

}  // namespace scenario

#endif  // #ifndef _SCENARIO_HCT_H_
