#ifndef _MATH_TYPE_H_
#define _MATH_TYPE_H_

#include "math_def.h"
#include <cmath>
#include <vector>
#include <string>
#include <utility>
#include <type_traits>
#include <iostream>
#include "Eigen/Geometry"
#include "Eigen/Sparse"
#include "math_coord.h"
#include "math_col_vector_2d.h"
#include "math_col_vector_3d.h"
#include "math_col_vector_4d.h"
#include "math_spatial_vector.h"
#include "math_spatial_transform.h"
#include "math_homogeneous_transform.h"
#include "math_epsilon_precision.h"

typedef enum class Dof2d: int32_t
{
    X = 0, // = 0
    Y,     // = 1
    Num,   // = 2
    Null = Num,
} Dof2dIdx_t;

typedef enum class Dof3d: int32_t
{
    X = 0, // = 0
    Y,     // = 1
    Z,     // = 2
    Num,   // = 3
    Null = Num,
} Dof3dIdx_t;

typedef enum class Dof6d: int32_t
{
    RotX = 0, // = 0, ///< Rotation around x-axis
    RotY,     // = 1, ///< Rotation around y-axis
    RotZ,     // = 2, ///< Rotation around z-axis
    XltX,     // = 3, ///< Translation in x-direction
    XltY,     // = 4, ///< Translation in y-direction
    XltZ,     // = 5, ///< Translation in z-direction
    Num,      // = 6
    Null = Num,
} Dof6dIdx_t;

typedef std::vector<Dof2dIdx_t> Dof2dIdxColl_t;
typedef std::vector<Dof3dIdx_t> Dof3dIdxColl_t;
typedef std::vector<Dof6dIdx_t> Dof6dIdxColl_t;

constexpr typename std::underlying_type<Dof2dIdx_t>::type operator*(const Dof2dIdx_t &dof2d_idx)
{
    return static_cast<typename std::underlying_type<Dof2dIdx_t>::type>(dof2d_idx);
}
constexpr typename std::underlying_type<Dof3dIdx_t>::type operator*(const Dof3dIdx_t &dof3d_idx)
{
    return static_cast<typename std::underlying_type<Dof3dIdx_t>::type>(dof3d_idx);
}
constexpr typename std::underlying_type<Dof6dIdx_t>::type operator*(const Dof6dIdx_t &dof6d_idx)
{
    return static_cast<typename std::underlying_type<Dof6dIdx_t>::type>(dof6d_idx);
}

