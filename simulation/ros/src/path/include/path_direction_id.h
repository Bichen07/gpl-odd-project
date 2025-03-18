#ifndef _PATH_DIRECTION_ID_H_
#define _PATH_DIRECTION_ID_H_

#include <map>
#include <string>
#include <iostream>

namespace path {

typedef enum class Direction: int32_t
{
    Forward = 0,
    Opposite,
    Num,
    Null = Num,
} DirectionId;

DirectionId ToDirectionId(const std::string &key);
std::string ToDirectionLabel(const DirectionId &directionId);
DirectionId EvaluateDirection(const int32_t isPositive);

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const DirectionId &directionId)
{
    static const std::map<DirectionId, const char *> directionIdMap =
    {
        {Direction::Forward,  "Direction::Forward"},
        {Direction::Opposite, "Direction::Opposite"},
        {Direction::Null,     "Direction::Null"},
    };

    ostream << directionIdMap.find(directionId)->second;
    return ostream;
}

} // namespace path {

#endif // #ifndef _PATH_DIRECTION_ID_H_
