#ifndef _VISILIBITY_UTLIS_H_
#define _VISILIBITY_UTLIS_H_

#include <math_type.h>
#include <visilibity.hpp>

namespace VisiLibity {

math::Vector2d_t ConvertToVector2d(const Point &point);
std::vector<math::Vector2d_t> ConvertToVector2ds(const std::vector<Point> &points);

Point ConvertToPoint(const math::Vector2d_t &vector2d);
std::vector<Point> ConvertToPoints(const std::vector<math::Vector2d_t> &vector2ds);

std::vector<math::Vector2d_t> ExtractCorners(const Polygon &polygon);

} // namespace VisiLibity {

#endif // #ifndef _VISILIBITY_UTLIS_H_
