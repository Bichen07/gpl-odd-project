#ifndef _ISO_SPECIFICATION_H_
#define _ISO_SPECIFICATION_H_

#include <math_type.h>

namespace iso {

namespace acc {

struct TimeGap final
{
    static constexpr math::real_t CriticalMin()
    {return math::real_t{0.8};}
    static constexpr math::real_t RangeMin()
    {return math::real_t{1.5};}
    static constexpr math::real_t RangeMax()
    {return math::real_t{2.2};}
};

struct CurveCapability final
{
    static constexpr math::real_t ClassTwoTestTrackRadius()
    {return math::real_t{500.0};}
    static constexpr math::real_t ClassThreeTestTrackRadius()
    {return math::real_t{250.0};}
    static constexpr math::real_t ClassFourTestTrackRadius()
    {return math::real_t{125.0};}
    static constexpr math::real_t ClassTwoMaxLateralAcceleration()
    {return math::real_t{2.0};}
    static constexpr math::real_t ClassThreeMaxLateralAcceleration()
    {return math::real_t{2.3};}
    static constexpr math::real_t ClassFourMaxLateralAcceleration()
    {return math::real_t{2.3};}
    static constexpr math::real_t DecelerationTriggerTimeGapFactor()
    {return math::real_t{2.0} / math::real_t{3.0};}
};

struct TargetDiscrimination final
{
    static constexpr math::real_t DefaultDesiredVehicleEndMps()
    {return math::real_t{27.0};}
    static constexpr math::real_t MinDesiredVehicleEndMps()
    {return math::real_t{22.0};}
    static constexpr math::real_t BeginEndMpsDifference()
    {return math::real_t{3.0};}
};

} // namespace acc {

namespace fvcws {

struct LongitudinalDiscrimination final
{
    static constexpr math::real_t TargetVehicleBeginMps()
    {return math::real_t{20.0};}
    static constexpr math::real_t DesiredTimeGap()
    {return math::real_t{1.5};}
    static const math::real_t MinRelativeSpeed()
    {return math::real_t{4.2};}
    static const math::real_t MaxRelativeSpeed()
    {return math::real_t{20.0};}
};

struct LateralDiscrimination final
{
    static constexpr math::real_t DesiredTimeGap()
    {return math::real_t{1.5};}
    static constexpr math::real_t ForwardVehicleInitSpeed()
    {return math::real_t{20.0};}
    static constexpr math::real_t TargetVehicleInitSpeed()
    {return math::real_t{20.0};}
};

} // namespace fvcws {

} // namespace iso {

#endif // #ifndef _ISO_SPECIFICATION_H_
