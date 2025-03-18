#include <geometry_transform_3d.h>
#include <ros/console.h>

namespace geometry {

// public func.

Transform3d::Transform3d()
    : Base(Base::Identity())
{
}

Transform3d::Transform3d(const geometry_msgs::Pose &pose)
    : Base(
        geometry::Quaternion(pose.orientation).toRotationMatrix(),
        geometry::Vector3d(pose.position))
{
}

Transform3d::Transform3d(const Quaternion &quaternion, const Vector3d &position)
    : Base(quaternion.toRotationMatrix(), position)
{
}

Transform3d::Transform3d(const Vector3d &vector3d)
    : Base(
        geometry::Quaternion::Identity().toRotationMatrix(),
        vector3d)
{
}

Transform3d::Transform3d(const Transform3d &other)
    : Base(
        other.GetQuaternion().toRotationMatrix(),
        other.GetPosition())
{
}

Transform3d &Transform3d::operator=(const Transform3d &other)
{
    if (&other == this)
    {
        return *this;
    }

    this->Base::operator=(other);

    return *this;
}

Transform3d::Transform3d(const Base &base)
    : Base(base)
{
}

Transform3d &Transform3d::operator=(const Base &base)
{
    this->Base::operator=(base);
    return *this;
}

Quaternion Transform3d::GetQuaternion() const
{
    return Quaternion(this->linear());
}

Vector3d Transform3d::GetPosition() const
{
    return Vector3d(this->translation());
}

geometry_msgs::Pose Transform3d::ToPose() const
{
    geometry_msgs::Pose outputPose;
    outputPose.orientation =
        this->GetQuaternion().ToGeometryMsgsQuaternion();
    outputPose.position = this->GetPosition().ToPoint();

    return outputPose;
}

// protected func.

// private func.

} // namespace geometry {
