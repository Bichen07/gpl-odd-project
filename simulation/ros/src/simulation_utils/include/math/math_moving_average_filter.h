#ifndef _MATH_MOVING_AVERAGE_FILTER_H_
#define _MATH_MOVING_AVERAGE_FILTER_H_

#include <math_type.h>
#include <deque>

namespace math {

template<typename ValueType>
class MovingAverageFilter final
{

public:

    MovingAverageFilter(const std::size_t bufferSize = 0ul);
    MovingAverageFilter(const MovingAverageFilter &other);
    MovingAverageFilter &operator=(const MovingAverageFilter &other);
    virtual ~MovingAverageFilter() = default;

    const std::deque<ValueType> &GetDeque() const;
    std::size_t GetBufferSize() const;
    std::size_t GetElementSize() const;
    void Configure(const std::size_t bufferSize);
    ValueType ComputeSum() const;
    ValueType ComputeAverage() const;
    void Push(const ValueType &input);

protected:

private:

    std::size_t mBufferSize;
    std::deque<ValueType> mDeque;
};

} // namespace math {

#endif // #ifndef _MATH_MOVING_AVERAGE_FILTER_H_
