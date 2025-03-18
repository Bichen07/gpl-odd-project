#ifndef _MATH_GENERATE_UNIFORM_DISTRIBUTION_RANDOM_REAL_VALUE_H_
#define _MATH_GENERATE_UNIFORM_DISTRIBUTION_RANDOM_REAL_VALUE_H_

#include "math_generate_random_real_value.h"

namespace math {

class GenerateUniformDistributionRandomRealValue final : public GenerateRandomRealValue
{

public:

    GenerateUniformDistributionRandomRealValue();
    GenerateUniformDistributionRandomRealValue(const real_t min_value, const real_t max_value);
    GenerateUniformDistributionRandomRealValue(const GenerateUniformDistributionRandomRealValue &) = delete;
    GenerateUniformDistributionRandomRealValue &operator=(const GenerateUniformDistributionRandomRealValue &) = delete;
    virtual ~GenerateUniformDistributionRandomRealValue();

    virtual real_t operator()() override;

    virtual real_t min_value() const override;
    virtual real_t max_value() const override;

    virtual void set_bounds(const real_t min_value, const real_t max_value) override;

protected:

private:

    std::default_random_engine generator_;
    std::uniform_real_distribution<real_t> distribution_;
};

} // namespace math {

#endif // #ifndef _MATH_GENERATE_UNIFORM_DISTRIBUTION_RANDOM_REAL_VALUE_H_
