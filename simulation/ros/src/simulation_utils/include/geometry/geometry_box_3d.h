#ifndef _GEOMETRY_BOX_3D_H_
#define _GEOMETRY_BOX_3D_H_

#include <math_type.h>

namespace geometry {

struct Box3d final
{
    math::Vector3d_t minCorner;
    math::Vector3d_t maxCorner;

    Box3d()
        : minCorner{}
        , maxCorner{}
    {
    }
    explicit Box3d(
        const math::Vector3d_t &inputMinCorner,
        const math::Vector3d_t &inputMaxCorner)
        : minCorner{inputMinCorner}
        , maxCorner{inputMaxCorner}
    {
    }
    Box3d(const Box3d &other) = default;
    Box3d &operator=(const Box3d &other) = default;
    ~Box3d() = default;
};

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const Box3d &box3d)
{
    ostream << "minCorner: " << box3d.minCorner.transpose() << '\n' <<
        "maxCorner: " << box3d.maxCorner.transpose();
    return ostream;
}

} // namespace geometry {

#endif // #ifndef _GEOMETRY_BOX_3D_H_
