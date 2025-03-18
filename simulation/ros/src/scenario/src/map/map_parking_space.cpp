#include <map_parking_space.h>
#include <stdexcept>
#include <ros/console.h>
#include <utils_converter.h>
#include <geometry_utils.h>
#include <numeric>

namespace map {

// public func.

ParkingSpace::ParkingSpace()
    : mParkingLotId{0}
    , mSpaceId{0}
    , mLaneId{0}
    , mPointId{0}

    , mOrientationType{Orientation::Null}
    , mCorners{}
    , mTransform{}
{
}

ParkingSpace::ParkingSpace(
    const int32_t parkingLotId,
    const int32_t spaceId,
    const int32_t laneId,
    const int32_t pointId,
    const OrientationType &orientationType,
    const std::vector<math::Vector3d_t> &corners)
    : mParkingLotId{parkingLotId}
    , mSpaceId{spaceId}
    , mLaneId{laneId}
    , mPointId{pointId}

    , mOrientationType{orientationType}
    , mCorners{corners}
    , mTransform{}
{
    std::vector<math::Vector2d_t> closedCwCorner2ds;
    mTransform = this->ComputeTransform(
        mOrientationType,
        mCorners,
        &closedCwCorner2ds);

    mCorners = geometry::SortPoints(
        std::vector<math::Vector2d_t>(closedCwCorner2ds.cbegin(), closedCwCorner2ds.cend() - 1),
        mCorners);
}

ParkingSpace::ParkingSpace(const ParkingSpace &other)
    : mParkingLotId{other.GetParkingLotId()}
    , mSpaceId{other.GetSpaceId()}
    , mLaneId{other.GetLaneId()}
    , mPointId{other.GetPointId()}

    , mOrientationType{other.GetOrientationType()}
    , mCorners{other.GetCorners()}
    , mTransform{other.GetTransform()}
{
}

ParkingSpace &ParkingSpace::operator=(const ParkingSpace &other)
{
    if (&other == this)
    {
        return *this;
    }

    mParkingLotId = other.GetParkingLotId();
    mSpaceId = other.GetSpaceId();
    mLaneId = other.GetLaneId();
    mPointId = other.GetPointId();

    mOrientationType = other.GetOrientationType();
    mCorners = other.GetCorners();
    mTransform = other.GetTransform();

    return *this;
}

ParkingSpace::~ParkingSpace()
{
}

const int32_t ParkingSpace::GetParkingLotId() const
{
    return mParkingLotId;
}

const int32_t ParkingSpace::GetSpaceId() const
{
    return mSpaceId;
}

const int32_t ParkingSpace::GetLaneId() const
{
    return mLaneId;
}

const int32_t ParkingSpace::GetPointId() const
{
    return mPointId;
}

const ParkingSpace::OrientationType ParkingSpace::GetOrientationType() const
{
    return mOrientationType;
}

const std::vector<math::Vector3d_t> &ParkingSpace::GetCorners() const
{
    return mCorners;
}

const math::HomoXfm3d_t &ParkingSpace::GetTransform() const
{
    return mTransform;
}

// protected func.

// private func.

math::HomoXfm3d_t ParkingSpace::ComputeTransform(
    const OrientationType &orientationType,
    const std::vector<math::Vector3d_t> &corners,
    std::vector<math::Vector2d_t> *closedCwCorner2ds) const
{
    if (nullptr == closedCwCorner2ds)
    {
        ROS_ERROR_STREAM("closedCwCorner2ds is nullptr");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    const auto forwardVector{corners.at(1) - corners.at(0)};
    const math::real_t accumulatedPositionZ = std::accumulate(
        corners.cbegin(),
        corners.cend(),
        math::real_t{0.0},
        [](math::real_t accumulatedZ, const math::Vector3d_t &corner)
        {return accumulatedZ+ corner.z();});
    const math::real_t averagePositionZ =
        accumulatedPositionZ / static_cast<math::real_t>(corners.size());
    const math::real_t headingRadian = std::atan2(
        forwardVector.y(),
        forwardVector.x());
    const math::RotMat3d_t outputRotation = math::AngleAxis_t(
        headingRadian,
        math::Vector3d_t::UnitZ()).toRotationMatrix();

    const auto convexHull2d{geometry::ConvexHull2d(utils::ConvertToVector2ds(corners))};
    const math::Vector3d_t outputPosition(
        utils::ConvertToVector3d(convexHull2d.GetCentroid(), averagePositionZ));

    *closedCwCorner2ds = convexHull2d.GetCorners();

    return math::HomoXfm3d_t(outputRotation, outputPosition);
}

} // namespace map {
