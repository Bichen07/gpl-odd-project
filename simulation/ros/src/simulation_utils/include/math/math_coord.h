#ifndef _MATH_COORD_H_
#define _MATH_COORD_H_

#include <string>
#include <map>
#include <iostream>

typedef enum class Coord: int32_t
{
    Local = 0,
    World,
    Num,
    Null = Num,
} Coord_t;

Coord_t ToCoord(const std::string &key);
std::string ToCoordLabel(const Coord_t &coord);

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const Coord_t &coord)
{
    static const std::map<Coord_t, std::string> kCoordMap =
    {
        {Coord::Local, "Coord::Local"},
        {Coord::World, "Coord::World"},
        {Coord::Null,  "Coord::Null"},
    };

    ostream << kCoordMap.find(coord)->second;

    return ostream;
}

#endif // #ifndef _MATH_COORD_H_
