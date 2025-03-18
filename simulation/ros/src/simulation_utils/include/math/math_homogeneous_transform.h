#ifndef _MATH_HOMOGENEOUS_TRANSFORM_H_
#define _MATH_HOMOGENEOUS_TRANSFORM_H_

#include "math_def.h"
#include "Eigen/Dense"
#include "Eigen/Geometry"

namespace math {

template<typename Scalar, int32_t Dim>
class HomogeneousTransform : public Eigen::Transform<Scalar, Dim, Eigen::Isometry>
{
    typedef Eigen::Transform<Scalar, Dim, Eigen::Isometry> Base_t;

public:

    typedef typename Base_t::Scalar RealScalar;
    typedef Eigen::Matrix<Scalar, Dim, Dim> RotMat_t;
    typedef Eigen::Matrix<Scalar, Dim, 1> Vector_t;

    static HomogeneousTransform Identity();

    HomogeneousTransform();
    explicit HomogeneousTransform(const RotMat_t &rot_mat, const Vector_t &xlt);
    explicit HomogeneousTransform(const RotMat_t &rot_mat);
    explicit HomogeneousTransform(const Vector_t &xlt);
    HomogeneousTransform(const Base_t &base);
    HomogeneousTransform(const HomogeneousTransform &other);
    HomogeneousTransform &operator=(const HomogeneousTransform &other);
    virtual ~HomogeneousTransform();

protected:

private:

};

} // namespace math {

namespace math {

template<typename Scalar, int32_t Dim>
HomogeneousTransform<Scalar, Dim> HomogeneousTransform<Scalar, Dim>::Identity()
{
    return HomogeneousTransform<Scalar, Dim>();
}

template<typename Scalar, int32_t Dim>
HomogeneousTransform<Scalar, Dim>::HomogeneousTransform()
    :Base_t(Base_t::Identity())
{
}

template<typename Scalar, int32_t Dim>
HomogeneousTransform<Scalar, Dim>::HomogeneousTransform(const RotMat_t &rot_mat, const Vector_t &xlt)
    :Base_t(Base_t::Identity())
{
    this->linear() = rot_mat;
    this->translation() = xlt;
}

template<typename Scalar, int32_t Dim>
HomogeneousTransform<Scalar, Dim>::HomogeneousTransform(const RotMat_t &rot_mat)
    :Base_t(Base_t::Identity())
{
    this->linear() = rot_mat;
}

template<typename Scalar, int32_t Dim>
HomogeneousTransform<Scalar, Dim>::HomogeneousTransform(const Vector_t &xlt)
    :Base_t(Base_t::Identity())
{
    this->translation() = xlt;
}

template<typename Scalar, int32_t Dim>
HomogeneousTransform<Scalar, Dim>::HomogeneousTransform(const HomogeneousTransform<Scalar, Dim>::Base_t &base)
    :Base_t(base)
{
}

template<typename Scalar, int32_t Dim>
HomogeneousTransform<Scalar, Dim>::HomogeneousTransform(const HomogeneousTransform &other)
    :Base_t(other)
{
}

template<typename Scalar, int32_t Dim>
HomogeneousTransform<Scalar, Dim> &HomogeneousTransform<Scalar, Dim>::operator=(const HomogeneousTransform &other)
{
    if (&other == this)
    {
        return *this;
    }

    this->linear() = other.linear();
    this->translation() = other.translation();

    return *this;
}

template<typename Scalar, int32_t Dim>
HomogeneousTransform<Scalar, Dim>::~HomogeneousTransform()
{
}

} // namespace math {

namespace Eigen {

template<typename charT, typename traits, typename Scalar, int32_t Dim>
std::basic_ostream<charT, traits> &operator<<(
        std::basic_ostream<charT, traits> &ostream,
        const Transform<Scalar, Dim, Isometry> &isometry
        )
{
    static constexpr char kNewLine = '\n';
    ostream << "linear" << kNewLine
        << isometry.linear() << kNewLine
        << "translation: "
        << isometry.translation().transpose();

    return ostream;
}

}

#endif // #ifndef _MATH_HOMOGENEOUS_TRANSFORM_H_
