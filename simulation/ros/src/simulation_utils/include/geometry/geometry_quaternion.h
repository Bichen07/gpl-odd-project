#ifndef _GEOMETRY_QUATERNION_H_
#define _GEOMETRY_QUATERNION_H_

#include <Eigen/Geometry>
#include <geometry_msgs/Quaternion.h>

namespace geometry {

class Quaternion : public Eigen::Quaternion<double, Eigen::DontAlign>
{
    using Base = Eigen::Quaternion<double, Eigen::DontAlign>;

public:

    Quaternion();
    Quaternion(const Base &base);
    explicit Quaternion(
        const double inputW,
        const double inputX,
        const double inputY,
        const double inputZ);
    explicit Quaternion(const geometry_msgs::Quaternion &input);
    template<typename OtherDerived>
    Quaternion(const Eigen::MatrixBase<OtherDerived> &other);
    template<typename OtherDerived>
    Quaternion &operator=(const Eigen::MatrixBase<OtherDerived> &other);
    virtual ~Quaternion() = default;

    geometry_msgs::Quaternion ToGeometryMsgsQuaternion() const;

protected:

private:

};

} // namespace geometry {

namespace geometry {

template<typename OtherDerived>
Quaternion::Quaternion(const Eigen::MatrixBase<OtherDerived> &other)
    : Base(other)
{
}

template<typename OtherDerived>
Quaternion &Quaternion::operator=(const Eigen::MatrixBase<OtherDerived> &other)
{
    this->Base::operator=(other);
    return *this;
}

} // namespace geometry {

#endif // #ifndef _GEOMETRY_QUATERNION_H_
