#ifndef _MATH_GENERATE_RANDOM_INT_VALUE_H_
#define _MATH_GENERATE_RANDOM_INT_VALUE_H_

#include "math_def.h"
#include <random>
#include "math_type.h"

namespace math {

class GenerateRandomIntValue
{

public:

    GenerateRandomIntValue(const GenerateRandomIntValue &) = delete;
    GenerateRandomIntValue &operator=(const GenerateRandomIntValue &) = delete;
    virtual ~GenerateRandomIntValue() = default;

    virtual int32_t operator()() = 0;

    virtual int32_t min_value() const = 0;
    virtual int32_t max_value() const = 0;

    virtual void set_bounds(const int32_t min_value, const int32_t max_value) = 0;

protected:

    GenerateRandomIntValue() = default;

private:

};

} // namespace math {

#endif // #ifndef _MATH_GENERATE_RANDOM_INT_VALUE_H_
