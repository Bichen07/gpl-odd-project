#ifndef _MOTION_ALKS_CUT_IN_CONFIG_H_
#define _MOTION_ALKS_CUT_IN_CONFIG_H_

#include <iostream>
#include <jsoncpp/json/json.h>
#include <motion_offset_2d.h>

namespace motion
{

    struct AlksCutInConfig final
    {
        double  ve0_kph;
        double  vo0_kph;
        double  dx0_m;
        double  dy0_m;
        double  vy_mps;
        double  delay_seconds;
        int32_t begin_lane_id;
        int32_t begin_point_id;
        int32_t end_lane_id;
        int32_t end_point_id;

        AlksCutInConfig()                                  = default;
        AlksCutInConfig(const AlksCutInConfig& other)      = default;
        AlksCutInConfig& operator=(const AlksCutInConfig&) = default;
        ~AlksCutInConfig()                                 = default;
    };

    void ParseAlksCutInConfig(const Json::Value& configJsonValue, AlksCutInConfig& outputconfig);

    template <typename charT, typename traits>
    std::basic_ostream<charT, traits>& operator<<(std::basic_ostream<charT, traits>& ostream, const AlksCutInConfig& config)
    {
        ostream << "[motion::AlksCutInConfig]"
                << "\n"
                << "begin_lane_id: " << config.begin_lane_id << '\n'
                << "begin_point_id: " << config.begin_point_id << '\n'
                << "delay_seconds: " << config.delay_seconds << '\n'
                << "ve0_kph: " << config.ve0_kph << '\n'
                << "vo0_kph: " << config.vo0_kph << '\n'
                << "\n"
                << "dx0_m: " << config.dx0_m << '\n'
                << "dy0_m: " << config.dy0_m << '\n'
                << "vy_mps: " << config.vy_mps << '\n';
        return ostream;
    }

}  // namespace motion

#endif  // #ifndef _MOTION_ALKS_CUT_IN_CONFIG_H_
