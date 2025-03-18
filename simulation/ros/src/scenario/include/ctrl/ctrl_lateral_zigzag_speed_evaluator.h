#ifndef _CTRL_LATERAL_ZIGZAG_SPEED_EVALUATOR_H_
#define _CTRL_LATERAL_ZIGZAG_SPEED_EVALUATOR_H_

#include <math_sine_wave_evaluator.h>

namespace ctrl {

class LateralZigzagSpeedEvaluator final
{

public:

    LateralZigzagSpeedEvaluator();
    LateralZigzagSpeedEvaluator(const LateralZigzagSpeedEvaluator &) = delete;
    LateralZigzagSpeedEvaluator &operator=(const LateralZigzagSpeedEvaluator &) = delete;
    virtual ~LateralZigzagSpeedEvaluator();

    void Configure(
        const math::real_t maxSpeed,
        const math::real_t minSpeed,
        const math::real_t ordinaryFrequency,
        const math::real_t phaseRadian);
    math::real_t Compute(const math::real_t time);

protected:

private:

    math::SineWaveEvaluator mSineWaveEvaluator;
};

} // namespace ctrl {

#endif // #ifndef _CTRL_LATERAL_ZIGZAG_SPEED_EVALUATOR_H_
