#include "math_utils.h"
#include <algorithm>
#include <numeric>
#include <functional>
#include <fstream>
#include <iomanip>
#include <type_traits>
#include <list>
#include <sstream>
#include <stdexcept>
#include "boost/iterator/counting_iterator.hpp"
#include "boost/numeric/conversion/cast.hpp"
#include <ros/console.h>

namespace math {
    
namespace inner {
template<typename Scalar_t>
constexpr Scalar_t ToEulerAngleEpsilon()
{return Scalar_t{1.0e-6};}
} // namespace math::inner {

template<typename Scalar>
Scalar Pi()
{
    return boost::numeric_cast<Scalar>(M_PI);
}
template float64_t Pi<float64_t>();
template float32_t Pi<float32_t>();

template<typename Scalar>
Scalar TwoPi()
{
    return math::Pi<Scalar>() * Scalar{2.0};
}
template float64_t TwoPi<float64_t>();
template float32_t TwoPi<float32_t>();

template<typename Scalar>
Scalar HalfPi()
{
    return math::Pi<Scalar>() * Scalar{0.5};
}
template float64_t HalfPi<float64_t>();
template float32_t HalfPi<float32_t>();

template<typename Scalar>
Scalar QuarterPi()
{
    return math::Pi<Scalar>() * Scalar{0.25};
}
template float64_t QuarterPi<float64_t>();
template float32_t QuarterPi<float32_t>();

template<typename Scalar>
Scalar Degree_90()
{
    return boost::numeric_cast<Scalar>(90.0);
}
template float64_t Degree_90<float64_t>();
template float32_t Degree_90<float32_t>();

template<typename Scalar>
Scalar Degree_180()
{
    return boost::numeric_cast<Scalar>(180.0);
}
template float64_t Degree_180<float64_t>();
template float32_t Degree_180<float32_t>();

template<typename Scalar>
Scalar Degree_270()
{
    return boost::numeric_cast<Scalar>(270.0);
}
template float64_t Degree_270<float64_t>();
template float32_t Degree_270<float32_t>();

template<typename Scalar>
Scalar Degree_360()
{
    return boost::numeric_cast<Scalar>(360.0);
}
template float64_t Degree_360<float64_t>();
template float32_t Degree_360<float32_t>();

template<typename Scalar>
Scalar Half(const Scalar &input_value)
{
    return Scalar{0.5} * input_value;
}
template float64_t Half<float64_t>(const float64_t &);
template float32_t Half<float32_t>(const float32_t &);

Vector3d_t Half(const Vector3d_t &input)
{
    return real_t{0.5} * input;
}
VectorNd_t Half(const VectorNd_t &input)
{
    return real_t{0.5} * input;
}

VectorNd_t Scale(const VectorNd_t &input, const real_t scale)
{
    return scale * input;
}

template<typename Scalar>
Scalar ToRadian()
{
    static const Scalar kCoef = Pi<Scalar>() / Scalar{180.0};
    return kCoef;
}
template float64_t ToRadian<float64_t>();
template float32_t ToRadian<float32_t>();

template<typename Scalar>
Scalar ToDegree()
{
    static const Scalar kCoef = Scalar{180.0} / Pi<Scalar>();
    return kCoef;
}
template float64_t ToDegree<float64_t>();
template float32_t ToDegree<float32_t>();

template<typename Scalar>
Scalar ToRadian(const Scalar &degree)
{
    return degree * ToRadian<Scalar>();
}
template float64_t ToRadian<float64_t>(const float64_t &);
template float32_t ToRadian<float32_t>(const float32_t &);

template<typename Scalar>
Scalar ToDegree(const Scalar &radian)
{
    return radian * ToDegree<Scalar>();
}
template float64_t ToDegree<float64_t>(const float64_t &);
template float32_t ToDegree<float32_t>(const float32_t &);

Vector3d_t ToRadian(const Vector3d_t &degree_vector)
{
    return degree_vector * math::ToRadian<Vector3d_t::RealScalar>();
}

Vector3d_t ToDegree(const Vector3d_t &radian_vector)
{
    return radian_vector * math::ToDegree<Vector3d_t::RealScalar>();
}

VectorNd_t ToRadian(const VectorNd_t &degree_vector)
{
    VectorNd_t radian_output(degree_vector.size());
    std::for_each(
            boost::counting_iterator<VectorNd_t::Index>(0),
            boost::counting_iterator<VectorNd_t::Index>(degree_vector.size()),
            [&](const VectorNd_t::Index &a_kIndex)
            {radian_output[a_kIndex] = math::ToRadian(degree_vector[a_kIndex]);}
            );
    return radian_output;
}

VectorNd_t ToDegree(const VectorNd_t &radian_vector)
{
    VectorNd_t degree_output(radian_vector.size());
    std::for_each(
            boost::counting_iterator<VectorNd_t::Index>(0),
            boost::counting_iterator<VectorNd_t::Index>(radian_vector.size()),
            [&](const VectorNd_t::Index &a_kIdx)
            {degree_output[a_kIdx] = math::ToDegree(radian_vector[a_kIdx]);}
            );

    return degree_output;
}

template<typename Scalar>
Scalar WarpToPi(const Scalar &radian)
{
    return std::fmod(radian + math::Pi<Scalar>(), math::TwoPi<Scalar>()) - math::Pi<Scalar>();
}
template float64_t WarpToPi<float64_t>(const float64_t &);
template float32_t WarpToPi<float32_t>(const float32_t &);

template<typename Scalar>
Scalar ComputePrincipalAngle(const Scalar &input_radian)
{
    //float PrincipleAngle(const float angle)
    //{
    //    float anglePrcp = std::atan2(std::sin(angle), std::cos(angle));
    //    if (std::signbit(anglePrcp))
    //        anglePrcp += 2.0f * M_PI;
    //    return anglePrcp;
    //}
    Scalar output_radian = std::atan2(std::sin(input_radian), std::cos(input_radian));
    if (std::signbit(output_radian))
    {
        output_radian += math::TwoPi<Scalar>();
    }

    return output_radian;
}
template float64_t ComputePrincipalAngle<float64_t>(const float64_t &);
template float32_t ComputePrincipalAngle<float32_t>(const float32_t &);

template<typename Scalar>
Scalar ComputeArcCosine(const Scalar &input, const Scalar &epsilon /* = Scalar{1.0e-10} */)
{
    if (input > Scalar{1.0})
    {
        if (math::IsApprox(input, Scalar{1.0}, epsilon))
        {
            return Scalar{0.0};
        }
        else
        {
            //console::log(ERR) << "invalid input: " << input << std::endl;
            throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
        }
    }

    if (input < Scalar{-1.0})
    {
        if (math::IsApprox(input, Scalar{-1.0}, epsilon))
        {
        }
        else
        {
            //console::log(ERR) << "invalid input: " << input << std::endl;
            throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
        }
    }

    return acos(input);
}
template float64_t ComputeArcCosine(const float64_t &, const float64_t &);
template float32_t ComputeArcCosine(const float32_t &, const float32_t &);

Vector3d_t UnitX()
{
    return Vector3d_t::UnitX();
}

Vector3d_t UnitY()
{
    return Vector3d_t::UnitY();
}

Vector3d_t UnitZ()
{
    return Vector3d_t::UnitZ();
}

Vector3d_t UnitVector(const Dof3dIdx_t &dof3d_idx)
{
    static const std::map<Dof3dIdx_t, Vector3d_t> kUnitAxisMap =
    {
        {Dof3d::X, Vector3d_t::UnitX()},
        {Dof3d::Y, Vector3d_t::UnitY()},
        {Dof3d::Z, Vector3d_t::UnitZ()},
    };

    auto found_axis = kUnitAxisMap.find(dof3d_idx);
    if (kUnitAxisMap.end() == found_axis)
    {
        //console::log(ERR) << "invalid " << dof3d_idx << std::endl;
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return found_axis->second;
}

Vector3d_t UnitVector(const AxisDir_t &axis_dir)
{
    static const std::map<AxisDir_t, Vector3d_t> kUnitVectorMap =
    {
        {AxisDir::PositiveX, Vector3d_t::UnitX()},
        {AxisDir::PositiveY, Vector3d_t::UnitY()},
        {AxisDir::PositiveZ, Vector3d_t::UnitZ()},
        {AxisDir::NegativeX, -Vector3d_t::UnitX()},
        {AxisDir::NegativeY, -Vector3d_t::UnitY()},
        {AxisDir::NegativeZ, -Vector3d_t::UnitZ()},
    };

    auto found_vector = kUnitVectorMap.find(axis_dir);
    if (kUnitVectorMap.end() == found_vector)
    {
        //console::log(ERR) << "invalid " << axis_dir << std::endl;
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return found_vector->second;
}

Dof3dIdx_t EvalDof3dIdx(
        const Vector3d_t &vector,
        const Vector3d_t::RealScalar epsilon
        )
{
    static const std::map<Dof3dIdx_t, Vector3d_t> kUnitAxisMap =
    {
        {Dof3d::X, Vector3d_t::UnitX()},
        {Dof3d::Y, Vector3d_t::UnitY()},
        {Dof3d::Z, Vector3d_t::UnitZ()},
    };

    auto found = std::find_if(
            kUnitAxisMap.begin(),
            kUnitAxisMap.end(),
            [&](const std::pair<Dof3dIdx_t, Vector3d_t> &axis_pair)
            {return math::IsApprox(axis_pair.second, vector, epsilon);}
            );

    if (kUnitAxisMap.end() == found)
    {
        return Dof3d::Null;
    }

    return found->first;
}

AxisDir_t EvalVectorDirection(
        const Vector3d_t &vector,
        const Vector3d_t::RealScalar epsilon
        )
{
    static const std::map<AxisDir_t, Vector3d_t> kAxisMap =
    {
        {AxisDir::PositiveX, Vector3d_t::UnitX()},
        {AxisDir::PositiveY, Vector3d_t::UnitY()},
        {AxisDir::PositiveZ, Vector3d_t::UnitZ()},
        {AxisDir::NegativeX, -Vector3d_t::UnitX()},
        {AxisDir::NegativeY, -Vector3d_t::UnitY()},
        {AxisDir::NegativeZ, -Vector3d_t::UnitZ()},
    };

    auto found = std::find_if(
            kAxisMap.begin(),
            kAxisMap.end(),
            [&](const std::pair<AxisDir_t, Vector3d_t> &ref_pair)
            {return math::IsApprox(ref_pair.second, vector, epsilon);}
            );

    if (kAxisMap.end() == found)
    {
        return AxisDir::Null;
    }

    return found->first;
}

template<typename Scalar>
Scalar Reciprocal(const Scalar &input_value)
{
    static const float64_t kEpsilon = boost::numeric_cast<float64_t>(1.0e-10);
    const float64_t target_value = boost::numeric_cast<float64_t>(input_value);
    if (math::IsApproxZero(target_value, kEpsilon))
    {
        //console::log(ERR, 10) << "input_value: " << target_value << ", is almost zero" << NEWLINE
        //    << std::endl;
        ROS_ERROR_STREAM(std::setprecision(10) <<
            "input_value: " << target_value << ", is almost zero");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    const float64_t reciprocal = boost::numeric_cast<float64_t>(1.0) / target_value;
    return boost::numeric_cast<Scalar>(reciprocal);
}
template float64_t Reciprocal<float64_t>(const float64_t &);
template float32_t Reciprocal<float32_t>(const float32_t &);

template<typename Scalar>
Scalar Clamp(
    const Scalar input,
    const Scalar min,
    const Scalar max)
{
    return std::max(min, std::min(input, max));
}
template float64_t Clamp(const float64_t, const float64_t, const float64_t);
template float32_t Clamp(const float32_t, const float32_t, const float32_t);

template<typename Scalar>
Scalar ToFloor(const Scalar &input_value, const Scalar &epsilon)
{
    const Scalar floor_value = floor(input_value);
    if (input_value > floor_value)
    {
        if (fabs(input_value - floor_value) < epsilon)
        {
            return floor_value;
        }
    }

    return input_value;
}
template float64_t ToFloor<float64_t>(const float64_t &, const float64_t &);
template float32_t ToFloor<float32_t>(const float32_t &, const float32_t &);

template<typename Scalar>
Scalar ToCeil(const Scalar &input_value, const Scalar &epsilon)
{
    const Scalar ceil_value = ceil(input_value);
    if (input_value < ceil_value)
    {
        if (fabs(input_value - ceil_value) < epsilon)
        {
            return ceil_value;
        }
    }

    return input_value;
}
template float64_t ToCeil<float64_t>(const float64_t &, const float64_t &);
template float32_t ToCeil<float32_t>(const float32_t &, const float32_t &);

template<typename Scalar>
Scalar Clip(const Scalar &input, const Scalar &lower_bound, const Scalar &upper_bound)
{
    return std::max(lower_bound, std::min(input, upper_bound));
}
template float64_t Clip<float64_t>(const float64_t &, const float64_t &, const float64_t &);
template float32_t Clip<float32_t>(const float32_t &, const float32_t &, const float32_t &);
template int32_t Clip<int32_t>(const int32_t &, const int32_t &, const int32_t &);

real_t Dot(
        const Vector3d_t &vector_1st,
        const Vector3d_t &vector_2nd
        )
{
    return vector_1st.dot(vector_2nd);
}

Vector3d_t Cross(
        const Vector3d_t &vector_1st,
        const Vector3d_t &vector_2nd
        )
{
    return vector_1st.cross(vector_2nd);
}
 
real_t ComputeCross(
        const Vector2d_t &vector_1st,
        const Vector2d_t &vector_2nd
        )
{
    return vector_1st.x() * vector_2nd.y() - vector_1st.y() * vector_2nd.x();
}

Vector3d_t ComputeLocalXlt(const HomoXfm3d_t &homo_xfm)
{
    return -homo_xfm.linear().transpose() * homo_xfm.translation();
}

Vector3dColl_t ExtractXlt(const HomoXfm3dColl_t &xfm_coll, const Coord_t &coord)
{
    Vector3dColl_t xlt_coll(xfm_coll.size(), Vector3d_t::Zero());
    if (Coord::Local == coord)
    {
        std::transform(
                xfm_coll.begin(),
                xfm_coll.end(),
                xlt_coll.begin(),
                [](const HomoXfm3d_t &xfm)
                {return math::ComputeLocalXlt(xfm);}
                );
    }
    else if (Coord::World == coord)
    {
        std::transform(
                xfm_coll.begin(),
                xfm_coll.end(),
                xlt_coll.begin(),
                [](const HomoXfm3d_t &xfm)
                {return xfm.translation();}
                );
    }
    else
    {
        //console::log(ERR) << "invalid " << coord << std::endl;
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return xlt_coll;
}

Vector3d_t ComputeOffsetPosition(const HomoXfm3d_t &xfm, const FrenetCoord &frenet_coord)
{
    const Vector3d_t longitudinal_vector(
        xfm.linear().col(0).x(),
        xfm.linear().col(0).y(),
        0.0
        );
    const Vector3d_t lateral_vector(
        xfm.linear().col(1).x(),
        xfm.linear().col(1).y(),
        0.0
        );

    return xfm.translation() +
        frenet_coord.s() * longitudinal_vector +
        frenet_coord.d() * lateral_vector;
}

RotMat3d_t CrossMatrix(const Vector3d_t &input_vector)
{
    typedef typename Vector3d_t::RealScalar Scalar_t;
    static const Scalar_t kZero = Scalar_t{0.0};
    const Scalar_t scalar_x = input_vector.x();
    const Scalar_t scalar_y = input_vector.y();
    const Scalar_t scalar_z = input_vector.z();

    RotMat3d_t Result;
    Result <<     kZero, -scalar_z,  scalar_y,
               scalar_z,     kZero, -scalar_x,
              -scalar_y,   scalar_x,    kZero;

    return Result;
}

SpatialMat_t SpatialCross(const SpatialVector_t &spatial_vector)
{
    SpatialMat_t cross_mat(SpatialMat_t::Zero());

    RotMat3d_t angular_cross_mat = math::CrossMatrix(spatial_vector.angular_vector());
    RotMat3d_t linear_cross_mat = math::CrossMatrix(spatial_vector.linear_vector());

    cross_mat.topLeftCorner(angular_cross_mat.rows(), angular_cross_mat.cols()) = angular_cross_mat;
    cross_mat.bottomRightCorner(angular_cross_mat.rows(), angular_cross_mat.cols()) = angular_cross_mat;
    cross_mat.bottomLeftCorner(linear_cross_mat.rows(), linear_cross_mat.cols()) = linear_cross_mat;

    return cross_mat;
}

SpatialMat_t SpatialCrossDual(const SpatialVector_t &spatial_vector)
{
    SpatialMat_t cross_dual_mat(SpatialMat_t::Zero());

    RotMat3d_t angular_cross_mat = math::CrossMatrix(spatial_vector.angular_vector());
    RotMat3d_t linear_cross_mat = math::CrossMatrix(spatial_vector.linear_vector());

    cross_dual_mat.topLeftCorner(angular_cross_mat.rows(), angular_cross_mat.cols()) = angular_cross_mat;
    cross_dual_mat.bottomRightCorner(angular_cross_mat.rows(), angular_cross_mat.cols()) = angular_cross_mat;
    cross_dual_mat.topRightCorner(linear_cross_mat.rows(), linear_cross_mat.cols()) = linear_cross_mat;

    return cross_dual_mat;
}

int32_t ComputeRank(const MatrixNd_t &input_mat)
{
    return input_mat.fullPivLu().rank();
}

bool_t IsFullRank(const MatrixNd_t &input_mat)
{
    const int32_t rank = input_mat.fullPivLu().rank();
    //const std::pair<int32_t, int32_t> input_dim = std::minmax(
    //        input_mat.rows(),
    //        input_mat.cols()
    //        );

    //return rank == input_dim.first ? TRUE : FALSE;
    return rank == std::min(input_mat.rows(), input_mat.cols()) ? TRUE : FALSE;
}

bool_t IsSquareMatrix(const MatrixNd_t &input_mat)
{
    return input_mat.rows() == input_mat.cols() ? TRUE : FALSE;
}

bool_t IsSymmetricMatrix(const MatrixNd_t &input_mat, const real_t epsilon)
{
    if (!math::IsSquareMatrix(input_mat))
    {
        return FALSE;
    }

    return input_mat.isApprox(input_mat.transpose(), epsilon);
}

MatrixNd_t ComputePseudoinverse(
        const MatrixNd_t &input_mat,
        const MatrixNd_t::RealScalar &min_singular_value // = SvdTolerance()
        )
{
    Eigen::JacobiSVD<MatrixNd_t> jacobi_svd(input_mat, Eigen::ComputeThinU | Eigen::ComputeThinV);
    const int32_t singular_value_num = boost::numeric_cast<int32_t>(jacobi_svd.singularValues().size());
    VectorNd_t inverse_singular_value = VectorNd_t::Zero(singular_value_num);
    for (int32_t singular_idx = 0; singular_idx < singular_value_num; ++singular_idx)
    {
        if (fabs(jacobi_svd.singularValues()(singular_idx)) > min_singular_value)
        {
            inverse_singular_value(singular_idx)
                = VectorNd_t::RealScalar{1.0} / jacobi_svd.singularValues()(singular_idx);
        }
    }

    const MatrixNd_t pseudo_inverse_mat
        = jacobi_svd.matrixV()
        * inverse_singular_value.asDiagonal()
        * jacobi_svd.matrixU().transpose();

    {
        static const EpsilonPrecision_t kEpsPrec(EpsilonPrecision_t::Scalar_t{1.0e-5});
        MatrixNd_t original_mat = input_mat * pseudo_inverse_mat * input_mat;
        bool_t is_approx_input_mat = math::IsApprox(
                input_mat,
                original_mat,
                kEpsPrec.epsilon()
                );
        if (!is_approx_input_mat)
        {
            const MatrixNd_t error_mat = input_mat * pseudo_inverse_mat;
            //console::log(WARN, kEpsPrec.precision_digits())
            //    << "not a good pseudo inverse" << NEWLINE
            //    << "input_mat * input_mat^-1" << NEWLINE
            //    << error_mat << NEWLINE
            //    << std::endl;
        }
    }

    return pseudo_inverse_mat;
}

MatrixNd_t ComputeWeightedPseudoinverse(
        const MatrixNd_t &input_mat,
        const MatrixNd_t &weight_mat,
        const MatrixNd_t::RealScalar &min_singular_value
        )
{
    Eigen::JacobiSVD<MatrixNd_t> jacobi_svd(input_mat, Eigen::ComputeThinU | Eigen::ComputeThinV);
    const int32_t singular_value_num = boost::numeric_cast<int32_t>(jacobi_svd.singularValues().size());
    VectorNd_t inverse_singular_value = VectorNd_t::Zero(singular_value_num);
    for (int32_t singular_idx = 0; singular_idx < singular_value_num; ++singular_idx)
    {
        if (fabs(jacobi_svd.singularValues()(singular_idx)) > min_singular_value)
        {
            inverse_singular_value(singular_idx)
                = VectorNd_t::RealScalar{1.0} / jacobi_svd.singularValues()(singular_idx);
        }
    }

    const MatrixNd_t weighted_pseudo_inverse_mat
        = jacobi_svd.matrixV()
        * weight_mat
        * inverse_singular_value.asDiagonal()
        * jacobi_svd.matrixU().transpose();

    return weighted_pseudo_inverse_mat;
}

MatrixNd_t::RealScalar ComputeConditionNum(const MatrixNd_t &input)
{
    Eigen::JacobiSVD<MatrixNd_t> svd(input);
    return svd.singularValues()(0) / svd.singularValues()(svd.singularValues().size() - 1);
}

RotMat3d_t ComputeRelativeRotMat(
        const Vector3d_t &source_vector,
        const Vector3d_t &end_vector
        )
{
    const Vector3d_t unit_source_vector = source_vector.normalized();
    const Vector3d_t unit_end_vector = end_vector.normalized();

    Quaternion_t target_quat;
    target_quat.setFromTwoVectors(unit_source_vector, unit_end_vector);

    {
        if (!math::IsValidRotation(target_quat.toRotationMatrix(), math::ValidRotationEpsilon()))
        {
            //console::log(ERR, 5) << NEWLINE
            //    << "invalid rotation matrix" << NEWLINE
            //    << "is nan: " <<  math::IsNan(target_quat.toRotationMatrix()) << NEWLINE
            //    << "determinant: " << target_quat.toRotationMatrix().determinant() << NEWLINE
            //    << std::endl;
            throw std::logic_error(std::string(__FILE__":") + std::to_string(__LINE__));
        }

        Vector3d_t target_end_vector = target_quat.toRotationMatrix() * unit_source_vector;
        if (!math::IsApprox(unit_end_vector, target_end_vector, 1.0e-5))
        {
            //console::log(ERR, 5) << NEWLINE
            //    << "cannot convert source_vector to end_vector by rotation matrix" << NEWLINE
            //    << "source_vector: " << source_vector.transpose() << NEWLINE
            //    << "end_vector: " << end_vector.transpose() << NEWLINE
            //    << std::endl;
            throw std::logic_error(std::string(__FILE__":") + std::to_string(__LINE__));
        }
    }

    return target_quat.toRotationMatrix();
}

real_t ComputeRelativeAngle(
        const Vector3d_t &source_vector,
        const Vector3d_t &end_vector
        )
{
    const real_t numerator = source_vector.dot(end_vector);
    const real_t denominator = source_vector.norm() * end_vector.norm();

    return acos(numerator / denominator);
}

real_t ComputeRotationalAngle(
        const Vector2d_t &source_vector,
        const Vector2d_t &end_vector
        )
{
    const real_t numerator
        = end_vector.y() * source_vector.x()
        - end_vector.x() * source_vector.y();
    const real_t denominator
        = end_vector.x() * source_vector.x()
        + end_vector.y() * source_vector.y();

    return atan2(numerator, denominator);
}

real_t ComputeRotationalAngle(
        const Vector3d_t &source_vector,
        const Vector3d_t &end_vector,
        const PlaneCoord_t &projective_plane
        )
{
    Vector2d_t projective_source_vector = Vector2d_t::Zero();
    Vector2d_t projective_end_vector = Vector2d_t::Zero();
    if (Plane::Xy == projective_plane)
    {
        projective_source_vector = Vector2d_t(
                source_vector.x(),
                source_vector.y()
                );
        projective_end_vector = Vector2d_t(
                end_vector.x(),
                end_vector.y()
                );
    }
    else if (Plane::Yz == projective_plane)
    {
        projective_source_vector = Vector2d_t(
                source_vector.y(),
                source_vector.z()
                );
        projective_end_vector = Vector2d_t(
                end_vector.y(),
                end_vector.z()
                );
    }
    else if (Plane::Xz == projective_plane)
    {
        projective_source_vector = Vector2d_t(
                source_vector.x(),
                source_vector.z()
                );
        projective_end_vector = Vector2d_t(
                end_vector.x(),
                end_vector.z()
                );
    }
    else
    {
        //console::log(ERR) << "invalid " << projective_plane << std::endl;
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return math::ComputeRotationalAngle(
            projective_source_vector,
            projective_end_vector
            );
}

real_t ComputePrincipalAngle(const RotMat2d_t &rotmat2d)
{
    return Eigen::Rotation2D<real_t>(rotmat2d).smallestPositiveAngle();
}

RotMat2d_t ComputeRotMat2d(const real_t radian)
{
    return Eigen::Rotation2D<real_t>(radian).toRotationMatrix();
}

Quaternion_t ComputeOrientationXy(const Vector3d_t &vector3d)
{
    const real_t heading_radian = std::atan2(
        vector3d.y(),
        vector3d.x()
        );
    return Quaternion_t{AngleAxis_t(heading_radian, Vector3d_t::UnitZ())};
}

RotMat3d_t ToRotMat(const AngleAxis_t &angle_axis)
{
    return RotMat3d_t(angle_axis);
}

RotMat3d_t ToRotMat(const AngleAxisColl_t &angle_axis_coll)
{
    return math::ToQuaternion(angle_axis_coll).toRotationMatrix();
}

RotMat3d_t ToRotMat(
        const math::Vector3d_t &coord_x,
        const math::Vector3d_t &coord_y,
        const math::Vector3d_t &coord_z
        )
{
    RotMat3d_t output;
    output.col(*Dof3d::X) = coord_x;
    output.col(*Dof3d::Y) = coord_y;
    output.col(*Dof3d::Z) = coord_z;

    if (!math::IsValidRotation(output, math::ValidRotationEpsilon()))
    {
        //console::log(ERR) << "invalid rotation matrix" << NEWLINE
        //    << output << NEWLINE
        //    << std::endl;
        throw std::invalid_argument(std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__)));
    }

    return output;
}

RotMat3d_t ToRotMatXyz(const Vector3d_t &radian_angle)
{
    return RotMat3d_t(
            AngleAxis_t(radian_angle.z(), math::UnitZ())
            * AngleAxis_t(radian_angle.y(), math::UnitY())
            * AngleAxis_t(radian_angle.x(), math::UnitX())
            );
}

RotMat3d_t ToRotMatZyx(const Vector3d_t &radian_angle)
{
    return RotMat3d_t(
            AngleAxis_t(radian_angle.x(), math::UnitX())
            * AngleAxis_t(radian_angle.y(), math::UnitY())
            * AngleAxis_t(radian_angle.z(), math::UnitZ())
            );
}

RotMat3d_t ToRotMatYzx(const Vector3d_t &radian_angle)
{
    return RotMat3d_t(
            AngleAxis_t(radian_angle.x(), math::UnitX())
            * AngleAxis_t(radian_angle.z(), math::UnitZ())
            * AngleAxis_t(radian_angle.y(), math::UnitY())
            );
}

RotMat3d_t ToRotMatXzy(const Vector3d_t &radian_angle)
{
    return RotMat3d_t(
            AngleAxis_t(radian_angle.y(), math::UnitY())
            * AngleAxis_t(radian_angle.z(), math::UnitZ())
            * AngleAxis_t(radian_angle.x(), math::UnitX())
            );
}

RotMat3d_t ToRotMatYxz(const Vector3d_t &radian_angle)
{
    return RotMat3d_t(
            AngleAxis_t(radian_angle.z(), math::UnitZ())
            * AngleAxis_t(radian_angle.x(), math::UnitX())
            * AngleAxis_t(radian_angle.y(), math::UnitY())
            );
}

RotMat3d_t ToRotMatZxy(const Vector3d_t &radian_angle)
{
    return RotMat3d_t(
            AngleAxis_t(radian_angle.y(), math::UnitY())
            * AngleAxis_t(radian_angle.x(), math::UnitX())
            * AngleAxis_t(radian_angle.z(), math::UnitZ())
            );
}

Quaternion_t ToQuaternion(const AngleAxis_t &angle_axis)
{
    AngleAxisColl_t angle_axis_coll(1, angle_axis);
    return math::ToQuaternion(angle_axis_coll);
}

Quaternion_t ToQuaternion(const AngleAxisColl_t &angle_axis_coll)
{
    Quaternion_t output_quat(Quaternion_t::Identity());
    std::for_each(
            angle_axis_coll.begin(),
            angle_axis_coll.end(),
            [&](const AngleAxis_t &angle_axis)
            {output_quat = angle_axis * output_quat;}
            );

    return output_quat;
}

Quaternion_t ToQuaternionXyz(const Vector3d_t &radian_angle)
{
    AngleAxisColl_t angle_axis_coll =
    {
        {radian_angle.x(), math::UnitX()},
        {radian_angle.y(), math::UnitY()},
        {radian_angle.z(), math::UnitZ()},
    };

    return math::ToQuaternion(angle_axis_coll);
}

Quaternion_t ToQuaternionZyx(const Vector3d_t &radian_angle)
{
    AngleAxisColl_t angle_axis_coll =
    {
        {radian_angle.z(), math::UnitZ()},
        {radian_angle.y(), math::UnitY()},
        {radian_angle.x(), math::UnitX()},
    };

    return math::ToQuaternion(angle_axis_coll);
}

Quaternion_t ToQuaternionYzx(const Vector3d_t &radian_angle)
{
    AngleAxisColl_t angle_axis_coll =
    {
        {radian_angle.y(), math::UnitY()},
        {radian_angle.z(), math::UnitZ()},
        {radian_angle.x(), math::UnitX()},
    };

    return math::ToQuaternion(angle_axis_coll);
}

Quaternion_t ToQuaternionXzy(const Vector3d_t &radian_angle)
{
    AngleAxisColl_t angle_axis_coll =
    {
        {radian_angle.x(), math::UnitX()},
        {radian_angle.z(), math::UnitZ()},
        {radian_angle.y(), math::UnitY()},
    };

    return math::ToQuaternion(angle_axis_coll);
}

Quaternion_t ToQuaternionYxz(const Vector3d_t &radian_angle)
{
    AngleAxisColl_t angle_axis_coll =
    {
        {radian_angle.y(), math::UnitY()},
        {radian_angle.x(), math::UnitX()},
        {radian_angle.z(), math::UnitZ()},
    };

    return math::ToQuaternion(angle_axis_coll);
}

Quaternion_t ToQuaternionZxy(const Vector3d_t &radian_angle)
{
    AngleAxisColl_t angle_axis_coll =
    {
        {radian_angle.z(), math::UnitZ()},
        {radian_angle.x(), math::UnitX()},
        {radian_angle.y(), math::UnitY()},
    };

    return math::ToQuaternion(angle_axis_coll);
}

Quaternion_t ComputeAverage(const QuaternionColl_t &a_kQuatColl)
{
    //typedef Eigen::Matrix<Quaternion_t::RealScalar, 4, 1> Vector4d_t;
    using Vector4d_t = Eigen::Matrix<Quaternion_t::RealScalar, 4, 1>;
    auto toVector4d = [](const Quaternion_t &a_kQuat)
    {
        return Vector4d_t(a_kQuat.x(), a_kQuat.y(), a_kQuat.z(), a_kQuat.w());
    };
    auto toQuaternion = [](const Vector4d_t &a_kVector4d)
    {
        return Quaternion_t(a_kVector4d.w(), a_kVector4d.x(), a_kVector4d.y(), a_kVector4d.z());
    };
    auto isClosed = [](const Quaternion_t &a_kRef, const Quaternion_t &a_kTarg)
    {
        return a_kRef.dot(a_kTarg) >= 0 ? TRUE : FALSE;
    };

    Vector4d_t accumQuatVec = Vector4d_t::Zero();

    const int lQuatNum = static_cast<int>(a_kQuatColl.size());
    for (auto itQuat = a_kQuatColl.begin(); itQuat != (a_kQuatColl.begin() + lQuatNum); ++itQuat)
    {
        if (!isClosed(a_kQuatColl.front(), *itQuat))
        {
            accumQuatVec += toVector4d(itQuat->inverse());
            //console::log(MSG) << "Not closed quaternion" << std::endl;
        }
        else
        {
            accumQuatVec += toVector4d(*itQuat);
        }
    }

    Quaternion_t::RealScalar invSize
        = boost::numeric_cast<Quaternion_t::RealScalar>(1.0)
        / boost::numeric_cast<Quaternion_t::RealScalar>(lQuatNum);
    Vector4d_t avgQuatVec = accumQuatVec * invSize;
    avgQuatVec.normalize();

    return toQuaternion(avgQuatVec);
}

Vector4d_t ToVector4d(const Quaternion_t &quat)
{
    return Vector4d_t(quat.x(), quat.y(), quat.z(), quat.w());
}


template<typename Type>
Type Lerp(
        const Type &begin,
        const Type &end,
        const real_t step_ratio
        )
{
    static const real_t kUnitStepRatio = real_t{1.0};
    static const real_t kZeroStepRatio = real_t{0.0};

    if (step_ratio < kZeroStepRatio)
    {
        //console::log(ERR, 5) << "invalid step_ratio: " << step_ratio << NEWLINE
        std::cerr << "invalid step_ratio: " << step_ratio << NEWLINE
            << "step_ratio shall be greater or equal to 0.0" << NEWLINE
            << std::endl;
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }
    if (step_ratio > kUnitStepRatio)
    {
        //console::log(ERR, 5) << "invalid step_ratio: " << step_ratio << NEWLINE
        std::cerr << "invalid step_ratio: " << step_ratio << NEWLINE
            << "step_ratio shall be smaller or equal to 1.0" << NEWLINE
            << std::endl;
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return (kUnitStepRatio - step_ratio) * begin + step_ratio * end;
}

template real_t Lerp<real_t>(const real_t &, const real_t &, const real_t);
template Vector3d_t Lerp<Vector3d_t>(const Vector3d_t &, const Vector3d_t &, const real_t);

Quaternion_t Slerp(
        const Quaternion_t &start_quat,
        const Quaternion_t &end_quat,
        const Quaternion_t::RealScalar &step_ratio
        )
{
    static Quaternion_t::RealScalar kUnitStepRatio = Quaternion_t::RealScalar{1.0};
    static Quaternion_t::RealScalar kZeroStepRatio = Quaternion_t::RealScalar{0.0};
    if (step_ratio < kZeroStepRatio)
    {
        //console::log(ERR, 5) << "invalid step_ratio: " << step_ratio << NEWLINE
        //    << "step_ratio shall be greater or equal to 0.0" << NEWLINE
        //    << std::endl;
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }
    if (step_ratio > kUnitStepRatio)
    {
        //console::log(ERR, 5) << "invalid step_ratio: " << step_ratio << NEWLINE
        //    << "step_ratio shall be smaller or equal to 1.0" << NEWLINE
        //    << std::endl;
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return start_quat.slerp(
            step_ratio,
            end_quat
            );
}

AngleAxis_t ToAngleAxis(const ExpMap_t &exp_mat)
{
    return AngleAxis_t(exp_mat.norm(), exp_mat.normalized());
}

Vector3d_t ToEulerAngleXyz(const RotMat3d_t &rot_mat)
{
    typedef RotMat3d_t::RealScalar Scalar_t;
    if (rot_mat(2, 0) > (Scalar_t{1.0} - inner::ToEulerAngleEpsilon<Scalar_t>()))
    {
        Scalar_t AngX = atan2(rot_mat(0, 1), rot_mat(0, 2));
        Scalar_t AngY = -math::HalfPi<Scalar_t>();
        Scalar_t AngZ = Scalar_t{0.0};

        return Vector3d_t(AngX, AngY, AngZ);
    }

    if (rot_mat(2, 0) < -(Scalar_t{1.0} - inner::ToEulerAngleEpsilon<Scalar_t>()))
    {
        Scalar_t AngX = atan2(rot_mat(0, 1), rot_mat(0, 2));
        Scalar_t AngY = math::HalfPi<Scalar_t>();
        Scalar_t AngZ = Scalar_t{0.0};

        return Vector3d_t(AngX, AngY, AngZ);
    }

    Scalar_t AngX = atan2(rot_mat(2, 1), rot_mat(2, 2));
    Scalar_t AngY = -asin(rot_mat(2, 0));
    Scalar_t AngZ = atan2(rot_mat(1, 0), rot_mat(0, 0));

    return Vector3d_t(AngX, AngY, AngZ);
}

Vector3d_t ToEulerAngleZyx(const RotMat3d_t &rot_mat)
{
    typedef RotMat3d_t::RealScalar Scalar_t;
    if (rot_mat(0, 2) > (Scalar_t{1.0} - inner::ToEulerAngleEpsilon<Scalar_t>()))
    {
        Scalar_t AngZ = atan2(rot_mat(1, 0), rot_mat(1, 1));
        Scalar_t AngY = math::HalfPi<Scalar_t>();
        Scalar_t AngX = Scalar_t{0.0};

        return Vector3d_t(AngZ, AngY, AngX);
    }

    if(rot_mat(0, 2) < -(Scalar_t{1.0} - inner::ToEulerAngleEpsilon<Scalar_t>()))
    {
        Scalar_t AngZ = atan2(rot_mat(1, 0), rot_mat(1, 1));
        Scalar_t AngY = -math::HalfPi<Scalar_t>();
        Scalar_t AngX = Scalar_t{0.0};

        return Vector3d_t(AngZ, AngY, AngX);
    }

    Scalar_t AngZ = -atan2(rot_mat(0, 1), rot_mat(0, 0));
    Scalar_t AngY = asin(rot_mat(0, 2));
    Scalar_t AngX = -atan2(rot_mat(1, 2), rot_mat(2, 2));

    return Vector3d_t(AngZ, AngY, AngX);	// order of return is the order of input
}

Vector3d_t ToEulerAngleYzx(const RotMat3d_t &rot_mat)
{
    typedef RotMat3d_t::RealScalar Scalar_t;

    if (rot_mat(0, 1) > (Scalar_t{1.0} - inner::ToEulerAngleEpsilon<Scalar_t>()))
    {
        Scalar_t AngY = atan2(rot_mat(1, 2), rot_mat(1, 0));
        Scalar_t AngZ = -math::HalfPi<Scalar_t>();
        Scalar_t AngX = Scalar_t{0.0};

        return Vector3d_t(AngY, AngZ, AngX);
    }

    if (rot_mat(0, 1) < -(Scalar_t{1.0} - inner::ToEulerAngleEpsilon<Scalar_t>()))
    {
        Scalar_t AngY = atan2(rot_mat(1, 2), rot_mat(1, 0));
        Scalar_t AngZ = math::HalfPi<Scalar_t>();
        Scalar_t AngX = Scalar_t{0.0};

        return Vector3d_t(AngY, AngZ, AngX);
    }

    Scalar_t AngY = atan2(rot_mat(0, 2), rot_mat(0, 0));
    Scalar_t AngZ = -asin(rot_mat(0, 1));
    Scalar_t AngX = atan2(rot_mat(2, 1), rot_mat(1, 1));

    return Vector3d_t(AngY, AngZ, AngX);	// order of return is the order of input
}

Vector3d_t ToEulerAngleXzy(const RotMat3d_t &rot_mat)
{
    typedef RotMat3d_t::RealScalar Scalar_t;
    if (rot_mat(1, 0) > (Scalar_t{1.0} - inner::ToEulerAngleEpsilon<Scalar_t>()))
    {
        Scalar_t AngX = -atan2(rot_mat(0, 2), rot_mat(0, 1));
        Scalar_t AngZ = math::HalfPi<Scalar_t>();
        Scalar_t AngY = Scalar_t{0.0};

        return Vector3d_t(AngX, AngZ, AngY);
    }

    if (rot_mat(1, 0) < -(Scalar_t{1.0} - inner::ToEulerAngleEpsilon<Scalar_t>()))
    {
        Scalar_t AngX = -atan2(rot_mat(0, 2), rot_mat(0, 1));
        Scalar_t AngZ = -math::HalfPi<Scalar_t>();
        Scalar_t AngY = Scalar_t{0.0};

        return Vector3d_t(AngX, AngZ, AngY);
    }

    Scalar_t AngX = -atan2(rot_mat(1, 2), rot_mat(1, 1));
    Scalar_t AngZ = asin(rot_mat(1, 0));
    Scalar_t AngY = -atan2(rot_mat(2, 0), rot_mat(0, 0));

    return Vector3d_t(AngX, AngZ, AngY);	// order of return is the order of input
}

Vector3d_t ToEulerAngleYxz(const RotMat3d_t &rot_mat)
{
    typedef RotMat3d_t::RealScalar Scalar_t;
    if (rot_mat(2, 1) > (Scalar_t{1.0} - inner::ToEulerAngleEpsilon<Scalar_t>()))
    {
        Scalar_t AngY = atan2(rot_mat(0, 2), rot_mat(0, 0));
        Scalar_t AngX = math::HalfPi<Scalar_t>();
        Scalar_t AngZ = Scalar_t{0.0};

        return Vector3d_t(AngY, AngX, AngZ);
    }

    if (rot_mat(2, 1) < -(Scalar_t{1.0} - inner::ToEulerAngleEpsilon<Scalar_t>()))
    {
        Scalar_t AngY = atan2(rot_mat(0, 2), rot_mat(0, 0));
        Scalar_t AngX = -math::HalfPi<Scalar_t>();
        Scalar_t AngZ = Scalar_t{0.0};

        return Vector3d_t(AngY, AngX, AngZ);
    }

    Scalar_t AngY = -atan2(rot_mat(2, 0), rot_mat(2, 2));
    Scalar_t AngX = asin(rot_mat(2, 1));
    Scalar_t AngZ = -atan2(rot_mat(0, 1), rot_mat(1, 1));

    return Vector3d_t(AngY, AngX, AngZ);	// order of return is the order of input
}

Vector3d_t ToEulerAngleZxy(const RotMat3d_t &rot_mat)
{
    typedef RotMat3d_t::RealScalar Scalar_t;
    if (rot_mat(1, 2) > (Scalar_t{1.0} - inner::ToEulerAngleEpsilon<Scalar_t>()))
    {
        Scalar_t AngZ = -atan2(rot_mat(0, 1), rot_mat(0, 0));
        Scalar_t AngX = -math::HalfPi<Scalar_t>();
        Scalar_t AngY = Scalar_t{0.0};

        return Vector3d_t(AngZ, AngX, AngY);
    }

    if (rot_mat(1, 2) < -(Scalar_t{1.0} - inner::ToEulerAngleEpsilon<Scalar_t>()))
    {
        Scalar_t AngZ = -atan2(rot_mat(0, 1), rot_mat(0, 0));
        Scalar_t AngX = math::HalfPi<Scalar_t>();
        Scalar_t AngY = Scalar_t{0.0};

        return Vector3d_t(AngZ, AngX, AngY);
    }

    Scalar_t AngZ = atan2(rot_mat(1, 0), rot_mat(1, 1));
    Scalar_t AngX = -asin(rot_mat(1, 2));
    Scalar_t AngY = atan2(rot_mat(0, 2), rot_mat(2, 2));

    return Vector3d_t(AngZ, AngX, AngY);	// order of return is the order of input
}

template<typename VectorType>
real_t ComputeAccumulatedDistance(
        const int32_t begin_idx,
        const int32_t end_idx,
        const std::vector<VectorType> &points)
{
    real_t output_distance{0.0};
    for (int32_t idx = begin_idx; idx < end_idx; ++idx)
    {
        output_distance += (points.at(idx + 1) - points.at(idx)).norm();
    }

    return output_distance;
}
template real_t ComputeAccumulatedDistance(const int32_t, const int32_t, const std::vector<Vector2d_t> &);
template real_t ComputeAccumulatedDistance(const int32_t, const int32_t, const std::vector<Vector3d_t> &);

template<typename VectorType>
VectorType ExtractClosestPoint(const VectorType &ref, const std::vector<VectorType> &targets)
{
    const VectorType closest_target = *std::min_element(
        targets.begin(),
        targets.end(),
        [&ref](const VectorType &first, const VectorType &second)
        {return (ref - first).norm() < (ref - second).norm();});

    return closest_target;
}
template Vector2d_t ExtractClosestPoint<Vector2d_t>(const Vector2d_t &, const std::vector<Vector2d_t> &);
template Vector3d_t ExtractClosestPoint<Vector3d_t>(const Vector3d_t &, const std::vector<Vector3d_t> &);

template<typename VectorType>
VectorType ExtractFurthestPoint(const VectorType &ref, const std::vector<VectorType> &targets)
{
    const VectorType furthest_target = *std::max_element(
        targets.begin(),
        targets.end(),
        [&ref](const VectorType &first, const VectorType &second)
        {return (ref - first).norm() < (ref - second).norm();});

    return furthest_target;
}
template Vector2d_t ExtractFurthestPoint<Vector2d_t>(const Vector2d_t &, const std::vector<Vector2d_t> &);
template Vector3d_t ExtractFurthestPoint<Vector3d_t>(const Vector3d_t &, const std::vector<Vector3d_t> &);

Vector3dColl_t ExtractRotationAxis(const RotMat3d_t &rot_mat)
{
    Vector3dColl_t axis_coll(*Dof3d::Num, Vector3d_t());

    axis_coll[*Dof3d::X] = rot_mat.col(*Dof3d::X);
    axis_coll[*Dof3d::Y] = rot_mat.col(*Dof3d::Y);
    axis_coll[*Dof3d::Z] = rot_mat.col(*Dof3d::Z);

    return axis_coll;
}

Vector3d_t ExtractRotationAxis(const Dof6dIdx_t &dof6d_idx, const RotMat3d_t &rot_mat)
{
    if (dof6d_idx > Dof6d::RotZ)
    {
        //console::log(ERR) << "invalid " << dof6d_idx << std::endl;
        throw std::invalid_argument(std::string(__FILE__";") + std::to_string(__LINE__));
    }

    return rot_mat.col(*dof6d_idx);
}

Vector3d_t ExtractRotationAxis(const Dof3dIdx_t &dof3d_idx, const RotMat3d_t &rot_mat)
{
    return rot_mat.col(*dof3d_idx);
}

Vector3d_t ExtractVerticalAxis(const PlaneCoord_t &plane_coord)
{
    static const std::map<PlaneCoord_t, Vector3d_t> kVerticalAxisMap =
    {
        {Plane::Xy, Vector3d_t::UnitZ()},
        {Plane::Yz, Vector3d_t::UnitX()},
        {Plane::Xz, Vector3d_t::UnitY()},
    };

    return kVerticalAxisMap.find(plane_coord)->second;
}

PlaneCoord_t ExtractProjectivePlane(const Dof3dIdx_t &vertical_axis_idx)
{
    static const std::map<Dof3dIdx_t, PlaneCoord_t> kProjectivePlaneMap =
    {
        {Dof3d::X, Plane::Yz},
        {Dof3d::Y, Plane::Xz},
        {Dof3d::Z, Plane::Xy},
    };

    return kProjectivePlaneMap.find(vertical_axis_idx)->second;
}

Vector3d_t ProjectVectorOntoPlane(const Vector3d_t &given_vector, const Vector3d_t &plane_normal)
{
    const Vector3d_t normal_component = given_vector.dot(plane_normal) * plane_normal.squaredNorm() * plane_normal;
    const Vector3d_t plane_component = given_vector - normal_component;

    return plane_component;
}

template<>
std::vector<VectorNd_t::RealScalar> ToScalarColl(const VectorNd_t &input)
{
    return std::vector<VectorNd_t::RealScalar>(
            input.data(),
            input.data() + input.size()
            );
}
template<>
std::list<VectorNd_t::RealScalar> ToScalarColl(const VectorNd_t &input)
{
    return std::list<VectorNd_t::RealScalar>(
            input.data(),
            input.data() + input.size()
            );
}

VectorNd_t ToVector(const VectorNd_t::RealScalar *input, const int32_t size)
{
    VectorNd_t output(VectorNd_t::Zero(size));
    for (VectorNd_t::Index idx = VectorNd_t::Index{0}; idx < output.size(); ++idx)
    {
        output(idx) = *(input + idx);
    }

    return output;
}

VectorNd_t ToVector(const std::vector<VectorNd_t::RealScalar> &coll)
{
    const VectorNd_t::Index element_size = boost::numeric_cast<VectorNd_t::Index>(coll.size());
    VectorNd_t output_vector(element_size);
    std::for_each(
            boost::counting_iterator<VectorNd_t::Index>(0),
            boost::counting_iterator<VectorNd_t::Index>(element_size),
            [&](const VectorNd_t::Index &idx)
            {output_vector(idx) = coll[idx];}
            );
    return output_vector;
}

VectorNdColl_t ToVectorColl(const std::vector<int32_t> &size_coll, const VectorNd_t &given_vector)
{
    VectorNdColl_t vector_coll;
    vector_coll.reserve(size_coll.size());
    int32_t accumulated_element_count = 0;
    for (auto element_size = size_coll.begin(); element_size != size_coll.end(); ++element_size)
    {
        vector_coll.push_back(given_vector.segment(accumulated_element_count, *element_size));
        accumulated_element_count += *element_size;
    }

    return vector_coll;
}

template<typename OutputMatrix_t, typename InputMatrix_t>
std::vector<OutputMatrix_t> ExtractVerticalCutMatrixColl(const InputMatrix_t &input, const int32_t cut_size)
{
    const div_t div_result = div(
            boost::numeric_cast<int32_t>(input.rows()),
            cut_size
            );
    if (int32_t{0} != div_result.rem)
    {
        return std::vector<OutputMatrix_t>();
    }

    std::vector<OutputMatrix_t> output_coll;
    output_coll.reserve(div_result.quot);

    for (int32_t coll_idx = 0; coll_idx < div_result.quot; ++coll_idx)
    {
        const InputMatrix_t cut_mat = input.middleRows(cut_size * coll_idx, cut_size);
        output_coll.push_back(cut_mat);
    }

    return output_coll;
}
template std::vector<Vector3d_t> ExtractVerticalCutMatrixColl(const VectorNd_t &, const int32_t);
template std::vector<VectorNd_t> ExtractVerticalCutMatrixColl(const VectorNd_t &, const int32_t);
template std::vector<MatrixNd_t> ExtractVerticalCutMatrixColl(const MatrixNd_t &, const int32_t);

MatrixNd_t ToMatrix(
        const VectorNd_t &given_vector,
        const int32_t row_size,
        const int32_t col_size,
        const bool_t is_row_major /* = TRUE */
        )
{
    if (boost::numeric_cast<int32_t>(given_vector.size()) != (row_size * col_size))
    {
        //console::log(ERR) << "unmatched size" << NEWLINE
        //    << "given_vector size is " << given_vector.size() << NEWLINE
        //    << "the given row_size " << row_size << NEWLINE
        //    << "this given col_size " << col_size << NEWLINE
        //    << std::endl;
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
        return MatrixNd_t();
    }

    MatrixNd_t output(MatrixNd_t::Zero(row_size, col_size));

    if (is_row_major)
    {
        for (int32_t row_idx = 0; row_idx < row_size; ++row_idx)
        {
            output.row(row_idx) = given_vector.segment(
                    row_idx * col_size,
                    col_size
                    );
        }
    }
    else
    {
        for (int32_t col_idx = 0; col_idx < col_size; ++col_idx)
        {
            output.col(col_idx) = given_vector.segment(
                    col_idx * row_size,
                    row_size
                    );
        }
    }

    return output;
}

MatrixNd_t StackHorizontalMatrix(const MatrixNd_t &left_mat, const MatrixNd_t &right_mat)
{
    const bool_t is_left_mat_empty = math::IsEmpty(left_mat);
    const bool_t is_right_mat_empty = math::IsEmpty(right_mat);

    if (is_left_mat_empty && is_right_mat_empty)
    {
        return left_mat;
    }

    if (is_left_mat_empty)
    {
        return right_mat;
    }

    if (is_right_mat_empty)
    {
        return left_mat;
    }

    if (left_mat.rows() != right_mat.rows())
    {
        //console::log(ERR) << "unequal rows b/t left_mat & right_mat" << NEWLINE
        //    << "left_mat  " << left_mat.rows() << NEWLINE
        //    << "right_mat " << right_mat.rows() << NEWLINE
        //    << std::endl;
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));

        return MatrixNd_t();
    }

    MatrixNd_t output = MatrixNd_t::Zero(
            left_mat.rows(),
            left_mat.cols() + right_mat.cols()
            );
    output.leftCols(left_mat.cols()) = left_mat;
    output.rightCols(right_mat.cols()) = right_mat;

    return output;
}

template<typename InputMatrix>
MatrixNd_t StackHorizontalMatrix(const std::vector<InputMatrix> &mat_coll)
{
    if (mat_coll.empty())
    {
        return InputMatrix();
    }

    std::vector<InputMatrix> filtered_mat_coll;
    filtered_mat_coll.reserve(mat_coll.size());
    std::copy_if(
            mat_coll.begin(),
            mat_coll.end(),
            std::back_inserter(filtered_mat_coll),
            [](const InputMatrix &input_mat)
            {return !math::IsEmpty(input_mat);}
            );

    int32_t accumulated_col_size = filtered_mat_coll.front().cols();
    for (auto mat = filtered_mat_coll.begin() + 1; mat != filtered_mat_coll.end(); ++mat)
    {
        if (mat->rows() != filtered_mat_coll.front().rows())
        {
            const int32_t idx = boost::numeric_cast<int32_t>(
                    std::distance(filtered_mat_coll.begin(), mat)
                    );
            //console::log(ERR) << "unequal rows at " << idx << " matrix, rows " << mat->rows() << NEWLINE
            //    << "1st mat rows is " << filtered_mat_coll.front().rows() << NEWLINE
            //    << std::endl;
            throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));

            return MatrixNd_t();
        }

        accumulated_col_size += boost::numeric_cast<int32_t>(mat->cols());
    }

    MatrixNd_t output_mat = MatrixNd_t::Zero(
            filtered_mat_coll.front().rows(),
            accumulated_col_size
            );
    int32_t col_idx = 0;
    for (auto mat = filtered_mat_coll.begin(); mat != filtered_mat_coll.end(); ++mat)
    {
        output_mat.middleCols(col_idx, mat->cols()) = *mat;
        col_idx += boost::numeric_cast<int32_t>(mat->cols());
    }

    return output_mat;
}
template MatrixNd_t StackHorizontalMatrix<Vector3d_t>(const std::vector<Vector3d_t> &);
template MatrixNd_t StackHorizontalMatrix<Vector6d_t>(const std::vector<Vector6d_t> &);
template MatrixNd_t StackHorizontalMatrix<VectorNd_t>(const std::vector<VectorNd_t> &);
template MatrixNd_t StackHorizontalMatrix<MatrixNd_t>(const std::vector<MatrixNd_t> &);

MatrixNd_t StackVerticalMatrix(const MatrixNd_t &top_mat, const MatrixNd_t &bottom_mat)
{
    const bool_t is_top_mat_empty = math::IsEmpty(top_mat);
    const bool_t is_bottom_mat_empty = math::IsEmpty(bottom_mat);

    if (is_top_mat_empty && is_bottom_mat_empty)
    {
        return top_mat;
    }

    if (is_top_mat_empty)
    {
        return bottom_mat;
    }

    if (is_bottom_mat_empty)
    {
        return top_mat;
    }

    if (top_mat.cols() != bottom_mat.cols())
    {
        //console::log(ERR) << "unequal cols b/t top_mat & bottom_mat" << NEWLINE
        //    << "top_mat    " << top_mat.cols() << NEWLINE
        //    << "bottom_mat " << bottom_mat.cols() << NEWLINE
        //    << std::endl;
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));

        return MatrixNd_t();
    }

