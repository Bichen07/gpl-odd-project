#ifndef _GEOMETRY_UTILS_H_
#define _GEOMETRY_UTILS_H_

#include <geometry_type.h>

namespace geometry {

Edge3d ConvertToEdge3d(const Edge2d &edge2d, const math::real_t positionZ);
Rect2d ConvertToRect2d(const Rect3d &rect3d);
Rect3d ConvertToRect3d(const Rect2d &rect2d, const math::real_t positionZ);

Rect2d ComputeBoundingRect2d(const math::HomoXfm2d_t &xfm2d, const math::Vector2d_t &size);
Rect2d ComputeBoundingRect2d(
    const math::HomoXfm2d_t &xfm2d,
    const math::Vector2d_t &size,
    const math::Vector2d_t &localOffset);
Rect3d ComputeBoundingRect3d(const math::HomoXfm3d_t &xfm3d, const math::Vector2d_t &size);
template<typename VectorType>
std::vector<VectorType> ExtractCcwCorners(const Rect<VectorType> &rect);
template<typename VectorType>
std::vector<VectorType> ExtractClosedCcwCorners(const Rect<VectorType> &rect);
template<typename VectorType>
std::vector<VectorType> ExtractCwCorners(const Rect<VectorType> &rect);
template<typename VectorType>
std::vector<VectorType> ExtractClosedCwCorners(const Rect<VectorType> &rect);

template<typename VectorType>
std::vector<VectorType> GenerateClosedCorners(const std::vector<VectorType> &unclosedCorners);

Polygon2d ComputePolygon(const Rect2d &rect2d);
Polygon2d ComputePolygon(const std::vector<math::Vector2d_t> &closedCwCorners);
math::real_t ComputeArea(const Polygon2d &polygon);
math::real_t ComputeIntersectionArea(const Polygon2d &first, const Polygon2d &second);

template<typename VectorType>
std::vector<VectorType> ExtractPolygonClosedCorners(const Rect<VectorType> &inputRect);
template<typename VectorType>
std::vector<VectorType> ExtractCorners(const Rect<VectorType> &inputRect);
template<typename VectorType>
bool IsZero(const Rect<VectorType> &inputRect);
template<typename VectorType>
bool IsValidSize(const VectorType &inputSize, const math::real_t epsilon);

template<typename VectorType>
std::vector<VectorType> SortPoints(
    const std::vector<math::Vector2d_t> &refPoint2ds,
    const std::vector<VectorType> &unarrangedPoint,
    const math::real_t distanceXyEpsilon = math::real_t{1.0e-5});

} // namespace geometry {

#endif // #ifndef _GEOMETRY_UTILS_H_
