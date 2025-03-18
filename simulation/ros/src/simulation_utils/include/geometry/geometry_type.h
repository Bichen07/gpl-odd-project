#ifndef _GEOMETRY_TYPE_H_
#define _GEOMETRY_TYPE_H_

#include <boost/geometry/geometry.hpp>
#include <boost/geometry/geometries/polygon.hpp>
#include <boost/geometry/geometries/register/point.hpp>
#include <math_type.h>
#include <geometry_box.h>
#include <geometry_edge.h>
#include <geometry_rect.h>
#include <geometry_vector_2d.h>

BOOST_GEOMETRY_REGISTER_POINT_2D_GET_SET(
        ::math::Vector2d_t,
        ::math::Vector2d_t::RealScalar,
        boost::geometry::cs::cartesian,
        x,
        y,
        set_x,
        set_y)

namespace geometry {

typedef boost::geometry::model::polygon<math::Vector2d_t> Polygon2d;
typedef Box<geometry::Vector2d> Box2d;
typedef Edge<math::Vector2d_t> Edge2d;
typedef Edge<math::Vector3d_t> Edge3d;
typedef Rect<math::Vector2d_t> Rect2d;
typedef Rect<math::Vector3d_t> Rect3d;

} // namespace geometry {

#endif // #ifndef _GEOMETRY_TYPE_H_
