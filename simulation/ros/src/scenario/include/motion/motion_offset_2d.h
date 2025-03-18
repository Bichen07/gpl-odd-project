#ifndef _MOTION_OFFSET_2D_H_
#define _MOTION_OFFSET_2D_H_

#include <math_frenet_coord.h>

namespace motion {

struct Offset2d final
{
    math::FrenetCoord position;
    math::real_t orientation;

    Offset2d()
        : position{}
        , orientation{0.0}
    {
    }
    explicit Offset2d(
        const math::FrenetCoord &inputPosition,
        const math::real_t inputOrientation)
        : position{inputPosition}
        , orientation{inputOrientation}
    {
    }
    Offset2d(const Offset2d &other) = default;
    Offset2d &operator=(const Offset2d &other) = default;
    ~Offset2d() = default;
};

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const Offset2d &offset2d)
{
    ostream << "[motion::Offset2d]" << '\n' <<
        "position: " << offset2d.position <<
        ", orientation: " << offset2d.orientation;
    return ostream;
}

} // namespace motion {

#endif // #ifndef _MOTION_OFFSET_2D_H_
