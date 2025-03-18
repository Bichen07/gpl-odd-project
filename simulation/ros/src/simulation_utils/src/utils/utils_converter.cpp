#include "utils_converter.h"

namespace utils {

math::Vector2d_t ConvertToVector2d(const geometry_msgs::Point &point)
{
    return math::Vector2d_t(point.x, point.y);
}

math::Vector2d_t ConvertToVector2d(const math::Vector3d_t &vector3d)
{
    return math::Vector2d_t(vector3d.x(), vector3d.y());
}

math::Vector3d_t ConvertToVector3d(const geometry_msgs::Vector3 &vector3)
{
    return math::Vector3d_t(vector3.x, vector3.y, vector3.z);
}

math::Vector3d_t ConvertToVector3d(const geometry_msgs::Pose &pose)
{
    return math::Vector3d_t(
        pose.position.x,
        pose.position.y,
        pose.position.z);
}

math::Vector3d_t ConvertToVector3d(const geometry_msgs::Quaternion &q)
{
    math::real_t pitch, roll, yaw;
    math::real_t sinr_cosp = 2 * (q.w * q.x + q.y * q.z);
    math::real_t cosr_cosp = 1 - 2 * (q.x * q.x + q.y * q.y);
    roll = std::atan2(sinr_cosp, cosr_cosp);

    // pitch (y-axis rotation)
    math::real_t sinp = 2 * (q.w * q.y - q.z * q.x);
    if (std::abs(sinp) >= 1)
        pitch = std::copysign(M_PI / 2, sinp); // use 90 degrees if out of range
    else
        pitch = std::asin(sinp);

    // yaw (z-axis rotation)
    math::real_t siny_cosp = 2 * (q.w * q.z + q.x * q.y);
    math::real_t cosy_cosp = 1 - 2 * (q.y * q.y + q.z * q.z);
    yaw = std::atan2(siny_cosp, cosy_cosp);

    math::Vector3d_t result(roll, pitch, yaw);

    return result;
}

math::Vector3d_t ConvertToVector3d(const geometry_msgs::Point &point)
{
    return math::Vector3d_t(point.x, point.y, point.z);
}

math::Vector3d_t ConvertToVector3d(const tf::Vector3 &tfvector3)
{
    return math::Vector3d_t(
        tfvector3.x(),
        tfvector3.y(),
        tfvector3.z());
}

math::Vector3d_t ConvertToVector3d(
    const math::Vector2d_t &vector2d,
    const math::real_t coordZ)
{
    return math::Vector3d_t(
        vector2d.x(),
        vector2d.y(),
        coordZ);
}

std::vector<math::Vector3d_t> ConvertToVector3ds(
    const std::vector<math::Vector2d_t> &vector2ds,
    const math::real_t coordZ)
{
    if (vector2ds.empty())
    {
        return std::vector<math::Vector3d_t>();
    }

    std::vector<math::Vector3d_t> outputVector3ds(vector2ds.size());
    std::transform(
        vector2ds.begin(),
        vector2ds.end(),
        outputVector3ds.begin(),
        [&coordZ](const math::Vector2d_t &vector2d)
        {return math::Vector3d_t(vector2d.x(), vector2d.y(), coordZ);});

    return outputVector3ds;
}

std::vector<math::Vector2d_t> ConvertToVector2ds(const std::vector<math::Vector3d_t> &vector3ds)
{
    if (vector3ds.empty())
    {
        return std::vector<math::Vector2d_t>();
    }

    std::vector<math::Vector2d_t> outputVector2ds(vector3ds.size());
    std::transform(
        vector3ds.begin(),
        vector3ds.end(),
        outputVector2ds.begin(),
        [](const math::Vector3d_t &vector3d)
        {return math::Vector2d_t(vector3d.x(), vector3d.y());});

    return outputVector2ds;
}

math::Vector6d_t ConvertToVector6d(const geometry_msgs::Twist &twist)
{
    math::Vector6d_t outputVector;
    outputVector.set_linear_vector(
        math::Vector3d_t(twist.linear.x, twist.linear.y, twist.linear.z));
    outputVector.set_angular_vector(
        math::Vector3d_t(twist.angular.x, twist.angular.y, twist.angular.z));

    return outputVector;
}

math::RotMat3d_t ConvertToRotMat3d(const tf::Matrix3x3 &tfrotmat)
{
    math::RotMat3d_t outputRotmat;
    outputRotmat.col(*Dof3d::X) = utils::ConvertToVector3d(tfrotmat.getColumn(*Dof3d::X));
    outputRotmat.col(*Dof3d::Y) = utils::ConvertToVector3d(tfrotmat.getColumn(*Dof3d::Y));
    outputRotmat.col(*Dof3d::Z) = utils::ConvertToVector3d(tfrotmat.getColumn(*Dof3d::Z));

    return outputRotmat;
}

math::Quaternion_t ConvertToQuaternion(const geometry_msgs::Quaternion &quaternionMsg)
{
    math::Quaternion_t outputQuaternion;
    outputQuaternion.w() = quaternionMsg.w;
    outputQuaternion.x() = quaternionMsg.x;
    outputQuaternion.y() = quaternionMsg.y;
    outputQuaternion.z() = quaternionMsg.z;

    return outputQuaternion;
}

math::Quaternion_t ConvertToQuaternion(const tf::Quaternion &tfQuaternion)
{
    return math::Quaternion_t(
        tfQuaternion.getW(),
        tfQuaternion.getX(),
        tfQuaternion.getY(),
        tfQuaternion.getZ()
        );
}

math::HomoXfm3d_t ConvertToHomoXfm3d(const tf::Transform &tfTransform)
{
    return math::HomoXfm3d_t(
        utils::ConvertToRotMat3d(tfTransform.getBasis()),
        utils::ConvertToVector3d(tfTransform.getOrigin()));
}

math::HomoXfm3d_t ConvertToHomoXfm3d(const geometry_msgs::Pose &pose)
{
    const auto vector3d{utils::ConvertToVector3d(pose.position)};
    const auto quaternion{utils::ConvertToQuaternion(pose.orientation)};

    return math::HomoXfm3d_t(quaternion.toRotationMatrix(), vector3d);
}

geometry_msgs::Vector3 ConvertToGeometryMsgsVector3(
    const geometry_msgs::Quaternion &orientation)
{
    math::Vector3d_t vector = ConvertToVector3d(orientation);
    return ConvertToGeometryMsgsVector3(vector);
}

geometry_msgs::Vector3 ConvertToGeometryMsgsVector3(
    const math::real_t x,
    const math::real_t y,
    const math::real_t z)
{
    geometry_msgs::Vector3 outputVector3;
    outputVector3.x = x;
    outputVector3.y = y;
    outputVector3.z = z;

    return outputVector3;
}

geometry_msgs::Vector3 ConvertToGeometryMsgsVector3(const math::Vector3d_t &vector3d)
{
    geometry_msgs::Vector3 outputVector3;
    outputVector3.x = vector3d.x();
    outputVector3.y = vector3d.y();
    outputVector3.z = vector3d.z();

    return outputVector3;
}

geometry_msgs::Vector3 ConvertToGeometryMsgsVector3(const tf::Vector3 &vector3)
{
    geometry_msgs::Vector3 outputVector3;
    outputVector3.x = vector3.x();
    outputVector3.y = vector3.y();
    outputVector3.z = vector3.z();

    return outputVector3;
}

geometry_msgs::Point32 ConvertToGeometryMsgsPoint32(const geometry_msgs::Point &point)
{
    geometry_msgs::Point32 outputPoint32;
    outputPoint32.x = point.x;
    outputPoint32.y = point.y;
    outputPoint32.z = point.z;

    return outputPoint32;
}

geometry_msgs::Point32 ConvertToGeometryMsgsPoint32(const tf::Point &tfPoint)
{
    geometry_msgs::Point32 outputPoint32;
    outputPoint32.x = tfPoint.x();
    outputPoint32.y = tfPoint.y();
    outputPoint32.z = tfPoint.z();

    return outputPoint32;
}

geometry_msgs::Point32 ConvertToGeometryMsgsPoint32(const math::Vector3d_t &vector3d)
{
    geometry_msgs::Point32 outputPoint32;
    outputPoint32.x = vector3d.x();
    outputPoint32.y = vector3d.y();
    outputPoint32.z = vector3d.z();

    return outputPoint32;
}

geometry_msgs::Point ConvertToGeometryMsgsPoint(const math::Vector3d_t &vector3d)
{
    geometry_msgs::Point outputPoint;
    outputPoint.x = vector3d.x();
    outputPoint.y = vector3d.y();
    outputPoint.z = vector3d.z();

    return outputPoint;
}

geometry_msgs::Point ConvertToGeometryMsgsPoint(const tf::Vector3 &tfVector3)
{
    geometry_msgs::Point outputPoint;
    outputPoint.x = tfVector3.x();
    outputPoint.y = tfVector3.y();
    outputPoint.z = tfVector3.z();

    return outputPoint;
}

geometry_msgs::Point ConvertToGeometryMsgsPoint(const geometry_msgs::Point32 &point32)
{
    geometry_msgs::Point outputPoint;
    outputPoint.x = point32.x;
    outputPoint.y = point32.y;
    outputPoint.z = point32.z;

    return outputPoint;
}

geometry_msgs::Accel ConvertToGeometryMsgsAccel(const math::Vector6d_t &vector6d)
{
    geometry_msgs::Accel outputAccel;
    outputAccel.linear = utils::ConvertToGeometryMsgsVector3(vector6d.linear_vector());
    outputAccel.angular = utils::ConvertToGeometryMsgsVector3(vector6d.angular_vector());

    return outputAccel;
}

geometry_msgs::Quaternion ConvertToGeometryMsgsQuaternion(
    const math::real_t orientation)
{
    geometry_msgs::Vector3 vector;
    vector.z = orientation;
    return ConvertToGeometryMsgsQuaternion(vector);
}

geometry_msgs::Quaternion ConvertToGeometryMsgsQuaternion(
    const geometry_msgs::Vector3 &eulerAngles)
{
    // euler angle in eadian to quaternion
    geometry_msgs::Quaternion outputOrientation;
    math::real_t roll = eulerAngles.x;
    math::real_t pitch = eulerAngles.y;
    math::real_t yaw = eulerAngles.z;
    math::real_t cr = cos(roll * 0.5);
    math::real_t sr = sin(roll * 0.5);
    math::real_t cp = cos(pitch * 0.5);
    math::real_t sp = sin(pitch * 0.5);
    math::real_t cy = cos(yaw * 0.5);
    math::real_t sy = sin(yaw * 0.5);
    outputOrientation.w = cr * cp * cy + sr * sp * sy;
    outputOrientation.x = sr * cp * cy - cr * sp * sy;
    outputOrientation.y = cr * sp * cy + sr * cp * sy;
    outputOrientation.z = cr * cp * sy - sr * sp * cy;
    return outputOrientation;
}

geometry_msgs::Quaternion ConvertToGeometryMsgsQuaternion(const math::Quaternion_t &quaternion)
{
    geometry_msgs::Quaternion outputOrientation;
    outputOrientation.w = quaternion.w();
    outputOrientation.x = quaternion.x();
    outputOrientation.y = quaternion.y();
    outputOrientation.z = quaternion.z();

    return outputOrientation;
}

geometry_msgs::Quaternion ConvertToGeometryMsgsQuaternion(const tf::Quaternion &tfQuaternion)
{
    geometry_msgs::Quaternion outputQuaternion;
    outputQuaternion.w = tfQuaternion.getW();
    outputQuaternion.x = tfQuaternion.getX();
    outputQuaternion.y = tfQuaternion.getY();
    outputQuaternion.z = tfQuaternion.getZ();

    return outputQuaternion;
}

geometry_msgs::Pose ConvertToGeometryMsgsPose(const geometry_msgs::Pose2D &pose2d)
{
    geometry_msgs::Pose outputPose;
    outputPose.position.x = pose2d.x;
    outputPose.position.y = pose2d.y;
    geometry_msgs::Vector3 vector;
    vector.z = pose2d.theta;
    outputPose.orientation = ConvertToGeometryMsgsQuaternion(vector);
    return outputPose;
}

geometry_msgs::Pose ConvertToGeometryMsgsPose(const math::Vector3d_t &vector3d)
{
    geometry_msgs::Pose outputPose;
    outputPose.position.x = vector3d.x();
    outputPose.position.y = vector3d.y();
    outputPose.position.z = vector3d.z();
    outputPose.orientation.x = 0.0;
    outputPose.orientation.y = 0.0;
    outputPose.orientation.z = 0.0;
    outputPose.orientation.w = 1.0;

    return outputPose;
}

geometry_msgs::Pose ConvertToGeometryMsgsPose(const tf::Vector3 &vector3)
{
    geometry_msgs::Pose outputPose;
    outputPose.position.x = vector3.x();
    outputPose.position.y = vector3.y();
    outputPose.position.z = vector3.z();
    outputPose.orientation.x = 0.0;
    outputPose.orientation.y = 0.0;
    outputPose.orientation.z = 0.0;
    outputPose.orientation.w = 1.0;

    return outputPose;
}

geometry_msgs::Pose ConvertToGeometryMsgsPose(
    const math::real_t x,
    const math::real_t y,
    const math::real_t z)
{
    geometry_msgs::Pose outputPose;
    outputPose.position.x = x;
    outputPose.position.y = y;
    outputPose.position.z = z;
    outputPose.orientation.x = 0.0;
    outputPose.orientation.y = 0.0;
    outputPose.orientation.z = 0.0;
    outputPose.orientation.w = 1.0;

    return outputPose;
}

geometry_msgs::Pose ConvertToGeometryMsgsPose(
    const math::RotMat3d_t &rotmat3d,
    const math::Vector3d_t &translation3d)
{
    geometry_msgs::Pose outputPose;
    outputPose.position.x = translation3d.x();
    outputPose.position.y = translation3d.y();
    outputPose.position.z = translation3d.z();

    const math::Quaternion_t orientation(rotmat3d);
    outputPose.orientation.w = orientation.w();
    outputPose.orientation.x = orientation.x();
    outputPose.orientation.y = orientation.y();
    outputPose.orientation.z = orientation.z();

    return outputPose;
}

geometry_msgs::Pose ConvertToGeometryMsgsPose(
    const math::Quaternion_t &orientation,
    const math::Vector3d_t &position)
{
    geometry_msgs::Pose outputPose;
    outputPose.position.x = position.x();
    outputPose.position.y = position.y();
    outputPose.position.z = position.z();
    outputPose.orientation.w = orientation.w();
    outputPose.orientation.x = orientation.x();
    outputPose.orientation.y = orientation.y();
    outputPose.orientation.z = orientation.z();

    return outputPose;
}

geometry_msgs::Pose ConvertToGeometryMsgsPose(
    const math::Vector3d_t &position,
    const math::Quaternion_t &orientation)
{
    geometry_msgs::Pose outputPose;
    outputPose.position.x = position.x();
    outputPose.position.y = position.y();
    outputPose.position.z = position.z();
    outputPose.orientation.w = orientation.w();
    outputPose.orientation.x = orientation.x();
    outputPose.orientation.y = orientation.y();
    outputPose.orientation.z = orientation.z();

    return outputPose;
}

geometry_msgs::Pose ConvertToGeometryMsgsPose(const math::HomoXfm3d_t &transform)
{
    return utils::ConvertToGeometryMsgsPose(
        transform.linear(),
        transform.translation());
}

geometry_msgs::Pose ConvertToGeometryMsgsPose(const tf::Pose &tfPose)
{
    geometry_msgs::Pose outputPose;
    outputPose.position = utils::ConvertToGeometryMsgsPoint(tfPose.getOrigin());
    outputPose.orientation = utils::ConvertToGeometryMsgsQuaternion(tfPose.getRotation());

    return outputPose;
}

tf::Point ConvertToTfPoint(const math::Vector3d_t &vector)
{
    return tf::Point(vector.x(), vector.y(), vector.z());
}

tf::Point ConvertToTfPoint(const geometry_msgs::Point32 &point32)
{
    return tf::Point(point32.x, point32.y, point32.z);
}

tf::Vector3 ConvertToTfVector3(const math::Vector3d_t &vector)
{
    return tf::Vector3(vector.x(), vector.y(), vector.z());
}

tf::Vector3 ConvertToTfVector3(const geometry_msgs::Vector3 &vector3)
{
    return tf::Vector3(vector3.x, vector3.y, vector3.z);
}

tf::Vector3 ConvertToTfVector3(const geometry_msgs::Point &point)
{
    return tf::Vector3(point.x, point.y, point.z);
}

tf::Vector3 ConvertToTfVector3(const geometry_msgs::Point32 &point32)
{
    return tf::Vector3(point32.x, point32.y, point32.z);
}

tf::Quaternion ConvertToTfQuaternion(const math::Quaternion_t &quaternion)
{
    return tf::Quaternion(
        quaternion.x(),
        quaternion.y(),
        quaternion.z(),
        quaternion.w());
}

tf::Quaternion ConvertToTfQuaternion(const geometry_msgs::Quaternion &quaternion)
{
    return tf::Quaternion(
        quaternion.x,
        quaternion.y,
        quaternion.z,
        quaternion.w);
}

std_msgs::ColorRGBA ConvertToColorRGBA(
    const float red,
    const float green,
    const float blue,
    const float alpha)
{
    std_msgs::ColorRGBA outputColor;
    outputColor.r = red;
    outputColor.g = green;
    outputColor.b = blue;
    outputColor.a = alpha;

    return outputColor;
}

} // namespace utils {
