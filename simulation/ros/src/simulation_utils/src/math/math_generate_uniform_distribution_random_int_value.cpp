#include "math_generate_uniform_distribution_random_int_value.h"
#include <chrono>

namespace math {

// public func.

GenerateUniformDistributionRandomIntValue::GenerateUniformDistributionRandomIntValue()
    :GenerateRandomIntValue(),
    generator_(std::chrono::system_clock::now().time_since_epoch().count()),
    distribution_()
{
}

GenerateUniformDistributionRandomIntValue::GenerateUniformDistributionRandomIntValue(
        const int32_t min_value,
        const int32_t max_value
        )
    :GenerateRandomIntValue(),
    generator_(std::chrono::system_clock::now().time_since_epoch().count()),
    distribution_(std::uniform_int_distribution<int32_t>(min_value, max_value))
{
}

GenerateUniformDistributionRandomIntValue::~GenerateUniformDistributionRandomIntValue()
{
}

int32_t GenerateUniformDistributionRandomIntValue::operator()()
{
    return distribution_(generator_);
}

int32_t GenerateUniformDistributionRandomIntValue::min_value() const
{
    return distribution_.min();
}

int32_t GenerateUniformDistributionRandomIntValue::max_value() const
{
    return distribution_.max();
}

void GenerateUniformDistributionRandomIntValue::set_bounds(
        const int32_t min_value,
        const int32_t max_value
        )
{
    distribution_ = std::uniform_int_distribution<int32_t>(min_value, max_value);
}

// protected func.

// private func.

} // namespace math {
