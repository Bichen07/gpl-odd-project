#include <ctrl_ease_in_out_lateral_speed_evaluator.h>
#include <stdexcept>
#include <ros/console.h>
#include <math_ease_in_out_generator.h>
#include <math_utils.h>

namespace ctrl {

// public func.

EaseInOutLateralSpeedEvaluator::EaseInOutLateralSpeedEvaluator()
    : mTimeStep{0.0}
    , mDesiredSpeed{0.0}
    , mInitPosition{0.0}
    , mTargetPosition{0.0}

    , mIdx{0}
    , mEaseInOutSpeeds{}
{
}

EaseInOutLateralSpeedEvaluator::~EaseInOutLateralSpeedEvaluator()
{
}

void EaseInOutLateralSpeedEvaluator::Configure(
    const math::real_t timeStep,
    const math::real_t desiredSpeed,
    const math::real_t initPosition,
    const math::real_t targetPosition)
{
    if (timeStep < math::real_t{1.0e-6})
    {
        ROS_ERROR_STREAM("invalid timeStep: " << timeStep);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    mTimeStep = timeStep;
    mDesiredSpeed = desiredSpeed;
    mInitPosition = initPosition;
    mTargetPosition = targetPosition;

    const math::real_t movingVector = mTargetPosition - mInitPosition;
    if (std::signbit(mDesiredSpeed) != std::signbit(movingVector))
    {
        ROS_ERROR_STREAM(
            "diff. direction between desiredSpeed and moving vector" << '\n' <<
            "deisredSpeed: " << desiredSpeed << '\n' <<
            "movingVector: " << movingVector << '\n' <<
            "initPosition: " << initPosition << '\n' <<
            "targetPosition: " << targetPosition);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    const math::real_t movingTime = std::fabs(movingVector / mDesiredSpeed);
    const int32_t weightSize = std::lround(movingTime / mTimeStep);
    if (0 == weightSize)
    {
        return;
    }

    math::EaseInOutGenerator easeInOutGenerator;
    const auto easeInOutWeights = easeInOutGenerator.ComputeQuadraticInOutWeight(
        weightSize,
        true);

    mEaseInOutSpeeds.resize(easeInOutWeights.size());
    auto speed{mEaseInOutSpeeds.begin()};
    *speed = math::real_t{0.0};
    ++speed;
    for (auto weight{easeInOutWeights.cbegin() + 1};
         weight != easeInOutWeights.cend();
         ++weight)
    {
        const math::real_t stepDistance = movingVector * (*weight - *(weight - 1));
        *speed = stepDistance / mTimeStep;
        ++speed;
    }
}

math::real_t EaseInOutLateralSpeedEvaluator::Compute(const actor::Agent &agent)
{
    if (mEaseInOutSpeeds.empty())
    {
        return math::real_t{0.0};
    }

    const bool isReachingTargetPosition = math::IsApprox(
        mTargetPosition,
        agent.GetFrenetState().position.d(),
        1.0e-3);
    if (isReachingTargetPosition)
    {
        return 0.0;
    }

    math::real_t outputSpeed{0.0};
    if (mIdx < static_cast<int32_t>(mEaseInOutSpeeds.size()))
    {
        outputSpeed = mEaseInOutSpeeds.at(mIdx);

        const math::real_t nextPosition =
            agent.GetFrenetState().position.d() +
            mTimeStep * outputSpeed;

        if (mDesiredSpeed > 0.0)
        {
            if (nextPosition > mTargetPosition)
            {
                outputSpeed = (mTargetPosition - agent.GetFrenetState().position.d()) / mTimeStep;
            }
        }
        else
        {
            if (nextPosition < mTargetPosition)
            {
                outputSpeed = (mTargetPosition - agent.GetFrenetState().position.d()) / mTimeStep;
            }
        }

        ++mIdx;
    }

    return outputSpeed;
}

// protected func.

// private func.

} // namespace ctrl {
