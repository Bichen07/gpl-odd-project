#ifndef _UTILS_DESIRED_FREQUENCY_EVALUATOR_H_
#define _UTILS_DESIRED_FREQUENCY_EVALUATOR_H_

#include <math_type.h>

namespace utils {

class DesiredFrequencyEvaluator final
{
    static constexpr math::real_t DefaultSamplingTime()
    {return math::real_t{0.01};}

public:

    DesiredFrequencyEvaluator();
    explicit DesiredFrequencyEvaluator(const math::real_t desiredFrequency);
    DesiredFrequencyEvaluator(const DesiredFrequencyEvaluator &) = delete;
    DesiredFrequencyEvaluator &operator=(const DesiredFrequencyEvaluator &) = delete;
    virtual ~DesiredFrequencyEvaluator() = default;

    math::real_t GetDesiredFrequency() const;

    void Configure(const math::real_t desiredFrequency);
    bool CanTriggerEvent();

protected:

private:

    math::real_t mPreviousTimeStamp;
    math::real_t mDesiredFrequency;
};

} // namespace utils {

#endif // #ifndef _UTILS_DESIRED_FREQUENCY_EVALUATOR_H_
