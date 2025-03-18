#include <utils_json.h>
#include <string>
#include <iterator>
#include <fstream>
#include <stdexcept>
#include <ros/console.h>

namespace utils {

template<> int32_t GetJsonValue(
    const Json::Value &jsonValue,
    const std::string &fileName,
    const uint32_t lineNum)
{
    if (!jsonValue.isInt())
    {
        ROS_ERROR_STREAM("invalid int32_t json value at " << fileName << ": " << lineNum);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return jsonValue.asInt();
}

template<> float GetJsonValue(
    const Json::Value &jsonValue,
    const std::string &fileName,
    const uint32_t lineNum)
{
    if (!jsonValue.isDouble())
    {
        ROS_ERROR_STREAM("invalid float json value at " << fileName << ": " << lineNum);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return jsonValue.asFloat();
}

template<> double GetJsonValue(
    const Json::Value &jsonValue,
    const std::string &fileName,
    const uint32_t lineNum)
{
    if (!jsonValue.isDouble())
    {
        ROS_ERROR_STREAM("invalid double json value at " << fileName << ": " << lineNum);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return jsonValue.asDouble();
}

template<> std::string GetJsonValue(
    const Json::Value &jsonValue,
    const std::string &fileName,
    const uint32_t lineNum)
{
    if (!jsonValue.isString())
    {
        ROS_ERROR_STREAM("invalid string json value at " << fileName << ": " << lineNum);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return jsonValue.asString();
}

void ParseJsonValue(
    const std::string &fileName,
    Json::Value *outputJsonValue)
{
    if (nullptr == outputJsonValue)
    {
        ROS_ERROR_STREAM("outputJsonValue is nullptr");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    std::ifstream inputFileStream(
        fileName,
        std::ifstream::in);
    if (!inputFileStream.good())
    {
        ROS_ERROR_STREAM("input file stream is not good, file name: " << fileName);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    Json::Reader jsonReader;
    jsonReader.parse(inputFileStream, *outputJsonValue);
    inputFileStream.close();
}

bool IsMemberKey(
    const Json::Value &jsonValue,
    const char *key)
{
    return jsonValue.isMember(key);
}

void ConfirmMemberKey(
    const Json::Value &jsonValue,
    const char *key,
    const char *fileName,
    const uint32_t lineNum)
{
    if (!jsonValue.isMember(key))
    {
        ROS_ERROR_STREAM("invalid key: " << key << " at " << fileName << ": " << lineNum);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }
}

} // namespace utils {
