#ifndef _PATH_NAVG_ROAD_ENDPOINT_H_
#define _PATH_NAVG_ROAD_ENDPOINT_H_

#include <limits>
#include <iostream>

namespace path {

struct NavgRoadEndpoint
{
    bool isForward;
    int32_t navgRoadId;

    NavgRoadEndpoint()
        : isForward{false}
        , navgRoadId{std::numeric_limits<int32_t>::min()}
    {
    }
    NavgRoadEndpoint(
        const bool inputIsForward,
        const int32_t inputNavgRoadId)
        : isForward{inputIsForward}
        , navgRoadId{inputNavgRoadId}
    {
    }
    NavgRoadEndpoint(const NavgRoadEndpoint &other) = default;
    NavgRoadEndpoint &operator=(const NavgRoadEndpoint &other) = default;
    ~NavgRoadEndpoint() = default;
};

static bool operator==(const NavgRoadEndpoint &left, const NavgRoadEndpoint &right)
{
    if (left.isForward == right.isForward &&
        left.navgRoadId == right.navgRoadId)
    {
        return true;
    }

    return false;
}

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const NavgRoadEndpoint &endpoint)
{
    ostream << "[NavgRoadEndpoint]" << '\n' <<
        "isForward: " << endpoint.isForward << '\n' <<
        "navgRoadId: " << endpoint.navgRoadId;
    return ostream;
}

} // namespace path {

#endif // #ifndef _PATH_NAVG_ROAD_ENDPOINT_H_
