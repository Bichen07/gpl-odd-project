#ifndef _MATH_POINT_SEQUENCE_SAMPLER_H_
#define _MATH_POINT_SEQUENCE_SAMPLER_H_

#include <functional>
#include "math_type.h"

namespace math {

typedef enum class DistanceEvaluation: int32_t
{
    Dim2d = 0,
    Dim3d = 1,
    Num,
    Null = Num,
} DistanceEvaluationId_t;

class PointSequenceSampler final
{

public:

    PointSequenceSampler();
    PointSequenceSampler(const PointSequenceSampler &other) = default;
    PointSequenceSampler &operator=(const PointSequenceSampler &other) = default;
    virtual ~PointSequenceSampler();

    math::Vector3dColl_t Compute(
        const Vector3dColl_t &inputs,
        const real_t output_step_distance,
        const DistanceEvaluationId_t &distance_evaluation_id
        ) const;

protected:

private:

    using ComputeNormFunc_t = std::function<real_t (const Vector3d_t &, const Vector3d_t &)>;

    std::vector<real_t> ComputeAccumulatedDistance(
        const std::vector<Vector3d_t> &inputs,
        const DistanceEvaluationId_t &distance_evaluation_id
        ) const;
    real_t ComputeNormXyz(const Vector3d_t &first, const Vector3d_t &second) const;
    real_t ComputeNormXy(const Vector3d_t &first, const Vector3d_t &second) const;
};

} // namespace math {

#endif // #ifndef _MATH_POINT_SEQUENCE_SAMPLER_H_
