#ifndef _MOTION_CONFIG_READER_H_
#define _MOTION_CONFIG_READER_H_

#include <functional>
#include <jsoncpp/json/json.h>

namespace motion {

template<typename MotionConfigType>
void ParseMotionConfigs(
    const Json::Value &configJsonValue,
    std::function<void (const Json::Value &, MotionConfigType *)> &parseFunc,
    std::vector<MotionConfigType> *outputConfigs);
template<typename MotionConfigType>
void ParseMotionConfigs(
    const Json::Value &configJsonValue,
    std::function<void (const Json::Value &, MotionConfigType &)> &parseFunc,
    std::vector<MotionConfigType> &outputConfigs);

} // namespace motion {

#endif // #ifndef _MOTION_CONFIG_READER_H_
