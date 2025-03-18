#include <path_interpolator_id.h>
#include <cctype>
#include <algorithm>
#include <stdexcept>
#include <ros/console.h>

namespace path {

InterpolatorId ToInterpolatorId(const std::string &key)
{
    std::string lowercaseKey(key);
    std::transform(
        key.cbegin(),
        key.cend(),
        lowercaseKey.begin(),
        [](const char input)
        {return std::tolower(input);});

    static const std::map<std::string, InterpolatorId> interpolatorIdMap =
    {
        {ToInterpolatorLabel(Interpolator::Linear),          Interpolator::Linear},
        {ToInterpolatorLabel(Interpolator::QuadraticBezier), Interpolator::QuadraticBezier},
        {ToInterpolatorLabel(Interpolator::Null),            Interpolator::Null},
    };

    const auto foundPair{interpolatorIdMap.find(lowercaseKey)};
    if (interpolatorIdMap.end() == foundPair)
    {
        ROS_ERROR_STREAM(
            "invalid key: " << key << '\n' <<
            "return Interpolator::Null instead");
        return Interpolator::Null;
    }

    return foundPair->second;
}

std::string ToInterpolatorLabel(const InterpolatorId &interpolatorId)
{
    static const std::map<InterpolatorId, const char *> interpolatorLabelMap =
    {
        {Interpolator::Linear,          "linear"},
        {Interpolator::QuadraticBezier, "quadratic_bezier"},
    };

    const auto foundPair{interpolatorLabelMap.find(interpolatorId)};
    if (interpolatorLabelMap.end() == foundPair)
    {
        ROS_ERROR_STREAM("invalid " << interpolatorId);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return foundPair->second;
}

} // namespace path {
