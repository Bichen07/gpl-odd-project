#ifndef _MATH_GENERATE_RANDOM_VECTOR_H_
#define _MATH_GENERATE_RANDOM_VECTOR_H_

#include "math_def.h"
#include <memory>
#include "math_type.h"

namespace math {

class GenerateRandomVector final
{

public:

    GenerateRandomVector();
    explicit GenerateRandomVector(
            const math::VectorNd_t &lower_bounds,
            const math::VectorNd_t &upper_bounds
            );
    GenerateRandomVector(const GenerateRandomVector &other);
    GenerateRandomVector &operator=(const GenerateRandomVector &other);
    virtual ~GenerateRandomVector();

    VectorNd_t operator()() const;
    VectorNd_t operator()(const VectorNd_t &means) const;

    VectorNd_t lower_bounds() const;
    VectorNd_t upper_bounds() const;

    void set_lower_bounds(const VectorNd_t &lower_bounds);
    void set_upper_bounds(const VectorNd_t &upper_bounds);

protected:

private:

    std::unique_ptr<VectorNd_t> lower_bounds_;
    std::unique_ptr<VectorNd_t> upper_bounds_;
};

} // namespace math {

#endif // #ifndef _MATH_GENERATE_RANDOM_VECTOR_H_
