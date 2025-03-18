#ifndef _MATH_QUADRATIC_BEZIER_CURVE_H_
#define _MATH_QUADRATIC_BEZIER_CURVE_H_

#include "math_def.h"
#include "math_type.h"

namespace math {

class QuadraticBezierCurve final
{

public:

    QuadraticBezierCurve();
    QuadraticBezierCurve(const QuadraticBezierCurve &) = delete;
    QuadraticBezierCurve &operator=(const QuadraticBezierCurve &) = delete;
    virtual ~QuadraticBezierCurve();

    Vector3dColl_t Compute(
        const Vector3d_t &point_1st,
        const Vector3d_t &point_2nd,
        const Vector3d_t &point_3rd,
        const int32_t size
        ) const;

protected:

private:

};

} // namespace math {

#endif // #ifndef _MATH_QUADRATIC_BEZIER_CURVE_H_
