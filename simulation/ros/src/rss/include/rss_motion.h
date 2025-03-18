#ifndef _RSS_MOTION_H_
#define _RSS_MOTION_H_

#include <math_type.h>

namespace rss {

math::real_t ComputeHeadingRadian(const math::Vector3d_t &velocity);

} // namespace rss {

#endif // #ifndef _RSS_MOTION_H_
