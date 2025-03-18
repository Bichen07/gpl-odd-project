#ifndef _GEOMETRY_TRANSFORM_3D_H_
#define _GEOMETRY_TRANSFORM_3D_H_

#include <math_homogeneous_transform.h>
#include <geometry_msgs/Pose.h>
#include <geometry_quaternion.h>
#include <geometry_vector_3d.h>

namespace geometry {

class Transform3d : public math::HomogeneousTransform<double, 3>
{
    using Base = math::HomogeneousTransform<double, 3>;

public:

    Transform3d();
    explicit Transform3d(const geometry_msgs::Pose &pose);
    explicit Transform3d(
        const Quaternion &quaternion,
        const Vector3d &position);
    explicit Transform3d(const Vector3d &vector3d);
    Transform3d(const Transform3d &other);
    Transform3d &operator=(const Transform3d &other);
    Transform3d(const Base &base);
    Transform3d &operator=(const Base &base);
    virtual ~Transform3d() = default;

    Quaternion GetQuaternion() const;
    Vector3d GetPosition() const;

    geometry_msgs::Pose ToPose() const;

protected:

private:

};

} // namespace geometry {

#endif // #ifndef _GEOMETRY_TRANSFORM_3D_H_
