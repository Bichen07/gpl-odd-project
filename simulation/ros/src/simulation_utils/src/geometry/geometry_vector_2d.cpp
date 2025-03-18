#include <geometry_vector_2d.h>
#include <boost/numeric/conversion/cast.hpp>

namespace geometry {

// public func.

Vector2d::Vector2d()
    : Base(Base::Zero())
{
}

Vector2d::Vector2d(const double inputX, const double inputY)
    : Base(inputX, inputY)
{
}

geometry_msgs::Vector3 Vector2d::ToVector3(const double z) const
{
    geometry_msgs::Vector3 vector3;
    vector3.x = this->x();
    vector3.y = this->y();
    vector3.z = z;

    return vector3;
}

geometry_msgs::Point32 Vector2d::ToPoint32(const float z) const
{
    geometry_msgs::Point32 point32;
    point32.x = boost::numeric_cast<float>(this->x());
    point32.y = boost::numeric_cast<float>(this->y());
    point32.z = z;

    return point32;
}

geometry_msgs::Point Vector2d::ToPoint(const double z) const
{
    geometry_msgs::Point point;
    point.x = this->x();
    point.y = this->y();
    point.z = z;

    return point;
}

// protected func.

// private func.

} // namespace geometry {
