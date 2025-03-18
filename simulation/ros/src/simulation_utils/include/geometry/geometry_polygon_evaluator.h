#ifndef _GEOMETRY_POLYGON_EVALUATOR_H_
#define _GEOMETRY_POLYGON_EVALUATOR_H_

#include <math_type.h>
#include <math_frenet_transformer.h>
#include <geometry_type.h>

namespace geometry {

class PolygonEvaluator final
{

public:

    PolygonEvaluator();
    PolygonEvaluator(const PolygonEvaluator &) = delete;
    PolygonEvaluator &operator=(const PolygonEvaluator &) = delete;
    virtual ~PolygonEvaluator();

    Polygon2d Compute(
        const math::real_t beginLongitudinalDistance,
        const math::real_t lateralWidth,
        const math::real_t forwardDistance) const;

    void Configure(const std::vector<math::Vector3d_t> &pointSequence);

protected:

private:

    std::vector<math::Vector3d_t> mPointSequence3d;
    std::vector<math::Vector2d_t> mPointSequence2d;
    math::FrenetTransformer mFrenetTransformer;
};

} // namespace geometry {

#endif // #ifndef _GEOMETRY_POLYGON_EVALUATOR_H_
