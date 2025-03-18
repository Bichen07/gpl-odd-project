#include <sensor_lidar_detected_object.h>
#include <stdexcept>
#include <ros/console.h>
#include <utils_converter.h>

namespace sensor {

// public func.

LidarDetectedObject::LidarDetectedObject()
    : mConfig{}
    , mBoundingPolygonalColumn{}
    , mState{}
    , mSize{}
{
}

LidarDetectedObject::~LidarDetectedObject()
{
}

std::string LidarDetectedObject::GetId() const
{
    ROS_ERROR_STREAM("no implementation");
    throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    return std::string();
}

const geometry::PolygonalColumn &LidarDetectedObject::GetBoundingPolygonalColumn() const
{
    return mBoundingPolygonalColumn;
}

const motion::State &LidarDetectedObject::GetState() const
{
    return mState;
}

const math::Vector3d_t &LidarDetectedObject::GetSize() const
{
    return mSize;
}

const actor::ObjectClassId &LidarDetectedObject::GetObjectClassId() const
{
    return mConfig.objectClassId;
}

void LidarDetectedObject::Update(const LidarDetectedObjectConfig &config)
{
    mConfig = config;

    const math::real_t topPolygonCornerHeight =
        mConfig.agentState.position.z() +
        0.5 * mConfig.agentSize.z();
    const auto topPolygonCorners = utils::ConvertToVector3ds(
        mConfig.boundingConvexHull.GetCorners(),
        topPolygonCornerHeight);
    mBoundingPolygonalColumn.Configure(
        topPolygonCorners,
        mConfig.agentSize.z());

    mState.position = mBoundingPolygonalColumn.GetCentroid3d();
    mState.orientation = mConfig.agentState.orientation;
    mState.linearVelocity = mConfig.agentState.linearVelocity;
    mState.angularVelocity = mConfig.agentState.angularVelocity;

    mSize = this->ComputeSize(
        mConfig.agentTransform,
        mBoundingPolygonalColumn.GetTopPolygonCorners(),
        mConfig.agentSize.z());
}

// protected func.

// private func.

math::Vector3d_t LidarDetectedObject::ComputeSize(
    const math::HomoXfm3d_t &agentTransform3d,
    const std::vector<math::Vector3d_t> &worldTopPolygonCorners,
    const math::real_t agentSizeZ) const
{
    std::vector<math::real_t> localCoordXs(worldTopPolygonCorners.size());
    std::vector<math::real_t> localCoordYs(worldTopPolygonCorners.size());

    auto worldCorner{worldTopPolygonCorners.cbegin()};
    auto localCoordX{localCoordXs.begin()};
    auto localCoordY{localCoordYs.begin()};
    for (; worldCorner != worldTopPolygonCorners.cend();
         ++worldCorner, ++localCoordX, ++localCoordY)
    {
        const auto localCorner = agentTransform3d.inverse() * (*worldCorner);
        *localCoordX = localCorner.x();
        *localCoordY = localCorner.y();
    }

    std::sort(localCoordXs.begin(), localCoordXs.end());
    std::sort(localCoordYs.begin(), localCoordYs.end());

    const auto sizeX = localCoordXs.back() - localCoordXs.front();
    if (sizeX < 0.0)
    {
        ROS_ERROR_STREAM(
            "invalid sizeX: " << sizeX << '\n' <<
            "localCoordXs.back(): " << localCoordXs.back() <<
            ", localCoordXs.front(): " << localCoordXs.front());
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    const auto sizeY = localCoordYs.back() - localCoordYs.front();
    if (sizeY < 0.0)
    {
        ROS_ERROR_STREAM(
            "invalid sizeY: " << sizeY << '\n' <<
            "localCoordYs.back(): " << localCoordYs.back() <<
            ", localCoordYs.front(): " << localCoordYs.front());
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return math::Vector3d_t(sizeX, sizeY, agentSizeZ);
}

} // namespace sensor {
