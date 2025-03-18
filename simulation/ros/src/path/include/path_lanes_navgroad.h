#ifndef _PATH_LANES_NAVGROAD_H_
#define _PATH_LANES_NAVGROAD_H_

#include <limits>
#include <path_navgroad_endpoint.h>

namespace path {

struct LanesNavgroad final
{
    int32_t laneId;
    NavgroadEndpoint begin;
    NavgroadEndpoint end;

    LanesNavgroad()
        : laneId{std::numeric_limits<int32_t>::min()}
        , begin{}
        , end{}
    {
    }
    LanesNavgroad(
        const int32_t inputLaneId,
        const NavgroadEndpoint &inputBegin,
        const NavgroadEndpoint &inputEnd)
        : laneId{inputLaneId}
        , begin{inputBegin}
        , end{inputEnd}
    {
    }
    LanesNavgroad(const LanesNavgroad &other) = default;
    LanesNavgroad &operator=(const LanesNavgroad &other) = default;
    ~LanesNavgroad() = default;
};

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const LanesNavgroad &lanesNavgroad)
{
    ostream << "[LanesNavgroad]" << '\n' <<
        "laneId: " << lanesNavgroad.laneId << '\n' <<
        "begin: " << lanesNavgroad.begin << '\n' <<
        "end: " << lanesNavgroad.end;
    return ostream;
}

} // namespace path {

#endif // #ifndef _PATH_LANES_NAVGROAD_H_
