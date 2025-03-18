#include <ctrl_lateral_zigzag_speed_evaluator.h>
#include <ros/console.h>

namespace ctrl {

LateralZigzagSpeedEvaluator::LateralZigzagSpeedEvaluator()
{
}

LateralZigzagSpeedEvaluator::~LateralZigzagSpeedEvaluator()
{
}

void LateralZigzagSpeedEvaluator::Configure(
    const math::real_t maxSpeed,
    const math::real_t minSpeed,
    const math::real_t ordinaryFrequency,
    const math::real_t phaseRadian)
{
    const math::real_t amplitude{0.5 * (maxSpeed - minSpeed)};
    const math::real_t centerAmplitude{0.5 * (maxSpeed + minSpeed)};
    mSineWaveEvaluator.Configure(
        amplitude,
        ordinaryFrequency,
        phaseRadian,
        centerAmplitude);
}

math::real_t LateralZigzagSpeedEvaluator::Compute(const math::real_t time)
{
    return mSineWaveEvaluator.Compute(time);
}

} // namespace ctrl {
