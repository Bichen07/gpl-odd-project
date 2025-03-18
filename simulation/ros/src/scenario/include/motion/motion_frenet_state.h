#ifndef _MOTION_FRENET_STATE_H_
#define _MOTION_FRENET_STATE_H_

#include <math_frenet_coord.h>

namespace motion {

struct FrenetState final
{
    int32_t idx;
    math::FrenetCoord position;
    math::FrenetCoord velocity;

    FrenetState()
        : idx{0}
        , position{}
        , velocity{}
    {
    }
    explicit FrenetState(
        const int32_t inputIdx,
        const math::FrenetCoord &inputPosition,
        const math::FrenetCoord &inputVelocity)
        : idx{inputIdx}
        , position(inputPosition)
        , velocity(inputVelocity)
    {
    }
    FrenetState(const FrenetState &other) = default;
    FrenetState &operator=(const FrenetState &other) = default;
    ~FrenetState() = default;
};

} // namespace motion {

#endif // #ifndef _MOTION_FRENET_STATE_H_
