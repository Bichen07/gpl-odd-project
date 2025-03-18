#ifndef _MATH_EULER_INTEGRATOR_H_
#define _MATH_EULER_INTEGRATOR_H_

#include "math_type.h"

namespace math {

class EulerIntegrator final
{

public:

    EulerIntegrator();
    EulerIntegrator(const EulerIntegrator &other);
    EulerIntegrator &operator=(const EulerIntegrator &other);
    virtual ~EulerIntegrator();

    //virtual VectorNd_t Compute(
    //        const VectorNd_t &gradient,
    //        const real_t step,
    //        const VectorNd_t &init_value
    //        ) const override;
    real_t Compute(
            const real_t gradiant,
            const real_t step,
            const real_t init_value
            ) const;

protected:

private:

};

} // namespace math {

#endif // #ifndef _MATH_EULER_INTEGRATOR_H_
