#include <rss_motion.h>
#include <math_utils.h>

namespace rss {

math::real_t ComputeHeadingRadian(const math::Vector3d_t &velocity)
{
    math::real_t headingRadian{0.0};
    if (!math::IsApproxZero(velocity, math::real_t{1.0e-6}))
    {
        headingRadian = atan2(velocity.y(), velocity.x());
    }

    return headingRadian;
    //math::real_t lastHeadingRadian{0.0};
    //if (!math::IsApproxZero(lastState.linearVelocity, 1.0e-6))
    //{
    //    lastHeadingRadian = atan2(lastState.linearVelocity.y(), lastState.linearVelocity.x());
    //}
}

} // namespace rss {
