#ifndef _VISILIBITY_VISIBILITY_POLYGON_EVALUATOR_H_
#define _VISILIBITY_VISIBILITY_POLYGON_EVALUATOR_H_

#include <math_type.h>
#include <visilibity.hpp>

namespace VisiLibity {

class VisibilityPolygonEvaluator final
{
    static constexpr math::real_t DefaultEpsilon()
    {return math::real_t{1.0e-9};}

public:

    VisibilityPolygonEvaluator();
    VisibilityPolygonEvaluator(const VisibilityPolygonEvaluator &) = delete;
    VisibilityPolygonEvaluator &operator=(const VisibilityPolygonEvaluator &) = delete;
    virtual ~VisibilityPolygonEvaluator();

    void Configure(
        const std::vector<math::Vector2d_t> &boundaryPolygonCorners,
        const std::vector<std::vector<math::Vector2d_t>> &holePolygons,
        const math::real_t epsilon = DefaultEpsilon());
    /**
     * Output corners in CW orientation
     */
    std::vector<math::Vector2d_t> Compute(const math::Vector2d_t &observerPosition);

protected:

private:

    VisiLibity::Environment mEnvironment;
    math::real_t mEpsilon;
};

} // namespace VisiLibity {

#endif // #ifndef _VISILIBITY_VISIBILITY_POLYGON_EVALUATOR_H_