    MatrixNd_t output = MatrixNd_t::Zero(
            top_mat.rows() + bottom_mat.rows(),
            top_mat.cols()
            );
    output.topRows(top_mat.rows()) = top_mat;
    output.bottomRows(bottom_mat.rows()) = bottom_mat;

    return output;
}

template<typename InputMatrix>
MatrixNd_t StackVerticalMatrix(const std::vector<InputMatrix> &mat_coll)
{
    if (mat_coll.empty())
    {
        return InputMatrix();
    }

    std::vector<InputMatrix> filtered_mat_coll;
    filtered_mat_coll.reserve(mat_coll.size());
    std::copy_if(
            mat_coll.begin(),
            mat_coll.end(),
            std::back_inserter(filtered_mat_coll),
            [](const InputMatrix &input_mat)
            {return !math::IsEmpty(input_mat);}
            );

    int32_t accumulated_row_size = filtered_mat_coll.front().rows();
    for (auto mat = filtered_mat_coll.begin() + 1; mat != filtered_mat_coll.end(); ++mat)
    {
        if (mat->cols() != filtered_mat_coll.front().cols())
        {
            const int32_t idx = boost::numeric_cast<int32_t>(
                    std::distance(filtered_mat_coll.begin(), mat)
                    );
            //console::log(ERR) << "unequal cols at " << idx << " matrix, cols " << mat->cols() << NEWLINE
            //    << "1st mat cols is " << filtered_mat_coll.front().cols() << NEWLINE
            //    << std::endl;
            throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));

            return MatrixNd_t();
        }

        accumulated_row_size += boost::numeric_cast<int32_t>(mat->rows());
    }

    MatrixNd_t output_mat = MatrixNd_t::Zero(
            accumulated_row_size,
            filtered_mat_coll.front().cols()
            );
    int32_t row_idx = 0;
    for (auto mat = filtered_mat_coll.begin(); mat != filtered_mat_coll.end(); ++mat)
    {
        output_mat.middleRows(row_idx, mat->rows()) = *mat;
        row_idx += boost::numeric_cast<int32_t>(mat->rows());
    }

    return output_mat;
}
template MatrixNd_t StackVerticalMatrix<Vector2d_t>(const std::vector<Vector2d_t> &);
template MatrixNd_t StackVerticalMatrix<Vector3d_t>(const std::vector<Vector3d_t> &);
template MatrixNd_t StackVerticalMatrix<Vector6d_t>(const std::vector<Vector6d_t> &);
template MatrixNd_t StackVerticalMatrix<VectorNd_t>(const std::vector<VectorNd_t> &);
template MatrixNd_t StackVerticalMatrix<MatrixNd_t>(const std::vector<MatrixNd_t> &);

