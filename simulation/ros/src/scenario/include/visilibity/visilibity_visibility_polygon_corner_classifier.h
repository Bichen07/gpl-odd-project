#ifndef _VISILIBITY_VISIBILITY_POLYGON_CORNER_CLASSIFIER_H_
#define _VISILIBITY_VISIBILITY_POLYGON_CORNER_CLASSIFIER_H_

#include <math_type.h>
#include <visilibity_edge.h>

namespace VisiLibity {

class VisibilityPolygonCornerClassifier final
{

public:

    VisibilityPolygonCornerClassifier();
    VisibilityPolygonCornerClassifier(const VisibilityPolygonCornerClassifier &) = delete;
    VisibilityPolygonCornerClassifier &operator=(const VisibilityPolygonCornerClassifier &) = delete;
    virtual ~VisibilityPolygonCornerClassifier();

    std::vector<std::vector<math::Vector2d_t>> Compute(
        const std::vector<math::Vector2d_t> &visibilityPolygonCwCorners,
        const std::vector<std::vector<math::Vector2d_t>> &holePolygonCornerSets);

protected:

private:

    std::vector<std::vector<Edge>> ComputeHolePolygonEdgeSets(
        const std::vector<std::vector<math::Vector2d_t>> &holePolygonCornerSets) const;
    std::vector<math::Vector2d_t> ExtractCornersOnPolygon(
        const std::vector<Edge> &edges,
        const std::vector<math::Vector2d_t> corners) const;
};

} // namespace VisiLibity {

#endif // #ifndef _VISILIBITY_VISIBILITY_POLYGON_CORNER_CLASSIFIER_H_
