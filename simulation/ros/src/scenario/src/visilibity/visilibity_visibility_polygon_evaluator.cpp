#include <visilibity_visibility_polygon_evaluator.h>
#include <algorithm>
#include <ros/console.h>
#include <visilibity_utils.h>

namespace VisiLibity {

// public func.

VisibilityPolygonEvaluator::VisibilityPolygonEvaluator()
    : mEnvironment{}
    , mEpsilon{DefaultEpsilon()}
{
}

VisibilityPolygonEvaluator::~VisibilityPolygonEvaluator()
{
}

void VisibilityPolygonEvaluator::Configure(
    const std::vector<math::Vector2d_t> &boundaryPolygonCorners,
    const std::vector<std::vector<math::Vector2d_t>> &holePolygons,
    const math::real_t epsilon)
{
    std::vector<Polygon> environmentPolygons;
    environmentPolygons.reserve(holePolygons.size() + 1ul);

    const Polygon boundaryPolygon(
        VisiLibity::ConvertToPoints(boundaryPolygonCorners));
    environmentPolygons.push_back(boundaryPolygon);

    for (auto holePolygonCorners{holePolygons.begin()};
         holePolygonCorners != holePolygons.end();
         ++holePolygonCorners)
    {
        const Polygon holePolygon(
            VisiLibity::ConvertToPoints(*holePolygonCorners));
        environmentPolygons.push_back(holePolygon);
    }

    mEnvironment = VisiLibity::Environment(environmentPolygons);

    if (!mEnvironment.is_valid(mEpsilon))
    {
        ROS_WARN_STREAM(
            "Environment model is invalid" << '\n' <<
            "A valid environment model must have" << '\n' <<
            "   1) outer boundary and holes pairwise " << '\n' <<
            "epsilon -disjoint simple polygons" << '\n' <<
            "   (no two features should come " << '\n' <<
            "within epsilon of each other)," << '\n' <<
            "   2) outer boundary is oriented ccw, and"  << '\n' <<
            "   3) holes are oriented cw.");
    }
}

std::vector<math::Vector2d_t> VisibilityPolygonEvaluator::Compute(
    const math::Vector2d_t &observerPosition)
{
    VisiLibity::Visibility_Polygon visibilityPolygon(
        VisiLibity::ConvertToPoint(observerPosition),
        mEnvironment,
        mEpsilon);

    auto ccwCorners = VisiLibity::ExtractCorners(visibilityPolygon);
    std::vector<math::Vector2d_t> outputCwCorners(ccwCorners.size());
    std::reverse_copy(
        ccwCorners.begin(),
        ccwCorners.end(),
        outputCwCorners.begin());

    return outputCwCorners;
}

// protected func.

// private func.

} // namespace VisiLibity {
