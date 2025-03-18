#ifndef _ISO_TYPE_H_
#define _ISO_TYPE_H_

#include <map>
#include <iostream>

namespace iso {

typedef enum class PerformanceClass: int32_t
{
    One = 0,
    Two,
    Three,
    Four,
    Num,
    Null = Num,
} PerformanceClassId;

namespace acc {

typedef enum class TimeGapState: int32_t
{
    UnderCriticalMin = 0, // time-gap < 0.8 s
    UnderRangeMin,        // 1.5 s > time-gap >= 0.8 s
    WithinRange,          // 2.2 s > time-gap >= 1.5 s
    AboveRangeMax,        // time-gap >= 2.2 s
    Num,
    Null = Num,
} TimeGapStateId;

typedef enum class TargetDiscriminationState: int32_t
{
    BeforeInitialCondition = 0,
    DuringTest,
    PassTest,
    FailTest,
    Num,
    Null = Num,
} TargetDiscriminationStateId;

} // namespace acc {

namespace fvcws {

typedef enum class LongitudinalDiscriminationState: int32_t
{
    BeforeInitialCondition = 0,
    InitFollowing,
    SubjectAcceleratingTriggerWarning,
    FirstWarning,
    AfterFirstWarningFollowing,
    TargetDecelerationTriggerWarning,
    SecondWarning,
    PassTest,
    FailTest,
    Num,
    Null = Num,
} LongitudinalDiscriminationStateId;

typedef enum class LateralDiscriminationState: int32_t
{
    BeforeInitCondition = 0,
    InitFollowing,
    ForwardDeceleration,
    SubjectPassForward,
    TargetDeceleration,
    SubjectWarning,
    PassTest,
    FailTest,
    Num,
    Null = Num,
} LateralDiscriminationStateId;

} // namespace fvcws {

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
        std::basic_ostream<charT, traits> &ostream,
        const PerformanceClassId &performanceClassId)
{
    static const std::map<PerformanceClassId, const char *> performanceClassIdMap =
    {
        {PerformanceClass::One,   "PerformanceClass::One"},
        {PerformanceClass::Two,   "PerformanceClass::Two"},
        {PerformanceClass::Three, "PerformanceClass::Three"},
        {PerformanceClass::Four,  "PerformanceClass::Four"},
        {PerformanceClass::Null,  "PerformanceClass::Null"},
    };

    ostream << performanceClassIdMap.find(performanceClassId)->second;
    return ostream;
}

namespace acc {

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
        std::basic_ostream<charT, traits> &ostream,
        const TimeGapStateId &timeGapStateId)
{
    static const std::map<acc::TimeGapStateId, const char *> timeGapStateIdMap =
    {
        {acc::TimeGapState::UnderCriticalMin, "acc::TimeGapState::UnderCriticalMin"},
        {acc::TimeGapState::UnderRangeMin,    "acc::TimeGapState::UnderRange"},
        {acc::TimeGapState::WithinRange,      "acc::TimeGapState::WithinRange"},
        {acc::TimeGapState::AboveRangeMax,    "acc::TimeGapState::AboveMax"},
        {acc::TimeGapState::Null,             "acc::TimeGapState::Null"},
    };

    ostream << timeGapStateIdMap.find(timeGapStateId)->second;
    return ostream;
}

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
        std::basic_ostream<charT, traits> &ostream,
        const TargetDiscriminationStateId &stateId)
{
    static const std::map<acc::TargetDiscriminationStateId, const char *> stateIdMap =
    {
        {
            acc::TargetDiscriminationState::BeforeInitialCondition,
            "acc::TargetDiscriminationState::BeforeInitialCondition"
        },
        {
            acc::TargetDiscriminationState::DuringTest,
            "acc::TargetDiscriminationState::DuringTest"
        },
        {
            acc::TargetDiscriminationState::PassTest,
            "acc::TargetDiscriminationState::PassTest"
        },
        {
            acc::TargetDiscriminationState::FailTest,
            "acc::TargetDiscriminationState::FailTest"
        },
        {
            acc::TargetDiscriminationState::Null,
            "acc::TargetDiscriminationState::Null"
        },
    };

    ostream << stateIdMap.find(stateId)->second;
    return ostream;
}

} // namespace acc {

