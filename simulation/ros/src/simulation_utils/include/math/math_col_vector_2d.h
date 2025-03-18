#ifndef _MATH_COL_VECTOR_2D_H_
#define _MATH_COL_VECTOR_2D_H_

#include "math_def.h"
#include <iostream>
#include "Eigen/Dense"

namespace math {

template<typename Scalar>
class ColVector2d : public Eigen::Matrix<Scalar, 2, 1>
{
    using Base_t = Eigen::Matrix<Scalar, 2, 1>;

public:

    typedef typename Base_t::RealScalar RealScalar;

    static constexpr int32_t dof_num()
    {return int32_t{2};}

    ColVector2d();
    explicit ColVector2d(
            const Scalar &coord_x,
            const Scalar &coord_y
            );
    explicit ColVector2d(const Scalar *coord_xy);
    template<typename OtherDerived>
    ColVector2d(const Eigen::MatrixBase<OtherDerived> &other);
    virtual ~ColVector2d();

    template<typename OtherDerived>
    ColVector2d &operator=(const Eigen::MatrixBase<OtherDerived> &other);

    void set_x(const Scalar &coord_x);
    void set_y(const Scalar &coord_y);
    void set_xy(const Scalar &coord_x, const Scalar &coord_y);
    void set_xy(const Scalar *coord_xy);

protected:

private:

};

} // namespace math {

namespace math {

// public func.

template<typename Scalar>
ColVector2d<Scalar>::ColVector2d()
    :Base_t(Base_t::Zero())
{
}

template<typename Scalar>
ColVector2d<Scalar>::ColVector2d(
        const Scalar &coord_x,
        const Scalar &coord_y
        )
    :Base_t((Base_t() << coord_x, coord_y).finished())
{
}

template<typename Scalar>
ColVector2d<Scalar>::ColVector2d(const Scalar *coord_xy)
    :Base_t((Base_t() << coord_xy[0], coord_xy[1]).finished())
{
}

template<typename Scalar>
template<typename OtherDerived>
ColVector2d<Scalar>::ColVector2d(const Eigen::MatrixBase<OtherDerived> &other)
    :Base_t(other)
{
}

template<typename Scalar>
template<typename OtherDerived>
ColVector2d<Scalar> &ColVector2d<Scalar>::operator=(const Eigen::MatrixBase<OtherDerived> &other)
{
    this->Base_t::operator=(other);
    return *this;
}

template<typename Scalar>
ColVector2d<Scalar>::~ColVector2d()
{
}

template<typename Scalar>
void ColVector2d<Scalar>::set_x(const Scalar &coord_x)
{
    Base_t::x() = coord_x;
}

template<typename Scalar>
void ColVector2d<Scalar>::set_y(const Scalar &coord_y)
{
    Base_t::y() = coord_y;
}

template<typename Scalar>
void ColVector2d<Scalar>::set_xy(const Scalar &coord_x, const Scalar &coord_y)
{
    (*this) << coord_x, coord_y;
}

template<typename Scalar>
void ColVector2d<Scalar>::set_xy(const Scalar *coord_xy)
{
    (*this) << coord_xy[0], coord_xy[1];
}

// protected func.

// private func.

// non-member func.

template<typename charT, typename traits, typename Scalar>
std::basic_ostream<charT, traits> &operator<<(
        std::basic_ostream<charT, traits> &ostream,
        const ColVector2d<Scalar> &col_vector2d
        )
{
    ostream << col_vector2d.x() << ", "
        << col_vector2d.y();

    return ostream;
}

} // namespace math {

#endif // #ifndef _MATH_COL_VECTOR_2D_H_
