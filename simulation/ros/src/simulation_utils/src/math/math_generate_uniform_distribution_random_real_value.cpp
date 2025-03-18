#include "math_generate_uniform_distribution_random_real_value.h"
#include <chrono>

namespace math {

// public func.

GenerateUniformDistributionRandomRealValue::GenerateUniformDistributionRandomRealValue()
    :GenerateRandomRealValue(),
    generator_(std::chrono::system_clock::now().time_since_epoch().count()),
    distribution_()
{
}

GenerateUniformDistributionRandomRealValue::GenerateUniformDistributionRandomRealValue(
        const real_t min_value,
        const real_t max_value
        )
    :GenerateRandomRealValue(),
    generator_(std::chrono::system_clock::now().time_since_epoch().count()),
    distribution_(std::uniform_real_distribution<real_t>(min_value, max_value))
{
}

GenerateUniformDistributionRandomRealValue::~GenerateUniformDistributionRandomRealValue()
{
}

real_t GenerateUniformDistributionRandomRealValue::operator()()
{
    return distribution_(generator_);
}

real_t GenerateUniformDistributionRandomRealValue::min_value() const
{
    return distribution_.min();
}

real_t GenerateUniformDistributionRandomRealValue::max_value() const
{
    return distribution_.max();
}

void GenerateUniformDistributionRandomRealValue::set_bounds(const real_t min_value, const real_t max_value)
{
    distribution_ = std::uniform_real_distribution<real_t>(min_value, max_value);
}

// protected func.

// private func.

} // namespace math {
