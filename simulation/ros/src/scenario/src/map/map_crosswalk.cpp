#include "map_crosswalk.h"
#include <limits>
#include <ros/console.h>

namespace map {

// public func.

Crosswalk::Crosswalk()
    : mCorners{}
    , mConvexHull2d{}
    , mCentroid3d{}
    , mEdges{}
    , mVectorMatcher{}
{
}

Crosswalk::Crosswalk(const std::vector<math::Vector3d_t> &inputCorners)
    : mCorners{}
    , mConvexHull2d{}
    , mCentroid3d{}
    , mEdges{}
    , mVectorMatcher{}
{
    this->Configure(inputCorners);
}

Crosswalk::Crosswalk(const Crosswalk &other)
    : mCorners{}
    , mConvexHull2d{}
    , mCentroid3d{}
    , mEdges{}
    , mVectorMatcher{}
{
    this->Configure(other.GetCorners());
}

Crosswalk &Crosswalk::operator=(const Crosswalk &other)
{
    if (&other == this)
    {
        return *this;
    }

    this->Configure(other.GetCorners());

    return *this;
}

Crosswalk::~Crosswalk()
{
}

const std::vector<math::Vector3d_t> &Crosswalk::GetCorners() const
{
    return mCorners;
}

const math::Vector3d_t &Crosswalk::GetCentroid() const
{
    return mCentroid3d;
}

const std::vector<geometry::Edge3d> &Crosswalk::GetEdges() const
{
    return mEdges;
}

void Crosswalk::Configure(const std::vector<math::Vector3d_t> &inputCorners)
{
    if (inputCorners.empty())
    {
        return;
    }

    std::vector<math::Vector2d_t> inputCorners2d(inputCorners.size());
    std::transform(
        inputCorners.begin(),
        inputCorners.end(),
        inputCorners2d.begin(),
        [](const math::Vector3d_t &point_3d)
        {return math::Vector2d_t(point_3d.x(), point_3d.y());});
    mConvexHull2d.Compute(inputCorners2d);

    const auto polygonCorners{mConvexHull2d.GetCorners()};
    mCorners = mVectorMatcher.Compute(
        std::vector<math::Vector2d_t>(polygonCorners.begin(), polygonCorners.end() - 1),
        inputCorners);

    mCentroid3d = math::Vector3d_t(
        mConvexHull2d.GetCentroid().x(),
        mConvexHull2d.GetCentroid().y(),
        this->ComputerAverageHeight(mCorners));
    
    mEdges.resize(mCorners.size());
    auto corner{mCorners.begin() + 1};
    auto edge{mEdges.begin()};
    for (; corner != mCorners.end(); ++corner, ++edge)
    {
        *edge = geometry::Edge3d(*(corner - 1), *corner);
    }

    mEdges.back() = geometry::Edge3d(mCorners.back(), mCorners.front());
    std::stable_sort(
        mEdges.begin(),
        mEdges.end(),
        [](const geometry::Edge3d &first, const geometry::Edge3d &second)
        {return first.GetNorm() < second.GetNorm();});

    for (auto edge{mEdges.begin()}; edge != mEdges.end(); ++edge)
    {
        const int32_t idx = static_cast<int32_t>(std::distance(mEdges.begin(), edge));
    }
}

// protected func.

// private func.

math::real_t Crosswalk::ComputerAverageHeight(const std::vector<math::Vector3d_t> &vector3ds) const
{
    if (vector3ds.empty())
    {
        ROS_ERROR_STREAM("vector3ds is empty");
        return 0.0;
    }

    math::real_t accumulatedHeight{0.0};
    for (const auto &vector3d: vector3ds)
    {
        accumulatedHeight += vector3d.z();
    }

    return accumulatedHeight / static_cast<math::real_t>(vector3ds.size());
}

} // namespace map {
