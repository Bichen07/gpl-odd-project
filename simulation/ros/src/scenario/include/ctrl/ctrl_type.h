#ifndef _CTRL_TYPE_H_
#define _CTRL_TYPE_H_

#include <map>
#include <iostream>

namespace ctrl {

typedef enum class EndOption: int32_t
{
    Repeat,
    StayAtBegin,
    StayAtEnd,
    Num,
    Null = Num,
} EndOptionId;

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
        std::basic_ostream<charT, traits> &ostream,
        const EndOptionId &endOptionId)
{
    static const std::map<EndOptionId, const char *> endOptionIdMap =
    {
        {EndOption::Repeat,      "EndOption::Repeat"},
        {EndOption::StayAtBegin, "EndOption::StayAtBegin"},
        {EndOption::StayAtEnd,   "EndOption::StayAtEnd"},
        {EndOption::Null,        "EndOption::Null"},
    };

    ostream << endOptionIdMap.find(endOptionId)->second;
    return ostream;
}

} // namespace ctrl {

#endif // #ifndef _CTRL_TYPE_H_
