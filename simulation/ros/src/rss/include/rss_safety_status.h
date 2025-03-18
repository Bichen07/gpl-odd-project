#ifndef _RSS_SAFETY_STATUS_H_
#define _RSS_SAFETY_STATUS_H_

#include <map>
#include <iostream>

namespace rss {

enum class SafetyStatus: int32_t
{
    Safe = 0,
    Warning,
    Dangerous,
    Num,
    Null = Num,
};

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const SafetyStatus &safetyStatus)
{
    static const std::map<SafetyStatus, const char *> safetyStatusMap =
    {
        {SafetyStatus::Safe,      "rss::SafetyStatus::Safe"},
        {SafetyStatus::Warning,   "rss::SafetyStatus::Warning"},
        {SafetyStatus::Dangerous, "rss::SafetyStatus::Dangerous"},
        {SafetyStatus::Null,      "rss::SafetyStatus::Null"},
    };

    ostream << safetyStatusMap.find(safetyStatus)->second;

    return ostream;
}

} // namespace rss {

#endif // #ifndef _RSS_SAFETY_STATUS_H_
