#ifndef _GEOMETRY_INTERSECTION_EVALUATOR_H_
#define _GEOMETRY_INTERSECTION_EVALUATOR_H_

#include <math_type.h>
#include <geometry_type.h>

namespace geometry {

class IntersectionEvaluator final
{

public:

    IntersectionEvaluator();
    IntersectionEvaluator(const IntersectionEvaluator &other) = default;
    IntersectionEvaluator &operator=(const IntersectionEvaluator &other) = default;
    virtual ~IntersectionEvaluator();

    math::real_t ComputeArea(const Polygon2d &first, const Polygon2d &second) const;

protected:

private:

};

} // namespace geometry {

#endif // #ifndef _GEOMETRY_INTERSECTION_EVALUATOR_H_