template<typename InputMatrix>
MatrixNd_t StackVerticalMatrix(
        const std::vector<InputMatrix> &top_mat_coll,
        const std::vector<InputMatrix> &bottom_mat_coll
        )
{
    const MatrixNd_t top_mat = math::StackVerticalMatrix(top_mat_coll);
    const MatrixNd_t bottom_mat = math::StackVerticalMatrix(bottom_mat_coll);
    return math::StackVerticalMatrix(top_mat, bottom_mat);
}
template MatrixNd_t StackVerticalMatrix<Vector3d_t>(const std::vector<Vector3d_t> &, const std::vector<Vector3d_t> &);
template MatrixNd_t StackVerticalMatrix<Vector6d_t>(const std::vector<Vector6d_t> &, const std::vector<Vector6d_t> &);
template MatrixNd_t StackVerticalMatrix<VectorNd_t>(const std::vector<VectorNd_t> &, const std::vector<VectorNd_t> &);
template MatrixNd_t StackVerticalMatrix<MatrixNd_t>(const std::vector<MatrixNd_t> &, const std::vector<MatrixNd_t> &);

MatrixNd_t StackDiagonalMatrix(const MatrixNd_t &top_left_mat, const MatrixNd_t &bottom_right_mat)
{
    const bool_t is_top_left_mat_empty = math::IsEmpty(top_left_mat);
    const bool_t is_bottom_right_mat_empty = math::IsEmpty(bottom_right_mat);

    if (is_top_left_mat_empty && is_bottom_right_mat_empty)
    {
        return top_left_mat;
    }

    if (is_top_left_mat_empty)
    {
        return bottom_right_mat;
    }

    if (is_bottom_right_mat_empty)
    {
        return top_left_mat;
    }

    MatrixNd_t output = MatrixNd_t::Zero(
            top_left_mat.rows() + bottom_right_mat.rows(),
            top_left_mat.cols() + bottom_right_mat.cols()
            );
    output.topLeftCorner(
            top_left_mat.rows(),
            top_left_mat.cols()
            )
        = top_left_mat;
    output.bottomRightCorner(
            bottom_right_mat.rows(),
            bottom_right_mat.cols()
            )
        = bottom_right_mat;

    return output;
}

