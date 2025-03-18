#include <map_stop_line.h>
#include <stdexcept>
#include <ros/console.h>

namespace map {

// public func.

StopLine::StopLine()
    : mCorner3ds{}
    , mCentroid3d{}
    , mConvexHull2d{}
    , mLanePointIdMap{}
    , mVectorMatcher{}
{
}

StopLine::StopLine(const std::vector<math::Vector3d_t> &inputCorner3ds)
    : mCorner3ds{}
    , mCentroid3d{}
    , mConvexHull2d{}
    , mLanePointIdMap{}
    , mVectorMatcher{}
{
    this->Configure(inputCorner3ds);
}

StopLine::StopLine(
    const std::vector<math::Vector3d_t> &inputCorner3ds,
    const std::map<int32_t, std::vector<int32_t>> &lanePointIdMap)
    : mCorner3ds{}
    , mCentroid3d{}
    , mConvexHull2d{}
    , mLanePointIdMap{}
    , mVectorMatcher{}
{
    this->Configure(inputCorner3ds, lanePointIdMap);
}

StopLine::StopLine(const StopLine &other)
    : mCorner3ds{}
    , mCentroid3d{}
    , mConvexHull2d{}
    , mLanePointIdMap{}
    , mVectorMatcher{}
{
    this->Configure(other.GetCorner3ds(), other.GetLanePointIdMap());
}

StopLine &StopLine::operator=(const StopLine &other)
{
    if (&other == this)
    {
        return *this;
    }

    this->Configure(other.GetCorner3ds(), other.GetLanePointIdMap());

    return *this;
}

StopLine::~StopLine()
{
}

const std::vector<math::Vector3d_t> &StopLine::GetCorner3ds() const
{
    return mCorner3ds;
}

const math::Vector3d_t &StopLine::GetCentroid3d() const
{
    return mCentroid3d;
}

const std::map<int32_t, std::vector<int32_t>> &StopLine::GetLanePointIdMap() const
{
    return mLanePointIdMap;
}

void StopLine::Configure(const std::vector<math::Vector3d_t> &inputCorner3ds)
{
    if (inputCorner3ds.empty())
    {
        return;
    }

    std::vector<math::Vector2d_t> inputCorner2ds(inputCorner3ds.size());
    std::transform(
        inputCorner3ds.begin(),
        inputCorner3ds.end(),
        inputCorner2ds.begin(),
        [](const math::Vector3d_t &corner3d)
        {return math::Vector2d_t(corner3d.x(), corner3d.y());});
    mConvexHull2d.Compute(inputCorner2ds);

    const auto convexHullCorners{mConvexHull2d.GetCorners()};
    mCorner3ds = mVectorMatcher.Compute(
        std::vector<math::Vector2d_t>(convexHullCorners.begin(), convexHullCorners.end() - 1),
        inputCorner3ds);

    math::real_t accumulatedCornerZ{0.0};
    for (const auto &corner3d: inputCorner3ds)
    {
        accumulatedCornerZ += corner3d.z();
    }

    const math::real_t centroidHeight =
        accumulatedCornerZ / static_cast<math::real_t>(inputCorner3ds.size());

    mCentroid3d = math::Vector3d_t(
        mConvexHull2d.GetCentroid().x(),
        mConvexHull2d.GetCentroid().y(),
        centroidHeight);
}

void StopLine::Configure(
    const std::vector<math::Vector3d_t> &inputCorner3ds,
    const std::map<int32_t, std::vector<int32_t>> &lanePointIdMap)
{
    this->Configure(inputCorner3ds);
    mLanePointIdMap = lanePointIdMap;
}

// protected func.

// private func.

} // namespace map {
