#include <math_quadratic_bezier_curve.h>
#include <stdexcept>
#include <ros/console.h>
#include <math_utils.h>

namespace math {

// public func.

QuadraticBezierCurve::QuadraticBezierCurve()
{
}

QuadraticBezierCurve::~QuadraticBezierCurve()
{
}

Vector3dColl_t QuadraticBezierCurve::Compute(
        const Vector3d_t &point_1st,
        const Vector3d_t &point_2nd,
        const Vector3d_t &point_3rd,
        const int32_t size
        ) const
{
    if (size <= int32_t{0})
    {
        ROS_ERROR_STREAM("zero size: " << size);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    const real_t step = math::Reciprocal(static_cast<real_t>(size));
    Vector3dColl_t output;
    output.reserve(size);
    for (int32_t idx{0}; idx < size; ++idx)
    {
        const real_t step_ratio = step * static_cast<real_t>(idx);
        const math::Vector3d_t interpolated_point =
            point_2nd +
            math::Square(1.0 - step_ratio) * (point_1st - point_2nd) +
            math::Square(step_ratio) * (point_3rd - point_2nd);
        output.push_back(interpolated_point);
    }

    return output;
}

// protected func.

// private func.

} // namespace math {
