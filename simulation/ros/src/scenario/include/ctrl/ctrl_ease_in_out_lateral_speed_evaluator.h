#ifndef _CTRL_EASE_IN_OUT_LATERAL_SPEED_EVALUATOR_H_
#define _CTRL_EASE_IN_OUT_LATERAL_SPEED_EVALUATOR_H_

#include <math_type.h>
#include <actor_agent.h>

namespace ctrl {

class EaseInOutLateralSpeedEvaluator final
{

public:

    EaseInOutLateralSpeedEvaluator();
    EaseInOutLateralSpeedEvaluator(const EaseInOutLateralSpeedEvaluator &) = delete;
    EaseInOutLateralSpeedEvaluator &operator=(const EaseInOutLateralSpeedEvaluator &) = delete;
    virtual ~EaseInOutLateralSpeedEvaluator();

    void Configure(
        const math::real_t timeStep,
        const math::real_t desiredSpeed,
        const math::real_t initPosition,
        const math::real_t targetPosition);
    math::real_t Compute(const actor::Agent &agent);

protected:

private:

    math::real_t mTimeStep;
    math::real_t mDesiredSpeed;
    math::real_t mInitPosition;
    math::real_t mTargetPosition;

    int32_t mIdx;
    std::vector<math::real_t> mEaseInOutSpeeds;
};

} // namespace ctrl {

#endif // #ifndef _CTRL_EASE_IN_OUT_LATERAL_SPEED_EVALUATOR_H_
