#ifndef _GEOMETRY_VECTOR_3D_H_
#define _GEOMETRY_VECTOR_3D_H_

#include <math_col_vector_3d.h>
#include <geometry_msgs/Vector3.h>
#include <geometry_msgs/Point32.h>
#include <geometry_msgs/Point.h>
#include <geometry_vector_2d.h>

namespace geometry {

class Vector3d : public math::ColVector3d<double>
{
    using Base = math::ColVector3d<double>;

public:

    static std::vector<Vector2d> ToVectorXys(
        const std::vector<Vector3d> &vector3ds);

    Vector3d();
    explicit Vector3d(
        const double inputX,
        const double inputY,
        const double inputZ);
    explicit Vector3d(const geometry_msgs::Vector3 &vector3);
    explicit Vector3d(const geometry_msgs::Point32 &point32);
    explicit Vector3d(const geometry_msgs::Point &point);
    template<typename OtherDerived>
    Vector3d(const Eigen::MatrixBase<OtherDerived> &other);
    template<typename OtherDerived>
    Vector3d &operator=(const Eigen::MatrixBase<OtherDerived> &other);
    Vector3d &operator=(const geometry_msgs::Vector3 &vector3);
    Vector3d &operator=(const geometry_msgs::Point32 &point32);
    Vector3d &operator=(const geometry_msgs::Point &point);
    virtual ~Vector3d() = default;

    geometry_msgs::Vector3 ToVector3() const;
    geometry_msgs::Point32 ToPoint32() const;
    geometry_msgs::Point ToPoint() const;

    template<typename OutputVectorType>
    OutputVectorType ToGeometryMsgsVector() const;

    Vector2d ToVectorXy() const;

protected:

private:

};

template<typename OutputVectorType>
void ToGeometryMsgsArray(
    const std::vector<Vector3d> &input,
    std::vector<OutputVectorType> &output);

} // namespace geometry {

namespace geometry {

template<typename OtherDerived>
Vector3d::Vector3d(const Eigen::MatrixBase<OtherDerived> &other)
    : Base(other)
{
}

template<typename OtherDerived>
Vector3d &Vector3d::operator=(const Eigen::MatrixBase<OtherDerived> &other)
{
    this->Base::operator=(other);
    return *this;
}

} // namespace geometry {

#endif // #ifndef _GEOMETRY_VECTOR_3D_H_
