#ifndef _MOTION_STATIONARY_OBJECT_CONFIG_H_
#define _MOTION_STATIONARY_OBJECT_CONFIG_H_

#include <iostream>
#include <motion_offset_2d.h>
#include <jsoncpp/json/json.h>

namespace motion {

struct StationaryObjectConfig final
{
    int32_t laneId;
    int32_t pointId;
    Offset2d offset;

    StationaryObjectConfig()
        : laneId{0}
        , pointId{0}
        , offset{}
    {
    }
    StationaryObjectConfig(const StationaryObjectConfig &) = default;
    StationaryObjectConfig &operator=(const StationaryObjectConfig &) = default;
    ~StationaryObjectConfig() = default;
};

void ParseStationaryObjectConfig(
    const Json::Value &configJsonValue,
    StationaryObjectConfig &outputConfig);

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const StationaryObjectConfig &config)
{
    ostream << "[motion::StationaryObjectConfig]" << '\n' <<
        "laneId: " << config.laneId << '\n' <<
        "pointId: " << config.pointId << '\n' <<
        "offset: " << config.offset;
    return ostream;
}

} // namespace motion {

#endif // #ifndef _MOTION_STATIONARY_OBJECT_CONFIG_H_