template<typename Type>
std::vector<Type> Concatenate(const std::vector<Type> &coll_1st, const std::vector<Type> &coll_2nd)
{
    std::vector<Type> output;
    output.reserve(coll_1st.size() + coll_2nd.size());
    output.insert(output.end(), coll_1st.begin(), coll_1st.end());
    output.insert(output.end(), coll_2nd.begin(), coll_2nd.end());

    return output;
}
template std::vector<real_t> Concatenate(const std::vector<real_t> &, const std::vector<real_t> &);
template std::vector<Vector3d_t> Concatenate(const std::vector<Vector3d_t> &, const std::vector<Vector3d_t> &);
template std::vector<VectorNd_t> Concatenate(const std::vector<VectorNd_t> &, const std::vector<VectorNd_t> &);
template std::vector<MatrixNd_t> Concatenate(const std::vector<MatrixNd_t> &, const std::vector<MatrixNd_t> &);
template std::vector<RotMat3d_t> Concatenate(const std::vector<RotMat3d_t> &, const std::vector<RotMat3d_t> &);
template std::vector<HomoXfm3d_t> Concatenate(const std::vector<HomoXfm3d_t> &, const std::vector<HomoXfm3d_t> &);

bool_t IsEmpty(const MatrixNd_t &input)
{
    const bool_t is_empty
        = int32_t{0} == boost::numeric_cast<int32_t>(input.rows())
        || int32_t{0} == boost::numeric_cast<int32_t>(input.cols());

    return is_empty;
}

