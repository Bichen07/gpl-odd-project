#include <metric_min_bounding_envelope.h>
#include <fstream>
#include <stdexcept>
#include <ros/console.h>
#include <jsoncpp/json/json.h>

namespace metric {

// public func.

MinBoundingEnvelope::MinBoundingEnvelope()
    : mRealPath{}
    , mSimPath{}
{
}

const std::vector<math::Vector3d_t> &MinBoundingEnvelope::GetRealPath() const
{
    return mRealPath;
}

const std::vector<math::Vector3d_t> &MinBoundingEnvelope::GetSimPath() const
{
    return mSimPath;
}

void MinBoundingEnvelope::Configure(const std::string &fileName)
{
    std::ifstream fileStream;
    fileStream.open(fileName, std::ifstream::in);
    if (!fileStream.good())
    {
        ROS_ERROR_STREAM("fail to open " << fileName);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    Json::Reader jsonReader;
    Json::Value trajectoryJsonValue;
    jsonReader.parse(fileStream, trajectoryJsonValue);
    fileStream.close();

    mRealPath.reserve(trajectoryJsonValue["real"].size());
    for (const auto &realValue: trajectoryJsonValue["real"])
    {
        mRealPath.push_back(
            math::Vector3d_t(
                realValue[1].asDouble(),
                realValue[2].asDouble(),
                realValue[3].asDouble()));
    }

    mSimPath.reserve(trajectoryJsonValue["sim"].size());
    for (const auto &simValue: trajectoryJsonValue["sim"])
    {
        mSimPath.push_back(
            math::Vector3d_t(
                simValue[1].asDouble(),
                simValue[2].asDouble(),
                simValue[3].asDouble()));
    }

    ROS_DEBUG_STREAM_COND(
        false,
        "real path size: " << mRealPath.size() << '\n' <<
        "sim path size: " << mSimPath.size());
}

// protected func.

// private func.

} // namespace metric {
