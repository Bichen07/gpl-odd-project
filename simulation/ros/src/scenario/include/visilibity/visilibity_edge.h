#ifndef _VISILIBITY_EDGE_H_
#define _VISILIBITY_EDGE_H_

#include <iostream>
#include <math_type.h>

namespace VisiLibity {

class Edge final
{
    static constexpr math::real_t DefaultEpsilon()
    {return math::real_t{1.0e-3};}

public:

    Edge();
    Edge(
        const math::Vector2d_t &beginPosition,
        const math::Vector2d_t &endPosition);
    Edge(const Edge &other);
    Edge &operator=(const Edge &other);
    virtual ~Edge();

    const math::Vector2d_t &GetBeginPosition() const;
    const math::Vector2d_t &GetEndPosition() const;
    const math::real_t GetNorm() const;

    const math::real_t ComputeDistance(const math::Vector2d_t &point) const;

    const bool IsOnEdge(
        const math::Vector2d_t &point,
        const math::real_t distanceEpsilon = DefaultEpsilon()) const;

protected:

private:

    math::Vector2d_t mBeginPosition;
    math::Vector2d_t mEndPosition;
    math::real_t mNorm;
    math::ParametrizedLine2d_t mParametrizedLine;
};

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const Edge &edge)
{
    ostream << "BeginPosition: " << edge.GetBeginPosition().transpose() << '\n' <<
        "EndPosition: " << edge.GetEndPosition().transpose() << '\n' <<
        "Norm: " << edge.GetNorm();
    return ostream;
}

} // namespace VisiLibity {

#endif // #ifndef _VISILIBITY_EDGE_H_
