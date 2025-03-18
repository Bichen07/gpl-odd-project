#ifndef _MATH_COL_VECTOR_3D_H_
#define _MATH_COL_VECTOR_3D_H_

#include "math_def.h"
#include <array>
#include <iostream>
#include "Eigen/Dense"

namespace math {

template<typename Scalar>
class ColVector3d : public Eigen::Matrix<Scalar, 3, 1>
{
    using Base_t = Eigen::Matrix<Scalar, 3, 1>;

public:

    typedef typename Base_t::RealScalar RealScalar;

    static constexpr int32_t dof_num()
    {return int32_t{3};}

    ColVector3d();
    explicit ColVector3d(
            const Scalar &coord_x,
            const Scalar &coord_y,
            const Scalar &coord_z
            );
    explicit ColVector3d(const Scalar *coord_xyz);
    ColVector3d(const std::array<Scalar, 3> &coord_xyz);
    /**
     * This constructor allows you to construct ColVector3d from Eigen
     * expressions
     */
    template<typename OtherDerived>
    ColVector3d(const Eigen::MatrixBase<OtherDerived> &other);
    virtual ~ColVector3d();

    /**
     * This method allows you to assign Eigen expressions to ColVector3d
     */
    template<typename OtherDerived>
    ColVector3d &operator=(const Eigen::MatrixBase<OtherDerived> &other);

    void set_x(const Scalar &coord_x);
    void set_y(const Scalar &coord_y);
    void set_z(const Scalar &coord_z);
    void set_xyz(const Scalar &coord_x, const Scalar &coord_y, const Scalar &coord_z);
    void set_xyz(const Scalar *coord_xyz);

    ColVector3d<Scalar> ProjectToXyPlane() const;
    ColVector3d<Scalar> ProjectToYzPlane() const;
    ColVector3d<Scalar> ProjectToXzPlane() const;

    ColVector3d<Scalar> ProjectToXyPlane(const Scalar &plane_height) const;
    ColVector3d<Scalar> ProjectToYzPlane(const Scalar &plane_height) const;
    ColVector3d<Scalar> ProjectToXzPlane(const Scalar &plane_height) const;

protected:

private:

};

// template<typename Scalar,
//     template<typename ELEM, typename ALLOC = std::allocator<ELEM>> class Coll_t = std::vector>
// Coll_t<ColVector3d<Scalar>> operator-(
//         const Coll_t<ColVector3d<Scalar>> &coll_1st,
//         const Coll_t<ColVector3d<Scalar>> &coll_2nd
//         );
// template<typename Scalar,
//     template<typename ELEM, typename ALLOC = std::allocator<ELEM>> class Coll_t = std::vector
//     >
// Coll_t<ColVector3d<Scalar>> operator*(
//         const Coll_t<ColVector3d<Scalar>> &col_vector3d_coll,
//         const Scalar &scale
//         );

} // namespace math {

