#ifndef _PATH_INTERPOLATOR_ID_H_
#define _PATH_INTERPOLATOR_ID_H_

#include <map>
#include <string>
#include <iostream>

namespace path {

typedef enum class Interpolator: int32_t
{
    Linear,
    QuadraticBezier,
    Num,
    Null = Num,
} InterpolatorId;

InterpolatorId ToInterpolatorId(const std::string &key);
std::string ToInterpolatorLabel(const InterpolatorId &interpolatorId);

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const InterpolatorId &interpolatorId)
{
    static const std::map<InterpolatorId, const char *> interpolatorIdMap =
    {
        {Interpolator::Linear,          "Interpolator::Linear"},
        {Interpolator::QuadraticBezier, "Interpolator::QuadraticBezier"},
    };

    ostream << interpolatorIdMap.find(interpolatorId)->second;
    return ostream;
}

} // namespace path {

#endif // #ifndef _PATH_INTERPOLATOR_ID_H_
