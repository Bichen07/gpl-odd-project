#ifndef _CTRL_CONST_LATERAL_SPEED_EVALUATOR_H_
#define _CTRL_CONST_LATERAL_SPEED_EVALUATOR_H_

#include <math_type.h>
#include <actor_agent.h>

namespace ctrl {

class ConstLateralSpeedEvaluator final
{

public:

    ConstLateralSpeedEvaluator();
    ConstLateralSpeedEvaluator(const ConstLateralSpeedEvaluator &) = delete;
    ConstLateralSpeedEvaluator &operator=(const ConstLateralSpeedEvaluator &) = delete;
    virtual ~ConstLateralSpeedEvaluator();

    math::real_t GetDesiredSpeed() const;
    math::real_t GetInitLateralPosition() const;
    math::real_t GetTargetLateralPosition() const;

    void Configure(
        const math::real_t timeStep,
        const math::real_t desiredSpeed,
        const math::real_t initLateralPosition,
        const math::real_t targetLateralPosition);
    math::real_t Compute(const actor::Agent &agent);

protected:

private:

    math::real_t mTimeStep;
    math::real_t mDesiredSpeed;
    math::real_t mInitLateralPosition;
    math::real_t mTargetLateralPosition;
};

} // namespace ctrl {

#endif // #ifndef _CTRL_CONST_LATERAL_SPEED_EVALUATOR_H_
