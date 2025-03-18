#include "math_frenet_coord.h"

namespace math {

// public func.

FrenetCoord::FrenetCoord()
    :s_{0.0},
    d_{0.0}
{
}

FrenetCoord::FrenetCoord(const real_t coord_s, const real_t coord_d)
    :s_{coord_s},
    d_{coord_d}
{
}

FrenetCoord::~FrenetCoord()
{
}

real_t FrenetCoord::s() const
{
    return s_;
}

real_t FrenetCoord::d() const
{
    return d_;
}

void FrenetCoord::set_s(const real_t coord_s)
{
    s_ = coord_s;
}

void FrenetCoord::set_d(const real_t coord_d)
{
    d_ = coord_d;
}

// protected func.

// private func.

// auxiliary func.

FrenetCoord operator+(const FrenetCoord &lhs, const FrenetCoord &rhs)
{
    return FrenetCoord(lhs.s() + rhs.s(), lhs.d() + rhs.d());
}

FrenetCoord operator-(const FrenetCoord &lhs, const FrenetCoord &rhs)
{
    return FrenetCoord(lhs.s() - rhs.s(), lhs.d() - rhs.d());
}

} // namespace math {
