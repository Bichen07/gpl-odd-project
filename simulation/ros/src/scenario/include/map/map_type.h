#ifndef _MAP_TYPE_H_
#define _MAP_TYPE_H_

#include <utility>
#include <math_type.h>

namespace map {

typedef enum class Direction: int32_t
{
    Forward = 0,
    Reverse,
    Num,
    Null = Num,
} DirectionId;

typedef std::pair<math::Vector3d_t, math::Vector3d_t> Vector3dPair;

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const DirectionId &directionId)
{
    static const std::map<DirectionId, const char *> directionIdMap =
    {
        {Direction::Forward, "Direction::Forward"},
        {Direction::Reverse, "Direction::Reverse"},
        {Direction::Null,    "Direction::Null"},
    };

    ostream << directionIdMap.find(directionId)->second;
    return ostream;
}

} // namespace map {

#endif // #ifndef _MAP_TYPE_H_
