#include "math_cubic_hermite_spline_interpolator.h"
#include <stdexcept>
#include "boost/numeric/conversion/cast.hpp"
#include "math_utils.h"

namespace math {

// public func.

CubicHermiteSplineInterpolator::CubicHermiteSplineInterpolator()
    :eps_prec_(new math::EpsilonPrecision_t(default_epsilon()))
{
}

CubicHermiteSplineInterpolator::~CubicHermiteSplineInterpolator()
{
}

Vector3dColl_t CubicHermiteSplineInterpolator::Compute(
        const Vector3d_t &begin_tangent, // m1
        const Vector3d_t &begin_point,   // p1
        const Vector3d_t &end_point,     // p2
        const Vector3d_t &end_tangent,   // m2
        const int32_t size
        ) const
{
    const real_t unit_ratio = real_t{1.0} / boost::numeric_cast<real_t>(size);

    Vector3dColl_t output;
    output.reserve(size);

    for (int32_t idx = 0; idx < size; ++idx)
    {
        const real_t ratio = boost::numeric_cast<real_t>(idx) * unit_ratio;
        const real_t ratio_square = math::Square(ratio);
        const real_t ratio_cube = math::Cube(ratio);

        const Vector3d_t interpolated_point
            = (ratio_cube - real_t{2.0} * ratio_square + ratio) * begin_tangent
            + (real_t{2.0} * ratio_cube - real_t{3.0} * ratio_square + real_t{1.0}) * begin_point
            + (real_t{-2.0} * ratio_cube + real_t{3.0} * ratio_square) * end_point
            + (ratio_cube - ratio_square) * end_tangent;

        output.push_back(interpolated_point);
    }

    return output;
}

math::Vector3d_t CubicHermiteSplineInterpolator::ComputePos(
        const Vector3d_t &begin_tangent, // m1
        const Vector3d_t &begin_point,   // p1
        const Vector3d_t &end_point,     // p2
        const Vector3d_t &end_tangent,   // m2
        const real_t step_ratio
        ) const
{
    this->VerifyStepRatio(step_ratio);

    //const real_t ratio = boost::numeric_cast<real_t>(idx) * unit_ratio;
    const real_t step_ratio_square = math::Square(step_ratio);
    const real_t step_ratio_cube = math::Cube(step_ratio);

    const Vector3d_t interpolated_pos
        = (step_ratio_cube - real_t{2.0} * step_ratio_square + step_ratio) * begin_tangent
        + (real_t{2.0} * step_ratio_cube - real_t{3.0} * step_ratio_square + real_t{1.0}) * begin_point
        + (real_t{-2.0} * step_ratio_cube + real_t{3.0} * step_ratio_square) * end_point
        + (step_ratio_cube - step_ratio_square) * end_tangent;

    return interpolated_pos;
}

math::Vector3d_t CubicHermiteSplineInterpolator::ComputeFirstDerivative(
        const Vector3d_t &begin_tangent, // m1
        const Vector3d_t &begin_point,   // p1
        const Vector3d_t &end_point,     // p2
        const Vector3d_t &end_tangent,   // m2
        const real_t step_ratio
        ) const
{
    this->VerifyStepRatio(step_ratio);

    const real_t step_ratio_square = math::Square(step_ratio);

    const Vector3d_t first_derivative
        = (real_t{3.0} * step_ratio_square - real_t{4.0} * step_ratio + real_t{1.0}) * begin_tangent
        + (real_t{6.0} * step_ratio_square - real_t{6.0} * step_ratio) * begin_point
        + (real_t{-6.0} * step_ratio_square + real_t{6.0} * step_ratio) * end_point
        + (real_t{3.0} * step_ratio_square - real_t{2.0} * step_ratio) * end_tangent;

    return first_derivative;
}

math::Vector3d_t CubicHermiteSplineInterpolator::ComputeSecondDerivative(
        const Vector3d_t &begin_tangent, // m1
        const Vector3d_t &begin_point,   // p1
        const Vector3d_t &end_point,     // p2
        const Vector3d_t &end_tangent,   // m2
        const real_t step_ratio
        ) const
{
    this->VerifyStepRatio(step_ratio);

    const math::Vector3d_t second_derivative
        = (real_t{6.0} * step_ratio - real_t{4.0}) * begin_tangent
        + (real_t{12.0} * step_ratio - real_t{6.0}) * begin_point
        + (real_t{-12.0} * step_ratio + real_t{6.0}) * end_point
        + (real_t{6.0} * step_ratio - real_t{2.0}) * end_tangent;

    return second_derivative;
}

// protected func.

// private func.

math::Vector3d_t CubicHermiteSplineInterpolator::ComputeStepRatioCubeTermCoef(
        const Vector3d_t &begin_tangent, // m1
        const Vector3d_t &begin_point,   // p1
        const Vector3d_t &end_point,     // p2
        const Vector3d_t &end_tangent    // m2
        ) const
{
    return begin_tangent + real_t{2.0} * begin_point - real_t{2.0} * end_point + end_tangent;
}

math::Vector3d_t CubicHermiteSplineInterpolator::ComputeStepRatioSquareTermCoef(
        const Vector3d_t &begin_tangent, // m1
        const Vector3d_t &begin_point,   // p1
        const Vector3d_t &end_point,     // p2
        const Vector3d_t &end_tangent    // m2
        ) const
{
    return real_t{-2.0} * begin_tangent - real_t{3.0} * begin_point + real_t{3.0} * end_point - end_tangent;
}

math::Vector3d_t CubicHermiteSplineInterpolator::ComputeStepRatioTermCoef(const math::Vector3d_t &begin_tangent) const
{
    return begin_tangent;
}

math::Vector3d_t CubicHermiteSplineInterpolator::ComputeConstantTermCoef(
        const math::Vector3d_t &begin_point,
        const math::Vector3d_t &interpolated_pos
        ) const
{
    return begin_point - interpolated_pos;
}

void CubicHermiteSplineInterpolator::VerifyStepRatio(const math::real_t step_ratio) const
{
    //static constexpr int32_t kPrecisionDigits = int32_t{5};
    if (step_ratio < zero_step_ratio())
    {
        //console::log(ERR, eps_prec_->precision_digits())
        //    << "invalid step_ratio: " << step_ratio << NEWLINE
        //    << "step_ratio shall be greater or equal to 0.0" << NEWLINE
        //    << std::endl;
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    if (step_ratio > unit_step_ratio())
    {
        //console::log(ERR, eps_prec_->precision_digits())
        //    << "invalid step_ratio: " << step_ratio << NEWLINE
        //    << "step_ratio shall be smaller or equal to 1.0" << NEWLINE
        //    << std::endl;
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }
}

} // namespace math {
