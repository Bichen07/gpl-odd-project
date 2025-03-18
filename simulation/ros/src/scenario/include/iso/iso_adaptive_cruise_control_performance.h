#ifndef _ISO_ADAPTIVE_CRUISE_CONTROL_PERFORMANCE_H_
#define _ISO_ADAPTIVE_CRUISE_CONTROL_PERFORMANCE_H_

#include <math_type.h>

namespace iso {

struct AdaptiveCruiseControlPerformance final
{
    bool isSuccessfulTimeGap;
    math::real_t timeGap;
};

} // namespace iso {

#endif // #ifndef _ISO_ADAPTIVE_CRUISE_CONTROL_PERFORMANCE_H_