bool_t IsParallel(
        const Vector3d_t &vector_1st,
        const Vector3d_t &vector_2nd,
        const real_t epsilon /* = real_t{1.0e-8} */
        )
{
    return math::IsApproxZero(vector_1st.cross(vector_2nd), epsilon);
}

bool_t IsPerpendicular(
        const Vector3d_t &vector_1st,
        const Vector3d_t &vector_2nd,
        const real_t epsilon /* = real_t{1.0e-8} */
        )
{
    return math::IsApproxZero(vector_1st.dot(vector_2nd), epsilon);
}

template<typename Scalar>
bool_t IsApproxZero(
        const Scalar &input_value,
        const Scalar &epsilon
        )
{
    const float64_t target_value = boost::numeric_cast<float64_t>(input_value);
    return fabs(target_value) < boost::numeric_cast<float64_t>(epsilon) ? TRUE : FALSE;
}
template bool_t IsApproxZero<float64_t>(const float64_t &, const float64_t &);
template bool_t IsApproxZero<float32_t>(const float32_t &, const float32_t &);
template bool_t IsApproxZero<int32_t>(const int32_t &, const int32_t &);

bool_t IsApproxZero(
        const MatrixNd_t &mat,
        const MatrixNd_t::RealScalar &epsilon
        )
{
    return mat.isZero(epsilon);
}

