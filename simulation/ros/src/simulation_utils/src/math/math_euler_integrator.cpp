#include "math_euler_integrator.h"
#include <stdexcept>

namespace math {

// public func.

EulerIntegrator::EulerIntegrator()
{
}

EulerIntegrator::EulerIntegrator(const EulerIntegrator &other)
{
}

EulerIntegrator &EulerIntegrator::operator=(const EulerIntegrator &other)
{
    if (&other == this)
    {
        return *this;
    }

    return *this;
}

EulerIntegrator::~EulerIntegrator()
{
}

real_t EulerIntegrator::Compute(
        const real_t gradient,
        const real_t step,
        const real_t init_value
        ) const
{
    if (step < math::real_t{0.0})
    {
        //console::log(ERR) << "invalid step " << step << std::endl;
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return init_value + gradient * step;
}

// protected func.

// private func.

} // namespace math {