namespace fvcws {

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
        std::basic_ostream<charT, traits> &ostream,
        const LongitudinalDiscriminationStateId &stateId)
{
    static const std::map<LongitudinalDiscriminationStateId, const char *> stateIdMap =
    {
        {
            fvcws::LongitudinalDiscriminationState::BeforeInitialCondition,
            "fvcws::LongitudinalDiscriminationState::BeforeInitialCondition"
        },
        {
            fvcws::LongitudinalDiscriminationState::InitFollowing,
            "fvcws::LongitudinalDiscriminationState::InitFollowing"
        },
        {
            fvcws::LongitudinalDiscriminationState::SubjectAcceleratingTriggerWarning,
            "fvcws::LongitudinalDiscriminationState::SubjectAcceleratingTriggerWarning"
        },
        {
            fvcws::LongitudinalDiscriminationState::FirstWarning,
            "fvcws::LongitudinalDiscriminationState::FirstWarning"
        },
        {
            fvcws::LongitudinalDiscriminationState::AfterFirstWarningFollowing,
            "fvcws::LongitudinalDiscriminationState::AfterFirstWarningFollowing"
        },
        {
            fvcws::LongitudinalDiscriminationState::TargetDecelerationTriggerWarning,
            "fvcws::LongitudinalDiscriminationState::TargetDecelerationTriggerWarning"
        },
        {
            fvcws::LongitudinalDiscriminationState::SecondWarning,
            "fvcws::LongitudinalDiscriminationState::SecondWarning"
        },
        {
            fvcws::LongitudinalDiscriminationState::PassTest,
            "fvcws::LongitudinalDiscriminationState::PassTest"
        },
        {
            fvcws::LongitudinalDiscriminationState::FailTest,
            "fvcws::LongitudinalDiscriminationState::FailTest"
        },
        {
            fvcws::LongitudinalDiscriminationState::Null,
            "fvcws::LongitudinalDiscriminationState::Null"
        },
    };

    ostream << stateIdMap.find(stateId)->second;
    return ostream;
}

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
        std::basic_ostream<charT, traits> &ostream,
        const LateralDiscriminationStateId &stateId)
{
    static const std::map<LateralDiscriminationStateId, const char *> stateIdMap =
    {
        {
            fvcws::LateralDiscriminationState::BeforeInitCondition,
            "fvcws::LateralDiscriminationState::BeforeInitCondition"
        },
        {
            fvcws::LateralDiscriminationState::InitFollowing,
            "fvcws::LateralDiscriminationState::InitFollowing"
        },
        {
            fvcws::LateralDiscriminationState::ForwardDeceleration,
            "fvcws::LateralDiscriminationState::ForwardDeceleration"
        },
        {
            fvcws::LateralDiscriminationState::SubjectPassForward,
            "fvcws::LateralDiscriminationState::SubjectPassForward"
        },
        {
            fvcws::LateralDiscriminationState::TargetDeceleration,
            "fvcws::LateralDiscriminationState::TargetDeceleration"
        },
        {
            fvcws::LateralDiscriminationState::SubjectWarning,
            "fvcws::LateralDiscriminationState::SubjectWarning"
        },
        {
            fvcws::LateralDiscriminationState::PassTest,
            "fvcws::LateralDiscriminationState::PassTest"
        },
        {
            fvcws::LateralDiscriminationState::FailTest,
            "fvcws::LateralDiscriminationState::FailTest"
        },
        {
            fvcws::LateralDiscriminationState::Null,
            "fvcws::LateralDiscriminationState::Null"
        },
    };

    ostream << stateIdMap.find(stateId)->second;
    return ostream;
}

} // namespace fvcws {

} // namespace iso {

#endif // #ifndef _ISO_TYPE_H_
