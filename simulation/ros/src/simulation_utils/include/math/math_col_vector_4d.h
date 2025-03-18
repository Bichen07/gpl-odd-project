#ifndef _MATH_COL_VECTOR_4D_H_
#define _MATH_COL_VECTOR_4D_H_

#include "math_def.h"
#include "Eigen/Dense"

namespace math {

template<typename Scalar>
class ColVector4d : public Eigen::Matrix<Scalar, 4, 1>
{
    using Base_t = Eigen::Matrix<Scalar, 4, 1>;

public:

    typedef typename Base_t::RealScalar RealScalar;

    static constexpr int32_t dof_num()
    {return int32_t{4};}

    ColVector4d();
    explicit ColVector4d(
            const Scalar &x, // r
            const Scalar &y, // g
            const Scalar &z, // b
            const Scalar &w  // a
            );
    template<typename OtherDerived>
        ColVector4d(const Eigen::MatrixBase<OtherDerived> &other);
    template<typename OtherDerived>
        ColVector4d &operator=(const Eigen::MatrixBase<OtherDerived> &other);
    virtual ~ColVector4d();

    void set_x(const Scalar &x);
    void set_y(const Scalar &y);
    void set_z(const Scalar &z);
    void set_w(const Scalar &w);
    void set_xyzw(const Scalar &x, const Scalar &y, const Scalar &z, const Scalar &w);

    void set_r(const Scalar &x);
    void set_g(const Scalar &y);
    void set_b(const Scalar &z);
    void set_a(const Scalar &w);
    void set_rgba(const Scalar &x, const Scalar &y, const Scalar &z, const Scalar &w);

protected:

private:

};

} // namespace math {

namespace math {

// public func.

template<typename Scalar>
ColVector4d<Scalar>::ColVector4d()
    :Base_t(Base_t::Zero())
{
}

template<typename Scalar>
ColVector4d<Scalar>::ColVector4d(
        const Scalar &x,
        const Scalar &y,
        const Scalar &z,
        const Scalar &w
        )
    :Base_t((Base_t() << x, y, z, w).finished())
{
}

template<typename Scalar>
template<typename OtherDerived>
ColVector4d<Scalar>::ColVector4d(const Eigen::MatrixBase<OtherDerived> &other)
    :Base_t(other)
{
}

template<typename Scalar>
template<typename OtherDerived>
ColVector4d<Scalar> &ColVector4d<Scalar>::operator=(const Eigen::MatrixBase<OtherDerived> &other)
{
    this->Base_t::operator=(other);
    return *this;
}

template<typename Scalar>
ColVector4d<Scalar>::~ColVector4d()
{
}

template<typename Scalar>
void ColVector4d<Scalar>::set_x(const Scalar &x)
{
    Base_t::x() = x;
}

template<typename Scalar>
void ColVector4d<Scalar>::set_y(const Scalar &y)
{
    Base_t::y() = y;
}

template<typename Scalar>
void ColVector4d<Scalar>::set_z(const Scalar &z)
{
    Base_t::z() = z;
}

template<typename Scalar>
void ColVector4d<Scalar>::set_w(const Scalar &w)
{
    Base_t::w() = w;
}

template<typename Scalar>
void ColVector4d<Scalar>::set_xyzw(const Scalar &x, const Scalar &y, const Scalar &z, const Scalar &w)
{
    (*this) << x, y, z, w;
}

template<typename Scalar>
void ColVector4d<Scalar>::set_r(const Scalar &r)
{
    Base_t::x() = r;
}

template<typename Scalar>
void ColVector4d<Scalar>::set_g(const Scalar &g)
{
    Base_t::y() = g;
}

template<typename Scalar>
void ColVector4d<Scalar>::set_b(const Scalar &b)
{
    Base_t::z() = b;
}

template<typename Scalar>
void ColVector4d<Scalar>::set_a(const Scalar &a)
{
    Base_t::w() = a;
}

template<typename Scalar>
void ColVector4d<Scalar>::set_rgba(const Scalar &r, const Scalar &g, const Scalar &b, const Scalar &a)
{
    (*this) << r, g, b, a;
}

// protected func.

// private func.

} // namespace math {

#endif // #ifndef _MATH_COL_VECTOR_4D_H_