namespace math {

typedef enum class AngleOrder: int32_t
{
    Xyz = 0,
    Zyx,
    Yzx,
    Xzy,
    Yxz,
    Zxy,
    Num,
    Null = Num,
} AngleOrder_t;

typedef enum class Plane: int32_t
{
    Xy = 0,
    Yz,
    Xz,
    Num,
    Null = Num,
} PlaneCoord_t;

typedef enum class QuaternionCoef: int32_t
{
    W = 0,
    X,
    Y,
    Z,
} QuaternionCoefIdx_t;

typedef enum class AxisDir: int32_t
{
    PositiveX = 0,
    PositiveY,
    PositiveZ,
    NegativeX,
    NegativeY,
    NegativeZ,
    Num,
    Null = Num,
} AxisDir_t;

typedef float64_t real_t;

template<int32_t RowNum, int32_t ColNum>
    using Matrix_t = Eigen::Matrix<real_t, RowNum, ColNum>;
template<int32_t Num>
    using ColVector_t = Eigen::Matrix<real_t, Num, 1>;
template<int32_t Num>
    using Vector_t = Eigen::Matrix<real_t, Num, 1>;
template<int32_t Num>
    using RowVector_t = Eigen::Matrix<real_t, 1, Num>;
typedef Eigen::Matrix<real_t, Eigen::Dynamic, Eigen::Dynamic> MatrixNd_t;
typedef Eigen::Matrix<real_t, Eigen::Dynamic, 1> VectorNd_t;
typedef Eigen::Matrix<real_t, 1, Eigen::Dynamic> RowVectorNd_t;
typedef Eigen::SparseMatrix<real_t> SparseMatrix_t;
typedef Eigen::Triplet<real_t> Triplet_t;
typedef std::vector<Triplet_t> TripletColl_t;

typedef Eigen::Matrix<real_t, *Dof2d::Num, *Dof2d::Num> RotMat2d_t;
typedef std::vector<RotMat2d_t> RotMat2dColl_t;
typedef HomogeneousTransform<real_t, *Dof2d::Num> HomoXfm2d_t;
typedef std::vector<HomoXfm2d_t> HomoXfm2dColl_t;

typedef Eigen::Matrix<real_t, *Dof3d::Num, *Dof3d::Num> RotMat3d_t;
typedef std::vector<RotMat3d_t> RotMat3dColl_t;
typedef HomogeneousTransform<real_t, *Dof3d::Num> HomoXfm3d_t;
typedef std::vector<HomoXfm3d_t> HomoXfm3dColl_t;

typedef Eigen::ParametrizedLine<real_t, *Dof2d::Num> ParametrizedLine2d_t;
typedef Eigen::Hyperplane<real_t, *Dof2d::Num> Hyperplane2d_t;

typedef Eigen::ParametrizedLine<real_t, *Dof3d::Num> ParametrizedLine3d_t;
typedef Eigen::Hyperplane<real_t, *Dof3d::Num> Hyperplane3d_t;

typedef ColVector2d<real_t> Vector2d_t;
typedef ColVector3d<real_t> Vector3d_t;
typedef ColVector4d<real_t> Vector4d_t;
typedef SpatialVector<real_t> Vector6d_t;
typedef Matrix_t<*Dof6d::Num, *Dof6d::Num> SpatialMat_t;
typedef SpatialTransform<real_t> SpatialTransform_t;
typedef SpatialTransform<real_t> SpatialXfm_t;
typedef SpatialVector<real_t> SpatialVector_t;

typedef ColVector3d<real_t> ExpMap_t;
typedef Eigen::Quaternion<real_t, Eigen::DontAlign> Quaternion_t;
typedef std::vector<Quaternion_t> QuaternionColl_t;
typedef Eigen::AngleAxis<real_t> AngleAxis_t;

typedef std::vector<Vector2d_t> Vector2dColl_t;
typedef std::vector<Vector3d_t> Vector3dColl_t;
typedef std::vector<Vector4d_t> Vector4dColl_t;
typedef std::vector<SpatialVector_t> SpatialVectorColl_t;
typedef std::vector<Vector6d_t> Vector6dColl_t;
typedef std::vector<VectorNd_t> VectorNdColl_t;
typedef std::vector<RowVectorNd_t> RowVectorNdColl_t;
typedef std::vector<MatrixNd_t> MatrixNdColl_t;
typedef std::vector<AngleAxis_t> AngleAxisColl_t;

typedef std::pair<Vector2d_t, Vector2d_t> Vector2dPair_t;
typedef std::pair<Vector3d_t, Vector3d_t> Vector3dPair_t;
typedef EpsilonPrecision<real_t> EpsilonPrecision_t;

constexpr typename std::underlying_type<QuaternionCoefIdx_t>::type operator*(const QuaternionCoefIdx_t &quat_coef_idx)
{
    return static_cast<typename std::underlying_type<QuaternionCoefIdx_t>::type>(quat_coef_idx);
}

} // namespace math {

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
        std::basic_ostream<charT, traits> &ostream,
        const Dof2dIdx_t &dof2d_idx
        )
{
    static const std::map<Dof2dIdx_t, std::string> kDof2dMap =
    {
        {Dof2d::X,    STRINGIFY(Dof2d::X)},
        {Dof2d::Y,    STRINGIFY(Dof2d::Y)},
        {Dof2d::Null, STRINGIFY(Dof2d::Null)},
    };

    ostream << kDof2dMap.find(dof2d_idx)->second;
    return ostream;
}

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
        std::basic_ostream<charT, traits> &ostream,
        const Dof3dIdx_t &dof3d_idx
        )
{
    static const std::map<Dof3dIdx_t, std::string> kDof3dMap =
    {
        {Dof3d::X,    STRINGIFY(Dof3d::X)},
        {Dof3d::Y,    STRINGIFY(Dof3d::Y)},
        {Dof3d::Z,    STRINGIFY(Dof3d::Z)},
        {Dof3d::Null, STRINGIFY(Dof3d::Null)},
    };

    ostream << kDof3dMap.find(dof3d_idx)->second;
    return ostream;
}

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
        std::basic_ostream<charT, traits> &ostream,
        const Dof6dIdx_t &dof6d_idx
        )
{
    static const std::map<Dof6dIdx_t, std::string> kDof6dMap =
    {
        {Dof6d::RotX, STRINGIFY(Dof6d::RotX)},
        {Dof6d::RotY, STRINGIFY(Dof6d::RotY)},
        {Dof6d::RotZ, STRINGIFY(Dof6d::RotZ)},
        {Dof6d::XltX, STRINGIFY(Dof6d::XltX)},
        {Dof6d::XltY, STRINGIFY(Dof6d::XltY)},
        {Dof6d::XltZ, STRINGIFY(Dof6d::XltZ)},
        {Dof6d::Null, STRINGIFY(Dof6d::Null)},
    };

    ostream << kDof6dMap.find(dof6d_idx)->second;
    return ostream;
}

