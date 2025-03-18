#ifndef _RSS_STRUCTURED_SAFETY_H_
#define _RSS_STRUCTURED_SAFETY_H_

#include <iostream>
#include <rss_msgs/StructuredSafety.h>
#include <rss_safety_status.h>
#include <rss_safety_state.h>

namespace rss {

struct StructuredSafety
{
    SafetyStatus status;
    SafetyState state;

    StructuredSafety()
        : status{SafetyStatus::Null}
        , state{}
    {
    }
    explicit StructuredSafety(
        const SafetyStatus &inputSafetyStatus,
        const SafetyState &inputState)
        : status{inputSafetyStatus}
        , state{inputState}
    {
    }
    StructuredSafety(const StructuredSafety &other) = default;
    StructuredSafety &operator=(const StructuredSafety &other) = default;
    ~StructuredSafety() = default;
};

void ToStructuredSafetyMsg(
    const StructuredSafety &structuredSafety,
    rss_msgs::StructuredSafety &outputMsg);

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const StructuredSafety &structuredSafety)
{
    ostream << "[StructuredSafety]" << '\n' <<
        "status: " << structuredSafety.status << '\n' <<
        structuredSafety.state;
    return ostream;
}

} // namespace rss {

#endif // #ifndef _RSS_STRUCTURED_SAFETY_H_
