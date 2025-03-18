#ifndef _RSS_PEDESTRIAN_LANE_STATUS_H_
#define _RSS_PEDESTRIAN_LANE_STATUS_H_

#include <iostream>
#include <iomanip>

namespace rss {

struct PedestrianLaneStatus final
{
    bool isOnSidewalk;
    bool isOnRoad;

    PedestrianLaneStatus()
        : isOnSidewalk{false}
        , isOnRoad{false}
    {
    }
    PedestrianLaneStatus(
        const bool inputOnSidewalk,
        const bool inputOnRoad)
        : isOnSidewalk{inputOnSidewalk}
        , isOnRoad{inputOnRoad}
    {
    }
    PedestrianLaneStatus(const PedestrianLaneStatus &other) = default;
    PedestrianLaneStatus &operator=(const PedestrianLaneStatus &other) = default;
    ~PedestrianLaneStatus() = default;
};

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const PedestrianLaneStatus &status)
{
    ostream << std::boolalpha <<
        "[PedestrianLaneStatus]" << '\n' <<
        "isOnSidewalk: " << status.isOnSidewalk << '\n' <<
        "isOnRoad: " << status.isOnRoad;
    return ostream;
}

} // namespace rss {

#endif // #ifndef _RSS_PEDESTRIAN_LANE_STATUS_H_
