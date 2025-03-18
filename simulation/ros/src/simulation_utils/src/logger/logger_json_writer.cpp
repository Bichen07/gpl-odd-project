#include <logger_json_writer.h>
#include <memory>
#include <fstream>
#include <ros/console.h>

namespace logger {

// public func.

JsonWriter::JsonWriter()
    : mOutputJsonValue{}
    , mFileName{}
{
}

JsonWriter::~JsonWriter()
{
}

void JsonWriter::ConfigureFileName(const std::string &fileName)
{
    mFileName = fileName;
}

void JsonWriter::Append(
    const std::string &id,
    const int32_t intValue)
{
    mOutputJsonValue[id] = intValue;
}

void JsonWriter::Append(
    const std::string &id,
    const double doubleValue)
{
    mOutputJsonValue[id] = doubleValue;
}

void JsonWriter::Append(
    const std::string &id,
    const math::Vector3d_t &vector3d)
{
    mOutputJsonValue[id] = this->GenerateVector3dValue(vector3d);
}

void JsonWriter::Append(
    const std::string &id,
    const std::vector<math::Vector3d_t> &vector3ds)
{
    Json::Value vectorArrayValue(Json::arrayValue);
    for (const auto &vector: vector3ds)
    {
        vectorArrayValue.append(
            this->GenerateVector3dValue(vector));
    }

    mOutputJsonValue[id] = vectorArrayValue;
}

void JsonWriter::Append(
    const std::string &id,
    const math::FrenetCoord &frenetCoord)
{
    mOutputJsonValue[id] = this->GenerateFrenetCoordValue(frenetCoord);
}

void JsonWriter::Append(
    const std::string &id,
    const std::vector<math::FrenetCoord> &frenetCoords)
{
    Json::Value frenetCoordArrayValue(Json::arrayValue);
    for (const auto &frenetCoord: frenetCoords)
    {
        frenetCoordArrayValue.append(
            this->GenerateFrenetCoordValue(frenetCoord));
    }

    mOutputJsonValue[id] = frenetCoordArrayValue;
}

void JsonWriter::Write()
{
    Json::StreamWriterBuilder builder;
    builder["commentStyle"] = "None";
    builder["indentation"] = "   ";

    std::unique_ptr<Json::StreamWriter> writer(builder.newStreamWriter());
    std::ofstream outputFileStream(mFileName);
    writer->write(mOutputJsonValue, &outputFileStream);

    ROS_INFO_STREAM("write to file: " << mFileName);
    outputFileStream.close();
}

// protected func.

// private func.

Json::Value JsonWriter::GenerateVector3dValue(const math::Vector3d_t &vector3d) const
{
    Json::Value output;
    output["x"] = vector3d.x();
    output["y"] = vector3d.y();
    output["z"] = vector3d.z();

    return output;
}

Json::Value JsonWriter::GenerateFrenetCoordValue(const math::FrenetCoord &frenetCoord) const
{
    Json::Value output;
    output["s"] = frenetCoord.s();
    output["d"] = frenetCoord.d();

    return output;
}

} // namespace logger {
