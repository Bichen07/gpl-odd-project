#ifndef _MATH_SPATIAL_VECTOR_H_
#define _MATH_SPATIAL_VECTOR_H_

#include "math_def.h"
#include <iostream>
#include "Eigen/Dense"
#include "math_col_vector_3d.h"

namespace math {

template<typename Scalar> class ColVector3d;

template<typename Scalar>
class SpatialVector final : public Eigen::Matrix<Scalar, 6, 1>
{

    typedef Eigen::Matrix<Scalar, 6, 1> Base_t;

public:

    typedef typename Base_t::RealScalar RealScalar;
    typedef ColVector3d<Scalar> Vector3d_t;

    SpatialVector();
    explicit SpatialVector(
            const Vector3d_t &angular_vector,
            const Vector3d_t &linear_vector
            );
    template<typename OtherDerived>
    SpatialVector(const Eigen::MatrixBase<OtherDerived> &other);
    virtual ~SpatialVector();

    template<typename OtherDerived>
    SpatialVector &operator=(const Eigen::MatrixBase<OtherDerived> &other);
    /**
     * \brief
     * \return
     */
    Vector3d_t angular_vector() const;
    /**
     * \brief
     * \return
     */
    Vector3d_t linear_vector() const;
    /**
     * \brief
     * \param[in]
     */
    void set_angular_vector(const Vector3d_t &angular_vector);
    /**
     * \brief
     * \param[in]
     */
    void set_linear_vector(const Vector3d_t &linear_vector);

protected:

private:

};

} // namespace math {

namespace math {

// public func.

template<typename Scalar>
SpatialVector<Scalar>::SpatialVector()
    :Base_t(Base_t::Zero())
{
}

template<typename Scalar>
SpatialVector<Scalar>::SpatialVector(
        const typename SpatialVector<Scalar>::Vector3d_t &angular_vector,
        const typename SpatialVector<Scalar>::Vector3d_t &linear_vector
        )
    :Base_t((Base_t() << angular_vector, linear_vector).finished())
{
}

template<typename Scalar>
    template<typename OtherDerived>
SpatialVector<Scalar>::SpatialVector(const Eigen::MatrixBase<OtherDerived> &other)
    :Base_t(other)
{
}

template<typename Scalar>
    template<typename OtherDerived>
SpatialVector<Scalar> &SpatialVector<Scalar>::operator=(
        const Eigen::MatrixBase<OtherDerived> &other
        )
{
    this->Base_t::operator=(other);
    return *this;
}

template<typename Scalar>
SpatialVector<Scalar>::~SpatialVector()
{
}

template<typename Scalar>
typename SpatialVector<Scalar>::Vector3d_t SpatialVector<Scalar>::angular_vector() const
{
    return this->topRows(3);
}

template<typename Scalar>
typename SpatialVector<Scalar>::Vector3d_t SpatialVector<Scalar>::linear_vector() const
{
    return this->bottomRows(3);
}

template<typename Scalar>
void SpatialVector<Scalar>::set_angular_vector(const Vector3d_t &angular_vector)
{
    this->topRows(3) = angular_vector;
}

template<typename Scalar>
void SpatialVector<Scalar>::set_linear_vector(const Vector3d_t &linear_vector)
{
    this->bottomRows(3) = linear_vector;
}

// protected func.

// private func.

// non-member func.

template<typename charT, typename traits, typename Scalar>
std::basic_ostream<charT, traits> &operator<<(
        std::basic_ostream<charT, traits> &ostream,
        const SpatialVector<Scalar> &spatial_vector
        )
{
    ostream << "angular: "
        << spatial_vector.angular_vector()
        << ", linear: "
        << spatial_vector.linear_vector();

    return ostream;
}

} // namespace math {

#endif // #ifndef _MATH_SPATIAL_VECTOR_H_
