/*
 * ----------------- BEGIN LICENSE BLOCK ---------------------------------
 *
 * Copyright (c) 2017 Computer Vision Center (CVC) at the Universitat Autonoma
 * de Barcelona (UAB).
 * Copyright (C) 2019 Intel Corporation
 *
 * SPDX-License-Identifier: MIT
 *
 * ----------------- END LICENSE BLOCK -----------------------------------
 */

#include "opendrive/geometry/Geometry.h"
#include "opendrive/geometry/odrSpiral.h"

#include "opendrive/types.hpp"

#include <boost/array.hpp>
#include <boost/math/tools/rational.hpp>
#include <cmath>
#include <stdexcept>

namespace opendrive {
namespace geometry {

DirectedPoint::DirectedPoint()
  : location(0, 0)
  , tangent(0)
{
}
DirectedPoint::DirectedPoint(const Point &point, double t)
  : location(point)
  , tangent(t)
{
}
DirectedPoint::DirectedPoint(double x, double y, double t)
  : location(x, y)
  , tangent(t)
{
}

void DirectedPoint::ApplyLateralOffset(double lateral_offset)
{
  auto normal_x = -std::sin(tangent);
  auto normal_y = std::cos(tangent);
  location.x += lateral_offset * normal_x;
  location.y += lateral_offset * normal_y;
}

GeometryType Geometry::GetType() const
{
  return _type;
}
double Geometry::GetLength() const
{
  return _length;
}
double Geometry::GetStartOffset() const
{
  return _start_position_offset;
}
double Geometry::GetHeading() const
{
  return _heading;
}

const Point &Geometry::GetStartPosition()
{
  return _start_position;
}

Geometry::Geometry(GeometryType type, double start_offset, double length, double heading, const Point &start_pos)
  : _type(type)
  , _length(length)
  , _start_position_offset(start_offset)
  , _heading(heading)
  , _start_position(start_pos)
{
  if (_length == 0.)
  {
    throw std::invalid_argument("Geometry of length 0");
  }
}

GeometryLine::GeometryLine(double start_offset, double length, double heading, const Point &start_pos)
  : Geometry(GeometryType::LINE, start_offset, length, heading, start_pos)
{
}

const DirectedPoint GeometryLine::PosFromDist(const double dist) const
{
  DirectedPoint p(_start_position, _heading);
  p.location.x += dist * std::cos(p.tangent);
  p.location.y += dist * std::sin(p.tangent);
  return p;
}

GeometryArc::GeometryArc(double start_offset, double length, double heading, const Point &start_pos, double curv)
  : Geometry(GeometryType::ARC, start_offset, length, heading, start_pos)
  , _curvature(curv)
{
}

const DirectedPoint GeometryArc::PosFromDist(double dist) const
{
  if (std::fabs(_curvature) < 1e-15)
  {
    // case not supported given the small curvature
    return DirectedPoint(_start_position, _heading);
  }
  const double radius = 1.0 / _curvature;
  const double theta = _heading - M_PI_2;
  double x = _start_position.x - radius * (cos(theta) - cos(theta + dist * _curvature));
  double y = _start_position.y - radius * (sin(theta) - sin(theta + dist * _curvature));

  double tangent = _heading + dist * _curvature;

  DirectedPoint p(x, y, tangent);

  return p;
}

double GeometryArc::GetCurvature() const
{
  return _curvature;
}

GeometrySpiral::GeometrySpiral(
    double start_offset,
    double length,
    double heading,
    const Point &start_pos,
    double curv_s,
    double curv_e)
    : Geometry(GeometryType::SPIRAL, start_offset, length, heading, start_pos),
      _curve_start(curv_s),
      _curve_end(curv_e)
{
}


//geom::Vector2D RotatebyAngle(double angle, double x, double y) {
Point RotatebyAngle(double angle, double x, double y) {
    const double cos_a = std::cos(angle);
    const double sin_a = std::sin(angle);
    return Point(
    static_cast<float>(x * cos_a - y * sin_a),
    static_cast<float>(y * cos_a + x * sin_a));
}

template <typename T>
static T Clamp(T a, T min = T(0), T max = T(1)) {
  return std::min(std::max(a, min), max);
}

const DirectedPoint GeometrySpiral::PosFromDist(double dist) const
{

    dist = Clamp(dist, 0.0, _length);
    DirectedPoint p(_start_position, _heading);

    const double curve_end = (_curve_end);
    const double curve_start = (_curve_start);
    const double curve_dot = (curve_end - curve_start) / (_length);
    const double s_o = curve_start / curve_dot;
    double s = s_o + dist;

    double x;
    double y;
    double t;
    odrSpiral(s, curve_dot, &x, &y, &t);

    double x_o;
    double y_o;
    double t_o;
    odrSpiral(s_o, curve_dot, &x_o, &y_o, &t_o);

    x = x - x_o;
    y = y - y_o;
    t = t - t_o;

    Point pos = RotatebyAngle(_heading - t_o, x, y);
    p.location.x += pos.x;
    p.location.y += pos.y;
    p.tangent = _heading + t;

    return p;
}

GeometryPoly3::GeometryPoly3(
  double start_offset, double length, double heading, const Point &start_pos, double a, double b, double c, double d)
  : Geometry(GeometryType::POLY3, start_offset, length, heading, start_pos)
  , _a{a}
  , _b{b}
  , _c{c}
  , _d{d}
{
}

const DirectedPoint GeometryPoly3::PosFromDist(const double dist) const
{
  auto poly = boost::array<double, 4>{{_a, _b, _c, _d}};

  double u = dist;
  double v = boost::math::tools::evaluate_polynomial(poly, u);

  const double cos_t = std::cos(_heading);
  const double sin_t = std::sin(_heading);

  double x0 = _start_position.x;
  double y0 = _start_position.y;
  double x = u * cos_t - v * sin_t;
  double y = u * sin_t + v * cos_t;

  auto tangentPoly = boost::array<double, 4>{{_b, 2.0 * _c, 3.0 * _d}};

  double tangentV = boost::math::tools::evaluate_polynomial(tangentPoly, u);
  double theta = atan2(tangentV, 1.0);

  DirectedPoint point(x0 + x, y0 + y, _heading + theta);
  return point;
}

GeometryParamPoly3::GeometryParamPoly3(double start_offset,
                                       double length,
                                       double heading,
                                       const Point &start_pos,
                                       double aU,
                                       double bU,
                                       double cU,
                                       double dU,
                                       double aV,
                                       double bV,
                                       double cV,
                                       double dV)
  : Geometry(GeometryType::PARAMPOLY3, start_offset, length, heading, start_pos)
  , _aU{aU}
  , _bU{bU}
  , _cU{cU}
  , _dU{dU}
  , _aV{aV}
  , _bV{bV}
  , _cV{cV}
  , _dV{dV}
{
}

const DirectedPoint GeometryParamPoly3::PosFromDist(const double dist) const
{
  double p = std::min(1.0, dist / _length);

  auto polyU = boost::array<double, 4>{{_aU, _bU, _cU, _dU}};
  auto polyV = boost::array<double, 4>{{_aV, _bV, _cV, _dV}};

  double u = boost::math::tools::evaluate_polynomial(polyU, p);
  double v = boost::math::tools::evaluate_polynomial(polyV, p);

  const double cos_t = std::cos(_heading);
  const double sin_t = std::sin(_heading);
  double x0 = _start_position.x;
  double y0 = _start_position.y;
  double x = u * cos_t - v * sin_t;
  double y = u * sin_t + v * cos_t;

  auto tangentPolyU = boost::array<double, 4>{{_bU, 2.0 * _cU, 3.0 * _dU, 0.0}};
  auto tangentPolyV = boost::array<double, 4>{{_bV, 2.0 * _cV, 3.0 * _dV, 0.0}};

  double tangentU = boost::math::tools::evaluate_polynomial(tangentPolyU, p);
  double tangentV = boost::math::tools::evaluate_polynomial(tangentPolyV, p);
  double theta = atan2(tangentV, tangentU);

  DirectedPoint point(x0 + x, y0 + y, _heading + theta);
  return point;
}

} // namespace
} // namespace