namespace math {

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
        std::basic_ostream<charT, traits> &ostream,
        const AngleOrder_t &angle_order
        )
{
    static const std::map<AngleOrder_t, std::string> kAngleOrderMap =
    {
        {AngleOrder::Xyz,  STRINGIFY(AngleOrder::Xyz)},
        {AngleOrder::Zyx,  STRINGIFY(AngleOrder::Zyx)},
        {AngleOrder::Yzx,  STRINGIFY(AngleOrder::Yzx)},
        {AngleOrder::Xzy,  STRINGIFY(AngleOrder::Xzy)},
        {AngleOrder::Yxz,  STRINGIFY(AngleOrder::Yxz)},
        {AngleOrder::Zxy,  STRINGIFY(AngleOrder::Zxy)},
        {AngleOrder::Null, STRINGIFY(AngleOrder::Null)},
    };

    ostream << kAngleOrderMap.find(angle_order)->second;

    return ostream;
}

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
        std::basic_ostream<charT, traits> &ostream,
        const PlaneCoord_t &plane_coord
        )
{
    static const std::map<PlaneCoord_t, std::string> kCoordMap =
    {
        {Plane::Xy,   STRINGIFY(Plane::Xy)},
        {Plane::Yz,   STRINGIFY(Plane::Yz)},
        {Plane::Xz,   STRINGIFY(Plane::Xz)},
        {Plane::Null, STRINGIFY(Plane::Null)},
    };

    ostream << kCoordMap.find(plane_coord)->second;

    return ostream;
}

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
        std::basic_ostream<charT, traits> &ostream,
        const AxisDir_t &axis_dir
        )
{
    static const std::map<AxisDir_t, std::string> kAxisDirMap =
    {
        {AxisDir::PositiveX, STRINGIFY(AxisDir::PositiveX)},
        {AxisDir::PositiveY, STRINGIFY(AxisDir::PositiveY)},
        {AxisDir::PositiveZ, STRINGIFY(AxisDir::PositiveZ)},
        {AxisDir::NegativeX, STRINGIFY(AxisDir::NegativeX)},
        {AxisDir::NegativeY, STRINGIFY(AxisDir::NegativeY)},
        {AxisDir::NegativeZ, STRINGIFY(AxisDir::NegativeZ)},
        {AxisDir::Null,      STRINGIFY(AxisDir::Null)},
    };

    ostream << kAxisDirMap.find(axis_dir)->second;

    return ostream;
}

template<typename charT, typename traits, typename InputVector_t>
std::basic_ostream<charT, traits> &operator<<(
        std::basic_ostream<charT, traits> &ostream,
        const std::vector<InputVector_t> &vector_coll
        )
{
    for (auto vector = vector_coll.begin(); vector != vector_coll.end(); ++vector)
    {
        ostream << vector->transpose() << NEWLINE;
    }

    return ostream;
}

} // namespace math {

namespace Eigen {

template<typename charT, typename traits, typename Scalar, int32_t Option>
std::basic_ostream<charT, traits> &operator<<(
        std::basic_ostream<charT, traits> &ostream,
        const Quaternion<Scalar, Option> &quat
        )
{
    ostream << "w: " << quat.w() <<
        ", x: " << quat.x() <<
        ", y: " << quat.y() <<
        ", z: " << quat.z();

    return ostream;
}

} // namespace Eigen {

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
        std::basic_ostream<charT, traits> &ostream,
        const std::vector<math::Vector2d_t> &vector_2d_coll
        )
{
    for (auto vector_2d = vector_2d_coll.begin(); vector_2d != vector_2d_coll.end(); ++vector_2d)
    {
        ostream << vector_2d->transpose() << NEWLINE;
    }

    return ostream;
}

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
        std::basic_ostream<charT, traits> &ostream,
        const math::Vector3dColl_t &vector_3d_coll
        )
{
    for (auto vector_3d = vector_3d_coll.begin(); vector_3d != vector_3d_coll.end(); ++vector_3d)
    {
        ostream << vector_3d->transpose() << NEWLINE;
    }

    return ostream;
}

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
        std::basic_ostream<charT, traits> &ostream,
        const math::VectorNdColl_t &vector_nd_coll
        )
{
    for (auto vector_nd = vector_nd_coll.begin(); vector_nd != vector_nd_coll.end(); ++vector_nd)
    {
        ostream << vector_nd->transpose() << NEWLINE;
    }

    return ostream;
}

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
        std::basic_ostream<charT, traits> &ostream,
        const math::MatrixNdColl_t &matrix_coll
        )
{
    for (auto matrix = matrix_coll.begin(); matrix != matrix_coll.end(); ++matrix)
    {
        ostream << *matrix << NEWLINE;
    }

    return ostream;
}

//template<typename charT, typename traits>
//std::basic_ostream<charT, traits> &operator<<(
//        std::basic_ostream<charT, traits> &ostream,
//        const math::Vector3dCollPair_t &vector3d_coll_pair
//        )
//{
//    ostream << "left" << NEWLINE;
//    for (auto left_vector = vector3d_coll_pair.left.begin();
//            left_vector != vector3d_coll_pair.left.end();
//            ++left_vector)
//    {
//        ostream << left_vector->transpose() << NEWLINE;
//    }
//
//    ostream << "right" << NEWLINE;
//    for (auto right_vector = vector3d_coll_pair.right.begin();
//            right_vector != vector3d_coll_pair.right.end();
//            ++right_vector)
//    {
//        ostream << right_vector->transpose() << NEWLINE;
//    }
//
//    return ostream;
//}

#endif // #ifndef _MATH_TYPE_H_
