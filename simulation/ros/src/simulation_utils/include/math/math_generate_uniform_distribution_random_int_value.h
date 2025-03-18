#ifndef _MATH_GENERATE_UNIFORM_DISTRIBUTION_RANDOM_INT_VALUE_H_
#define _MATH_GENERATE_UNIFORM_DISTRIBUTION_RANDOM_INT_VALUE_H_

#include "math_generate_random_int_value.h"

namespace math {

class GenerateUniformDistributionRandomIntValue final : public GenerateRandomIntValue
{

public:

    GenerateUniformDistributionRandomIntValue();
    GenerateUniformDistributionRandomIntValue(const int32_t min_value, const int32_t max_value);
    GenerateUniformDistributionRandomIntValue(const GenerateUniformDistributionRandomIntValue &) = delete;
    GenerateUniformDistributionRandomIntValue &operator=(const GenerateUniformDistributionRandomIntValue &) = delete;
    virtual ~GenerateUniformDistributionRandomIntValue();

    virtual int32_t operator()() override;

    virtual int32_t min_value() const override;
    virtual int32_t max_value() const override;

    virtual void set_bounds(const int32_t min_value, const int32_t max_value) override;

protected:

private:

    std::default_random_engine generator_;
    std::uniform_int_distribution<int32_t> distribution_;
};

} // namespace math {

#endif // #ifndef _MATH_GENERATE_UNIFORM_DISTRIBUTION_RANDOM_INT_VALUE_H_
