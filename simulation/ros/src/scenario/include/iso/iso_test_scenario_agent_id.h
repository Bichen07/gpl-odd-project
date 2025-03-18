#ifndef _ISO_TEST_SCENARIO_AGENT_ID_H_
#define _ISO_TEST_SCENARIO_AGENT_ID_H_

#include <string>

namespace iso {

namespace acc {

struct CurveCapabilityAgent final
{
    static constexpr const char *TargetVehicle()
    {return "acc_curve_capability_target_vehicle";}
};

struct TargetDiscriminationAgent final
{
    static constexpr const char *TargetVehicle()
    {return "acc_target_discrimination_target_vehicle";}
    static constexpr const char *ForwardVehicle()
    {return "acc_target_discrimination_forward_vehicle";}
};

} // namespace acc {

namespace lcdas {

struct OvertakingAgent final
{
    static const char *TargetVehicle()
    {return "adas_lcdas_overtaking_subject_target_vehicle";}
};

struct OvertookAgent final
{
    static const char *TargetVehicle()
    {return "adas_lcdas_overtaking_target_vehicle";}
};

struct LatralMovingAgent final
{
    static const char *TargetVehicle()
    {return "adas_lcdas_lateral_moving_target_vehicle";}  
};

} // namespace lcdas {

namespace lsf {

struct TargetStationaryAgent final
{
    static const char *TargetVehicle()
    {return "adas_lsf_automatic_deceleration_vehicle";}
}; 

struct FollowingAgent final
{
    static const char *FirstTargetVehicle()
    {return "adas_lsf_first_target_vehicle";}
    static const char *SecondTargetVehicle()
    {return "adas_lsf_second_target_vehicle";}
}; 

} // namespace lsf {

namespace fvcws {

struct LongitudinalDiscriminationAgent final
{
    static constexpr const char *NearTargetVehicle()
    {return "fvcws_longitudinal_discrimination_near_target_vehicle";}
    static constexpr const char *FarTargetVehicle()
    {return "fvcws_longitudinal_discrimination_far_target_vehicle";}
};

struct LateralDiscriminationAgent final
{
    static constexpr const char *TargetVehicle()
    {return "fvcws_lateral_discrimination_target_vehicle";}
    static constexpr const char *ForwardVehicle()
    {return "fvcws_lateral_discrimination_forward_vehicle";}
};

} // namespace fvcws {

} // namespace iso {

#endif // #ifndef _ISO_TEST_SCENARIO_AGENT_ID_H_
