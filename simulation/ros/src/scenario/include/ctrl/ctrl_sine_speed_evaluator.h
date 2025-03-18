#ifndef _CTRL_SINE_SPEED_EVALUATOR_H_
#define _CTRL_SINE_SPEED_EVALUATOR_H_

#include <math_sine_wave_evaluator.h>

namespace ctrl {

class SineSpeedEvaluator final
{

public:

    SineSpeedEvaluator();
    SineSpeedEvaluator(const SineSpeedEvaluator &) = delete;
    SineSpeedEvaluator &operator=(const SineSpeedEvaluator &) = delete;
    virtual ~SineSpeedEvaluator();

    void Configure(
        const math::real_t timeStep,
        const math::real_t minSpeed,
        const math::real_t maxSpeed);
    math::real_t Compute(const math::real_t time);

protected:

private:

    math::SineWaveEvaluator mSineWaveEvaluator;
};

} // namespace ctrl {

#endif // #ifndef _CTRL_SINE_SPEED_EVALUATOR_H_
