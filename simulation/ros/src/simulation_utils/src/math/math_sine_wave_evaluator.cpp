#include <math_sine_wave_evaluator.h>
#include <cmath>
#include <math_utils.h>

namespace math {

// public func.

SineWaveEvaluator::SineWaveEvaluator()
    :amplitude_{0.0},
    ordinary_frequency_{0.0},
    phase_radian_{0.0},
    center_amplitude_{0.0}
{
}

SineWaveEvaluator::~SineWaveEvaluator()
{
}

void SineWaveEvaluator::Configure(
    const real_t amplitude,
    const real_t ordinary_frequency,
    const real_t phase_radian,
    const real_t center_amplitude)
{
    amplitude_ = amplitude;
    ordinary_frequency_ = ordinary_frequency;
    phase_radian_ = phase_radian;
    center_amplitude_ = center_amplitude;
}

real_t SineWaveEvaluator::Compute(const real_t time) const
{
    return std::sin(math::TwoPi<real_t>() * ordinary_frequency_ * time + phase_radian_) *
        amplitude_ +
        center_amplitude_;
}

// protected func.

// private func.

} // namespace math {
