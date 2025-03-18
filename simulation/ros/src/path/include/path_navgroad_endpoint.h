#ifndef _PATH_NAVGROAD_ENDPOINT_H_
#define _PATH_NAVGROAD_ENDPOINT_H_

#include <limits>
#include <iostream>
#include <path_direction_id.h>

namespace path {

struct NavgroadEndpoint
{
    int32_t navgroadId;
    DirectionId direction;

    NavgroadEndpoint()
        : navgroadId{std::numeric_limits<int32_t>::min()}
        , direction{Direction::Null}
    {
    }
    NavgroadEndpoint(
        const int32_t inputNavgroadId,
        const DirectionId &inputDirection)
        : navgroadId{inputNavgroadId}
        , direction{inputDirection}
    {
    }
    NavgroadEndpoint(const NavgroadEndpoint &other) = default;
    NavgroadEndpoint &operator=(const NavgroadEndpoint &other) = default;
    ~NavgroadEndpoint() = default;
};

static bool operator==(const NavgroadEndpoint &left, const NavgroadEndpoint &right)
{
    if (left.navgroadId == right.navgroadId &&
        left.direction == right.direction)
    {
        return true;
    }

    return false;
}

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const NavgroadEndpoint &endpoint)
{
    ostream << "[NavgroadEndpoint]" << '\n' <<
        "navgroadId: " << endpoint.navgroadId << '\n' <<
        "direction: " << endpoint.direction;
    return ostream;
}

} // namespace path {

#endif // #ifndef _PATH_NAVGROAD_ENDPOINT_H_
