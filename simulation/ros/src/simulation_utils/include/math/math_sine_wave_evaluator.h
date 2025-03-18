#ifndef _MATH_SINE_WAVE_EVALUATOR_H_
#define _MATH_SINE_WAVE_EVALUATOR_H_

#include <math_type.h>

namespace math {

class SineWaveEvaluator final
{

public:

    SineWaveEvaluator();
    SineWaveEvaluator(const SineWaveEvaluator &) = delete;
    SineWaveEvaluator &operator=(const SineWaveEvaluator &) = delete;
    virtual ~SineWaveEvaluator();

    void Configure(
        const real_t amplitude,
        const real_t ordinary_frequency,
        const real_t phase_radian,
        const real_t center_amplitude);

    real_t Compute(const real_t time) const;

protected:

private:


    real_t amplitude_;
    // the number of oscillations that occur each second of time
    real_t ordinary_frequency_;
    real_t phase_radian_;
    real_t center_amplitude_;
};

} // namespace math {

#endif // #ifndef _MATH_SINE_WAVE_EVALUATOR_H_