bool_t IsApprox(
        const MatrixNd_t &ref_mat,
        const MatrixNd_t &test_mat,
        const real_t &epsilon
        )
{
    if (ref_mat.rows() != test_mat.rows()
            || ref_mat.cols() != test_mat.cols())
    {
        //console::log(ERR) << "unequal size b/t ref_mat & test_mat" << NEWLINE
        //    << "ref_mat size " << math::PrintSize(ref_mat) << NEWLINE
        //    << "test_mat size " << math::PrintSize(test_mat) << NEWLINE
        //    << std::endl;

        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }
    MatrixNd_t diff = ref_mat - test_mat;
    bool_t is_approx = diff.isZero(epsilon);

    return is_approx;
}

bool_t IsApprox(
        const Quaternion_t &ref_quaternion,
        const Quaternion_t &test_quaternion,
        const real_t epsilon
        )
{
    if (!math::IsApprox(ref_quaternion.w(), test_quaternion.w(), epsilon))
    {
        return false;
    }

    if (!math::IsApprox(ref_quaternion.x(), test_quaternion.x(), epsilon))
    {
        return false;
    }

    if (!math::IsApprox(ref_quaternion.y(), test_quaternion.y(), epsilon))
    {
        return false;
    }

    if (!math::IsApprox(ref_quaternion.z(), test_quaternion.z(), epsilon))
    {
        return false;
    }

    return true;
}

bool_t IsApprox(
        const HomoXfm3d_t &ref_xfm_3d,
        const HomoXfm3d_t &test_xfm_3d,
        const real_t epsilon
        )
{
    if (!math::IsApprox(ref_xfm_3d.linear(), test_xfm_3d.linear(), epsilon))
    {
        return false;
    }

    if (!math::IsApprox(ref_xfm_3d.translation(), test_xfm_3d.translation(), epsilon))
    {
        return false;
    }

    return true;
}

bool_t IsApprox(
        const HomoXfm2d_t &ref_xfm_2d,
        const HomoXfm2d_t &test_xfm_2d,
        const real_t epsilon)
{
    if (!math::IsApprox(ref_xfm_2d.linear(), test_xfm_2d.linear(), epsilon))
    {
        return false;
    }

    if (!math::IsApprox(ref_xfm_2d.translation(), test_xfm_2d.translation(), epsilon))
    {
        return false;
    }

    return true;
}

bool_t IsApprox(
        const FrenetCoord &ref_frenet_coord,
        const FrenetCoord &test_frenet_coord,
        const real_t epsilon)
{
    if (!math::IsApprox(ref_frenet_coord.s(), test_frenet_coord.s(), epsilon))
    {
        return false;
    }

    if (!math::IsApprox(ref_frenet_coord.d(), test_frenet_coord.d(), epsilon))
    {
        return false;
    }

    return true;
}

