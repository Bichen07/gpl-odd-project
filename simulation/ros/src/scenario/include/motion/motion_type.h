#ifndef _MOTION_TYPE_H_
#define _MOTION_TYPE_H_

#include <string>
#include <map>
#include <iostream>

namespace motion {

typedef enum class ComingDirection: int32_t
{
    OncomingSide = 0,
    LeftSide,
    RightSide,
    Num,
    Null = Num
} ComingDirectionId;

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
        std::basic_ostream<charT, traits> &ostream,
        const ComingDirectionId &comingDirectionId)
{
    static const std::map<ComingDirectionId, const char *> comingDirectionMap =
    {
        {ComingDirection::OncomingSide, "ComingDirection::OncomingSide"},
        {ComingDirection::LeftSide,     "ComingDirection::LeftSide"},
        {ComingDirection::RightSide,    "ComingDirection::RightSide"},
        {ComingDirection::Null,         "ComingDirection::Null"},
    };

    ostream << comingDirectionMap.find(comingDirectionId)->second;
    return ostream;
}

} // namespace motion {

#endif // #ifndef _MOTION_TYPE_H_
