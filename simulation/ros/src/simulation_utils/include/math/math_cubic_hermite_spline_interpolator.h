#ifndef _MATH_CUBIC_HERMITE_SPLINE_INTERPOLATOR_H_
#define _MATH_CUBIC_HERMITE_SPLINE_INTERPOLATOR_H_

#include "math_def.h"
#include <memory>
#include <utility>
#include "math_fwd.h"
#include "math_type.h"

namespace math {

class CubicHermiteSplineInterpolator final
{
    static constexpr real_t default_epsilon()
    {return real_t{1.0e-7};}

public:

    CubicHermiteSplineInterpolator();
    CubicHermiteSplineInterpolator(const CubicHermiteSplineInterpolator &) = delete;
    CubicHermiteSplineInterpolator &operator=(const CubicHermiteSplineInterpolator &) = delete;
    virtual ~CubicHermiteSplineInterpolator();

    math::Vector3dColl_t Compute(
            const Vector3d_t &begin_tangent, // m1
            const Vector3d_t &begin_point,   // p1
            const Vector3d_t &end_point,     // p2
            const Vector3d_t &end_tangent,   // m2
            const int32_t size
            ) const;

    math::Vector3d_t ComputePos(
            const Vector3d_t &begin_tangent, // m1
            const Vector3d_t &begin_point,   // p1
            const Vector3d_t &end_point,     // p2
            const Vector3d_t &end_tangent,   // m2
            const real_t step_ratio
            ) const;
    math::Vector3d_t ComputeFirstDerivative(
            const Vector3d_t &begin_tangent, // m1
            const Vector3d_t &begin_point,   // p1
            const Vector3d_t &end_point,     // p2
            const Vector3d_t &end_tangent,   // m2
            const real_t step_ratio
            ) const;
    math::Vector3d_t ComputeSecondDerivative(
            const Vector3d_t &begin_tangent, // m1
            const Vector3d_t &begin_point,   // p1
            const Vector3d_t &end_point,     // p2
            const Vector3d_t &end_tangent,   // m2
            const real_t step_ratio
            ) const;

protected:

private:

    static constexpr real_t unit_step_ratio()
    {return real_t{1.0};}
    static constexpr real_t zero_step_ratio()
    {return real_t{0.0};}

    math::Vector3d_t ComputeStepRatioCubeTermCoef(
            const Vector3d_t &begin_tangent, // m1
            const Vector3d_t &begin_point,   // p1
            const Vector3d_t &end_point,     // p2
            const Vector3d_t &end_tangent    // m2
            ) const;
    math::Vector3d_t ComputeStepRatioSquareTermCoef(
            const Vector3d_t &begin_tangent, // m1
            const Vector3d_t &begin_point,   // p1
            const Vector3d_t &end_point,     // p2
            const Vector3d_t &end_tangent    // m2
            ) const;
    math::Vector3d_t ComputeStepRatioTermCoef(const math::Vector3d_t &begin_tangent) const;
    math::Vector3d_t ComputeConstantTermCoef(
            const math::Vector3d_t &begin_point,
            const math::Vector3d_t &interpolated_pos
            ) const;

    real_t SelectOptimalStepRatio() const;

    void VerifyStepRatio(const math::real_t step_ratio) const;

    //std::unique_ptr<CubicPolynomialSolver> cubic_polynomial_solver_;
    std::unique_ptr<EpsilonPrecision_t> eps_prec_;
};

} // namespace math {

#endif // #ifndef _MATH_CUBIC_HERMITE_SPLINE_INTERPOLATOR_H_
