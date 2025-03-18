#ifndef _MATH_STREAM_UTILS_H_
#define _MATH_STREAM_UTILS_H_

#include <jsoncpp/json/json.h>
#include <math_type.h>
#include <math_frenet_coord.h>

namespace math {

math::Vector2d_t ParseVector2d(const Json::Value &value);
math::Vector3d_t ParseVector3d(const Json::Value &value);
std::vector<math::Vector3d_t> ParseVector3ds(const Json::Value &values);

math::FrenetCoord ParseFrenetCoord(const Json::Value &value);
std::vector<math::FrenetCoord> ParseFrenetCoords(const Json::Value &values);

} // namespace math {

#endif // #ifndef _MATH_STREAM_UTILS_H_
