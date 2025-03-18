#ifndef _MOTION_DISTANCE_SPEED_CONFIG_H_
#define _MOTION_DISTANCE_SPEED_CONFIG_H_

#include <iostream>

namespace motion {

struct DistanceSpeedConfig final
{
    double distance;
    double speedMps;

    DistanceSpeedConfig()
        : distance{0.0}
        , speedMps{0.0}
    {
    }
    explicit DistanceSpeedConfig(
        const double inputDistance,
        const double inputSpeedMps)
        : distance{inputDistance}
        , speedMps{inputSpeedMps}
    {
    }
    DistanceSpeedConfig(const DistanceSpeedConfig &other) = default;
    DistanceSpeedConfig &operator=(const DistanceSpeedConfig &other) = default;
    ~DistanceSpeedConfig() = default;
};

bool operator<(const DistanceSpeedConfig &lhs, const DistanceSpeedConfig &rhs);

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const DistanceSpeedConfig &config)
{
    ostream << "[motion::DistanceSpeedConfig]" << '\n' <<
        "distance: " << config.distance << '\n' <<
        "speedMps: " << config.speedMps;
    return ostream;
}

} // namespace motion {

#endif // #ifndef _MOTION_DISTANCE_SPEED_CHANGE_CONFIG_H_
