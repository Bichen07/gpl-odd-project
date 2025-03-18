#include <math_stream_utils.h>
#include <fstream>
#include <stdexcept>
#include <ros/console.h>

namespace math {

math::Vector2d_t ParseVector2d(const Json::Value &value)
{
    return math::Vector2d_t(
        value["x"].asDouble(),
        value["y"].asDouble());
}

math::Vector3d_t ParseVector3d(const Json::Value &value)
{
    return math::Vector3d_t(
        value["x"].asDouble(),
        value["y"].asDouble(),
        value["z"].asDouble());
}

std::vector<math::Vector3d_t> ParseVector3ds(const Json::Value &values)
{
    //const std::size_t size{values.size()};
    std::vector<math::Vector3d_t> outputs(values.size());
    auto output{outputs.begin()};
    for (const auto &value: values)
    {
        *output = math::ParseVector3d(value);
        ++output;
    }

    return outputs;
}

math::FrenetCoord ParseFrenetCoord(const Json::Value &value)
{
    return math::FrenetCoord(
        value["s"].asDouble(),
        value["d"].asDouble());
}

std::vector<math::FrenetCoord> ParseFrenetCoords(const Json::Value &values)
{
    std::vector<math::FrenetCoord> outputs(values.size());
    auto output{outputs.begin()};
    for (const auto &value: values)
    {
        *output = math::ParseFrenetCoord(value);
        ++output;
    }

    return outputs;
}

} // namespace math {