template<typename Scalar>
bool_t IsApprox(
        const Scalar &ref_input,
        const Scalar &test_input,
        const Scalar &epsilon
        )
{
    const float64_t ref_value = boost::numeric_cast<float64_t>(ref_input);
    const float64_t test_value = boost::numeric_cast<float64_t>(test_input);

    return fabs(ref_value - test_value) < boost::numeric_cast<float64_t>(epsilon) ? TRUE : FALSE;
}
template bool_t IsApprox<float64_t>(const float64_t &, const float64_t &, const float64_t &);
template bool_t IsApprox<float32_t>(const float32_t &, const float32_t &, const float32_t &);

template<typename Scalar>
bool_t IsGreaterThanOrApprox(
        const Scalar &input_1st,
        const Scalar &input_2nd,
        const Scalar &epsilon
        )
{
    if (input_1st > input_2nd)
    {
        return TRUE;
    }

    return math::IsApprox<Scalar>(input_1st, input_2nd, epsilon);
}
template bool_t IsGreaterThanOrApprox<float64_t>(const float64_t &, const float64_t &, const float64_t &);
template bool_t IsGreaterThanOrApprox<float32_t>(const float32_t &, const float32_t &, const float32_t &);

template<typename Scalar>
bool_t IsLessThanOrApprox(
        const Scalar &input_1st,
        const Scalar &input_2nd,
        const Scalar &epsilon
        )
{
    if (input_1st < input_2nd)
    {
        return TRUE;
    }

    return math::IsApprox<Scalar>(input_1st, input_2nd, epsilon);
}
template bool_t IsLessThanOrApprox<float64_t>(const float64_t &, const float64_t &, const float64_t &);
template bool_t IsLessThanOrApprox<float32_t>(const float32_t &, const float32_t &, const float32_t &);

MatrixNd_t TruncateMatrixSmallElement(
        const MatrixNd_t &mat,
        const MatrixNd_t::RealScalar &epsilon /* = 1.0e-10 */
        )
{
    typedef MatrixNd_t::Index Idx_t;
    MatrixNd_t out_mat = mat;

    for (Idx_t row_idx = Idx_t{0}; row_idx < mat.rows(); ++row_idx)
    {
        for (Idx_t col_idx = Idx_t{0}; col_idx < mat.cols(); ++col_idx)
        {
            if (fabs(mat(row_idx, col_idx)) <= epsilon)
            {
                out_mat(row_idx, col_idx) = MatrixNd_t::RealScalar{0.0};
            }
        }
    }

    return out_mat;
}

