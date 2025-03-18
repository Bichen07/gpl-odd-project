#ifndef _MATH_CATMULL_ROM_SPLINE_INTERPOLATOR_H_
#define _MATH_CATMULL_ROM_SPLINE_INTERPOLATOR_H_

#include "math_def.h"
#include "math_type.h"

namespace math {

class CatmullRomSplineInterpolator final
{
    static constexpr real_t default_tension()
    {return real_t{0.5};}

public:

    CatmullRomSplineInterpolator();
    CatmullRomSplineInterpolator(const CatmullRomSplineInterpolator &) = delete;
    CatmullRomSplineInterpolator &operator=(const CatmullRomSplineInterpolator &) = delete;
    virtual ~CatmullRomSplineInterpolator();

    math::Vector3dColl_t Compute(
            const math::Vector3d_t &point_1st,
            const math::Vector3d_t &point_2nd,
            const math::Vector3d_t &point_3rd,
            const math::Vector3d_t &point_4th,
            const int32_t size,
            const math::real_t tension = default_tension()
            ) const;

protected:

private:

    math::MatrixNd_t ComputeCoefMat(const math::real_t ratio) const;
    math::MatrixNd_t ComputeBasisMat(const math::real_t tension) const;
    math::MatrixNd_t ComputeControlVectorMat(
            const math::Vector3d_t &point_1st,
            const math::Vector3d_t &point_2nd,
            const math::Vector3d_t &point_3rd,
            const math::Vector3d_t &point_4th
            ) const;
};

} // namespace math {

#endif // #ifndef _MATH_CATMULL_ROM_SPLINE_INTERPOLATOR_H_
