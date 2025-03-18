#include <visilibity_edge.h>
#include <ros/console.h>
#include <math_utils.h>

namespace VisiLibity {

// public func.

Edge::Edge()
    : mBeginPosition{}
    , mEndPosition{}
    , mNorm{0.0}
    , mParametrizedLine{}
{
}

Edge::Edge(
    const math::Vector2d_t &beginPosition,
    const math::Vector2d_t &endPosition)
    : mBeginPosition{beginPosition}
    , mEndPosition{endPosition}
    , mNorm{(mEndPosition - mBeginPosition).norm()}
    , mParametrizedLine{math::ParametrizedLine2d_t::Through(mBeginPosition, mEndPosition)}
{
}

Edge::Edge(const Edge &other)
    : mBeginPosition{other.GetBeginPosition()}
    , mEndPosition{other.GetEndPosition()}
    , mNorm(other.GetNorm())
    , mParametrizedLine{math::ParametrizedLine2d_t::Through(mBeginPosition, mEndPosition)}
{
}

Edge &Edge::operator=(const Edge &other)
{
    if (&other == this)
    {
        return *this;
    }

    mBeginPosition = other.GetBeginPosition();
    mEndPosition = other.GetEndPosition();
    mNorm = other.GetNorm();
    mParametrizedLine = math::ParametrizedLine2d_t::Through(
        other.GetBeginPosition(),
        other.GetEndPosition());

    return *this;
}

Edge::~Edge()
{
}

const math::Vector2d_t &Edge::GetBeginPosition() const
{
    return mBeginPosition;
}

const math::Vector2d_t &Edge::GetEndPosition() const
{
    return mEndPosition;
}

const math::real_t Edge::GetNorm() const
{
    return mNorm;
}

const math::real_t Edge::ComputeDistance(const math::Vector2d_t &point) const
{
    return mParametrizedLine.distance(point);
}

const bool Edge::IsOnEdge(
    const math::Vector2d_t &point,
    const math::real_t distanceEpsilon) const
{
    const auto pointToEdgeDistance = mParametrizedLine.distance(point);
    if (!math::IsApproxZero(pointToEdgeDistance, distanceEpsilon))
    {
        return false;
    }

    if (math::IsApprox(point, mBeginPosition, distanceEpsilon))
    {
        //ROS_INFO_STREAM(
        //    "point & mBeginPosition are the same: " << point.transpose());
        return true;
    }

    if (math::IsApprox(point, mEndPosition, distanceEpsilon))
    {
        return false;
    }

    const auto testVector = point - mBeginPosition;
    const auto refVector = mEndPosition - mBeginPosition;

    const bool isOnEdge =
        refVector.dot(testVector) > 0.0 &&
        testVector.norm() < refVector.norm();
    //if (isOnEdge)
    //{
    //    ROS_INFO_STREAM(
    //        "point: " << point.transpose() << '\n' <<
    //        "testVector: " << testVector.transpose() << ", " <<
    //        "norm: " << testVector.norm() << '\n' <<
    //        "refVector: " << refVector.transpose() << ", " <<
    //        "norm: " << refVector.norm() << '\n' <<
    //        "dot: " << refVector.dot(testVector));
    //}

    return isOnEdge;
}

// protected func.

// private func.

} // namespace VisiLibity {
