#include <utils_time_step_evaluator.h>
#include <ros/time.h>

namespace utils {

// public func.

TimeStepEvaluator::TimeStepEvaluator()
    : mPreviousTime{0.0}
    , mCurrentTime{ros::Time::now().toSec()}
{
}

TimeStepEvaluator::~TimeStepEvaluator()
{
}

math::real_t TimeStepEvaluator::Compute()
{
    mPreviousTime = mCurrentTime;
    mCurrentTime = ros::Time::now().toSec();

    return mCurrentTime - mPreviousTime;
}

// protected func.

// private func.

} // namespace utils {
