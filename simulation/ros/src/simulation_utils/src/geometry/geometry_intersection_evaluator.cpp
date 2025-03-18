#include <geometry_intersection_evaluator.h>
#include <deque>
#include <boost/geometry/algorithms/convex_hull.hpp>
#include <boost/foreach.hpp>

namespace geometry {

// public func.

IntersectionEvaluator::IntersectionEvaluator()
{
}

IntersectionEvaluator::~IntersectionEvaluator()
{
}

math::real_t IntersectionEvaluator::ComputeArea(
    const Polygon2d &first,
    const Polygon2d &second) const
{
    std::deque<Polygon2d> outputs;
    boost::geometry::intersection(first, second, outputs);

    math::real_t intersectionArea{0.0};
    BOOST_FOREACH(Polygon2d const &output, outputs)
    {
        intersectionArea += boost::geometry::area(output);
    }

    return intersectionArea;
}

// protected func.

// private func.

} // namespace geometry {