namespace math {

// public func.

template<typename Scalar>
ColVector3d<Scalar>::ColVector3d()
    :Base_t(Base_t::Zero())
{
}

template<typename Scalar>
ColVector3d<Scalar>::ColVector3d(
        const Scalar &coord_x,
        const Scalar &coord_y,
        const Scalar &coord_z
        )
    :Base_t((Base_t() << coord_x, coord_y, coord_z).finished())
{
}

template<typename Scalar>
ColVector3d<Scalar>::ColVector3d(const Scalar *coord_xyz)
    :Base_t((Base_t() << coord_xyz[0], coord_xyz[1], coord_xyz[2]).finished())
{
}

template<typename Scalar>
ColVector3d<Scalar>::ColVector3d(const std::array<Scalar, 3> &coord_xyz)
    :Base_t((Base_t() << coord_xyz[0], coord_xyz[1], coord_xyz[2]).finished())
{
}

template<typename Scalar>
template<typename OtherDerived>
ColVector3d<Scalar>::ColVector3d(const Eigen::MatrixBase<OtherDerived> &other)
    :Base_t(other)
{
}

template<typename Scalar>
template<typename OtherDerived>
ColVector3d<Scalar> &ColVector3d<Scalar>::operator=(const Eigen::MatrixBase<OtherDerived> &other)
{
    this->Base_t::operator=(other);
    return *this;
}

template<typename Scalar>
ColVector3d<Scalar>::~ColVector3d()
{
}

template<typename Scalar>
void ColVector3d<Scalar>::set_x(const Scalar &coord_x)
{
    Base_t::x() = coord_x;
}

template<typename Scalar>
void ColVector3d<Scalar>::set_y(const Scalar &coord_y)
{
    Base_t::y() = coord_y;
}

template<typename Scalar>
void ColVector3d<Scalar>::set_z(const Scalar &coord_z)
{
    Base_t::z() = coord_z;
}

template<typename Scalar>
void ColVector3d<Scalar>::set_xyz(const Scalar &coord_x, const Scalar &coord_y, const Scalar &coord_z)
{
    (*this) << coord_x, coord_y, coord_z;
}

template<typename Scalar>
void ColVector3d<Scalar>::set_xyz(const Scalar *coord_xyz)
{
    (*this) << coord_xyz[0], coord_xyz[1], coord_xyz[2];
}

template<typename Scalar>
ColVector3d<Scalar> ColVector3d<Scalar>::ProjectToXyPlane() const
{
    return this->ProjectToXyPlane(Scalar{0.0});
}

template<typename Scalar>
ColVector3d<Scalar> ColVector3d<Scalar>::ProjectToYzPlane() const
{
    return this->ProjectToYzPlane(Scalar{0.0});
}

template<typename Scalar>
ColVector3d<Scalar> ColVector3d<Scalar>::ProjectToXzPlane() const
{
    return this->ProjectToXzPlane(Scalar{0.0});
}

template<typename Scalar>
ColVector3d<Scalar> ColVector3d<Scalar>::ProjectToXyPlane(const Scalar &plane_height) const
{
    return ColVector3d<Scalar>(
            this->x(),
            this->y(),
            plane_height
            );
}

template<typename Scalar>
ColVector3d<Scalar> ColVector3d<Scalar>::ProjectToYzPlane(const Scalar &plane_height) const
{
    return ColVector3d<Scalar>(
            plane_height,
            this->y(),
            this->z()
            );
}

template<typename Scalar>
ColVector3d<Scalar> ColVector3d<Scalar>::ProjectToXzPlane(const Scalar &plane_height) const
{
    return ColVector3d<Scalar>(
            this->x(),
            plane_height,
            this->z()
            );
}

// protected func.

// private func.

// non-member func.

template<typename charT, typename traits, typename Scalar>
std::basic_ostream<charT, traits> &operator<<(
        std::basic_ostream<charT, traits> &ostream,
        const ColVector3d<Scalar> &col_vector3d
        )
{
    ostream << col_vector3d.x() << ", "
        << col_vector3d.y() << ", "
        << col_vector3d.z();

    return ostream;
}

// template<typename Scalar,
//     template<typename ELEM, typename ALLOC = std::allocator<ELEM>> class Coll_t
//     >
// Coll_t<ColVector3d<Scalar>> operator-(
//         const Coll_t<ColVector3d<Scalar>> &coll_1st,
//         const Coll_t<ColVector3d<Scalar>> &coll_2nd
//         )
// {
//     MATH_ASSERT(
//             coll_1st.size() == coll_2nd.size(),
//             "Unmatched coll size"
//             );

//     Coll_t<ColVector3d<Scalar>> diff_coll;
//     diff_coll.reserve(coll_1st.size());
//     std::transform(
//             coll_1st.begin(),
//             coll_1st.end(),
//             coll_2nd.begin(),
//             std::back_inserter(diff_coll),
//             [&](const ColVector3d<Scalar> &a_kVec1st, const ColVector3d<Scalar> &a_kVec2nd)
//             {return a_kVec1st - a_kVec2nd;}
//             );

//     //using namespace boost;
//     //Coll_t<ColVector3d<Scalar>> diff_coll2;
//     //diff_coll2.reserve(coll_1st.size());
//     //std::transform(
//     //        coll_1st.begin(),
//     //        coll_1st.end(),
//     //        coll_2nd.begin(),
//     //        std::back_inserter(diff_coll2),
//     //        lambda::ret<ColVector3d<Scalar>>(lambda::_1 - lambda::_2)
//     //        );

//     return diff_coll;
// }

// template<typename Scalar,
//     template<typename ELEM, typename ALLOC = std::allocator<ELEM>> class Coll_t
//     >
// Coll_t<ColVector3d<Scalar>> operator*(
//         const Coll_t<ColVector3d<Scalar>> &col_vector3d_coll,
//         const Scalar &scale
//         )
// {
//     Coll_t<ColVector3d<Scalar>> scale_coll;
//     scale_coll.reserve(col_vector3d_coll.size());
//     std::transform(
//             col_vector3d_coll.begin(),
//             col_vector3d_coll.end(),
//             std::back_inserter(scale_coll),
//             [&](const ColVector3d<Scalar> &a_kVec)
//             {return a_kVec * scale;}
//             );

//     return scale_coll;
// }

} // namespace math {

#endif // #ifndef _MATH_COL_VECTOR_3D_H_
