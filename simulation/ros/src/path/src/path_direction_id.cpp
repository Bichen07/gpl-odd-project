#include <path_direction_id.h>
#include <cctype>
#include <algorithm>
#include <stdexcept>
#include <ros/console.h>

namespace path {

DirectionId ToDirectionId(const std::string &key)
{
    std::string lowercaseKey(key);
    std::transform(
        key.cbegin(),
        key.cend(),
        lowercaseKey.begin(),
        [](const char &input)
        {return std::tolower(input);});

    static const std::map<std::string, DirectionId> directionIdMap =
    {
        {ToDirectionLabel(Direction::Forward),  Direction::Forward},
        {ToDirectionLabel(Direction::Opposite), Direction::Opposite},
        {ToDirectionLabel(Direction::Null),     Direction::Null},
    };

    const auto foundPair{directionIdMap.find(lowercaseKey)};
    if (directionIdMap.end() == foundPair)
    {
        ROS_ERROR_STREAM(
            "invalid key: " << key << '\n' <<
            "return Direction::Null instead");
        return Direction::Null;
    }

    return foundPair->second;
}

std::string ToDirectionLabel(const DirectionId &directionId)
{
    static const std::map<DirectionId, const char *> directionLabelMap =
    {
        {Direction::Forward,  "forward"},
        {Direction::Opposite, "opposite"},
        {Direction::Null,     "null"},
    };

    const auto foundPair{directionLabelMap.find(directionId)};
    if (directionLabelMap.end() == foundPair)
    {
        ROS_ERROR_STREAM("invalid " << directionId);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return foundPair->second;
}

DirectionId EvaluateDirection(const int32_t isPositive)
{
    if (int32_t{0} != isPositive && int32_t{1} != isPositive)
    {
        ROS_ERROR_STREAM(
            "invalid isPositive: " << isPositive << '\n' <<
            "the value shall be 0 or 1");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return int32_t{0} == isPositive ? Direction::Opposite : Direction::Forward;
}

} // namespace path {
