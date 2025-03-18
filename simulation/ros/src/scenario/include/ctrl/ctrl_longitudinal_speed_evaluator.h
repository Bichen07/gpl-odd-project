#ifndef _CTRL_LONGITUDINAL_SPEED_EVALUATOR_H_
#define _CTRL_LONGITUDINAL_SPEED_EVALUATOR_H_

#include <math_type.h>

namespace ctrl {

class LongitudinalSpeedEvaluator final
{

public:

    LongitudinalSpeedEvaluator();
    LongitudinalSpeedEvaluator(const LongitudinalSpeedEvaluator &) = delete;
    LongitudinalSpeedEvaluator &operator=(const LongitudinalSpeedEvaluator &) = delete;
    virtual ~LongitudinalSpeedEvaluator();

    math::real_t Compute(
        const math::real_t timeStep,
        const math::real_t currentSpeed,
        const math::real_t desiredSpeed,
        const math::real_t desiredAcceleration);

protected:

private:

};

} // namespace ctrl {

#endif // #ifndef _CTRL_LONGITUDINAL_SPEED_EVALUATOR_H_
