#ifndef _UTILS_APPROXIMATION_EVALUATOR_H_
#define _UTILS_APPROXIMATION_EVALUATOR_H_

#include <math_type.h>

namespace utils {

template<typename ObjectType>
class ApproximationEvaluator final
{

public:

    static constexpr math::real_t DefaultEpsilon()
    {return math::real_t{1.0e-6};}

    ApproximationEvaluator();
    explicit ApproximationEvaluator(const math::real_t epsilon);
    ApproximationEvaluator(const ApproximationEvaluator &other);
    ApproximationEvaluator &operator=(const ApproximationEvaluator &other);
    virtual ~ApproximationEvaluator();

    math::real_t GetEpsilon() const;
    const ObjectType &GetPreviousObject() const;

    bool Compute(const ObjectType &updatedObject);
    void Configure(const math::real_t epsilon);

protected:

private:

    math::real_t mEpsilon;
    ObjectType mPreviousObject;
};

} // namespace utils {

#endif // #ifndef _UTILS_APPROXIMATION_EVALUATOR_H_
