#ifndef _RSS_SAFETY_STATE_H_
#define _RSS_SAFETY_STATE_H_

#include <bitset>
#include <iostream>
#include <ros/console.h>
#include <rss_msgs/SafetyState.h>

namespace rss {

struct SafetyState final
{
    bool isLateralLeftSafe;
    bool isLateralRightSafe;
    bool isLongitudinalSafe;

    SafetyState()
        : isLateralLeftSafe{false}
        , isLateralRightSafe{false}
        , isLongitudinalSafe{false}
    {
    }
    SafetyState(
        const bool inputLateralLeftSafe,
        const bool inputLateralRightSafe,
        const bool inputLongitudinalSafe)
        : isLateralLeftSafe{inputLateralLeftSafe}
        , isLateralRightSafe{inputLateralRightSafe}
        , isLongitudinalSafe{inputLongitudinalSafe}
    {
    }
    SafetyState(const SafetyState &) = default;
    SafetyState &operator=(const SafetyState &) = default;
    ~SafetyState() = default;
};

void ToSafetyStateMsg(
    const SafetyState &safetyState,
    rss_msgs::SafetyState &outputMsg);

static bool operator<(const SafetyState &first, const SafetyState &second)
{
    const std::bitset<3> firstNum =
        (first.isLateralLeftSafe ? std::bitset<3>("100") : std::bitset<3>("000")) |
        (first.isLateralRightSafe ? std::bitset<3>("010") : std::bitset<3>("000")) |
        (first.isLongitudinalSafe ? std::bitset<3>("001") : std::bitset<3>("000"));
    const std::bitset<3> secondNum =
        (second.isLateralLeftSafe ? std::bitset<3>("100") : std::bitset<3>("000")) |
        (second.isLateralRightSafe ? std::bitset<3>("010") : std::bitset<3>("000")) |
        (second.isLongitudinalSafe ? std::bitset<3>("001") : std::bitset<3>("000"));

    return firstNum.to_ulong() < secondNum.to_ulong();
}

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const SafetyState &safetyState)
{
    ostream << std::boolalpha <<
        "[SafetyState]" << '\n' <<
        "isLateralLeftSafe: " << safetyState.isLateralLeftSafe << '\n' <<
        "isLateralRightSafe: " << safetyState.isLateralRightSafe << '\n' <<
        "isLongitudinalSafe: " << safetyState.isLongitudinalSafe;
    return ostream;
}

} // namespace rss {

#endif // #ifndef _RSS_SAFETY_STATE_H_
