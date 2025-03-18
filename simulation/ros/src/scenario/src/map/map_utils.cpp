#include <map_utils.h>
#include <ros/console.h>

namespace map {

DirectionId QueryDirectionId(const std::string &key)
{
    static const std::map<std::string, DirectionId> directionMap =
    {
        {"forward", Direction::Forward},
        {"Forward", Direction::Forward},
        {"reverse", Direction::Reverse},
        {"Reverse", Direction::Reverse},
    };

    const auto foundPair = directionMap.find(key);
    if (directionMap.end() == foundPair)
    {
        ROS_ERROR_STREAM("invalid key: " << key);
        return Direction::Null;
    }

    return foundPair->second;
}

} // namespace map {
