#include <utils_desired_frequency_evaluator.h>
#include <stdexcept>
#include <ros/time.h>
#include <ros/console.h>
#include <math_utils.h>

namespace utils {

// public func.

DesiredFrequencyEvaluator::DesiredFrequencyEvaluator()
    : mPreviousTimeStamp{ros::Time::now().toSec()}
    , mDesiredFrequency{math::real_t{1.0}}
{
}

DesiredFrequencyEvaluator::DesiredFrequencyEvaluator(const math::real_t desiredFrequency)
    : mPreviousTimeStamp{ros::Time::now().toSec()}
    , mDesiredFrequency{desiredFrequency}
{
    if (math::IsLessThanOrApprox(desiredFrequency, math::real_t{0.0}, math::real_t{1.0-6}))
    {
        ROS_ERROR_STREAM(
            "invalid desiredFrequency: " << desiredFrequency << '\n' <<
            "desiredFrequency shall >= 0");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }
}

math::real_t DesiredFrequencyEvaluator::GetDesiredFrequency() const
{
    return mDesiredFrequency;
}

void DesiredFrequencyEvaluator::Configure(const math::real_t desiredFrequency)
{
    mDesiredFrequency = desiredFrequency;
}

bool DesiredFrequencyEvaluator::CanTriggerEvent()
{
    const math::real_t currentTime{ros::Time::now().toSec()};
    const bool canTrigger =
        (currentTime - mPreviousTimeStamp) >
        math::real_t{1.0} / mDesiredFrequency - DefaultSamplingTime();
    mPreviousTimeStamp = canTrigger ? currentTime : mPreviousTimeStamp;

    return canTrigger;
}

// protected func.

// private func.

} // namespace utils {
