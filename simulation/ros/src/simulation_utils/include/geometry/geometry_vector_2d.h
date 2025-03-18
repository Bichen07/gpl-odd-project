#ifndef _GEOMETRY_VECTOR_2D_H_
#define _GEOMETRY_VECTOR_2D_H_

#include <math_col_vector_2d.h>
#include <geometry_msgs/Vector3.h>
#include <geometry_msgs/Point32.h>
#include <geometry_msgs/Point.h>

namespace geometry {

class Vector2d : public math::ColVector2d<double>
{
    using Base = math::ColVector2d<double>;

public:

    Vector2d();
    Vector2d(const double  inputX, const double inputY);
    template<typename OtherDerived>
    Vector2d(const Eigen::MatrixBase<OtherDerived> &other);
    template<typename OtherDerived>
    Vector2d &operator=(const Eigen::MatrixBase<OtherDerived> &other);
    virtual ~Vector2d() = default;

    geometry_msgs::Vector3 ToVector3(const double z = double{0.0}) const;
    geometry_msgs::Point32 ToPoint32(const float z = float{0.0f}) const;
    geometry_msgs::Point ToPoint(const double z = double{0.0}) const;

protected:

private:

};

} // namespace geometry {

namespace geometry {

template<typename OtherDerived>
Vector2d::Vector2d(const Eigen::MatrixBase<OtherDerived> &other)
    : Base(other)
{
}

template<typename OtherDerived>
Vector2d &Vector2d::operator=(const Eigen::MatrixBase<OtherDerived> &other)
{
    this->Base::operator=(other);
    return *this;
}

} // namespace geometry {

#endif // #ifndef _GEOMETRY_VECTOR_2D_H_
