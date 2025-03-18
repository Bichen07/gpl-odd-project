#ifndef _GEOMETRY_EDGE_H_
#define _GEOMETRY_EDGE_H_

#include <math_type.h>

namespace geometry {

template<typename VectorType>
class Edge final
{

public:

    Edge();
    explicit Edge(
        const VectorType &beginPosition,
        const VectorType &direction,
        const math::real_t norm);
    explicit Edge(
        const VectorType &beginPosition,
        const VectorType &endPosition);
    Edge(const Edge &other);
    Edge &operator=(const Edge &other);
    virtual ~Edge();

    const VectorType &GetBeginPosition() const;
    const VectorType &GetDirection() const;
    const math::real_t GetNorm() const;

protected:

private:

    VectorType mBeginPosition;
    VectorType mDirection;
    math::real_t mNorm;
};

} // namespace geometry {

#endif // #ifndef _GEOMETRY_EDGE_H_
