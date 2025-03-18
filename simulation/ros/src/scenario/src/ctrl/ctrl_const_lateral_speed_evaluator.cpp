#include <ctrl_const_lateral_speed_evaluator.h>
#include <stdexcept>
#include <ros/console.h>
#include <math_utils.h>

namespace ctrl {

// public func.

ConstLateralSpeedEvaluator::ConstLateralSpeedEvaluator()
    : mTimeStep{0.0}
    , mDesiredSpeed{0.0}
    , mInitLateralPosition{0.0}
    , mTargetLateralPosition{0.0}
{
}

ConstLateralSpeedEvaluator::~ConstLateralSpeedEvaluator()
{
}

math::real_t ConstLateralSpeedEvaluator::GetDesiredSpeed() const
{
    return mDesiredSpeed;
}

math::real_t ConstLateralSpeedEvaluator::GetInitLateralPosition() const
{
    return mInitLateralPosition;
}

math::real_t ConstLateralSpeedEvaluator::GetTargetLateralPosition() const
{
    return mTargetLateralPosition;
}

void ConstLateralSpeedEvaluator::Configure(
    const math::real_t timeStep,
    const math::real_t desiredSpeed,
    const math::real_t initLateralPosition,
    const math::real_t targetLateralPosition)
{
    if (timeStep < math::real_t{1.0e-6})
    {
        ROS_ERROR_STREAM("invalid timeStep: " << timeStep);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    mTimeStep = timeStep;
    mDesiredSpeed = desiredSpeed;
    mInitLateralPosition = initLateralPosition;
    mTargetLateralPosition = targetLateralPosition;

    const math::real_t movingVector = mTargetLateralPosition - mInitLateralPosition;
    if (std::signbit(mDesiredSpeed) != std::signbit(movingVector))
    {
        ROS_ERROR_STREAM(
            "diff. direction between desiredSpeed and moving vector" << '\n' <<
            "deisredSpeed: " << desiredSpeed << '\n' <<
            "movingVector: " << movingVector << '\n' <<
            "initLateralPosition: " << initLateralPosition << '\n' <<
            "targetLateralPosition: " << targetLateralPosition);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }
}

math::real_t ConstLateralSpeedEvaluator::Compute(const actor::Agent &agent)
{
    const bool isReachingTargetPosition = math::IsApprox(
        mTargetLateralPosition,
        agent.GetFrenetState().position.d(),
        1.0e-3);
    if (isReachingTargetPosition)
    {
        //ROS_INFO_STREAM("isReachingTargetPosition");
        return 0.0;
    }

    const math::real_t nextLateralPosition =
        agent.GetFrenetState().position.d() +
        mTimeStep * mDesiredSpeed;

    math::real_t outputSpeed{mDesiredSpeed};
    if (mDesiredSpeed > 0.0)
    {
        if (nextLateralPosition > mTargetLateralPosition)
        {
            outputSpeed =
                (mTargetLateralPosition - agent.GetFrenetState().position.d()) / mTimeStep;
        }
    }
    else
    {
        if (nextLateralPosition < mTargetLateralPosition)
        {
            outputSpeed =
                (mTargetLateralPosition - agent.GetFrenetState().position.d()) / mTimeStep;
        }
    }

    return outputSpeed;
}

// protected func.

// private

} // namespace ctrl {
