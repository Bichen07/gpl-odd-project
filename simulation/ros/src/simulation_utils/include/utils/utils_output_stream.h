#ifndef _UTILS_OUTPUT_STREAM_H_
#define _UTILS_OUTPUT_STREAM_H_

#include <tf/transform_listener.h>

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const tf::Vector3 &vector3)
{
    ostream << vector3.x() << ", " << vector3.y() << ", " << vector3.z();
    return ostream;
}

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const tf::Matrix3x3 &matrix)
{
    ostream << matrix.getRow(0) << '\n'
        << matrix.getRow(1) << '\n'
        << matrix.getRow(2);
    return ostream;
}

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const tf::Transform &transform)
{
    ostream << "Basis: " << '\n'
        << transform.getBasis() << '\n'
        << "Origin: " << transform.getOrigin();
    return ostream;
}

#endif // #ifndef _UTILS_OUTPUT_STREAM_H_
