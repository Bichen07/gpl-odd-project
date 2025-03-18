#ifndef _UTILS_TIME_STEP_EVALUATOR_H_
#define _UTILS_TIME_STEP_EVALUATOR_H_

#include <math_type.h>

namespace utils {

class TimeStepEvaluator final
{

public:

    TimeStepEvaluator();
    TimeStepEvaluator(const TimeStepEvaluator &) = delete;
    TimeStepEvaluator &operator=(const TimeStepEvaluator &) = delete;
    virtual ~TimeStepEvaluator();

    math::real_t Compute();

protected:

private:

    math::real_t mPreviousTime;
    math::real_t mCurrentTime;
};

} // namespace utils {

#endif // #ifndef _UTILS_TIME_STEP_EVALUATOR_H_
