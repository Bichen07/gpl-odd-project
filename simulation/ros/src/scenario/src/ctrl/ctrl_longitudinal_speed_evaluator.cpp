#include <ctrl_longitudinal_speed_evaluator.h>
#include <math_utils.h>

namespace ctrl {

// public func.

LongitudinalSpeedEvaluator::LongitudinalSpeedEvaluator()
{
}

LongitudinalSpeedEvaluator::~LongitudinalSpeedEvaluator()
{
}

math::real_t LongitudinalSpeedEvaluator::Compute(
    const math::real_t timeStep,
    const math::real_t currentSpeed,
    const math::real_t desiredSpeed,
    const math::real_t desiredAcceleration)
{
    if (math::IsApproxZero(desiredAcceleration, 1.0e-6))
    {
        return currentSpeed;
    }

    const math::real_t nextSpeed = currentSpeed + timeStep * desiredAcceleration;
    if (desiredAcceleration > 0.0)
    {
        if (nextSpeed < desiredSpeed)
        {
            return nextSpeed;
        }
    }
    else
    {
        if (nextSpeed > desiredSpeed)
        {
            return nextSpeed;
        }
    }

    return desiredSpeed;
}

// protected func.

// private func.

} // namespace ctrl {
