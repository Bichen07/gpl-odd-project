#ifndef _MATH_FRENET_VELOCITY_TRANSFORMER_H_
#define _MATH_FRENET_VELOCITY_TRANSFORMER_H_

#include "math_fwd.h"
#include "math_type.h"

namespace math {

class FrenetVelocityTransformer final
{
    static constexpr real_t default_epsilon()
    {return real_t{1.0e-6};}

public:

    FrenetVelocityTransformer();
    FrenetVelocityTransformer(const FrenetVelocityTransformer &) = delete;
    FrenetVelocityTransformer &operator=(const FrenetVelocityTransformer &) = delete;
    virtual ~FrenetVelocityTransformer();

    Vector2d_t ConvertToCartesianCoord(
        const FrenetCoord &frenet_velocity,
        const real_t heading_radian
        ) const;
    FrenetCoord ConvertToFrenetCoord(
        const Vector2d_t &cartesian_velocity,
        const real_t heading_radian
        ) const;

protected:

private:

};

} // namespace math {

#endif // #ifndef _MATH_FRENET_VELOCITY_TRANSFORMER_H_
