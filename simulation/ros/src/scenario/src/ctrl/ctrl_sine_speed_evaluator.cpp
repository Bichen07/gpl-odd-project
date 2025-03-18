#include <ctrl_sine_speed_evaluator.h>
#include <ros/console.h>

namespace ctrl {

// public func.

SineSpeedEvaluator::SineSpeedEvaluator()
    : mSineWaveEvaluator{}
{
}

SineSpeedEvaluator::~SineSpeedEvaluator()
{
}

void SineSpeedEvaluator::Configure(
    const math::real_t timeStep,
    const math::real_t minSpeed,
    const math::real_t maxSpeed)
{
    const math::real_t amplitude{0.5 * (maxSpeed - minSpeed)};
    const math::real_t ordinaryFrequency{0.5};
    const math::real_t phaseRadian{0.0};
    const math::real_t centerAmplitude{0.5 * (maxSpeed + minSpeed)};
    //ROS_INFO_STREAM('\n' <<
    //    "minSpeed: " << minSpeed << '\n' <<
    //    "maxSpeed: " << maxSpeed << '\n' <<
    //    "amplitude: " << amplitude << '\n' <<
    //    "centerAmplitude: " << centerAmplitude);

    mSineWaveEvaluator.Configure(
        amplitude,
        ordinaryFrequency,
        phaseRadian,
        centerAmplitude);
}

math::real_t SineSpeedEvaluator::Compute(const math::real_t time)
{
    return mSineWaveEvaluator.Compute(time);
}

// protected func.

// private func.

} // namespace ctrl {
