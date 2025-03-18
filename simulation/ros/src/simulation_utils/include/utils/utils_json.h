#ifndef UTILS_JSON_H_
#define UTILS_JSON_H_

#include <string>
#include <jsoncpp/json/json.h>

namespace utils {

#define GetIntJsonValue(jsonValue) \
    GetJsonValue<int32_t>(jsonValue, __FILE__, __LINE__)
#define GetFloatJsonValue(jsonValue) \
    GetJsonValue<float>(jsonValue, __FILE__, __LINE__)
#define GetDoubleJsonValue(jsonValue) \
    GetJsonValue<double>(jsonValue, __FILE__, __LINE__)
#define GetStringJsonValue(jsonValue) \
    GetJsonValue<std::string>(jsonValue, __FILE__, __LINE__)
#define VerifyMemberKey(jsonValue, key) \
    ConfirmMemberKey(jsonValue, key, __FILE__, __LINE__)

template<typename DataType>
DataType GetJsonValue(
    const Json::Value &jsonValue,
    const std::string &fileName,
    const uint32_t lineNum);
void ParseJsonValue(
    const std::string &fileName,
    Json::Value *outputJsonValue);
bool IsMemberKey(
    const Json::Value &jsonValue,
    const char *key);
void ConfirmMemberKey(
    const Json::Value &jsonValue,
    const char *key,
    const char *fileName,
    const uint32_t lineNum);

} // namespace utils {

#endif // #ifndef UTILS_JSON_H_
