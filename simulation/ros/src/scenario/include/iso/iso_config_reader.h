#ifndef _ISO_CONFIG_READER_H_
#define _ISO_CONFIG_READER_H_

#include <vector>
#include <string>
#include <jsoncpp/json/json.h>

namespace iso {

bool ParseAgentId(
    const Json::Value &configJsonValue,
    std::string *outputAgentId);
bool ParseAgentIds(
    const Json::Value &configJsonValue,
    std::vector<std::string> *outputAgentIds);

} // namespace iso {

#endif // #ifndef _ISO_CONFIG_READER_H_
