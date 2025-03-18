#ifndef _MATH_FRENET_COORD_H_
#define _MATH_FRENET_COORD_H_

#include "math_type.h"

namespace math {

class FrenetCoord final
{

public:

    FrenetCoord();
    explicit FrenetCoord(const real_t coord_s, const real_t coord_d);
    FrenetCoord(const FrenetCoord &other) = default;
    FrenetCoord &operator=(const FrenetCoord &other) = default;
    virtual ~FrenetCoord();

    real_t s() const;
    real_t d() const;

    void set_s(const real_t coord_s);
    void set_d(const real_t coord_d);

protected:

private:

    real_t s_;
    real_t d_;
};

FrenetCoord operator+(const FrenetCoord &lhs, const FrenetCoord &rhs);
FrenetCoord operator-(const FrenetCoord &lhs, const FrenetCoord &rhs);

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
        std::basic_ostream<charT, traits> &ostream,
        const FrenetCoord &frenet_coord
        )
{
    ostream << frenet_coord.s() << ", " << frenet_coord.d();
    return ostream;
}

} // namespace math {

#endif // #ifndef _MATH_FRENET_COORD_H_
