#ifndef _ISO_ACC_TIME_GAP_PERFORMANCE_H_
#define _ISO_ACC_TIME_GAP_PERFORMANCE_H_

#include <math_type.h>
#include <iso_type.h>

namespace iso {
namespace acc {

struct TimeGapPerformance final
{
    math::real_t timeGap;
    TimeGapStateId timeGapStateId;

    TimeGapPerformance()
        : timeGap{0.0}
        , timeGapStateId{TimeGapState::Null}
    {
    }
    TimeGapPerformance(
        const math::real_t inputTimeGap,
        const TimeGapStateId &inputTimeGapStateId)
        : timeGap{inputTimeGap}
        , timeGapStateId{inputTimeGapStateId}
    {
    }
    TimeGapPerformance(const TimeGapPerformance &other) = default;
    TimeGapPerformance &operator=(const TimeGapPerformance &other) = default;
    ~TimeGapPerformance() = default;
};

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
        std::basic_ostream<charT, traits> &ostream,
        const TimeGapPerformance &performance)
{
    ostream << "timeGap: " << performance.timeGap << '\n' <<
        "timeGapStateId: " << performance.timeGapStateId;
    return ostream;
}

} // namespace acc {
} // namespace iso {

#endif // #ifndef _ISO_ACC_TIME_GAP_PERFORMANCE_H_
