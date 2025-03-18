#ifndef _MATH_UTILS_H_
#define _MATH_UTILS_H_

#include "math_def.h"
#include <string>
#include <vector>
#include <type_traits>
#include <iostream>
#include "math_fwd.h"
#include "math_type.h"
#include "math_frenet_coord.h"

namespace math {
/**
 * \brief Get the Pi value, 3.1415926............, and the precision is specified by the type Scalar
 * \return The Pi value
 */
template<typename Scalar>
Scalar Pi();
/**
 * \brief Get the value 2.0 * Pi
 * return 2.0 * Pi
 */
template<typename Scalar>
Scalar TwoPi();
/**
 * \brief Get the value Pi/2
 * \return Pi/2
 */
template<typename Scalar>
Scalar HalfPi();
/**
 * \brief Get the value Pi/4
 * return Pi/4
 */
template<typename Scalar>
Scalar QuarterPi();
/**
 * \brief
 */
template<typename Scalar>
Scalar Degree_90();
template<typename Scalar>
Scalar Degree_180();
template<typename Scalar>
Scalar Degree_270();
template<typename Scalar>
Scalar Degree_360();
/**
 * \brief Compute half value of input_value according to its type
 * \param[in] input_value
 * \return 0.5 * input_value
 */
template<typename Scalar>
Scalar Half(const Scalar &input_value);
/**
 * \brief Compute half value of input
 * \param[in] input
 * \return 0.5 * input
 */
Vector3d_t Half(const Vector3d_t &input);
VectorNd_t Half(const VectorNd_t &input);
/**
 * \brief
 */
VectorNd_t Scale(const VectorNd_t &input, const real_t scale);
/**
 * \brief Get the constant to convert the angle unit from degree to radian
 * \return Pi / 180.0
 */
template<typename Scalar>
Scalar ToRadian();
/**
 * \brief Get the constant to convert the angle unit from radian to degree
 * \return 180.0 / Pi
 */
template<typename Scalar>
Scalar ToDegree();
/**
 * \brief Convert input unit from degree to radian
 * \param[in] degree The given degree value
 * \return degree * Pi / 180.0
 */
template<typename Scalar>
Scalar ToRadian(const Scalar &degree);
/**
 * \brief Convert input unit from radian to degree
 * \param[in] radian The given radian value
 * \return radian * 180.0 / Pi
 */
template<typename Scalar>
Scalar ToDegree(const Scalar &radian);
/**
 * \brief Convert degree_vector unit from degree to radian
 * \param[in] degree_vector The given degree vector
 * \return degree_vector * Pi / 180.0
 */
Vector3d_t ToRadian(const Vector3d_t &degree_vector);
/**
 * \brief Convert radian_vector unit from radian to degree
 * \param[in] radian_vector The given radian vector
 * \return radian_vector * Pi / 180.0
 */
Vector3d_t ToDegree(const Vector3d_t &radian_vector);
/**
 * \brief
 * \param[in]
 * \return
 */
VectorNd_t ToRadian(const VectorNd_t &degree_vector);
/**
 * \brief Convert radian_vector unit from radian to degree
 * \param[in] radian_vector The gvein radian vector
 * \return radian_vector * Pi / 180.0
 */
VectorNd_t ToDegree(const VectorNd_t &radian_vector);
/**
 * \brief
 */
template<typename Scalar>
Scalar WarpToPi(const Scalar &radian);

template<typename Scalar>
Scalar ComputePrincipalAngle(const Scalar &input_radian);
/**
 * \brief Compute arc cosine value
 */
template<typename Scalar>
Scalar ComputeArcCosine(const Scalar &input, const Scalar &epsilon = Scalar{1.0e-10});
/**
 * \brief Get unit vecotr at X-axis
 * \return (1.0, 0.0, 0.0)
 */
Vector3d_t UnitX();
/**
 * \brief Get unit vector at Y-axis
 * \return (0.0, 1.0, 0.0)
 */
Vector3d_t UnitY();
/**
 * \brief Get unit vector at Z-axis
 * \return (0.0, 0.0, 1.0)
 */
Vector3d_t UnitZ();
/**
 * \brief
 */
Vector3d_t UnitVector(const Dof3dIdx_t &dof3d_idx);
/**
 * \brief
 */
Vector3d_t UnitVector(const AxisDir_t &axis_dir);
/**
 * \brief
 */
Dof3dIdx_t EvalDof3dIdx(
        const Vector3d_t &vector,
        const Vector3d_t::RealScalar epsilon = Vector3d_t::RealScalar{1.0e-6}
        );
/**
 * \brief
 */
AxisDir_t EvalVectorDirection(
        const Vector3d_t &vector,
        const Vector3d_t::RealScalar epsilon = Vector3d_t::RealScalar{1.0e-6}
        );
/**
 * \brief Comptue the reciprocal of a_kVal, i.e., retval * input_value = 1.0
 * \param[in] input_value The target value
 * \return The reciprocal of input_value
 */
template<typename Scalar>
Scalar Reciprocal(const Scalar &input_value);
/**
 * \brief Compute the square value of the given input_value
 * \param[in] input_value The target value
 * \return The square of input_value
 */
template<typename Scalar>
constexpr Scalar Square(const Scalar &input_value)
{
    return input_value * input_value;
}
/**
 * \brief Compute the cube value of the given input_value
 * \param[in] input_value The target value
 * \return The cube of input_value
 */
template<typename Scalar>
constexpr Scalar Cube(const Scalar &input_value)
{
    return input_value * input_value * input_value;
}
/**
 * \brief
 * \retval -1, if input_value < 0,
 * \retval 1, if input_value >= 0
 */
template<typename Scalar>
int32_t Sgn(const Scalar &input_value)
{
    return input_value < Scalar{0} ? -1 : 1;
}

template<typename Scalar>
Scalar Clamp(
    const Scalar input,
    const Scalar min,
    const Scalar max);
/**
 * \brief Truncate input_value to the floor value, e.g., truncate 3.002 to 3.000, if input_value - floor_value < epsilon,
 * i.e., input_value approximates floor_value
 * \param[in] input_value The target truncated input
 * \param[in] epsilon     The given epsilon
 * \retval floor(input_value), if input_value > floor_value && input_value - floor_value < epsilon
 * \retval input_value, otherwise
 */
template<typename Scalar>
Scalar ToFloor(const Scalar &input_value, const Scalar &epsilon);
/**
 * \brief Round input_value to the ceil value, e.g. round 3.998 to 4.0, if ceil_value - input_value < epsilon,
 * i.e., input_value approximates ceil_value
 * \param[in] input_value The target truncated input
 * \param[in] epsilon     The given epsilon
 * \retval ceil(input_value), if input_value < ceil_value && ceil_value - input_value < epsilon
 * \retval input_value, otherwise
 */
template<typename Scalar>
Scalar ToCeil(const Scalar &input_value, const Scalar &epsilon);
/**
 * \brief
 */
template<typename Scalar>
Scalar Clip(const Scalar &input, const Scalar &lower_bound, const Scalar &upper_bound);
/**
 * \brief Compute dot value of the vector_1st and vector_2nd
 * \param[in] vector_1st
 * \param[in] vector_2nd
 * \return dot value of the given vector_1st and vector_2nd
 */
real_t Dot(
        const Vector3d_t &vector_1st,
        const Vector3d_t &vector_2nd
        );
/**
 * \brief Compute cross vector of the vector_1st and vector_2nd
 * \param[in] vector_1st
 * \param[in] vector_2nd
 * \return cross vector of the given vector_1st and vector_2nd
 */
Vector3d_t Cross(
        const Vector3d_t &vector_1st,
        const Vector3d_t &vector_2nd
        );
real_t ComputeCross(
        const Vector2d_t &vector_1st,
        const Vector2d_t &vector_2nd
        );
/**
 * \brief
 */
Vector3d_t ComputeLocalXlt(const HomoXfm3d_t &homo_xfm);
/**
 * \brief
 */
Vector3dColl_t ExtractXlt(const HomoXfm3dColl_t &xfm_coll, const Coord_t &coord);
/**
 * \brief
 */
Vector3d_t ComputeOffsetPosition(const HomoXfm3d_t &xfm, const FrenetCoord &frenet_coord);
/**
 * \brief Compute the cross matrix of input_vector
 * i.e. Output = 
 *       0 -z  y
 *       z  0 -x
 *      -y  x  0
 * \param[in] input_vector
 */
RotMat3d_t CrossMatrix(const Vector3d_t &input_vector);
/**
 * \brief
 * \param[in] spatial_vector
 * \return
 */
SpatialMat_t SpatialCross(const SpatialVector_t &spatial_vector);
/**
 * \brief
 * \param[in] input_vector
 * \return
 */
SpatialMat_t SpatialCrossDual(const SpatialVector_t &spatial_vector);
/**
 * \brief
 * \param[in] input_mat
 * \return
 */
int32_t ComputeRank(const MatrixNd_t &input_mat);
/**
 * \brief
 */
bool_t IsFullRank(const MatrixNd_t &input_mat);
/**
 * \brief
 */
bool_t IsSquareMatrix(const MatrixNd_t &input_mat);
/**
 * \brief
 */
bool_t IsSymmetricMatrix(const MatrixNd_t &input_mat, const real_t epsilon);
/**
 * \brief Get the default tolerance of SVD
 */
constexpr MatrixNd_t::RealScalar SvdTolerance()
{return MatrixNd_t::RealScalar{1.0e-6};}
/**
 * \brief Compute Pseudoinverse by SVD
 * \param[in] input_mat
 * \return
 */
MatrixNd_t ComputePseudoinverse(
        const MatrixNd_t &input_mat,
        const MatrixNd_t::RealScalar &min_singular_value = SvdTolerance()
        );
/**
 * \brief
 */
MatrixNd_t ComputeWeightedPseudoinverse(
        const MatrixNd_t &input_mat,
        const MatrixNd_t &weight_mat,
        const MatrixNd_t::RealScalar &min_singular_value = SvdTolerance()
        );
/**
 * \brief
 * \param[in]
 * \return
 */
MatrixNd_t::RealScalar ComputeConditionNum(const MatrixNd_t &input);
/**
 * \brief Compute the rotation matrix to transform source_vector to end_vector, i.e.
 * end_vector = RelativeRotMat * source_vector
 * \param[in] source_vector The source vector
 * \param[in] end_vector The end vector
 * \return The rotation matrix transforming source_vector to end_vector
 */
RotMat3d_t ComputeRelativeRotMat(
        const Vector3d_t &source_vector,
        const Vector3d_t &end_vector
        );
/**
 * \brief
 */
real_t ComputeRelativeAngle(
        const Vector3d_t &source_vector,
        const Vector3d_t &end_vector
        );
/**
 * \brief
 */
real_t ComputeRotationalAngle(
        const Vector2d_t &source_vector,
        const Vector2d_t &end_vector
        );
real_t ComputeRotationalAngle(
        const Vector3d_t &source_vector,
        const Vector3d_t &end_vector,
        const PlaneCoord_t &projective_plane
        );
real_t ComputePrincipalAngle(const RotMat2d_t &rotmat2d);
RotMat2d_t ComputeRotMat2d(const real_t radian);
/**
 * \brief
 */
Quaternion_t ComputeOrientationXy(const Vector3d_t &vector3d);
/**
 * Compute rotation matrix via the specified angle & rotation axis
 * Angle unit: radian
 */
RotMat3d_t ToRotMat(const AngleAxis_t &angle_axis);
/**
 * Compute rotation matrix via the specified series of the angles & rotation axes
 * Angle unit: radian
 */
RotMat3d_t ToRotMat(const AngleAxisColl_t &angle_axis_coll);
/**
 * \brief
 */
RotMat3d_t ToRotMat(
        const Vector3d_t &coord_x,
        const Vector3d_t &coord_y,
        const Vector3d_t &coord_z
        );
/**
 * \brief Compute rotation matrix by X-Y-Z order, RotZ * RotY * RotX,
 * i.e., a vector, p, as transformed as RotZ * RotY * RotX * p
 * \param[in]
 * \return
 */
RotMat3d_t ToRotMatXyz(const Vector3d_t &radian_angle);
/**
 * Compute rotation, using the order Z->Y->X, according to the given Euler angles
 * Angle unit: radian
 */
RotMat3d_t ToRotMatZyx(const Vector3d_t &radian_angle);
/**
 * Angle unit: radian
 */
RotMat3d_t ToRotMatYzx(const Vector3d_t &radian_angle);
RotMat3d_t ToRotMatXzy(const Vector3d_t &radian_angle);
RotMat3d_t ToRotMatYxz(const Vector3d_t &radian_angle);
RotMat3d_t ToRotMatZxy(const Vector3d_t &radian_angle);
/**
 * Convert Euler angle, i.e., given a rotation axis and rotation angle, to
 * quaternion
 * Angle unit: radian
 */
Quaternion_t ToQuaternion(const AngleAxis_t &a_kAngAxis);
/**
 * Convert a series of angle-axis rotation representations to a quaternion
 */
Quaternion_t ToQuaternion(const AngleAxisColl_t &angle_axis_coll);
/**
 * Compute the quaternion according to the given angles,
 * the rotation axis order is X->Y->Z
 */
Quaternion_t ToQuaternionXyz(const Vector3d_t &radian_angle);
/**
 * Compute the quaternion according to the given angles,
 * the rotation axis order is Z->Y->X
 */
Quaternion_t ToQuaternionZyx(const Vector3d_t &radian_angle);
/**
 * Compute the quaternion according to the given angles,
 * the rotation axis order is Y->Z->X
 */
Quaternion_t ToQuaternionYzx(const Vector3d_t &radian_angle);
Quaternion_t ToQuaternionXzy(const Vector3d_t &radian_angle);
Quaternion_t ToQuaternionYxz(const Vector3d_t &radian_angle);
Quaternion_t ToQuaternionZxy(const Vector3d_t &radian_angle);
/**
 * \brief
 * \param[in]
 * \return
 */
Quaternion_t ComputeAverage(const QuaternionColl_t &a_kQuatColl);
/**
 * \brief
 */
Vector4d_t ToVector4d(const Quaternion_t &quat);
/**
 * \brief Compute the linear interpolation according to the weight, step_ratio, and the start and end
 * vectors, begin_vector and end_vector
 * \param[in] begin_vector The begin vector
 * \param[in] end_vector   The end vector
 * \param[in] step_ratio   The interpolation weight
 * \return The interpoalted vector,
 * i.e., (1.0 - step_ratio) * begin_vector + step_ratio * end_vector
 */
template<typename Type>
Type Lerp(
        const Type &begin,
        const Type &end,
        const real_t step_ratio
        );
/**
 * \brief
 * \param[in] start_quat
 * \param[in] end_quat
 * \param[in] step_ratio
 * \return (1.0 - step_ratio) * start_quat + step_ratio * end_quat
 */
Quaternion_t Slerp(
        const Quaternion_t &start_quat,
        const Quaternion_t &end_quat,
        const Quaternion_t::RealScalar &step_ratio
        );
/**
 * \brief
 */
AngleAxis_t ToAngleAxis(const ExpMap_t &exp_mat);
/**
 * \brief Convert the rotation matrix to the Euler angles by the order X-Y-Z
 * \param[in] rot_mat The target rotation matrix
 * \return The Euler angles in the order X-Y-Z, i.e., Vector3d_t(AngX, AngY, AngZ)
 */
Vector3d_t ToEulerAngleXyz(const RotMat3d_t &rot_mat);
/**
 * \brief Conver the rotation matrix to the Euler angles by the order Z-Y-X
 * \param[in] rot_mat The target rotation matrix
 * \return The Euler angles in the order Z-Y-X, i.e., Vector3d_t(AngZ, AngY, AngX);
 */
Vector3d_t ToEulerAngleZyx(const RotMat3d_t &rot_mat);
/**
 * \brief Convert the rotation matrix to the Euler angles by the order Y-Z-X
 * \param[in] rot_mat The target rotation matrix
 * \return The Euler angles in the order Y-Z-X, i.e., Vector3d_t(AngY, AngZ, AngX)
 */
Vector3d_t ToEulerAngleYzx(const RotMat3d_t &rot_mat);
/**
 * \brief Convert the rotation matrix to the Euler angles by the order X-Z-Y
 * \param[in] rot_mat The target rotation matrix
 * \return The Euler angles in the order X-Z-Y, i.e., Vector3d_t(AngX, AngZ, AngY)
 */
Vector3d_t ToEulerAngleXzy(const RotMat3d_t &rot_mat);
/**
 * \brief Convert the rotation matrix to the Euler angles by the order Y-X-Z
 * \param[in] rot_mat The target rotation matrix
 * \return The Euler angles in the order Y-X-Z, i.e., Vector3d_t(AngY, AngX, AngZ)
 */
Vector3d_t ToEulerAngleYxz(const RotMat3d_t &rot_mat);
/**
 * \brief Convert the rotation matrix to the Euler angles by the order Z-X-Y
 * \param[in] rot_mat The target rotation matrix
 * \return The Euler angles in the order Z-X-Y, i.e., Vector3d_t(AngZ, AngX, AngY);
 */
Vector3d_t ToEulerAngleZxy(const RotMat3d_t &rot_mat);
/**
 * \brief
 */
template<typename VectorType>
real_t ComputeAccumulatedDistance(
        const int32_t begin_idx,
        const int32_t end_idx,
        const std::vector<VectorType> &points);
/**
 * \brief
 */
template<typename VectorType>
VectorType ExtractClosestPoint(
        const VectorType &ref,
        const std::vector<VectorType> &targets);
template<typename VectorType>
VectorType ExtractFurthestPoint(
        const VectorType &ref,
        const std::vector<VectorType> &targets);
/**
 * \brief Extract the rotation axes, x, y, and z, of the target rotation matrix
 * \param[in] rot_mat The target rotation matrix
 * \return The rotation axes, x, y, and z, extracted from the target rotation matrix
 */
Vector3dColl_t ExtractRotationAxis(const RotMat3d_t &rot_mat);
/**
 * \brief Get the rotation axis, specified by the a_kDof6dIdx, of the target rotation matrix
 * \param[in] dof6d_idx The target dof index
 * \param[in] rot_mat   The target rotation matrix
 * \return The specified rotation axis extracted from the target rotation matrix
 */
Vector3d_t ExtractRotationAxis(const Dof6dIdx_t &dof6d_idx, const RotMat3d_t &rot_mat);
/**
 * \brief Get the rotation axis, specified by the a_kDof3dIdx, of the target rotation matrix
 * \param[in] dof3d_idx The target dof index
 * \param[in] rot_mat   The target rotation matrix
 * \return The specified rotation axis extracted from the target rotation matrix
 */
Vector3d_t ExtractRotationAxis(const Dof3dIdx_t &dof3d_idx, const RotMat3d_t &rot_mat);
/**
 * \brief
 */
Vector3d_t ExtractVerticalAxis(const PlaneCoord_t &plane_coord);
/**
 * \brief
 */
PlaneCoord_t ExtractProjectivePlane(const Dof3dIdx_t &vertical_axis_idx);
/**
 * \brief
 */
Vector3d_t ProjectVectorOntoPlane(const Vector3d_t &given_vector, const Vector3d_t &plane_normal);
/**
 * \brief
 */
template<template<typename, typename = std::allocator<VectorNd_t::RealScalar>> class Coll>
Coll<VectorNd_t::RealScalar> ToScalarColl(const VectorNd_t &input);
/**
 * \brief
 */
VectorNd_t ToVector(const VectorNd_t::RealScalar *input, const int32_t size);
/**
 * \brief
 */
VectorNd_t ToVector(const std::vector<VectorNd_t::RealScalar> &coll);
/**
 * \brief
 */
VectorNdColl_t ToVectorColl(const std::vector<int32_t> &size_coll, const VectorNd_t &given_vector);
/**
 * \brief
 */
template<typename OutputMatrix_t, typename InputMatrix_t>
std::vector<OutputMatrix_t> ExtractVerticalCutMatrixColl(const InputMatrix_t &input, const int32_t cut_size);
/**
 * \brief Convert the given_vector to a matrix with the specified row_size and col_size
 */
MatrixNd_t ToMatrix(
        const VectorNd_t &given_vector,
        const int32_t row_size,
        const int32_t col_size,
        const bool_t is_row_major = TRUE
        );
/**
 * \brief Stack left & right matrix horizontally into a single matrix
 * \param[in] left_mat The left matrix with the identical row size to the right matrix
 * \param[in] right_mat The right matrix with the identical row size to the left matrix
 * \return A matrix with horizontally arranged left_mat & right_mat
 */
MatrixNd_t StackHorizontalMatrix(const MatrixNd_t &left_mat, const MatrixNd_t &right_mat);
/**
 * \brief
 * \param[in] mat_coll
 * \return
 */
template<typename InputMatrix>
MatrixNd_t StackHorizontalMatrix(const std::vector<InputMatrix> &mat_coll);
/**
 * \brief Stack top & bottom matrix vertically into a single matirx
 * \param[in] top_mat The top matrix with the identical column size to the bottom matrix
 * \param[in] bottom_mat The bottom matrix with the identical column size to the top matrix
 * \return A matrix with vertically arranged top_mat & bottom_mat
 */
MatrixNd_t StackVerticalMatrix(const MatrixNd_t &top_mat, const MatrixNd_t &bottom_mat);
/**
 * \brief
 * \param[in] mat_coll
 * \return
 */
template<typename InputMatrix>
MatrixNd_t StackVerticalMatrix(const std::vector<InputMatrix> &mat_coll);
/**
 * \brief
 */
template<typename InputMatrix>
MatrixNd_t StackVerticalMatrix(
        const std::vector<InputMatrix> &top_mat_coll,
        const std::vector<InputMatrix> &bottom_mat_coll
        );
/**
 * \brief
 */
MatrixNd_t StackDiagonalMatrix(const MatrixNd_t &top_left_mat, const MatrixNd_t &bottom_right_mat);
/**
 * \brief
 */
template<typename Type>
std::vector<Type> Concatenate(const std::vector<Type> &coll_1st, const std::vector<Type> &coll_2nd);
/**
 * \brief Test if the input is empty
 * \param[in] input
 * \return TRUE, the input has zero rows or zero cols
 *         FALSE, the input has non-zero rows & cols
 */
bool_t IsEmpty(const MatrixNd_t &input);
/**
 * \brief
 */
bool_t IsParallel(
        const Vector3d_t &vector_1st,
        const Vector3d_t &vector_2nd,
        const real_t epsilon = real_t{1.0e-8}
        );
/**
 * \brief
 */
bool_t IsPerpendicular(
        const Vector3d_t &vector_1st,
        const Vector3d_t &vector_2nd,
        const real_t epsilon = real_t{1.0e-8}
        );
/**
 * \brief Test if the input_value approximates 0 with the given epsilon
 */
template<typename Scalar>
bool_t IsApproxZero(
        const Scalar &input_value,
        const Scalar &epsilon
        );
/**
 * \brief
 */
bool_t IsApproxZero(
        const MatrixNd_t &mat,
        const MatrixNd_t::RealScalar &epsilon
        );
/**
 * \brief Compare if ref_mat & test_mat are approximate with the tolerance epsilon
 * Note that, if both ref_mat & test_mat are approximate to zero,
 * the MatrixNd_t::isApprox would return FALSE,
 * and this function fix it by applying (ref_mat - test_mat).isZero(epsilon)
 * \param[in] ref_mat
 * \param[in] test_mat
 * \param[in] epsilon
 * \return
 */
bool_t IsApprox(
        const MatrixNd_t &ref_mat,
        const MatrixNd_t &test_mat,
        const real_t &epsilon
        );
bool_t IsApprox(
        const Quaternion_t &ref_quaternion,
        const Quaternion_t &test_quaternion,
        const real_t epsilon
        );
bool_t IsApprox(
        const HomoXfm3d_t &ref_xfm_3d,
        const HomoXfm3d_t &test_xfm_3d,
        const real_t epsilon
        );
bool_t IsApprox(
        const HomoXfm2d_t &ref_xfm_2d,
        const HomoXfm2d_t &test_xfm_2d,
        const real_t epsilon
        );
bool IsApprox(
        const FrenetCoord &ref_frenet_coord,
        const FrenetCoord &test_frenet_coord,
        const real_t epsilon
        );
/**
 * \brief
 */
template<typename Scalar>
bool_t IsApprox(
        const Scalar &ref_input,
        const Scalar &test_input,
        const Scalar &epsilon
        );
/**
 * \brief Evaluate if input_1st >= input_2nd with the approximated epsilon
 */
template<typename Scalar>
bool_t IsGreaterThanOrApprox(
        const Scalar &input_1st,
        const Scalar &input_2nd,
        const Scalar &epsilon
        );
/**
 * \brief Evaluate if input_1st <= input_2nd with the approximated epsilon
 */
template<typename Scalar>
bool_t IsLessThanOrApprox(
        const Scalar &input_1st,
        const Scalar &input_2nd,
        const Scalar &epsilon
        );
/**
 * \brief
 */
MatrixNd_t TruncateMatrixSmallElement(
        const MatrixNd_t &mat,
        const MatrixNd_t::RealScalar &epsilon = MatrixNd_t::RealScalar{1.0e-10}
        );
/**
 * \brief
 */
void ShowVector(
        const std::vector<VectorNd_t> &a_kVectorColl,
        const std::vector<std::string> &a_kVectorNameColl
        );
/**
 * \brief
 */
void ShowDiff(
        const MatrixNd_t &ref_mat,
        const MatrixNd_t &trg_mat,
        const MatrixNd_t::RealScalar epsilon = MatrixNd_t::RealScalar{1.0e-10}
        );
/**
 * \brief
 */
void DumpMatrix(
        const MatrixNd_t &mat,
        const char_t *file_name,
        const bool_t is_exec = TRUE
        );
/**
 * \brief
 */
void DumpMatrix(
        const MatrixNd_t &mat_1st,
        const MatrixNd_t &mat_2nd,
        const char_t *file_name,
        const bool_t is_exec = TRUE
        );
/**
 * \brief
 * \param[in]
 * \param[in]
 * \return: No. of non-zero elements
 */
int32_t ShowMatrixNonZero(
        const MatrixNd_t &mat,
        const MatrixNd_t::RealScalar &epsilon = MatrixNd_t::RealScalar{1.0e-10}
        );
/**
 * \brief
 * \param[in]
 * \param[in]
 * \return No. of non-zero elements
 */
int32_t ShowSparseMatrix(
        const SparseMatrix_t &mat,
        const SparseMatrix_t::RealScalar &epsilon = SparseMatrix_t::RealScalar{1.0e-10}
        );
/**
 * \brief
 * \param[in]
 * \return
 */
bool_t IsNan(const MatrixNd_t &mat);
/**
 * \brief
 */
bool_t IsNormalizedVector(const VectorNd_t &input, const real_t epsilon);
bool_t IsNormalizedQuaternion(const Quaternion_t &input, const real_t epsilon);
/**
 * \brief
 * \param[in]
 * \return
 */
bool_t IsValidRotation(
        const RotMat3d_t &rot_mat,
        const real_t epsilon
        );
/**
 * \brief
 */
template<typename Scalar>
bool_t IsDiffSign(const Scalar &input_1st, const Scalar &input_2nd);

template<typename Scalar>
bool_t IsInRange(const Scalar &value, const Scalar &low, const Scalar &high);
/**
 * \brief
 */
constexpr RotMat3d_t::RealScalar ValidRotationEpsilon()
{return RotMat3d_t::RealScalar{1.0e-6};}
/**
 * \breif
 * \return
 */
RotMat3d_t ToUnitAxis(
        const RotMat3d_t &rotmat,
        const AxisDir_t &axis_dir
        );
/**
 * \brief Figure out whether the rotmat has unit rotation axis, i.e., unit column vector
 * \param[in] rotmat Target rotation matrix
 * \param[in] axis_dir Axis direction
 * \param[in] epsilon Epsilon for floating number comparison
 * \return
 */
bool_t IsUnitAxis(
        const RotMat3d_t &rotmat,
        const AxisDir_t &axis_dir,
        const RotMat3d_t::RealScalar &epsilon
        );
/**
 * \brief Show the rows & cols of input
 * This function is convenient with <<operator
 * \param[in] input The input matrix
 * \return The string contains the matrix size
 */
std::string PrintSize(const MatrixNd_t &input);
/**
 * \brief Compute the sum for each elements of left_mat_coll and right_mat_coll,
 * i.e., left_mat_coll + right_mat_coll
 */
template<typename InputMatrix_t>
std::vector<InputMatrix_t> Plus(
        const std::vector<InputMatrix_t> &left_mat_coll,
        const std::vector<InputMatrix_t> &right_mat_coll
        );
/**
 * \brief Compute the difference for each element of left_mat_coll and right_mat_coll,
 * i.e., left_mat_coll - right_mat_coll
 */
template<typename InputMatrix_t>
std::vector<InputMatrix_t> Minus(
        const std::vector<InputMatrix_t> &left_mat_coll,
        const std::vector<InputMatrix_t> &right_mat_coll
        );
/**
 * \brief
 */
template<typename InputMatrix_t>
std::vector<InputMatrix_t> Scale(const std::vector<InputMatrix_t> &input_coll, const math::real_t scale);

} // namespace math {

#endif // #ifndef _MATH_UTILS_H_
