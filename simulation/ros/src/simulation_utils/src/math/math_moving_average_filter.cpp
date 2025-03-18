#include <math_moving_average_filter.h>
#include <stdexcept>
#include <ros/console.h>

namespace math {

// public func.

template<typename ValueType>
MovingAverageFilter<ValueType>::MovingAverageFilter(const std::size_t bufferSize)
    : mBufferSize{bufferSize}
    , mDeque{}
{
}

template<typename ValueType>
MovingAverageFilter<ValueType>::MovingAverageFilter(
    const MovingAverageFilter<ValueType> &other)
    : mBufferSize{other.GetBufferSize()}
    , mDeque{other.GetDeque()}
{
}

template<typename ValueType>
MovingAverageFilter<ValueType> &MovingAverageFilter<ValueType>::operator=(
    const MovingAverageFilter<ValueType> &other)
{
    if (this == &other)
    {
        return *this;
    }

    mBufferSize = other.GetBufferSize();
    mDeque = other.GetDeque();

    return *this;
}

template<typename ValueType>
const std::deque<ValueType> &MovingAverageFilter<ValueType>::GetDeque() const
{
    return mDeque;
}

template<typename ValueType>
std::size_t MovingAverageFilter<ValueType>::GetBufferSize() const
{
    return mBufferSize;
}

template<typename ValueType>
std::size_t MovingAverageFilter<ValueType>::GetElementSize() const
{
    return mDeque.size();
}

template<typename ValueType>
void MovingAverageFilter<ValueType>::Configure(const std::size_t bufferSize)
{
    mBufferSize = bufferSize;
}

template<typename ValueType>
ValueType MovingAverageFilter<ValueType>::ComputeSum() const
{
    if (mDeque.empty())
    {
        ROS_WARN_STREAM("the buffer is emtpy");
        return ValueType();
    }

    ValueType output{mDeque.front()};
    auto element{mDeque.cbegin() + 1};
    for (; element != mDeque.cend(); ++element)
    {
        output += *element;
    }

    return output;
}

template<typename ValueType>
ValueType MovingAverageFilter<ValueType>::ComputeAverage() const
{
    if (mDeque.empty())
    {
        ROS_WARN_STREAM("the buffer is empty");
        return ValueType();
    }

    return this->ComputeSum() / static_cast<double>(mDeque.size());
}

template<typename ValueType>
void MovingAverageFilter<ValueType>::Push(const ValueType &input)
{
    if (std::size_t{0ul} == mBufferSize)
    {
        ROS_ERROR_STREAM("buffer size is zero");
        throw std::logic_error(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    if (mDeque.size() > mBufferSize)
    {
        ROS_ERROR_STREAM(
            "invalid mDeque size: " << mDeque.size() << '\n' <<
            "given buffer size is " << mBufferSize);
        throw std::logic_error(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    if (mDeque.size() == mBufferSize)
    {
        mDeque.pop_front();
    }

    mDeque.push_back(input);
}

// protected func.

// private func.

// explicit instantiation

template class MovingAverageFilter<float>;
template class MovingAverageFilter<double>;
template class MovingAverageFilter<math::Vector2d_t>;
template class MovingAverageFilter<math::Vector3d_t>;
template class MovingAverageFilter<math::Vector6d_t>;

} // namespace math {
