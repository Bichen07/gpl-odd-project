#include <visilibity_visibility_polygon_corner_classifier.h>
#include <ros/console.h>
#include <math_utils.h>

namespace VisiLibity {

// public func.

VisibilityPolygonCornerClassifier::VisibilityPolygonCornerClassifier()
{
}

VisibilityPolygonCornerClassifier::~VisibilityPolygonCornerClassifier()
{
}

std::vector<std::vector<math::Vector2d_t>> VisibilityPolygonCornerClassifier::Compute(
    const std::vector<math::Vector2d_t> &visibilityPolygonCwCorners,
    const std::vector<std::vector<math::Vector2d_t>> &holePolygonCornerSets)
{
    const auto holePolygonEdgeSets =
        this->ComputeHolePolygonEdgeSets(holePolygonCornerSets);

    std::vector<std::vector<math::Vector2d_t>> classifiedCornerSets(
        holePolygonEdgeSets.size());
    auto holePolygonEdgeSet{holePolygonEdgeSets.cbegin()};
    auto classifiedCornerSet{classifiedCornerSets.begin()};
    for (; holePolygonEdgeSet != holePolygonEdgeSets.cend();
         ++holePolygonEdgeSet, ++classifiedCornerSet)
    {
        *classifiedCornerSet = this->ExtractCornersOnPolygon(
            *holePolygonEdgeSet,
            visibilityPolygonCwCorners);
    }

    return classifiedCornerSets;
}

// protected func.

// private func.

std::vector<std::vector<Edge>> VisibilityPolygonCornerClassifier::ComputeHolePolygonEdgeSets(
    const std::vector<std::vector<math::Vector2d_t>> &holePolygonCornerSets) const
{
    std::vector<std::vector<Edge>> outputEdgeSets(holePolygonCornerSets.size());
    auto cornerSet{holePolygonCornerSets.cbegin()};
    auto outputEdgeSet{outputEdgeSets.begin()};
    for (; cornerSet != holePolygonCornerSets.end();
         ++cornerSet, ++outputEdgeSet)
    {
        auto corner{cornerSet->begin() + 1};
        outputEdgeSet->resize(cornerSet->size());
        auto edge{outputEdgeSet->begin()};
        while (corner != cornerSet->end())
        {
            *edge = Edge(*(corner - 1), *corner);
            ++corner;
            ++edge;
        }

        *edge = Edge(
            cornerSet->back(),
            cornerSet->front());
    }

    return outputEdgeSets;
}

std::vector<math::Vector2d_t> VisibilityPolygonCornerClassifier::ExtractCornersOnPolygon(
    const std::vector<Edge> &edges,
    const std::vector<math::Vector2d_t> corners) const
{
    std::vector<math::Vector2d_t> outputCorners;
    outputCorners.reserve(corners.size());
    for (auto edge{edges.cbegin()}; edge != edges.cend(); ++edge)
    {
        for (auto corner{corners.cbegin()}; corner != corners.cend(); ++corner)
        {
            if (edge->IsOnEdge(*corner))
            {
                outputCorners.push_back(*corner);
            }
        }
    }

    return outputCorners;
}

} // namespace VisiLibity {