void ShowVector(
        const std::vector<VectorNd_t> &vector_coll,
        const std::vector<std::string> &name_coll
        )
{
    if (vector_coll.size() != name_coll.size())
    {
        //console::log(ERR) << "unequal size of input collection" << NEWLINE
        //    << "vector_coll size: " << vector_coll.size() << NEWLINE
        //    << "name_coll size: " << name_coll.size() << NEWLINE
        //    << std::endl;
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    const int32_t coll_size = boost::numeric_cast<int32_t>(vector_coll.size());

    static const int32_t kWidth = 18;
    std::cout << std::setw(boost::numeric_cast<int32_t>(std::string("idx: ").size()) + 5) << " " << " ";
    for (auto name_idx = boost::counting_iterator<int32_t>(0);
            name_idx != boost::counting_iterator<int32_t>(coll_size);
            ++name_idx)
    {
        if (boost::numeric_cast<int32_t>(name_coll[*name_idx].size()) < kWidth)
        {
            std::cout << std::setw(kWidth + 1) << name_coll[*name_idx] << " ";
        }
        else
        {
            std::cout << std::setw(kWidth + 1) << name_coll[*name_idx].substr(0, kWidth) << " ";
        }
    }
    std::cout << std::endl;

    int32_t max_size = boost::numeric_cast<int32_t>(
            std::max_element(
                vector_coll.begin(),
                vector_coll.end(),
                [](const VectorNd_t &a, const VectorNd_t &b){return a.size() < b.size();}
                )->size()
            );

    for (auto dof_idx = boost::counting_iterator<int32_t>(0);
            dof_idx != boost::counting_iterator<int32_t>(max_size);
            ++dof_idx)
    {
        std::cout << "idx: " << std::setw(5) << *dof_idx << " ";
        for (auto vector_idx = boost::counting_iterator<int32_t>(0);
                vector_idx != boost::counting_iterator<int32_t>(coll_size);
                ++vector_idx)
        {
            if (*dof_idx < boost::numeric_cast<int32_t>(vector_coll[*vector_idx].size()))
            {
                std::cout << std::setprecision(4) << std::fixed
                    << std::setw(kWidth) << vector_coll[*vector_idx](*dof_idx) << ", ";
            }
            else
            {
                std::cout << std::setw(kWidth) << " " << ", ";
            }
        }
        std::cout << std::endl;
    }
    std::cout << std::endl;
}

void ShowDiff(
        const MatrixNd_t &ref_mat,
        const MatrixNd_t &trg_mat,
        const MatrixNd_t::RealScalar epsilon // = 1.0e-10
        )
{
    typedef MatrixNd_t::Index Idx_t;
    if (ref_mat.rows() != trg_mat.rows())
    {
        //console::log(ERR) << "unequal row num b/t ref_mat & trg_mat" << NEWLINE
        //    << "ref_mat row num: " << ref_mat.rows() << NEWLINE
        //    << "trg_mat row num: " << trg_mat.rows() << NEWLINE
        //    << std::endl;
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    if (ref_mat.cols() != trg_mat.cols())
    {
        //console::log(ERR) << "unequal col num b/t ref_mat & trg_mat" << NEWLINE
        //    << "ref_mat col num: " << ref_mat.cols() << NEWLINE
        //    << "trg_mat col num: " << trg_mat.cols() << NEWLINE
        //    << std::endl;
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    const EpsilonPrecision_t kEpsPrec(epsilon);
    MatrixNd_t diff_mat = (ref_mat - trg_mat).cwiseAbs();
    for (Idx_t row_idx = 0; row_idx < diff_mat.rows(); ++row_idx)
    {
        for (Idx_t col_idx = 0; col_idx < diff_mat.cols(); ++col_idx)
        {
            if (boost::numeric_cast<float64_t>(diff_mat(row_idx, col_idx)) > kEpsPrec.epsilon())
            {
                //console::log(ERR) << "index: " << "(" << row_idx << ", " << col_idx << "), "
                //    << std::setprecision(kEpsPrec.precision_digits()) << std::fixed
                //    << "ref_mat: " << ref_mat(row_idx, col_idx) << ", "
                //    << "trg_mat: " << trg_mat(row_idx, col_idx)
                //    << std::endl;
            }
        }
    } // for (MatrixNd_t::Index row_idx = 0; row_idx < diff_mat.rows(); ++row_idx)
}

void DumpMatrix(
        const MatrixNd_t &mat,
        const char_t *file_name,
        const bool_t is_exec /* = TRUE */
        )
{
    typedef MatrixNd_t::Index Idx_t;
    static const int32_t kDigit = 4;
    static const int32_t kWidth = 7;

    if (!is_exec)
    {
        return;
    }

    std::ofstream output_stream;
    output_stream.open(file_name, std::ofstream::out);
    for (Idx_t label_idx = Idx_t{0}; label_idx < mat.cols(); ++label_idx)
    {
        static const char_t kSpace = ' ';
        output_stream << std::setw(kWidth + 1) << label_idx << kSpace;
    }

    output_stream << std::endl;

    for (Idx_t row_idx = Idx_t{0}; row_idx < mat.rows(); ++row_idx)
    {
        for (Idx_t col_idx = Idx_t{0}; col_idx < mat.cols(); ++col_idx)
        {
            output_stream << std::setw(kWidth) << std::fixed << std::setprecision(kDigit)
                << mat(row_idx, col_idx) << ", ";
        }

        output_stream << std::endl;
    }

    output_stream.close();
}

void DumpMatrix(
        const MatrixNd_t &mat_1st,
        const MatrixNd_t &mat_2nd,
        const char_t *file_name,
        const bool_t is_exec /* = TRUE */
        )
{
    typedef MatrixNd_t::Index Idx_t;
    static const int32_t kDigit = 4;
    static const int32_t kWidth = 7;

    if (!is_exec)
    {
        return;
    }

    std::ofstream output_stream;
    output_stream.open(file_name, std::ofstream::out);

    const int32_t max_col = boost::numeric_cast<int32_t>(std::max(mat_1st.cols(), mat_2nd.cols()));
    for (int32_t label_idx = 0; label_idx < max_col; ++label_idx)
    {
        static const char_t kSpace = ' ';
        output_stream << std::setw(kWidth + 1) << label_idx << kSpace;
    }

    output_stream << std::endl;

    // dump the 1st matrix
    for (Idx_t row_idx_1st = Idx_t{0}; row_idx_1st < mat_1st.rows(); ++row_idx_1st)
    {
        for (Idx_t col_idx_1st = Idx_t{0}; col_idx_1st < mat_1st.cols(); ++col_idx_1st)
        {
            output_stream << std::setw(kWidth) << std::fixed << std::setprecision(kDigit)
                << mat_1st(row_idx_1st, col_idx_1st) << ", ";
        }

        output_stream << std::endl;
    }

    output_stream << std::endl;
    // dump the 2nd matrix
    for (Idx_t row_idx_2nd = Idx_t{0}; row_idx_2nd < mat_2nd.rows(); ++row_idx_2nd)
    {
        for (Idx_t col_idx_2nd = Idx_t{0}; col_idx_2nd < mat_2nd.cols(); ++col_idx_2nd)
        {
            output_stream << std::setw(kWidth) << std::fixed << std::setprecision(kDigit)
                << mat_2nd(row_idx_2nd, col_idx_2nd) << ", ";
        }

        output_stream << std::endl;
    }

    output_stream.close();
}

int32_t ShowMatrixNonZero(
        const MatrixNd_t &mat,
        const MatrixNd_t::RealScalar &epsilon /* = 1.0e-9 */
        )
{
    typedef MatrixNd_t::Index Idx_t;
    int32_t non_zero_count = 0;
    for (Idx_t row_idx = Idx_t{0}; row_idx < mat.rows(); ++row_idx)
    {
        for (Idx_t col_idx = Idx_t{0}; col_idx < mat.cols(); ++col_idx)
        {
            if (boost::numeric_cast<MatrixNd_t::RealScalar>(fabs(mat(row_idx, col_idx))) > epsilon)
            {
                std::cout << "(" << row_idx << ", "
                    << col_idx << "): "
                    << mat(row_idx, col_idx) << NEWLINE;
                ++non_zero_count;
            }
        } // for (Idx_t col_idx = boost::numeric_cast<Idx_t>(0); col_idx < mat.cols(); ++col_idx)
    } // for (Idx_t row_idx = boost::numeric_cast<Idx_t>(0); row_idx < mat.rows(); ++row_idx)

    return non_zero_count;
}

int32_t ShowSparseMatrix(
        const SparseMatrix_t &mat,
        const SparseMatrix_t::RealScalar &epsilon /* = 1.0e-9 */
        )
{
    typedef SparseMatrix_t::Index Idx_t;
    int32_t non_zero_count = 0;
    for (Idx_t out_idx = Idx_t{0}; out_idx < mat.outerSize(); ++out_idx)
    {
        for (SparseMatrix_t::InnerIterator inner_iterator(mat, out_idx); inner_iterator; ++inner_iterator)
        {
            if (boost::numeric_cast<MatrixNd_t::RealScalar>(fabs(inner_iterator.value())) > epsilon)
            {
                std::cout << "(" << inner_iterator.row() << ", " << inner_iterator.col() << ")"
                    << ": " << inner_iterator.value() << NEWLINE;
                ++non_zero_count;
            }
        } // for (SparseMatrix_t::InnerIterator inner_iterator(mat, lout_idx); inner_iterator; ++inner_iterator)
    } // for (int32_t out_idx = 0; out_idx < mat.outerSize(); ++out_idx)

    return non_zero_count;
}

bool_t IsNan(const MatrixNd_t &mat)
{
    typedef MatrixNd_t::Index Idx_t;
    for (Idx_t row_idx = Idx_t{0}; row_idx < mat.rows(); ++row_idx)
    {
        for (Idx_t col_idx = Idx_t{0}; col_idx < mat.cols(); ++col_idx)
        {
            if (std::isnan(mat(row_idx, col_idx)))
            {
                return TRUE;
            }
        }
    }

    return FALSE;
}

bool_t IsNormalizedVector(const VectorNd_t &input, const real_t epsilon)
{
    return math::IsApprox(math::real_t{1.0}, input.norm(), epsilon);
}

bool_t IsNormalizedQuaternion(const Quaternion_t &input, const real_t epsilon)
{
    return math::IsApprox(math::real_t{1.0}, input.norm(), epsilon);
}

bool_t IsValidRotation(
        const RotMat3d_t &rot_mat,
        const real_t epsilon
        )
{
    if (math::IsNan(rot_mat))
    {
        return FALSE;
    }

    static const RotMat3d_t::RealScalar kOne = RotMat3d_t::RealScalar{1.0};
    bool_t is_valid_determinant = fabs(boost::numeric_cast<float64_t>(rot_mat.determinant() - kOne)) < boost::numeric_cast<float64_t>(epsilon);

    return is_valid_determinant;
}

template<typename Scalar>
bool_t IsDiffSign(const Scalar &input_1st, const Scalar &input_2nd)
{
    const bool_t is_diff_sign
        = (input_1st > Scalar{0} && input_2nd < Scalar{0})
        || (input_1st < Scalar{0} && input_2nd > Scalar{0});

    return is_diff_sign;
}
template bool_t IsDiffSign(const int32_t &, const int32_t &);
template bool_t IsDiffSign(const float32_t &, const float32_t &);
template bool_t IsDiffSign(const float64_t &, const float64_t &);

template<typename Scalar>
bool_t IsInRange(const Scalar &value, const Scalar &low, const Scalar &high)
{
    if (low > high)
    {
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return !(value < low) && (value < high);
}
template bool_t IsInRange(const int32_t &, const int32_t &, const int32_t &);
template bool_t IsInRange(const float32_t &, const float32_t &, const float32_t &);
template bool_t IsInRange(const float64_t &, const float64_t &, const float64_t &);

RotMat3d_t ToUnitAxis(
        const RotMat3d_t &rotmat,
        const AxisDir_t &axis_dir
        )
{
    const Quaternion_t input_quat(rotmat);
    const Quaternion_t::RealScalar half_theta = acos(input_quat.w());
    const Quaternion_t::RealScalar designate_axis_value = sin(half_theta);
    const Quaternion_t::RealScalar other_axis_value = Quaternion_t::RealScalar{0.0};

    Quaternion_t unit_axis_quat(Quaternion_t::Identity());
    switch (axis_dir)
    {
        case AxisDir::PositiveX:
        case AxisDir::NegativeX:
            unit_axis_quat = Quaternion_t(
                    input_quat.w(),
                    designate_axis_value,
                    other_axis_value,
                    other_axis_value
                    ).normalized();
            break;

        case AxisDir::PositiveY:
        case AxisDir::NegativeY:
            unit_axis_quat = Quaternion_t(
                    input_quat.w(),
                    other_axis_value,
                    designate_axis_value,
                    other_axis_value
                    ).normalized();
            break;

        case AxisDir::PositiveZ:
        case AxisDir::NegativeZ:
            unit_axis_quat = Quaternion_t(
                    input_quat.w(),
                    other_axis_value,
                    other_axis_value,
                    designate_axis_value
                    ).normalized();
            break;

//        case AxisDir::NegativeX:
//            unit_axis_quat = Quaternion_t(
//                    input_quat.w(),
//                    -designate_axis_value,
//                    other_axis_value,
//                    other_axis_value
//                    ).normalized();
//            break;
//
//        case AxisDir::NegativeY:
//            unit_axis_quat = Quaternion_t(
//                    input_quat.w(),
//                    other_axis_value,
//                    -designate_axis_value,
//                    other_axis_value
//                    ).normalized();
//            break;
//
//        case AxisDir::NegativeZ:
//            unit_axis_quat = Quaternion_t(
//                    input_quat.w(),
//                    other_axis_value,
//                    other_axis_value,
//                    -designate_axis_value
//                    ).normalized();
            break;

        default:
            //console::log(ERR) << "invalid axis_dir: " << axis_dir << std::endl;
            throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
            break;
    }

    RotMat3d_t unit_axis_rotmat = unit_axis_quat.toRotationMatrix();

    static const EpsilonPrecision_t kEpsPrec(math::ValidRotationEpsilon());
    if (!math::IsValidRotation(unit_axis_rotmat, kEpsPrec.epsilon()))
    {
        //console::log(ERR, kEpsPrec.precision_digits())
        //    << "invalid rotation matrix after modifying " << axis_dir << NEWLINE
        //    << unit_axis_rotmat << NEWLINE
        //    << "is nan: " << std::boolalpha << math::IsNan(unit_axis_rotmat) << NEWLINE
        //    << "determinant: " << unit_axis_rotmat.determinant() << NEWLINE
        //    << std::endl;
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return unit_axis_rotmat;
}

bool_t IsUnitAxis(
        const RotMat3d_t &rotmat,
        const AxisDir_t &axis_dir,
        const RotMat3d_t::RealScalar &epsilon
        )
{
    if (AxisDir::Null == axis_dir)
    {
        //console::log(WARN) << "axis_dir is " << axis_dir << std::endl;
        return FALSE;
    }
    static const std::map<AxisDir_t, Vector3d_t> kUnitAxisMap =
    {
        {AxisDir::PositiveX, math::UnitX()},
        {AxisDir::PositiveY, math::UnitY()},
        {AxisDir::PositiveZ, math::UnitZ()},
        {AxisDir::NegativeX, -math::UnitX()},
        {AxisDir::NegativeY, -math::UnitY()},
        {AxisDir::NegativeZ, -math::UnitZ()},
    };
    static const std::map<AxisDir_t, Dof3dIdx_t> kDofIdxMap =
    {
        {AxisDir::PositiveX, Dof3d::X},
        {AxisDir::PositiveY, Dof3d::Y},
        {AxisDir::PositiveZ, Dof3d::Z},
        {AxisDir::NegativeX, Dof3d::X},
        {AxisDir::NegativeY, Dof3d::Y},
        {AxisDir::NegativeZ, Dof3d::Z},
    };

    return math::IsApprox(
            kUnitAxisMap.at(axis_dir),
            rotmat.col(*(kDofIdxMap.at(axis_dir))),
            epsilon
            );
}

std::string PrintSize(const MatrixNd_t &input)
{
    std::ostringstream ostream;
    ostream << "(" << input.rows() << ", " << input.cols() << ")";
    return ostream.str();
}

template<typename InputMatrix_t>
std::vector<InputMatrix_t> Plus(
        const std::vector<InputMatrix_t> &left_mat_coll,
        const std::vector<InputMatrix_t> &right_mat_coll
        )
{
    const bool_t is_equal_size = left_mat_coll.size() == right_mat_coll.size();

    if (!is_equal_size)
    {
        //console::log(ERR) << "diff. size" << NEWLINE
        //    << "left: " << left_mat_coll.size() << NEWLINE
        //    << "right: " << right_mat_coll.size() << NEWLINE
        //    << std::endl;
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    std::vector<InputMatrix_t> output(left_mat_coll.size());
    std::transform(
            left_mat_coll.begin(),
            left_mat_coll.end(),
            right_mat_coll.begin(),
            output.begin(),
            [](const InputMatrix_t &left_mat, const InputMatrix_t &right_mat)
            {return left_mat + right_mat;}
            );

    return output;
}
template std::vector<Vector3d_t> Plus(const std::vector<Vector3d_t> &, const std::vector<Vector3d_t> &);
template std::vector<VectorNd_t> Plus(const std::vector<VectorNd_t> &, const std::vector<VectorNd_t> &);
template std::vector<MatrixNd_t> Plus(const std::vector<MatrixNd_t> &, const std::vector<MatrixNd_t> &);

template<typename InputMatrix_t>
std::vector<InputMatrix_t> Minus(
        const std::vector<InputMatrix_t> &left_mat_coll,
        const std::vector<InputMatrix_t> &right_mat_coll
        )
{
    const bool_t is_equal_size = left_mat_coll.size() == right_mat_coll.size();

    if (!is_equal_size)
    {
        //console::log(ERR) << "diff. size" << NEWLINE
        //    << "left: " << left_mat_coll.size() << NEWLINE
        //    << "right: " << right_mat_coll.size() << NEWLINE
        //    << std::endl;
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    std::vector<InputMatrix_t> output(left_mat_coll.size());
    std::transform(
            left_mat_coll.begin(),
            left_mat_coll.end(),
            right_mat_coll.begin(),
            output.begin(),
            [](const InputMatrix_t &left_mat, const InputMatrix_t &right_mat)
            {return left_mat - right_mat;}
            );

    return output;
}
template std::vector<Vector3d_t> Minus(const std::vector<Vector3d_t> &, const std::vector<Vector3d_t> &);
template std::vector<VectorNd_t> Minus(const std::vector<VectorNd_t> &, const std::vector<VectorNd_t> &);
template std::vector<MatrixNd_t> Minus(const std::vector<MatrixNd_t> &, const std::vector<MatrixNd_t> &);

template<typename InputMatrix_t>
std::vector<InputMatrix_t> Scale(const std::vector<InputMatrix_t> &input_coll, const math::real_t scale)
{
    std::vector<InputMatrix_t> output_coll(input_coll.size());
    std::transform(
            input_coll.begin(),
            input_coll.end(),
            output_coll.begin(),
            [&scale](const InputMatrix_t &input)
            {return input * scale;}
            );

    return output_coll;
}
template std::vector<Vector3d_t> Scale(const std::vector<Vector3d_t> &, const math::real_t);
template std::vector<VectorNd_t> Scale(const std::vector<VectorNd_t> &, const math::real_t);
template std::vector<MatrixNd_t> Scale(const std::vector<MatrixNd_t> &, const math::real_t);


} // namespace math {
