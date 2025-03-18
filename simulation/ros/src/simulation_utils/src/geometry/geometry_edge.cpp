#include <geometry_edge.h>
#include <ros/console.h>
#include <math_utils.h>

namespace geometry {

// public func.

template<typename VectorType>
Edge<VectorType>::Edge()
    : mBeginPosition{}
    , mDirection{}
    , mNorm{0.0}
{
}

template<typename VectorType>
Edge<VectorType>::Edge(
    const VectorType &beginPosition,
    const VectorType &direction,
    const math::real_t norm)
    : mBeginPosition{beginPosition}
    , mDirection{direction}
    , mNorm(norm)
{
    if (!math::IsApprox(mDirection.norm(), 1.0, 1.0e-6))
    {
        ROS_ERROR_STREAM("mDirection isn't normalized, norm: " << mDirection.norm());
    }

    if (mNorm < 0.0)
    {
        ROS_ERROR_STREAM("invalid mNorm: " << mNorm);
    }
}

template<typename VectorType>
Edge<VectorType>::Edge(
    const VectorType &beginPosition,
    const VectorType &endPosition)
    : mBeginPosition{beginPosition}
    , mDirection{}
    , mNorm{}
{
    const VectorType beginToEndVector{endPosition - mBeginPosition};
    mDirection = beginToEndVector.normalized();
    mNorm = beginToEndVector.norm();
}

template<typename VectorType>
Edge<VectorType>::Edge(const Edge<VectorType> &other)
    : mBeginPosition(other.GetBeginPosition())
    , mDirection(other.GetDirection())
    , mNorm(other.GetNorm())
{
}

template<typename VectorType>
Edge<VectorType> &Edge<VectorType>::operator=(const Edge<VectorType> &other)
{
    if (&other == this)
    {
        return *this;
    }

    mBeginPosition = other.GetBeginPosition();
    mDirection = other.GetDirection();
    mNorm = other.GetNorm();

    return *this;
}

template<typename VectorType>
Edge<VectorType>::~Edge()
{
}

template<typename VectorType>
const VectorType &Edge<VectorType>::GetBeginPosition() const
{
    return mBeginPosition;
}

template<typename VectorType>
const VectorType &Edge<VectorType>::GetDirection() const
{
    return mDirection;
}

template<typename VectorType>
const math::real_t Edge<VectorType>::GetNorm() const
{
    return mNorm;
}

// protected func.

// private func.

// explicit instantiation

template class Edge<math::Vector2d_t>;
template class Edge<math::Vector3d_t>;

} // namespace geometry {
