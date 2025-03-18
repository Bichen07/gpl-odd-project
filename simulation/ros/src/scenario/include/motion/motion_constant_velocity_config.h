#ifndef _MOTION_CONSTANT_VELOCITY_CONFIG_H_
#define _MOTION_CONSTANT_VELOCITY_CONFIG_H_

#include <iostream>
#include <jsoncpp/json/json.h>
#include <motion_offset_2d.h>

namespace motion {

struct ConstantVelocityConfig final
{
    double longitudinalOffsetRatio;
    double lateralOffsetRatio;
    double longitudinalOffset;
    double lateralOffset;
    double agentHeadingDegrees;
    double agentSpeedKph;
    double egoSpeedKph;
    int32_t beginLaneId;
    int32_t beginPointId;
    int32_t endLaneId;
    int32_t endPointId;

    ConstantVelocityConfig() = default;
    ConstantVelocityConfig(const ConstantVelocityConfig& other) = default;
    ConstantVelocityConfig& operator=(const ConstantVelocityConfig&) = default;
    ~ConstantVelocityConfig() = default;
};

void
ParseConstantVelocityConfig(const Json::Value& configJsonValue,
                            ConstantVelocityConfig& outputconfig);

template<typename charT, typename traits>
std::basic_ostream<charT, traits>&
operator<<(std::basic_ostream<charT, traits>& ostream,
           const ConstantVelocityConfig& config)
{
    ostream << "[motion::ConstantVelocityConfig]"
            << "\n"
            << "longitudinalOffsetRatio: " << config.longitudinalOffsetRatio
            << '\n'
            << "lateralOffsetRatio: " << config.lateralOffsetRatio << '\n'
            << "\n"
            << "longitudinalOffset: " << config.longitudinalOffset << '\n'
            << "lateralOffset: " << config.lateralOffset << '\n'
            << "heading: " << config.agentHeadingDegrees << '\n'
            << "agentSpeedKph: " << config.agentSpeedKph << '\n'
            << "egoSpeedKph: " << config.egoSpeedKph << '\n'
            << "beginLaneId: " << config.beginLaneId << '\n'
            << "beginPointId: " << config.beginPointId << '\n'
            << "endLaneId: " << config.endLaneId << '\n'
            << "endPointId: " << config.endPointId << '\n';
    return ostream;
}

} // namespace motion

#endif // #ifndef _MOTION_CONSTANT_VELOCITY_CONFIG_H_
