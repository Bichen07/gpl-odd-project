#include <math_coord.h>
#include <algorithm>
#include <ros/console.h>

Coord_t ToCoord(const std::string &key)
{
    std::string lowercaseKey{key};
    std::transform(
        key.cbegin(),
        key.cend(),
        lowercaseKey.begin(),
        [](const char &input)
        {return std::tolower(input);});

    static const std::map<std::string, Coord_t> coordMap =
    {
        {ToCoordLabel(Coord::Local), Coord::Local},
        {ToCoordLabel(Coord::World), Coord::World},
        {ToCoordLabel(Coord::Null),  Coord::Null},
    };

    const auto foundPair{coordMap.find(lowercaseKey)};
    if (coordMap.end() == foundPair)
    {
        ROS_ERROR_STREAM(
            "invalid key: " << key << '\n' <<
            "return Coord::Null instead");
        return Coord::Null;
    }

    return foundPair->second;
}

std::string ToCoordLabel(const Coord_t &coord)
{
    static const std::map<Coord_t, std::string> coordLabelMap =
    {
        {Coord::Local, "local"},
        {Coord::World, "world"},
        {Coord::Null,  "null"},
    };

    const auto foundPair{coordLabelMap.find(coord)};
    if (coordLabelMap.end() == foundPair)
    {
        ROS_ERROR_STREAM("invalid" << coord);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return foundPair->second;
}
