#ifndef _GEOMETRY_RECT_H_
#define _GEOMETRY_RECT_H_

#include <math_type.h>

namespace geometry {

template<typename VectorType>
struct Rect final
{
    VectorType topLeft;
    VectorType topRight;
    VectorType bottomLeft;
    VectorType bottomRight;

    Rect()
        : topLeft{}
        , topRight{}
        , bottomLeft{}
        , bottomRight{}
    {
    }
    explicit Rect(
        const VectorType &inputTopLeft,
        const VectorType &inputTopRight,
        const VectorType &inputBottomLeft,
        const VectorType &inputBottomRight)
        : topLeft{inputTopLeft}
        , topRight{inputTopRight}
        , bottomLeft{inputBottomLeft}
        , bottomRight{inputBottomRight}
    {
    }
    Rect(const Rect &) = default;
    Rect &operator=(const Rect &) = default;
    ~Rect() = default;
};

template<typename charT, typename traits, typename VectorType>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const Rect<VectorType> &rect)
{
    ostream << "topLeft: " << rect.topLeft.transpose() << ", "
        << "bottomLeft: " << rect.bottomLeft.transpose() << ", "
        << "bottomRight: " << rect.bottomRight.transpose() << ", "
        << "topRight: " << rect.topRight.transpose();
    return ostream;
}

} // namespace geometry {

#endif // #ifndef _GEOMETRY_RECT_H_
