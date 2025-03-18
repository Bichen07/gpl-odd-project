#include <geometry_quaternion.h>

namespace geometry {

// public func.

Quaternion::Quaternion()
    : Base(Base::Identity())
{
}

Quaternion::Quaternion(const Base &base)
    : Base(base)
{
}

Quaternion::Quaternion(
    const double inputW,
    const double inputX,
    const double inputY,
    const double inputZ)
    : Base(inputW, inputX, inputY, inputZ)
{
}

Quaternion::Quaternion(const geometry_msgs::Quaternion &input)
    : Base(input.w, input.x, input.y, input.z)
{
}

geometry_msgs::Quaternion Quaternion::ToGeometryMsgsQuaternion() const
{
    geometry_msgs::Quaternion output;
    output.w = this->x();
    output.x = this->x();
    output.y = this->y();
    output.z = this->z();

    return output;
}

// protected func.

// private func.

} // namespace geometry {
