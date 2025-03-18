#ifndef _GEOMETRY_BOX_H_
#define _GEOMETRY_BOX_H_

#include <iostream>

namespace geometry {

template<typename VectorType>
struct Box final
{
    VectorType minCorner;
    VectorType maxCorner;

    Box()
        : minCorner{}
        , maxCorner{}
    {
    }
    explicit Box(
        const VectorType &inputMinCorner,
        const VectorType &inputMaxCorner)
        : minCorner{inputMinCorner}
        , maxCorner{inputMaxCorner}
    {
    }
    Box(const Box &other) = default;
    Box &operator=(const Box &other) = default;
    ~Box() = default;
};

template<typename charT, typename traits, typename VectorType>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const Box<VectorType> &box)
{
    ostream << "[Box]" << '\n' <<
        "minCorner: " << box.minCorner.transpose() << '\n' <<
        "maxCorner: " << box.maxCorner.transpose();
    return ostream;
}

} // namespace geometry {

#endif // #ifndef _GEOMETRY_BOX_H_
