#include <utils_geometry_msgs.h>
#include <math_utils.h>
#include <utils_converter.h>

namespace utils {

geometry_msgs::Vector3 GetZeroGeometryMsgsVector3()
{
    static geometry_msgs::Vector3 output;
    output.x = double{0.0};
    output.y = double{0.0};
    output.z = double{0.0};

    return output;
}

geometry_msgs::Point GetZeroGeometryMsgsPoint()
{
    static geometry_msgs::Point output;
    output.x = double{0.0};
    output.y = double{0.0};
    output.z = double{0.0};

    return output;
}

geometry_msgs::Accel GetZeroGeometryMsgsAccel()
{
    static geometry_msgs::Accel output;
    output.linear.x = double{0.0};
    output.linear.y = double{0.0};
    output.linear.z = double{0.0};
    output.angular.x = double{0.0};
    output.angular.y = double{0.0};
    output.angular.z = double{0.0};

    return output;
}

geometry_msgs::Quaternion GetIdentityGeometryMsgsQuaternion()
{
    static geometry_msgs::Quaternion output;
    output.w = math::Quaternion_t::Identity().w();
    output.x = math::Quaternion_t::Identity().x();
    output.y = math::Quaternion_t::Identity().y();
    output.z = math::Quaternion_t::Identity().z();

    return output;
}

geometry_msgs::Pose GetIdentityGeometryMsgsPose()
{
    static geometry_msgs::Pose output;
    output.orientation = utils::GetIdentityGeometryMsgsQuaternion();
    output.position = utils::GetZeroGeometryMsgsPoint();

    return output;
}

geometry_msgs::Polygon ComputeGeometryMsgsLocalCoordCubePolygon(
    const geometry_msgs::Pose &cubePoseMsg,
    const math::Vector3d_t &cubeSize,
    const tf::StampedTransform &baseLinkToWorldTransform)
{
    const math::real_t offsetX = math::real_t{0.5} * cubeSize.x();
    const math::real_t offsetY = math::real_t{0.5} * cubeSize.y();
    const math::real_t offsetZ = math::real_t{0.5} * cubeSize.z();

    const std::vector<math::real_t> vertexOffsetsX(
        {+offsetX, -offsetX, -offsetX, +offsetX, +offsetX, -offsetX, -offsetX, +offsetX});
    const std::vector<math::real_t> vertexOffsetsY(
        {+offsetY, +offsetY, -offsetY, -offsetY, +offsetY, +offsetY, -offsetY, -offsetY});
    const std::vector<math::real_t> vertexOffsetsZ(
        {+offsetZ, +offsetZ, +offsetZ, +offsetZ, -offsetZ, -offsetZ, -offsetZ, -offsetZ});

    geometry_msgs::Transform cubeTransformMsg;
    cubeTransformMsg.translation.x = cubePoseMsg.position.x;
    cubeTransformMsg.translation.y = cubePoseMsg.position.y;
    cubeTransformMsg.translation.z = cubePoseMsg.position.z;
    cubeTransformMsg.rotation = cubePoseMsg.orientation;

    tf::Transform cubeTransform;
    tf::transformMsgToTF(cubeTransformMsg, cubeTransform);
    geometry_msgs::Polygon cubePolygon;
    cubePolygon.points.resize(vertexOffsetsX.size());

    for (std::size_t idx{0u}; idx < vertexOffsetsX.size(); ++idx)
    {
        const tf::Point localVertex(
            vertexOffsetsX[idx],
            vertexOffsetsY[idx],
            vertexOffsetsZ[idx]);
        const tf::Point worldVertex = cubeTransform * localVertex;
        const tf::Point outputVertex = baseLinkToWorldTransform.inverse() * worldVertex;
        cubePolygon.points[idx] = utils::ConvertToGeometryMsgsPoint32(outputVertex);
    }

    return cubePolygon;
}

geometry_msgs::Polygon ComputeGeometryMsgsWorldCoordCubePolygon(
    const geometry_msgs::Pose &cubePoseMsg,
    const math::Vector3d_t &cubeSize)
{
    const math::real_t offsetX = math::real_t{0.5} * cubeSize.x();
    const math::real_t offsetY = math::real_t{0.5} * cubeSize.y();
    const math::real_t offsetZ = math::real_t{0.5} * cubeSize.z();

    const std::vector<math::real_t> cornerOffsetsX(
        {+offsetX, -offsetX, -offsetX, +offsetX, +offsetX, -offsetX, -offsetX, +offsetX});
    const std::vector<math::real_t> cornerOffsetsY(
        {+offsetY, +offsetY, -offsetY, -offsetY, +offsetY, +offsetY, -offsetY, -offsetY});
    const std::vector<math::real_t> cornerOffsetsZ(
        {+offsetZ, +offsetZ, +offsetZ, +offsetZ, -offsetZ, -offsetZ, -offsetZ, -offsetZ});

    geometry_msgs::Transform cubeTransformMsg;
    cubeTransformMsg.translation.x = cubePoseMsg.position.x;
    cubeTransformMsg.translation.y = cubePoseMsg.position.y;
    cubeTransformMsg.translation.z = cubePoseMsg.position.z;
    cubeTransformMsg.rotation = cubePoseMsg.orientation;

    tf::Transform cubeTransform;
    tf::transformMsgToTF(cubeTransformMsg, cubeTransform);
    geometry_msgs::Polygon cubePolygon;
    cubePolygon.points.resize(cornerOffsetsX.size());

    for (std::size_t idx{0ul}; idx < cornerOffsetsX.size(); ++idx)
    {
        const tf::Point localVertex(
            cornerOffsetsX[idx],
            cornerOffsetsY[idx],
            cornerOffsetsZ[idx]);
        const tf::Point worldVertex = cubeTransform * localVertex;
        cubePolygon.points[idx] = utils::ConvertToGeometryMsgsPoint32(worldVertex);
    }

    return cubePolygon;
}

geometry_msgs::Polygon ComputeGeometryMsgsLocalCoordPolygonalColumn(
    const std::vector<math::Vector3d_t> &worldCorners,
    const tf::StampedTransform &baseLinkToWorldTransform)
{
    geometry_msgs::Polygon localPolygon;
    localPolygon.points.resize(worldCorners.size());
    auto localPolygonCorner{localPolygon.points.begin()};
    auto worldCorner{worldCorners.cbegin()};
    for (; worldCorner != worldCorners.cend();
         ++worldCorner, ++localPolygonCorner)
    {
        const tf::Point localCorner =
            baseLinkToWorldTransform.inverse() *
            utils::ConvertToTfPoint(*worldCorner);
        *localPolygonCorner = utils::ConvertToGeometryMsgsPoint32(localCorner);
    }

    return localPolygon;
}

geometry_msgs::Polygon ComputeGeometryMsgsWorldCoordPoygonalColumn(
    const std::vector<math::Vector3d_t> &worldCorners)
{
    geometry_msgs::Polygon outputWorldPolygon;
    outputWorldPolygon.points.resize(worldCorners.size());
    std::transform(
        worldCorners.cbegin(),
        worldCorners.cend(),
        outputWorldPolygon.points.begin(),
        [](const math::Vector3d_t &worldCorner)
        {return utils::ConvertToGeometryMsgsPoint32(worldCorner);});

    return outputWorldPolygon;
}

geometry_msgs::Pose ComputeOffsetPose(
    const geometry_msgs::Pose &originalPose,
    const geometry_msgs::Vector3 &offset)
{
    geometry_msgs::Pose offsetPose;
    offsetPose.orientation = originalPose.orientation;
    offsetPose.position.x = originalPose.position.x + offset.x;
    offsetPose.position.y = originalPose.position.y + offset.y;
    offsetPose.position.z = originalPose.position.z + offset.z;

    return offsetPose;
}

double ComputeSquaredNorm(const geometry_msgs::Vector3 &vector3)
{
    return vector3.x * vector3.x + vector3.y * vector3.y + vector3.z * vector3.z;
}

double ComputeNorm(const geometry_msgs::Vector3 &vector3)
{
    return std::sqrt(
        utils::ComputeSquaredNorm(vector3));
}

geometry_msgs::Quaternion ComputeOrientationXy(const geometry_msgs::Vector3 &vector3)
{
    math::Quaternion_t quaternion{
        math::ComputeOrientationXy(
            utils::ConvertToVector3d(vector3))};

    return utils::ConvertToGeometryMsgsQuaternion(quaternion);
}

bool IsApprox(
    const geometry_msgs::Point32 &firstPoint,
    const geometry_msgs::Point32 &secondPoint,
    const double epsilon)
{
    if (std::fabs(firstPoint.x - secondPoint.x) >= epsilon)
    {
        return false;
    }

    if (std::fabs(firstPoint.y - secondPoint.y) >= epsilon)
    {
        return false;
    }

    if (std::fabs(firstPoint.z - secondPoint.z) >= epsilon)
    {
        return false;
    }

    return true;
}

bool IsApprox(
    const geometry_msgs::Point &firstPoint,
    const geometry_msgs::Point &secondPoint,
    const double epsilon)
{
    if (std::fabs(firstPoint.x - secondPoint.x) >= epsilon)
    {
        return false;
    }

    if (std::fabs(firstPoint.y - secondPoint.y) >= epsilon)
    {
        return false;
    }

    if (std::fabs(firstPoint.z - secondPoint.z) >= epsilon)
    {
        return false;
    }

    return true;
}

bool IsApprox(
    const geometry_msgs::Vector3 &firstVector,
    const geometry_msgs::Vector3 &secondVector,
    const double epsilon)
{
    if (std::fabs(firstVector.x - secondVector.x) >= epsilon)
    {
        return false;
    }

    if (std::fabs(firstVector.y - secondVector.y) >= epsilon)
    {
        return false;
    }

    if (std::fabs(firstVector.z - secondVector.z) >= epsilon)
    {
        return false;
    }

    return true;
}

bool IsApprox(
    const geometry_msgs::Quaternion &firstQuaternion,
    const geometry_msgs::Quaternion &secondQuaternion,
    const double epsilon)
{
    if (std::fabs(firstQuaternion.w - secondQuaternion.w) > epsilon)
    {
        return false;
    }

    if (std::fabs(firstQuaternion.x - secondQuaternion.x) > epsilon)
    {
        return false;
    }

    if (std::fabs(firstQuaternion.y - secondQuaternion.y) > epsilon)
    {
        return false;
    }

    if (std::fabs(firstQuaternion.z - secondQuaternion.z) > epsilon)
    {
        return false;
    }

    return true;
}

bool IsApprox(
    const geometry_msgs::Pose &firstPose,
    const geometry_msgs::Pose &secondPose,
    const double epsilon)
{
    if (!utils::IsApprox(firstPose.position, secondPose.position, epsilon))
    {
        return false;
    }

    if (!utils::IsApprox(firstPose.orientation, secondPose.orientation, epsilon))
    {
        return false;
    }

    return true;
}

template<typename CoordXyzType>
bool IsApproxZero(
    const CoordXyzType &input,
    const double epsilon)
{
    if (std::fabs(input.x) > epsilon)
    {
        return false;
    }

    if (std::fabs(input.y) > epsilon)
    {
        return false;
    }

    if (std::fabs(input.z) > epsilon)
    {
        return false;
    }

    return true;
}
template
bool IsApproxZero(const geometry_msgs::Vector3 &, const double);

} // namespace utils {
