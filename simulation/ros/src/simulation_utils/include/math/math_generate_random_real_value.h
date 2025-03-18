#ifndef _MATH_GENERATE_RANDOM_REAL_VALUE_H_
#define _MATH_GENERATE_RANDOM_REAL_VALUE_H_

#include "math_def.h"
#include <random>
#include "math_type.h"

namespace math {

class GenerateRandomRealValue
{

public:

    GenerateRandomRealValue(const GenerateRandomRealValue &) = delete;
    GenerateRandomRealValue &operator=(const GenerateRandomRealValue &) = delete;
    virtual ~GenerateRandomRealValue() = default;

    virtual real_t operator()() = 0;

    virtual real_t min_value() const = 0;
    virtual real_t max_value() const = 0;

    virtual void set_bounds(const real_t min_value, const real_t max_value) = 0;

protected:

    GenerateRandomRealValue() = default;

private:

};

} // namespace math {

#endif // #ifndef _MATH_GENERATE_RANDOM_REAL_VALUE_H_
