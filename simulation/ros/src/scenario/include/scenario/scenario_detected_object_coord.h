#ifndef _SCENARIO_DETECTED_OBJECT_COORDINATE_H_
#define _SCENARIO_DETECTED_OBJECT_COORDINATE_H_

#include <math_type.h>

namespace scenario {

struct DetectedObjectCoord final
{
    Coord pose;
    Coord velocity;

    DetectedObjectCoord()
        : pose{Coord::Null}
        , velocity{Coord::Null}
    {
    }
    DetectedObjectCoord(
        const Coord &inputPose,
        const Coord &inputVelocity)
        : pose{inputPose}
        , velocity{inputVelocity}
    {
    }
    DetectedObjectCoord(const DetectedObjectCoord &other) = default;
    DetectedObjectCoord &operator=(const DetectedObjectCoord &other) = default;
    ~DetectedObjectCoord() = default;
};

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const DetectedObjectCoord &coord)
{
    ostream << "[DetectedObjectCoord]" << '\n' <<
        "pose: " << coord.pose << '\n' <<
        "velocity: " << coord.velocity;
    return ostream;
}

} // namespace scenario {

#endif // #ifndef _SCENARIO_DETECTED_OBJECT_COORDINATE_H_
