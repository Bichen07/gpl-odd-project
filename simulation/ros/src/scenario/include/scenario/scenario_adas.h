#ifndef _SCENARIO_ADAS_H_
#define _SCENARIO_ADAS_H_

#include <vector>
#include <string>
#include <scenario_simulator_factory.h>
#include <adas_acc_target_discrimination_simulator.h>
#include <adas_acc_curve_capability_simulator.h>
#include <adas_fvcws_curved_road_lateral_discrimination_simulator.h>
#include <adas_fvcws_straight_road_lateral_discrimination_simulator.h>
#include <adas_fvcws_longitudinal_discrimination_simulator.h>
#include <adas_lkas_straight_lane_keeping_simulator.h>
#include <adas_lcdas_overtaking_subject_simulator.h>
#include <adas_lcdas_overtaking_target_simulator.h>
#include <adas_lcdas_lateral_moving_simulator.h>
#include <adas_lsf_automatic_deceleration_simulator.h>
#include <adas_lsf_retargeting_simulator.h>

namespace scenario {

static constexpr const char *adas_acc_target_discrimination_simulator_id()
{return "adas_acc_target_discrimination_simulator";}
static constexpr const char *adas_acc_curve_capability_simulator_id()
{return "adas_acc_curve_capability_simulator";}
static constexpr const char *adas_fvcws_curved_road_lateral_discrimination_simulator_id()
{return "adas_fvcws_curved_road_lateral_discrimination_simulator";}
static constexpr const char *adas_fvcws_straight_road_lateral_discrimination_simulator_id()
{return "adas_fvcws_straight_road_lateral_discrimination_simulator";}
static constexpr const char *adas_fvcws_longitudinal_discrimination_simulator_id()
{return "adas_fvcws_longitudinal_discrimination_simulator";}
static constexpr const char *adas_lkas_straight_lane_keeping_simulator_id()
{return "adas_lkas_straight_lane_keeping_simulator";}
static constexpr const char *adas_lcdas_overtaking_subject_simulator_id()
{return "adas_lcdas_overtaking_subject_simulator";}
static constexpr const char *adas_lcdas_overtaking_target_simulator_id()
{return "adas_lcdas_overtaking_target_simulator";}
static constexpr const char *adas_lcdas_lateral_moving_simulator_id()
{return "adas_lcdas_lateral_moving_simulator";}
static constexpr const char *adas_lsf_automatic_deceleration_simulator_id()
{return "adas_lsf_automatic_deceleration_simulator";}
static constexpr const char *adas_lsf_retargeting_simulator_id()
{return "adas_lsf_retargeting_simulator";}
static constexpr const char *adas_lsf_retargeting_simulator_id_2()
{return "adas_lsf_retargeting_simulator_2";}

static const std::vector<std::string> AdasScenarioIds =
{
    "adas_acc_target_discrimination",
    "adas_acc_curve_capability",
    "adas_fvcws_curved_road_lateral_discrimination",
    "adas_fvcws_straight_road_lateral_discrimination",
    "adas_fvcws_longitudinal_discrimination",
    "adas_lkas_straight_lane_keeping",
    "adas_lcdas_overtaking_subject",
    "adas_lcdas_overtaking_target",
    "adas_lcdas_lateral_moving",
    "adas_lsf_automatic_deceleration",
    "adas_lsf_retargeting_capability",
    "adas_lsf_retargeting_capability_2",
};

template<typename IdType>
void RegisterAdasScenarios(SimulatorFactory<IdType> &outputFactory)
{
    std::map<IdType, boost::function<Simulator *()>> simulatorRegisterMap
    {
        {
            adas_acc_target_discrimination_simulator_id(),
            boost::bind(boost::factory<adas::acc::TargetDiscriminationSimulator *>())
        },
        {
            adas_acc_curve_capability_simulator_id(),
            boost::bind(boost::factory<adas::acc::CurveCapabilitySimulator *>())
        },
        {
            adas_fvcws_curved_road_lateral_discrimination_simulator_id(),
            boost::bind(boost::factory<adas::fvcws::CurvedRoadLateralDiscriminationSimulator *>())
        },
        {
            adas_fvcws_straight_road_lateral_discrimination_simulator_id(),
            boost::bind(boost::factory<adas::fvcws::StraightRoadLateralDiscriminationSimulator *>())
        },
        {
            adas_fvcws_longitudinal_discrimination_simulator_id(),
            boost::bind(boost::factory<adas::fvcws::LongitudinalDiscriminationSimulator *>())
        },
        {
            adas_lkas_straight_lane_keeping_simulator_id(),
            boost::bind(boost::factory<adas::lkas::StraightLaneKeepingSimulator *>())
        },
        {
            adas_lcdas_overtaking_subject_simulator_id(),
            boost::bind(boost::factory<adas::lcdas::OvertakingSubjectWarningSimulator *>())
        },
        {
            adas_lcdas_overtaking_target_simulator_id(),
            boost::bind(boost::factory<adas::lcdas::OvertakingTargetWarningSimulator *>())
        },
        {
            adas_lcdas_lateral_moving_simulator_id(),
            boost::bind(boost::factory<adas::lcdas::LateralMovingSimulator *>())
        },
        {
            adas_lsf_automatic_deceleration_simulator_id(),
            boost::bind(boost::factory<adas::lsf::AutomaticDecelerationSimulator *>())
        },
        {
            adas_lsf_retargeting_simulator_id(),
            boost::bind(boost::factory<adas::lsf::RetargetingSimulator *>())
        },
        {
            adas_lsf_retargeting_simulator_id_2(),
            boost::bind(boost::factory<adas::lsf::RetargetingSimulator *>())
        },
    };

    outputFactory.Register(simulatorRegisterMap);
}

template<typename IdType>
void AppendAdasScenarioIds(std::vector<IdType> &outputScenarioIds)
{
    outputScenarioIds.insert(
        outputScenarioIds.end(),
        AdasScenarioIds.cbegin(),
        AdasScenarioIds.cend());
}

} // namespace scenario {

#endif // #ifndef _SCENARIO_ADAS_H_
